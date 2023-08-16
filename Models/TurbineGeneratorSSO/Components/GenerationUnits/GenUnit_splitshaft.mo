within TurbineGeneratorSSO.Components.GenerationUnits;
model GenUnit_splitshaft
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=100000, fn=60);
  OpenIPSL.Types.Voltage Vb = 22000 "base voltage";
  Machines.GENROU_multidomain_2flange
                                 generator(
    V_b=22000,
    P_0=39999950,
    Q_0=5416571,
    v_0=1,
    angle_0=0.07068583470577,
    M_b=M_b,
    Tpd0=Tpd0,
    Tppd0=Tppd0,
    Tppq0=Tppq0,
    H=H,
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
  OpenIPSL.Electrical.Controls.PSSE.TG.IEEEG1 governor(
    P0=0.4,
    K=20,
    T_1=0.15,
    T_3=0.2,
    T_4=0.25,
    K_1=0.25,
    T_5=7.5,
    K_3=0.25,
    T_6=0.4,
    K_5=0.5,
    T_7=9999) annotation (Placement(transformation(extent={{80,40},{60,60}})));
  OpenIPSL.Electrical.Controls.PSSE.ES.IEEET1 exciter(
    T_R=0.06,
    K_A=200,
    T_A=0.001,
    V_RMAX=2,
    V_RMIN=-2,
    K_E=0.1,
    T_E=0.55,
    K_F=0.06,
    E_1=2.85,
    S_EE_1=0.3,
    E_2=3.8,
    S_EE_2=0.6)
    annotation (Placement(transformation(extent={{78,-40},{58,-20}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{100,-58},{90,-48}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Shafts.Shaft_Scalable_v2_heqk shaft_rhs(H={0.092897,0.155589,0.858670,
        0.884215}, K={19.303,34.929,52.038,70.858})
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
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
  Shafts.Shaft_Scalable_v2_heqk shaft_lhs(
    N=1,
    H={0.0342165},
    K={2.82}) annotation (Placement(transformation(extent={{20,20},{40,40}})));
equation
  connect(generator.p, pwPin)
    annotation (Line(points={{80,0},{110,0}}, color={0,0,255}));
  connect(division.y, torque.tau)
    annotation (Line(points={{-19,0},{-12,0}}, color={0,0,127}));
  connect(gain.y, division.u1) annotation (Line(points={{-59,20},{-48,20},{-48,
          6},{-42,6}}, color={0,0,127}));
  connect(realExpression.y, division.u2) annotation (Line(points={{-59,-20},{
          -48,-20},{-48,-6},{-42,-6}}, color={0,0,127}));
  connect(governor.PMECH_HP, gain.u) annotation (Line(points={{59,54},{-92,54},
          {-92,20},{-82,20}}, color={0,0,127}));
  connect(generator.SPEED, governor.SPEED_HP)
    annotation (Line(points={{81,7},{86,7},{86,50},{78,50}}, color={0,0,127}));
  connect(generator.EFD, exciter.EFD) annotation (Line(points={{58,-6},{52,-6},
          {52,-30},{57,-30}}, color={0,0,127}));
  connect(exciter.VOEL, const.y)
    annotation (Line(points={{68,-41},{68,-53},{89.5,-53}}, color={0,0,127}));
  connect(exciter.VUEL, const.y)
    annotation (Line(points={{72,-41},{72,-53},{89.5,-53}}, color={0,0,127}));
  connect(exciter.VOTHSG, const.y) annotation (Line(points={{79,-26},{88,-26},{
          88,-53},{89.5,-53}}, color={0,0,127}));
  connect(generator.XADIFD, exciter.XADIFD) annotation (Line(points={{81,-9},{
          90,-9},{90,-46},{60,-46},{60,-41}}, color={0,0,127}));
  connect(generator.ETERM, exciter.ECOMP) annotation (Line(points={{81,-3},{86,
          -3},{86,-30},{79,-30}}, color={0,0,127}));
  connect(generator.EFD0, exciter.EFD0) annotation (Line(points={{81,-5},{84,-5},
          {84,-34},{79,-34}}, color={0,0,127}));
  connect(torque.flange, shaft_rhs.flange_a)
    annotation (Line(points={{10,0},{19.6,0}}, color={0,0,0}));
  connect(shaft_rhs.flange_b, generator.flange_b)
    annotation (Line(points={{40.4,0},{60,0}}, color={0,0,0}));
  connect(shaft_lhs.flange_b, generator.flange_a)
    annotation (Line(points={{40.4,30},{54,30},{54,6},{60,6}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.05,
      __Dymola_Algorithm="Dassl"));
end GenUnit_splitshaft;
