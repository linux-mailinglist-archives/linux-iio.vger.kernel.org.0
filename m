Return-Path: <linux-iio+bounces-23758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3233B451D0
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F181C80CBF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CF927D782;
	Fri,  5 Sep 2025 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n8/Z0uFe"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8848242D94;
	Fri,  5 Sep 2025 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061746; cv=fail; b=ZKuSKXFltSaoUZ7B7vpapJqcFewDALs/BFSz486M5VtKekznByX1tAfCA3ZGsTiKhqY0Yr90rIe12Oz7f69Z7U5k05IB5jdDZgvW2bubKLv6fEnPM9+AXjkSJ3W4/1AQRnAY+5orsl71a6h8je8fp7AbM31m9m1uAC0xYiNWDgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061746; c=relaxed/simple;
	bh=jYly6ZleG/OcBcmWMeY+/uWfdasUegqOOn7RTcs/Ftg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pw48S+INPqkBxH9+YG4UK74G8KSh4CUV0J+tE8dpNgYyKGcKMjPAnenh78f3O8mEsOvqyUwXLmooC1o1SWmSE9R3T3lR62DUipwUFtbwiMmHDmCb/RtJP0VOZj0GJk8qPQo7fmIzWAQle7Jzl44hgRkMcPWfW8eIPMxy0UmdCj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n8/Z0uFe; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO4/edQqSD2Mgyqdl+L70sel2jFWMbpqUjhiWauc498O/VcTk6AB6dnu8YSHSZ+6W2lNO7Cr7zThgTkEW904qWuzzETbKASOVKUd2JNBCOlQUucvbkgi0RYG+eNWipQyyp7YXZ/x/6R415qm2t17OwAqgVdWYxSb70Kjb766ymxg7qosAYEejXdjTeXnWQJDbu9eyKbzdqpOnJY/SyvKl85e53pyvaWbe6mRKIXKTXzWHw8n19FNpoaxZZx22fjYNypcK/O4WPSVekm6jbwW1vwKQ5yNTuBryVAT/ABaYH+QJVkro3nqNJYShQ75RQlksDBM1QYonNu2KpAlgNkL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vddh5gddId5gR3KRmIpxOiG/9jAlua4VlomritJy708=;
 b=LhSlXne033FntnDcBRHwJYnCqMmRiLyV8Ye8QQpDtSqxl3vpSmfibOM6vjk+WYJIfpfrbfVXD1hBmwx/uOccyzz/zw2uLkVf+qOujlEvfVPk8aeAhFow1Zs/n0dEvmQON4dckTH8bUB/MMLgNcT5WN4KO9sYwr6kBzuYyLrymYidWYeVCr5Xn1yaHarJIY10emOmM9NAZqDDkpIeNWsj2ahHpYWfHCK/RjrWSFxdstPxVYa26iPQTouAOQMaERFY5+ybAWrufWtbi9feahKBfYr3vYMkZL+sVxSuspR1tJu3yGama4EGGOrKKNQwJsr/L0Bkso9vvD/tnPbk2pvvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vddh5gddId5gR3KRmIpxOiG/9jAlua4VlomritJy708=;
 b=n8/Z0uFe8sbuMcg/KeDsT7CfoLo4iMjaDVEO7i/PKqQQQHICwns6XZyj0okdj6AUt56uRDrj5IWYsbvoXgBJKxB42nx9NiadiNieKpkui61Qi9BLs7Z5HlsCtMKxK6m4KWwKjWBU6oTK00IEXRH0LcReymFliIkDjyHShS9QEJQ=
Received: from SJ0PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:33f::27)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 08:42:20 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::60) by SJ0PR05CA0052.outlook.office365.com
 (2603:10b6:a03:33f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Fri,
 5 Sep 2025 08:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 08:42:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:42:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:42:02 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 03:42:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Salih Erim <salih.erim@amd.com>, Anand Ashok Dumbre
	<anand.ashok.dumbre@xilinx.com>, Anish Kadamathikuttiyil Karthikeyan Pillai
	<anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>, Andy Shevchenko
	<andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open
 list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for Sysmon
Date: Fri, 5 Sep 2025 10:41:44 +0200
Message-ID: <610690b9cc4ab3854b56df550b688b4cc72a5653.1757061697.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757061697.git.michal.simek@amd.com>
References: <cover.1757061697.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7036; i=michal.simek@amd.com; h=from:subject:message-id; bh=oAK+tV50H6FxUNTxxyMRovdkHdQp5LFNhGxk7RtAZNM=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTsWuRjInqBVWH9SluB/bGxs9mD393csonLwPpHrYNbh pNOZdipjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiIxT2Gv1Lv0hJeHl/GfaPz 1d/tD3WyBFN/KexdcHOezN+JmxweK1cz/OFu3pxjendt2dI0pjV7K34dChTTnuecP3PTKiFzhlU 8k1kB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f82d205-0114-49f7-f944-08ddec582082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gpO6to8T4i38S4QOXsIVKYhehiiV92FDnoMYE018AYda5GnB3IL43aV3CuR7?=
 =?us-ascii?Q?jpt7fQrDIgH4xbqAfcua9llZPcbIdthPJ2wDSFhINQzYCJK8t0q5tUSEY3M8?=
 =?us-ascii?Q?j9NG91EILAq46bEqGUjzdmrLw56n11R9F/NaDS4H99IKUn1GmPM+L4cLMUrW?=
 =?us-ascii?Q?4NllBM5O0qY5tJBez9GAU/cpf7ZRc3mSE8mpCMTS0MxnaiipLI+OtEhUWKei?=
 =?us-ascii?Q?/4I5FN/l8GkC87sZMZ844trQaN7Qw/hDVVGjzXzRGxuwYFq2HbJd1bn3HjH5?=
 =?us-ascii?Q?B6y6ohqA2EUUB0HlOHO/pUeT+ELk69ztdo3BDITwT7u1th2Uxjxd4qEVwPja?=
 =?us-ascii?Q?E7dsdGVZScAx+D1sKItsEsVt+jVn4Qwxo7UCNxLTeBOb2vYP846j8Gh+d0y8?=
 =?us-ascii?Q?2znuHZOuajM4XcNbZfns/aGE+9cLkcy55lbYbvSFOLBs8hu+tLtjAuKd8Y4j?=
 =?us-ascii?Q?vuRJwhWoeIhEPeJF13ckcH14sNHBcQRB6049uRGbfov3+I4SMRGkXNoTNK9Y?=
 =?us-ascii?Q?z4rDW1a5Znl4tcoSLOnhm0BuaHVO9HD2AISLP7XpIJH3Wc70+Z9LL3B37PtO?=
 =?us-ascii?Q?KpIuvtXvOrk2OFlld/MriDrr/jrtq0BDW7YQ4VE6rYtsyWbh3qmj7cLpmfmn?=
 =?us-ascii?Q?bfkt06SgfIdzrxlrGDTMYx/HfwPEFW7h+kHJ2RflYAHH8yhJS4/qVbprR5JS?=
 =?us-ascii?Q?GYkP0I3tx3mc9fOWjqNwt1vDBvUZJufxrhYfxTRFRc6EX35OFKacN6PNS0RP?=
 =?us-ascii?Q?cIKBumdzvnAEKY1HGdKeL0c/P01utGMp9h0IOjCO+3DWnTnh2SkU+imtWjiR?=
 =?us-ascii?Q?zjZjqYR7HMMSDKElRK/1p4aNLk007GRzSJ+6teUyfzf0oOoeXRvugc4rm+Xa?=
 =?us-ascii?Q?97BPtiHktkkPjHvXZcjaT1/YH4wP3Qomd3VhW4iiwir6Pm5hrlxAT2g7S9rH?=
 =?us-ascii?Q?c9ARfyI8b+N5t7QR6UHvbvPJox5uHjZyyDyrhJ5hGO19pIDJQfLIh1uJLf9Q?=
 =?us-ascii?Q?Z1GF6bOSsDIqV1dpa7qSKf6jmWWnfhB1VA7iTIEtqUnH4Acs1mLHjTa5pvda?=
 =?us-ascii?Q?a9eksTgZ0bK3fmk7yF9QSMqGxx34fH/Pak4l+s+ZpAejHbqp1NvyRnGSdxYx?=
 =?us-ascii?Q?h00cLZh4Aift9O4nmxVlsVipXWwgFKLfgHzQDrcTEolF+0IEjB5/u8Bxpg2B?=
 =?us-ascii?Q?qMtTZcikJJY9usBOSFEwCFl/M22AT358+ULu3uGGElDeXI4b8U3GP8oa/N8b?=
 =?us-ascii?Q?DVWf+KLJURvXhQkYexXU/0QF8A/FweqJb3sc0/37OnxIsG342V9sp1hOwj3t?=
 =?us-ascii?Q?//kclbsioRn/rZwj3Kr+mm34v59K8AK20a9/t7FlkBjAcDj9CiuDi/BEBzWa?=
 =?us-ascii?Q?lPgMV7FXHaJN94iNcd3VryB56IudtHuHBvjEksRe8gMd58/hxHt1NfiQ6m+Q?=
 =?us-ascii?Q?PCA6FQZEj8LhSIfasURNUOuGlk049k2Hqt6ZShUt9PPWuXq6kV8wSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:42:20.1857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f82d205-0114-49f7-f944-08ddec582082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123

From: Salih Erim <salih.erim@amd.com>

Add devicetree documentation for Xilinx Sysmon IP which is used for
internal chip monitoring on Xilinx Versal SOCs.

Co-developed-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Co-developed-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
Signed-off-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
Signed-off-by: Salih Erim <salih.erim@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../bindings/iio/adc/xlnx,versal-sysmon.yaml  | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
new file mode 100644
index 000000000000..a768395cade7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
@@ -0,0 +1,235 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,versal-sysmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal Sysmon
+
+maintainers:
+  - Salih Erim <salih.erim@amd.com>
+
+description:
+  The Xilinx Sysmon provides on-chip monitoring and control for the supply
+  voltages and temperatures across the chip. Since there are only 160 supply
+  voltage registers and 184 measurement points, there is no constant mapping
+  of supply voltage registers and the measurement points. User has to select
+  the voltages to monitor in design tool. Depending on the selection, a voltage
+  supply gets mapped to one of the supply registers. So, this mapping information
+  is provided via description which contain the information of name of
+   the supply enabled and the supply register it maps to.
+
+properties:
+  compatible:
+    items:
+      - const: xlnx,versal-sysmon
+
+  reg:
+    maxItems: 1
+    description: Sysmon Registers.
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt line for Sysmon.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#io-channel-cells':
+    const: 0
+
+  xlnx,hbm:
+    type: boolean
+    description:
+      Exists if node refers to a HBM (High Bandwidth Memory) SLR (Super Logic Region).
+
+  xlnx,nodeid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      PLM specified sysmon node id.
+
+  xlnx,numaiechannels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 64
+    description:
+      Total number of sysmon satellites close to AI Engine exposed as channels.
+
+  xlnx,numchannels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 160
+    description:
+      Number of supply channels enabled in the design.
+
+patternProperties:
+  "^supply@([0-9]{1,2}|1[0-5][0-9])$":
+    type: object
+    description:
+      Represents the supplies configured in the design.
+
+    properties:
+      reg:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 159
+        description:
+          The supply number associated with the voltage.
+
+      xlnx,name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          Name of the supply enabled
+
+      xlnx,bipolar:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          If the supply has a bipolar type and the output will be signed.
+
+    required:
+      - reg
+      - xlnx,name
+
+    additionalProperties: false
+
+  "^temp@([1-9]|[1-5][0-9]|6[0-4])$":
+    type: object
+    description:
+      Represents the sysmon temperature satellites.
+
+    properties:
+      reg:
+        minimum: 1
+        maximum: 64
+        description:
+          The sysmon temperature satellite number.
+
+      xlnx,aie-temp:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          If present it indicates the temperature satellite is in
+          close proximity with AI Engine
+
+      xlnx,name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          Name of temperature satellite exposed
+
+    required:
+      - reg
+      - xlnx,name
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - xlnx,numchannels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    sysmon@f1270000 {
+        compatible = "xlnx,versal-sysmon";
+        reg = <0xf1270000 0x4000>;
+        interrupts = <0 0x90 IRQ_TYPE_LEVEL_HIGH>;
+        xlnx,numchannels = <8>;
+        xlnx,numaiechannels = <8>;
+        xlnx,nodeid = <0x18224055>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        supply@0 {
+            reg = <0>;
+            xlnx,name = "vccint";
+        };
+
+        supply@31 {
+            reg = <31>;
+            xlnx,name = "vccsoc";
+        };
+
+        supply@32 {
+            reg = <32>;
+            xlnx,bipolar;
+            xlnx,name = "vccram";
+        };
+
+        supply@63 {
+            reg = <63>;
+            xlnx,bipolar;
+            xlnx,name = "vccaux";
+        };
+
+        supply@64 {
+            reg = <64>;
+            xlnx,name = "vccbram";
+        };
+
+        supply@95 {
+            reg = <95>;
+            xlnx,name = "gt_avaux";
+        };
+
+        supply@96 {
+            reg = <96>;
+            xlnx,name = "gt_vccaux";
+        };
+
+        supply@159 {
+            reg = <159>;
+            xlnx,name = "vccint_ir";
+        };
+
+        temp@7 {
+            reg = <7>;
+            xlnx,aie-temp;
+            xlnx,name = "aie-temp-ch0";
+        };
+
+        temp@8 {
+            reg = <8>;
+            xlnx,aie-temp;
+            xlnx,name = "aie-temp-ch1";
+        };
+
+        temp@14 {
+            reg = <14>;
+            xlnx,aie-temp;
+            xlnx,name = "aie-temp-ch2";
+        };
+
+        temp@15 {
+            reg = <15>;
+            xlnx,aie-temp;
+            xlnx,name = "aie-temp-ch3";
+        };
+
+        temp@16 {
+            reg = <16>;
+            xlnx,aie-temp;
+            xlnx,name = "aie-temp-ch4";
+        };
+
+        temp@30 {
+            reg = <30>;
+            xlnx,aie-temp;
+            xlnx,name = "aie-temp-ch5";
+        };
+
+        temp@33 {
+            reg = <33>;
+            xlnx,aie-temp;
+            xlnx,name = "aie-temp-ch6";
+        };
+
+        temp@34 {
+            reg = <34>;
+            xlnx,aie-temp;
+            xlnx,name = "aie-temp-ch7";
+        };
+    };
-- 
2.43.0


