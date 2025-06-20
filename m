Return-Path: <linux-iio+bounces-20791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADEBAE12AD
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 06:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A27F3BC8B1
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 04:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF3D1F866A;
	Fri, 20 Jun 2025 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="UVdCW7QR"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE31E1E1B;
	Fri, 20 Jun 2025 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395374; cv=fail; b=BgRceVFIm8kG4VfBSt6mjgaNoOTb0zPh6QlJbdYP8MHCoOheD3Mc7gCiLbyEl+pW8Jsni2IkzHXSQHjGHVZM5MkjmvCF6DLSpm2JusHFodNZib6RqO/mCGRi+lRgTS0xhUWqLVOfuuEQJEQ77Wb6r0IuwuB8md5XlK5cqoCc9+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395374; c=relaxed/simple;
	bh=W8ugDt0xVfN60eXUOgKWcbIdgjHsVLM0KeKCQV0Bx0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7cwaoLqdl27KgbQDpUjrx2xi9+1ixFynSIcFq86+gZairD0IhuMQ0MZNsz3vKWNcpkzRG+7C3THqsBgatTDXSKyEA5OGXFWYHBULsQN7Zml9oH0Lvxk7VdG+Me2clQltedAa57+D0GL+//QqbZUvjONz+b925/mvU2jZ2O7Uqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in.bosch.com; spf=pass smtp.mailfrom=in.bosch.com; dkim=pass (2048-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b=UVdCW7QR; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzXyz822PutSbR5WG3OjIN0XVdNVdoyU4OvxC5TaJ+I/PzGSM7S7trbYxVQk3WDVcn6yP7P8MT6KACltRkbutl8NR25BqlH1gi0Zj1C1MvH6O6Y1ee3m8DS8FzYw3Te6/EbPezXQmEp1SK5+be6I5ekxHV0vPkr26Z8VfPXfA3GWnac1OHHOXVAIdiUKoxCnOu1qwGpQDBujc6Fs55gIEhSzAI+XlbZ2Ywm5YlVP74ZkV4KZ8ol7a+WT3eqn9xaMTiOHY1gLdqu+Ssle6TZ153AYp0d8dqS4hLyEmQSBNnJ6dpKxxK67dWjjyoxiS5BXuaZ93UTnteuzSGDiaYcIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irOd/G1EqhWVkE9ZjPuUjQ0SR2laaaNHjpm9JyCAQQ4=;
 b=wrnzyxdfSnGZlBfQ8NfQD/i0JtcJGVKyFg+XUvLUZgFcKSBiJfjVYMr0aNjWtVUbJAeMnX84iIzzHyIZtfNZN/z5CpcWIp85vqPAiiuBjnX165jZHPi6X/5MacaV5g5BELi9WUZ3TV1tuxMkZpyQ9twES051RpvvtOZw3nzoWLgFlyi745xZW2SbsEGk9/zr/i/8worHrIreJOv2DAyNnbQdxMz4SQjmtC9KIsgT6/kmDxZhSbLcfnPXuQxTnaQCmKwPmgbWHXdxnsEOkV2B+rUPDyu0cXHe1K433EJUO9bG5bOmFm4fHoptCJEe6XisU4zT1p/eHu4nRLMvkhCtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 139.15.153.205) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=in.bosch.com; dmarc=temperror action=none
 header.from=in.bosch.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irOd/G1EqhWVkE9ZjPuUjQ0SR2laaaNHjpm9JyCAQQ4=;
 b=UVdCW7QRX7fEEVRWwR6jpvGUDpaPMeEbT82jMTLWc3sN/653kfLm8qFIoqC0Yr5Y6uuJRIyHra1EDCNWnx6YXAGW2F77MoitmTTMRM4vNHvFWfrOoxOLtcsvGgxwk0daNbolR9ePhhbcwiFD0izIM+8qXi92WVnxixuKM7ENjcrEeZZb34MFzSZuZrV3KjS0HAB5+8fEfxKg6ZLAfOsGBNkM9rb0WYhrXWC4fYgYW92j+0w5jEig+cCcQ2rtz4bRHym7ATnwsFcsGLTeKTZWBP9DatwkD5gO3ESOouv7f3fd/ELfxKpu/Dxcwh0Mo9ZV0/UZ8l8tWPPa9JDcBAi36w==
Received: from DB7PR05CA0037.eurprd05.prod.outlook.com (2603:10a6:10:2e::14)
 by VI0PR10MB8486.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 04:56:07 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:10:2e:cafe::24) by DB7PR05CA0037.outlook.office365.com
 (2603:10a6:10:2e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Fri,
 20 Jun 2025 04:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 139.15.153.205) smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=in.bosch.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of in.bosch.com: DNS Timeout)
Received: from eop.bosch-org.com (139.15.153.205) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 04:56:05 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Fri, 20 Jun
 2025 06:56:04 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Fri, 20 Jun 2025 06:56:05 +0200
Received: from COB-C-005HH.cob.apac.bosch.com (10.169.242.187) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 20 Jun 2025 06:56:00 +0200
From: <liquancin.mereenamathai@in.bosch.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<vassilisamir@gmail.com>, <marcelo.schmitt1@gmail.com>,
	<javier.carrasco.cruz@gmail.com>, <Xu.Zhang@cn.bosch.com>,
	<Maoting.Bian@cn.bosch.com>, <Liquancin.MereenaMathai@in.bosch.com>,
	Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
Subject: [PATCH v1 2/2] dt-bindings: iio driver: Add BMP390 pressure sensor device tree binding
Date: Fri, 20 Jun 2025 10:24:55 +0530
Message-ID: <20250620045456.1151-3-liquancin.mereenamathai@in.bosch.com>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|VI0PR10MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ac8111-3368-4957-049b-08ddafb6c3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uf9BEJIRRN72JnQMiky4a6JSayvBLbWlj6ryaGZyjaYBsxCbCl3Y4W4sJiN4?=
 =?us-ascii?Q?v1ply2LHE2BEz88zQm1FNykwj17wADfLNjzu/PDUtCFR0Z1sS2dsa01LQS+y?=
 =?us-ascii?Q?+dkcoCr5ZzI80d9CWKEl02XfbgFh2GGPqZzjYDtQDASj4sGPo20V0GQ/AENH?=
 =?us-ascii?Q?c1sZqqZJWjIQ17el6cB5CVFOAE1ysut4QUvH+aqnVCeJ5RxQGOIxXOonB7Xq?=
 =?us-ascii?Q?Y/rSRtg3xML6J8EsMidmMcg0hd3LWrdzsAQ7kj6JGN4v/W7tZ7ohf5rCpZ7J?=
 =?us-ascii?Q?8E3hEJeqgVaQ0J/Ax5lxmBk5VAdFp/cJwZmn9bi4napMLgCaz+83J2c7wxwf?=
 =?us-ascii?Q?dunoNgbyaJEwLbxNHq9guC4vgJtxmCS6pCwDZoqZ31gf5YeuanwqQwLpOP40?=
 =?us-ascii?Q?0zhAhHsCy7KOYXCuMu4fvmWEz1KHQXunyTARKvZwKV1ViUAnPUYuGuZoP998?=
 =?us-ascii?Q?2OMJV09mT9DRgSIKadVYXi5unbNco86wQcj9fPvyWpQDWkO/Q6wl2kqYOiTL?=
 =?us-ascii?Q?NgvACk0/e/lV58Sk4ZHxqN+NrWMfGVQUshSZU/cYwEXvniPO7hf77aJ9BlSs?=
 =?us-ascii?Q?5vQbUuSLcL3PNRRokHtJc1MUsJreIyf1ITEdI45vGge6lL0tZWU7xS3jkmpX?=
 =?us-ascii?Q?XiAezb2Ca/qEP/ebuTlrPaGdRl0eNUAiGSlRXUkkAA15Ru7UqlkWykDah8fE?=
 =?us-ascii?Q?4/J0e9oNn8nG3t4aDZaA7zH3uuWifF7gAkJW2b6pekflU8UhUzvmXuVPaTU8?=
 =?us-ascii?Q?QFcGGYaeilp7O5fJoOlxwS0wirnfEia9bwp+/0YF11XZm1CE14gDJPKryE24?=
 =?us-ascii?Q?ArExO/xjQbwlQFErJRtkTtuBQ4OyePsmaKkMDtb01h7TkKzpdqlIPTh7nskA?=
 =?us-ascii?Q?4dTX64684PKDTEFFhKeUSgnFkaoWPhU+kB/uzd4VS3NOGIEftvCvEo+epIfe?=
 =?us-ascii?Q?YaU5whkiJ55ZYRhlUwzL8R/e3urCk3Ywsx9W21MbrNaQkC9vQZ/rLZiypQ2s?=
 =?us-ascii?Q?jPFWUDNLZuCgGq1XlCx1zpyw6/V2f8KhC66S6mdaJ5OXagzstWKbDFtBzGha?=
 =?us-ascii?Q?U0FjJYLUklb7aMzs30aCPKUSdh5t8/RX0d5lu5U8RTS0LVIm2VPzOAY3VMIG?=
 =?us-ascii?Q?q1sHJhKv5h+MX5jqYKyyLjzHS5b4gmXCwa8jdqgKOj9rKgVWPyVPlBPMBEbw?=
 =?us-ascii?Q?nMAwb65M52rJVbAmdLq6f90YTgqgdfmELLL1yNGEJTRyvWxk0Y1jmzsZH+PK?=
 =?us-ascii?Q?rEKQCdSlTZqxmSyIqlFpq2H8/4Qd20iewjHR1+rdMT/IE4PFYip9FRlDnH99?=
 =?us-ascii?Q?XvmaGlOy1NN6e0oA8K4AGsMcS1fN/S3FxTVGCIJtWnYt6mgxnhyBB270cCCw?=
 =?us-ascii?Q?9phy/8ciMn6J4XQDcmSxv439Q6XXnHadFhUp7GHkhk9WqZGdORfcItu3Fjg1?=
 =?us-ascii?Q?5k/pc3d1JXwewN8osMEtILga2Bzep5c2bGL4qb30i8jkgevIIhUR2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 04:56:05.8786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ac8111-3368-4957-049b-08ddafb6c3bf
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8486

From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>

Signed-off-by: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
---
 .../bindings/iio/pressure/bosch,bmp390.yaml   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml b/Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml
new file mode 100644
index 000000000000..c36c7827a9d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/bosch,bmp390.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch Sensortec BMP390 Pressure Sensor
+
+maintainers:
+  - Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
+
+description: |
+   This binding describes the Bosch Sensortec BMP390 pressure
+   iio sensors with an i2c and spi interface
+   Specifications about the sensor can be found at:
+   https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp390/
+
+properties:
+  compatible:
+    enum:
+      - bosch,bmp390
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 10000000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        bmp390@76 {
+            compatible = "bosch,bmp390";
+            reg = <0x76>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <7 0>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&spi0_pins>;
+        bmp390@0 {
+            compatible = "bosch,bmp390";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <7 0>;
+        };
+    };
+
-- 
2.20.1


