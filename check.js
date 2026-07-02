// =============================================================
// check.js — the one balance band that IS the thesis:
// a player who DIAGNOSES the zero (hunter) must clearly beat a
// player who spreads effort evenly (spreader) and one who idles.
// Mirrors index.html's season math. Run: node check.js
// =============================================================
"use strict";

function makeCast(){ return [
  {tai:8,gan:1,ban:4},{tai:9,gan:3,ban:2},{tai:6,gan:4,ban:7},
  {tai:5,gan:6,ban:3},{tai:4,gan:7,ban:8},{tai:2,gan:8,ban:6},
  {tai:9,gan:5,ban:1,arrives:6}                                    // Cô Liên — the returnee (leaves at 13 if unrooted)
].map(function(c){ return {tai:c.tai,gan:c.gan,ban:c.ban,btai:c.tai,bgan:c.gan,bban:c.ban,started:false,arrives:c.arrives,gone:false}; }); }
function activeSim(c,season){ return !c.gone && (c.arrives===undefined||season>=c.arrives); }

function chance(p,von){ return Math.min(0.85,(p.tai*p.gan*p.ban)/1000*0.9*(0.6+0.4*von/10)); }

function lcg(seed){ var s=seed>>>0; return function(){ s=(1103515245*s+12345)>>>0; return s/4294967296; }; }

function run(strategy,seed){
  var rnd=lcg(seed), cast=makeCast(), luat=3, von=3;
  for(var season=0;season<16;season++){
    var here=cast.filter(function(c){return activeSim(c,season);});
    for(var a=0;a<3;a++){
      function communal(target){                  // failure night lifts everyone crushed (mirrors index.html actNerve)
        cast.forEach(function(o){ if(o!==target&&activeSim(o,season)&&o.crushedOnce&&!o.started) o.gan=Math.min(10,o.gan+1); });
      }
      if(strategy==="hunter"){                    // find the lowest factor in the xóm, raise exactly it
        var best=null,bm=99;
        here.forEach(function(c){ if(c.started)return; var m=Math.min(c.tai,c.gan,c.ban); if(m<bm){bm=m;best=c;} });
        if(best){ if(best.gan<=best.tai&&best.gan<=best.ban){ best.gan=Math.min(10,best.gan+2); communal(best); }
          else if(best.tai<=best.ban) best.tai=Math.min(10,best.tai+2);
          else best.ban=Math.min(10,best.ban+2); }
      } else if(strategy==="spreader"){           // effort everywhere, no diagnosis
        var c2=here[Math.floor(rnd()*here.length)], k=["tai","gan","ban"][Math.floor(rnd()*3)];
        if(c2&&!c2.started){ c2[k]=Math.min(10,c2[k]+2); if(k==="gan") communal(c2); }
      }                                           // idle: nothing
    }
    cast.forEach(function(p){
      if(p.started||!activeSim(p,season)) return;
      if(rnd()<chance(p,von)){ p.started=true; p.age=0;
        cast.forEach(function(o){ if(o!==p) o.gan=Math.min(10,o.gan+1); }); }
    });
    // the returnee leaves if unrooted (mirrors index.html: season>=13, ban<4, not bloomed)
    if(season>=13) cast.forEach(function(c){ if(c.arrives!==undefined&&!c.started&&c.ban<4) c.gone=true; });
    // age-based stamp risk (mirrors index.html): young workshops 15%, established 5%, only under a heavy sky
    if(luat<4) cast.forEach(function(p){ if(p.started&&rnd()<(((p.age|0)<2)?0.15:0.05)){ p.started=false; p.crushedOnce=true; p.gan=Math.max(0,p.gan-3); } });
    // the recycling flywheel: enough standing workshops and the river feeds itself (mirrors index.html)
    if(cast.filter(function(c){return c.started;}).length>=3) von=Math.min(10,von+1);
    cast.forEach(function(p){ if(p.started) p.age=(p.age|0)+1; });
    // entropy: un-bloomed tending decays back toward each person's nature (mirrors index.html)
    cast.forEach(function(p){ if(p.started||!activeSim(p,season)) return;
      ["tai","gan","ban"].forEach(function(k){ if(p[k]>p["b"+k] && rnd()<0.35) p[k]--; }); });
    var r=rnd(); if(r<0.12) luat=Math.min(10,luat+1); else if(r<0.20) luat=Math.max(1,luat-1);
    if(season%4===3) von=Math.min(10,von+1);
  }
  return cast.filter(function(p){return p.started;}).length;
}

var N=1200, sums={hunter:0,spreader:0,idle:0};
["hunter","spreader","idle"].forEach(function(st){
  for(var i=0;i<N;i++) sums[st]+=run(st,1009+i*53);
  sums[st]/=N;
});
console.log("standing workshops after 16 seasons (avg of "+N+" runs):");
console.log("  hunter   (diagnose the zero) : "+sums.hunter.toFixed(2));
console.log("  spreader (effort everywhere) : "+sums.spreader.toFixed(2));
console.log("  idle     (do nothing)        : "+sums.idle.toFixed(2));

var ok = sums.hunter > sums.spreader + 0.7 && sums.hunter > sums.idle + 1.8 && sums.spreader > sums.idle;
console.log(ok ? "\n✅ BAND HOLDS: diagnosis > spreading > idling — the multiplication teaches itself."
               : "\n❌ BAND BROKEN: diagnosis does not clearly beat spreading — the thesis is not felt. Fix the numbers.");
process.exit(ok?0:1);
