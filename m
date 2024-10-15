Return-Path: <linux-iio+bounces-10634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8FE99EFB7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 16:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B79B21777
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAEA1C4A19;
	Tue, 15 Oct 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QWkm7Nyu"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083621FC7F6;
	Tue, 15 Oct 2024 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003050; cv=fail; b=WZD45bPI9zvKP4ZiCBzjdNL9NUC8rt/HODCrBMmq9KRO+mBK2wwV4OAzFvUZAgu5kwNeQs/8E19wbSUQ4e9z+eTteB6fEInpN4/3h+QKqW33lvxHEfHV9OuDh5UrRV6/ppfHl76hm1mEqzdPB0VtxIWazNLtUGkHbFosJuKLG6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003050; c=relaxed/simple;
	bh=jBW9dRb2Q7fkECKRbwQaBsPqg3TX84ry26Q5ZmRVplo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MB6EwflMfIglcCbUMedH/Cs//9CblGcP2zu0DFdu8qnafQ1zpg7bKCWCjyStQRa9sEjPMVCX7Zc/jFWZOOV5wBNomxA3wPj8naHwCHjvet0TBBod7fYUr13X+Y1L1w7dlddm77QLQtIfhF/MWzEIFrMl5LF0CrS2D1FZI3Ta61o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QWkm7Nyu; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOZKMGfqt0Q8VFfy7Xl8eQ86YK4PJ2eAJnqACk7k5I98Prl06aG1Euam6PyMUZg/hlC6ERbjjYTGYyAmJstN1w7kXgO/MeK6NLALSF+7Jw/Sgintc2ZuexSZNAyPQ7fmDDPHlbumOfmiwahwvSmb30DeQyqVohD3WGsvB2cq4ZNldHeP7DGpf9nKKDYTI4TubbkU/5V1bsrI0lYqWdptcsBo/u358Ik54B7Ei6D9RjCde7E8riWU6IEV7+8J2z2Wfsv7z46+gUXWrMP9SimJiBoso0iCRoy3/uCZJTpuAzdkFencjfJA2sXZgAiPdGg67KgwQArZa3XyLIh33KLlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb2K3oIaWi5yrqQaC9lyjmZ5eqottKylRr1oLhFtCGc=;
 b=tH8SBX+UbQdEfqgE/Fox6nIcZqO8BQTelvJoLLh8wms47E89IszgIU7iuVpF+rFN1PS4nsMwCmtNSccZkpI5oaHuj1gH3Jk6TR9stpmhva050KVeqHSjIY6wYkYxEOgbf18oiGTz5SBSEBCL2JZXQjo4iCDLdSrrLMjC+zt2W9HZszE2rpQC8j5IW71vzY9Bh5e/jJCUG22ZPtISPx+NLAJElWU/k4mi3vAP02RXdLjiJxv4Sh3VTK5mTyR2OF7lkzCdMv9npIed62zLzhPSQEmJcOPcwFN32b7KFhrblQ2kxLnZUEBEaSQFsFD5CSXdAKQC8251baJKe5HuiO1/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb2K3oIaWi5yrqQaC9lyjmZ5eqottKylRr1oLhFtCGc=;
 b=QWkm7NyugO/rQz2YclNqJKGFJCZ46jd9SPapRMWOc8acR6k6DYRRZDL2m3cAUl1n5at//ErY/GNy3h3wVLGaeKoSqktyL69U/f8eeAV3Adw0KK0RKqvvGp7qeypAoz3LlwtxqZk3m3eB9nfw5kEwlVPEPL/OJXCxtqeiwedvbM0=
Received: from DUZPR01CA0288.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::21) by GV2PR02MB8577.eurprd02.prod.outlook.com
 (2603:10a6:150:75::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 14:37:20 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::9b) by DUZPR01CA0288.outlook.office365.com
 (2603:10a6:10:4b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 14:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 14:37:20 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:19 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 16:37:19 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 54D1A13E;
	Tue, 15 Oct 2024 16:37:19 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 515C118E1ECB; Tue, 15 Oct 2024 16:37:19 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Tue, 15 Oct 2024 16:37:12 +0200
Message-ID: <20241015143713.2017626-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015143713.2017626-1-perdaniel.olsson@axis.com>
References: <20241015143713.2017626-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|GV2PR02MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1ccc7e-25bd-4611-ea0f-08dced26e019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00aLIz3HEheg7IRCeTsuRnhiMKI2Cf4zg1dEKOfVZF684yIGeZWcdBFp9gvF?=
 =?us-ascii?Q?ykNfAB1jqzpOrYOXnab4EJNn4KfFKsmZYcdIpDbZ30vcZLR4C7kceH3GnTLD?=
 =?us-ascii?Q?zXblgyMqJm7079VeGLOFcbfuburdCh32bLKVipElC0aAaWXRcSsuMXpGEcVZ?=
 =?us-ascii?Q?sf7JKhypJBWzZoH082DIYy2ttf4ba7J0CkntND9PoQMoK4I/ZvCcb5JI0ckf?=
 =?us-ascii?Q?bkhicKL/YCHGo+JPVIrSlsafjshmUA6iexOyFfFSuYAu98AHSS8roUPZv37J?=
 =?us-ascii?Q?Py4Ac7UTFtpOP5iEYjxri9yzwNsQSzY7lzl5AbWVsn2KBNOtYChp+GLtoQyH?=
 =?us-ascii?Q?7i0y4l/lQI1RpBHXzl60kL2O+qituGRNJAk09nnnprZZosAh/a3Dx8fN8NzQ?=
 =?us-ascii?Q?X5Za3z3QOJsYyR8YNuS0xLX+uQKs9lAHb1+MPils5tVnaU0psAyZmR4x68vY?=
 =?us-ascii?Q?K5Y/PuTFeavnKk5AicTaR1ouAeWaN1/7dp6Wh2mDwXeEVZGwIWERYE+wfJTz?=
 =?us-ascii?Q?1bhyL51Z32krG3UJrp9X09MaBRt9X8s4HUhL6HBq1czwAyHzWr3JQFi9lShK?=
 =?us-ascii?Q?pqxG0KTEnRaKfa5835aJcsb4x0m6h36y+anC10jMnmLk7ds1n+3WxACrSqQc?=
 =?us-ascii?Q?q/gBY/covHfmB+x4ZgwGUWyZtW01gDdXiJB2bboSnY4hHnKJz92hndoKndOy?=
 =?us-ascii?Q?Jyzbzyh9vo4tyuvJM+Ai+PGWALyEBcmBhsSKKyvKGxZgv50JsFZLMRJYPdG0?=
 =?us-ascii?Q?TN09tvaXK11Sb4IlfM+OGpzatVigopDPBzDWIMrWqkZa5jBka9LpdSrwOnop?=
 =?us-ascii?Q?t+ghDlOZy0RJS8aJ8rbjwE8Q1p9SWYyEhlFbAY2l5iNtCwuCvaEy/UnvZwZY?=
 =?us-ascii?Q?RdJ1uiIvUTQlL74KdauR6w4skJph6X4ViJ0PMgE9wD1RLcgUHizH/DqAkctA?=
 =?us-ascii?Q?gsSVPJrkKCRKdo/qOpajHA1JUn0Ie06hbEbIYDx0fcnbvvhjLYR/d8PQP5bF?=
 =?us-ascii?Q?7H1HonRjRo6JI/3pqqzM7fmQkxPXMA6hFQW6rXrDrgnIgpCOtKyzt4lknJJP?=
 =?us-ascii?Q?2FE2Rn+xCTAIsWJvYaZCOXEFMnFWWqOjLbcW6OUnqXMPLaj/dRUVdseiCiql?=
 =?us-ascii?Q?zhrNRWKlrsHW08M9ATWCSP90UTyUd5h/eOOjdRY/pMUllRjJMoPiMrAk3u/h?=
 =?us-ascii?Q?/dXnOUrS5JGkipZxQWAbzKdi9vp4gVinPQEjYggdnK9SyDctZHikIXXtC7Z4?=
 =?us-ascii?Q?TOmrJEbF4CRnu+DezQbuJ0i2saYRNt43o2x0jKSQR9RQu3sj3bhrhwDhqFek?=
 =?us-ascii?Q?Da9qqHKBgM+b6eIj7oDZUK9d?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 14:37:20.3477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1ccc7e-25bd-4611-ea0f-08dced26e019
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8577

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


