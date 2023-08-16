within TurbineGeneratorSSO.Examples;
model SMIB_SSR_FBM "Modified implementation of IEEE First Benchmark Model to assess GENDCO turbine-generator unit."
  extends Modelica.Icons.Example;
  OpenIPSL.Electrical.Branches.PwLine pwLine(
    R=0,
    X=0.14,
    G=0,
    B=0) annotation (Placement(transformation(extent={{-20,-4},{-8,4}})));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(
    R=0.02,
    X=0.5,
    G=0,
    B=0) annotation (Placement(transformation(extent={{14,-4},{26,4}})));
  OpenIPSL.Electrical.Branches.PwLine pwLine4(
    R=0,
    X=-0.35,
    G=0,
    B=0) annotation (Placement(transformation(extent={{34,-4},{46,4}})));
  OpenIPSL.Electrical.Machines.PSSE.GENCLS gENCLS(
    M_b=100e6,
    D=0,
    angle_0=0,
    X_d=0.2,
    H=0,
    P_0=10017110,
    Q_0=8006544,
    v_0=1) annotation (Placement(transformation(extent={{100,-10},{90,10}})));
  OpenIPSL.Electrical.Loads.PSSE.Load_variation constantLoad(
    PQBRAK=0.7,
    d_t=0,
    d_P=0,
    angle_0=-0.5762684,
    t1=0,
    characteristic=2,
    P_0=50000000,
    Q_0=10000000,
    v_0=0.9919935) annotation (Placement(transformation(extent={{-10,-72},{10,-52}})));
  OpenIPSL.Electrical.Events.PwFault pwFault(
    t1=2,
    t2=2.15,
    R=Modelica.Constants.eps,
    X=Modelica.Constants.eps)
         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-30})));
  OpenIPSL.Electrical.Buses.Bus GEN1
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=100000000, fn=60)
    annotation (Placement(transformation(extent={{-100,80},{-60,100}})));
  OpenIPSL.Electrical.Buses.Bus LOAD(v_0=constantLoad.v_0, angle_0=constantLoad.angle_0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  OpenIPSL.Electrical.Buses.Bus GEN2
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  OpenIPSL.Electrical.Buses.Bus FAULT
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Components.GenerationUnits.GenUnit_GENDCO_splitshaft
                                     generatorUnit(
    M_b=892400000,
    Tpd0=4.3,
    Tppd0=0.032,
    Tppq0=0.05,
    H=0.868495,
    D=0,
    Xd=1.79,
    Xq=1.71,
    Xpd=0.169,
    Xppd=0.135,
    Xppq=0.2,
    Xl=0.13,
    S10=0.11,
    S12=0.39,
    R_a=0,
    Xpq=0.228,
    Tpq0=0.85,
    Xpp=0.2,
    angle_0=0.070492225331847)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(GEN1.p, pwLine.p)
    annotation (Line(points={{-30,0},{-19.4,0}}, color={0,0,255}));
  connect(pwLine.n, LOAD.p)
    annotation (Line(points={{-8.6,0},{0,0}}, color={0,0,255}));
  connect(pwLine3.p, LOAD.p) annotation (Line(points={{14.6,0},{0,0}},
                 color={0,0,255}));
  connect(constantLoad.p, LOAD.p)
    annotation (Line(points={{0,-52},{0,0}}, color={0,0,255}));
  connect(GEN2.p, gENCLS.p)
    annotation (Line(points={{80,0},{90,0}}, color={0,0,255}));
  connect(pwLine4.n, GEN2.p) annotation (Line(points={{45.4,0},{80,0}},
                   color={0,0,255}));
  connect(generatorUnit.pwPin, GEN1.p)
    annotation (Line(points={{-59,0},{-30,0}}, color={0,0,255}));
  connect(FAULT.p, pwLine4.n)
    annotation (Line(points={{60,0},{45.4,0}}, color={0,0,255}));
  connect(pwLine3.n, pwLine4.p)
    annotation (Line(points={{25.4,0},{34.6,0}}, color={0,0,255}));
  connect(pwFault.p, FAULT.p)
    annotation (Line(points={{60,-18.3333},{60,0}}, color={0,0,255}));
  annotation (experiment(
      StopTime=30,
      Interval=0.0004,
      __Dymola_Algorithm="Rkfix4"));
end SMIB_SSR_FBM;
