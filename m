Return-Path: <linux-iio+bounces-9491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9A9977CC2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 12:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC01F27905
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287071D79A3;
	Fri, 13 Sep 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Ah/uUOlc"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217042AB0;
	Fri, 13 Sep 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221691; cv=fail; b=tP0gXraFMWa3ZDdTiN1aIWspRDLhkmCcNSegA/yHv1dNuIzRS0FsFOZg4mGxIoHmBVyfRELaDdl0d/EsMTiY2cmyQSzqYDTJnCo3adc+yNgTEsEYC3aM6TF9+tv0xhwatNjide+J+zfFvLc/ubpNcdSEaZXrEWuH2vZ0OiQLTb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221691; c=relaxed/simple;
	bh=I0vPsARZkVwWvxxQMyDE9dg7R2y7EQ5kubEv4CW6SCU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VlBAH6bd0QH83GKKujTdo6f5o+B/+/vkOEzTGm5WkjuS51YYQL+UISNqEWVNrlJiL9Q8DJOQaVpZKV9N51nyVYNt8dTvR/2Zvg0RZ7kFyzeMSugE1wWG//pEoMS1DUUeCsAyqBfaeUSo4Y5l7lGEtw/5xBsbqQnmWtnwODBWP7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Ah/uUOlc; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8jT++UqvR5KTtwRlPkCDoFWWEDLbENBvWzII59UWFCk9AoQpriQRLZMjy13YyiNq7Dj6Sx0ZZbkItcMVj8IKcxNZbukmIJ54pMaNG7EAbytPg16pjURc3cibnhqamLN+AiUxp/PR/lojERCsaSSsY9KtS8plH0slm76rs5zZDIpJ0Pur+krj6bH77szH/gapxjT3G39oytaqZLEqQSi8i3RLNM/s2C3YS033MiZSzPkLLh3iPu2qYAw++OntRGMicedMo89VRH+7LK3kjzAtCxNFAmlgu0T93oun4bEXhtUaOckhsAYY2KaEPSmn8hC+q2iaSXY1/IwzC47eociVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOWSWzmolBP0byNTklwp3+g1QD9wKTLG8651ukIT3z0=;
 b=S2GcvfS0ae07uxHpBZ28c/ysI5HqSeYCtldP6dxRDq6oqWtBcNFDu1LFHbF4Yy9M9IfV1g4//OQwEl4r3E3HDi6TZSOrbx9JYvhWuhseiJ5T3BTHUWxrhT30XolfvzKxeA8gHsnIohfk8b534obNu+uZ3kCoLmqV0I1Df6Kn5RTnbmz1wXG5NbHlVUOsOuNcK+uzZcvarL0uVGJId0+qaQ3VB9zTI4QiK3gLnVLd+RVQQYpyXNKV9NPll5mc4V2s/J0bxCtmlSU/t9RsTUy0UZ0bbZYcI70ubk7Q8ZtZXZGjj3tHQEHbKvjvvOGsLk9BojWzMATR71808mxrXrKwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOWSWzmolBP0byNTklwp3+g1QD9wKTLG8651ukIT3z0=;
 b=Ah/uUOlcV2AKysrzGQCfysVWrQdseM/rE5YhkBQkXba853MY4q2PNWpNFjPLlN9hAb7fxOFNragt2pXNDpCV7l/TyUSTaDWqkThdIsepYEsOmkAmrQ4KXrVzUrU67hL14FJTCTwz3uhPD6rEqoWdNsRN2iit34cX7W/WflZCcdMeJntDXxeLNkUkanaelFLh4Bzs0ZEPFltJfMjqWk5JDYgQWMB7Nx+BooqKclaJG7FlwARDGIrnWgIRhdKMEnO0vuDKO1qABrtQmP87U3rYtBYjB8mL9Hz09W01dleQJifmdCxBudkgYy4YROtzK0kDqXMBhYLPLUKlGVGB17A5cA==
Received: from DU7PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::6) by AS4PR10MB6111.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:583::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 10:01:22 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::70) by DU7PR01CA0006.outlook.office365.com
 (2603:10a6:10:50f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Fri, 13 Sep 2024 10:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 10:01:20 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Sep
 2024 12:01:04 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 12:01:04 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v7 0/2] iio: imu: smi240: add bosch smi240 driver
Date: Fri, 13 Sep 2024 12:00:09 +0200
Message-ID: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AS4PR10MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 649b8d80-adf3-44a3-814c-08dcd3db045b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RURjd0VCR3ZGLy91SHZYV0pvVVp1bkJtalBsNTBkNDA0MnlqWUZWeHpLb1Jq?=
 =?utf-8?B?RnV3QktobmVCYTRyblVBdFJsWFVIcDdCbVdQN1NDL3pkVks0SStrQ1lqZXZa?=
 =?utf-8?B?RVJmdXJmWmYxcGI4d2x5V3dpME42ZHJYVVBLbUhiQ1ZzQ3JtVkcxeGZpTVNn?=
 =?utf-8?B?aW0wYWN4bkFnb0g5MCtRR0lYWWt0cU9NT2JRekpsUE9jeUdkMHFJY1ZacjFQ?=
 =?utf-8?B?SDZZRFV0MXpjSWpWMUxOWmZiUGp1eVlDVVY5N1dsZGt2eTYveGQvR0VVUFVJ?=
 =?utf-8?B?VmdSeXdueHdqcmhPbjRGeEhrbDlxRkkzOFRhQW1HcWlOZXl3Ulljc1Q1QWpG?=
 =?utf-8?B?eFVhZy9JV0hOdzdCczQxTmtvR2t1QktiNEJLMmpxcjJQQkljckNUVWJqcHBi?=
 =?utf-8?B?MVdSZTByUFE2NUViZGp2ZXFVTE95YW1sVlVUOU15UUJZeTdyQjhXZFpGZHB1?=
 =?utf-8?B?elFyTE14RFdPTTdJbjFoSXFUWHE2L3pPSVZiOXhuZkhiSEN0TFNmN0lIMFlP?=
 =?utf-8?B?cEZpVTBwWTVyeDN1Rlo4OXAzd3hjZG1iRnZJdlpzVG9OdHJ4RXAzVFp0L2tM?=
 =?utf-8?B?K3VaWlMyYXBkeDFxYTRkelcrWGZRUkdvcFRxSUpPM3NzdkNqVEtmSXloTmdq?=
 =?utf-8?B?OFlrOFBoUk1LZzUrYU1oWnl4MDBqWHp6OEhydnhSN2VTYTF4WlZ0aVFsWE5P?=
 =?utf-8?B?V2pNNmJTS1hTYy9vVFBBT1duVVFsbUM0ZU5tL3VBVHJQcTVVV1UzR3RTTGpI?=
 =?utf-8?B?YisvQS9HTWZiNWNRM0E3YlBxd3FmTE9aZ3ErMGIwVklveHBrL3hiS3RITnRB?=
 =?utf-8?B?YTRwTE5PMjhNek5QNTAvUEhwakpmTm9HWWNhZmpMSHB2UDlCMjJLOGpOTnA1?=
 =?utf-8?B?cU9QWFNLYk9OSkFoUUNpblFGNHZMMkxLVlpwaENaKyszWEhjK2tHUklKaHRl?=
 =?utf-8?B?THdabHBRSkViTHN5SVppcDFjSXcxcnJJeTNIZlNLMUVFR0VMTUVhS2FOUXR2?=
 =?utf-8?B?b1FXSFFtZHNzNkI5Zzk1TDZ1WTZXTEordzJJWHJmZ1ppWmg0OTk2UGdMc0V6?=
 =?utf-8?B?NkZuUzdETFZzalc2dEZvWEJyTUxWWUFkS0EvS3NPdVFwVmpqcG9KZEtiUUhK?=
 =?utf-8?B?QzNNT3dqN3o2UkFuWXlMd0doeC8xWUJXTzg3YWg4L0hYMStaQTRxVTRCanJP?=
 =?utf-8?B?NWRBVkljWjhYTmJoVDlGMldURVF5bTk1NUhiRS85M1RrTEphdG1QSkFoSUZP?=
 =?utf-8?B?TUw0ZVozcW1uK2NXejczdjM3OTRmWlR2SG45OVlIMWtCNFAxeXpNSzRVU1I1?=
 =?utf-8?B?dloySW5NUTBlZW9xNGM4M3ZQSXFrUkVtTDlPQzl5azBTcFlEOEVuWTlUK21N?=
 =?utf-8?B?Q3pTTTMrVWpPMElqTUFiZVpEQUdlZ045Ylp0TWh1SHRsVjMzbGVMd2trU1hD?=
 =?utf-8?B?OG15bk1vRFR6UVJCU0FWSXA3ZEFUMFdwWWlERG5hK1UvT04xUjNSY0dTdDZI?=
 =?utf-8?B?dlNCWW5Yc1JNd1pMcFZ3aU9iZXd4amFiNHNRN3lHeUNnQjk4Nzc0ZTNUNjZC?=
 =?utf-8?B?RDZIQVJOMUVTL3A2MW0zVDhBMStHTXp4Zmt3WmpXWEtsZkRHeTA0dUd2OWxO?=
 =?utf-8?B?dDN6b1JiWWR5TTRFSC96Zk9JRnJoTXNBTWNMTE5JTnJvRG14TDJrNEswMzZs?=
 =?utf-8?B?elRwT3JTZ3JUMzVZS3NqcWNmVS9iUXlYTnc1QXJxUXd4UUxENU1JZkIrTzA3?=
 =?utf-8?B?bFFVOHhMUERhNEIxN2gxRGZ1Ym0vZ1MzQTA5Zk54Z0pvNEpheTUwRUpjMDFj?=
 =?utf-8?B?U1JXVmFLc1FpT0lTN2dPbDV4QVNJT0VRSnp1dUQyVzE3TE4vMFJjdzRSV1lP?=
 =?utf-8?B?ZE4vNUpaSWY1T2R0R3VGaXZxK1c2K1ZudGplZ1hINWxoaGw3Q1pMZ0paSzh1?=
 =?utf-8?B?SjFORThxaVQ5VmE3eHJ3T21rZ3hhVG1JK3p2MC9FZDAwRzZEckN2VXVVNDdW?=
 =?utf-8?B?ZDlGYmkxcDRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 10:01:20.0578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649b8d80-adf3-44a3-814c-08dcd3db045b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6111

From: Shen Jianping <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi240. The smi240 is a combined
three axis angular rate and three axis acceleration sensor module
with a measurement range of +/-300°/s and up to 16g. This driver
provides raw data access for each axis through sysfs, and tiggered
buffer for continuous sampling. A synchronous acc and gyro sampling
can be triggered by setting the capture bit in spi read command.

dt-bindings: 
v1 -> v2
    - Add more detail in description
    - Add maintainer
    - Add vdd and vddio power supply
    - Use generic node name
    - Order the properties according to DTS coding style

v2 -> v3
    - Improve description
    - Improve supply definition
    - Make supply definition as required
    - Add supply definition in example

v3 -> v4
    - No changes

v4 -> v5
    - No changes

v5 -> v6
    - Fix checkpatch findings

v6 -> v7
    - No changes

imu driver:
v1 -> v2
    - Use regmap for register access
    - Redefine channel for each singel axis
    - Provide triggered buffer
    - Fix findings in Kconfig
    - Remove unimportant functions

v2 -> v3
    - Use enum für capture mode
    - Using spi default init value instead manual init 
    - remove duplicated module declaration
    - Fix code to avoid warning

v3 -> v4
    - Use DMA safe buffer
    - Use channel info instead of custom ABI
    - Fix other findings

v4 -> v5
    - Merge the implementation in one simple file
    - Add channel info for acc/gyro data channel
    - Fix other findings

v5 -> v6
    - Fix checkpatch findings
    - Fix review findings

v6 -> v7
    - Fix offset and scale

Shen Jianping (2):
  dt-bindings: iio: imu: smi240: add Bosch smi240
  iio: imu: smi240: add driver

 .../bindings/iio/imu/bosch,smi240.yaml        |  51 ++
 drivers/iio/imu/Kconfig                       |  14 +
 drivers/iio/imu/Makefile                      |   2 +
 drivers/iio/imu/smi240.c                      | 611 ++++++++++++++++++
 4 files changed, 678 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240.c

-- 
2.34.1


