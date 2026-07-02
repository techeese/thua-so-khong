// =============================================================
// check.js — the one balance band that IS the thesis:
// a player who DIAGNOSES the zero (hunter) must clearly beat a
// player who spreads effort evenly (spreader) and one who idles.
// Mirrors index.html's season math. Run: node check.js
// =============================================================
"use strict";

function makeCast(rnd){ return [
  {tai:8,gan:1,ban:4},{tai:9,gan:3,ban:2},{tai:6,gan:4,ban:7},
  {tai:5,gan:6,ban:3},{tai:4,gan:7,ban:8},{tai:2,gan:8,ban:6},
  {tai:9,gan:5,ban:1,arrives:0}                                    // Cô Liên — arrival rolled per run below
].map(function(c,idx){
  var o={tai:c.tai,gan:c.gan,ban:c.ban,started:false,gone:false};
  // year variants (mirrors index.html fresh()): jitter non-zero stats ±1, authored zero stays true
  var m=Math.min(o.tai,o.gan,o.ban), zk=(m===o.gan)?"gan":(m===o.tai)?"tai":"ban";
  ["tai","gan","ban"].forEach(function(k){ if(k===zk||o[k]<=1) return;
    o[k]=Math.max(1,Math.min(10,o[k]+(rnd()<0.5?-1:1))); });
  o.btai=o.tai; o.bgan=o.gan; o.bban=o.ban;
  if(idx===6) o.arrives=5+Math.floor(rnd()*4);
  return o; }); }
function activeSim(c,season){ return !c.gone && (c.arrives===undefined||season>=c.arrives); }

function chance(p,von){ return Math.min(0.85,(p.tai*p.gan*p.ban)/1000*0.9*(0.6+0.4*von/10)+(p.mom||0)); }

function lcg(seed){ var s=seed>>>0; return function(){ s=(1103515245*s+12345)>>>0; return s/4294967296; }; }

function run(strategy,seed){
  var rnd=lcg(seed), cast=makeCast(rnd), pairsSet={};
  var luat=2+Math.floor(rnd()*3), von=2+Math.floor(rnd()*3), baStart=7+Math.floor(rnd()*3), stormStreak=0;
  for(var season=0;season<16;season++){
    var here=cast.filter(function(c){return activeSim(c,season);});
    if(luat<4){ stormStreak++; } else { stormStreak=0; }
    var actsN=(season>0&&luat<4&&stormStreak<=2)?2:3;   // storm tax + adaptation (mirrors index.html)
    for(var a=0;a<actsN;a++){
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
      } else if(strategy==="linker"){             // spam Kết nối on the two lowest-BẠN people (first friend +2, later +1 — mirrors index.html)
        var un=here.filter(function(c){return !c.started;}).sort(function(a,b){return a.ban-b.ban;});
        if(un.length>=2){ var A=un[0],B=un[1];
          var gA2=(A.links|0)===0?2:1, gB2=(B.links|0)===0?2:1;
          var ky=cast.indexOf(A)+"-"+cast.indexOf(B);
          if(pairsSet[ky]){ gA2=1; gB2=1; } else { pairsSet[ky]=true; A.links=(A.links|0)+1; B.links=(B.links|0)+1; }
          A.ban=Math.min(10,A.ban+gA2); B.ban=Math.min(10,B.ban+gB2); }
      }                                           // idle: nothing
    }
    cast.forEach(function(p){
      if(p.started||!activeSim(p,season)) return;
      if(rnd()<chance(p,von)){ p.started=true; p.age=0; p.born=true; p.mom=0;
        // inspiration reaches only people you've met — active strategies know everyone, idle knows no one
        if(strategy!=="idle") cast.forEach(function(o){ if(o!==p) o.gan=Math.min(10,o.gan+1); }); }
      else if(p.tai*p.gan*p.ban>=100){ p.mom=Math.min(0.09,(p.mom||0)+0.03); }
    });
    // the returnee leaves if unrooted (mirrors index.html: season>=13, ban<4, not bloomed)
    if(season>=13) cast.forEach(function(c){ if(c.arrives!==undefined&&!c.started&&c.ban<4) c.gone=true; });
    // age-based stamp risk (mirrors index.html): young workshops 15%, established 5%, only under a heavy sky
    // tier-based stamps (mirrors index.html): established workshops step down (owner gan−2), only tier-1 is erased
    if(luat<4) cast.forEach(function(p){ if(p.started&&!p.born&&rnd()<(((p.age|0)<2)?0.15:0.05)){
      var prodv=p.tai*p.gan*p.ban;
      if(prodv>=300){ p.gan=Math.max(0,p.gan-2); p.mom=0; }
      else { p.started=false; p.crushedOnce=true; p.gan=Math.max(0,p.gan-3); p.mom=0; } } });
    // the recycling flywheel now counts TIERS (mirrors index.html): sum(tier)>=4 → the river feeds itself
    var tsum=cast.reduce(function(a,c){ if(!c.started) return a;
      var pv=c.tai*c.gan*c.ban; return a+(pv<300?1:pv<600?2:3); },0);
    if(tsum>=4) von=Math.min(10,von+1);
    cast.forEach(function(p){ if(p.started){ p.age=(p.age|0)+1; p.born=false; } });
    // the elder's clock (mirrors index.html; the sim has no apprenticeship, so blooming him is the only save)
    if(season+1>=baStart){ var ba=cast[1]; if(!ba.started&&!ba.gone&&ba.tai>0) ba.tai=Math.max(0,ba.tai-1); }
    // entropy: un-bloomed tending decays back toward each person's nature (mirrors index.html)
    cast.forEach(function(p){ if(p.started||!activeSim(p,season)) return;
      ["tai","gan","ban"].forEach(function(k){ if(p[k]>p["b"+k] && rnd()<0.35) p[k]--; }); });
    var r=rnd();
    if(luat<4){ if(r<0.25) luat=luat+1; else if(r<0.33) luat=Math.max(1,luat-1); }
    else { if(r<0.12) luat=Math.min(10,luat+1); else if(r<0.20) luat=Math.max(1,luat-1); }
    if(season%4===3) von=Math.min(10,von+1);
  }
  var tsum=cast.reduce(function(a,c){ if(!c.started) return a;
    var pv=c.tai*c.gan*c.ban; return a+(pv<300?1:pv<600?2:3); },0);
  return {n:cast.filter(function(p){return p.started;}).length, ts:tsum};
}

var N=1200, sums={hunter:0,spreader:0,linker:0,idle:0}, tiers={hunter:0,spreader:0,linker:0,idle:0};
["hunter","spreader","linker","idle"].forEach(function(st){
  for(var i=0;i<N;i++){ var r2=run(st,1009+i*53); sums[st]+=r2.n; tiers[st]+=r2.ts; }
  sums[st]/=N; tiers[st]/=N;
});
console.log("standing workshops after 16 seasons (avg of "+N+" runs):");
console.log("  hunter   (diagnose the zero) : "+sums.hunter.toFixed(2));
console.log("  spreader (effort everywhere) : "+sums.spreader.toFixed(2));
console.log("  linker   (spam Kết nối)      : "+sums.linker.toFixed(2));
console.log("  idle     (do nothing)        : "+sums.idle.toFixed(2));
console.log("tiers: hunter "+tiers.hunter.toFixed(1)+" · spreader "+tiers.spreader.toFixed(1)+" · linker "+tiers.linker.toFixed(1)+" · idle "+tiers.idle.toFixed(1));

// linker margin note: the sim's linker SORTS by lowest BẠN — a one-dimension hunter, semi-diagnostic by
// construction — so the bar is "strictly inferior with a modest margin" (+0.3), not the blind-strategy +0.5.
// The actual exploit (repeat +2/+2 pair-farming) is dead by design: repeats give +1/+1, first-friend-only +2.
var ok = sums.hunter > sums.spreader + 0.5 && sums.hunter > sums.linker + 0.3 && sums.hunter > sums.idle + 1.5
      && sums.spreader > sums.idle
      && sums.idle <= 4.0                        // difficulty ceiling: doing nothing must NOT earn a thriving xóm
      && tiers.hunter > tiers.spreader + 3;      // rooted depth, not just bloom count, separates diagnosis
console.log(ok ? "\n✅ BAND HOLDS: diagnosis beats spreading, link-spam, and idling — the multiplication teaches itself."
               : "\n❌ BAND BROKEN: a non-diagnostic strategy rivals the hunter — the thesis is not felt. Fix the numbers.");
process.exit(ok?0:1);
