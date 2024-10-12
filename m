Return-Path: <linux-iio+bounces-10525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEF399B60E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519EA2825A7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE83AC2B;
	Sat, 12 Oct 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/frBg+m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595317993;
	Sat, 12 Oct 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728749767; cv=none; b=EvW9iv3u9ZpINTNBDWmEN1N55vDcjbrZ/PQ4S3qFZJMAQqqA9e/E9PDAyNV9JgU+V74nBaQ4fcixhL7kCjWB+S4C0CnqIXtugJuQeFnx8X6pDZ5oyvDhaWsk0lW+fJk7Uq1p4mhQTZk5Vpmeq71Xo6/dzGrEOrVNwfqMehQGaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728749767; c=relaxed/simple;
	bh=qGDf/vEhiszj7Otj4WWZ6hT1HU9tpl6YOZdUU12lsAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ekwaj4xeNd9rBeIBpEETNNA5JPudBCRhDpgPTl752GwWrdtM3OaNtYLyh6D0fM7S5wbBym1W2NMThO+r9270N4cN/KbsqaPQGhnNK5kJ1eNG7BeYcBK9WP8VqpvD+hnXG6sf0axXn8jIi/r9VsoBuWaE7XK9/j3fX0d6VnZjLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/frBg+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2132BC4CEC6;
	Sat, 12 Oct 2024 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728749766;
	bh=qGDf/vEhiszj7Otj4WWZ6hT1HU9tpl6YOZdUU12lsAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/frBg+moz5sz/LGPXuX5Tz8bGU2g5GiIE/jAa4r5yC4PydLG1nkLx1IcLybQ0m6l
	 cQQwJKlYaDQUei56rEGYgOrZN1mq3rx34apiJzZQfajrFYPd117S6Zau/MInsGjNFn
	 HhbvN//3QWx+OjhfPI4rpDHcgYywwHBHtegWcrPUOcVU4T5894MDWwboFO7tisN0B9
	 t9F+9zXWCLZ4j5z1LeT/r9BWruyRVPaFbqu3w8/Dd+o0ggrfJ6Km/kr+nbBR0Ulv+S
	 ELglqwPqFhrFRvPnYXhTGKo9Es2sobSFh5G1x//lqrHDirNHRsztbuUvg+eBhgObVy
	 zNbpXRudaIolA==
Date: Sat, 12 Oct 2024 17:15:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <mazziesaccount@gmail.com>, <lars@metafoo.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: gts-helper: Fix memory leaks in
 iio_gts_build_avail_scale_table()
Message-ID: <20241012171559.2c118a2f@jic23-huawei>
In-Reply-To: <20241011095512.3667549-1-ruanjinjie@huawei.com>
References: <20241011095512.3667549-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 17:55:12 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> modprobe iio-test-gts and rmmod it, then the following memory leak
> occurs:
> 
> 	unreferenced object 0xffffff80c810be00 (size 64):
> 	  comm "kunit_try_catch", pid 1654, jiffies 4294913981
> 	  hex dump (first 32 bytes):
> 	    02 00 00 00 08 00 00 00 20 00 00 00 40 00 00 00  ........ ...@...
> 	    80 00 00 00 00 02 00 00 00 04 00 00 00 08 00 00  ................
> 	  backtrace (crc a63d875e):
> 	    [<0000000028c1b3c2>] kmemleak_alloc+0x34/0x40
> 	    [<000000001d6ecc87>] __kmalloc_noprof+0x2bc/0x3c0
> 	    [<00000000393795c1>] devm_iio_init_iio_gts+0x4b4/0x16f4
> 	    [<0000000071bb4b09>] 0xffffffdf052a62e0
> 	    [<000000000315bc18>] 0xffffffdf052a6488
> 	    [<00000000f9dc55b5>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000175a3fd4>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000f505065d>] kthread+0x2e8/0x374
> 	    [<00000000bbfb0e5d>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80cbfe9e70 (size 16):
> 	  comm "kunit_try_catch", pid 1658, jiffies 4294914015
> 	  hex dump (first 16 bytes):
> 	    10 00 00 00 40 00 00 00 80 00 00 00 00 00 00 00  ....@...........
> 	  backtrace (crc 857f0cb4):
> 	    [<0000000028c1b3c2>] kmemleak_alloc+0x34/0x40
> 	    [<000000001d6ecc87>] __kmalloc_noprof+0x2bc/0x3c0
> 	    [<00000000393795c1>] devm_iio_init_iio_gts+0x4b4/0x16f4
> 	    [<0000000071bb4b09>] 0xffffffdf052a62e0
> 	    [<000000007d089d45>] 0xffffffdf052a6864
> 	    [<00000000f9dc55b5>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000175a3fd4>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000f505065d>] kthread+0x2e8/0x374
> 	    [<00000000bbfb0e5d>] ret_from_fork+0x10/0x20
> 	......
> 
> It includes 5*5 times "size 64" memory leaks, which correspond to 5 times
> test_init_iio_gain_scale() calls with gts_test_gains size 10 (10*size(int))
> and gts_test_itimes size 5. It also includes 5*1 times "size 16"
> memory leak, which correspond to one time __test_init_iio_gain_scale()
> call with gts_test_gains_gain_low size 3 (3*size(int)) and gts_test_itimes
> size 5.
> 
> The reason is that the per_time_gains[i] is not freed which is allocated in
> the "gts->num_itime" for loop in iio_gts_build_avail_scale_table().
> 
> Cc: stable@vger.kernel.org
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Hi Jinjie,

Your explanation looks correct to me.  I'll wait a while though to give Matti time
to take a look as well.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-gts-helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 59d7615c0f56..7326c7949244 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -307,6 +307,8 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>  	if (ret)
>  		goto err_free_out;
>  
> +	for (i = 0; i < gts->num_itime; i++)
> +		kfree(per_time_gains[i]);
>  	kfree(per_time_gains);
>  	gts->per_time_avail_scale_tables = per_time_scales;
>  


