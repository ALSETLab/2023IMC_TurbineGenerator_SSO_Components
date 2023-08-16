within TurbineGeneratorSSO.Components.GenerationUnits;
model GenUnit_GENDCO  "Multidomain Turbine-Generator Unit with Torsional Shaft Model and GENDCO"
  inner OpenIPSL.Electrical.SystemBase SysData( S_b = 960000000, fn = 30);
  Machines.GENDCO                generator(
    V_b=400000,
    P_0=40000000,
    Q_0=5416582,
    v_0=1,
    angle_0=0.070492225331847,
    M_b=M_b,
    Tpd0=Tpd0,
    Tppd0=Tppd0,
    Tppq0=Tppq0,
    H=0.869,
    D=D,
    Xd=Xd,
    Xq=Xq,
    Xpd=Xpd,
    Xppd=Xppd,
    Xppq=Xppq,
    Xl=Xl,
    S10=S10,
    S12=S12,
    R_a=R_a,
    pole_no=2,
    Xpq=Xpq,
    Tpq0=Tpq0,
    Xpp=Xpp) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  OpenIPSL.Interfaces.PwPin pwPin
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Gain gain(k=generator.M_b)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Shafts.Shaft_Scalable_v2_heqk shaft(
    N=4,
    H={0.176,1.427,1.428,1.428},
    K={17.78,27.66,31.31,37.25})
    annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=generator.SPEED_MECH)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  parameter OpenIPSL.Types.ApparentPower M_b=100000000 "Machine base power";
  parameter OpenIPSL.Types.Time Tpd0=5
    "d-axis transient open-circuit time constant";
  parameter OpenIPSL.Types.Time Tppd0=0.5E-01
    "d-axis sub-transient open-circuit time constant";
  parameter OpenIPSL.Types.Time Tppq0=0.1
    "q-axis sub-transient open-circuit time constant";
  parameter OpenIPSL.Types.Time H=0.869 "Inertia constant";
  parameter Real D=0 "Speed damping";
  parameter OpenIPSL.Types.PerUnit Xd=1.41 "d-axis reactance";
  parameter OpenIPSL.Types.PerUnit Xq=1.35 "q-axis reactance";
  parameter OpenIPSL.Types.PerUnit Xpd=0.3 "d-axis transient reactance";
  parameter OpenIPSL.Types.PerUnit Xppd=0.2 "d-axis sub-transient reactance";
  parameter OpenIPSL.Types.PerUnit Xppq=0.2 "q-axis sub-transient reactance";
  parameter OpenIPSL.Types.PerUnit Xl=0.12 "leakage reactance";
  parameter OpenIPSL.Types.PerUnit S10=0.1 "Saturation factor at 1.0 pu";
  parameter OpenIPSL.Types.PerUnit S12=0.5 "Saturation factor at 1.2 pu";
  parameter OpenIPSL.Types.PerUnit R_a=0 "Armature resistance";
  parameter OpenIPSL.Types.PerUnit Xpq=0.6 "q-axis transient reactance ";
  parameter OpenIPSL.Types.Time Tpq0=0.7
    "q-axis transient open-circuit time constant";
  parameter OpenIPSL.Types.PerUnit Xpp=0.2 "Sub-transient reactance ";
  parameter OpenIPSL.Types.PerUnit v_0=1 "Initial voltage magnitude";
  parameter OpenIPSL.Types.Angle angle_0=0.07068583470577
    "Initial voltage angle";
equation
  connect(generator.p, pwPin)
    annotation (Line(points={{80,0},{110,0}}, color={0,0,255}));
  connect(division.y, torque.tau)
    annotation (Line(points={{-19,0},{-12,0}}, color={0,0,127}));
  connect(gain.y, division.u1) annotation (Line(points={{-59,20},{-48,20},{-48,
          6},{-42,6}}, color={0,0,127}));
  connect(realExpression.y, division.u2) annotation (Line(points={{-59,-20},{
          -48,-20},{-48,-6},{-42,-6}}, color={0,0,127}));
  connect(generator.PMECH0, gain.u) annotation (Line(points={{81,5},{86,5},{86,
          36},{-88,36},{-88,20},{-82,20}}, color={0,0,127}));
  connect(generator.EFD0, generator.EFD) annotation (Line(points={{81,-5},{86,
          -5},{86,-14},{52,-14},{52,-6},{58,-6}}, color={0,0,127}));
  connect(torque.flange, shaft.flange_a)
    annotation (Line(points={{10,0},{23.6,0}}, color={0,0,0}));
  connect(shaft.flange_b, generator.torque)
    annotation (Line(points={{44.4,0},{60,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.05,
      __Dymola_Algorithm="Dassl"));
end GenUnit_GENDCO;
