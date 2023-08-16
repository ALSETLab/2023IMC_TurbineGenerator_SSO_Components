within TurbineGeneratorSSO.BaseModels.Machines;
partial model baseMachineMultidomain  "Base model for multidomain machines to accept a shaft torque input"
  import Complex;
  import Modelica.ComplexMath.arg;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import 'abs' =
         Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.conj;
  import Modelica.Blocks.Interfaces.*;
  extends OpenIPSL.Electrical.Essentials.pfComponent(
    final enabledisplayPF=false,
    final enablefn=false,
    final enableV_b=false,
    final enableangle_0=true,
    final enablev_0=true,
    final enableQ_0=true,
    final enableP_0=true,
    final enableS_b=true);
  //Machine parameters
  parameter
    OpenIPSL.Types.ApparentPower M_b
    "Machine base power" annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.Time Tpd0
    "d-axis transient open-circuit time constant"
    annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.Time Tppd0
    "d-axis sub-transient open-circuit time constant"
    annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.Time Tppq0
    "q-axis sub-transient open-circuit time constant"
    annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.Time H
    "Inertia constant" annotation (Dialog(group="Machine parameters"));
  parameter Real D "Speed damping"
    annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit Xd
    "d-axis reactance" annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit Xq
    "q-axis reactance" annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit Xpd
    "d-axis transient reactance" annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit Xppd
    "d-axis sub-transient reactance"
    annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit Xppq
    "q-axis sub-transient reactance"
    annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit Xl
    "leakage reactance" annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit S10
    "Saturation factor at 1.0 pu"
    annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit S12
    "Saturation factor at 1.2 pu"
    annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit R_a=0
    "Armature resistance" annotation (Dialog(group="Machine parameters"));
  parameter OpenIPSL.Types.PerUnit w0(min=-1 +
        Modelica.Constants.eps)=0 "Initial speed deviation from nominal"
    annotation (Dialog(group="Initialization"));
  OpenIPSL.Interfaces.PwPin p(
    vr(start=vr0),
    vi(start=vi0),
    ir(start=ir0),
    ii(start=ii0))
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  RealOutput SPEED "Machine speed deviation from nominal [pu]"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  RealOutput PMECH0 "Initial value of machine electrical power (machine base)"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  RealOutput ETERM(start=v_0) "Machine terminal voltage [pu]"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  RealInput EFD "Generator main field voltage [pu]"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(extent={{-140,-80},{-100,-40}})));
  RealOutput EFD0 "Initial generator main field voltage [pu]"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  RealOutput PELEC(start=p0) "Machine electrical power (machine base)"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  RealOutput ISORCE "Machine source current [pu]"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  RealOutput ANGLE "Machine relative rotor angle"
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  RealOutput XADIFD "Machine field current [pu]" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={110,-90}), iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={110,-90})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b torque
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  OpenIPSL.Types.PerUnit w(start=w0,
      fixed=true) "Machine speed deviation";
  OpenIPSL.Types.Angle delta
    "Rotor angle";
  OpenIPSL.Types.PerUnit Vt(start=v_0)
    "Bus voltage magnitude";
  OpenIPSL.Types.Angle anglev(start=
        angle_0) "Bus voltage angle";
  OpenIPSL.Types.PerUnit I(start=
        sqrt(ir0^2 + ii0^2)) "Terminal current magnitude";
  OpenIPSL.Types.Angle anglei(start=
        atan2(ii0, ir0)) "Terminal current angle";
  OpenIPSL.Types.PerUnit P(start=P_0
        /S_b) "Active power (system base)";
  OpenIPSL.Types.PerUnit Q(start=Q_0
        /S_b) "Reactive power (system base)";
  OpenIPSL.Types.PerUnit Te
    "Electrical torque [pu]";
  OpenIPSL.Types.PerUnit id
    "d-axis armature current [pu]";
  OpenIPSL.Types.PerUnit iq
    "q-axis armature current [pu]";
  OpenIPSL.Types.PerUnit ud
    "d-axis terminal voltage [pu]";
  OpenIPSL.Types.PerUnit uq
    "q-axis terminal voltage [pu]";
protected
  parameter
    OpenIPSL.Types.AngularVelocity w_b=2*
      Modelica.Constants.pi*fn "System base speed";
  parameter Real CoB=M_b/S_b;
  parameter OpenIPSL.Types.PerUnit vr0=v_0*cos(
      angle_0) "Real component of initial terminal voltage";
  parameter OpenIPSL.Types.PerUnit vi0=v_0*sin(
      angle_0) "Imaginary component of initial terminal voltage";
  parameter OpenIPSL.Types.PerUnit ir0=-CoB*(p0*
      vr0 + q0*vi0)/(vr0^2 + vi0^2)
    "Real component of initial armature current (system base)";
  parameter OpenIPSL.Types.PerUnit ii0=-CoB*(p0*
      vi0 - q0*vr0)/(vr0^2 + vi0^2)
    "Imaginary component of initial armature current (system base)";
  parameter OpenIPSL.Types.PerUnit p0=P_0/M_b
    "Initial active power generation (machine base)";
  parameter OpenIPSL.Types.PerUnit q0=Q_0/M_b
    "Initial reactive power generation (machine base)";

public
  parameter Real pole_no=2 "Number of poles in the machine (default, 2)";
  Real PMECH;
  OpenIPSL.Types.AngularVelocity SPEED_MECH;

equation
  //adding mechcanical interface
  SPEED_MECH = w_b * (1 + SPEED)*2/pole_no;//mechanical speed (rad/s)
  //SPEED_MECH = der(flange_b.phi);
  torque.phi = delta*pole_no/2;   // (deg)
  (SPEED_MECH*torque.tau/(M_b))*(pole_no/2) = PMECH;   // (pu)

  //Interfacing outputs with the internal variables
  ANGLE = delta;
  SPEED = w;
  ETERM = Vt;
  PELEC = P/CoB;
  [p.ir; p.ii] = -CoB*[sin(delta), cos(delta); -cos(delta), sin(delta)]*[id; iq];
  [p.vr; p.vi] = [sin(delta), cos(delta); -cos(delta), sin(delta)]*[ud; uq];
  -P = p.vr*p.ir + p.vi*p.ii;
  -Q = p.vi*p.ir - p.vr*p.ii;
  Vt = sqrt(p.vr^2 + p.vi^2);
  anglev = atan2(p.vi, p.vr);
  I = sqrt(p.ii^2 + p.ir^2);
  anglei = atan2(p.ii, p.ir);
  der(w) = ((PMECH - D*w)/(w + 1) - Te)/(2*H);
  der(delta) = w_b*w;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(extent={{-100,100},{100,-100}},
          lineColor={0,0,255}),Text(
          extent={{64,75},{92,65}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="SPEED"),Text(
          extent={{60,-66},{92,-76}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="ISORCE"),Text(
          extent={{64,-25},{92,-35}},
          lineColor={0,0,255},
          textString="ETERM"),Text(
          extent={{64,94},{92,84}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="ANGLE"),Text(
          extent={{58,56},{92,46}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="PMECH0"),Text(
          extent={{64,34},{92,24}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="PELEC"),Text(
          extent={{72,-46},{92,-56}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="EFD0"),Text(
          extent={{56,-86},{92,-96}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="XADIFD0"),
                               Text(
          extent={{-90,-50},{-60,-70}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="EFD")}));
end baseMachineMultidomain;
