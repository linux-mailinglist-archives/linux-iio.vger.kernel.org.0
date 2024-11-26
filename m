Return-Path: <linux-iio+bounces-12686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43A9D9AB6
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F196DB25AEC
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670721D79B4;
	Tue, 26 Nov 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RTQErcbR"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461141D5CEE;
	Tue, 26 Nov 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636403; cv=fail; b=q7i66ndEOfNIQTKsrJMLwO4fojWReJ2yBb0H9cPxUSJoYjRW0vBEQS/nIixWBOWQIA0nncrFSfMjcADJvzGK3mZ6vbPCoB6LMJowCxhcOEBDsVVlVmAbFQSMGvBZ9oABnPizelT9oaxNwHdQxZJmhJ7ZN1IEw6/Adl0v9GuidJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636403; c=relaxed/simple;
	bh=anotIRYwtbRSQfU3/ZijzGIBJmHXk7wG3amWdmqZBV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRHz86QhJL5i9xIVOETJXfwfqaa/cTu5PN+IxENRj6YVUknwTXO+yoF+STZBvksNDQelnqnl5TAHb2OdPtcH07owDeX5rOZq+YfmR1E5exJoUAG4sxJuR6ej1zNYjk+50yjIm0rBE+FkehcPubfwPTKTe/7lgx65+j3x7JsHJgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RTQErcbR; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9lJZxmBxqH+rWY8/QrPl36pCSz4stm0/NDMmDQ0+bpS7MsUc4uRtlBw8LzBsfKDAFCLEpfw3DtQA6OQQl3DNKb32W2a4JrJaCHSMIHyN14W/IgwPlTubR5rsmRGBNf42EUKz4IZLsh+S3OTGmrJp5hWemm60HP94sec3ONZozUf3MIR6wRZlf6O0tUCQ/adTF4TyQZQPRahjiLwAK2m3vXvDqMTIajf4rlH2spryc9+b+AswYzADmrUpS9PwnSVhbLAHWy7qWyokLZgvxWRcZE9pOjh6xun/wdKfqM81xDAFLpqOLp1C+7dxZtTcOUKJZKL7dKIVS1Oy/A3sxYWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w60dWKTvlDTi6JfIzlCH8vUtH6nRIsNK3tWKG6UlqzM=;
 b=vRGE2fzpHwwu/aidMdzCIuFh5rxGMKeYs7GUFvQdtPEL3n7yca1jo5wmr4NRPNFaWQi1UB2hbxFF+JnbEOC47qsYKl4RyJPRRmoPKwCDBOlltjeznaTlszsYCbi0Kxcza1YCmRGZgNwAxQLBnSHNqMCLY0OCGAzbfcuNYPaEW+ZP4QY8srlnxjBLecemVCtOBJGqtA3zC0wnh9/Rp8Ga6ABICekX8I8986cnzik8PQ65PSXxZqZnsb3H8OzitawZYFpVCgillqMHRFwPxsYCZgeXOderZCU8VgdUxQazdEfKLt90MUn6SjawhtftVU0WhqZq8LkH9bBtodYcY9Iz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w60dWKTvlDTi6JfIzlCH8vUtH6nRIsNK3tWKG6UlqzM=;
 b=RTQErcbR59wyByIpvzRPPFzG9kLSYHYlOAtzsOYinblkADdCkKw7rv+bu5N84XtTV6+FOjmcnLeNqpOE24jWiBOEIdeX3Rey2EbfME77u3xhu/vnWMccVytHHKjG2H2lB3/t1fQoyyeGkeVR9Lh6J62gt7mE676b5Xxbaar4VYM=
Received: from DB9PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::18) by VI0PR02MB10993.eurprd02.prod.outlook.com
 (2603:10a6:800:25a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 15:53:17 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::42) by DB9PR01CA0013.outlook.office365.com
 (2603:10a6:10:1d8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Tue,
 26 Nov 2024 15:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 15:53:17 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 16:53:15 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 16:53:15 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Nov 2024 16:53:15 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 69BD046A;
	Tue, 26 Nov 2024 16:53:15 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 84FA418E1ECB; Tue, 26 Nov 2024 16:53:15 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Tue, 26 Nov 2024 16:53:11 +0100
Message-ID: <20241126155312.1660271-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126155312.1660271-1-perdaniel.olsson@axis.com>
References: <20241126155312.1660271-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|VI0PR02MB10993:EE_
X-MS-Office365-Filtering-Correlation-Id: 309d418f-d25b-4341-d59a-08dd0e327186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?enxUYn3IOLsx6dXJ8+FO8COC6TaVhB4ty3MSvstRy6gNU+Dx/0NkKElFE3tU?=
 =?us-ascii?Q?8HBwZMou13Wokg0GyLYM5vJSm0B9zH/xaIb+iJ/toauWvrs5Nvh8wGrx3lF7?=
 =?us-ascii?Q?AT2/BSJIxLbBDjx1mH4NJPf4b5WSM2NAW9Ha/fQzyq8yEqw4sUIP8nQnIS1T?=
 =?us-ascii?Q?jxRoLZZ/NvmaTY5M0+6MatS9FUWgu6MkRqTgViOzHMWkWOeStwjuYpCMYGJO?=
 =?us-ascii?Q?GUfG0UnGcgkItWipUx22xqVm6oDkwDoAk9LK9xl0ItRF6PYT+S3fBQ+yVoO8?=
 =?us-ascii?Q?9xsYfqO9GHXckILdxIkkin0YAafYmFiKYFN3Tbz93tEDKxR+Wo0CQVwpeZ5E?=
 =?us-ascii?Q?LopKff3f708IHCjRnSYoq0UxyWuTNBfk2zbrzUvVW5CbOt+HsxJsWnHuYqUS?=
 =?us-ascii?Q?TsoLmWjU1NHCnU7pYAM3StCwaTaTGj5orMUkmkQFBSMOpeU7aFpdUHCKeV1t?=
 =?us-ascii?Q?KfoIPKANh79qQBRZraR97BVLUd0EqOBQwoXI7h4xCSD/GBIlDC3XA7+GGSTU?=
 =?us-ascii?Q?3nYhemNusKopyRGsDmY+xh6IswJwZ8vQPP/BtL5s/sIAfQUk6kI5ehmIEDPI?=
 =?us-ascii?Q?b3vElEgrq6YPh/MY5Kky7PHJYDFRyDShbE7aV4YDxaBNuWtQSPC9rsoIfHWs?=
 =?us-ascii?Q?f1qwu3BSjYeO3ww488DQ4vmwNR9o4Gr89hR4o1BwB+QS56/44J+Z9oph/CaT?=
 =?us-ascii?Q?mcyTdc2LcH7Vy0/ZcvzxpjxQkAV8ezj5gkytbb/rQXhGuorgEg0UA8I8f/mT?=
 =?us-ascii?Q?EAXt6mqJBn1eCE2bYHDRsP6wb35+bg2AWQ3Qy3aK7Ugh0tGDKCYjFK92Yi/D?=
 =?us-ascii?Q?86dnXuhi3mhDL0GC5KAQfJoJDNXY2zP79wDQYul71oo29a5St4To8DUxxJhm?=
 =?us-ascii?Q?K6yphbXIHEUOMULOev5LutN0+6b7jETDHn4vlJKM9KYoc/VC/AzQDr8udSUF?=
 =?us-ascii?Q?JjDcSfeHUcF9hbd6ReSrEmE0IFEnO+1lJYQOF3yN+TvqHRWIHn+bLYji1Vr8?=
 =?us-ascii?Q?OSWLZD/yeSds4IlQo90MKT2Wkrnm4VL+eY1J18VDbPSvoxfhy4VLuZSthOey?=
 =?us-ascii?Q?NpbnFoLWuHNS5e3xH0tYllpKiHO3fhsSUpzYPqS2GWVcgyaMKgLxhu9j3hTo?=
 =?us-ascii?Q?HCo+jyg00Xv/nFTlaulEOozxbsOIFjU8ANh9142l3+ALPAdsWX2ryrM/CdKQ?=
 =?us-ascii?Q?waNXJKixqTPbD/7v1eYEDQUbHO1/gc2mlBZdojP4I3o3PfBpUXO1lZt0YzR+?=
 =?us-ascii?Q?Ib3CJTc6xQThIwb5t4+wGeb2QfCPV1Csiec3G2cAPsEWSqd7KC7qENVJlc3w?=
 =?us-ascii?Q?UgKt9f9wOtSNZzv8m5NV6d2CX8b88wdG6W+8Oy0r/0OSFsUiIqOOPd6zrmsz?=
 =?us-ascii?Q?TdIv0i9esZz/0W/ZhGll2wHbDrqIGXfH2SLaAdswkpANXfn8EQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 15:53:17.1669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 309d418f-d25b-4341-d59a-08dd0e327186
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10993

Add devicetree bindings for the OPT4060 RGBW color sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
---
 .../bindings/iio/light/ti,opt4060.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
new file mode 100644
index 000000000000..568fb2a9b7a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ti,opt4060.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OPT4060 RGBW Color Sensor
+
+maintainers:
+  - Per-Daniel Olsson <perdaniel.olsson@axis.com>
+
+description:
+  Texas Instrument RGBW high resolution color sensor over I2C.
+  https://www.ti.com/lit/gpn/opt4060
+
+properties:
+  compatible:
+    enum:
+      - ti,opt4060
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@44 {
+            compatible = "ti,opt4060";
+            reg = <0x44>;
+            vdd-supply = <&vdd_reg>;
+            interrupt-parent = <&gpio5>;
+            interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.39.5


