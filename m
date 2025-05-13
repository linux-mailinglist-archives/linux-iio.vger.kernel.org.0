Return-Path: <linux-iio+bounces-19499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BDFAB57DD
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8B23ACCB1
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCDD1D61BB;
	Tue, 13 May 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="BYW0n+no"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518181AB528;
	Tue, 13 May 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148502; cv=fail; b=RTn1zn+WqZpHrlhGLQ2cWfcb6TYjUuVGsUXe+lP4s7Vin+U2bXMA6JZRzWYqzp/dSFnamdUreg5ne1HxX4IqsbJz2bkX/sTtiufZjCb3yFU/ZahsQKNKyF0Wp3FPUGpppX6DL/55w7fTaDfX6zQo//oAiBoMGTixFiM7UN0FaSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148502; c=relaxed/simple;
	bh=XjgN2Nv/02U+9zMtAJBJMweTrRurvUy1CEhFSrwzM3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6OgdNUTU5/wDNEAU6wsMNSfOIP6o1Yoi/P1wG70ioVVzuvlUcRnPbH5Ju6dFcr7H/ITcLYPqG4arvkWXNjMJZtCNrEwOdtGC0gJQpQdq+Hubfb4sHhLUwRPw/hhxozanK4zXl3tEwPVZmxUAk5nxcBFP21fEF5ThFpoCttFLCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=BYW0n+no; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvvBMSM0VIZcq7dJyb8MZm5yMcFKPx7SR5bfJEshQwVOHBzOcRid4DnYN2+gRUlLJZUXxXUkeP2P4dsJj4TYv/m476iInFJRQW4n2PV37t4eKuAwuMb+YNw1dWxOTWHN0/HFFPv082+LG0Jb91qih5/hFCC8FKfCZRUzve0UCATfLz9do1IJZWl4ttvEgT7S+lAqbd9qa/oucpROVVYmvEzKwHc/tPhPjsEXGMMrHM7RxDsq8Dv1r5yNGJwAFupDM6bRUecy3FmF35i2K3VF32nw70I5TAxcRHoDvQfo3MwZIjpZo3eOEHg+/kZqA6KReMZdHPE28pzpRZUwQEfmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjIsDiCoF6jnkS5smHU2kM5XkeSWntqusBg31KgDOCA=;
 b=D2GnuOGAjpl6WyKnHGuVDxIG19NOIu89xc9gK8z6E744uqrPoeHIYmrAAvC/qMF0mSVxEn2mNFLrnCSO/TWLeJhNpWW73TOC66X4mQk+CqIK/N1D90Juq56hMaYcuyX4ZFTDGNrswkjp22Q1I8gGyqqw+9aKwZN9aYQI2eewIYstdCRRyLPMR2uTBhncrqek3DTaegt8k0Owph91+09ncanobU1VFrA3T7+3Ef15muWtQQOGxWIFk88eMoDQ72VCVi7EFcW2GbUAk+lo9iG1QCjAx1QmywVom9y84yQCH6yCJSF0FblL0Wd9JwqnwykvUBHySLngO7zQv8A52kgbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjIsDiCoF6jnkS5smHU2kM5XkeSWntqusBg31KgDOCA=;
 b=BYW0n+noXiI/JO2/WUZzJ73C6rrBbgcq7Cp1UwZDjgmjHbPSfmaWodJBfcH8MuuiSFdOve89AwMalfgD1MGoq6g+Qjogg6KPv5/Ta7xCObRdtCDLS0ZeAxA64uKALuX2xRZfkqpYbl9pzEbJRgU3VC2tZYrYm9m4MvtLb6ERzDvEo1B7tvyNwXlUHoBX0+aDrI3FGqYkglLiQEpaL05DPgDMx3NqayImOJDjbP+ZXTemIHLSA+WiR6L7+eVxnBOikSnSOOUhw6AjQjpNkXbHGIo0S7LgUvUdJMGaF6vQTwo0Aea6oqzavKYkHuBezjFLgk15hQMqD4VyR7uK//T6Tw==
Received: from AM8P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::24)
 by DU2PR10MB7861.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:497::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 15:01:36 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::2d) by AM8P191CA0019.outlook.office365.com
 (2603:10a6:20b:21a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Tue,
 13 May 2025 15:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 15:01:36 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 17:01:11 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Tue, 13 May 2025 17:01:10 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.215.140) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 May 2025 17:01:08 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: smi330: Add binding
Date: Tue, 13 May 2025 17:00:27 +0200
Message-ID: <20250513150028.42775-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
References: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|DU2PR10MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: f444470f-0a72-4d93-dadc-08dd922f0eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/zteSWk5Be3taEttAQ+kTAm2Ltplupnq+vak8acTTB9/dj2z5BpbbYXc7H0?=
 =?us-ascii?Q?uxD7EU+ZrNhiWVBIig+SXzmjlKQc3UTEVLBiNiSj+NJalz+TmI0t9Yo2mr7h?=
 =?us-ascii?Q?2ld5WetU5CtSL9xSzvP4WdR0R/x1kPezPrUegfPIbVgIAjOMNm+Qw+mSD+mZ?=
 =?us-ascii?Q?THz8E6+Qkwka00T6D13nGiQ7eUH9OpVpBwrH2LGq2bK/tXS177yp7W410/Vj?=
 =?us-ascii?Q?rLU24+nKPqXPuCpNe/gP3moq+uDrJDpb3ofhlnBWIRD3ZtmtfO2OsulYCiUa?=
 =?us-ascii?Q?xjEXxTguzDnKVe4GOgRWZu18R1/9r1mYPzaURkpnFQzQjnXPwz+jf5BL8vHi?=
 =?us-ascii?Q?1ZKTaPPVuIgZA1ejSssY/KJJ6ICizzbbwbgt1SGJyUiaas2bj6+6qsUW7zSB?=
 =?us-ascii?Q?9EB1so0wfu/aZG8ruWNxjKL2578ocnFxy5jA+9g0IcT0MftBSM0mA9SAuugi?=
 =?us-ascii?Q?JH5rED1l+xCmYPrnviDiz7vE7zcKKAEVxQhBz20ZuMmChbH8QOy8Tp1EZ240?=
 =?us-ascii?Q?Y+HdfTL2hoc0NJr5PWQcJH1Cwo5ycu8d19TZDO9xBmWKa9FchCO2NYs4QwVz?=
 =?us-ascii?Q?/s5R8cxttjnMm4wbwjiUM11FaKM4dfisz/nY/VszH4VMz3r7Z7VshVz/GnW4?=
 =?us-ascii?Q?qf8pc/aVyFh27vPWKLxyAmfetAKJrT4q8veU8HpTTvIrxS6ByMFrefZPxWAM?=
 =?us-ascii?Q?SV2O1LPqS1zetUJT15Yy0QD8EYQUMIUUFE2Y2BGrt3AZhmmaP9Ek7613klmv?=
 =?us-ascii?Q?Bq+ToFU/qigYIi/Kn2BFXogk5sMKuYXEGl+CkfbiFAgIa3Oss4TTe7X8OBPB?=
 =?us-ascii?Q?oVC6/oGhZTnwaayL2sxQFBaczgPLqI2+ZluApplPRJByWkhFahAF6CpPyrw8?=
 =?us-ascii?Q?DiWZn4WYCeiEueXJiEmaPn0tsIOGfGnm6yxZ5XaR1AiQxDhduypqLep54nuw?=
 =?us-ascii?Q?N88XRBmX3jPc24USj6nhcOzL/at1yE+4mJ6avPiPUHNIhn10flb0JU3myyUN?=
 =?us-ascii?Q?gvk770eNSU0rjKNRtlPx8Wtu9Rab6axLJBWariVzOxEred55Ia3wrbY10be2?=
 =?us-ascii?Q?71tF8rfjXRl89xX0prht92arIv6nTnHGHzcL0tcCCX2WO0XcqzRmKA5Uc3OM?=
 =?us-ascii?Q?1nMtw5VUUd4FzPvQrXT7mKiWCMH7wXusMSrEUGjNGTueAJt3YjnrvvffEF8Z?=
 =?us-ascii?Q?PIrsnz8gcP8rk01RE88dherUBbtPbTtNpuTUgn0Gs0UWYzKZrTBZ/a4Dtgjc?=
 =?us-ascii?Q?mmKinDOXYNUlvB1ASebRSiDUdGxyCTmB8LLYhpkL32TSmRXgZYKrp4HUqltK?=
 =?us-ascii?Q?M+SJEEL2+ZroW3Bt++x6EvKham6XgKyBaNRiS/Q4n8L4WDCKJzUtKf1dKL+q?=
 =?us-ascii?Q?modRckoy26FtmGYcgyMyh/WDrC9MPzrmqxLGGM8L/+NYTkRT3ifym21yycGS?=
 =?us-ascii?Q?R0A0tb9p9VgmPDEJkcdXZMpwfTDanMphTP8TI4hi6u5SFtWHUgeS8WyXWhRc?=
 =?us-ascii?Q?oDwjin20R1sw5dI=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:01:36.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f444470f-0a72-4d93-dadc-08dd922f0eb3
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7861

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add devicetree binding for Bosch imu smi330.
The smi330 is a combined three axis angular rate and
three axis acceleration sensor module.

Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 .../bindings/iio/imu/bosch,smi330.yaml        | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
new file mode 100644
index 00000000000..9924fadccbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,smi330.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch SMI330 6-Axis IMU
+
+maintainers:
+  - Stefan Gutmann <stefam.gutmann@de.bosch.com>
+
+description:
+  SMI330 is a 6-axis inertial measurement unit that supports acceleration and
+  gyroscopic measurements with hardware fifo buffering. Sensor also provides
+  events information such as motion, no-motion and tilt detection.
+
+properties:
+  compatible:
+    const: bosch,smi330
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: provide VDD power to the sensor.
+
+  vddio-supply:
+    description: provide VDD IO power to the sensor.
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+    description:
+      set if the interrupt pin(s) should be configured as
+      open drain. If not set, defaults to push-pull.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example for I2C
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@68 {
+            compatible = "bosch,smi330";
+            reg = <0x68>;
+            vddio-supply = <&vddio>;
+            vdd-supply = <&vdd>;
+            interrupt-parent = <&gpio>;
+            interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
+        };
+    };
+
+    // Example for SPI
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "bosch,smi330";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            interrupt-parent = <&gpio>;
+            interrupts = <26 IRQ_TYPE_EDGE_RISING>, <20 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1", "INT2";
+        };
+    };
-- 
2.34.1


