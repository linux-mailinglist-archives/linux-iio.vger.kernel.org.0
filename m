Return-Path: <linux-iio+bounces-19107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01CAA9755
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FCB7A5E73
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884E264A77;
	Mon,  5 May 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="d+zdF+AN"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18C25D20E;
	Mon,  5 May 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458278; cv=fail; b=i1yPYBFNOeSIRuuurv8ohH6UoZxm1iBYwML6gfkSyUtilW26G7u3Ls/7JwUbbw7iBwvYM03lcgnyXMsCpn4mvF+WjLF8kqoGPZE4Uj17Sqx8HaKKUIQv1XIyERRaj4eIenh1LkJLYMzQAEMNlw2/ouZ8aWDkCSFv4seZjYkmLrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458278; c=relaxed/simple;
	bh=ZMuZ15PED0DrLPDC5adzChk2ijXqVcxKrBKV3MUAAQM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TchhasPPejtNZAQ3+XVAjLPZSrAXhRB2/ePYEXlVSUI4Y7ymQ8pKJQdqKJlwCi6d/HiRN1V+DyYwf/xhaKXNL39Ifyco2LoWFtQzoAyRq/TAMO8wtXDgK1Hd/V0CpBEv3pAXRdJQtl2RK6z3JuFmDRKXjmRZck5xwrfAccs8Ns0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=d+zdF+AN; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKymZKelegUmsQEY+ixDhYHJZLC/xTULPiQd3O7aJZToVuFkSn+80WsVoEjKvv0M6YND23YwYLUgH4rnM/kJbUHpT215QwiH6O2Vl/ux9ClAeiBZW+RuFxwrpZNyD644kqpe0TShc3Xzxdr8LXjHtCgvyzkLwmFtyLTPFjozQpA80oF6Dv/t6FcMl6k2jmZ5jmIHI+d+Q5z6Xnw2oj3EToXeXDnEoFvhYj7lFdQsKG1y1gB+XxQ8cOLEBwGOmcp14ClUx67e62G98t7XV1AYjJOf1OXdzhdU9ClVHdWV4WfCakPQzh3PX4ZBqs6jBQcnG7ivLNzqk+SQvpOon5Ythw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUS4gy8TyN20/AUD3AS1xPva6HjdMdcDLMqvmFGqxEw=;
 b=smP6ozYzKJ6dghtSwcg+/1m4MduN6i9ivuvdGrXy6UpsnkjtGwYUU1N1DA0CXRxh/oN9HO7M5WtqX4ucm7sJznXTkDtxCjFKBrzqP3zVXs1VBRBoNxWNKW2zF1SzKkg9NJCZeXXpPyGkgS/UmHrrTTF94cBmlG20oJC3ko42reszo3xVpcAvvdEJr2+Tr+uLoarVXdu6iUAmGzL3EwZ6tE22e4P7kXKe0bn+Idut//rulEuU6g+TotyuG8R0A3B60l28EgkTbf6yBf4Bm02yLchPY2USIY0UjfdLixIq05Ad9MbJed9PMU5Br8MtQNdLYuUhOXc21fFUxKyJhmAYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUS4gy8TyN20/AUD3AS1xPva6HjdMdcDLMqvmFGqxEw=;
 b=d+zdF+ANc2qdOLbOYuXCujfICpieFicxVNV7aJ6Y0u9l8gzxIVzB5NjLYQu59zLaItaG3VOI19pWxc3lsvVgfBZ44Z7pgwF1dMxXLQyEuldrm9geAi3VIlmX7y75t7dwdkxQwLLsJ5a1nr7FiliB/+eUp42Soo5F2Hay6Y3RPt7Kk1Y7Wosz1mTifG9JfSPPeRy2WJHP9u+1ophSBOwPcKuLWAQjFQ/YRkFmzLerHWlArEbpd+zVBHlPTdwdAz5evTuKnCT2ozx9dqX3sqKTWGpYZjzui2CDIcRYgWZcVtORMcVYosj8OXv4ZmoXU092Ed+rtDZHNggOUmjSm0bACw==
Received: from DU2PR04CA0319.eurprd04.prod.outlook.com (2603:10a6:10:2b5::24)
 by DB9PR10MB6522.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 15:17:53 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::c9) by DU2PR04CA0319.outlook.office365.com
 (2603:10a6:10:2b5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Mon,
 5 May 2025 15:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:17:52 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v1 2/3] dt-bindings: iio: imu: smi330: Add binding
Date: Mon, 5 May 2025 17:16:40 +0200
Message-ID: <20250505151641.52878-3-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|DB9PR10MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 096d7b22-cc44-48f0-680d-08dd8be8017f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9kTqlmUHwIiD8xvmJnSu2k9CRg94ajXkp3WGgM1GKpfV2n1jY0nr/RQKU9Nz?=
 =?us-ascii?Q?hnIizBD4EbSU4dM0AOw8WXkAmoHctz9guS5Qqc90pJDlnPGaWv7ah59JDVdm?=
 =?us-ascii?Q?z4XABwUNZOQcH+dfFblMQyEY4f+ouceGGDGKh+1rde68Y1tTKK+ScBWcX6Wb?=
 =?us-ascii?Q?WtonCu0qVrWNFsUqee0zk/nB3+whNNez0xXbBHhDMyNcnErrzLvVwvZAI4wc?=
 =?us-ascii?Q?sNNo//mhJ9HtOX36b0F6fSR4e1dy6JBE0d6r8YQSCljRtzlUVelLcF9MTJat?=
 =?us-ascii?Q?F7tnfhqKNS2vIW3xIASbF0SXLVXVXm8xHhGh63GRZVMY5P+IDgBFhwmOazbJ?=
 =?us-ascii?Q?09aXyU4D8nYHVTEbld5RqTZPFTLGB8yUYW541C9O6kWBgX/EQdl07nFxdilM?=
 =?us-ascii?Q?NhZnfb+Ndqc+xrT4Qj2cYsvpy1X/xn5kAC4TQe4hLCPa+Q+gntkJQqfK7Iq6?=
 =?us-ascii?Q?IQDY7OOI02C79WUzsH9pr7buHxEyohO2DYWm8EE7R12wBZsn+VtfroQxsFPX?=
 =?us-ascii?Q?SWqx+soSAAvCadJ55sm4WItZVHFHX+HcF44sTPEd9DiKimzHVGpbH9xO3Taq?=
 =?us-ascii?Q?v4+3x9ot5oM6L/LR5PWIHXx/vZr+Kb10goBGSAm1YrEBJ4fR5G5eGHvk1xPT?=
 =?us-ascii?Q?6YdyTqyLjqCiGDkyL8Elq5BRi8UlArxFYPlm8TFw3wJ7QTBQ1wFmyzGZytOC?=
 =?us-ascii?Q?m+MFb/A8n0PALOSFb3oIiFIZVgZyGuUZItn1VGlCbC8r9Z8pAi8X9SfMlDI0?=
 =?us-ascii?Q?L6vSn6UpAgXt4Bi6jcDrlQXiqfogCjRgPp8gME61HA1zVmRNj4GsD1nDyQ+3?=
 =?us-ascii?Q?eXKHGqkLrJ3/rMceKthB9VSFKqKEutsV26ADElrUgHcveTB20rrn095F1Qdj?=
 =?us-ascii?Q?1ahshsf4O0/t4nlP2ac6WwBCE9raOk3a4Yj9A+IVgPNs3Eh8XHQJcLzoLHWG?=
 =?us-ascii?Q?+nI+T04orDe2LJkbL9CE3+CwIRhbDJwTn14hur4EUxgYVr+4SayeeTlFJUc6?=
 =?us-ascii?Q?ujWQgpg7yKiB4lQfN07207h1kHBktqP7wlkcZZJ3dWCACQPLAyCa4pe+BlRK?=
 =?us-ascii?Q?x6rhG3ZsqdB1YbLJ6yJIyePTz/VtOKTwjPLNdSu6Mejnt3C7OrcBg0qiowDZ?=
 =?us-ascii?Q?Y2Fx9wnEdKO/mFYvU1liKFMRo8Mj3JOoqNnQ43zLeAEbfGOywC8Bdeyho8Wa?=
 =?us-ascii?Q?93+TtsDj7WsX2xd3T56iWLvCp+HuYTm+rKvh39ZPKTPIlkzsxorAXQw+nVxr?=
 =?us-ascii?Q?msw6X0zli+1sot7MWzAPdFxcooTALqblKMnYObz/JoUm7ikWkLE8efL4Qe6Q?=
 =?us-ascii?Q?3lOZwxGm8yBpnzM56mxKM4uDOwfKLdN8qdtyq+kqb3+ANorzQpm0xyTfExjy?=
 =?us-ascii?Q?BkawXtx+QtYwB6wJks7FRl8JITKy3hSiSmGenhUF0MFTLY+FvXDcuYeuo9Vr?=
 =?us-ascii?Q?J4OkJBf1Dn5zYlvwuuCjkDCZyI2gqwmhOh6VmaQCnAKZDSRyJpFQNgIeob9A?=
 =?us-ascii?Q?lVoVgKvQgNFghms=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:17:52.9219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096d7b22-cc44-48f0-680d-08dd8be8017f
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6522

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add devicetree binding for Bosch imu smi330.
The smi330 is a combined three axis angular rate and
three axis acceleration sensor module.

Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 .../bindings/iio/imu/bosch,smi330.yaml        | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
new file mode 100644
index 00000000000..fb65bd26ada
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
@@ -0,0 +1,89 @@
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
+    description:
+      set if the specified interrupt pin should be configured as
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


