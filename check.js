// =============================================================
// check.js — the one balance band that IS the thesis:
// a player who DIAGNOSES the zero (hunter) must clearly beat a
// player who spreads effort evenly (spreader) and one who idles.
// Mirrors index.html's season math. Run: node check.js
// =============================================================
"use strict";

function makeCast(){ return [
  {tai:8,gan:1,ban:4},{tai:9,gan:3,ban:2},{tai:6,gan:4,ban:7},
  {tai:5,gan:6,ban:3},{tai:4,gan:7,ban:8},{tai:2,gan:8,ban:6}
].map(function(c){ return {tai:c.tai,gan:c.gan,ban:c.ban,btai:c.tai,bgan:c.gan,bban:c.ban,started:false}; }); }

function chance(p,von){ return Math.min(0.85,(p.tai*p.gan*p.ban)/1000*0.9*(0.6+0.4*von/10)); }

function lcg(seed){ var s=seed>>>0; return function(){ s=(1103515245*s+12345)>>>0; return s/4294967296; }; }

function run(strategy,seed){
  var rnd=lcg(seed), cast=makeCast(), luat=3, von=3;
  for(var season=0;season<16;season++){
    for(var a=0;a<3;a++){
      if(strategy==="hunter"){                    // find the lowest factor in the xóm, raise exactly it
        var best=null,bm=99;
        cast.forEach(function(c){ if(c.started)return; var m=Math.min(c.tai,c.gan,c.ban); if(m<bm){bm=m;best=c;} });
        if(best){ if(best.gan<=best.tai&&best.gan<=best.ban) best.gan=Math.min(10,best.gan+2);
          else if(best.tai<=best.ban) best.tai=Math.min(10,best.tai+2);
          else best.ban=Math.min(10,best.ban+2); }
      } else if(strategy==="spreader"){           // effort everywhere, no diagnosis
        var c2=cast[Math.floor(rnd()*6)], k=["tai","gan","ban"][Math.floor(rnd()*3)];
        if(!c2.started) c2[k]=Math.min(10,c2[k]+2);
      }                                           // idle: nothing
    }
    cast.forEach(function(p){
      if(p.started) return;
      if(rnd()<chance(p,von)){ p.started=true;
        cast.forEach(function(o){ if(o!==p) o.gan=Math.min(10,o.gan+1); }); }
    });
    if(luat<4) cast.forEach(function(p){ if(p.started&&rnd()<0.10){ p.started=false; p.gan=Math.max(0,p.gan-3); } });
    // entropy: un-bloomed tending decays back toward each person's nature (mirrors index.html)
    cast.forEach(function(p){ if(p.started) return;
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
