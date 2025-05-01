-- particle effects
-- by atzlochtlan

function _init()
    prt={} --basic
    smk={} --smoke
    flm={} --flames
    str={} --stars
    rgn={} --raining
    bbl={} --bubbles
    mgc={} --magical
    vcm={} --vacuum
    rct={} --rocket
    gys={} --geyser
    snw={} --snow
    trn={} --triangle
    whr={} --whirl
    atm={} --atoms
    frw={} --fireworks
    wht={} --suprise
    typ=0
    --palchng()
    --t=flr(time()*3)%2
end

-->8
-- particles

------------------1

function prtdraw(prt)
    for p in all(prt) do
        circfill(p.x,p.y,p.rad,p.clr)
    end
end

function prtmake()
        if btnp(🅾️) then
            for i=1,30 do
                add(prt,{x=64,y=64,
                    dx=rnd(2)-1,dy=rnd(2)-1,
                    rad=rnd(2),act=30,clr=7})
            end
        end
   
    for p in all(prt) do
        p.x+=p.dx*2
        p.y+=p.dy*2
        p.act-=1
        if p.act<0 then
            del(prt,p)
        end
    end
end

------------------2

function smkmake()
        if btnp(🅾️) then
            for i=1,20 do
                add(smk,{x=64,y=64,
                    dx=rnd(2)-1,dy=rnd(2)-1,
                    rad=5,act=60,
                    clr=rnd({5,6,7,13})})
            end
        end
   
    for p in all(smk) do
        p.x+=p.dx*0.5
        p.y+=p.dy*0.5
        p.act-=1
        if p.act<45 then p.rad=4 end
        if p.act<30 then p.rad=3 end
        if p.act<15 then p.rad=2 end
        if p.act<5 then p.rad=1 end
        if p.act<0 then
            del(smk,p)
        end
    end
end

------------------3

function flmmake()
        if btn(🅾️) then
            for i=1,15 do
                add(flm,{x=54+rnd(20),
                    y=80+rnd(10),
                    dx=rnd(2)-1,dy=rnd(2)+1,
                    rad=rnd(2)+1,act=20,
                    clr=7})
            end
        end
   
    for p in all(flm) do
        p.y-=p.dy
        p.act-=1
        if p.act<16 then p.clr=10 end
        if p.act<12 then p.clr=9 end
        if p.act<8 then p.clr=8 end
        if p.act<0 then
            del(flm,p)
        end
    end
end

------------------4

function strmake()
        if btnp(🅾️) then
            for i=1,40 do
                add(str,{x=rnd(128+64),
                    y=rnd(128),
                    dx=rnd(2)+1,dy=rnd(2)-1,
                    rad=0,act=60,
                    clr=7})
            end
        end
   
    for p in all(str) do
        p.x-=p.dx
        p.act-=1
        if p.act<0 then
            del(str,p)
        end
    end
end

------------------5

function rgnmake()
        if btn(🅾️) then
            for i=1,2 do
                add(rgn,{x=54+rnd(20),y=8,
                    dx=rnd(3)/10,dy=rnd(4)+3,
                    rad=0,act=60,
                    clr=12})
            end
        end
   
    for p in all(rgn) do
        p.y+=p.dy
        p.x+=p.dx
        if p.y>116 then p.act=-1 end
        if p.act<0 then
            del(rgn,p)
        end
    end
end

------------------6

function bblmake()
        if btnp(🅾️) then
            for i=1,10 do
                add(bbl,{x=64,y=80,
                    dx=rnd(2)-1,dy=rnd(2)+1,
                    rad=3,act=rnd(10)+40,clr=12})
            end
        end
   
    for p in all(bbl) do
        p.y+=p.dy*-1
        p.x+=p.dx
        p.act-=1
        if p.act<0 then
            del(bbl,p)
        end
    end
end

function bbldraw()
    for p in all(bbl) do
        circ(p.x,p.y,p.rad,p.clr)
        circfill(p.x-2,p.y-2,0,7)
    end
end

------------------7

function mgcmake()
        if btnp(🅾️) then
            for i=1,20 do
                add(mgc,{x=64,y=64,
                    dx=rnd(2)-1,dy=rnd(2)-1,
                    rad=3,act=rnd(10)+40,
                    clr=rnd({3,10,11}),
                    shp=rnd({"◆","★","✽"})})
            end
        end
   
    for p in all(mgc) do
        p.y+=p.dy*0.5
        p.x+=p.dx*2
        p.act-=1
        if p.act<0 then
            del(mgc,p)
        end
    end
end

function mgcdraw()
    for p in all(mgc) do
        print(p.shp,p.x,p.y,p.clr)
    end
end

------------------8

function vcmmake()
        if btnp(🅾️) then
            for i=1,100 do
                add(vcm,{x=rnd(88)+20,
                    y=rnd(88)+20,dx=1,dy=1,
                    rad=0,act=30,
                    clr=rnd({2,7,14})})
            end
        end
   
    for p in all(vcm) do
        if p.x<64 then p.x+=p.dx*2 end
        if p.x>64 then p.x-=p.dx*2 end
        if p.y<64 then p.y+=p.dy*2 end
        if p.y>64 then p.y-=p.dy*2 end
        if p.x==64 or p.y==64 then p.act=-1 end
        p.act-=1
        if p.act<0 then
            del(vcm,p)
        end
    end
end

-->8
-- particles 2

------------------9

function rctmake()
        if btnp(🅾️) then
            for i=1,50 do
                add(rct,{x=54+rnd(20),
                    y=20+rnd(10),dx=1,
                    dy=rnd(2)+1,rad=rnd(2),
                    act=30,
                    clr=1})
            end
        end
   
    for p in all(rct) do
        p.y+=p.dy*1.5
        if p.act<25 then p.clr=12 end
        if p.act<20 then p.clr=13 end
        if p.act<15 then p.clr=7 end
       
            if p.y>40 and p.x<56 then p.act=-1 end
            if p.y>60 and p.x<58 then p.act=-1 end
            if p.y>80 and p.x<60 then p.act=-1 end
            if p.y>40 and p.x>71 then p.act=-1 end
            if p.y>60 and p.x>69 then p.act=-1 end
            if p.y>80 and p.x>66 then p.act=-1 end
       
        if p.y>110 then p.act=-1 end
        p.act-=1
        if p.act<0 then
            del(rct,p)
        end
    end
end

------------------10

function gysmake()
        if btn(🅾️) then
            for i=1,30 do
                add(gys,{x=60+rnd(8),
                    y=100+rnd(10),dx=rnd(2)-1,
                    dy=rnd(3)+1,rad=rnd(2),
                    act=20,clr=13})
            end
        end
   
    for p in all(gys) do
        p.y+=p.dy*-1.5
        p.x+=p.dx*0.5
        if p.y<60 then p.x+=p.dx end
        if p.y<40 then p.x+=p.dx*2 end
       
        if p.act<10 then p.clr=6 end
        if p.act<5 then p.clr=7 end
        if p.y<20 then p.act=-1 end
        p.act-=1
        if p.act<0 then
            del(gys,p)
        end
    end
end

------------------11

function snwmake()
        if btnp(🅾️) then
            for i=1,5 do
                add(snw,{x=rnd(48)+40,
                    y=20+rnd(10),dx=0,
                    dy=rnd(2)+1,rad=1,
                    act=30,clr=7,ang=0})
            end
        end
       
    for p in all(snw) do
        p.x+=sin(p.ang)*1.5
  p.ang+=0.03
        p.y+=p.dy
       
        if p.act<5 then p.rad=0 end
        if p.y>110 then p.act=-1 end
        p.act-=1
        if p.act<0 then
            del(snw,p)
        end
    end
end

------------------12

function trnmake()
        if btnp(🅾️) then
            for i=1,1 do
                add(trn,{x1=rnd(48)+40,y1=rnd(48)+40,
                    x2=rnd(48)+40,y2=rnd(48)+40,
                    x3=rnd(48)+40,y3=rnd(48)+40,
                   
                    dx1=rnd(2)-1,dy1=rnd(2)-1,
                    dx2=rnd(2)-1,dy2=rnd(2)-1,
                    dx3=rnd(2)-1,dy3=rnd(2)-1,
                   
                    act=100,clr=rnd(16)})
            end
        end
       
    for p in all(trn) do
        p.x1+=p.dx1 p.y1+=p.dy1
        p.x2+=p.dx2 p.y2+=p.dy2
        p.x3+=p.dx3 p.y3+=p.dy3
       
        p.act-=1
        if p.act<0 then
            del(trn,p)
        end
    end
end

function trndraw()
    for p in all(trn) do
        line(p.x1,p.y1,p.x2,p.y2,p.clr)
        line(p.x2,p.y2,p.x3,p.y3,p.clr)
        line(p.x3,p.y3,p.x1,p.y1,p.clr)
    end
end

------------------13

function whrmake()
        if btnp(🅾️) then
            for i=1,10 do
                add(whr,{x=rnd(58)+40,
                    y=rnd(58)+40,dx=rnd(2)-1,
                    dy=rnd(2)-1,rad=rnd(3),act=100,
                    clr=rnd{4,9,15},xang=0,yang=0})
            end
        end
       
    for p in all(whr) do
        p.x+=sin(p.xang)*1.5
  p.xang+=0.03
  p.y+=sin(p.yang)*1.5
  p.yang+=0.03
       
        p.act-=1
        if p.act<0 then
            del(whr,p)
        end
    end
end

------------------14

function atmmake()
        if btnp(🅾️) then
            for i=1,10 do
                add(atm,{x,y,
                    ox=rnd(58)+40,rds=rnd(10)+10,
                    oy=rnd(58)+40,rad=1,act=80,
                    clr=6,ang=0,spd=rnd(5)+5})
            end
        end
       
    for p in all(atm) do
        p.ang+=p.spd
     if (p.ang>360) then p.ang=0 end
     p.x=p.ox+p.rds*cos(p.ang/360)
     p.y=p.oy+p.rds*sin(p.ang/360)
       
        if p.act<5 then p.rad=0 end
        p.act-=1
        if p.act<0 then
            del(atm,p)
        end
    end
end

------------------15

function frwmake()
        if btnp(🅾️) then
            for i=1,60 do
                add(frw,{x=64,y=48,
                    rad=0,dx=rnd(2)-1,dy=rnd(2)-1,
                    act=50,clr=10,grv=0.02})
            end
        end
       
    for p in all(frw) do
        p.x+=p.dx
        p.y+=p.dy
        p.dy+=p.grv
       
        if p.act<40 then p.clr=9 end
        if p.act<30 then p.clr=8 end
        if p.act<20 then p.clr=2 end
        p.act-=1
        if p.act<0 then
            del(frw,p)
        end
    end
end

------------------16

function whtmake()
        if btnp(🅾️) then
            for i=1,10 do
                add(wht,{x=rnd(48)+40,y=110,
                    rad=0,dx=0,dy=rnd(2)+1,
                    act=60,clr=8,ang=0})
            end
        end
       
    for p in all(wht) do
        p.x+=sin(p.ang)*1.5
  p.ang+=0.05
        p.y+=p.dy*-0.8
        if p.clr>14 then p.clr=8 end
        p.clr+=1
        p.act-=1
        if p.act<0 then
            del(wht,p)
        end
    end
end

function whtdraw()
    for p in all(wht) do
        print("?",p.x,p.y,p.clr)
    end
end
-->8
-- controls

function typcont()
    if btnp(➡️) then
        typ+=1
    elseif btnp(⬅️) then
        typ-=1
    end
   
    if typ<0 then typ=16 end
    if typ>16 then typ=0 end
end

function cent(s)
  return 64-#s*2
end

function palchng()
    pal({[0]=128,129,130,131,132,
    133,134,135,136,137,138,139,
    140,141,142,143},1)
end