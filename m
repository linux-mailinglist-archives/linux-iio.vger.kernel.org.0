Return-Path: <linux-iio+bounces-13089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B223B9E3F7A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 17:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62132281C48
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0B20C462;
	Wed,  4 Dec 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="DG/FjBkf"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306854A28;
	Wed,  4 Dec 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329260; cv=fail; b=CJYM/uh8XdU7KnYhrJebcOVcjsz60VjaurZxs8BhhTo+dGj4jBk4juL6yboMTxKiPVeiD2WK6oPvgYD/Lz+xoPrFq2vjx1nyiVBrwwkABBWgHnsVg8D/aePJarS7PT/jyLspbe8rxySekbw9Xrb/sQ3xllZCrNSBSe8eLAdxgDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329260; c=relaxed/simple;
	bh=8B9EeDhlGgulLSOJNs0biohFZNnR5MxLuQw+VVPmixo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsLlbm2d0SK+9l8AzNJsL8lDplAAefo6OlTy9wqTY88hdpGQahuIpYkl245u41B4M5tqVXThmG8GAk49VMk/AMCaTNp3/lNeNGdX4nIXmBuMUjYqtjkBkvWrROa+ObvG8vM2vU0TIqH7PFTIlu5n4qWY3A2iaBlZ+YwdPUElHvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=DG/FjBkf; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdaYZki66sY0JxueMz9fH7EBEWNyrc9GmLHnRjbmIA2buzW7NMltiLuTexf1MAgTyelqDoIqYSoEIl0S6AFhpCNGficVXqW+IEk8jbzaChAjUngId7GFDGUzbK+V550QC46ikqLafbWeeVMSXZjw/60zV3fo7QfNqzjnhFaL4k0hZB0dbpmzky1tE2eYQgKecawOvyPe+CiWA7YanxLLsHd5o8IK+++AdKYkwiOsHlcgHoi6tJ/zXEBZUXt7Q078c17wfxvljPXnmovoXP51HWN6fMX1SNbzXtVJ69qzxusXA/ho2yyBDmpWluLmRjty4WagrGqwD3Q9ZqzOnsIyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mj5AUZ5/5mEiAJN1vWWyeHbUrRVL8aElZd+RfBYe7A=;
 b=xTn7kynTsry3OpE/5CsxG8AXLYTachQua/Ear3ICL+dmuHWNTF3CjF3RkYAAbCqRGj2sI0zL/1fSANEQodnrOzme0SLJmuemnBaKM+WlGZ7MVvC2WFiOrhK0j9WQHPXGymlTTfoY1x+MPeew9jCFZcAel1JpPUPU9LZhrSYnexIkyPwMpHOP8VG4R2sI9G/EnFDsbisMUG3HzVP8GZEHebzNsTdFvPDqMAv/SoJODyh4kbWW/4LFMFNzxnJGAkJRkdBUxqfg0g5tydc9pxpr7azpVaKq3UYTAkAZeB2FGOg4t2+W4i6tGQF04+6QET6kV8rvXh8vltiuLmyG5hx2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mj5AUZ5/5mEiAJN1vWWyeHbUrRVL8aElZd+RfBYe7A=;
 b=DG/FjBkfzzBiexQqc2AnL8OHO/vsRbvOcE8akLEgxWG7skI8jlTHYBlzE8Vl3u4o8NzVG7mXEYf7a2ux+haDYBe4EjIgHjSjsr2YQLBBnz+GYFhySOGceydYaec9/l3cSBMT0FG7Hpcy3dulIXy+stx8vxLy57by0skQl6EMlfY=
Received: from DU2PR04CA0232.eurprd04.prod.outlook.com (2603:10a6:10:2b1::27)
 by VI1PR0701MB6752.eurprd07.prod.outlook.com (2603:10a6:800:19c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 16:20:49 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::a6) by DU2PR04CA0232.outlook.office365.com
 (2603:10a6:10:2b1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 16:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 16:20:48 +0000
Received: from n9w6sw14.localnet (10.30.4.231) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 4 Dec
 2024 17:20:48 +0100
From: Christian Eggers <ceggers@arri.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Antoni Pokusinski <apokusinski01@gmail.com>, Francesco Dolcini
	<francesco@dolcini.it>, =?ISO-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?=
	<jpaulo.silvagoncalves@gmail.com>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?ISO-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: light: as73211: fix channel handling in only-color
 triggered buffer
Date: Wed, 4 Dec 2024 17:20:47 +0100
Message-ID: <3614353.dWV9SEqChM@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20241204-iio_memset_scan_holes-v2-2-3f941592a76d@gmail.com>
References: <20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com>
 <20241204-iio_memset_scan_holes-v2-2-3f941592a76d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|VI1PR0701MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ca7325-8817-4c7a-6811-08dd147f9d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iCZ5GFXuJpsyJLd19Icv/qKz9IP8qcS7hTelduGRy1Tv2wYuevsv2IaGzn8f?=
 =?us-ascii?Q?6SOJfUy7XTCMnaE1AEkhF3MfK0XSgU3XQAz9OQNBgqFxRGSWOfUusSMmsda/?=
 =?us-ascii?Q?bryif7vOswm9SCZA6O8xhoAUfU61JGJ4RzhceLfzgWLpCPjZ9VyjCi1bYCyd?=
 =?us-ascii?Q?AVgs3o0ZlHH2SkuMbeeZqEysdgO0jH/V69fnuejI2vqfZeVQ1IOcNr5nXR87?=
 =?us-ascii?Q?irgF5rjr00rFy3cuOudkBRilYeFic2ydvYE7ObYM2XACHd2FcUSknbs4LFoO?=
 =?us-ascii?Q?TgopqiUgEbm3+VJs+930rl8N0tJXfn+ycu4/apVu3+yIj+G5Lvlv8Ptjud31?=
 =?us-ascii?Q?2D+4Jt+Yk0oPkCWt81W0/L1ChKDsESgx4M6Lc4EG5Xoi5+TtO2CiSHrZy4Mv?=
 =?us-ascii?Q?eGwPr9vCZ63fxdaS0kQXBjsPEa5GJQ9O8QkyySMmufqEwysPIW24kGHpSeVx?=
 =?us-ascii?Q?9vjebq+tDMkYKZ1Rq1DE8JVJ+RbY9t20SCs5Wa7nw8ACMePrU2m7cWkcpfBt?=
 =?us-ascii?Q?eAW1uPeh7fWFFpJgyfVv04SOh/+x0U+ILXHeZ6Uw5wFMwzQrEVHXN7C3L/an?=
 =?us-ascii?Q?PhiY7CLdn98/xoKABcqGmn2EAPWoLULLfVy6nuh87KwuYuXE7QkxBbVeZnhV?=
 =?us-ascii?Q?xnM2KBtQzTs16I3pa++yaony9Mc9TY7h62WTdqMoxtLT//oV1QbSSYax9Z/6?=
 =?us-ascii?Q?zHl7swNlUFkC0j3n0LV2oYFpNEdvV01j3y2hqr051RXnsr8scSVzZITTnEcs?=
 =?us-ascii?Q?sdAV/tcxhSdRM4AopBxJwiYGokLR1/Vgeg0aRBv/3iAEp4+TXZZgqcVulbz/?=
 =?us-ascii?Q?B8jcxuwhIoUU4X8wTjovDZMqOCgD/Zd7tfLITtskScoQxoow7EFYO69A1KNu?=
 =?us-ascii?Q?Y5pnbPUaNRDeFCet1xAU2P9k0xVmCAh39R6AbwJEIgPBacQ1Tj1Wtc8k/uJW?=
 =?us-ascii?Q?lol6GD2w082nG6KtwLG68bG8ZFwltk5CkWZKakoj5UNAG6TS0dMI9z6uPScY?=
 =?us-ascii?Q?7wKPEsdrfKiWJrSBTaEf+W7wYjONXVvzT0z+zS6rToLkBIDwC5HlEijzHvCU?=
 =?us-ascii?Q?osPaFkPtRVLQLrF9Eb2tI8RgqhlSNUHbEWKrL+lW+mFmh6CeoMFLnouOXF5P?=
 =?us-ascii?Q?1WNqKWk6HTjefe/2cVarAD+Uw8nDFJoyP4+c6OLbUEjnYBgkWwbKvXiLhlzX?=
 =?us-ascii?Q?lAKE3ID1FvTEnueefVBbiFkYKXTA5mMUV+oaDPOFrjH4hbk91Z/JzNl19Hb4?=
 =?us-ascii?Q?HtnMPVw5Rnfpwuj9Lkpc4d6Tdotwi41bknW6uBFWYzgPgyQd1OXgy8jdG9Ed?=
 =?us-ascii?Q?7tqckCLvVwgXw3u57Hub8o6bI97hW33JdQ/6myuBBYx0kjujJyRnq1C75np1?=
 =?us-ascii?Q?Zi/qrayTmW909Zuzebhzuyq7x8mWGfLoEzn7y2KJPVxN65XWe079oRyeYQ1b?=
 =?us-ascii?Q?Xcg1b6vHZJLaSywd0nsLmdalPzqoCNH8?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:20:48.5442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ca7325-8817-4c7a-6811-08dd147f9d23
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6752

On Wednesday, 4 December 2024, 00:55:32 CET, Javier Carrasco wrote:
> The channel index is off by one unit if AS73211_SCAN_MASK_ALL is not
> set (optimized path for color channel readings), and it must be shifted
> instead of leaving an empty channel for the temperature when it is off.
> 
> Once the channel index is fixed, the uninitialized channel must be set
> to zero to avoid pushing uninitialized data.
> 
> Cc: stable@vger.kernel.org
> Fixes: 403e5586b52e ("iio: light: as73211: New driver")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/as73211.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index be0068081ebb..2d45dfeda406 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -672,9 +672,12 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>  
>  		/* AS73211 starts reading at address 2 */
>  		ret = i2c_master_recv(data->client,
> -				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
> +				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
>  		if (ret < 0)
>  			goto done;
> +
> +		/* Avoid pushing uninitialized data */
> +		scan.chan[3] = 0;
>  	}
>  
>  	if (data_result) {
> @@ -682,9 +685,15 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>  		 * Saturate all channels (in case of overflows). Temperature channel
>  		 * is not affected by overflows.
>  		 */
> -		scan.chan[1] = cpu_to_le16(U16_MAX);
> -		scan.chan[2] = cpu_to_le16(U16_MAX);
> -		scan.chan[3] = cpu_to_le16(U16_MAX);
> +		if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {
> +			scan.chan[1] = cpu_to_le16(U16_MAX);
> +			scan.chan[2] = cpu_to_le16(U16_MAX);
> +			scan.chan[3] = cpu_to_le16(U16_MAX);
> +		} else {
> +			scan.chan[0] = cpu_to_le16(U16_MAX);
> +			scan.chan[1] = cpu_to_le16(U16_MAX);
> +			scan.chan[2] = cpu_to_le16(U16_MAX);
> +		}
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> 
> 

With this change, having only X, Y and Z in the scan_mask (without the
temperature channel) works fine.

But it looks that there is still another problem if a single color channel
(e.g. X) is omitted from the scan mask (which probably wouldn't make much
sense in practice).  If I am right, the layout of scan.chan[] is also wrong for
that case, so e.g. if omitting X, the application will get the X values where
it expects the temperature value (which isn't read from the hardware at all).

Does it make sense to write a follow-up patch for this? I fear that taking all
possible combinations into account could make the driver more complicated than
necessary.  Or is there a good example how to handle such combinations?


Tested-by: Christian Eggers <ceggers@arri.de>





