within TurbineGeneratorSSO.Examples;
model IEEE_SSR_FBM
  extends Modelica.Icons.Example;
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=500000, fn=60) "Must add this line in all models";

  Components.GenerationUnits.GenUnit_splitshaft genUnit(
    M_b=892400000,
    Tpd0=4.3,
    Tppd0=0.032,
    Tppq0=0.05,
    H=0.858670,
    D=0,
    Xd=1.79,
    Xq=1.71,
    Xpd=0.169,
    Xppd=0.135,
    Xppq=0.2,
    Xl=0.13,
    R_a=0,
    Xpq=0.228,
    Tpq0=0.05,
    Xpp=0.2,
    v_0=1,
    angle_0=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));
  OpenIPSL.Electrical.Buses.Bus bus(V_b=500000)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  OpenIPSL.Electrical.Buses.Bus bus2(V_b=500000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-28})));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(
    R=0.02,
    X=0.5,
    G=0,
    B=0)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,16})));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(R=0.0014,
    X=0.06,
    G=0,
    B=0)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-60})));
  OpenIPSL.Electrical.Branches.PSAT.TwoWindingTransformer
    twoWindingTransformer1(
    V_b=22000,
    Vn=500000,
    rT=0.0002,
    xT=0.14) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,60})));
  OpenIPSL.Electrical.Branches.PwLine pwLine2(
    R=0,
    X=-0.35,
    G=0,
    B=0)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-12})));
  OpenIPSL.Electrical.Machines.PSSE.GENCLS gENCLS(M_b=10000000000, H=1000000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-90})));
  OpenIPSL.Electrical.Events.PwFault pwFault(
    R=Modelica.Constants.small,
    X=0.01,
    t1=0.2,
    t2=0.5) annotation (Placement(transformation(extent={{42,24},{54,36}})));
equation
  connect(bus2.p, pwLine3.n) annotation (Line(points={{0,-28},{0,-51}},
                                                 color={0,0,255}));
  connect(pwLine1.n, bus.p)
    annotation (Line(points={{0,25},{0,30}},          color={0,0,255}));
  connect(genUnit.pwPin, twoWindingTransformer1.p)
    annotation (Line(points={{0,79},{0,76},{1.9984e-15,71}}, color={0,0,255}));
  connect(twoWindingTransformer1.n, bus.p) annotation (Line(points={{0,49},{0,
          30}},                                    color={0,0,255}));
  connect(pwLine2.p, bus2.p)
    annotation (Line(points={{0,-21},{0,-28}}, color={0,0,255}));
  connect(pwLine2.n, pwLine1.p)
    annotation (Line(points={{0,-3},{0,7}}, color={0,0,255}));
  connect(gENCLS.p, pwLine3.p)
    annotation (Line(points={{0,-80},{0,-69}}, color={0,0,255}));
  connect(pwFault.p, bus.p)
    annotation (Line(points={{41,30},{0,30}}, color={0,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=0.5,
      Interval=0.0004,
      __Dymola_Algorithm="Dassl"));
end IEEE_SSR_FBM;
