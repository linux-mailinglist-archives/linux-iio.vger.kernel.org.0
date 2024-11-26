Return-Path: <linux-iio+bounces-12679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F43B9D9910
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 15:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FF5B294A7
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD61D5AA8;
	Tue, 26 Nov 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XcFOnAeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0ADD528;
	Tue, 26 Nov 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629616; cv=fail; b=Kq4Lzr0sgHuVkZY1vKhWlJcEuFxZt9pYkmpvgiYagdSZbF7d3XQpCWPUIJUhM1ui1dXYf1WhR8ln0HMQnbHbUfMw5ks0zu93fIv5C+1TzESxv7mzockRFIrNgJwlpZoa6EW9b5FMF/wQeCiKHyYMojprYiLLp/y/ga6pnVB5oKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629616; c=relaxed/simple;
	bh=cOO4/N6aVs3iJ6Uw+f0NbtEPxMMt+7oMD/LuOrP1Dhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLqErl+cag3/bwmvRpvz0904wWcObr7aEBQu5Lnws4O0FcG4rYVeU5pkK8C7y9mPUcGWWyYOTwPzucwv9fPpGvw+7hUmJDBeEJG7aklmPIkjJbWSiIArMh36TzfHgBj8u7/D7KREh6f76m0ndD72UejZn61VD2JDopr/LHkkSBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XcFOnAeV; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHU4wHsEPjwTlzSRpWN+OL4OrHB+pPaSPiLZteKCMA9FtgmhO7h3zrswk9l5C3v9evIGqHT4kKCbUriI5Y+isx+gkcYlFyFU01OJrHZSOC/bodQawSFMEh/C0uQFFE1H0zGH3sNoT8gxL0JgLKC+jc9EihXLzHb/x+Y1hqxLAwGRdZrolce7QJxfBUkjPoWR2EU1iOJEuqtqcdhDKrQvEWLd8Zx78IsiwcqpkNXILBTNJ3j5SGEX0wMu/VJNC3sMIgfzwg2MWaEjZHKdmYFaHr7qRWJweft2WgminYOYgHHHifht3rKr9xbI6gOOESofWOYv09BfLhjdaQ88bSezyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmCiKwOQdYF/AAxdsmLO8HObvnAItZjibrdeJBRyHyI=;
 b=wPkqnuDAe+FCYpkexsW1iKeiRgc93oUIbvFnDah8YK7j3V8J7Pj3G6tkjwSJu0AMUhy4ZpXdUDnzpcvyI0gBa0rk8E0qL9gKrEjB9dZsynw8uMo+gJ9vlMLoytfec//G6Mga57IzbfAjJKoEAL7Kv5sC9dvU+gMcOqLQa0inox9THEAnlOSQqDW23aKzZnpFuZYI/mg+wxUQidwnfNqTiUSkjSvtgDn4sS0ABbEitqXlewJlG8dMS5uVDfI0JffdkjF3GoKhoiBkAZcbr1XuXpETOv9iJBg8N9G5tJQXTU3JlD2iWeCJZjhZV+d3QX+KKctnBvMX5COdbH5EINTHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmCiKwOQdYF/AAxdsmLO8HObvnAItZjibrdeJBRyHyI=;
 b=XcFOnAeVna6W0hZsfmmEbCEoSt5+5PzZ/kMFURLzhF/kyV72IHEe6kpw4/aD/vpyV+dOYhekD8KJu89Hpkzi2e6QEgs3sNIVNEjF8FJc/2itUt+KNWAgCCgvM9bgHxXGTx6MafZaqiQdn1FvuKnBYloTieZ3CmzGqQZ7OwNLUU8=
Received: from DU2P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::22)
 by AS8PR02MB6982.eurprd02.prod.outlook.com (2603:10a6:20b:2e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Tue, 26 Nov
 2024 14:00:09 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::9d) by DU2P251CA0009.outlook.office365.com
 (2603:10a6:10:230::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Tue,
 26 Nov 2024 14:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 14:00:09 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 15:00:08 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 15:00:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Nov 2024 15:00:06 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id C04181A3;
	Tue, 26 Nov 2024 15:00:06 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 9FA8618E1ECB; Tue, 26 Nov 2024 15:00:06 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v7 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Tue, 26 Nov 2024 15:00:01 +0100
Message-ID: <20241126140002.1564564-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126140002.1564564-1-perdaniel.olsson@axis.com>
References: <20241126140002.1564564-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|AS8PR02MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 7608664d-4f1e-44a8-c492-08dd0e22a3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E/eSndDcwf1XOLiAEI9gB2H5Ps6UYAeOL4qZUB2lkyxFpA/9+P7pj4QdhJ4S?=
 =?us-ascii?Q?8/X8wNJNlbKBRp8q4dqplrxBsTMoHVuP8M3tkD6GM/1sFCJn7qSZ1xWF4vaZ?=
 =?us-ascii?Q?PM1e3SUPPO3sfhEiA6m3QovjXyHo1/kTduHhHJ9A5tABFhPyw2FT3vBl343Y?=
 =?us-ascii?Q?mRvLz0b9vYFpStmwBNQcAuDcutzDiQMe/mPc8i4fQL+SQgC8hlQqi9C26bLY?=
 =?us-ascii?Q?JiI4Bxqhp4J60Znk4ImdmyxMdx0fFgN6wCXQYLhJv+PeqzxStrRQm+OP5WRp?=
 =?us-ascii?Q?lkhkN/9byUbvG3RhcolF+p9c0tfLLzULmeds9vWlN80mm1W6JJ1m4tqSE9p7?=
 =?us-ascii?Q?24AC2QFIm8JNyimIJ6UVLNKILv73b+KYhoZQeauVVbuBBbk/AxGMOHCfUaeZ?=
 =?us-ascii?Q?sxJfF3k6DUa0HPu8N4qtY0F6dRTcezkQbVIIJfjxKtBHNV0W8aOXp9fVJ5G1?=
 =?us-ascii?Q?qeP3BGlRD8gDXLaB6S7mdw08a7IlEYsRA5ghLYmGoJvxkuNvATiob6hKAYUv?=
 =?us-ascii?Q?fJvnjnP5U+XiaqdtJM2spZgZv59fDgu9e8CrGq/Ejswt2iAP28JDmNciM1gb?=
 =?us-ascii?Q?KA/MG+PQIgYDHRAHoG0hhaAyRYsWRKbFMIt25ys8fTCAsPWmBqlZdoUBjKfq?=
 =?us-ascii?Q?Tt58kF6razGv2wq4AbC+LbCZZAB1ahOsHazhOP2kDA+QJ0XTLkI9cfAtuTUe?=
 =?us-ascii?Q?yua6v/VZGGsuXbI0kOcW9BLHYt7uWXjw4LrITegIy/4l/ccbAh2EG2ZTd5HY?=
 =?us-ascii?Q?mDwTrGys3gwW216I3Rq+jUMAp0OC3M1ZFlahP09LnlcBL5ugJLAoKDfFiWlI?=
 =?us-ascii?Q?YcRjO8QHgwdBmNSCkZkYmFdTcXXmukwQW5dt3CnPmx7qcoy3agOhUNvi7Aq2?=
 =?us-ascii?Q?r5iV4YdRdSTQ9Vc3a3SCdfA3c5REqgpN3O/oFdIRK77egrwJ1D/KgZgbGCXC?=
 =?us-ascii?Q?e99pt7vDljBaPKnHaZUmkunPzOQJhRJmKDcMTktJ6ApDmd2naoViqShu7Tc+?=
 =?us-ascii?Q?z7XlvNeyveuBzge6PEEMx6BvF9Iu2za2rISrlKrZjs22aIwSg1db+V2LJZ5x?=
 =?us-ascii?Q?fwLxGFlgjnvdtzH9IempAppyGKYSG2XXC/EYtzAP/WoHv7viilFrGBeO4T7q?=
 =?us-ascii?Q?o1o1WrVGcR/9xQ3Munyxzz0tFW45LNDSwVpKdlepm9/da4JFxQqPb8xel3GU?=
 =?us-ascii?Q?VfGMRJWqSPOH2Z/Zq55cv3XdDGv58rlvqWiqlz7O6Csz5Rne22eaDr8SW9gB?=
 =?us-ascii?Q?ABX3VmQcrvgrajTP42hjLfKNfwr+1QYS5xuodGU3qEInm1UgBAV6Rv6eS/n3?=
 =?us-ascii?Q?Oqz3LNwcZJrC6tMCqQhlYRmHivCB6lu46G7CMbQHSaU+vhTX02dYJf/zu/f6?=
 =?us-ascii?Q?iTvNqfXTj/oj3SuIcdr7fCIDNgGBzSVOHqmM25DtgW3hTIKugg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 14:00:09.8716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7608664d-4f1e-44a8-c492-08dd0e22a3fb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6982

Add devicetree bindings for the OPT4060 RGBW color sensor.

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


