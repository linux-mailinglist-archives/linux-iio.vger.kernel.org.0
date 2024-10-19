Return-Path: <linux-iio+bounces-10785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CB9A4E81
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FD11C2135F
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AEC2207A;
	Sat, 19 Oct 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnNNVDr1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF015E81;
	Sat, 19 Oct 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347066; cv=none; b=gJ316DPt18uAqTmVWM++axDr3rooSjU/5/F+pVKA9YnKFER+nxLKemap+dRm/dzSrEa4toGwTjEZfhQCcMYvKL6xi5M2BPt9g5toMVd+RvBnVfvIbvkbRC4eB7MXVFIiZE1CMzZLOl+Gzc9qD0OT2t6OPhCrr0sHEWIQEy1QlY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347066; c=relaxed/simple;
	bh=/X2ej3Dn7UsSI9DfvUJdLKMZ1if/iYptpT5OAn5/WS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkTuZIWxUrk00Wkp7qzgjuxjgrPiwHa5ixOg1lljJKpYkfyJNot8ks8elfmgUhB7p88tGSx1Bk7jgR5GySaWdMKXU7+P1I3b2Y3MtaO3O6cjPo2nIo+f4X11aZqLMxQFsZGmiQ2iuddANfVKsu+tncmuYMHzRxmmR9A2W6YmFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnNNVDr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7545C4CEC5;
	Sat, 19 Oct 2024 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729347066;
	bh=/X2ej3Dn7UsSI9DfvUJdLKMZ1if/iYptpT5OAn5/WS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XnNNVDr10D7XF5sIQ1QuztDdj/AlAvH/runVRDre7g8jhMfiEG58HcecaAqTw5PLL
	 jV1hjtQ3+JTYTi6tYdh/J5QYGAauaG24mFiZsca50V/4Nbfd1+8LD20Kwcsj9L298g
	 ShhUKfywezr53XSwcWzCiLmJjaERBO7cFEX7+dx03gaTk0IoLlufk6VP4QTVQgYzcU
	 K/x8/czobYZ+UoNO+idKKsq2C97G8rJ5wiDh2nCLLJyUUK2XLYHiN5v93PnRhnTVb/
	 KYNO+g0Wc6g0x9rhrwEzts5a5kTp6Qr6ZTryS837hxvlPTWwB0lI270d7fQ/G3WOhc
	 jI74ac3ipRvdw==
Date: Sat, 19 Oct 2024 15:10:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <mazziesaccount@gmail.com>, <lars@metafoo.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: gts-helper: Fix memory leaks for the error path
 of iio_gts_build_avail_scale_table()
Message-ID: <20241019151045.5b86cb3e@jic23-huawei>
In-Reply-To: <20241016012453.2013302-1-ruanjinjie@huawei.com>
References: <20241016012453.2013302-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 09:24:53 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> If per_time_scales[i] or per_time_gains[i] kcalloc fails in the for loop
> of iio_gts_build_avail_scale_table(), the err_free_out will fail to call
> kfree() each time when i is reduced to 0, so all the per_time_scales[0]
> and per_time_gains[0] will not be freed, which will cause memory leaks.
> 
> Fix it by checking if i >= 0.
> 
> Cc: stable@vger.kernel.org
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Applied.
> ---
> v2:
> - Update the commit message.
> - Add Reviewed-by.
> ---
>  drivers/iio/industrialio-gts-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7326c7949244..5f131bc1a01e 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -315,7 +315,7 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>  	return 0;
>  
>  err_free_out:
> -	for (i--; i; i--) {
> +	for (i--; i >= 0; i--) {
>  		kfree(per_time_scales[i]);
>  		kfree(per_time_gains[i]);
>  	}


