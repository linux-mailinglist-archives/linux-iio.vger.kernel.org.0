Return-Path: <linux-iio+bounces-27871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A33AD384EB
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A0E43010062
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71A346FAB;
	Fri, 16 Jan 2026 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwIgAusP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84F20FAAB;
	Fri, 16 Jan 2026 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589530; cv=none; b=MpfvekQeb2WKwaqmYwfMm+G/lT6dawVfhywWmtft/1Gpg9IJ2UriX7pJvRGNlh2k+A0lGwp4JUSVQpK67YmHk6o6NDxwa0+GWRaRWE9X04eTpos6tKsFDk8dUsj+DdV9KLvUZRPVaseMZLhBsUNatDlfyNp8V4RtWG5n/Svy7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589530; c=relaxed/simple;
	bh=m3kk3G9xMvoqo9xqwzrLann2emi+iejy+8GVP567rnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozWEr1t6U97VVQcUpAyl9NYaOcR2s01OoXuu4HfqP/fYA3y0OkGJ1E5dR7CoM2oaI6uRauAzHYSmp4HCk6F0fcxki27ZV4MvSL7bIl7X1HkwwfZKaK8NPKDt2s2/r/kY66OYF/idUEFRI0ztnrVkPXmzw3VM5Wm2uv3uYP2704o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwIgAusP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9DCC116C6;
	Fri, 16 Jan 2026 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768589530;
	bh=m3kk3G9xMvoqo9xqwzrLann2emi+iejy+8GVP567rnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FwIgAusPeLzsioqF2yoG7uFYuTszuBhE19AC+Rw4/x6cGbWFYWpT6nzje4R4PoHZk
	 sUOi26m8CgbYs9Oi3uolyikLcPBMh/2xNovS94pOOmNP7BktnTn4W+216BF5HV7WQN
	 no+z/kxFaoSESvUs1VG4w3YzOZRk9CkGJGuX7zSvLsFb6QMQ0yYicB3hh21GytR22a
	 36pPcPPJO2zj48fuk5PVlTr3xKSgNH1fKTz03E9SwoVenhRCCaR3jtM8+y2kqZex5P
	 bZpdYt5ckbo37oEjXyqfqexStAKoAp9M2Hls9l6GbeOs5YHIm0e6hInpwLa/Rrl+DH
	 gcnj7g7YcXeng==
Date: Fri, 16 Jan 2026 18:52:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v6 5/5] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <20260116185200.38be8bc7@jic23-huawei>
In-Reply-To: <fd9acf8fca67679a33441ea18d1d06b2aa2c5fad.1768350772.git.Jonathan.Santos@analog.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
	<fd9acf8fca67679a33441ea18d1d06b2aa2c5fad.1768350772.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 06:27:29 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> provide a VCM regulator interface.
> 
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. PGA is controlled by GPIOs provided in
> the device tree.
> 
> The AAF gain is defined by hardware connections and should be specified
> in the device tree.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Hi Jonathan,

See inline.  One small thing I am fine fixing up whilst applying
if nothing else comes up.

thanks,

Jonathan



> ---

> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index bd4b2e090c5b..980c079ab41a 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	const struct iio_scan_type *scan_type;
> +	int val, val2, tmp0, tmp1, i;
> +	struct u32_fract fract;
> +	unsigned long n, d;
> +	u64 tmp2;
> +
> +	scan_type = iio_get_current_scan_type(dev, &dev->channels[0]);
> +	if (scan_type->sign == 's')
> +		val2 = scan_type->realbits - 1;
> +	else
> +		val2 = scan_type->realbits;
> +
> +	for (i = 0; i < st->chip->num_pga_modes; i++) {
> +		/* Convert gain to a fraction format */
> +		fract.numerator = st->chip->pga_gains[i];
> +		fract.denominator = MILLI;
> +		if (st->chip->has_variable_aaf) {
> +			fract.numerator *= ad7768_aaf_gains_bp[st->aaf_gain];
> +			fract.denominator *= PERMYRIAD;
> +		}
> +
> +		rational_best_approximation(fract.numerator, fract.denominator,
> +					    INT_MAX, INT_MAX, &n, &d);
> +
> +		val = mult_frac(st->vref_uv, d, n);
> +		/* Would multiply by NANO here, but value is already in milli */
> +		tmp2 = ((u64)val * MICRO) >> val2;
> +		tmp0 = div_u64_rem(tmp2, NANO, &tmp1);
> +		st->scale_tbl[i][0] = tmp0; /* Integer part */
> +		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */

How does remainder from div_u64_rem() end up other than positive?
That divides a u64 by a u32 and takes a u32 * for that final parameter.
Changing the type of tmp1 to u32 should do the job. Given we do the divisor
is big enough, this can't be something subtle with the top bit set
(if it were it would need a comment!)

If nothing else comes up I can do that whilst applying
(I'll wait on Andy having a chance to sanity check the PERMYRIAD stuff anyway).

> +	}
> +}
> +

