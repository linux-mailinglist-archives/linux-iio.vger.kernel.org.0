Return-Path: <linux-iio+bounces-24115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789DB581B9
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 18:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C622206C3F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F423A25FA2D;
	Mon, 15 Sep 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="qY3B9alA"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD822A4EE;
	Mon, 15 Sep 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952737; cv=fail; b=QfMsFVSPBZyaKSckBRRJqzAxjS5qZl90pf7Irg52pdeSIcRPf+zZZaAzR6hFGU/i10EieqjdcGT5Wnb+C8Ew1qWSs/ClMQU/QkSAwfsRszdwyhAW4PgDUl5X85DCsVHwq5wj7i6L8MUllC4I2FoUn2T3vgS/obNj6CunBtkEXQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952737; c=relaxed/simple;
	bh=7elPI6oiWoPlhF6YappRCpwOzRDbrHnP7g7Am/791mY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFrHwSO3fIaXPqfgkos67udAs8gZJ/bSdfGWiQm7wFm3VpSyRVTmR91Bo0WSxkftKU4OBv/4FjH32DG4SzNhU291juesRwh4zbGQjnQNEGRa9N0JJWpp6R1+1khPplAUga2NmiYmjH+Yj/mbGnXfNfT0hqzm9VFWFyvreWPUaZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=qY3B9alA; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKKzNFcOltxrTqXj4lDnRjXMgRfxWQR7vNHEKA9FYP/k5j9oNnLOlZF/qSx/9HyfsQrW86PYiGD9rRJ3OTsgJJU5dTMHk00gd2Dh51KWhYTNsrQhf9zOZ168+eaR4rqxeenOVRj+i/UPk28xwGuvau3rRsRzVkR/SBW09IlmeRsUmiAsLxEGfgzuuPfLxT60iO44Nz7vhy97qfQo73o8fMP6rj9C2ogOT36bAGXQzdquiHQEHS3+dCOHfnjV/0h3RLkaWMoMz36pGqmoygHgpPJ4yYKKReJxFgcdBXqyL5H1wuS0VJNNeFiIhcz+/A8CVl+FllvOF0k6IX6VHrfrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RTJIY8bHME0NhyJ8j+UlJlOmZM6Jdi4TW5JSE9W8Xo=;
 b=M9nS/2p8q7nYwRAy8oi6eRYrFsBBiCCUq9TXxws62lb6Nx0jdoDYluaxUwi+PyaFArPUrIextaguiACsX7uHY60tAZvdqd/UWmOBk+VKujp032TKw2EVTSavdtbc2LJCONVYyyRHKMBT0pWSjh2Yg+/BcdeFkUSDVsUtydKT/1nnMs4JZxAN2AIOxjCWK6M02TuPxioWQ4T/DW4Q5VgjDiDJK/terIiIo4unZaM0VmAHax3ewgdbvFDu5tHQ3f40moD9STdPslhY94OYnRapyw0mkCnfjnEpFS7P2ooxrYJk0i7f98ycWFpRJDvtaqAuFTK3MomvFwdQzAqaWlkHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RTJIY8bHME0NhyJ8j+UlJlOmZM6Jdi4TW5JSE9W8Xo=;
 b=qY3B9alA6I9/It1xHRJ0/ODS0FCdRZB4YOPnCGvZZAfpgivdF/7YJrvJrzoe9yn/ISA4na7rsvSVBMApan/JLDK+LJrXdRIOgGKWQsb8xrAToBRBD4jznhi1JX+cpeP/hKDVhJ3pfU3Lg+/ZA5GGPVTFxp53eM0nHvyrjGhGOKAKYDNcKBfP5T71A0tZ/ckwOJRcOyZU3kqp+IKRUcMc3lFUeejSOz/JbyjGD5D0ZiGO80IcYztItE+iFSYJObjhxiF3i+cbO2miEBOdgJaz3Ab+w9S4M+uLi1EgZuNwPpJMzFk15euL8t9zo/OxIxmTdNUzImm7iZuj3f+pezdcmA==
Received: from AM0PR10CA0114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::31)
 by AM7PR10MB3955.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 16:12:09 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:208:e6:cafe::3a) by AM0PR10CA0114.outlook.office365.com
 (2603:10a6:208:e6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 16:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 16:12:09 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Mon, 15 Sep
 2025 18:12:02 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.179.220) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 15 Sep 2025 18:12:00 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: imu: smi330: Add binding
Date: Mon, 15 Sep 2025 18:09:33 +0200
Message-ID: <20250915160934.89208-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915160934.89208-1-Jianping.Shen@de.bosch.com>
References: <20250915160934.89208-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|AM7PR10MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2d3cd3-68a9-483d-eb81-08ddf4729f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zG31gM3YxWdj1w8N6bOPIGbkAxf9j0EDnnbIBhXL9SsDgHL53tXR7SixjWCj?=
 =?us-ascii?Q?NwJKiJ13bSzVZZ5PUCyJfzgw5TeXBq0V/mkTz8Ja/n/Ro8wVD2TL5cXSbX3i?=
 =?us-ascii?Q?0YsGt/HDip14lI7meYVUyPV3+qa+A80+KqkZNgg5HVaX4k7/DXTlpybMX5al?=
 =?us-ascii?Q?9f3VCuAPTHyB9IhwgMj9h/yJFVrHHyQEv0tioaKDOfjK7D2LkGOIpupcpqP1?=
 =?us-ascii?Q?LiLhPmYa1lMsOdKYTnRG5ziaBT/Na1z/WU20ZslIu6UoXxh7On/Yu3DoVkuQ?=
 =?us-ascii?Q?kRCfMM8RYQ1YLn+NWZMpa01OjPQKszzs1s+UWi/vtQEpXREfr6eLZGsNK9Cu?=
 =?us-ascii?Q?Vn5C5+3geqFYq4ggFq7WaRxh0fHdqG+hxtqzhlhJZVFUVs8ssRik6X37zCez?=
 =?us-ascii?Q?JeM9Y+tckSQCs2iyFYFsNHNL9KYxnZSEBZSjNLaQItWLDeZXJR9na5yvv8RQ?=
 =?us-ascii?Q?1Eji83bFawqLZGDhXaxRsatKBmVTkxvM6sSVGfk/j0m0XvkIsk97+Tnesvxn?=
 =?us-ascii?Q?mkBgiAREGDfdKGnsR5LDpYgAtKFEilO1Umm5t+EDuoUj1RqppEyAu2AWz1z/?=
 =?us-ascii?Q?K+QewSYELQNjcxxTxJZ3VUCOHHaZsyVg+5v8R7CHXB/bYysV5Kv7rn/GpwyN?=
 =?us-ascii?Q?ZW6TAWdm00HpTlAiWmSWY2OczWVaLLHwlB9TMrZI7soz0PpbnQP0gUEJv/Tt?=
 =?us-ascii?Q?bLmOF4PF55LbWDEpC6A5+I7xD3cd3C235BvEogngHLlg0Zuz9mdc3Z7CJ1F3?=
 =?us-ascii?Q?q1wUzkLUFJHvDiaE2blpGCNvT33NoVzxvqxpR4l03GmPS8fC5uczZ0twQfCd?=
 =?us-ascii?Q?hKhNKf5Q26eCLvxyfYqG4KO2x5tw5w8sT0e3tTTuD6O40lT8V7dLAaV6zZAJ?=
 =?us-ascii?Q?0cWlDs9OKt44qF3FiaxAQhyoShFfjJxROn9ifQkAZDimm1UiCR+bMOjFf7Xy?=
 =?us-ascii?Q?+u3xVHkEr0/9f2PipbzERlPQ9o2SoiEuCd2LvtqbvRKlOhDh4O+Tu3I4o6t7?=
 =?us-ascii?Q?5C90hpMHxt4Poo9RGHNVrHA7pgI8EudS+dSwKogUGT7CgNQw49w5qFswOrJA?=
 =?us-ascii?Q?ChyAmGmzF9ZF0CVpwYs2PIHnB4IZF6Fm5W9rWKcDQBtFYaCClOgsKq36jmjV?=
 =?us-ascii?Q?9NSUxUXdzAgvMcycFQWy3fHzzETIIFDGBBp7Bp6ZETzqwAeU8VikBY5MmKt2?=
 =?us-ascii?Q?bNibHdIlWcPN9EIKg1KeB4ILlBlENBprHGUJzROUd7+ptZtdUoWPcklca1mg?=
 =?us-ascii?Q?hQz/ahAiCOogU9s8FenFeB/IFj9LUycHIxZsLtxSNqXoE22S+d5R0Irp6wJF?=
 =?us-ascii?Q?2abCbSUKCDbeIbsWyRIqg9rutyPM3Ny5z/shmF9vKoR0pqm+1BGbCEhfnwx0?=
 =?us-ascii?Q?FqSqtPWUDexEbZLhGAK1woOKBBJTgkFnPpZmNzc+nh2TFwBjS2T308FIxZvN?=
 =?us-ascii?Q?OIvn35LV6XGVvkAW8zdpOXP+Bo9Pb6oK/d3CfBmJRGVdAZTJ72TxBTTVYyIG?=
 =?us-ascii?Q?L29AeX/E61CqYVw=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 16:12:09.4760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2d3cd3-68a9-483d-eb81-08ddf4729f79
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3955

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


