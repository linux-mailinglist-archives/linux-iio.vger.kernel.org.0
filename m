Return-Path: <linux-iio+bounces-18910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9863CAA52A7
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 19:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDFA1C06107
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9E25E44B;
	Wed, 30 Apr 2025 17:36:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686E264A7E;
	Wed, 30 Apr 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746034561; cv=none; b=HSJpRjfBnekbDfKgb4t6n4Fgc5UB43bAMRFE+86LifcvbzRb8e0BKSW5oasM6AV+q+EWrJHqPTFhj3Rc4hyN5NHxDkQ68hlu9M3r1FAYl/KPoshSEwivYSlHyi8dy/AWxs8cTFZQZWl861wxSIllUzVaxci3uvMITRpFPqMYuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746034561; c=relaxed/simple;
	bh=xUENiuUsWOzwhoofIpcPbKtlaOGW0jCJFuUnDxzc9fM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyZhAp2vMfy3SLy6J0X3L1UqU3Jv9oUq9UM3yXtBch4MmvJPZaeTSn2av5rB4RGXz51rhPfBLYoC5earktxs/VKGQ3U25knD2mzhe+ka2veVz0ml2TF18uBCJjoRzb0oLlQh2FQK4U0yunhPOe2dbzFnbYFgBMyzs43GpnB8bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Znkjy1tCYz6K9Pw;
	Thu,  1 May 2025 01:31:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CF18140277;
	Thu,  1 May 2025 01:35:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Apr
 2025 19:35:55 +0200
Date: Wed, 30 Apr 2025 18:35:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fabio Estevam <festevam@gmail.com>
CC: <jic23@kernel.org>, <mazziesaccount@gmail.com>,
	<linux-iio@vger.kernel.org>, Fabio Estevam <festevam@denx.de>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] iio: Fix scan mask subset check logic
Message-ID: <20250430183554.000038c1@huawei.com>
In-Reply-To: <20250429201717.3066511-1-festevam@gmail.com>
References: <20250429201717.3066511-1-festevam@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Apr 2025 17:17:17 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 2718f15403fb ("iio: sanity check available_scan_masks array"),
> verbose and misleading warnings are printed for devices like the MAX11601:
> 
> max1363 1-0064: available_scan_mask 8 subset of 0. Never used
> max1363 1-0064: available_scan_mask 9 subset of 0. Never used
> max1363 1-0064: available_scan_mask 10 subset of 0. Never used
> max1363 1-0064: available_scan_mask 11 subset of 0. Never used
> max1363 1-0064: available_scan_mask 12 subset of 0. Never used
> max1363 1-0064: available_scan_mask 13 subset of 0. Never used
> ...
> [warnings continue] 
> 
> Adding some debug prints show that the mask1 and mask2 indexes
> are incorrectly computed, leading to wrong array access.

Just for reference, as per the max1363 thread, the
bug isn't what is changed here, but rather another driver side problem.

> 
> These incorrect accesses causes the wrong subset output:
> 
> iio-core: ******** mask1[0] is 0x1
> iio-core: ******** mask2[1] is 0x4
> iio-core: ******** mask2[2] is 0x3
> iio-core: ******** mask2[3] is 0xf
> iio-core: ******** mask2[4] is 0x1000
> iio-core: ******** mask2[5] is 0x40000
> iio-core: ******** mask2[6] is 0x3000
> iio-core: ******** mask2[7] is 0x0
> iio-core: ******** mask2[8] is 0xffff0000000e2720
> max1363 1-0064: available_scan_mask 8 subset of 0. Never used
> iio-core: ******** mask2[9] is 0xffff0000000e2660
> max1363 1-0064: available_scan_mask 9 subset of 0. Never used
> iio-core: ******** mask2[10] is 0xffff0000000e25a0
> max1363 1-0064: available_scan_mask 10 subset of 0. Never used
> iio-core: ******** mask2[11] is 0xffff0000000e24e0
> max1363 1-0064: available_scan_mask 11 subset of 0. Never used
> iio-core: ******** mask2[12] is 0xffff0000000e2420
> max1363 1-0064: available_scan_mask 12 subset of 0. Never used
> iio-core: ******** mask2[13] is 0xffff0000000e2360
> max1363 1-0064: available_scan_mask 13 subset of 0. Never used
> 
> Fix the available_scan_masks sanity check logic so that it
> only prints the warning when an element of available_scan_mask
> is in fact a subset of a previous one.
> 
> With this fix, the warning output becomes both correct and more
> informative:
> 
> max1363 1-0064: Mask 7 (0xc) is a subset of mask 6 (0xf) and will be ignored.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Make it a standalone patch. max1363 fix will be sent later.
> - Keep using bitmap_subset().
> - Add more information about the error in the commit log.
> 
>  drivers/iio/industrialio-core.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6a6568d4a2cb..dabfcb50e5fe 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1947,21 +1947,13 @@ static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
>  	 * available masks in the order of preference (presumably the least
>  	 * costy to access masks first).
>  	 */
> -	for (i = 0; i < num_masks - 1; i++) {
> -		const unsigned long *mask1;
> -		int j;
>  
> -		mask1 = av_masks + i * longs_per_mask;
> -		for (j = i + 1; j < num_masks; j++) {
> -			const unsigned long *mask2;
> -
> -			mask2 = av_masks + j * longs_per_mask;
> -			if (bitmap_subset(mask2, mask1, masklength))
> +	for (i = 1; i < num_masks; i++)
> +		for (int j = 0; j < i; j++)
> +			if (bitmap_subset(&av_masks[i], &av_masks[j], BITS_PER_LONG))
>  				dev_warn(indio_dev->dev.parent,
> -					 "available_scan_mask %d subset of %d. Never used\n",
> -					 j, i);
> -		}
> -	}
> +					 "Mask %d (0x%lx) is a subset of mask %d (0x%lx) and will be ignored.\n",
> +					 i, av_masks[i], j, av_masks[j]);
>  }
>  
>  /**


