Return-Path: <linux-iio+bounces-13658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EF29F7F1C
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08D5160820
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D722756F;
	Thu, 19 Dec 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkKipVW/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10202225A37;
	Thu, 19 Dec 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624791; cv=none; b=DNwdjJZ3yO6ZxeRQXStelCLvBtBjySqrVXG6npXuO0j2LjSry04MsB9OxXrhVhz1Zp21nQXxxKDKZEewOYQ+1Ozp8b7FidbrTeBghyWQILud8QWSN9ULX7hdB2+Tz7c62hEa5xIqHt15tq3bsfV+qb4ua3Xjacel/OBUE2jveNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624791; c=relaxed/simple;
	bh=rgoQAbEJTQwRzXRD3IxE7lues6tslYN8Drjs2rCJCqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiJH4iLGuG10mSU9YQLoYFV2t7FUR6LrOuzATLo0e5VW2Rn0L4VtU8+f7GMx4yRGDKhn3zzR1IDZfLD4K+Az1ZHeXcUpLYEpIqG2VqBVQdjb+WFZZvNewZmL0gmD71DLA8ZLGYwwVESR4F4vP2RQP/l8aoHvxdr7+1QC2zNyL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkKipVW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F291C4CECE;
	Thu, 19 Dec 2024 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734624790;
	bh=rgoQAbEJTQwRzXRD3IxE7lues6tslYN8Drjs2rCJCqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BkKipVW/xO8twF1E1WTEGvAKvxm/rgE+KBYPaQ65/9hUYLW/AjitfMxjWi6aHn1Vs
	 iyOL5l9W9RHLxyknG20uFWjangL5k/M85Hj9MEcx7pIioSMGfZdRgl/4QO2c4HCKeE
	 MDpdvP9LMCUp2Iaz09h8/Oza8sK3jOulJY8Jy+cxvjzh4S/1q18lhG0mg7SfvmQzCN
	 iSPAajQV2Q6xftOToAu1jxu1IUu687nf9L5sa+V+cOAsWdqorKf28mfef6WSMzWilf
	 oHVj41waFscxvPcO9aOfw1Juaj7+zzvcplMgdNydJNVRHXD+/K9oOgLd7vNrg8bZU1
	 FqUhDGD2YMPxA==
Date: Thu, 19 Dec 2024 16:13:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4695: add offload-based oversampling
 support
Message-ID: <20241219161301.3f708302@jic23-huawei>
In-Reply-To: <20241217-ad4695-oversampling-v1-1-0b045d835dac@baylibre.com>
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
	<20241217-ad4695-oversampling-v1-1-0b045d835dac@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 16:47:28 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add support for the ad4695's oversampling feature when SPI offload is
> available. This allows the ad4695 to set oversampling ratios on a
> per-channel basis, raising the effective-number-of-bits from 16
> (OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
> full cycle through the auto-sequencer). The logic for reading and
> writing sampling frequency for a given channel is also adjusted based on
> the current oversampling ratio.
> 
> The non-offload case isn't supported as there isn't a good way to
> trigger the CNV pin in this mode. Support could be added in the future
> if a use-case arises.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Hi Trevor,

The clamping fun of get_calibbias seems overkill. If this isn't going to ever
overflow an s64 maybe just use the high precision to do it the easy way.
I'm not sure you can't just fit it in an s32 for that matter. I've just
not done the maths to check.

Jonathan


> +static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
> +{
> +	unsigned int reg_val;
> +
> +	switch (osr) {
> +	case 4:
> +		if (val2 >= 0 && val > S16_MAX / 2)
> +			reg_val = S16_MAX;
> +		else if ((val2 < 0 ? -val : val) < S16_MIN / 2)

It has been a while, but IIRC if val2 < 0 then val == 0 as otherwise
we carry the sign in the val part.  Sometimes we generalize that to
make life easier for driver writers but I think you can use that here
to simplify things.

(for background look at __iio_str_to_fixpoint() - it's a bit of a hack
to deal with integers have no negative 0)

		if (val > S16_MAX / 2)
			...
		else if (val < S16_MIN / 2)
			...	
		else if (val2 < 0) etc

You may feel it is better to keep the code considering the val2 < 0 when
val != 0 case and I don't mind that as it's not wrong, just overly complex!

If you can easily clamp the overall range you can just do some maths
with enough precision to get one number (probably a s64) and clamp that.
Easy to sanity check for overflow based on val to ensure no overflows.

		


> +			reg_val = S16_MIN;
> +		else if (val2 < 0)
> +			reg_val = clamp_t(int,
> +				-(val * 2 + -val2 * 2 / MICRO),
> +				S16_MIN, S16_MAX);
> +		else if (val < 0)
> +			reg_val = clamp_t(int,
> +				val * 2 - val2 * 2 / MICRO,
> +				S16_MIN, S16_MAX);
> +		else
> +			reg_val = clamp_t(int,
> +				val * 2 + val2 * 2 / MICRO,
> +				S16_MIN, S16_MAX);
> +		return reg_val;
> +	case 16:
> +		if (val2 >= 0 && val > S16_MAX)
> +			reg_val = S16_MAX;
> +		else if ((val2 < 0 ? -val : val) < S16_MIN)
> +			reg_val = S16_MIN;
> +		else if (val2 < 0)
> +			reg_val = clamp_t(int,
> +				-(val + -val2 / MICRO),
> +				S16_MIN, S16_MAX);
> +		else if (val < 0)
> +			reg_val = clamp_t(int,
> +				val - val2 / MICRO,
> +				S16_MIN, S16_MAX);
> +		else
> +			reg_val = clamp_t(int,
> +				val + val2 / MICRO,
> +				S16_MIN, S16_MAX);
> +		return reg_val;
> +	case 64:
> +		if (val2 >= 0 && val > S16_MAX * 2)
> +			reg_val = S16_MAX;
> +		else if ((val2 < 0 ? -val : val) < S16_MIN * 2)
> +			reg_val = S16_MIN;
> +		else if (val2 < 0)
> +			reg_val = clamp_t(int,
> +				-(val / 2 + -val2 / 2 / MICRO),
> +				S16_MIN, S16_MAX);
> +		else if (val < 0)
> +			reg_val = clamp_t(int,
> +				val / 2 - val2 / 2 / MICRO,
> +				S16_MIN, S16_MAX);
> +		else
> +			reg_val = clamp_t(int,
> +				val / 2 + val2 / 2 / MICRO,
> +				S16_MIN, S16_MAX);
> +		return reg_val;
> +	default:
> +		if (val2 >= 0 && val > S16_MAX / 4)
> +			reg_val = S16_MAX;
> +		else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
> +			reg_val = S16_MIN;
> +		else if (val2 < 0)
> +			reg_val = clamp_t(int,
> +				-(val * 4 + -val2 * 4 / MICRO),
> +				S16_MIN, S16_MAX);
> +		else if (val < 0)
> +			reg_val = clamp_t(int,
> +				val * 4 - val2 * 4 / MICRO,
> +				S16_MIN, S16_MAX);
> +		else
> +			reg_val = clamp_t(int,
> +				val * 4 + val2 * 4 / MICRO,
> +				S16_MIN, S16_MAX);
> +		return reg_val;
> +	}
> +}
> +

