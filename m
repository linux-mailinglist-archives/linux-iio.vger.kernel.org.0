Return-Path: <linux-iio+bounces-13610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A09F63C2
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 11:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24221894B62
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1A719CC02;
	Wed, 18 Dec 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="i9HyiQtS"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148F184556;
	Wed, 18 Dec 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518927; cv=fail; b=jtpIaKkTAHSdVZ00VTmKiklMShA/6lY+vr1fu1xXYTKHrQBIqtOQ80H0Fb1gek/r+V8BKnIZ4EU5ISc25AOz5DiQTo/Mf3GJK7hqoksMz7MPNGjS2SKq8xGSVEAae+ngBeSGiCK9Q2NwSbLjssrIVI+1LDLZnR2hKY5I/p07xzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518927; c=relaxed/simple;
	bh=anotIRYwtbRSQfU3/ZijzGIBJmHXk7wG3amWdmqZBV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQJ0OUJiEff7rGLhDfx5y66RhcTNStijC+zBvv+HD0gPKhTu2UzjN1gmTtj2UC9yvMfyH+wQ05aRdNf3qHnVyWNQogkFNPP+eFrDCASB/uFuQeEsX2orLYWZSEOdolvarC2UyNAcExe3DgQX8ghoukpPbHCnvsxGv/i5yYeuiA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=i9HyiQtS; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDVIOFpWw7O9WqmIM+G/y5v2rUjOo1HGQ5Xv7Y5mGloAmCKGzLUgoITbcBTzL3HE+h6NEzft7/uDp6S1zfjU0ix+hmZ9kWw0enxXbmG/SmtQFgacgZZDjyYIwZC5f5rptHO+KAwA+vmDcmGVtnpf3T2SR22bdHb+pgoTcpBS1b8SSk1fN9w353C13qPQnohebgh9gEfxCPybL83htMEQRK6C+OzPpnN0F2YTHzenJAufLCZcoQkGsLYt/k5fT3OEDdxa3VRlTcrzftl1krMxUN21X2G0TsEJlrY/C4R/12EiFqXym63uDmstaH4UlgDkNvNbdloyPsiuog7BDtmBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w60dWKTvlDTi6JfIzlCH8vUtH6nRIsNK3tWKG6UlqzM=;
 b=vV9rwOPI/zF4cX24WwubuxZeQ5lDdZNeLJLQLO7Dvt9vU2skDV5q0HuGPXjMVtgZYnWJsuejq+I8Kk7vlMjAriT+sCN108xhVLyjqbEmYa0/uDz+G1yu3fVf412RHeKOWUe9MwWYU82rfz521UvZjCMe3wDOMGxjKmP4LaQU7q06J00NOtU07jRpyqLX1B70iIzJ/IwSX6boXtFaKs0vLrv1DL3ufJQ0wm0c6/ycCNMlwls+v8v7wYNNd24XP1MQkV9aJjuNUI2KgmtjyRuPLzV4RLNNfDQGOjN34q+cy1uDmAFmG22H6AteLGrgNJSVFzo6WtJd8MWRpyxNZBooyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w60dWKTvlDTi6JfIzlCH8vUtH6nRIsNK3tWKG6UlqzM=;
 b=i9HyiQtSgghlPaPUVo4SCVeTBQQE7g9/uA1kqo3a+2WoozsDrNRDYXKcVuKHjPgtMx0mReFQmFr9scRRNC/fOksKVmV5Y7boSAXjzQ/vdovw59eqOwK3y6Lc24+y4XmKVJzVAcSUBavPUfYwIWC1dEAltK97K+O+rTey1cIfmGw=
Received: from AS9PR04CA0117.eurprd04.prod.outlook.com (2603:10a6:20b:531::22)
 by AS8PR02MB10145.eurprd02.prod.outlook.com (2603:10a6:20b:63e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 10:48:42 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:531:cafe::fc) by AS9PR04CA0117.outlook.office365.com
 (2603:10a6:20b:531::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 10:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 10:48:42 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 18 Dec
 2024 11:48:41 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 18 Dec 2024 11:48:41 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 9DA48149;
	Wed, 18 Dec 2024 11:48:41 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 9D5DD18E1EC0; Wed, 18 Dec 2024 11:48:41 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Wed, 18 Dec 2024 11:48:35 +0100
Message-ID: <20241218104836.2784523-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218104836.2784523-1-perdaniel.olsson@axis.com>
References: <20241218104836.2784523-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|AS8PR02MB10145:EE_
X-MS-Office365-Filtering-Correlation-Id: ba62433f-3281-4344-1ac5-08dd1f518a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YDTnbYmRUU7oiMSrPeTpqIngVjL4j7SgEoO9NWqMvxQbZ7yGwI85IzirlIYH?=
 =?us-ascii?Q?rVifqOe6Jw2++GUxZo0GHjUSJUMRLEwtEFFyV0f/1xRVo/nA9a/Juf7ldp0r?=
 =?us-ascii?Q?4mjEQPEREeC4pYsKsQxRBb099n0Oicujc6NXeDHwjE6aovFsIJOIQYEMMhEA?=
 =?us-ascii?Q?zjjeh1+pUtZGsO84I8jB8UZ0KAuRp18X0STYAvhN6J92qAko2GLrg9GxEvFG?=
 =?us-ascii?Q?4NHLZ6UPqt93CppgW7ICJEy1gPmJbdNy8lBNQ8z3YUeTcHB+BMBfqlfj8DPD?=
 =?us-ascii?Q?/vZqqKC1JU+vVMTPBljqpMGJBLt4AurFB6QhyC64iS+LMscG9ydoD6i+pLtz?=
 =?us-ascii?Q?aTdp6KGD+eHfi603243tMMbp6f4o+xU2uxtDsGTUpFmrhyyYmjXQPOCCn8Jx?=
 =?us-ascii?Q?epML2Qltl6uVGiwih/FMBK37uUKrnbX9BsTA71p9OVNB03ShAiKzxcMaM2Di?=
 =?us-ascii?Q?LZHhkjiq9qhMKXGIgy9njfEwQzTnLYKkSiM2nfBipVWiS/DmzFfcIHLihN0D?=
 =?us-ascii?Q?J+gTQaaAofUYWRMKQSNCbElyI35WnUeFwc4oBvBNhSzI7QEr5CIBnH7w+XvV?=
 =?us-ascii?Q?rcb1o2VM3399DE5OtBXByLILKbohI5SrgNhXE/iNqiv+fVXjzVVMgSWmPNUS?=
 =?us-ascii?Q?+9ofPSYnkpLTvLVoJ0sg3I+xr17Mu9285XXVuMqiTEe7ipp9OdUPGZARHlZi?=
 =?us-ascii?Q?RXoFxhqTaIzxyDA+Qy162TIxH4Uo6pzMmk6LEuDWVvtIqaTmYmSKsQbAVYKn?=
 =?us-ascii?Q?iJPgn1pXGjVglv7qItnZkdvpJhoeLyn/Y5nbfgA1njYPSeTSuTGTHlL6byue?=
 =?us-ascii?Q?NW836kPBcFQqsIoAZcdQ0etWJjKpP+7mmL/Uc9WEKUZs7i5gGkG2a9QZu8o9?=
 =?us-ascii?Q?nEOiV6HcCNilZWFijOI1m1pHFioNzxhniu80PF/W1rJQbbV8NOD+tj0Vsu6q?=
 =?us-ascii?Q?WEZzqVyBJRq7PNrWODg0K7DE78bICnxX+pd+avhH+EXfwf+6ax+E/jFjGB0E?=
 =?us-ascii?Q?4MYOvc+m7xnNI1hFJCRcxLGzP/vu0mFz8xZRwHK7S160zQs3y0XrZLKuNSnM?=
 =?us-ascii?Q?OMseUAxZ8tKdSywi+P0MIT5H66+tjFDQcyqimbvSJ74SfbJwwmsa+FtRFWV9?=
 =?us-ascii?Q?+Kkn+HAQPQp+vVWyAecoWMZVUjvo9ghGEq8/BYap5ONjq56tD7OAAuJzHVTE?=
 =?us-ascii?Q?1MtPPDB+GTue6VhaCjoxaRgEgnK1x4Q9EopShHiBC8SSiM0RgSZ+tuJTNR/P?=
 =?us-ascii?Q?313UzEJLk37Ua3Ou/1bMmF/KWuvDL501/cdW5NxATJYoqyNjrTnLS+E72lTu?=
 =?us-ascii?Q?XVITEG/tJmcE1S8H+uWjGWhz+GaISVW8prGubH6fd3LYWagPZ49pztmMAxgg?=
 =?us-ascii?Q?Gc2BMnojalrUOn4SVLGU/bNDmPLcU1aeqZSKqXe7Qjnyi+jkir7cYSG1iH/u?=
 =?us-ascii?Q?bQoku+7OkAE=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 10:48:42.8172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba62433f-3281-4344-1ac5-08dd1f518a3c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10145

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


