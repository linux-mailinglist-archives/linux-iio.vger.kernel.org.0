Return-Path: <linux-iio+bounces-19387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0364AB17DF
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 17:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188291C228A1
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72794233151;
	Fri,  9 May 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ovQqJA2X"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25320E011;
	Fri,  9 May 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802989; cv=fail; b=cHRERfMldxxKc74xb1Z9Mj+c1Mq3T+gXjHo1umjpQnIf5u1+I0+LdEJZbvhs87HSldmZuisVdHyfli1YsfAfhHWYV+xtJPjw0tRFSSurQYdJiKEADU/Yyyku9FhhDtQfzOXTfcADo9nFcgfHsSQ62V84kSA4xYPQTPma8cpl3lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802989; c=relaxed/simple;
	bh=R4y7g3BFayZhsR4NqNlTnMUWXxWGvv/XtcCKdjWP4Jk=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=W5xe9hJxrc9NA2FbMIujDN+f/Cg7w9yAIcfSIHVey7hYSwgN4g8FmRYnUsgq4shTd+hBCmJVuv2kysgbrgoyndUrDx+sZko3lShK57AYXzrl0p3Dv3H6T71Pzyn5SkUx1Z7iK3K4vKJg9bImyTRVYB9OTZCH08cfbQn21SV+u98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ovQqJA2X; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k41xOSda/AmdS9NKKot0yBDYykxuwUUPZbeX689YBWctafq7Z8dP/CgjM+M0UC2iS+eERPMZVfZOQeZPNZ4v3CMZdh1PKva+pnsAvpNY/+tA8PHUpYfrMsRs89RnRoL7M/kN9JxwF1RG9VXxtiA4UJQYBMEHg/ogen8o8zPkuKkTgQVZxbx/wr8zCwAIEao6dqE0kWIIPXSlY+AsHzhQPUghTHBlo5foPfSRd//8IPKfXVOHZeOQZ+9NcpXrjGLsXAVX7tXtb4bgIwXjFQ16SmKjOGW4hDaswwMHzcLmQfHRPEvuFEFr2RW67l0TPc6xCS0HGzu3O7Fp3pY+5i0asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiuelH7UCTwfpN/fq4tJcJ/Ea4XJl8t5NhG5W6VeX5w=;
 b=izQw+piC4adMHzv2IioWqpVPGXID80u+NPE3CJnjdZU3M87PT+7ormHtbd+j/Fs279nXi5+VkhvQ5FFiztE9PxIHVbQrhtISh/ZR+9a03C23ff/N3OMiGoPVBBCxZUjpqRHDdK5u6rcw5B60fuTp7rOOW3rK3t234ACKXBOZMMC7tZrf972WzDZ+c0uRy1Sp4cgRnT503oKnX7mcViqCvDXVZcpjr31HQ7Vm/nRJJO+wMWDdG+nstIZCm01uyH9yujSWy5LFwKpcQitqdJhvfaEQyFnf3S8U3EL7bGPFD62yL59JyE0U85mOqXArWuYjSXWYd2Kjzr7c/V192E9DgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiuelH7UCTwfpN/fq4tJcJ/Ea4XJl8t5NhG5W6VeX5w=;
 b=ovQqJA2XomVhUmpxIhI5vNyhIAvcG2KeidALvtk/j38evwdMhXFCqmdS6yZdhw6YacRGcxTUfHiFf/KPXGg0PHPfe8vOsvQQ6wS4z6jq75QpqELcGEHQgB6ty7WCasswI7RkRxnz295/sfWItTqE2aGkpV/z0dg/zRpEeg6KPJ0=
Received: from DU7P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::12)
 by AM9PR02MB7267.eurprd02.prod.outlook.com (2603:10a6:20b:3e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 15:03:05 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::46) by DU7P195CA0029.outlook.office365.com
 (2603:10a6:10:54d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 15:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:03:05 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 9 May
 2025 17:03:03 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR
 sensor
In-Reply-To: <cover.1746802541.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <c57675d505e93549bfca5f9909d67822ab304a44.1746802541.git.waqar.hameed@axis.com>
Date: Fri, 9 May 2025 17:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AM9PR02MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2d053b-346b-4884-abe0-08dd8f0a99e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C5EFIgXwbdTTF4vWsgTDl9fM1zGflouXnmGjvHgYIRn0QmqRNgsfh12Ppsc7?=
 =?us-ascii?Q?HhxPV3spckA8nL1N6nBvZfuvSHE9j9F24S1keuL2P8TepNubusRmEw9OYZM3?=
 =?us-ascii?Q?spqL1R8RYy7/6+KgV/om1iBQDQ74OAzjWvXxE/rvi4ai/azm44w3xUqKNwR2?=
 =?us-ascii?Q?YGMNyM+ltg88YqUI54pGxW1ty7hcjkMNxoquuOSIw76ZhW1cce/lKT0+04Z2?=
 =?us-ascii?Q?ypTn6cbCLtXGts4l3i1pIhohbwdV/yDlIxRZjFCT4dpWoRATVfxt3jWX59dY?=
 =?us-ascii?Q?KrWYWePhIk6z/53DPh5mdJJC5a+kdZUreclr+mrg97xjXgfbq50lNY3qUpz2?=
 =?us-ascii?Q?yjVBK46LeSN0+BFk4I333Qh47wGxdR4lbgknbQ6sKRTMZeKaVOiuXwIZF2t6?=
 =?us-ascii?Q?4/c3tH5aVg8skhNrFYiINoyRlETCA6so/V3uRLZpNvlJlLM6G8P0bx42uNLO?=
 =?us-ascii?Q?GDtfoG5f5xAMB0c8cgqYP8Zh4FiAwMdRZxO8vUGA+FU/EMPuStdve3Y9CSvP?=
 =?us-ascii?Q?8M3y1rdpQwKuoq37zb60e0pKwWqvWg8ZrtBW8RraQc+dlxDINOSSzpl6krBC?=
 =?us-ascii?Q?v2gfQOjHVWngATTq5yM8h7XquX4yMPkdkLe5Y0rzu3+7IAQ4lZ6P+UVQpCwu?=
 =?us-ascii?Q?HP9JMvf+bnusb3VZDwGpW8hks2oKMi/B6uMPtaLrJcHn3/PQ3eVAADth1K1K?=
 =?us-ascii?Q?7NtS+U3J/84ahJYbZP6P/nkymbIixRhdpSx27Jw79ZEjMpU4WQR0YhIo768k?=
 =?us-ascii?Q?PApoBnjDWXj1FrjC1b59rs/Zy1ybtJK6PpVuCUr13d3Tsx5p1V+TsaqQidpC?=
 =?us-ascii?Q?raJTfI1LLQg0k1Vf7GIruXHmie8msAub+ox9kDHQy2xwjzNY0JwoI7QEHjSi?=
 =?us-ascii?Q?Px9oXiPlsjOTDhwgahgA1vaoWKeRYfgDOzLQwIRakrVTvzJZpnlD87AvpQGj?=
 =?us-ascii?Q?tdQudfwljEvfyyoZ+pmfFNNW+BRce7yaPht2XQBOV8NXtqFfbsjzul6p2hmS?=
 =?us-ascii?Q?pVvUq65UlgNmTVJ8iz+fbcrym7ibArfvuSiqI2DFnDhmNQE0lds+e9Z0/YnE?=
 =?us-ascii?Q?Ia9Ysih81pf6QzvFBjuoOKWA8J8SwbE7aTlKkA1Gc6g4x+fDBRMBPptMMUEn?=
 =?us-ascii?Q?i+WlivgX258P/cuGkeX0CuDBGO5JiCDKq+GBSoBFxHOpcFxKLxGD/nnvotW5?=
 =?us-ascii?Q?A0jqCpMH1Vw2mKCJxPQ+ITvfg780KqhasFcRjw6ilUObyRi95WA8w5lY4rNR?=
 =?us-ascii?Q?2qaVnNdORdMIKJgi8kn7GfX2upDOhGonlFf5jQmoLBVuMN8EG0jBpPNkfHbp?=
 =?us-ascii?Q?sq7e4rSrMGUjVg93383++dhVmK4PlncZTcSFlnkqVE5VEBe773TrsQcDXHE7?=
 =?us-ascii?Q?MUfIL87Qi8TLa33ZilICzCTtMwyOlkrPfB/VLSK/F4lZfOtR0eniTfezVCb+?=
 =?us-ascii?Q?znFBDUUyp1enBlTxcvjW0iVrlHYsVmW6S91/s2jwRNtMSJYN/DkICA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:03:05.0570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2d053b-346b-4884-abe0-08dd8f0a99e8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7267

Nicera D3-323-AA is a PIR sensor for human detection. It has support for
raw data measurements and detection notification. The communication
protocol is custom made and therefore needs to be GPIO bit banged.

Add devicetree bindings requiring the compatible string and the various
GPIOs needed for operation. Some of the GPIOs have multiple use-cases
depending on device state. Describe these thoroughly.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../iio/proximity/nicera,d3323aa.yaml         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml b/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
new file mode 100644
index 000000000000..1ff24dad0086
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
@@ -0,0 +1,67 @@
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
+  vdd-gpio:
+    maxItems: 1
+    description:
+      GPIO for supply voltage (1.8 to 5.5 V).
+      This GPIO will be driven low by the driver in order to cut the supply and
+      reset the device (driving it then back to high to power it on).
+
+  clk-vout-gpio:
+    maxItems: 1
+    description:
+      GPIO for clock and detection.
+      After reset, the device signals with two falling edges on this pin that it
+      is ready for configuration (within 1.2 s), which the driver listens for as
+      interrupts.
+      During configuration, it is used as clock for data reading and writing (on
+      data-gpio). The driver drives this pin with the frequency of 1 kHz (bit
+      banging).
+      After all this, the device is now in operational mode and signals on this
+      pin for any detections. The driver listens for this as interrupts.
+
+  data-gpio:
+    maxItems: 1
+    description:
+      GPIO for data reading and writing.
+      During configuration, configuration data will be written and read back
+      with bit banging (together with clk-vout-gpio as clock).
+      After this, during operational mode, the device will output serial data on
+      this GPIO. However, the driver currently doesn't read this.
+
+required:
+  - compatible
+  - vdd-gpio
+  - clk-vout-gpio
+  - data-gpio
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    proximity {
+        compatible = "nicera,d3323aa";
+        vdd-gpio = <&gpio 73 0>;
+        clk-vout-gpio = <&gpio 78 0>;
+        data-gpio = <&gpio 76 0>;
+    };
+...
-- 
2.39.5


