Return-Path: <linux-iio+bounces-20679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A85ADA035
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 00:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C296D173CCB
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDD20A5D6;
	Sat, 14 Jun 2025 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="cGRWjYC2"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6D207A2A;
	Sat, 14 Jun 2025 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749939251; cv=fail; b=DRUnenWqV8EWsjjt3aWwAYmdVblz/ZucgNbHyPQTX1PLidcblQvOJN6besliKXs/iKpRlswrb111wT766MswwYy7MP+atLDEU4TFAdoUddGp/ZMSLdUrQdpu/6H9974ypPcFkwbpuPzaI25YaczLMxYfrA71Z9lrO9gXi5iUVBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749939251; c=relaxed/simple;
	bh=jbD5vAQPa3VN9DJQsqgaxKlNT8a7edxBVaBzztblK9k=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=fqehtTWi3mdlnRstszpntwJdEHI+c+Qk429fP/9GGaClcN4LIFIyD9JrJNBFKyLrWliNHjNR5WItRmsoft3Nz2bh2Ltops3KHriJrBfra0yDW3QCzCEVrTEPGkpIy9opYmXfwUZIfESMPCP3Jgn2/nQuidL029HvX0fhxfl4huk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=cGRWjYC2; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfKxTX3wKqnC1kqx9o1W/MixkdDyEuogQwnjiZ8KQdm5JYQBH5kZIqiHVubKzC/WeFT4+on7nG3Ei0tsZIhXp+lNdXcsidz4rJPmCOv/LaijPDr8KJC44iB/uRN/GPMb5/M3bHBa+4i/a4wz9/SZXzykx4sk/c0K5A+krXlVl9KVHhXVOQ7uO7jmeZFKHbxMr22fVHeWcLeZTsez9mYVtu0kvXDOAR/I1v65j1u/5U5+KPL9FjYB/+Y+i2GB/nXhe0zSjyjEmAmIrLJAnmwdAgQMEkE/EqZxPbCeYud0lFBXP5veKiy1EmSaJx7wZQpqAnIpaGXHGSzJ0epAJisbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JiRRQgcTI57yVLLv/FJDnC9f49UmWo0z2cgM96pnNw=;
 b=bwU+cdWPnYcxqc7FsIflpbz2Y9a/RtxZ+VhEL9LxdkO27wbmMgLuFwBxroRqVbhjOf1H2b4sEMSrgLAZ0HoRXs4crrvI9fTR6itXwrtJBnKMumdPDluJKEUh6+vDVn91mzr0fOkhCkXAoHoAK1U0DJGlLAjjItcnq6P/iwSZEuaseoT85nqqZ7QKrbE/3yXJytYnRy5g44X4ziqkZAJfQ0340jpBOTDPqMNUYRerkAoPnPf9Ww849uFMjRPbZzwcNT6k9KNmtiPG0RmbqpkSnexXICT6YtNZLKiicegK0KbzThmBJjuWBtr3xwtXP4UXt1rx8b1YhJDeuxTyVNtDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JiRRQgcTI57yVLLv/FJDnC9f49UmWo0z2cgM96pnNw=;
 b=cGRWjYC2+hiqBtyXC/ZDqZ44dpZQ3ZaJKKgJAsQTIW3hrPTeuCeCBaRTM4v7MiASYucMCj3NujebNxzyxabhyQeLth1hVaZvVm8Ww/XXGzETQrx/VuGDVqi8zGQ5rtafOJOKx+TBVd3JkqWuls5oGQqbGGZSUTnduLRydg03TLU=
Received: from DU2PR04CA0231.eurprd04.prod.outlook.com (2603:10a6:10:2b1::26)
 by DU0PR02MB9025.eurprd02.prod.outlook.com (2603:10a6:10:477::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sat, 14 Jun
 2025 22:14:05 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::78) by DU2PR04CA0231.outlook.office365.com
 (2603:10a6:10:2b1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Sat,
 14 Jun 2025 22:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 22:14:04 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sun, 15 Jun
 2025 00:14:03 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR
 sensor
In-Reply-To: <cover.1749938844.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <e2b1b56fbee07047f3fb549f17257dc3764af395.1749938844.git.waqar.hameed@axis.com>
Date: Sun, 15 Jun 2025 00:14:02 +0200
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|DU0PR02MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c1dddd-3cfc-41e9-b9af-08ddab90c680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGmhzU7yUGhlVPa7sqxhzVPsmqsMONyZZ7f7vaXOF5C8GjZwUdYeSbkjAu45?=
 =?us-ascii?Q?dJNtL8J7G6sNHpDxYXGTWTGAI/24rQ0yZtJ9XnFeTXdJMtOe0q5bTrrVLFNK?=
 =?us-ascii?Q?2y6KEsAnQ1QfXKEB+cRYOQocDp1TxihlV9XFOM+PC4mGlqG7hlQUYKG7YP/y?=
 =?us-ascii?Q?Dyn9m/61+hUu0/Rv3auYbczoZeMYW9Z28bfnaCSqz7dfPbZI/qeU00BRC85C?=
 =?us-ascii?Q?YT5zxGHLe7GC4cWcHxKmJnYYCMsowl0CjUZ8uL1iysfvPnCAYOyFU8vIhbuE?=
 =?us-ascii?Q?ZSBofH15J+9KGO6ghJgKVyTIwm9vYFamYaYafhrrCsDAxy8R0yDXmEfiL0cc?=
 =?us-ascii?Q?DDPVrXUR5dLDWZw4bCIUd0QMY1O5251oKqWybBFstq9VA98UU5muJgXRrdHg?=
 =?us-ascii?Q?q3o3/UsnQBQfMDZ7G1kN+JM6zqVgaVafFeXsEx9lhT63NQI7ZXcACCqkGJnU?=
 =?us-ascii?Q?6/FZmoEGil1lRco0RTtTWZbdRaEg/TKfE9YcKXmEKf9IRUEO8lDbhFDNDKUa?=
 =?us-ascii?Q?55fBbz7LKbt9XDiEjW2aEvrWZrux8KorSqsIdPYZA8qfC8nrkR8MGrlktAmq?=
 =?us-ascii?Q?GsaOiysolTt/cRHqL0QzUXLk46T4Efvq4JpimuwrsSO7UlOzAKORrX6qTA6j?=
 =?us-ascii?Q?UP1DHvIzupmpiN3vOemuQFUzTEit4+WQkD+L14wwm3RGxPYXuNDHjHQMWMPq?=
 =?us-ascii?Q?5uIix3KVWkgm8I4dHHw7me1uui4wB7Ifpd5XGpTmIFdnWcI8ZJAjS4hDhq4J?=
 =?us-ascii?Q?Sv+CjikKjB8HfmjHLlf8B+4BnGZ0yC+nrVmqsd8ERvOjqHYsbs5pnabIKm+Y?=
 =?us-ascii?Q?f4tZssK4gGWvUyUIOyMGOMztBcF27M5Za29G9vdr0HvJLlzMzNd6oGcov+Wc?=
 =?us-ascii?Q?F3iEruAvhjdh1PemjO4wgvxzEeUC98Lhh/b45zz2QV+Vn9HuRZMYeCXPf8Z0?=
 =?us-ascii?Q?/pjwdz/owonoCPwnGd0b51RLh/OhXj5iAU4NyfGtx7DTKT2XNIJIm4SdHi0N?=
 =?us-ascii?Q?h8lpgamUZ3h9xuQ/ZmCLMViJLcSKCofisVdTJVJt5boCCMOfQlLy+Dw/NwgS?=
 =?us-ascii?Q?wWqIS4PXhGqj1w1TQT9fYTV17jQuYrs2hVQIrS4zsN2L/9aQKeZxRc2iE0rz?=
 =?us-ascii?Q?ggoCRZn+qj8n/zoY++TZwln8InZe4uHXn7bD1Iqob6ieEVgq9Y2/gh6ekXgO?=
 =?us-ascii?Q?l89lOYRN28RaSq8at+EJu/ne6kWbtbRTO18SpDHLApka/eD6zI0SpSsTtSzr?=
 =?us-ascii?Q?vo/IC4UcYydolT+rGFIdiOnDwOgh81cVM7Ey1SHAKM6wACyDD+y23a/uJcGc?=
 =?us-ascii?Q?TrhoSIVjbddEMSEo//wkJ2i1ftMa03jfIO1Vcy4CPWmk7YFsuNgtdZhsJjMm?=
 =?us-ascii?Q?T4Id9+CPq8IO05SEl+tzMj5JmMF3xuWZyycRSjTC/KKxbaErobhVrTlaORnn?=
 =?us-ascii?Q?3bqpIMRAFlnvfYSGFeGNBsom3t4dGxlUHVAhEfMzyq2q86lgwDxYEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 22:14:04.9874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c1dddd-3cfc-41e9-b9af-08ddab90c680
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9025

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


