Return-Path: <linux-iio+bounces-9636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C571097C09A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4557F1F21AB3
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE01CA682;
	Wed, 18 Sep 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E9qkssJX"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2089.outbound.protection.outlook.com [40.92.19.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCFD1607A4;
	Wed, 18 Sep 2024 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726688605; cv=fail; b=coBq2p8uanFyWuLXtFo4GmO9HOQfHmIo5hQHvXO8AqpYsv65hw8sWP7HQiIgjU9nbJrwXZGgxp8bwJU+nonZY/oLc48Ji9e25AxZV5H5Pqq6arXrF4Xff1YxZCTdvsQBnub4VpWqB56Uo0KYq01Oc8DSO2GqIYNvsq/D97/UDJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726688605; c=relaxed/simple;
	bh=7q3uP7M4+GcRjRFYhwQPwv0bX9sa+Vb5DxcNXE0MImQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=unnbXYWZYqlUOBLAaza7CFKXujY5ZelOebZfIMplhqLuRK1UZ1dcNaO0sZWvpd7yE5kV+pwuNWhbQfgPI15be0xp57n6QdyAYrgTlfc+Pqg0rYjS2lHW/M/7REUUVtnOzeHmdoBBeKDs+GQztGjMx5Rca/eqe94fCUv6/58jxKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E9qkssJX; arc=fail smtp.client-ip=40.92.19.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlSJZuHzB3M9TWR7o0V07uIlYntU1D9BHWioGb5dwovGNa4fBhSe4B57FhHDpo4Of1rp0i3Za93Sj7k3ktjm610eIMoOS4bEVXMM7vH1ZFIn0L266vJMTlTwerBYwGKheL59dsBJ15XkJeaWbhyi+AfgwFw0Z1EKjfqBtXbyw+OnWXZXequKisX7PanCGxrlsHRxZBrWI5R3OxU3zR/vClLR7q7KORJexbZ9f3MiCvULLHfabiUXAj1YcJS/wUvDqqPWRQ5hJnjL9ZXDQ7KJA5i0HDHxTIcR3LdUaL20UGysXMWXWgA/7W72BhhK1aLfogOg2d4XRfagE5xKXGMpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q54PS6dahtf4AwCWlI975l6S5A2jftfqMFnFXmGcZIs=;
 b=yflq03Q4YsS5VfANwK4VZo7BV0o8CthXSm6E1hQAq4WTwW3maCKNWgabNDJiXgmQZdPwQv4Ka2cvUshAQY5qErlIEcjLbj2G2lvvopITsRo12Kv65N5PsA/Ep04En+DEToppEseamwR4WYAYXNnW6B6SOW2sbnsYcOuEGAK6JdDhNwSS9LrA8qkvQALql4AN2nvtw3prxN7489pnmmOZ+PVCgiJpe+4Iqii6Sn4sS+QOj53txTz2Tqy/wdp09iUpPVlxLpXIoH89Ynu6wQdpPWU3z7W43nSf8tzdo1lhcCd0kUNme87T7YMMQtdC1LpgrYZw6fuD9xLQt3s3HJVneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q54PS6dahtf4AwCWlI975l6S5A2jftfqMFnFXmGcZIs=;
 b=E9qkssJXtD0G99C8HzeBr+dd3OyMyZwQHKtqGbwZf0UP0auswxCRpaCmDhd3t0MXlIKMHo9ouAS5tUzLs9uH+Wq0HbqC67MzKya1DDRiMVTcDpUG3+m+b10c1cYYxd31lBuZOtP+yJxDFdTpNbzxFrUeegn3Q/f0Xfy2GB19CD+u5icjY6GikgtB31F+lxGBBDrESO1TnR7f0sb0//IZyPVokO85IbtaJln1oxLLPRfDVlfGprHVk6QioiqkJvp/maRuMQE0BPILkQHNNmeMkD0h+xAW6S5xI9lNve0Zs31EbAwMJP7AH0nq/yx5I5TwGMk8VAKp7Lv9EwDIsMlEqQ==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by SJ2P223MB1150.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:584::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Wed, 18 Sep
 2024 19:43:22 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%5]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 19:43:22 +0000
From: Steven Davis <goldside000@outlook.com>
To: hridesh699@gmail.com
Cc: Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: Fix alignment warning
Date: Wed, 18 Sep 2024 15:42:56 -0400
Message-ID:
 <SJ2P223MB102630DA926C5006D12E5132F7622@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918174320.614642-1-hridesh699@gmail.com>
References: <20240918174320.614642-1-hridesh699@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:610:119::34) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240918194256.13431-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|SJ2P223MB1150:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e3c9ab-0bab-414c-22db-08dcd81a26e8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599003|15080799006|5072599009|8060799006|461199028|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	nNn2MXwawVGaGPeIK5sbrD1c+UBcvWR+BVwAkArv8fIY9K43oqKc6NTWP9oUhlM/+HdbgTFCJM0kjsrV8gO8e5+MH8ISjaSlgcTgCzdU9nLt91SZ0fFSqSjxOr7p/lT3dcC6SIEQ/wu3IZFbdLi1Kp21l1Al3r3aNeZ2NCz4Bu7HZLtNBQ2PmE78xRH0M7zefWqx34ihqVEmcQVvrLVCj+Ldt3QU1qNLrv2rpP8ntLlCdQxMCxvYTbHtI2+LVxLNX9UCwuJIx3EfyoW4Lu5DuipcWzxf7QHWuHg6Ks82CZurA9yEXfr7Qxu89REm93oyW+H5fCbfxQ1gXnQ3mCXT6Db4KSrGhm1dFYOVKGrflgaKcxLpH2jlr1a01/W2sFDH7vcVNr6BIQWsEL4gsOCR4NDyL8LUx7Hkpr5wRg8l8MG9jv03txc2Yr7bAzOEa4t9moafMC3hr0BrOhKPDbLBKPU3Qvii5Cfyix9FcdDgbcLyFrO9dQs7FM5iua8gnNrFagtytwbXxSisbFlpStjXbQDuMK0SMesaSjDUAEabXlFizOyzvGmMmnHYnsxVN9Uy1/A/aMk50HF336BWTWgo1H+4xIVCMC6pfP6zHilRNzdZ71zsbboEsNxRNVQ5eVnpwXzFO8E1kRLeDhReE+M430GMqX09rgNOZsH+hpr06mptOY8fwcd2+ebBMcErWkZjb61S0eTqw5vFm1zugZ+GPtt3PFd17xPbyiLarKzMaJY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lkdkQt3dNIhx+jU3eIKAuk/1t+BAU2UO9xWphyFMcMi/fJo7I1KH/8u2qgLL?=
 =?us-ascii?Q?b+7MVbkKkIUi9QXrZg6TAshCQLdNI409mIlij47B+abCBC9N/tw87UP1a1jR?=
 =?us-ascii?Q?MfYoGIQwbxf5cMg144riPkpODTYike8jeyu/bhjj/1tsgZLjK0XAUNJP7xDs?=
 =?us-ascii?Q?izfUqmrylxchmnaXqL1L9mQn+BCFyR2ZGHRZdKbSK0bNyGMFa/8Gyh8zgic8?=
 =?us-ascii?Q?OaKQrhQYLY9xGUZz/E6vX5VjPfmQpvONrdQkB3L8DA6Q3XhcDO9HT43S8laq?=
 =?us-ascii?Q?wala5lVMWiO9ovAHKJFoNZIGxrFg4ZdWT/WxiTZUerhZdMVsoGScyRsC9hJQ?=
 =?us-ascii?Q?nZXxtxmx3Cc0x6sVbGoSHa1Qbn1jp0Vd8EtWerWxCifLAWZ9qSxgwbO+R2Oj?=
 =?us-ascii?Q?acDeEzkcEb1fJ+K40VENfd/+vdZRkpKfuN8khDR6D7VgmBhcYMQi47oe8G4m?=
 =?us-ascii?Q?FP33ibVxIUIA6840Z2oY2vWJTRlgxnngUPi6MMk5Mp3J2vMk8o9ySOH4TtXQ?=
 =?us-ascii?Q?qKDva8DCNALyXPVPSR8jew/b7JXoUSeh1ZY5WyQD/vI9DMowtTMExlkv/4sy?=
 =?us-ascii?Q?hhKqWA7B6ticnubGUNfXYKy57wF4dS0TDDO7S7QGB+ZWxoCK6pwx+l5wommW?=
 =?us-ascii?Q?UbarpirQgaKt2lTMUNaMALAtAYMOMrJjLfOEMh2cnYzeUAelDbPLnDy3o8QF?=
 =?us-ascii?Q?eUsrIAtjKp1rIiTAi2gR3lOnFbXJkSKP6jMucApqmUZ8v24qd4/GlY7jRADn?=
 =?us-ascii?Q?ClhVIge+UPYIH0BL++og950QoJbrDEJd1q2f2ED5yS/qRPIjI6TNnw/7PKp3?=
 =?us-ascii?Q?9rjWxlh0CdWP7nSx/K6nveiaUSbxjfP8YaFx50ueqWtKP+sZjayU/Dfp1CLg?=
 =?us-ascii?Q?kYhjLko5dqdFChD1vP5IM4dmSmAhJy496pxK+9k3SIEjazylSGwLn5VEsAxp?=
 =?us-ascii?Q?yEO8k6zA3KteDQVFjDOFMVMCiNtwsfsyS2lLrLsHkc8ugcrekcecbQyPZt4X?=
 =?us-ascii?Q?ea6aZWhtE3cYWNXNn8LM4y9gVpenJ3HM6D97yBBzc9A+RZwWcgBQSJ/LP6Ci?=
 =?us-ascii?Q?mHFvaQLJyeaLPKu23huY9UASfZLJ3+dtVrSKnwvTCM9f7lCV4a35gHLBlIjC?=
 =?us-ascii?Q?J1d3BJ9aMoX9l1cIIT98bHrlnQV17ewREoDcEkNWKc6aqVsRMvFHgWJwXpaA?=
 =?us-ascii?Q?r7mojLok+q7tk7PxCfhYa2enMY9d6RayxyeyenDBwQl/3RvDxYFIUnKgUNx4?=
 =?us-ascii?Q?+TbrfGHDEQEufoSTFnuT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e3c9ab-0bab-414c-22db-08dcd81a26e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 19:43:21.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P223MB1150

On Wed, 18 Sep 2024 at 23:13:19 +0530, Hridesh MG wrote:
> Reported by checkpatch:
>
> CHECK: Alignment should match open parenthesis
>
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>
  Acked-by: Steven Davis <goldside000@outlook.com>
> ---
> drivers/staging/iio/impedance-analyzer/ad5933.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 4ae1a7039418..d5544fc2fe98 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -628,9 +628,9 @@ static void ad5933_work(struct work_struct *work)
> 		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
> 					       iio_get_masklength(indio_dev));
> 		ret = ad5933_i2c_read(st->client,
> -				test_bit(1, indio_dev->active_scan_mask) ?
> -				AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
> -				scan_count * 2, (u8 *)buf);
> +				      test_bit(1, indio_dev->active_scan_mask) ?
> +				      AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
> +				      scan_count * 2, (u8 *)buf);
> 		if (ret)
> 			return;
> 
> -- 
> 2.46.0

