Return-Path: <linux-iio+bounces-10665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8701D9A14D9
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 23:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5D21C2219C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DFE1D2B0C;
	Wed, 16 Oct 2024 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="HPxmUMjR"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F11D2215;
	Wed, 16 Oct 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114512; cv=fail; b=NclI7+hk8jmy4l0SeVI3VT3XjBXjfWRoc906THsOBptR+cbvDOr5O4OsZP5Nb5D/m7brylAQijQlsAtJoNWh4/4BcyoYlEq+QuOPuUK9xzz0/NKI1nCss9wz3LwHHb2ocIOznHbEAdQC3ejDOE655P+WhctUNyAekbf3q9eCOfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114512; c=relaxed/simple;
	bh=jBW9dRb2Q7fkECKRbwQaBsPqg3TX84ry26Q5ZmRVplo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOVUO8lgJfbS5RIm8nyDIcC+wYBh3UxR2SWxQ9RH1Oue3cyKnxxla2WDGt5QrJ9CBdCz7uGQtNPiwI1OakfVewSE3AALzV/Xb1P7zTfiG8wa+U4FY/0yUfVy+63/e358JOiDIoBCjn/vK21bUYcVzke50AwqzsfTQedxSaNVBSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=HPxmUMjR; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9epY61b5j4t3iQShCfzVn2uRtmazUIu7megdiAwsxwGirwspgxjBWUcJ2ELvquiRgcoxov6+BMdt4Uux+ckiL8gqj3m7U05B23wkSE/98qGv8/45utK3jqTKaLhC+lDMh/t9zTkgx7/o9SgPpShy+KqTS0l+fx4WQMiXu0tHKwHKmINZNaxCNJafeSdbIG3jfFHi4YI1/QfPPrLR5VqDfeOK98kYcZ96s4itF/AiG4BVwghE3mIEOkLzs7EK+YoyYlaU903kYuE15mzoAzf5/d93EQ9GQwZvLAhm1lNaxe04gp1sJ34tWm2Wk5MsGXLZJGkJBgglbzlJayZ50AmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb2K3oIaWi5yrqQaC9lyjmZ5eqottKylRr1oLhFtCGc=;
 b=QVwrqSRJdzYhQCsnROTNkXUda8E8ylUkcyUtcWeM/KKUYhzGvtHSC2diarAE5BeK8WFkomPh8hzieEXaDicdzEd4yRxt5WybiIlxNLZJwS6HHkI0Om3EaEHeeuJBUjGufC9EZVh1YF3wfXD5NxJiyNa0J6d6v49rIr/qazJ7cSmfBG1R1KHqoU9lD1VDb2f9SWKjoRyqHfT+ymA0Wv3qvjhyVTnQJZREXEIXMKynnm56I6yMUI/O/+FWbUwp+yvsJPksVYgTy/U6Ppa1qMmD5UB5V3aGhEsk36K+NXy0l6VWonvFB3+X5WvGKT/li5fggJLX0UT2wOe4TRE6fzUbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb2K3oIaWi5yrqQaC9lyjmZ5eqottKylRr1oLhFtCGc=;
 b=HPxmUMjRWbL71I+n2Nk/Pc4R8UFgfGQ7bi/JGjpVwIM5/KHUYMqmr4pcxCrG2wnWXg7Kl4k9FoWyp4SMpFYD0lvAU7xZzN38Dmp8IUwiOUtCbbzukOFMBfCp8HnCwUF5/+eWA0S5CIRCTTIl52dDxLqLJs3UOjsHGMVIpHPndTU=
Received: from AM4PR07CA0006.eurprd07.prod.outlook.com (2603:10a6:205:1::19)
 by PA4PR02MB6589.eurprd02.prod.outlook.com (2603:10a6:102:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 21:35:06 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:205:1:cafe::a8) by AM4PR07CA0006.outlook.office365.com
 (2603:10a6:205:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 21:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 21:35:06 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 23:35:05 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 16 Oct 2024 23:35:05 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 372E770;
	Wed, 16 Oct 2024 23:35:05 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 3447D18E1ECB; Wed, 16 Oct 2024 23:35:05 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Wed, 16 Oct 2024 23:34:08 +0200
Message-ID: <20241016213409.3823162-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
References: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|PA4PR02MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc11228-a5ab-4fe9-9046-08dcee2a6712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPJyOPdEKRc6d/iC6hq2YC45S7KFv4snw7IrBnKgQwDPDNaZQ0NNS3KlXRO7?=
 =?us-ascii?Q?6z015ETch8+8yaHCJoslnmUZJmOYI5WC5Ppm6c+TKsydqs9zt8mgqKVIuePX?=
 =?us-ascii?Q?IEXdnrti1zpJEWmCT/XHbkbkZgrt1J2899XbTBQVusrvnAcaYW2Wrn1pCofW?=
 =?us-ascii?Q?vbYcGjY37w5SztUWvjIfYYIA68YNAGcWMVb69s6Zy41S2rwzr6vAatciPQuT?=
 =?us-ascii?Q?xyj7eQuV5ra8eu8xO+xgSFaRYNBYxLvtYeIKG2LcDCzkrZf6KdUmiNy1Hrg4?=
 =?us-ascii?Q?ftitH3aaG+4Qwjs6Vztwuo0QXEU47kpcXPDIWR5fTVDuSbAi7SyyF+o8ULds?=
 =?us-ascii?Q?S/gqcVY1O6slDLFZHdCRcew/hQjCv52CEyhDJa5FMrh6D+fx7KC/Dwsrpq7f?=
 =?us-ascii?Q?30Sf2G4HhizLCrb6r5Je8+kU6qliwNRbVUFPQSGaYSI55gxE0gFINn2xlNCU?=
 =?us-ascii?Q?PnER8T2WXd4MgWFHzCRgmk8lFA7s7R3brOd2/Yfx8qoN7PIRS+Xp0kLfg6u5?=
 =?us-ascii?Q?dRHy5Vz+C931dhKgxE/NqFnGx+DwgbNoZL8pELuE4hlZf/n1bMAVjtDcRon9?=
 =?us-ascii?Q?R0L1fV4Ww+W+6JdxwhwtH/gJ9davNgVbyP10nu/+7w9BKAzTul4jjs7BMyXo?=
 =?us-ascii?Q?uwEcpOCgHZ5t5Ds23oHbXjSdIizMuihaz/yAeawu9URnTxpW487KuuCkxmQq?=
 =?us-ascii?Q?zAGKPm0QPvKHBU4drc3fVZRSEy9j7bRI7yyiuFZCtwCgEPRC+D2Cnual6hCL?=
 =?us-ascii?Q?LTVgRw8Ia0vnp+Mh7xGGa0BqMeEmz5TIeHALwn28vzdT+a26mel8+ZS9oogx?=
 =?us-ascii?Q?P44PY5W9kovwoxB18H5YZdjW0pm69cZvYjo4MiFlzSj0WPoQxNpoBzboFrAU?=
 =?us-ascii?Q?b4+zMDyHl5st6oPsfO+EAxbwtL5tQUX2hkkW2zaiiP/n1k2yN3dtf101tEi9?=
 =?us-ascii?Q?xuSMF2WEiIiP+ce+RdMNicoxGf+hSjNz5wAmzfjcntnxrGcqKxOytU/t0YM0?=
 =?us-ascii?Q?kVoHVNfnZCAg4fao7QQZGWy7+IHEBoC6TWjvlteNC3IfNp6QCHb4Avk3scAE?=
 =?us-ascii?Q?arVU+azZ3Ebt++xL2P/G+Eo5HzbMwoD2r7/YML3g9TEG87X/wZwiuhg1Iquy?=
 =?us-ascii?Q?Sw6XWGZz9hEBxXOZDzsnofo+Vb4bA0kQuhUY7u59KKxIFnSG+UNWQIYC/YRS?=
 =?us-ascii?Q?jKwOSI0sZj07rLkC+Kra6Hj/g2UeQBj/UOOiY/tMgzGYwW1inK56f6MKKAew?=
 =?us-ascii?Q?Jjp1JfjoIxLpJ/czTC/B7leLoquFTY6HAq4c4FL9b3D4YC2DCRM5HYBa+LRQ?=
 =?us-ascii?Q?VPT5ruP0K6IWtU3mAt4MWVrirCRgGz9PjnC7y67nqc9J7i8zfO8KIm2hWwuH?=
 =?us-ascii?Q?JCAssQg=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 21:35:06.4605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc11228-a5ab-4fe9-9046-08dcee2a6712
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6589

Add devicetree bindings for the OPT4060 RGBW color sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


