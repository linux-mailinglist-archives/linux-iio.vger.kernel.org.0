Return-Path: <linux-iio+bounces-20674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE59ADA001
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 23:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194C7174D34
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE29204098;
	Sat, 14 Jun 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="nBObxMwF"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012028.outbound.protection.outlook.com [52.101.71.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE8202F83;
	Sat, 14 Jun 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749938219; cv=fail; b=uHhMko4f9vnG0SKgdJXXbhhoHNzV5pzlFwwg/CkJ0Qo7vA6UkIUhUNslNizPMORcnTZYbx2/5+C/iuMQsfE3zNdWMmAbm3IUFruXBPCPUj31UNhWi5o1Jxwk1UFrk1dSINX2NP3qCDVXxTI7saauvwaKvBLuwmflSWOBaifrd1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749938219; c=relaxed/simple;
	bh=jbD5vAQPa3VN9DJQsqgaxKlNT8a7edxBVaBzztblK9k=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=IZIflcMLBk4ulJE9XgSMtaaE3qCD8gT0+9C/MWZJ3kSg+cxyMSMIGEVLVfqeDQG156CMHqySDGcIk2uUn890vG2GqxT/BV/Ewlp1VH0I1gfPVrX0xKw53mqyOagZ4gGXdtJwZr8+PH5751e0zOthzct0KHfHeC80wPlq5eLojGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=nBObxMwF; arc=fail smtp.client-ip=52.101.71.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YACAMVumtW3erJKaG5OPBfKGdkITD1gIb26pE70vCweKtdfGZXrWO2Gm7gTungD/CV4NnmcBIqZyL9xU0f7Hc6RxFxP9NnPvdiM2w9gFf2/HftotESRmIUzPPVEmFvhH7SK2o+FbXJxNNS1hOv7QkzsLQlCZsHLzzMrXYLpDex90k8tWyqEsBYJR3YRzool1/134t2uDz27s+0ttg/RW+Q17FrUhJU16+4TaNwnG16dpKSqL6DI6j3HzyoYqBRx8veSZuV/a1hMyGAHmzA9wCQy++7dmJxjsoRjIDX0KWkLTH9iJy01e8t1i0LTgN9oPHEuTZ8LpdKEoy28phpsLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JiRRQgcTI57yVLLv/FJDnC9f49UmWo0z2cgM96pnNw=;
 b=PfXkg/L91M8TmCS9H/+FPxfJDVaC1txOgWz8tIstfSnoJHGgScLqt4auk8VMbZMsAmpnDMh4qyEzl0eL6EhXJyEUMgjryavQIpHYdp6LLJX2aEmcFzFuMGhjHZA5LrIW1GTPx/pxcyTiGWQHyXIyRWlSCCtTbkMiMWgGMwXtqxrb7xqwYzU0cXPWbdT0wmsNzTWTbIfXEHJXDIL5mItZjTQVx+EkAvMaPdaCACNOl2P4ZgO05ZwHSA2RE3R5pSvixsImdhWFLX2RgYHgiXoTbRDN8F+cupOHNfxNexQYD47y0g5OJMyv4e5I3K/2Fm4xtGjCZ2jBfgSd8oJAkJyz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JiRRQgcTI57yVLLv/FJDnC9f49UmWo0z2cgM96pnNw=;
 b=nBObxMwF1qGVDaig017LX+Y0oZiweZjQvodKhiGJaKqALGxlCO96UcsX00HoAqhDzOC9umLUTK53KjrV2M54Gvq8XwUfdbTqPpyMWp5wsAdpgDDpKSHA9uFdrYHgBrlqO/K7V5jpItiU8H37Q4ZSLTMJaG9bK0ZhD88RDA+T97E=
Received: from AM0PR04CA0084.eurprd04.prod.outlook.com (2603:10a6:208:be::25)
 by VI1PR02MB6464.eurprd02.prod.outlook.com (2603:10a6:800:19d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sat, 14 Jun
 2025 21:56:52 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:208:be:cafe::cd) by AM0PR04CA0084.outlook.office365.com
 (2603:10a6:208:be::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.27 via Frontend Transport; Sat,
 14 Jun 2025 21:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 21:56:52 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sat, 14 Jun
 2025 23:56:51 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR
 sensor
In-Reply-To: <cover.1749937579.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <e2b1b56fbee07047f3fb549f17257dc3764af395.1749937579.git.waqar.hameed@axis.com>
Date: Sat, 14 Jun 2025 23:56:51 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|VI1PR02MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 551fdca6-d39e-4589-64fb-08ddab8e5f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPcIYZSb4bmn2mJZoi2R/cvPWZyCzhY85IY2hTVdaYYg2KS8cQTN2FaYiCwy?=
 =?us-ascii?Q?XXFgGy3IybtUdv6StW8FZP8DjFbpYXLeVEkakzjYUwT2tQJXBWfQgKszslv3?=
 =?us-ascii?Q?GqKDc7h0IRHiDyM8BzWeFQfWP+jy5UIvTfu1Bted8Ccq/DQdjDIJDRlEgzMI?=
 =?us-ascii?Q?tNNV7VIHZt9eQRVtl52Rg3A9v8+EUZxPwWHdZtgXrUBQeiIxbKcczSoF1Kmt?=
 =?us-ascii?Q?0BHi6ViWwLMdB4qizJUib8oW6GIKLg/nh9h+yQIHuSrINL86AYBAOBWOfreZ?=
 =?us-ascii?Q?oZgFLO1YcRGFQHOpTTqGjcki1tkRxU41kVxjLDZ0NzXJM0iLzU7GJI5f6LPd?=
 =?us-ascii?Q?32mckS9HFFSTLBkWfhI4x7OuxPnFmQ4Va+dPLypx+ndS7c+5hI7d0LWFZ7cl?=
 =?us-ascii?Q?D9DfEGxSrc3zmOvVga746uAmlENbTQPDiTPAgEqEqKuZNNCAS/Zftp0KVU5I?=
 =?us-ascii?Q?x9gyS9bhCorix/v55OW9LYioJ+Z+0jJKXw6IoNdJJdMGFxldXKM6J1oIFRfJ?=
 =?us-ascii?Q?H6MaDssrlW43z30yWzR6QeJWyTxZ4xtiQZztmq6251HcupmigXbWE4+eCAaq?=
 =?us-ascii?Q?skeknN3Ej3AxFslITEdVGPGcSPd6YlumQ6+YyVINh1YPE0jDPBnol5wLxETN?=
 =?us-ascii?Q?5GHAfw94xPe7wAmHuhCDjZqlCm+at+VliAWh7U5sznlZjQRjXFevMhGHgJtA?=
 =?us-ascii?Q?/xRMWVp+12qGJ71gqDip8N2RXbnF9QMyMhPyZLldabWQ4FYPetKdmcT5EEv3?=
 =?us-ascii?Q?cPLkSaUr7Gb87jmLZE18w/RbBh7cbiUZPcxhFH91/eNpkrapaQLsAuyMp8aA?=
 =?us-ascii?Q?xKIszKoC0P7nBefGWr+yicmcnVlW6kZ+AFRFQjGdClpabIuzwBdxOi+e4UMD?=
 =?us-ascii?Q?K0W2siJSezxpe4SoLs8RCpAfKd8MjS7I6gSiRiTVDq89fjjNMo+l/U9hgZi5?=
 =?us-ascii?Q?sXGlC2JG6U+8jfi17SJEhVc/ORMbVnnUJsfqpfwWpXDxw9aO91D2w4tIbuaW?=
 =?us-ascii?Q?H+MW68pkECN2El/8ZppfDnSa6qVS1UYpbAvRojBKWcuQplDiUjLQliOS/HQJ?=
 =?us-ascii?Q?nwPzP20xSYDV1F4/0dZNT0Mkmn8YeFYeGsU3pWcn1x3PneKAIvGbsevQ4q0C?=
 =?us-ascii?Q?9yKlsdOWtzimn4m8Mf0+5ROl4j6bhF6G6pBzY7jXa4dNA7lrG/zk49wFZv4p?=
 =?us-ascii?Q?W2Ha+UwWIh1xzS94BiMAkEyKfc5Nwl9oAQ1tza88hFfu2okkhZv9esXe0hZC?=
 =?us-ascii?Q?gaph3rTvQ0+Ki9qWe8c9msujm2VcNCco6rVh82TQcebMa4tRfIrIpLNAZEAw?=
 =?us-ascii?Q?F5lgkbiD5E7szD1w9OZGdZf6RbPSHNoDf/vFbldqIGflFz30v7lDyR3bjUMu?=
 =?us-ascii?Q?debablzsp9/lA6QfQELO7oNaA6P14ya7/eS36o5HAPgibdT4TiQWIDaDGD8g?=
 =?us-ascii?Q?EpsprAOQRZP7NdXYq8BsA63zHUD6BM8JZTSP/GX09CrvNbEuJkJ0mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 21:56:52.4449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551fdca6-d39e-4589-64fb-08ddab8e5f0c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6464

Nicera D3-323-AA is a PIR sensor for human detection. It has two GPIOs
for detection and data communication.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../iio/proximity/nicera,d3323aa.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml b/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
new file mode 100644
index 000000000000..01c084de96c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
@@ -0,0 +1,60 @@
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
+    proximity {
+        compatible = "nicera,d3323aa";
+        vdd-supply = <&regulator_3v3>;
+        vout-clk-gpios = <&gpio 78 0>;
+        data-gpios = <&gpio 76 0>;
+    };
+...
-- 
2.39.5


