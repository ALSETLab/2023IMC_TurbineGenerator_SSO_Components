within TurbineGeneratorSSO.Components.GenerationUnits;
model GenUnit_noShaft
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=960000000, fn=30);
  Machines.GENROU_multidomain generator(
    P_0=39999950,
    Q_0=5416571,
    v_0=1,
    angle_0=0.07068583470577,
    M_b=100000000,
    Tpd0=5,
    Tppd0=0.5E-01,
    Tppq0=0.1,
    H=4.0,
    D=0,
    Xd=1.41,
    Xq=1.35,
    Xpd=0.3,
    Xppd=0.2,
    Xppq=0.2,
    Xl=0.12,
    S10=0.1,
    S12=0.5,
    pole_no=2,
    Xpq=0.6,
    Tpq0=0.7,
    Xpp=0.2) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
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
    T_7=9999) annotation (Placement(transformation(extent={{80,20},{60,40}})));
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
  Modelica.Blocks.Sources.RealExpression realExpression(y=generator.SPEED_MECH)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
equation
  connect(generator.p, pwPin)
    annotation (Line(points={{80,0},{110,0}}, color={0,0,255}));
  connect(division.y, torque.tau)
    annotation (Line(points={{-19,0},{-12,0}}, color={0,0,127}));
  connect(gain.y, division.u1) annotation (Line(points={{-59,20},{-48,20},{-48,
          6},{-42,6}}, color={0,0,127}));
  connect(realExpression.y, division.u2) annotation (Line(points={{-59,-20},{
          -48,-20},{-48,-6},{-42,-6}}, color={0,0,127}));
  connect(governor.PMECH_HP, gain.u) annotation (Line(points={{59,34},{-88,34},
          {-88,20},{-82,20}}, color={0,0,127}));
  connect(generator.SPEED, governor.SPEED_HP)
    annotation (Line(points={{81,7},{86,7},{86,30},{78,30}}, color={0,0,127}));
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
  connect(torque.flange, generator.flange_b)
    annotation (Line(points={{10,0},{60,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.05,
      __Dymola_Algorithm="Dassl"));
end GenUnit_noShaft;
