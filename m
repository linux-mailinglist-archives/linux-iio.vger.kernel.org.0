Return-Path: <linux-iio+bounces-21391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2542AFA483
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC0F189CDF9
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AF51FDA9E;
	Sun,  6 Jul 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIGTvz0j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0A1A9B3D;
	Sun,  6 Jul 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751798132; cv=none; b=fRc/lJZVq2NBHQ7PoTqDuvcY7Mnv9Rm3uZhkpGJL+JCP5pkF9A2Y/WrDhu5TaCoLUYM04SlF+/M6BUelSbNqUpxz03w5WBeVUCSPb4iy61qjPOAViev38Y0/eUpkdy9FGX3nArKS/wpZwo4gNPuNcDix75sVV9LXi+QM0EOe92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751798132; c=relaxed/simple;
	bh=iw9W7eKsGSO+1wAmPx6nLdHMNNWYLY9hCIj8UzZY+Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtKEuKYN6SuvcvO82dK/zQxLtko8ltptT4E+75E6j2U4ZvaOMCkJTQPgA1j5cV8TQwnVDV2oKk9BMyt9NypOeh9+HLgOrwdLjQZb5TmFB3llG6PtP5nt0q0b4oS8ayT90vI4MMl7p0LS9MZjejOl0To0lG5TA/J0oP3jfe2viCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIGTvz0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B0C4CEED;
	Sun,  6 Jul 2025 10:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751798131;
	bh=iw9W7eKsGSO+1wAmPx6nLdHMNNWYLY9hCIj8UzZY+Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WIGTvz0j1n2CFLGuOvApT9PP/1fHOEQ1aJwoEOOcgWC+pVTgyTSFOVeBsQ1oJDwU1
	 G9kTtY04mkfLteVI7bBG3ZmzurfBV0/cUAab7A1tA7IUeEdKqyzk33+3qnRdO8M18q
	 BBdRE77ciOnVrKtZl0lKrEExCusnH6TYHV0vNnF/m+MmuRWeNlgbr0ox+7jM9YKtBU
	 aiR6EtkdzOOBTlwd2I3Ep54eYjmsKKYIFCB5BpkiAskJ+5xo82wA5TEAYXzTzzKLFJ
	 e6Ganorx29zxoJf3Sw2/Wzno8oPx21jAJxJa9Pahh07jQ8jLlVPwSyrqKO2VSpVBGz
	 D+/t1vylrtZSg==
Date: Sun, 6 Jul 2025 11:35:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guillaume Ranquet
 <granquet@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: fix channels index for syscalib_mode
Message-ID: <20250706113525.3996d46b@jic23-huawei>
In-Reply-To: <20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-v1-1-7fdaedb9cac0@baylibre.com>
References: <20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-v1-1-7fdaedb9cac0@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Jul 2025 14:51:17 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix the index used to look up the channel when accessing the
> syscalib_mode attribute. The address field is a 0-based index (same
> as scan_index) that it used to access the channel in the
> ad7173_channels array throughout the driver. The channels field, on
> the other hand, may not match the address field depending on the
> channel configuration specified in the device tree and could result
> in an out-of-bounds access.
> 
> Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied and marked for stable.
> ---
>  drivers/iio/adc/ad7173.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..03412895f6dc71fcf8a07d09eb9f94a3840f02ef 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -318,7 +318,7 @@ static int ad7173_set_syscalib_mode(struct iio_dev *indio_dev,
>  {
>  	struct ad7173_state *st = iio_priv(indio_dev);
>  
> -	st->channels[chan->channel].syscalib_mode = mode;
> +	st->channels[chan->address].syscalib_mode = mode;
>  
>  	return 0;
>  }
> @@ -328,7 +328,7 @@ static int ad7173_get_syscalib_mode(struct iio_dev *indio_dev,
>  {
>  	struct ad7173_state *st = iio_priv(indio_dev);
>  
> -	return st->channels[chan->channel].syscalib_mode;
> +	return st->channels[chan->address].syscalib_mode;
>  }
>  
>  static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
> @@ -347,7 +347,7 @@ static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
>  	if (!iio_device_claim_direct(indio_dev))
>  		return -EBUSY;
>  
> -	mode = st->channels[chan->channel].syscalib_mode;
> +	mode = st->channels[chan->address].syscalib_mode;
>  	if (sys_calib) {
>  		if (mode == AD7173_SYSCALIB_ZERO_SCALE)
>  			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_SYS_ZERO,
> 
> ---
> base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
> change-id: 20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-49b404e99e0c
> 
> Best regards,


