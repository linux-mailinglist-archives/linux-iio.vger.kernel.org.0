Return-Path: <linux-iio+bounces-19106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A33FAA9754
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7847AD1E5
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EA2641E8;
	Mon,  5 May 2025 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="TXTDF85m"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013063.outbound.protection.outlook.com [52.101.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD54263F5F;
	Mon,  5 May 2025 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458277; cv=fail; b=Mrwdx+cLOkWZfIrFTycV80xeTd/9ati/FtEFCcEgh2pso1mQSeEWCyQf4kKqK9BqcEXPonzVrB+Vp+tDIQrz6pFKzIPMON4r7i2T4Zx1RKsQCyntT7DoWdMUVsNDQwPLCJgDTstvNOdVRMG3aAynP2NeI72hh311AnpACIzBkmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458277; c=relaxed/simple;
	bh=ARuTDlcems7s2KaFtdmTdPp7RYlsD0g+j/EfZSwE/kc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adYyz3OQ/lOXE9Qlrx+1QMahAZ+EUdN+3Q1MqWRDL91nQwUtbp6ZqH0K+/6pSKOLSJC698i4lVLv952gFNn6poAI0JkaEYWo6ThMAQzLbw7KXEByvFARznw/Pr2AJp+NQ8V7uMZRNBhsLgwNnXpfMkF95rEw6lkT0jKtE7ayxrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=TXTDF85m; arc=fail smtp.client-ip=52.101.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7NLW69twwS4JnFOeSgZoDndA4gMUibfdtSVMg+3nsBhDnB7nFGBBzTTnuotrGW8S43TT8CbYlSCM6Svx3yJF6PJVn04HsyJjlaV8U1AKFLF4TMePCl0dqUQMpDHZWmo4RVfYDXujV8al1Rsam02cB5bRGEFzgAoz3hJIOX9ER74BrZas37Eu643GirKd7YtwjCOkjpdbRFmf7cJH4hTMJe3DXtA5bbrhE/mBPbUHRhE0efpVTRwsYtP/gq+XF6kJu+FWeuU15CgtElk+4+T06P6NY7NCVs4Sm3dKDJIxEwBwczrb+5e3VL1O6PLTzaex4fK2WG4g6nR/BhSDkyhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcGFV3ZyT1F4iJgOWIspCnLMRIeLMTlicNpOgScxetI=;
 b=SyX1RPI37NEdfGNgVsiwJDHkFcZ8sgyvG1EgnidPsROnM/oDnSytEWXh3YJBRReup6ewnwc1Dylbbi1P/K1NfWUkCRGVqxI0JivzGU4TiH8HZRTPYHo3iaPfQjkCd7td1fvSYnKGBp3PtG0V6yFC7nOYG4BZB9OiRQD5sEkwwGnJdpNPJWcaTV3gY51X/a/R3m7VRBBljdm0dSbAgVULl2PCrF+UlPxBxxFou1c1anjMAfudk146c3IsYQsTL7wAG/TxmWf5WwSUmCku6InKsx8wNL/ql0HuqDmkepfpuWDAAVfbM5/kQJklhN7E+Amj9UUY47HTLlBJkyQDsY8PhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcGFV3ZyT1F4iJgOWIspCnLMRIeLMTlicNpOgScxetI=;
 b=TXTDF85mRfhUgLpCDLr2zpBNmHPpelSJlKTp19aAZqVQTdtxGjbwDcQFQbs9ujdsUTYmQrl/s9Hi9Gq5qqrYS2vig+D75D2QNY2geqYIUULFvx4Mi2njioMD0Bo1gsx9rz6dvw/QOPY9mAFQasP7H9sx33C/dh60AFDt5aS0szqM2XCvhEkked2cS5Il6Im/TqxK2gXNInJhh9XPASMXxtf8vxUzajF3QRmM8Yzyv2aZ5I+yNf8ht4n3BMbtJ4ugHWojQ5/ApB8taL8vrqDTVwAb05HwbhEFyO9DD/GUC6rTdYV1bNMRyT+S0u4GipqwHbRpJta/dzmPEbwFOZnsYg==
Received: from DUZPR01CA0164.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::18) by AS2PR10MB7131.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:60d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 15:17:49 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::83) by DUZPR01CA0164.outlook.office365.com
 (2603:10a6:10:4b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 15:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:17:49 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 17:17:46 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Mon, 5 May 2025 17:17:46 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.213.45) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 5 May 2025 17:17:45 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v1 1/3] docs: iio: imu: smi330: Add ABI documentation
Date: Mon, 5 May 2025 17:16:39 +0200
Message-ID: <20250505151641.52878-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505151641.52878-1-Jianping.Shen@de.bosch.com>
References: <20250505151641.52878-1-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|AS2PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b958913-4afe-491b-882b-08dd8be7ff91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hFqOKLpyEGI8vDJ8ElDcmlo0SaeD1FKfsee//+fCbobt+UBXVphUs2KeZpC2?=
 =?us-ascii?Q?VYRB6mHoV8ArL9DWNAoKx+0pJ2kDy2daSeFnzDrOSXgMmDqv9azG0IrU4qHq?=
 =?us-ascii?Q?uOMPGtVpe68KoDA8sEqAPN3Fh2JWSeba43cMQ9CwXSx1ZhR9k/5GIhG4UVZV?=
 =?us-ascii?Q?Bt/SpLaURxq5VFivRtHTEAFAb2p2Lu7l2hYsx++TOmmWi20aL28IUMEmJLph?=
 =?us-ascii?Q?0nz8Uf+XdCRzefl5Bo+HpkOmxfnaav3i0j6qUEPXwCLuk/DGvUTeh7pwwoUQ?=
 =?us-ascii?Q?ve67CuFM4RZYbAioGbNOwC2YB6DFuO2cYGB4NCRYOrnQxk2KnivjmKpVvZTy?=
 =?us-ascii?Q?GPewxE6SK4niLRmOo3pNjGCmAj9q2u71+Zf9MLht84RI+jjr5Xs78s/BAzvx?=
 =?us-ascii?Q?kE9TrXrc3emAjVHfVFSIY+LJxGJjB7t+rqUbkqSJQ1pv88w8SYxYt+yylOpP?=
 =?us-ascii?Q?ghuQUqSO4xmkdFa0s4bKzpnjCjGDy8IZEDtEZw66EJ7gpJ9CH3TPXvpf5zX/?=
 =?us-ascii?Q?b+i/oSMMRwWuXdbmvVqrYSds/hYdIQw7/iAyvfvoG5Htkt2NXPmCmo80K35Y?=
 =?us-ascii?Q?oM1zGJYWiPZGCGyvwE9iXQkT1yEInRxB02G97JJpIF5KA/l9JRh5ZTd9bMe4?=
 =?us-ascii?Q?o390/WZugLkQVkjjfZ0GViCq3pElr3ePM/GAfurD+U57d+qhlxvE3mqXekzk?=
 =?us-ascii?Q?6cUJYZYgVwzJHKzqj6+YNtt8474Hif4WDdaQBCxHRlDgSd7s3VennzJ6M5kC?=
 =?us-ascii?Q?UGwStTXh0WQQDHa/28M8SCwdT4UD8GC+sJez0Yzv8rDkHaEmU+Nkznn7TJ19?=
 =?us-ascii?Q?Dycah2fkycXbRtUkkAtNdui3rBn/pXeI9Pp8MsYbffDHqlWM04PZC/GZkIHl?=
 =?us-ascii?Q?ptOZFrHlKRdLwvEvsxxXTVonxwM3loTzL8l8ZzNXz+PUx1tP6jKws58PW+W2?=
 =?us-ascii?Q?+lhUKA/qr1x764TDXurR9PzEyjW95sgqU1JdlLMyS0ppKfyuY9awljq6EIBb?=
 =?us-ascii?Q?r2O7xWxCuSjcJTP92X61xhZMfuHoaMC7UpT3NmfaoH6zO0xYZ37tqLLQ9hIu?=
 =?us-ascii?Q?rzKIConSt1aB4hfaXMEolcY14/wOaKDTRNSTpxNQOW1Z+IqBRnacMjgn4Auh?=
 =?us-ascii?Q?FPnUdoA/7j7vALhaf9OzsSF4KJANkJIozXOzJjc0v+fbfRd4O40lWBzcGDp+?=
 =?us-ascii?Q?M1pbmhmES55RZm7gArgIXpTx3NdDOw+PNTwwF41cZl98kR42jDo2qaNFQ+l1?=
 =?us-ascii?Q?TS1HME9bw/x4OEx0HYctXvb8mWlKIuZev7VtbJp0b0G7bZ4b94DgbcrCi8dq?=
 =?us-ascii?Q?bhZ7eE7uumspjG/G+k3eXHrzi3+6yooAChohfP9SbLeUemJwBu4FI42bFekc?=
 =?us-ascii?Q?EEUgJe/SSGNHx3VZFC1NPDI0ihdSN3+kHVi49QCKQtr5ikvzfFNa5qhdFBHW?=
 =?us-ascii?Q?/o/UdJjqDz1YO7xTlwkVyjsVtFbw+Vbc1cj40OmkueP0mjAD5MuyE0REzITR?=
 =?us-ascii?Q?CJe8qNzDZfkzpcA9E9qUDnz+iYuWWpktgff6EhSrjZQgMQ4gMXpWW69lwQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:17:49.6937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b958913-4afe-491b-882b-08dd8be7ff91
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7131

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add ABI documentation for Bosch imu smi330.

Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 .../ABI/testing/sysfs-bus-iio-smi330          | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-smi330

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-smi330 b/Documentation/ABI/testing/sysfs-bus-iio-smi330
new file mode 100644
index 00000000000..68220926beb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-smi330
@@ -0,0 +1,149 @@
+What:		/sys/bus/iio/devices/iio:deviceX/events/self_cal
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		The device offers self-calibration for the gyroscope sensitivity error and the gyroscope offset. 
+		self-calibration to reduce the gyroscope sensitivity error is also known as component re-trim (CRT).
+		The self-calibration ABI will run the calibration routine and update the data path registers in the device.
+		Before initiating the self-calibration, the accelerometer is required to be enabled in high performance
+		mode with a sample rate preferred in the range of 25 Hz up to 200 Hz and the alternative sensor
+		configurations for accelerometer and gyroscope must be disabled.
+		If these preconditions are not fulfilled, the driver will make sure they are fulfilled by changing appropriate 
+		register values and then restore the configuration after the self-calibration has been performed.
+		The self-calibration can be triggered by writing '1' to the sysfs entry.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/self_test
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		The self-test of the device checks for a correct function of the accelerometer as well as the gyroscope. 
+		The execution of the self-test expects the following prerequisites to be fulfilled. 
+		For the self-test, the accelerometer must be configured to high performance mode at least, and the
+		alternative sensor configurations for accelerometer and gyroscope must be disabled. If these preconditions 
+		are not fulfilled, the driver will make sure they are fulfilled by changing appropriate register values 
+		and then restore the configuration after the self-test has been performed.
+		Once a self test is initiated, the output of data of the device to the registers and FIFO data buffer 
+		as well as all features are disabled. While the self-test is in progress, the host is not allowed to modify 
+		the configuration of the device.
+		The self-test can be triggered by writing '1' to the sysfs entry.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/soft_reset
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		The softreset performs a fundamental reset to the device which is largely equivalent to a power cycle. 
+ 		Following a delay, all user configuration settings are overwritten with their default state wherever applicable. 
+ 		To access the serial interface after a soft reset, the same timing constraints apply as for power on.
+ 		The soft-reset can be triggered by writing '1' to the sysfs entry.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/control_auto_op_mode
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		The auto-operation mode change is a built-in feature to support the smart power management of the device. 
+		The function provides automatic switching among two sets of operation modes for its accelerometer and gyroscope. 
+		In the following, the one set of configurations consists of ACC_CONF and GYR_CONF for the accelerometer and gyroscope 
+		and is called user configuration. The other set sensor of configurations consists of ALT_ACC_CONF and ALT_GYR_CONF, 
+		and is called alternative configuration. The switching is initiated by events of enabled advanced features 
+		or by commands sent from the host to switch from alternative configuration to user configuration.
+		The advanced feature engine and interrupts must be enabled for the auto-operation mode to take effect. 
+		Available options:
+		0 - Enables switching possiblility to alternate configuration for accelerometer
+		1 - Enables switching possiblility to alternate configuration for gyroscope
+		2 - Enables switching possiblility to alternate configuration for accelerometer and gyroscope
+		3 - Disables auto-operation mode change
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/set_auto_op_mode_cond
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		The conditions to switch operation mode must be configured by selecting one of the advanced features 
+		that will trigger the auto-operation mode change. 
+		The same advanced feature cannot be selected as a trigger for both user configuration and alternative configuration.
+		Available options:
+		0 - Change to user settings by A_NO_MOTION
+		1 - Change to user settings by A_ANY_MOTION
+		2 - Change to user settings by H_TILT_DETECTION
+		3 - Change to alternative settings by A_NO_MOTION
+		4 - Change to alternative settings by A_ANY_MOTION
+		5 - Change to alternative settings by H_TILT_DETECTION
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/config_user_overwrite
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		The configurations of the sensors can be instantly reset to the user configuration by directly writing 
+		to either ACC_CONF or GYR_CONF, if the option is enabled.
+		Available options:
+		0 - No mode change when writing to ACC_CONF or GYR_CONF
+		1 - Any write to ACC_CONF or GYR_CONF will instanly switch back to associated user configuration
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/alt_status
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		Reports the active configuration for the accelerometer and gyroscope.
+		Available options:
+		0x00 - ACC_CONF and GYR_CONF are used
+		0x01 - ALT_ACC_CONF and GYR_CONF are used
+		0x10 - ACC_CONF and ALT_GYR_CONF are used
+		0x11 - ALT_ACC_CONF and ALT_GYR_CONF are used
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/alt_odr
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		Set alternative output data rate (for accelerometer and gyroscope).
+		Available options:
+		0 - 0.78125 Hz
+		1 - 1.5625 Hz
+		3 - 3.125 Hz
+		6 - 6.25 Hz
+		12 - 12.5 Hz
+		25 - 25 Hz
+		50 - 50 Hz
+		100 - 100 Hz
+		200 - 200 Hz
+		400 - 400 Hz
+		800 - 800 Hz
+		1600 - 1600 Hz
+		3200 - 3200 Hz
+		6400 - 6400 Hz
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/alt_acc_mode
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		Set alternative accelerometer power mode.
+		Available options:
+		0 - Suspend
+		3 - Low power
+		4 - Normal
+		7 - Performance
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/alt_gyr_mode
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		Set alternative gyroscope power mode.
+		Available options:
+		0 - Suspend
+		3 - Low power
+		4 - Normal
+		7 - Performance
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/alt_acc_avg_num
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		Set alternative accelerometer averaging number.
+		Available options:
+		1, 2, 4, 8, 16, 32, 64
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/alt_gyr_avg_num
+KernelVersion:	6.16
+Contact:	Stefan.Gutmann@de.bosch.com
+Description:
+		Set alternative gyroscope averaging number.
+		Available options:
+		1, 2, 4, 8, 16, 32, 64
-- 
2.34.1


