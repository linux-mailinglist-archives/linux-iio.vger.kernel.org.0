Return-Path: <linux-iio+bounces-22964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A130EB2BC4A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 10:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267AB7B2DDA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A66315769;
	Tue, 19 Aug 2025 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OSpvc92v"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013058.outbound.protection.outlook.com [52.101.127.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DA311591;
	Tue, 19 Aug 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593762; cv=fail; b=D6YS6sm6yIGHhwWKrtZLFNW1hL9vtqfCK0jRvCZ984PPEPA/Wh8XiL2uL3+GJVWJBYoa3hqWQzQq3Z+BRbui6U4kAKmPpMWGBjiDi3ZrysAAkMpuqkX7COlfsoNCRsUzltTxox35KLq113vS2T5TkX2GGhcNex6o4/GzHOJvPaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593762; c=relaxed/simple;
	bh=9CUI1ORDYdoDO9eLlQNRsx6ePAP8vfStQgsi5PrPT00=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aIM93xFHRa7ofSKHiDKHryPCAV0pMsH6GCBCp0UBQsKT6lLYDwt1lQqNYVb9u64Mgg84dey2FNbv4PdAJ+aXxNKXbqHHevMwCRhiJv1N9/52BwHzTdM6XBVrLvdZJcCfVoGNB+pvjSnCDn+LfUD+XNiFshuv4DdkW0/ASjRC21c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OSpvc92v; arc=fail smtp.client-ip=52.101.127.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLutSrlFUwMTia5dzSKUjN/wjrpboZNgkuRjzKzADSqmJMX8a94EVog3eC4zmK79x30UEKdTLH1avG1anwFWKdaIum6FCsvNIEOR1X8MfVJgQ6izK+zMje4W3H+lSVrSv2aVrpZ2MSsXZlgy+6icqs8dmqe6XTXLq7FgqysZR0Fd2/SJOaKZnxB38DdljbVgBruZFvq18+Qf/6ZpXpE+9QviV5fm4IpPj0aFc7nW0ZhQfzfMaNz7J9FOPbkJaUF5qj12xbiHztfE/xJeEfEa+AfbSgbiqlsU78L3tn/LOXmCOS95ePyl0CYnVCb5SCKIEZqytHnx5TO8Rxv+pfsSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YoF9u38FnP08a17cgcIBbzUKQ7qmUcQErfO3Gha4d0=;
 b=yb1tHRvNVu1rd5x978A8yMt46Iam60DYow3HF0IidVj6axfUgboCJxpFtTesmkBD6a1bMHeSusls+hk8XkYV/OxzET5TOBe77XGFlPhW53N47vvV89JcMc8Jq28UvlNE9hR0mWQn9SQg2voaO7tdSsBqSOn+lhj+DEk/ph3VvTH21BN6pKplC3N7qkN3ys04Uwi6QhhpuHskIWus9+FD5HyiiLaxxAnXBhVqqXw69hl54PgLPQMQSCk6bfIWnILNUiL5M+bnL+BUNNDbjlF56toVqg8yXLvMMUtrGzbIBCvPcncrAqi/VXlaFBNi0FoWu+UCsCGQgHTCJDbwtUb1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YoF9u38FnP08a17cgcIBbzUKQ7qmUcQErfO3Gha4d0=;
 b=OSpvc92vk4Ik2KDyxDdGBafEW1E+d6lN7L69l8B7RsWdy+KD9y+94rg2CNpoJiSNPjLXwmIVq5cZT6MO2aiBxKDWJslc7odf9uysVc9ztEEnwTJ/UdVm6TV09V47qrBb5uOxipNw73NuLoqzmVbn9wIIpfDP2w+qXBqWGtt6ifkBbd8YNKClj8iFLtF3mQSWLf6/otnG41OgFJYURGpBqeSuYrbY4bbIEEh0kqsEWDxm3ythprVyWQsGjDBx9oSVnpFhUJ4ARYLNSenh3kmXshG8RhcK+ZAVviwSOrDgjXDPcSagHr1cpS+tQw655tH47G7pms6u/D0rExKsjrM2tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 08:55:57 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:55:57 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] iio: common: scmi_iio: use kcalloc() instead of kzalloc()
Date: Tue, 19 Aug 2025 16:55:42 +0800
Message-Id: <20250819085542.538715-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:405:3::29) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: 18598088-b98a-4de6-fa2e-08dddefe3640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3HlykPIRkHjJ88gv0TahKt2pmB6tN4SoHafo3ecxv4Akhwgu0U7v7ajgI3Ch?=
 =?us-ascii?Q?6Sh+2FyBI1TvwF0v7f5Pc3HCWT4HPUZBvK0G25l/FRG8k4EIWkSHn5IZXrMl?=
 =?us-ascii?Q?Nm1ULZ8pFAwh3FkodTKPLNUhyRrymnN/JqJKEdjOt9+rIggyGOpcAESMTGcp?=
 =?us-ascii?Q?uTocO5dPe4nuYIwOrisSG5Fs54ey997DhUclx691+7fSI9rhOJAyUDzq7eFt?=
 =?us-ascii?Q?E3dBDRFU915HHqvGfYtuJ4VHGGLn3rOmaI4jbMraVnyaaE/82fUlbcfZu/cc?=
 =?us-ascii?Q?78+HI/mFKV26lcthIelKzB0/oDWpB7KRK+vLrfaVrOHErtvf+u2pQkmFZQGn?=
 =?us-ascii?Q?ohYSQ9VHqDdFeTLUr7hACCCP3b6WnXODIKFYMwtZJhfNY7W3+EFZvyqac9KH?=
 =?us-ascii?Q?i2utQKhYk6aLnkGRPftGb7YDR4JrvpoK/wmSH1S5iB0815oVEBHX4MNiMM7u?=
 =?us-ascii?Q?k3rqOayjQlYa95M+IXT2pDuuU8J/1E4zpITo5Jiy8XP2aOPtjuw8m7VRkFwS?=
 =?us-ascii?Q?ABhMQTRxDs3TBwBBVqB1NIw26kwUHO1paRL3HW10Z+V4fnB/KEMF2PoUOtko?=
 =?us-ascii?Q?dTfT7+GSGSTIqTFL1/iA4bUmDd4fSBKynoydnsJ0polJveVDO64PgjKTUd/C?=
 =?us-ascii?Q?hO262QhsWqFd6r+uxAAsJ1X0Wa2/eBpyZXTvMoLrT+dMHDcMG3JeDB8DEA0a?=
 =?us-ascii?Q?CHCM0tMe5CeFuZRge57YalsS93Iy/iG9IkZ9XbSVhc3hQVxk1zTgras/8gH4?=
 =?us-ascii?Q?7AuvEAKzpZXCZfPYSJWKoLX/R95Tf/iznL/8MRfvWrS1ns4T2nKfe9riTFbl?=
 =?us-ascii?Q?nWZ6AnnExIEsgCr+xeCuEm5pqpZrtd05YccCMmhchoH1/+y7eUok9EPDKoB0?=
 =?us-ascii?Q?izoxKePeNP6UFc0kB5ah/UL4uhk3ZhAv4mq8KtyfOBWYLuQLTH8FkTN+M+Nc?=
 =?us-ascii?Q?RokT3IUwlPQu5l0A04+0ILWYuHQ5u2tITl2Zygr+4E1PWQ9fyQT13C60Vm4U?=
 =?us-ascii?Q?rR4LsKNgouledP4DD3eXs9wIimTbvznIzI9vNy4YNV8mNip0twqubeaJVGYq?=
 =?us-ascii?Q?Ui5e24fohiCjNFpc7J5AfNVh35oXd2SbsloshUo6NbIN4aVOPy0wdlCffEoA?=
 =?us-ascii?Q?2YyBMCgBiosYDpFFVRr3b/7Wh3a4/g5w7g5OVfy+qCqUIJd+453mAoz5M1rh?=
 =?us-ascii?Q?Tz8GGTUMDREwo9V0bhuhq+uiquPVc0MJf9NzplMhE/tFawkWm637kTGSHuwj?=
 =?us-ascii?Q?SvYZg3UCTk9pPHoq2EjJNVXuds2uDUtkvxSj8WjxSyH1Iyl/7QHm6rMFYbOE?=
 =?us-ascii?Q?5I+RZTWDuSf9sJRCgCwSb66o6TkrmclkQGJigcPCceWBdFU6rciIH6kHP60j?=
 =?us-ascii?Q?A9GdJqmNmukIvhvbM58qb8vgi7gpbnJ20FgWfzCnlft2vgiQWiGXn+XkE/hN?=
 =?us-ascii?Q?NMCCIaDV2x+5qjKZz/Ttkal5UtJMjsd4URjqwXJxDaivkbeQbOKk2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dmby/TZ/1Fn4wX5Grfohr2SDKxmZIwQSakm+LoJJBzggsYOUpFYKtXs0OFBO?=
 =?us-ascii?Q?z+J5hAqvicyyyRFUmUCxW5fbKp/X8AesbzgHceLScuQQnv44fhy2Gu8BEGFj?=
 =?us-ascii?Q?LkQvYoGkBNrwlTFSBavspOpHz3fqBOpH/P2dsqGgNSYdzsDdt+U9IqJn/Q2g?=
 =?us-ascii?Q?uFFHHeFkmV/Y9R05SN39+MWdO/2MymrWVwHb2T8YeoIezXcSs17cSQ+SJPvZ?=
 =?us-ascii?Q?cVRVPmF/8S3eU6fYkrzDKHQPLkGtAl0WXIRkWD6PdixXP5eK+KbpdpQMk6Dl?=
 =?us-ascii?Q?6noDDgNEbTDgVhIBVnIW1+Ug+D59GhSJ0L48W/1AJmZhWGStRyg/iSv+rLhH?=
 =?us-ascii?Q?MzfThJFOb30XZ2SlLR/uw80u/wkvL8cncNwByJjOJhuJPOVAt2X/L1tPYJFr?=
 =?us-ascii?Q?1BmBFx6JYV/QA9ekaCe8cJ3caeNn7IxIfU+Q+ZAYdsP1oiUUEAZ7tpQteqdr?=
 =?us-ascii?Q?3kBI/tLAdD+6iAZZP7ePpVOHdlh/RCqGkdwEqapmmDV+13j17JeCv8GafoLU?=
 =?us-ascii?Q?c3FO+gW1XTRKIdEi22DRAMSk5FX1xNsm9KRaUz4iaueg91o3vMiTBrVUCrEp?=
 =?us-ascii?Q?dzGCex2nFtupX/DIzuf6RpbBYeNX0lr6d0e6zKid7OEkzWvfjxNYEfiU8va3?=
 =?us-ascii?Q?NaWr9qDL5GqhOs3KB/YZr/+iWOx7AuUonm0U4vGdlOn2C5bNIyoHtkL1XMih?=
 =?us-ascii?Q?KTUEIMvzgAPa14YVjFUtEyB/68ALGwzKLC80ZGM8ueO7k/jXHdSmTMzPDsw0?=
 =?us-ascii?Q?M6A7110+8+khkOwUtjYm/cmD60YPuJdqNCLBKa+KjaBpEmfuQcURv9kqPwPf?=
 =?us-ascii?Q?Sxevh94UB/6KHPmRp2+2kdu4xUT8UKmAhQw4BNLpQbcNhNEndhkx8deJAkuR?=
 =?us-ascii?Q?f12VvTjlaxNohQCVcbk4RvP+E8U+QHsG2bwf/SumMMbVTtiS3bmv+e0CqSc5?=
 =?us-ascii?Q?LUWIJA6Y0x707gDLTjYmBCAaE7utDi0MldaBt1QMiPljLgobGj8fXgBTTP91?=
 =?us-ascii?Q?FOq0JGjSgCPIizT6TaOZPXxiUs9A+LbYczxL8rFF5nXd+7I5CASkMyAjOL31?=
 =?us-ascii?Q?JU6cWHBUn/WT8tOl6C3nmeOVlRzTOGUEvlFFGeF2Rk9LDlH2uLbxx7yTSA4+?=
 =?us-ascii?Q?vrvebAEK2couaaGgC5lucnHE7zP04hFdPEhvU+R8xcQVtTFxaLEhhvXBz4OD?=
 =?us-ascii?Q?OTRTKSiTHk3SSkiocOsnaFbT3v7yuNwRnBHhrtX1mxVl/k/Ven9u7yv7XUYH?=
 =?us-ascii?Q?+hYfN+KDjMRYGfchh7ukc6LckwmNtReT++azL0SVWfTH+K3oQgOAFPA0A1qc?=
 =?us-ascii?Q?rxNSo7gzkkGyqJ+kANphQQMgBaBAiuBXySC1ZoBx+Z0QeIwYKHSawJysDlWI?=
 =?us-ascii?Q?D7zrjSPgKxGzfW9x6XZXDgCfqZCa6hDZuwn0m4/Vcyz29nGxR3Jb/ul+Vz55?=
 =?us-ascii?Q?lwf3V3bkxFOMYG672ILvGZWK/jqiCLmf/BCx4fiA96OFYHpgxtVbvj3c9tzo?=
 =?us-ascii?Q?dFdOUOWfCwBdFnZwIlnTV0o2E0tsDLMEFewt+eKS4RibLUr1nzpEQTqJX3pE?=
 =?us-ascii?Q?+4ZqNks0sLvddGwss+uN42WDKGGsnsctZz8R/YUg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18598088-b98a-4de6-fa2e-08dddefe3640
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:55:57.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqRtU3jWEzbi6b8lIeXPcl0H+WfqyKt7P2hUu2drTMUng7xcOzNZIgN501fjjIU1Yh9EosVPgrGeQlFo/K6K/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459

Replace calls of devm_kzalloc() with devm_kcalloc() in scmi_alloc_iiodev()
and scmi_iio_set_sampling_freq_avail() for safer memory allocation with
built-in overflow protection.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index da516c46e057..19798ea9de3e 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -521,9 +521,9 @@ static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
 	int i;
 
 	sensor->freq_avail =
-		devm_kzalloc(&iio_dev->dev,
-			     sizeof(*sensor->freq_avail) *
-				     (sensor->sensor_info->intervals.count * 2),
+		devm_kcalloc(&iio_dev->dev,
+			     sensor->sensor_info->intervals.count * 2,
+			     sizeof(*sensor->freq_avail),
 			     GFP_KERNEL);
 	if (!sensor->freq_avail)
 		return -ENOMEM;
@@ -597,8 +597,8 @@ scmi_alloc_iiodev(struct scmi_device *sdev,
 	iiodev->info = &scmi_iio_info;
 
 	iio_channels =
-		devm_kzalloc(dev,
-			     sizeof(*iio_channels) * (iiodev->num_channels),
+		devm_kcalloc(dev, iiodev->num_channels,
+			     sizeof(*iio_channels),
 			     GFP_KERNEL);
 	if (!iio_channels)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1


