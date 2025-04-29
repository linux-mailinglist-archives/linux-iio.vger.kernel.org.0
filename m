Return-Path: <linux-iio+bounces-18862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6BAA16A4
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400245A05FF
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81EC24E000;
	Tue, 29 Apr 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYFandJn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E407E110;
	Tue, 29 Apr 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947988; cv=none; b=C7wOHtQ8VZyAvMobg56jImM0dHe26FKR8mmo1mXMS809eNSulIepvc7JIWXyTfvGVw/jCIYowoHPPbVRT6CThibtugIeUT9l2v3rObAQeIKBrB8WDVDPxWaqVP20kK+Nya5XwzPIxioOQ3fz0GgfETlNOBfAWxINaQhSWGruT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947988; c=relaxed/simple;
	bh=jls8EKZP3x3ZeV9bGVIVbYrhlCx9XIdJZvD4fEcWk+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaLfeWLyrz8Ojxc3etVw7o4F7LcSpajwB9zWzSoQ2pT+pKK9hFFUmH+OuZAyGzhXPsXWDDYLpjbO0KyKRcxqRzv2hNMgzcI4ufjOO6pOMilcui3oCftxRPn3TohRFAY2wQKeCLiDpWOcTvQA9Ql0z1964YYXQGw1xDJm2lUBYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYFandJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E3CC4CEEE;
	Tue, 29 Apr 2025 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745947988;
	bh=jls8EKZP3x3ZeV9bGVIVbYrhlCx9XIdJZvD4fEcWk+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pYFandJnS6iEp4jB7DcYg5LCip0gzke/SigpAK5O0GXDQyvLCXnrTpLsnXsABIXoU
	 5s1MzARBN2XEGef6YPP2vQAJbkqFAVtODzKbjhlLKAm4MXyFNB0pFIriKAV7IQ3cp+
	 mvUaNoiRHt2Koz9nltR8cwsdouOfcaa+m7Xn/16UiVrgs3SJI9HmwuBF2ubvz3l2Lp
	 zpX8jj9NzNNdUaT58k/FkGori+u1Fh+3d/HTxHH4Mr7ZtcKlAyyI1jPiFr+XHkXGja
	 Z+OYBQ/UE/kpkDKdghC5zNT7jyPa30r2tWOCyfRFnftIUv+LTtlWyJkW4wWOVrEXKq
	 /5FBORMIlFZPA==
Date: Tue, 29 Apr 2025 18:33:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org, Fabio Estevam
 <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
Message-ID: <20250429183301.326eaacf@jic23-huawei>
In-Reply-To: <20250429150213.2953747-1-festevam@gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 12:02:12 -0300
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
> Fix the available_scan_masks sanity check logic so that it
> only prints the warning when an element of available_scan_mask
> is in fact a subset of a previous one.
> 
> These warnings incorrectly report that later scan masks are subsets of
> the first one, even when they are not. The issue lies in the logic that
> checks for subset relationships between scan masks.

Add a little on why the logic is wrong would be good.

I stared at this for a while when you first reported it and
couldn't spot it..


> 
> Fix the subset detection to correctly compare each mask only
> against previous masks, and only warn when a true subset is found.
> 
> With this fix, the warning output becomes both correct and more
> informative:
> 
> max1363 1-0064: Mask 7 (0xc) is a subset of mask 6 (0xf) and will be ignored
> 
> Cc: stable@vger.kernel.org
> Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  drivers/iio/industrialio-core.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6a6568d4a2cb..855d5fd3e6b2 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1904,6 +1904,11 @@ static int iio_check_extended_name(const struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  
> +static int is_subset(unsigned long a, unsigned long b)
> +{
> +	return (a & ~b) == 0;
> +}
> +
>  static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
>  {
>  	unsigned int num_masks, masklength, longs_per_mask;
> @@ -1947,21 +1952,13 @@ static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
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
> +	for (i = 1; i < num_masks; ++i)
> +		for (int j = 0; j < i; ++j)
> +			if (is_subset(av_masks[i], av_masks[j]))

Why move away from the bitmap_subset() call?

There are some broken corners for large bitmaps but I'd
rather not make it worse if we can avoid it as the intent is
that we can make these larger bitmaps if needed.


>  				dev_warn(indio_dev->dev.parent,
> -					 "available_scan_mask %d subset of %d. Never used\n",
> -					 j, i);
> -		}
> -	}
> +					 "Mask %d (0x%lx) is a subset of mask %d (0x%lx) and will be ignored\n",
> +					 i, av_masks[i], j, av_masks[j]);
>  }
>  
>  /**


