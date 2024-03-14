Return-Path: <linux-iio+bounces-3520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB3587C06C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2431B1F21BDF
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D171B37;
	Thu, 14 Mar 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmTggI4m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D171B20
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430630; cv=none; b=BVI/q8HRYv1yjDtx37tfEFqJk3+TCyRSmvLwQytMCZ6jdj+Ho2NAv7gQ2GBjv3U/lGU9Ln2/lK6Y5kWtzZsLRGfsDB75a7TWUNdrYzJ8OJ6rJY7i+/kRf5lzQywmebVjoo0n75iFCARh1pLINWBtE+g30pxY4CeIcLi/dwGnFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430630; c=relaxed/simple;
	bh=cPADldGSwQorMVNrWhzYNIKpsz4a507wmnA2WUujMM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xz3vwRMzojy602IVywnWuxVEtHn+482HuJAUdlGiTNn7gOsjUBoPKv/9fgsNK2gzMEbPStAvg+zIEUUNXYAP2sKp7NAHqsYf+aI4qlnxAoe5flu46tAuICXrJfP8h1DeqFXP8yJgcGUxifnzNNmYA7pJ5l5jo9jDqM1E7DStV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmTggI4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8EDC433C7;
	Thu, 14 Mar 2024 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710430629;
	bh=cPADldGSwQorMVNrWhzYNIKpsz4a507wmnA2WUujMM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EmTggI4mXHp6n8ZErK+D3yrB8puhs/+24uu/9cFDq3UIhhLBfEPDAvm+YUWs7zk4O
	 dk5NIw2IVJexwKijG5VYdvNQZKgQJJoc6z1nBhclq9y2DiWN/SBUYJs8X7c+dDo/WS
	 K4rYKAgxei7lFlWL8BXF4zl5AG7NCNNUN4KHFKc9uDwdn/EnKftRNBAeiJcvBlBCeI
	 K6HTAna/90QWBxouXq2lVbZFfKrtOP9zh95PfH5drFEtka47sKpnwZhrY3cpOTMDSy
	 hV2avSiodkUA6ZNv29soSNQgb81+XHNR6BjhVRP62HR2u765NHiDj4/YYcQBqfuykR
	 eixrN4dp1A+pA==
Date: Thu, 14 Mar 2024 15:36:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: mazziesaccount@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Message-ID: <20240314153656.493ee487@jic23-huawei>
In-Reply-To: <ZfHM73ZqgnCp6CZv@cy-server>
References: <ZfHM73ZqgnCp6CZv@cy-server>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 10:57:35 -0500
Chenyuan Yang <chenyuan0y@gmail.com> wrote:

> The sorting in iio_gts_build_avail_time_table is not working as intended.
For function names, add () so
The sorting in iio_gts_build_avail_time_table() is not working as intended.

I can fix this up whilst applying but will be waiting for a RB or related
from Matti before queuing this up.

I'm assuming there are no existing drivers in tree that hit this problem?
If there are reply saying which ones so I can assess whether to rush this
fix in or not.

Thanks,

Jonathan


> It could result in an out-of-bounds access when the time is zero.
> 
> Here are more details:
> 
> 1. When the gts->itime_table[i].time_us is zero, e.g., the time
> sequence is `3, 0, 1`, the inner for-loop will not terminate and do
> out-of-bound writes. This is because once `times[j] > new`, the value
> `new` will be added in the current position and the `times[j]` will be
> moved to `j+1` position, which makes the if-condition always hold.
> Meanwhile, idx will be added one, making the loop keep running without
> termination and out-of-bound write.
> 2. If none of the gts->itime_table[i].time_us is zero, the elements
> will just be copied without being sorted as described in the comment
> "Sort times from all tables to one and remove duplicates".
> 
> For more details, please refer to https://lore.kernel.org/all/6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com.
> 
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 38416c28e16890b52fdd5eb73479299ec3f062f3 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7653261d2dc2..61714a8d5717 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -375,7 +375,7 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>  	for (i = gts->num_itime - 1; i >= 0; i--) {
>  		int new = gts->itime_table[i].time_us;
>  
> -		if (times[idx] < new) {
> +		if (idx == 0 || times[idx - 1] < new) {
>  			times[idx++] = new;
>  			continue;
>  		}
> @@ -385,9 +385,10 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>  				memmove(&times[j + 1], &times[j],
>  					(idx - j) * sizeof(int));
>  				times[j] = new;
> -				idx++;
> +				break;
>  			}
>  		}
> +		idx++;
>  	}
>  
>  	/* create a list of times formatted as list of IIO_VAL_INT_PLUS_MICRO */
> 


