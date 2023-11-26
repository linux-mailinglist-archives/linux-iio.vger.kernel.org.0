Return-Path: <linux-iio+bounces-403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E187F9494
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1D9281091
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25388DF59;
	Sun, 26 Nov 2023 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5lLJiT4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9246A2
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 17:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28E1C433C8;
	Sun, 26 Nov 2023 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701019573;
	bh=QstMPvKZWWXH1k6uFIpPTJoYRIG+NxTa6oNipKjBo/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s5lLJiT4T84tmmeh+iHocFr7oUyMjz64PpsL8MXDGj09RRXt8wEAUWqEYXg4fQllf
	 ztQSlQUsqnlKwK8kE8erNEdg+KxcTFkxxoGLAEK1q9GhUaEfItUcqQJ1kPFUKyRJtz
	 aOSArLpLRe5F0CsJ2FqQffoRzoxDfmkV9YDhtgo1oPUlQGrJLK3R/UUPJj9gt3TJTc
	 7KH5q55Wl2ZL8Lxo2P5ejzrbtm85SU2/Z4aQHPXjstJJh28QO+AbJ/wrEcI9hR+jP0
	 zkRFe5osBHyGcptknaa1w8NBk7Mq7eu+CESofaDqPIQSnRQNDTPF7TsZkqOLKMcW6u
	 v1ikw9yqWnHcg==
Date: Sun, 26 Nov 2023 17:26:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gts-helpers: Round gains and scales
Message-ID: <20231126172607.379c9d79@jic23-huawei>
In-Reply-To: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
References: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Oct 2023 11:50:46 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The GTS helpers do flooring of scale when calculating available scales.
> This results available-scales to be reported smaller than they should
> when the division in scale computation resulted remainder greater than
> half of the divider. (decimal part of result > 0.5)
> 
> Furthermore, when gains are computed based on scale, the gain resulting
> from the scale computation is also floored. As a consequence the
> floored scales reported by available scales may not match the gains that
> can be set.
> 
> The related discussion can be found from:
> https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/
> 
> Do rounding when computing scales and gains.
> 
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

A few questions inline about the maths.

> 
> ---
> Subjahit, is there any chance you test this patch with your driver? Can
> you drop the:
> 	if (val2 % 10)
> 		val2 += 1;
> from scale setting and do you see written and read scales matching?
> 
> I did run a few Kunit tests on this change - but I'm still a bit jumpy
> on it... Reviewing/testing is highly appreciated!
> 
> Just in case someone is interested in seeing the Kunit tests, they're
> somewhat unpolished & crude and can emit noisy debug prints - but can
> anyways be found from:
> https://github.com/M-Vaittinen/linux/commits/iio-gts-helpers-test-v6.6
> 
> ---
>  drivers/iio/industrialio-gts-helper.c | 58 +++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7653261d2dc2..7dc144ac10c8 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -18,6 +18,32 @@
>  #include <linux/iio/iio-gts-helper.h>
>  #include <linux/iio/types.h>
>  
> +static int iio_gts_get_gain_32(u64 full, unsigned int scale)
> +{
> +	unsigned int full32 = (unsigned int) full;
> +	unsigned int rem;
> +	int result;
> +
> +	if (full == (u64)full32) {
> +		unsigned int rem;
> +
> +		result = full32 / scale;
> +		rem = full32 - scale * result;
> +		if (rem >= scale / 2)
> +			result++;
> +
> +		return result;
> +	}
> +
> +	rem = do_div(full, scale);

As below, can we just add scale/2 to full in the do_div?

> +	if ((u64)rem >= scale / 2)
> +		result = full + 1;
> +	else
> +		result = full;
> +
> +	return result;
> +}
> +
>  /**
>   * iio_gts_get_gain - Convert scale to total gain
>   *
> @@ -28,30 +54,42 @@
>   *		scale is 64 100 000 000.
>   * @scale:	Linearized scale to compute the gain for.
>   *
> - * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
> + * Return:	(rounded) gain corresponding to the scale. -EINVAL if scale
>   *		is invalid.
>   */
>  static int iio_gts_get_gain(const u64 max, const u64 scale)
>  {
> -	u64 full = max;
> +	u64 full = max, half_div;
> +	unsigned int scale32 = (unsigned int) scale;
>  	int tmp = 1;
>  
> -	if (scale > full || !scale)
> +	if (scale / 2 > full || !scale)

Seems odd. Why are we checking scale / 2 here?

>  		return -EINVAL;
>  
> +	/*
> +	 * The loop-based implementation below will potentially run _long_
> +	 * if we have a small scale and large 'max' - which may be needed when
> +	 * GTS is used for channels returning specific units. Luckily we can
> +	 * avoid the loop when scale is small and fits in 32 bits.
> +	 */
> +	if ((u64)scale32 == scale)
> +		return iio_gts_get_gain_32(full, scale32);
> +
>  	if (U64_MAX - full < scale) {
>  		/* Risk of overflow */
> -		if (full - scale < scale)
> +		if (full - scale / 2 < scale)
>  			return 1;
>  
>  		full -= scale;
>  		tmp++;
>  	}
>  
> -	while (full > scale * (u64)tmp)
> +	half_div = scale >> 2;

Why divide by 4?  Looks like classic issue with using shifts for division
causing confusion.

> +
> +	while (full + half_div >= scale * (u64)tmp)
>  		tmp++;
>  
> -	return tmp;
> +	return tmp - 1;
>  }
>  
>  /**
> @@ -133,6 +171,7 @@ static int iio_gts_linearize(int scale_whole, int scale_nano,
>   * Convert the total gain value to scale. NOTE: This does not separate gain
>   * generated by HW-gain or integration time. It is up to caller to decide what
>   * part of the total gain is due to integration time and what due to HW-gain.
> + * Computed gain is rounded to nearest integer.
>   *
>   * Return: 0 on success. Negative errno on failure.
>   */
> @@ -140,10 +179,13 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
>  				int *scale_int, int *scale_nano)
>  {
>  	u64 tmp;
> +	int rem;
>  
>  	tmp = gts->max_scale;
>  
> -	do_div(tmp, total_gain);
> +	rem = do_div(tmp, total_gain);

can we do usual trick of
do_div(tmp + total_gain/2, total_gain)
to get the same rounding effect?

> +	if (total_gain > 1 && rem >= total_gain / 2)
> +		tmp += 1ULL;
>  
>  	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
>  }
> @@ -192,7 +234,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
>  		     NULL);
>  
> -		/* Convert gains to scales */
> +		/* Convert gains to scales. */

Grumble - unrelated change.

>  		for (j = 0; j < gts->num_hwgain; j++) {
>  			ret = iio_gts_total_gain_to_scale(gts, gains[i][j],
>  							  &scales[i][2 * j],
> 
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa


