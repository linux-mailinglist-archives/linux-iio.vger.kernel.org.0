Return-Path: <linux-iio+bounces-10182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931E99187F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20681F2217F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03153158A3D;
	Sat,  5 Oct 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="K0UlpMx8"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012B153598;
	Sat,  5 Oct 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147093; cv=fail; b=diyeHEQQHj+mi7HvM18BK+sM4KI+patSXQAWjaPlYh5ZipnDawKHGscVMXa8mIhYoVQKHO+EgCskyqGSkuuRg2whCUzCgHuogbiVpJzZyrjv3OGpHim0jJeRsklNOKqAm8ffXx01hdO7OdDgi8+JU0r6P0LCltEVHPEDO27Dt4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147093; c=relaxed/simple;
	bh=+iyZn7I4LrAXkPDQ54iAOo5Bzt/hzHL/eB+HgH1FvsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pffEX3hSmKE2xLz24Drp4mEtfRO0Pxtdz4Q0hYN2ZD6XHxD37/z3HMwq58CHHzgF+tHKlPP4BOrOh1A0LSClCwL/lByFG39BNq1vevr77AXJFn2xIvnGHJjrM97bAD6pzhyRbeyEg4sJ/Tm75wdnhdpNwezi9u5PwWmNSw4Y2KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=K0UlpMx8; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgms+Bu61UbpSR2hNI27WME0qGvgF8Lrp24bu613sXSUQPXCxLQKg73j3uP2iUOgVokghlhbPM7FIrx3NDV3IC8DU1fm1Jho9tSzgKWRFVFGE1xou0rTM6uSIcKRORs5yB+T10ezELylqbU+FK2vxxW8FunWRnEnbYg2/1RYHKV0MdrJT2jYTRpbZ/Hp7zrYVkp/MzKDeV9zsxrgKvvrT6PsfrJuaJvlienMDzo1nwSh7ETZj0Tsx9ehGGg41+DTScLV3Bo0Y/0jPkrSDvY7Q+J9DvdY6SVwMVNuwGpwYwCoiHzdu+Baop3D/5osJBa6mo3M2WTpzEiW5lyP7RCprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPtTwyoF0eUlXy64+pR515LZgl/+zxHKRIDg75ZnKdA=;
 b=kO/VdzHHhStN734EvAk8SNJNUxTdZbUZ3sSJUa45AYNb0rg9b81x9WiXUeFHNuMK755Wb362pfcEMk8y2LEczg1y4EaqCckZXELHy1uYO1HuiGGNlE9RYeoNfsgBOl1Xm21wFl6cKknZTzw63ghjAOE5TBDcIkjVUbRl9RWtx9h9bI17PpmpVJv2VzWfkCLUxBc0kmPQDhNaSyRmoa2bKkQUBzaPphx7etRQRVPDr+sBu8ZpJGVujqfeeg6UDeaUXhFoyynOJppDW6g8RcQiGd/rpAWno5iDt7HIGKvczjTXOkoR1Faruhm8yWLWC77gLKSWDy9qZIGNAX0Yn2TyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPtTwyoF0eUlXy64+pR515LZgl/+zxHKRIDg75ZnKdA=;
 b=K0UlpMx8H4mYYb+iqewC94ojwDOo9q5mAVIX7VGm2LU0rYa9pjIGzfV9G0u5xr2GNc8SQopuMar6Wu8xKD3BhrWdG+MaU+B019TNcAy3YqBOZaoX9qsqjul3EGFEqFertRjTLrlztQPAYKj9RUdgTm28wMxv+Jb48Ool4bO426Q=
Received: from AS9PR05CA0233.eurprd05.prod.outlook.com (2603:10a6:20b:494::27)
 by DU0PR02MB8242.eurprd02.prod.outlook.com (2603:10a6:10:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 16:51:27 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:20b:494:cafe::c6) by AS9PR05CA0233.outlook.office365.com
 (2603:10a6:20b:494::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Sat, 5 Oct 2024 16:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Sat, 5 Oct 2024 16:51:27 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 5 Oct
 2024 18:51:26 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 5 Oct
 2024 18:51:26 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 5 Oct 2024 18:51:26 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 0AAF62B8;
	Sat,  5 Oct 2024 18:51:26 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 087A818E1EC0; Sat,  5 Oct 2024 18:51:26 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Sat, 5 Oct 2024 18:51:18 +0200
Message-ID: <20241005165119.3549472-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|DU0PR02MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3309b4-b694-480b-49dd-08dce55df46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZSxf8z3iZHzRLhqR6MuL5rsUb0Pl8w9sU6tZ7dwAtNisx9i0rTvSqrjg8ym?=
 =?us-ascii?Q?8hZ1nge8peT3VVtR+ZTiRUKNTBvbp87MIZA9WErLwCL1Yu7HATCfoIhiUFAU?=
 =?us-ascii?Q?UXy5j2SW3EuDxbqL/+J5DtNe4KTgvo7iZ9Qb86zulmoqUPKycFHvHFA3s6EW?=
 =?us-ascii?Q?Qwi3ZqGGmTAXteb+J0uzPYvMr7n46ZPYZARAMl8fNK+PTpXE7wbHV5JujsRM?=
 =?us-ascii?Q?azVmjkuI7FFNo71/csfvt3yggyBExsy1ceso3BIdDQFGNsjYusIdshGESuD9?=
 =?us-ascii?Q?OpPpKdysGM3d5lyTAahQJvEntDTAftePB8m5wzfGwHAJ4XEXmbtpj3BZF+yD?=
 =?us-ascii?Q?8IQ+mEdWOWyocJHclWwmHZHYXOhKL797cairZlzS0/56fSt4UJJdDa9TxHjS?=
 =?us-ascii?Q?SaCvoRQBsma8R7Fl2YNIQeNe5WpM6fQiYrbmCd9OXdnSDhJKMjpDV9OSCYLu?=
 =?us-ascii?Q?N1tNg5D8qjgqJ3huGJUzuC2Em4KXItU74AGqp125rdsQ21X2D0hh7/12Pi/r?=
 =?us-ascii?Q?3JUsSpyyHG2WStdh/zkr/tNZNzOXFPKrsgMFBM4tnF996aDv0VR6S5/R7AZR?=
 =?us-ascii?Q?Np7yNeqZ/ElJSup/SbWBOreHQDx9MUiFLpyL79Vk1d/uVIEVN0j86XXvW+P0?=
 =?us-ascii?Q?pK+KtmRZt08S26v2UZ2fCG5FM14yahCQwMhSV2qz2egB/Dr7CZWB+CM04yRg?=
 =?us-ascii?Q?3b7QNuYNsG7O5YFLjVchL3oflK47L/H2ncOYbtvC//fpokLCmyFSoy2LAl1g?=
 =?us-ascii?Q?3eYm3ahun3Eh68H3PqAZ4OG+1ga/MciNCaaRKK78aUBE51FwgIfR/a8cp4jL?=
 =?us-ascii?Q?LurH5NFZGFvnf/MBF74sh0xyFw57saXV61s0gDbIE23PjoUxmveXwMFlM7s9?=
 =?us-ascii?Q?kypKT0MjHyygdS+4sXh9IbInfaUsXrolrdEs2XpbliUQ+QdBT7Cr6uBDwLKB?=
 =?us-ascii?Q?fd4NCWrHbt17RIiqyPOYWPQXznrKzCYHyZwNp16ECe89V3B13tP2rjZd66hy?=
 =?us-ascii?Q?uzkseDSSCPkHejhrxilb3fwumEvQ/Ej7ID+uhfob0zFiBRr5DPPFKtj6JCOb?=
 =?us-ascii?Q?ctIxDjJOL0ZnZv3z7K48UTvUdizs+3xNDYOWQsYka8Adu1dHZoKh7/q2a2Gt?=
 =?us-ascii?Q?4hs/wcFVtLute5zP6RIrKxAUce+OKaOP9qk+emb5ywTuClUdxJgv5zyCSSH1?=
 =?us-ascii?Q?jGpaTxIKDIOSm/00/dc+rZwv0XMcUdkRQij5bKFzU499qiPqQA/TYCw2Jcy4?=
 =?us-ascii?Q?kbDyB3TtoFNRUPaisDtX85EazzMoNPxsCgMBTcACoTQt73k5qQRdo0JfLOVQ?=
 =?us-ascii?Q?OHHoHPBAJ6Gxcq4wKgS5Yvh2?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 16:51:27.4821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3309b4-b694-480b-49dd-08dce55df46d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8242

Add devicetree bindings for the OPT4060 RGBW color sensor.

Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
---
 .../bindings/iio/light/ti,opt4060.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
new file mode 100644
index 000000000000..0577e27db1ef
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
+  vdd-supply:
+    description: Regulator that provides power to the sensor.
+
+required:
+  - compatible
+  - reg
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


