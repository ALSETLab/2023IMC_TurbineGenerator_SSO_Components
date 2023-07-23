within TurbineGeneratorSSO.Examples;
model IEEE_SSR_SBM
  extends Modelica.Icons.Example;
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=100000000, fn=60) "Must add this line in all models";

  Components.GenerationUnits.GenUnit genUnit(
    M_b=600000000,
    Tpd0=4.5,
    Tppd0=0.04,
    Tppq0=0.09,
    H=4,
    D=0,
    Xd=1.65,
    Xq=1.59,
    Xpd=0.25,
    Xppd=0.2,
    Xppq=0.2,
    Xl=0.14,
    R_a=0.0045,
    Xpq=0.46,
    Tpq0=0.55,
    Xpp=0.2,
    v_0=1,
    angle_0=0)                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));
  OpenIPSL.Electrical.Buses.InfiniteBus infiniteBus annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-90})));
  OpenIPSL.Electrical.Buses.Bus bus(V_b=500000)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,46})));
  OpenIPSL.Electrical.Buses.Bus bus1(V_b=500000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,10})));
  OpenIPSL.Electrical.Buses.Bus bus2(V_b=500000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-28})));
  OpenIPSL.Electrical.Branches.PwLine pwLine(R=0.0067, X=0.0739,
    G=0,
    B=0)                                     annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,8})));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(R=0.0074, X=0.08,
    G=0,
    B=0)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,30})));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(R=0.0014, X=0.03,
    G=0,
    B=0)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  OpenIPSL.Electrical.Branches.PSAT.TwoWindingTransformer
    twoWindingTransformer1(
    V_b=22000,
    Vn=500000,
    rT=0.0002,
    xT=0.02) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,62})));
  OpenIPSL.Electrical.Branches.PwLine pwLine2(
    R=0,
    X=0.55*(pwLine1.X),
    G=0,
    B=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-10})));
equation
  connect(bus2.p, pwLine3.n) annotation (Line(points={{0,-28},{0,-34.5},{
          5.55112e-16,-34.5},{5.55112e-16,-41}}, color={0,0,255}));
  connect(pwLine.n, bus.p)
    annotation (Line(points={{-40,17},{-40,46},{0,46}},color={0,0,255}));
  connect(pwLine1.n, bus.p)
    annotation (Line(points={{40,39},{40,46},{0,46}}, color={0,0,255}));
  connect(pwLine1.p, bus1.p)
    annotation (Line(points={{40,21},{40,10}}, color={0,0,255}));
  connect(bus2.p, pwLine.p)
    annotation (Line(points={{0,-28},{-40,-28},{-40,-1}}, color={0,0,255}));
  connect(pwLine3.p, infiniteBus.p) annotation (Line(points={{-5.55112e-16,-59},
          {-5.55112e-16,-69.5},{5.55112e-16,-69.5},{5.55112e-16,-80}}, color={0,
          0,255}));
  connect(genUnit.pwPin, twoWindingTransformer1.p) annotation (Line(points={{-1.9984e-15,
          79},{-1.9984e-15,76},{1.9984e-15,76},{1.9984e-15,73}}, color={0,0,255}));
  connect(twoWindingTransformer1.n, bus.p) annotation (Line(points={{-1.9984e-15,
          51},{-1.9984e-15,48.5},{0,48.5},{0,46}}, color={0,0,255}));
  connect(pwLine2.p, bus2.p)
    annotation (Line(points={{40,-19},{40,-28},{0,-28}}, color={0,0,255}));
  connect(pwLine2.n, bus1.p)
    annotation (Line(points={{40,-1},{40,10}}, color={0,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5,
      Interval=0.0004,
      __Dymola_Algorithm="Dassl"));
end IEEE_SSR_SBM;
