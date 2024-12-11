Return-Path: <linux-iio+bounces-13329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8D9ECDF0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 15:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3860A1632CB
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215752368FB;
	Wed, 11 Dec 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BUXVMZee"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515F232379;
	Wed, 11 Dec 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925866; cv=fail; b=W+uPZs2Mfv4gDEBKup8dp96LpMFkV+o2lbpqhXCnJb7JSoShOBujB8Q3RpZNyJKwbY+/cklXHx4nz3AmzqOz4yp2Xya5yALCDTQoKEJaoLULtANm+KLDcrCVZwqSN2s+ppom6mjhRnWsNosOVgMGMpBZr7KpY7TWBh5dNWTMbL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925866; c=relaxed/simple;
	bh=anotIRYwtbRSQfU3/ZijzGIBJmHXk7wG3amWdmqZBV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gt1f8ufu9vtvtEaDJNAx9smVnNCU8eUnbNUEugUGIlcIzg5Vezb00SOEq7PTSEAZuxCDyacAHfTiu/WygCfazcMJtJ7WGojiKeU/ztKFCPPo8K2i9kc4Rw3VCTajEIpwy5GAwh6fSPAYN0UeCh1v0rar7tK0dJ2AgS/v5aYB0h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BUXVMZee; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEi4Amb8iGYNT7uGI3V1hYBXB0f7zRTA6fhVkOStMeP3sBok6s5K7P87UjW/dOZkdcPXg/i91KrRhtdo5p7JibQOqvQRZ2gcP3gruSs3FfBzyxIcBLTCND1NeDUyldOlxt4A2sv/QmhPiCYKCRp3moQDy8tIO+2fo6onvTtaLx4GSEmu00chPjbtIIjr8sEZZgMQTpU2rLTnoQTCJ/R4Mt45+9rAx3CZshIEYuweqw3CIVMizgF39kjEQ5/R6gfXi2SZgZ23/OtZAnbbf5cCIwAuDezrAgLHIPPXWIEFCRFmrVcnvdHR/ItaMXyzbqYwrGJYdoqQ+ZB3wlY74BaURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w60dWKTvlDTi6JfIzlCH8vUtH6nRIsNK3tWKG6UlqzM=;
 b=qA+I4u9tjA7aVBYING8CG+Qx5c9qcbj9ckpEXIvkt2c9O256kbFOZXxindLSDcVvCnz9hjAX2PXqx9ULsVKOx8J7+E424tSFa2iqzDe6FeshJle6RkSUvoyS+bsEtNMZ50GVEApKeZiC5xuu15WVbIFxk77DdUIXBOGP+8SfwzcZb7RiEO034hMmOiYjRaSNWh54TKxsZ54+IWTNoSZa/miqtsnMzKJbQuEDnGbc8MP7z7Px0F0Ad2D4rTfY64r18Q2bEyrXhpL9DgdIjqGlwSzgfAH1UeuD/+AGN8LPN9D5DwVbR49fNUie70Th5is+JBkLXz7H+ia/ut+nBbRYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w60dWKTvlDTi6JfIzlCH8vUtH6nRIsNK3tWKG6UlqzM=;
 b=BUXVMZeeEpaeX1p89ZsGeMN/ubiUN9hgFVe88UoUKY3UwLyGb72M2GcCflnI5GHWvOVhyP2F33YDTMclorfuVwDpDs0KXeahVI9c+2LDXGvcQCuTi1hYmZ51vdGWboIv1r9+bB8+22TDk0PWngTkD/0p7+Jij7b3+W/zailFbZY=
Received: from AS9PR06CA0630.eurprd06.prod.outlook.com (2603:10a6:20b:46e::22)
 by PAXPR02MB7229.eurprd02.prod.outlook.com (2603:10a6:102:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:04:18 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:46e:cafe::2a) by AS9PR06CA0630.outlook.office365.com
 (2603:10a6:20b:46e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 14:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 14:04:17 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 15:04:15 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Dec 2024 15:04:15 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 34BAB1A1;
	Wed, 11 Dec 2024 15:04:15 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 329FF18E1EC0; Wed, 11 Dec 2024 15:04:15 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Wed, 11 Dec 2024 15:04:08 +0100
Message-ID: <20241211140409.1619910-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211140409.1619910-1-perdaniel.olsson@axis.com>
References: <20241211140409.1619910-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|PAXPR02MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b47eb8d-9273-4012-f006-08dd19ecb3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LWtbNI0G8ZIENp/p+n57cUlq8kugctTcPnMV2E0owkG913MIVHwqMBJ7n4rw?=
 =?us-ascii?Q?Qc6FEHDkX/Z+wq4z6DK3f8RXyYlTEWAEX7/YtwXm36Q8yExPdfXZQkWQZ6I7?=
 =?us-ascii?Q?2tusiT/cN1jXX5U5FjrB9MjLMyk6urMvcU/rNB4I+wRYKw6nf+BWxab3LThX?=
 =?us-ascii?Q?dkoErV/q02+Fw9qAbrWOZ9ji2i2GOQ0f77/YR3Ej/sbRpPNA3BO5gBB6oWIq?=
 =?us-ascii?Q?qszk4nD/hJ7D3Ya7KQSubZjyshj64vrM0UCE0mKHtAL9U6rrB7a49oRwBUn1?=
 =?us-ascii?Q?aIZiqORvnTDfjHoaEbIqSf1pj9U1PEJdq/IqlzfPPP1uSKBFclw8HtLxKH79?=
 =?us-ascii?Q?wDhlb+XdObsYOB2ROeO8dOZ9FLLV33TsRqaw1U8KJQ9DjPMrwayS693Pt21r?=
 =?us-ascii?Q?aaNDTbCrNRvRByIFX1JTD8QCCzQVaarec7gPxtLiYURLIprKctZT1qWSnoOZ?=
 =?us-ascii?Q?0xpR0lCThg6W1DrKQqeDnI78rPQwZQyfZz5Vt9gWGBPhBVFPuBuzkjQwbxaz?=
 =?us-ascii?Q?Bl1B6SsMs9t2GQnTJrzcR+zvpAivBQOaIFWxNMnZUDEkHQqFs4joVSlqMA8f?=
 =?us-ascii?Q?+WTkQqT5EJHahZueFoj7eaQcdMKBEV7WqjT9MjWO2cCcjWJ9+4mIUClMDDkv?=
 =?us-ascii?Q?IPDKz4KcHrTPccMsnjc5KqXfI42YOtOHJcyZBKvLtL5LxY4zH9VQyYFGPJht?=
 =?us-ascii?Q?+Rt7k4iEgyHzsdsyWrXbkXpOA2MYoaB+WU3dKOXKTbewGWY/lSivd7J48ffG?=
 =?us-ascii?Q?Y7iLfsd0Atl+SLwlJ1rZvAhxfJYQ+nJjdizx4fZAnD32nlh/KHB1O0TpVawL?=
 =?us-ascii?Q?AeJcK57dndoDfIavtUOT7IGSGuQrHXw/jZ8tgt2uIfD5DrbaK+x0dMi3Lljo?=
 =?us-ascii?Q?PH5stVWKK6s6ehhEH/zwE4gbQXN00IM4Fad5iFx55xcS1W/fY6KlH+F++2Ie?=
 =?us-ascii?Q?47F9gZjAWO1N0ZNDQHDA+kooAGizlVbm4nxDbKDwjKWoMXJW5v5C4md8/HF7?=
 =?us-ascii?Q?VXLzrdf36gWIMa7ybITizN48/ip+r3sq5S9p2um+E5JFOOgOB3SlhlllZk5z?=
 =?us-ascii?Q?UOsLi4dYqGFS1nSrxrYo/mPvT2CCkIVKnCSK/iJLeq6VU3y2GuIqA+TIaM+P?=
 =?us-ascii?Q?3jxjWIAik+DHA5BUkNzsiMwXsBFbCgetrCQsmbUl5A0KRvFCVfIUM6RRScyr?=
 =?us-ascii?Q?Ol58n4PLb6Xey3Q8NGH4Nb4W0Y272btfC+RfiPzcFmYws2rPDxUXXunwDgd+?=
 =?us-ascii?Q?NYhKob82TWj5YwTV+dQKzs+rx8SdcMMeAAMUfTZFsExL62F8fwxAnFnfWcos?=
 =?us-ascii?Q?U5n9aLVPS2IuwuIlowtPEeTEmEtNvYhPq6t1GdJz+WbLU8x3QoBeRviZX56W?=
 =?us-ascii?Q?WPtoqHFJ4JjNHFtWRFepTANTdyZv/CMOl7kHK7vXTzvmpKSW8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:04:17.8815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b47eb8d-9273-4012-f006-08dd19ecb3fe
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7229

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


