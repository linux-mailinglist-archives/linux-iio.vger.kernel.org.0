Return-Path: <linux-iio+bounces-9139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60696BF9E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 16:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A55287216
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0E11DA31E;
	Wed,  4 Sep 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="pIQMXak2"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C881CCEFC;
	Wed,  4 Sep 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458738; cv=fail; b=P91a4GlOhhd2bTXIbB4Jn+g2LwCq1bw14jPX0UzGyOL9VP0WlzBxfZw0vKvSNG2ZS7GK6fsUlulViEo1Nl18lDtS1EEJF9ff818aKsoNtEipGsen4pYxg+zwuZFpsU78/UrMFMmR8zj80WQyTn20EFQxAHhPUPxf9UdE+RJxcUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458738; c=relaxed/simple;
	bh=K7nkVC/oMz1JNOnRN3l1ONHaE5MMpz/jfpx92AWWsBA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvKRXgEgzJ+yk0JVDRb4DD+XKDPMo8ad6JPole+zuOmfsVePQ70cNsijGMsWn2Q8yDqmSVHpi8XiNKKTWbe3Ti4F5Ck5bOQeUvgX1t8z0azVNbxgKQ7Q6cyZdg5+4MzuIUbtUM64Y6MP1LpUnDAs2R6MXIvIA27E4I5q3eSsPyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=pIQMXak2; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q38Gsh5D1b+shp62ySYTkj4ZExoLAgADnNvKyHLjlDgoYpnT0zOCuO+HT472u8/cXIye7CVzI6b0nBAH7X6suuqEizVtG5guA3oilG3icpPIF7tA89+Jb41y9KU7/qjGMgFWWeNXLdvsbxrRBzyFGSOI8xjwaz7AIHea1bjHePXC0foKL1LgrOHt94OvM3XredgjtxfXSDspvR/wMc2YyZKFwBkillqDbAjMeDa5s+MlZ3KBiVJqRWWl3Ln5mWDSawcL3y68OJRP2pZHQv0Yru09PlKjl701VAWOWNJPQfmb8KjcB/FKWwqjeoMF+IjtN4gGP6hEyngoK6m3JG0s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFVUcETo4Vu0Tq4WPMxlS5tiVGRDhMPhTZDas14e5mY=;
 b=ly4DKBlc+W0+LXSPaf4SwAOQ+VeD1JmpHuikIja+IsKvFPvgYx4VfL8tcNfTIRLgZRLEGJcj91lU9/HulR03wMYM8jqUCU0634svHQHMueJcsbRKdg4PgocB5DpV8OS9ozUYXSMh4EAtPbE+uYegCLASi6ig7Un8A29CdZIUeq7EJsvdee3PIY65agl7NkgfJoJgXKdfnLb08ieQrFgDzIC9jo894sFBisnIRJiEF8pjKzd8pgskAhb1agSeNjCPwUL4LYDlQ/joYgBUEDwGHUyK6zZSnbzl68fCM0WeJCvf24l55SAxJkS8TWOJzgkXCFG8Jh679hwPJA+mzEZflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFVUcETo4Vu0Tq4WPMxlS5tiVGRDhMPhTZDas14e5mY=;
 b=pIQMXak2Zx8A9qH/OtiMWQGn08mvahoZrOGJtAgH4koLCaDowna7VqInTTI96MjXHtFV23M5JxG0DJmFnpc0+xehybfVMK2vt6U911BuutyCCznD62HS+H/dSvtclmZdnWxPeByGDvRBtPYzml0SwIZsdJQjzbkIbQWo0tp3y+T3k6Q8eAUMzSKcoQuWtJUFJCYbQkjZkWHVjKxUjaRtOeyW6nEIAi9aigrAbKJAFDoKy+sIhQ5H15L9uoi1++3XE2JNV7tY81N9CAhU1ZbMq6NnbAtdO/HMJbkVaA8w4PDhA8FRLVeALhLe6ZHDj6DdSxnp5FybPbwiJk3+HULAoA==
Received: from PA7P264CA0298.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:370::17)
 by DUZPR10MB8233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 14:05:30 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:370:cafe::91) by PA7P264CA0298.outlook.office365.com
 (2603:10a6:102:370::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 14:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 14:05:30 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Sep
 2024 16:05:19 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 16:05:19 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v5 0/2] iio: imu: smi240: add bosch smi240 driver
Date: Wed, 4 Sep 2024 16:05:04 +0200
Message-ID: <20240904140506.4741-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|DUZPR10MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e0ea2b-585c-4100-c283-08dccceaa2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFA0RzZGQXUyVW5DaDlXY2phNmgyayttZmQxM1pUSmF0elJ3Qlk0SGlqYnVy?=
 =?utf-8?B?M1oxTlh6TTNLS1JjVi9ZcWR5eXVtTGdyVWdnNVhIbXRXRFlZeFpzd0NWbDlm?=
 =?utf-8?B?WTg0eDRPYkVzTjU0QzlNdnpBekNDWXFpTTRCM3F2OUJ5U0UzWkpzV1E1K0Zw?=
 =?utf-8?B?S1hnbmZ3dGoxTU4reDJ3aGxsclgyOGRwYStCKzlTSGUvUWduWXZjOEQxMVA0?=
 =?utf-8?B?OC9mckFjbExSOHZTWUd5MDdXUzlzUzcrYTVYaUxDUm43L2dSR0M0VnBmUGZp?=
 =?utf-8?B?eEdkZEQvV0g0Szg4RDRCTGhUeUpNZjZYTGdHU2ZOQzVSVXUzZWRIOTZWMG1G?=
 =?utf-8?B?aXJXVk9Sd0ZXeTZheGtZNk81NGRuSDVBQ2dsWldjZ1NIV2tJSFJnaXlOZFQz?=
 =?utf-8?B?RUloUW45cVFWb1J4cG9aY2V5QlRiREIxU2JJeHM3K1Bab1kyckZwU21yYXY0?=
 =?utf-8?B?WmVvY3V5NXh0MDF1aXpLaGVQaU5RQXNWOXVwblZvM091aEs3TlVXNER4cmdM?=
 =?utf-8?B?ck56TlY1MnBrU0VpQ0FjNm10UWsxZ0RSVGVJTWkxbzNpT0pmdVZ2Q1lZZzZw?=
 =?utf-8?B?Y2F4OG5teGVOaFNnRXNPajZSL2lxa3pFOGl6aTkvRkdGMWVaVjJoYlVKcG1J?=
 =?utf-8?B?MjFvTUVGaUFJU2tPdjNHb21lMVhUcWx3WGNOY3Z3MFFwTlhIS3lFaytTa1JQ?=
 =?utf-8?B?U2R3ZUJYQkxXc0tWandYeGlUL2paYVpTUTcxOHNPWkovVFcyTDljRm1iZE05?=
 =?utf-8?B?c2dEUk5iRGpOQ3pCcFFGcDN0T2R6SmFWL0ZLUTkyc2NBcGxjVzRxQ2RNV3V1?=
 =?utf-8?B?U1grZ2lYakFQU0JUVHBEcStpSm1rNFdFRGlZRWppZWVRVVZlRldJY2lZeEpD?=
 =?utf-8?B?eVZBcGhmdUFaQll4UG9abUtacjBWMktZTDE3UGhhYWl4NHQxVk9nZTlNR2xM?=
 =?utf-8?B?enRrcWNmS0oyKzJ3U1FsUFJEOE1OTjUwdDVDbmV2SHVKSWZ2ZnpCWWlkYTl6?=
 =?utf-8?B?UUVLTkxGYU54REVTRmIxTndqRk1PQlZaNkZwTGFYSEdJNzNVRnl2YnB2SVA4?=
 =?utf-8?B?MGhvM3Z5d21jamJWTFVDUTJjSVYxeG90cTRQWDYxZzh3d1MxelJBbW9VRjNB?=
 =?utf-8?B?dzk0TmVNMi9hemEwd1JEaXVQYTdPdlFVRlZjWHBQUnhCM0NMVkxhTmJnNlFB?=
 =?utf-8?B?dlowVFNnVTY0dFZWUWpuV1UveHBid2ZsRGJodklkT1E2WGo0ckdETCtHNnNp?=
 =?utf-8?B?dCtmTVB4YjI3NzRaNmpUSXA0eTlLWkxUMmNlK1pvRW1yVzgzWHAreFlscy85?=
 =?utf-8?B?dzdCdHpRdmhubUxDN24xRHdZa3lrWlpCUHdoUlA4aDlpRHFSa00ycEV6R3o5?=
 =?utf-8?B?a0VMenN1OGJYaktsS3RMT0RNYWU3dFhhek1NTlBwQnk5M0YwNllXemtsNkE3?=
 =?utf-8?B?NitMRGdpZzJlN2ZEKzdMcVFmendjQlA0bUNSUW0zbVAwN1U2dTUzU3ZjU0Zu?=
 =?utf-8?B?ZHB3NkpsMUtwa3VLalM4cUVzZzU3enQza1lJc3JMQUQzQ05ydnlsM3pNZ3lM?=
 =?utf-8?B?ejFwdkVkSHYzU0Rwbm1Rc1ZDYmtBd2dpNkZ3U3VIWFdhUlJ4Nm9nRlBITys5?=
 =?utf-8?B?ajJ6cHA2SUtuY2NtcWd3WTErTExuU0tUcklIZ2xJSTdndUxLUVF0aWpiR2xj?=
 =?utf-8?B?ZUdWNjJmNWhXWWU3RUNFM2VOdzFxaWR3Z1QzanVPMHlxYjNVVG1ZQjVIR2lK?=
 =?utf-8?B?MUxibmZHUWJOTXJwWHk4am9jeitUdFEreUZRSmtXNDg4TVVSZVRnZjhGTGpP?=
 =?utf-8?B?R1FRZjNzTERYc2RlUnRmUzNVWnpZQXUxeGE3MkoyMFQ3aFg0WUVQdnBTb3U5?=
 =?utf-8?B?bUZhYm1qTDdFRmRoa3dtSlh5Z2lMZTZSREdxSHJmT0ppTHUrVkovMDF1dDBR?=
 =?utf-8?Q?6EZ/yclpm/VvTO3uP2zdS2Mutv3zc368?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:05:30.3508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e0ea2b-585c-4100-c283-08dccceaa2b7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8233

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

Shen Jianping (2):
  dt-bindings: iio: imu: smi240: add Bosch smi240
  iio: imu: smi240: add driver

 .../bindings/iio/imu/bosch,smi240.yaml        |  52 ++
 drivers/iio/imu/Kconfig                       |  14 +
 drivers/iio/imu/Makefile                      |   2 +
 drivers/iio/imu/smi240.c                      | 578 ++++++++++++++++++
 4 files changed, 646 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240.c

-- 
2.34.1


