Return-Path: <linux-iio+bounces-21358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB2AF97BA
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072381CA6039
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B6327A5F;
	Fri,  4 Jul 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="WWvyXwNx"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012037.outbound.protection.outlook.com [52.101.71.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE12327A25;
	Fri,  4 Jul 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645686; cv=fail; b=HceRKSAA4NuUSRtT2Jl6F4sohnl2XvwYBa50VDAXv7cAH+Fpd0yStq8j9cgRaRPWEkjd8BOkjgWDcnqb6QKx99P9EHiR6ukDG4QgNpJk7XVbqpqM2p2HswAARI3YwFknJKEh7/MziLRvV+TzL98B8pWB3q8CVEMEzcy9uDFs6rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645686; c=relaxed/simple;
	bh=xo1ATvoWd3a+RIu89EI3TQBARfI+STqw6q+g0QqTVuU=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=uglW0bdod7Z/+iyDM+VnVD2A1yVOKBbNsYvF0yic+pGLcPjjdwcV0FCwtdY2KIOkBBXReGJIX5i05I8HFX06aWTkzdMwFBYWFvpqF7HVsF+YDQciUSx8xFEtY0PkW3Uen8Z0JLss52G8K+dDxbv5c5Huhwu6qvlBGQN0b7Ad3eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=WWvyXwNx; arc=fail smtp.client-ip=52.101.71.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxb3u9auXf3pZSkmDrvpaCpNLuyDLzVb6u5N0J6rc0B7JGM29/AQx2B7PbIUcv0H03gJKHaF/tSkJ2A2Waf9TUz0/4W8o5D2Ng3cDpoQ5PT7wmR6UX9Cv3/jC2QmzeoZCBR+ELfYiFFRyTcwKaP+kesNpvko+UKlCd8R2+U27ayMG94DIHkIcm1z9ASgkUTHRX1Lm2MNCOsrVO/nkkzXNqbKXPrXr8bVuvyEsVwab0tcZpu6+9/iQ9/8be20v/YanyYhzr+737sCD55x8PCAUD9zUsmV3mta8mh76JuCVvsT3P08rETI9s5L9lHBbBMdL4P6q7Jzdr/qYDeeeIRpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZYKb/exBbSqupP2VVv9WXvgi6tJGHUDt/484hz5TzE=;
 b=Cd+3kPLEh+1jq1m/i8cKE8aauX83GrQurlO6hFboLCyd5RpYg9Af9L3/+IXd+vo1H6ZuxoYA7d1s4c1CboykHmGXSnK7l8MLXF3p8b+b2HGtVTp1PeLj50oyto0hj83kOarEIOcppm1fpOPY1SR82+WysE213XBPQ5NDMq+lsK82RtqA9XDmHaQ2Jh1Bdqq7e7e0ROxdplZnffWw783cwwCi9iGhefyusoYHACGQ/7EM9L2LwR+TdbyGtIQRwuh/qgspdtNUuhguaYOLHgEuWmoJOLPmfkpb4Jjo+/9bh5R6bPbFkOdypr8EHJQ6GW69qADNHsrlUVdGEgAOMb60WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZYKb/exBbSqupP2VVv9WXvgi6tJGHUDt/484hz5TzE=;
 b=WWvyXwNxyM11nZ2taAIBdATrx9M7bRilB6esT73QLyM7e7VEqRirWgSOhG+m1Vm0XUlNm8cCGgFc6fgBCHc4we4xA/4FEVhdc5tz4GL5k8bxkRpPIYHEwbcxap1RGc6sdnhOBNHNBKEoKoxm5PDX2xOY4H7JLOJnoNPgr96jugI=
Received: from AM0PR01CA0147.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::16) by PA6PR02MB10740.eurprd02.prod.outlook.com
 (2603:10a6:102:3c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 16:14:39 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:208:aa:cafe::5) by AM0PR01CA0147.outlook.office365.com
 (2603:10a6:208:aa::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 16:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 16:14:39 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 18:14:38 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR
 sensor
In-Reply-To: <cover.1751636734.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <19a2744cebaee57fe5349986094168524baa9838.1751636734.git.waqar.hameed@axis.com>
Date: Fri, 4 Jul 2025 18:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AD:EE_|PA6PR02MB10740:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7da977-25eb-4050-f621-08ddbb15e0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OLuJR8cPJer4eEI+/4yYjcmHZDikckwSdqBfPHjgoZvNea2sqKEwXLX+K/vE?=
 =?us-ascii?Q?LYJ7n4q+OukZsXJ0LqufkjYTheRV7QNL0oLM9EI43kotk7+5p7r/oS7eCh/l?=
 =?us-ascii?Q?a6DuXFvtyjEhO7ojD5A1sDgFnxUwxzRV8qsIGV24djXEqCzJXbCqq/er/h1g?=
 =?us-ascii?Q?2RQP+tuHtgxmcLk6pxneNfsQsQQsJ3MVYlS5nzUCywmrJWTxePckUN3A27Yn?=
 =?us-ascii?Q?NEhvCQ2/9s6CoqOBEeUPgg2EyUUA8zyAfFVePUnG6pUP6qfVBGeskmf9vVLl?=
 =?us-ascii?Q?9RYRzyVhdvKt0C9G9qytUpfF4qqYyQW0Fat77zz/J5gY7STIuKZs6jjrXfc0?=
 =?us-ascii?Q?+EtXf3Bar9vZ31PHcDM7B9FMrwQTCimm5eturR9gbVyWxvSTQ5or2Y7MOZlQ?=
 =?us-ascii?Q?/p2V/mRJ8YCNJWfRBtHXwlMPnN+RDrz3BM7/7gOwuL8VdG8TX4gcqW2JbEI/?=
 =?us-ascii?Q?17pdkxow/vFdmdWibJbTOfBDCNJFFstFjCwLw7psgAMl7XeNVhI0mY2dDR6H?=
 =?us-ascii?Q?AxxucFRLGWqy6c+NMfxseQObsJapSJjODiUQsaCSGAS/En3QjDxdK7aUWuNp?=
 =?us-ascii?Q?v523eW3fY2csFNsqMp0GVinFHVGgwIlJjJHckMwTPyVZvZWzTrciUNgXlQJK?=
 =?us-ascii?Q?rsqkxnzRrQe4NfjXpIZ1hiPNDbQ7104sfPnUKnu9rVHxGFzUxoKx5XfGiF2g?=
 =?us-ascii?Q?DnDg7dUU920AAfKDmCXNYQDX5uWEGvQR3FlciYbFvs8hDv3j1GIjrbCjGwW4?=
 =?us-ascii?Q?JemozTlzTeWGLR5aCVPFfl8An6u9yiDpvUDvz3xREvcEia6DeTcG2JgeeCoc?=
 =?us-ascii?Q?nr645yL8UjX5oSe9VMtAd/x3OOy+YffQUCRxSv/HycWhwyJpaMkvpsijCDTX?=
 =?us-ascii?Q?zmklmcdAqFnpTAUrnIi6O3/TEEr48VxHmwdjs/xymbvse1qzWhk0bAxzf+6x?=
 =?us-ascii?Q?03OUKoPGmyF3zZyW3bhZC9wZrtZrjiFE8OP0ngImnv6pBg26miHpGU0ky7L7?=
 =?us-ascii?Q?m3239SAcHLL54c78mO0q7AIKqcy8qWE+8y39Uh0r7ObDHFodiMNSF+RMHhK0?=
 =?us-ascii?Q?dVmwZYCGn8OXWGNC8BkOTGfImbwVWXa4f60iZw9/jClqx9N7IlLhr1mFiy2n?=
 =?us-ascii?Q?7+Tul7xr/a6+H0cUwvL/soW34qQZ1o4EDsChQRAVNdHrpjkXG367HK2HwWA2?=
 =?us-ascii?Q?AOqV7/ogg3KqFLMb9TPmzj7ys9S+ZxiYKrigXCeZEDXGD5ivC9n7BoZSXWe9?=
 =?us-ascii?Q?6y8z/NbnJCHvMJq+KLURIjwnMKb0W5Qf4D6NnDufZFVxCuVGKFFWU6NFf/oQ?=
 =?us-ascii?Q?KLDxBlyS4ZrmZO5EZiuoWCVzx1eIZILqC4aCKbXrlSjhGtookmeAwr/do9Au?=
 =?us-ascii?Q?OO9QUOtcieKYLj1wT5g3KamTQa+mvyZxY+Dj8piYnRVS2B3ImvcTihU9YqOh?=
 =?us-ascii?Q?aseT7BQIQY7ETf9nodlwClbo01BkVJJN8Qm9Ay7bSt/yu0UMrZ3smw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 16:14:39.6809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7da977-25eb-4050-f621-08ddbb15e0d4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10740

Nicera D3-323-AA is a PIR sensor for human detection. It has two GPIOs
for detection and data communication.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../iio/proximity/nicera,d3323aa.yaml         | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml b/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
new file mode 100644
index 000000000000..65d9b44fcd5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/nicera,d3323aa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nicera D3-323-AA PIR sensor
+
+maintainers:
+  - Waqar Hameed <waqar.hameed@axis.com>
+
+description: |
+  PIR sensor for human detection.
+  Datasheet: https://www.endrich.com/Datenbl%C3%A4tter/Sensoren/D3-323-AA_e.pdf
+
+properties:
+  compatible:
+    const: nicera,d3323aa
+
+  vdd-supply:
+    description:
+      Supply voltage (1.8 to 5.5 V).
+
+  vout-clk-gpios:
+    maxItems: 1
+    description:
+      GPIO for clock and detection.
+      After reset, the device signals with two falling edges on this pin that it
+      is ready for configuration (within 1.2 s).
+      During configuration, it is used as clock for data reading and writing (on
+      data-gpios).
+      After all this, when device is in operational mode, it signals on this pin
+      for any detections.
+
+  data-gpios:
+    maxItems: 1
+    description:
+      GPIO for data reading and writing. This is denoted "DO (SI)" in datasheet.
+      During configuration, this pin is used for writing and reading
+      configuration data (together with vout-clk-gpios as clock).
+      After this, during operational mode, the device will output serial data on
+      this GPIO.
+
+required:
+  - compatible
+  - vdd-supply
+  - vout-clk-gpios
+  - data-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    proximity {
+        compatible = "nicera,d3323aa";
+        vdd-supply = <&regulator_3v3>;
+        vout-clk-gpios = <&gpio 78 GPIO_ACTIVE_HIGH>;
+        data-gpios = <&gpio 76 GPIO_ACTIVE_HIGH>;
+    };
+...
-- 
2.39.5


