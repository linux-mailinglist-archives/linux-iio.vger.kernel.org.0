Return-Path: <linux-iio+bounces-15062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4482AA2A0D2
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 07:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A793A8864
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 06:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB9224AE4;
	Thu,  6 Feb 2025 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RTUFUP9z"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B52248BB;
	Thu,  6 Feb 2025 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822579; cv=fail; b=GNw3zAgj+v7OgOJNlpkLhXGxDT5B2bcn9JmUtKpzQUuGrxkFmefvfpCXTfdtRltvxOjP1ONH4XvG3njuGzkFu7bdFyRjIgTM3mtdPE+ryquOVq3M8qThHmAyoXjEtVaZ3TppcW28pBtUHYpBTxg2slpZ2FNgV0+S09m9iui0c/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822579; c=relaxed/simple;
	bh=feRh1TmTpeZRbba1bRH0QCCmN7kdfi2pJWVCPfMOIwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPRwFSUTN5NWJSFa+amFJXoidggHUFWtOLbvUWYreNxJok0KCTQceVaSWp1i3nX2gn1gyYpO9H+cKdYwr0dVUTA3xrTEEElplp7wYXc+8nTbGa9MqldT1soBTo/5fO3c2bXdQkTXIJOZwJozfyfIIc1hw//LAPddpr7Qz4DguJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RTUFUP9z; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFovdZop/IQ20V1bigiafIkBLDMgEUk2TI+HZWNw4gyaRgnBl6jiqlR1Tuqc2OII+yoaomTjYzXteKo2rlaOZEWcbsRC/SD5CDXzInMl+uWSG1d1zUT8q+oHxF2OoAhqfbWtaGlCNHdCPPod5wwcDNEhNSFJqqtsaifg73hDlpbAGlE75ViVdQVJVKE6+O1vvr+T/wUmQIN/vwe0ma62mEGJoiBUl1DmvR5OCc77I6QFBR46jf+zQePQXRPW2TVLalw3nAo857uD3tkIzxYaP0ORviJG+3sF6ZSTW3CmMJ6PXjXawoLtuguz+V008e0O7zOHsjumS2GiqfvcKQMD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzRHwIC4yEmlDtSWMJu5IvA7/s078x83bygNMcFYI04=;
 b=plaBze0WtwcrFI7Bd+F+01SobZ+TqYTw9/Q37PCGvrBDdQMjhKOwFhrlbITk+Rd/1uEIJ6Vy6jKcYO+MSaiiDjS3ZdWoAfRDUbV/AM2tORmPvhgqz4gpsg4UEggFKBhXcnkwXL3hjH87RgvScod8khCx8hMLUtf8vZQgmKa/V+GFgilY7xWaXl6w7Q07QaNT8Fjln9xkNp612OXDzw7PC7b2mqWkiB1rJ/FoLEs1PXrD4tTG+WG7mkvAAzoYQmiyWEkh9pM1BzFh+y1kqZ6+BfIufgXLXM/GB76YJbpD245uRHHjaOAkNBLMFaRMQvRRFgaLYsASB9m+Mv15X4jcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzRHwIC4yEmlDtSWMJu5IvA7/s078x83bygNMcFYI04=;
 b=RTUFUP9z6uH4ZLqrBQl0ctw9nVzmmdzTV9P4jkNctUDpYXln+Ramuyk1fzgNJ/rEbQlc5/uPlsVF2kwa4GBxfEM9nN+SKOO6dwJuAXhzHGzp+EC33rHGcvvfBjjQ3Hcf9oaSNpbMEcanhUq4CazIMLDGu+E0lJLXd3Izgv1rqoI=
Received: from AS9PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:20b:46c::15)
 by DB8PR02MB5932.eurprd02.prod.outlook.com (2603:10a6:10:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 06:16:13 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:46c:cafe::ee) by AS9PR07CA0007.outlook.office365.com
 (2603:10a6:20b:46c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Thu,
 6 Feb 2025 06:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:16:13 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 6 Feb
 2025 07:16:12 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 6 Feb 2025 07:16:12 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D0444462;
	Thu,  6 Feb 2025 07:16:08 +0100 (CET)
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <lars@metafoo.de>,
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Hermes Zhang
	<chenhuiz@axis.com>
CC: <kernel@axis.com>, Hermes Zhang <Hermes.Zhang@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: iio: chemical: sensirion,senxx: Add yaml description
Date: Thu, 6 Feb 2025 14:15:16 +0800
Message-ID: <20250206061521.2546108-3-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|DB8PR02MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: f28d82e1-eacc-4f2e-8e31-08dd4675c1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8zjKVZE74fIPFpOffIJfag9vPIzBPQ6YxPugwoHejl9pd1gtpLQPwHfAYh4t?=
 =?us-ascii?Q?WtpqpSA5Of2TaFEYRL+Dj9NEukSG5F4c8FI0UZG5Rq4xdn2bnumw/N5Gxd65?=
 =?us-ascii?Q?7G6/4Xl1UyPM6kbz/tlCxoNgsMK8U7GKsR8rWv+lKNOGBaKJRMHpDfGVMKZA?=
 =?us-ascii?Q?UTjK8hvvAc6X9gRNiAGd5+HqpC9TWmOITfy1BHYOTbrQgMz1V811nkLzH+kB?=
 =?us-ascii?Q?ycOwnqjryMmkG5JycQzYVIGrBnW/ioMGTLmxXWSbQA9MaoBhOD3nXiH9V0+r?=
 =?us-ascii?Q?HQEFm881mE7W4zCWMP4jKe7+ng7zesXyLedSNQaaO/WOh5rn7NAJd1xia+7d?=
 =?us-ascii?Q?0f4OkwgeLUrUZ4dDqBJ65cxWQU5UkstCiAEyiyni+NATWsuooAlufQH+DcT/?=
 =?us-ascii?Q?S1VlFTMbJzK/YI1MnbXAJ84Jd6hPilZlgi8/k1lbbZ/ErUlGuCf2JQSAQCdL?=
 =?us-ascii?Q?CKQkgms5gb6Bgg6Ure+D4O6iaGKK7J4o/t7XC7xcG/jWYCSKe1BgCI/nEsmD?=
 =?us-ascii?Q?u89EdYBT+mMm7YVVp0TSiwaCBjrAC9E+p/ZX5phV9qIjjq6j6xpRLIypR8xG?=
 =?us-ascii?Q?cP7G2KYeK8A4OMkili79x3hQfPS6jLgyB2KFX28aUVb6N/XqAWK0m511lHRO?=
 =?us-ascii?Q?bBqpvVz3gPTxgqcQV8tIEkDm7TBZ2V3mxaMw46Eik8NhKxeHqcXezAoIHQd9?=
 =?us-ascii?Q?hHiLjDgiBtbs+IxE7VvoFyVqxbljeVYMTgrlAihEKTFUldBchb9ksXlFzJW6?=
 =?us-ascii?Q?0lqI1BHtG1S93e67OsX1loOowf14UKAmkV/Qnrj6/1WWY+loasCgcJk2imFG?=
 =?us-ascii?Q?N0T2tYmkUmDNWmtviepPrEwciEgcMKlBEThF63Xekr5qo1nOcKOVGD2oWwZ0?=
 =?us-ascii?Q?oaD70TWnmtZPNagX/YN9jztwE6YJkQ6ClOtXUvaUqP3XEL1RzE7TWtq9yk90?=
 =?us-ascii?Q?OFOwWj3wJJjcxO/FW15X/P0Q5hMguV1nWaMKDj7OTcHAOWfpUcf++w0Zkh6n?=
 =?us-ascii?Q?tZ/FcD3Y7/RhcpPWp2tnhBzPlZkjHWCKNtcqwzSDSSRy2hGuGHskKODot12d?=
 =?us-ascii?Q?Lu4eKM717wfKaGPwRD5vaXkk90RwZ2lfP/7tNZ+m+2eUxCBHlwWgNpLMbMgK?=
 =?us-ascii?Q?gqqZm583D0sdEJwYUQl6q6yICgbhra8ZNZaT+bt4mWZOMh3SmFb2nvSK6Jzq?=
 =?us-ascii?Q?WCLujsPY18qHgkgpKRNPs2DqGobuIPdZFwkajvveT50A8962a7Ew7w5NRvn0?=
 =?us-ascii?Q?8OU5HoY6NTd1RdMaDZhZgQ01/2uRFCChKvZzfQRISY6z7QugjXA3wVEVTL2J?=
 =?us-ascii?Q?6bFA74kCB4uD0kNDe+1+8TIlR2K2DXIC+eV9uE2eItxkGYXnWr7hRQ6QQgMx?=
 =?us-ascii?Q?AcPz8N88A7LWqBAgyQohlOMBBTOg2wXnWXjrbL72INFrsAhvLV3QcFa/l6Hc?=
 =?us-ascii?Q?nSWaGyOSspE=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:16:13.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28d82e1-eacc-4f2e-8e31-08dd4675c1c2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5932

Add documentation for the SEN5x/SEN6x environmental sensor from Sensirion.

Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
---
 .../iio/chemical/sensirion,senxx.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml
new file mode 100644
index 000000000000..4d998eabe441
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/sensirion,senxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SEN5x/SEN6x environmental sensor
+
+maintainers:
+  - Hermes Zhang <chenhuiz@axis.com>
+
+description: |
+  The SEN5x/SEN6x is a sensor module family combining the measurement of air
+  quality parameters: particulate matter, VOC, NOx, humidity, and temperature.
+
+  Datasheet:
+  https://sensirion.com/media/documents/6791EFA0/62A1F68F/Sensirion_Datasheet_Environmental_Node_SEN5x.pdf
+  https://sensirion.com/media/documents/FAFC548D/6731FFFA/Sensirion_Datasheet_SEN6x.pdf
+
+properties:
+  compatible:
+    enum:
+      - sensirion,sen50
+      - sensirion,sen54
+      - sensirion,sen55
+      - sensirion,sen60
+      - sensirion,sen65
+      - sensirion,sen66
+
+  reg:
+    maxItems: 1
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sen55@69 {
+        compatible = "sensirion,sen55";
+        reg = <0x69>;
+      };
+    };
-- 
2.45.2


