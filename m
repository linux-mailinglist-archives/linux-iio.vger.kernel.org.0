Return-Path: <linux-iio+bounces-10050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6933298F478
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF2F281C50
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A0A1A7253;
	Thu,  3 Oct 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fGgYDOj7"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A01547E2;
	Thu,  3 Oct 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974187; cv=fail; b=NHlZH7907NDsE52+m1Ws/gveIlVRMjgUKErUn4aQ5jvpPWTc6FjHqT9KDbGHkZVFdItKYz+II4owTo6JC1Kyuu3xugMqA2MOwnCW60Q4mKW0yX2U3n8XYmBAY3TXyDL8AjUK7iJ0l+K1jM8vjrGJ0KsuV74pWrGSKbljJXEtc8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974187; c=relaxed/simple;
	bh=Mcv7XlZXhlOs9sRMfhY0pH5jr+3MtKja87Oad+Xwtm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGCgm49Hb0fvCr9+E1pZc97pjRUO0Cfeijdmdvc3dJLlikt4ETsxRQvaEi0XnriI95cAZGM5Xoaw6qEWKYPMk2SdmRFbQW3lcAZJi6g7BGetWO/LR+gU82okDzdu/ki3YeNvjtR/4FDYvwD7mM7UmqsjnD8BNcD4pr23AHC4GgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fGgYDOj7; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw3S2HzHFqKT2uBhYireQY17zchPxgShCks+idqZ/WrujhaR3je5XLoHBovz1mJz8WAOSyt3axoAEGyQ5XQj2U5/rA3DYVtDaompVdjIKoXmlZ4K58r+GZwNy9uDPyKO0dO0+DM9EFApLsIVfcQYKKaT+IMr5i2/DHdl5G8Bl2mlQEMgTY718Qb+mefoD/kM608wYsb0xI1bVJm6Tg7RFBx/P4v2nh68oI/1/sv3AijujRsxUO39D6g2Z5uusenkl/+jSOUiUo6Tv/5sBTWXddVwcrE3KjG7Sym3utJLF124z9Qf7OJV3CIdPy0Qq8f63EQriNmsHkAR6yjShxoRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2WWPnhVMyLkY4KhixVxW9n04gCquFZFiB31j54kx5s=;
 b=cIGgByVNhGvcZxqeNne8KOOUkNN4Vqc5ZrpWZWo2oUUNMIOkMBA+jiokG8lCFUIyvUXdVC8M92UvYBZOZzSNDXCq6xpjTGxTNqFJ+ucxmDRaFScsy1zEoLFJKY5bXm3t1JFFx2ydUPjdsZXHjQ68MLd08RwC3L3ge8o9bhnPoYOSLa+lw4YoZZnAmON5vzOTMKA33tlO3OkE3KZCAYxf/UrkV2AuoSsMgN7gxx2LSnwqBDKPiNSO4lx24pMAPpD5D2UEhYtn3PCHNXbRljb9o4CD3a5UtJMovoAwBf3S9LUNqBivCCLZwJj7nIY6JTp7UYgWVifTJ32H+qGVFGNmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2WWPnhVMyLkY4KhixVxW9n04gCquFZFiB31j54kx5s=;
 b=fGgYDOj7//GwcansoZ4KbghponNeA04nL3SnGqZkKnZMtM/b8KLn5cDeoVgp3/wORp4n5U4dLRT0FdUEH0kC7JzbzMraMwQb2q0w8t0p6wI9aq8d7iE3zG4AgTA2diojBSe3HNOukry31IN49+eUhoZCT08xKrtKcpzv2SeEyyM=
Received: from DU6P191CA0067.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::9) by
 AS8PR02MB8616.eurprd02.prod.outlook.com (2603:10a6:20b:54e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 16:49:42 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::61) by DU6P191CA0067.outlook.office365.com
 (2603:10a6:10:53e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 16:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 16:49:42 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:49:40 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 18:49:40 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id CA4811F0;
	Thu,  3 Oct 2024 18:49:40 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id C8C7518E1EC0; Thu,  3 Oct 2024 18:49:40 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Thu, 3 Oct 2024 18:49:31 +0200
Message-ID: <20241003164932.1162049-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241003164932.1162049-1-perdaniel.olsson@axis.com>
References: <20241003164932.1162049-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|AS8PR02MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8a4bb9-84fc-41ce-e746-08dce3cb60df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ykhF9AmeXuagltTPtkTwGc+lTYnqezi3mSvWIYPxoHo1EkyghFsi2kXZLOdA?=
 =?us-ascii?Q?Hdb+D/K+clIuD1BUtQ43IJitvkaRIyVmOamluDe3EJzcK6nm0cekzdcI3BLd?=
 =?us-ascii?Q?jPvgB8EFVkwdc1VM8aSqfH7ls012jc2itOJcT8VDj/1oHHXF9+MwF5z78VrY?=
 =?us-ascii?Q?gDAAHB6nB3SlxPUHm/44uC+QKU9PpNmIEnsXgp77ecKZh7djC8q4iAm1bJKR?=
 =?us-ascii?Q?pqB8Ub/HKhHxsz6fIe/edYP/FQDgaP2gdS0IYOQ5VFaehkd9DamNoYUx1P0n?=
 =?us-ascii?Q?lxwqtG+RVujsdUgSMna5TUodVpKbr1qzqiyL82cZu226elXsSEtizE9f2rP0?=
 =?us-ascii?Q?X2KZvGxrGv2p2Lpog7kcBHj+WWUxdDbQIYILhFTLwEY7jbZwo8lMMnel5iMR?=
 =?us-ascii?Q?lM9v/ACSSMYEhebCffAZqjB8geaIjVJoPI3T/6MsQIgKBEPNvMtFmmXyteZo?=
 =?us-ascii?Q?4pCi9wVz8cgr79kz4RQbJuZqdF6ZuGsWlyXQrfHUEjD8Y7LM8SuNgyYP1Sv6?=
 =?us-ascii?Q?7+PWAQZWwkwp05KWvMfvKcCxmtmo30ikfQ/BMS+SpAjPrvkbx35fNJyGZfgY?=
 =?us-ascii?Q?23ljwbUlU+K19uAvdfde1Jd76Qv5U/JQYiKFl5hd5ZAEc2Rqm/0mDSGxO+sR?=
 =?us-ascii?Q?sfk6Dd8BAQCBLewSPK7BxZI6EvBePNzuQ3DsOrichkXN88GaAfRULWZ5tzQ+?=
 =?us-ascii?Q?eo98uHPcV/rj9Dp7yFonpvwWPWcvcKp3MQanAoz7Lo2nIPpay4W3ze3KW4Zc?=
 =?us-ascii?Q?vU3D8YObtmlFsA9xbObzbDmO2H5ta2Ewms6oJYT559N1eauOLAvM2Os0Sv3b?=
 =?us-ascii?Q?fvX0oYrrdJGLUf7WRdauc946d1SitXzkxHrjEL+SFW16Hafn7HhS+fdaSNMZ?=
 =?us-ascii?Q?suhFaPNj0ciWk8h0sQhlMSRpAByYuJjmWTCoJxkD6Apukix7vj8McJaLdCGL?=
 =?us-ascii?Q?fBMK3atQJvyRt9uTvKuTKGyg5vf6PBtV12vHbrColN6bjE4KDuSBS0k/u6JL?=
 =?us-ascii?Q?XgZEmUTp07wNCBLBpf4t8k1tOxQxhjxfblelnn8eadWWKSU4oItLf9468x6t?=
 =?us-ascii?Q?8k6NasAG6bomM6nusaeZB1JCbASgkDwYMcVkGzLz3IVBilDa2gMGiaoYc5EP?=
 =?us-ascii?Q?ULpZG4HT9B8QUk7trDbth3vWdb1M8zCis0Fs2ZWMogpi4PcXit6zNuTqFvI7?=
 =?us-ascii?Q?1k2B9C/uT1cCaAiDppUBVzCA+ManJWO4BrzTq3OyO4zEgaahdwlHS64vM+jU?=
 =?us-ascii?Q?2qqlVQLqhLJEDEtax50aSwWwj/rlK8b/hf5Kp4nI0OMvi3u6TR5jqrdw7GRm?=
 =?us-ascii?Q?ZIYoPjX5hhohI/dclPfhihZJ?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:49:42.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8a4bb9-84fc-41ce-e746-08dce3cb60df
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8616

Add devicetree bindings for the OPT4060 RGBW color sensor.

Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
---
 .../bindings/iio/light/ti,opt4060.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
new file mode 100644
index 000000000000..28fd5136454a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
@@ -0,0 +1,65 @@
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,opt4060
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+    else:
+      properties:
+        interrupts: false
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
+        opt4060@44 {
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


