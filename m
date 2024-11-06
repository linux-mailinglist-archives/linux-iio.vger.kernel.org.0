Return-Path: <linux-iio+bounces-11943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEAB9BE67A
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 13:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3440285BEA
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6701DF268;
	Wed,  6 Nov 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TQBs8uWF"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2075.outbound.protection.outlook.com [40.107.103.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1211D416E;
	Wed,  6 Nov 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894457; cv=fail; b=dl6OR14myyDppHMSOgmvxX2CU6978lTpcFdmUOUImywb03yrJQppcKkEBxP/1prTP145cctHTRi3n8QmsZDp2JLQEPlC7klAO8cXTSNNVmA7wDIVYK4ZNSxoGIhpJeWd7eyp0b6rigpZin54h4UctDDg1pMQlr3dvZrDsDHWC/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894457; c=relaxed/simple;
	bh=jBW9dRb2Q7fkECKRbwQaBsPqg3TX84ry26Q5ZmRVplo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJCbjb4LDLVjgoSTbc1pWpA981KbT5nv0pKPELBMPhO6U6lvsH5pwfbYzbSScoTUmqUvKiMNsAA3wrephxewEb5KgPPyJTCBi7cqp7wyzRPJNZcfND3fFFrNFBMtfQdP1sz8biOO1xKLmQJfQ0bUviaOZywijeo01CohF2uG8BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TQBs8uWF; arc=fail smtp.client-ip=40.107.103.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rkepn1AJKBd0EehQS4maz5QwTuftmsGAzF8CclOwyuVdZcRBVGYG85GboUZm6gQCtnDfRl7cnC8JOuCtu5CcO5lsoyxS0DpiJZ4LfV3nVoQO5KAXOrFMTEILJwabYu77FHsKIax4O6KarUVQOoHp0z/Chppl2nxrIkeEVKz/Jr2pO8yKpFJx8KvCzkhSlnthb4QY+yWGyIAb3h+IPowIAfI2RfHDJP9EdjARmHZtfyw/LvY6A53atZkK7nc+m4ezdumY8NAvDKZhZQM8bJzuqpfcMVVfKEfEoWMRnv4fz7gXFn5EI61pVLyQI2ND2Sr6uHpREdEz5/1JBL2JaMaVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb2K3oIaWi5yrqQaC9lyjmZ5eqottKylRr1oLhFtCGc=;
 b=dKNWnQm6dHhyjPhHPq+PCEpITeeruHyzXyY9Zfz39IJj9EP41IxPiublTl8OHWhES/PAk9j6Lr31g1O5UD96A8szrVkF9OAmW7d/yzizuEe9Il6TenmET9KhAVVEzBZ9gLP76+Skqu36UZUBdS5e9pFTUuyEA+WodA7zl27Md8pEta5yW/2DpoZxfV544IIcm8sLi3Jb3ZZcHn9Cj+njq6m3f1M4+tI3+7klKJvqQfjh8ViONUPBTTOPVe10D4JzVDgpdPjX1W3Ju4Vfm0XvVw28bCUe1Z+AMC6ma7i/Xofa1Z7A1uat8nvUhq4Gxlr3xmEYAvlUM805IfaKJ4VjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb2K3oIaWi5yrqQaC9lyjmZ5eqottKylRr1oLhFtCGc=;
 b=TQBs8uWFKARClf238Y0VQ41nM/qTi/tdAd/izIPLN0OAAgWyx/mDiMBA1JmGKx8+wYOE60ZXyGmDGP/BQAYssL9y/SkYE/TL2/qC2ht4bbD7pMJA2H9dhh6zJs0P0678J7GlyJ8EtfkTTYWpTl5X/NA539BftoUt1Nw5lYKEMi8=
Received: from AS9PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::14) by GV1PR02MB8491.eurprd02.prod.outlook.com
 (2603:10a6:150:9d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 12:00:45 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:542:cafe::5e) by AS9PR01CA0035.outlook.office365.com
 (2603:10a6:20b:542::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Wed, 6 Nov 2024 12:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 12:00:44 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 13:00:42 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 13:00:42 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 6 Nov 2024 13:00:42 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 3E73C7A6;
	Wed,  6 Nov 2024 13:00:42 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 3BFDC18E1ECB; Wed,  6 Nov 2024 13:00:42 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Wed, 6 Nov 2024 13:00:35 +0100
Message-ID: <20241106120036.986755-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106120036.986755-1-perdaniel.olsson@axis.com>
References: <20241106120036.986755-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|GV1PR02MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c53ba1-dff3-4215-674e-08dcfe5aa508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EdeGfOdOYv3P4wkZfqZPU6EQZjPT8df1a2wjQyTGsCw+khtjDvyrd/SPqqhb?=
 =?us-ascii?Q?dVA8tEKZlrYBVkOKEon8QxSIsZerIZgLNk7m3lvsZJqvdQ7c7091m5qConwb?=
 =?us-ascii?Q?sHFtPQVqL6iV5FU/GaJPDk5BpC0Y+gyI+wrKAGDjDsSeNSXgV4i0/DoWgggS?=
 =?us-ascii?Q?gCq/KoAP43Yuj/5Nhu2AYRp3JxLsH0wwR3wb4CXTO1cFHU+zvAbkEyH0/u8w?=
 =?us-ascii?Q?J8P8M/QL75rRgGKTfWnkOQc8iUe+ldvpddh/vD7bFlahNwLnc4OIINJ+JgXm?=
 =?us-ascii?Q?V+5m/kx7JMOmK8F6HAKm3/kvyRKgZHdzpuL8e50Sq1hK0qq+yUu1J0Dn2dDi?=
 =?us-ascii?Q?Mlt42TCBsdIQQR66y4kPg4jCF8fur3aKj+TZ6Wq13DAlJPffj40iNOX7367t?=
 =?us-ascii?Q?ezb5d1qaZf57jCrg2FrAkfkR3r/LmQkOBVDP+urSWeojHuQQTV4ga0e258Ve?=
 =?us-ascii?Q?TqLCXkf7JSabSUDGlPMhkG2BrAZHHQFwc/v8A2kp7o39Umt1lYzDxqmsOnrM?=
 =?us-ascii?Q?LvD98d0mxi2j4hgsxOIVg/Mcv6YQlC1ds+Fb9B8Kin/NP9LTpR2xyxxJFFKP?=
 =?us-ascii?Q?rGy/r/s0NsESqyZ3TVC1/QbHcia7CKu5KtJd4HsF+kBqe7n2kaG6kpIFzHSk?=
 =?us-ascii?Q?vPLTACRNikJyZ0GPSo/Du8O623rf1l2IHZefxydzCHOP6rQusWch4TwHzxQT?=
 =?us-ascii?Q?dH7NBYzKjpXFW1vJCga+TNuv9BNzytlAGRA+7xNkBofHUzD+48lryRlOuX52?=
 =?us-ascii?Q?2tMSAn1bFqowOZCNQywrXRT6E+8VtVkxFR3VQPY8ft1xZ09s95KuXBQQbwnD?=
 =?us-ascii?Q?K+EBQwt9txFZbPDyKXkDJi5j8ZvPvDgS5nf+YkryEKuQ3D2tFVsqmkXSFKfe?=
 =?us-ascii?Q?EL2/M9AMPd7xQ3QnHavl7hY0sPhTNPwM194JLBMct7IDKWcC2NDTTq+TDfEn?=
 =?us-ascii?Q?Vftd/2MXr8Bs+9wDxSO07fRypGNyHwuh3z0HJlCsgiGqrOWboqPWO19XCz5u?=
 =?us-ascii?Q?QA0mgthnmb4NYm3PiXMVOUzNI/fjy440xygtB7ZI2JomzNxWZl3POZDhkfwc?=
 =?us-ascii?Q?3XromDfMUqnS9ScORiBwLx/6YNgCLBT5gDGktqm9huK6Ol1BQghDxhkmaqDX?=
 =?us-ascii?Q?FtlBb8YcP79F5ACyQgOLyfoQTDJKCZJI96Xolgl4C2gmOHmNQyT9UubFys5u?=
 =?us-ascii?Q?YJK6Du1R4bVOovmIfaf8eaEdY3A5vPVii17ddZOpVojb2zEgAJUmGwlbhcIe?=
 =?us-ascii?Q?cOPpBql3Jnzf9kGwUtA72xKNixe+ZDQ5O2iMfueN4PLhKWqd423MGHo2naH+?=
 =?us-ascii?Q?3G5X6S33EHd04jZQQnmgojzyw1EKwBzWqPIG9/2eP4Y9pHjGQNGaNCr+BbnX?=
 =?us-ascii?Q?Yl/b1JI=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 12:00:44.8758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c53ba1-dff3-4215-674e-08dcfe5aa508
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8491

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


