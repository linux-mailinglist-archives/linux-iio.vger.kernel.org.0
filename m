Return-Path: <linux-iio+bounces-21347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CCAF906A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824951891D34
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208512FA652;
	Fri,  4 Jul 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AQVnXl34"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10312FA62C;
	Fri,  4 Jul 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624784; cv=fail; b=loE8pLegD7yafe1gKXksui7150z0sprLB/bjm0wuP5rtMJpyjsrnKBtoPIpozehkGBK1zVLXXUQr9s3tMNx9uy1aS8YZsxPxLHOx+JvjLWXjejJXr2B2F6qKwlvDAtRFY7MUA0rYIxUsgXQlYalJbrmSh3m/qwRBNcDAwAcO9c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624784; c=relaxed/simple;
	bh=yYyPAZ5h/LQtAH7TVNf49z7fUi6LMcY68N9svPMyqYQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yrp8qfhIigV6fsgC0Kntmq22YSRmX68ssAadqDVvEasiGkAvL5HToLJAfzxHcvmDTs+Q3x0AX3PTrgvfnLbA8fM7ukJPetQYxt/7lL9gVJE+MHZE7co1+uJ3LD+3PMNmcQqIg3JswsZ+Bf4kgb6xHslhmI7vMBqabGbN6O3xdeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AQVnXl34; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiKXEIZC3UrEqAHbiRFYnGoVhhyl4T5pX4M9cxgGXzllg7cbfmPzlx2khL+wGn1bAAzzdFoDIZ8HW6XJeSUhGmb93qrEQZ4X9xARlaoAwxfU9Tm5pXD12KG/WEPjCdwvv11yMN1+ho7NQYNzw5YTLXG7m/HYFDsVinO3Pu3SDwwQJVLLG4DJRuFRGjxTKweeW7aIpAFAS2oFP09qSu2/szQyQgL/wa8JGmPiga+clut89fwUdbdGkhTFZEX2EuG0mt/Jh3QWpKVeQHaaJOmbVphsUJlcwdeAMvETl+NK7RGqM8cNzFr9rJqYQTPYGDNGI/U7oB1a7h7RXyzRWYmztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG+f8HogoEU/Bsxr3X0Xd5Os22lXcqLyVmcj4f5snHU=;
 b=f8E4QyqqjgZAfGpir9iA8vYwPOQmQi7A7zl1RnkecxD9YU/p0lBgG5f/u3FYdMpiP1NroS81bIl1zRW1BHEhRTSqlQ+/ghslpp6aWa8VfHODslUqplQdHu3gcooQeLyf2f+ybqVHDG4+U9BoIK3IuXtMeiGoW1/qgmeZ4K8isUqW09lX2elyOpo1uc/5TXv5A3VCJhpc0ek3dsj19I8aKwmy8f0Y7LQ4ONJYPNKfmksQ6JaNGt7RdS4KnYjB3PTNEJBdLhA5U7H8kicRAaQJFstqLGNC4+6AN8h/a3t6sGy+Go37RKI1B2zexZ11m5oQSKGNzKx6C2Pr/KTiJkupGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG+f8HogoEU/Bsxr3X0Xd5Os22lXcqLyVmcj4f5snHU=;
 b=AQVnXl34isYxHJT6Smog9ijF1XZ1GBEH3f1PjbeumZbpVhdc5vMbMoZrDy1ign3g2b/QudnNV+a+ta1NrU/R7CZV/wMqHgPS+fKf2K8tEAU9l3lbVCg4YwCbQahQHkvdSzLAzT2xjJqB8LjY8y2JywEhuGE2osoPkkDmSgz/gXo=
Received: from DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) by PA1PR02MB11281.eurprd02.prod.outlook.com
 (2603:10a6:102:4f4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 10:26:19 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::40) by DUZPR01CA0264.outlook.office365.com
 (2603:10a6:10:4b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 10:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:26:19 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 12:26:18 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, "Jonathan
 Cameron" <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"Javier Carrasco" <javier.carrasco.cruz@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 33/80] iio: imu: Remove redundant
 pm_runtime_mark_last_busy() calls
In-Reply-To: <20250704075423.3219461-1-sakari.ailus@linux.intel.com> (Sakari
	Ailus's message of "Fri, 4 Jul 2025 10:54:23 +0300")
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075423.3219461-1-sakari.ailus@linux.intel.com>
User-Agent: a.out
Date: Fri, 4 Jul 2025 12:26:18 +0200
Message-ID: <pndzfdkjlpx.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|PA1PR02MB11281:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ef1f32-84fa-45dd-c5cf-08ddbae53736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+LD8FRLjuWGkoLTcYClTiQZzgwTz6fEL5L3prNrksnI/b50MQPPudUIgogYP?=
 =?us-ascii?Q?agMeCtlPkVwpGQVDK7DHFSzrLVpV2HzOwxUxQRQKEkLqHka8dho8Ux20lBg/?=
 =?us-ascii?Q?h5szsXF+wXoBKjqWOgNZelduZJamkdesHbVAdCQ/8ybNlFLm/krvcbIxdyrx?=
 =?us-ascii?Q?vDRYPldvL8aBPDih5OwdbEK8vqgDpkPoo+cwn14JNU7fCxkWKoqsG3tp23ck?=
 =?us-ascii?Q?/HpI5iBCOag+LBrXBEjvsoS4/1Mb72WSCKJYIdSXS0pV/wUjIHFA5+CIjYuk?=
 =?us-ascii?Q?6RgsKF3y///nEddTA8zqLFJc27F1AJerw8LWWEPrMrTQH/Kw66IjWx5QHUfs?=
 =?us-ascii?Q?sccXJfYAN5GtLm4kNm/QI3TTPVrfVDBINcgTL9qpQTh385tBvmjMet3gVViP?=
 =?us-ascii?Q?LQ3Z7V/7+QfRsaJQodT/gK7rCh1z2utxKtCDoYm7qeaT0mWbEhejdzdGHPKA?=
 =?us-ascii?Q?pwm/BZU42XkW24XEea14wLJtrAykPZo/P8SGapNdmplcCVJPValjhuKA1IpS?=
 =?us-ascii?Q?cQQpoCz+3qTcHLavJQ5WLT36mFesrhMs2NUy/hdM34fbPZLPChRzdUr2oUre?=
 =?us-ascii?Q?uRbz3LRYZFDV5lao2n2n7P2AU00PqAP4ML75jLT1ByoUZojkGDuyhXclTJ6O?=
 =?us-ascii?Q?tY/qIfrNACtbngJ19U6mJuLlMgxdGFXEof5YkaHv3q/lmhVh2kQYXfOR95BN?=
 =?us-ascii?Q?hWGyPGIVMsE8P11bP4gRqQ8mzuZ7MgZdGQcfGnUqD9nW0AjJ7/gsEqXAHGRZ?=
 =?us-ascii?Q?hSafHisvV96Pfk+vR4L+dR2jFguS8B+9lfa97L7MH8EUITdI5UMIyYOEVgA+?=
 =?us-ascii?Q?muqJuNFWyrE4VGcvQ57Pr2qe3nxAtBkxwUN0AzQoYq9RHYfJRXTNpWBao+xI?=
 =?us-ascii?Q?0bctCgBkyY1W1ngwkv7vdC0AVMsBZe5k2TxfC/vMITm7c1JpT4qsqJgE/yXX?=
 =?us-ascii?Q?jiJcv8+6Uqs8E9TXsYjp74fhUNE5d33LsK+vbokklS1pcUFr8jvCqYWQli+m?=
 =?us-ascii?Q?CUCq+AoiwY8f0S6s5iC7x3hNT4DOSbMXZrbX8RmGj8u8MlHdbGBOFiOCh+ws?=
 =?us-ascii?Q?+IhW0xoSS4kwvQaUugkDo9xy2Tp43PuzN33swpsinoFJxHFedaqggNyTy1Vm?=
 =?us-ascii?Q?1b3GTohKsfnuFKQRfvxpizSQhp6Y2I7KkawfyemheFQH3xtrrLNgcXHqfBTv?=
 =?us-ascii?Q?u//7kbSw5vk/YNk5qzZrcW86IHOEOsyAWwAtRUC3oVw/xSJvTj3wOs37JfJQ?=
 =?us-ascii?Q?KQi5nFe4ewDMlYeQWgBMavJvHJ514RaXA/vcTkAeC15LsJujs3Y7zsV2I3qW?=
 =?us-ascii?Q?4mwWyvVdOhQMi+lZlA+j+ehdtmONur4cP4+1slkt16IHrMT8B2HqET2qJDvA?=
 =?us-ascii?Q?09Y2R1eI8hCA90/WAzMIQldrblF1JDquTDyaMMx4hG7ckg6msItgU431IJ7C?=
 =?us-ascii?Q?WQu+UbSAaaV5wWOdULK4KUFCjMdozkeoEx+aZ6AIuY+r5eKv9OCzZJNBeh37?=
 =?us-ascii?Q?h/NQqyfW0EzOXLxFAZ4ohcWCXiNBdXwOWIKd?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:26:19.2536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ef1f32-84fa-45dd-c5cf-08ddbae53736
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11281

On Fri, Jul 04, 2025 at 10:54 +0300 Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

[...]

> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 55c82891e08c..42016d56c852 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -750,7 +750,6 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
> -		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);

As Jonathan mentioned in [PATCH 27/80], please run `checkpatch.pl`. It
will tell you that the braces should be eliminated.

>  	}
>  	if (ret < 0) {

