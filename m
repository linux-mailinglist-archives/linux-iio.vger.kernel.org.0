Return-Path: <linux-iio+bounces-21314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C84AF7CAC
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEE918896C9
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387E22259F;
	Thu,  3 Jul 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="ZPjJiLDH"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E015C0;
	Thu,  3 Jul 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557156; cv=fail; b=KYcSrSlSYyLkskj0h6GWxMnFeZbtDj3u9uzin9aHfl3rSE6arEf5qXeQNQiw9e77oXwLoNwY09DxIiPtYKH33/NCWAy5oYLGqX3MZJLkcdDmFuEsVPXa8YDA2ovAzT+UB8RySyu3OPlGONLKuG7uWfcGvVCyTOxJBAnltxIpBjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557156; c=relaxed/simple;
	bh=7elPI6oiWoPlhF6YappRCpwOzRDbrHnP7g7Am/791mY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=To8r2NGdB9j2kUga7Mk+jjHPHg64oc09E6DzTWrzzII9N1KoIiYB9x0799ZbChwgx5kTMXdbkde1FiVftRhqMlptF2Fw+LoZ81TNtOhlmj0yQuKjfER+ulMpg0lGanOcQKUfueogFNzzVTuEn2OJZMmjYIg3pHdhjTWjsxwA6cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=ZPjJiLDH; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFtnVi70kkZ1y0cMLnnKcNdiPdKajttzfZFPzcbc61z2jZ3hpz/t25bDA6vFe3cZnk9AujE3RNC7kaLuNCCe7VsouuRsWHcPHpO5IZ7DGERaOoYXMczX9YSWjiAYVVOqL5YCR4ECHyfUro/6bXcVzDHGElVyYXyy23xoZ2T8FLVji64G22os3PQhkLNEr7tLcGwRp3gtwg/2kfxUpYetdMKpEngnP4jsv++ZM86JNezy4G39cNxMmTjzzPGBa4sOqa/YahoBDsVLQTzNIl+VHJXN5H0Jt2ybB8iZoF2Tr5iLLplnN6RT9DIubEgclbCLs1SKizbHdzWaIZhIjkCN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RTJIY8bHME0NhyJ8j+UlJlOmZM6Jdi4TW5JSE9W8Xo=;
 b=UzzOHmELuw/iV39Bw08hlLkxvU9jYkuwqFuapJot0HexRsRaUEEyMSOtdiS+44JDWHonZOSqI3f4flndt5SvOF+jDboHue5l/jQzANTYewDbrR8tMH5wsvtIuYSAVWrh05BrWWGbmGS6TJbbgHrth3XeM1jnzedLJZezcMXVtmLPtcZO4g2zKlfyH9xLvphv4ng0h3fzWw7NL6PIDpNoTODYpDfo6MFPeHhoJ1ax02ifJTRy4UlDR78OS+p5JvaG0oiXsMLJnaSnf+38oQ6hKG+ewnFH3/koo6CE5Qdfhyv2KHS0+73h3J8gjIT4P5BKqEDmBtAhl6bDGHmqm2V8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RTJIY8bHME0NhyJ8j+UlJlOmZM6Jdi4TW5JSE9W8Xo=;
 b=ZPjJiLDHgXOVkwr4MbZxgwJL000gKeSZDGnXZYr5VTdDTDayR1DHOuRkInalwwxEHM/6bteBRRPbrlzOVhZez7mcDi1Bq5Q/YCUGhzeLguTnCD9yft7t32mH2aDQcvG5HUjETUVcyYwirGlfKlLN/xVdnRc36Ow0TycwYUQ4Wh6/3OO6yWH8aZfHzYOwIXLtP/GBz/ArriSMr1gZDifCbC1DPPtAMC26m9L2qq7ytregPM4xOc5II+TFPkHM7EQDF3kq4Uxm1TPO7XPj4C5mP1brr8owv8oSq+5nnljkpfUIga/ZDdsmM5jZLQH/rXBZaa7vuFyFhoOkKgreG8cpOQ==
Received: from DU2PR04CA0237.eurprd04.prod.outlook.com (2603:10a6:10:2b1::32)
 by DB8PR10MB3209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 15:39:09 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::78) by DU2PR04CA0237.outlook.office365.com
 (2603:10a6:10:2b1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 15:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 15:39:09 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Thu, 3 Jul
 2025 17:39:06 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Thu, 3 Jul 2025 17:39:05 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.13.214.229) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 3 Jul 2025 17:39:05 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: smi330: Add binding
Date: Thu, 3 Jul 2025 17:38:22 +0200
Message-ID: <20250703153823.806073-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|DB8PR10MB3209:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa6a011-a377-49cf-8082-08ddba47c0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwfvC91EPhQ2nPOJ3/Nfa95sCIOnCcBYhrMsYS3XXBcXV1R47ouRNtgFU2+k?=
 =?us-ascii?Q?gZqAN7RejqeChJUIe0mtiEDXAT7D8MwRncdyyX4qLZ4HIVPYbuHY0++2X0eV?=
 =?us-ascii?Q?vKSB+5UBMlJWo/KJOEpRWZA3rlRW9E0TTMH+yNK5WX8ldduOSIiKC/M3ziKs?=
 =?us-ascii?Q?TYRNAGODhGDO6cAmjcDJEoXUBA29gGKNC4423K+3hqyPlJXZyVSK/aOVmJsb?=
 =?us-ascii?Q?QtQ26lQL4WLAHexPuI+urNPHvDvEDUUX+/yt909QwBi/6bOQRdwwdBs+a46j?=
 =?us-ascii?Q?72CrQ09FyhluCOu4smJ/cQhYqYMEkrjiKowhf5OoA+kA96ALnJl1qRmHaoaW?=
 =?us-ascii?Q?acBpsFzlNBRbZDNEb+9CDJQXa8Tw+BlUPexA7Xrk0dGVji4r8xMFFGAHsVed?=
 =?us-ascii?Q?DHPDNBaqruow6inWU/Ed1spe4NPteHxneiRx7lBdpgS/Ucbaxj3FGRfItFA5?=
 =?us-ascii?Q?0q/HLQRTRMn1Q2IC24pLbjI49qxNONCAnQg/NoBvWMsyySJpuzyCw33UGqnt?=
 =?us-ascii?Q?avm7tk9QefFH8b7ioJL/RE0T7A/qmeTzFmuGktdRBrH1IgO16QQRQsdW00Qd?=
 =?us-ascii?Q?kj/x31P+qwGGTxiRxpe0QsdARBFXJIMicMpTq9lNFB8aMn3Vetmq3URGbl8a?=
 =?us-ascii?Q?KyWdIgBf00bSspld+TX7S2ejFV1LgaRaeDSrf6VfI8ELOca41Hx98FSvu9Rc?=
 =?us-ascii?Q?mjDXRjEzj76jjEZL2RAT2iBhid7BWVCUky3dEnBXfjvnDhdAhbHx5OjyCL9o?=
 =?us-ascii?Q?cZEhP0INvdjrZZAfNP9qin26D7cp14xoFtOsWHJnImWila6BJ+M5aXhEuRnT?=
 =?us-ascii?Q?52brdIwJOefXAoc2vuqhIQvx3FFO9y7iqvRjcvkr8frGa1Turdi5btA0PIzF?=
 =?us-ascii?Q?MozsyjDpbTldUtMAsx4IAxJdefFM4kt/N4Hiem0wBBjVOUOTUbZwhGGP5RSg?=
 =?us-ascii?Q?xSp9aWzIHfI4vvCJGn0UMAqHEFM3xBllFfXIlr6cM2dp6Vg/cx0TDNUC92Ar?=
 =?us-ascii?Q?pVmZg0gYW9sIRNNoqI90RU7J/E0JougaygOKtO6Xx6OjOyKRBebDGl0XJOG9?=
 =?us-ascii?Q?yZOz/pmVykyu/24pqAEIKi9HROLwN4+f76h/e2K6Kjx8jhmZDvq09mkTFKKx?=
 =?us-ascii?Q?eQI8T8nI1y+oD1nhqFx3X0GLvCxQSOn34CAwTDgPv7rT3e0zZPCg6DaoymdD?=
 =?us-ascii?Q?egh+jhoG25fRshx5bgp4JX+kcOp+f1bgclGviO4kLVfmWS9yze1kTDJGEF4v?=
 =?us-ascii?Q?envwl3iUzPgdRE8x6x7qMWjOgs7CF2hs/iWnzcTgWPRNyjg/9woPbyJ6dhdl?=
 =?us-ascii?Q?OJxPn0Cthhl3/UcELbMkLofeUlUn3ZOobCYGgLJq4afYYWpbQe9Hb4xfmwPI?=
 =?us-ascii?Q?0MG57R6xDflcRILKapzUOGhAQfRB1TdTI+gpar4P3IJ558pNAOmhwmNvupYX?=
 =?us-ascii?Q?B8wrvmjfCzZ4Bh4m7V2tPRpzAQCg+9G3KeND3cRqrwFPbl5njtMsBfu6RDHz?=
 =?us-ascii?Q?Au3iZPHg79jyovw=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:39:09.5693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa6a011-a377-49cf-8082-08ddba47c0ce
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3209

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
index 00000000000..0270ca456d2
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
+            interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
+        };
+    };
-- 
2.34.1


