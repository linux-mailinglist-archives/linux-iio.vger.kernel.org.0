Return-Path: <linux-iio+bounces-19117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78507AA985C
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFDE189E926
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66330266EE6;
	Mon,  5 May 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3Sh146R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9F15C15F;
	Mon,  5 May 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461400; cv=none; b=Pc3WhOLVDbBlOys68UvQkYjowTsWpegE3chZfFH/KQhkPO6wtCPrxuDufktxDD3JSGySc9iJcGSwtZ/QtvD5QX7kpI0FEyszO1vAFkGm5IrVbiLVu4Pj0p/wCYv5fk/viz8BiCvewJiLcXSkOWtNzHvCB3EQ1k3I4n8nGxqlZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461400; c=relaxed/simple;
	bh=K7pvnUNgm6DOpU+mu+K0mW5Kn0q/QRO+Sw/uMu12T7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJMArP3/mySh9sjiDSD12fwhs8X3JjSqOhBg5Zqpzsnie8LKGcYdNJxllB0ttQWLIcuwdqAq4SZe9UPSsa6c7+heWKRMYWZ9/5wIbMZFJYZReEqu2/h3D8Ixd0NLXm5MafMYuyp/tuCmgm/LQSQB+KmZEVUZlotm6PApNHIAB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3Sh146R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9397BC4CEE4;
	Mon,  5 May 2025 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746461399;
	bh=K7pvnUNgm6DOpU+mu+K0mW5Kn0q/QRO+Sw/uMu12T7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R3Sh146RsRf0sycpd0cQf8qCnrvGfuQSYUpdpS6X5S1kIrLmHqTH4WmW8+J/jlaf4
	 DXb7HUaIUNCEQj3SNFpeL8qh2bzfMjq3OPX7raBT2pO1WqQ011vOiB8uIuBr3AV264
	 Y4Tf3fzjaMxulAo4nUgID8dRED5JZO1x0lDpeISp6RlWcfQ5nOCNa9iCzQxTGVLQH5
	 bpbgUwCb5kLnVZ3BAOc6ju+VyQuiGCmQIkHflSu7fjWNGKMkuOC2ddy965OmewedSz
	 4NLmnHx43/UuUqsbV+iGvhNQQqiEfkly6+O0rnxR2e2iZabV1DGt0cnRQ0FpWGBBiX
	 Xu9XGxpKdllvw==
Date: Mon, 5 May 2025 17:09:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <andy@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>, "Pop
 Paul" <paul.pop@analog.com>
Subject: Re: [PATCH v6 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <20250505170950.1d7941d0@jic23-huawei>
In-Reply-To: <4493dc2e3e0fb61ba3e8a0e54571998aaaaf46c8.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
	<4493dc2e3e0fb61ba3e8a0e54571998aaaaf46c8.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Apr 2025 21:14:17 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables sinc3, sinc3+rej60
> and wideband filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features. Sampling frequency
> table is updated after every digital filter parameter change.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Pop Paul <paul.pop@analog.com>
> Signed-off-by: Pop Paul <paul.pop@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
A few trivial additions from me.

> ---
> v6 Changes:
> * Made sinc3 decimation rate calculation clearer as requested.
> * Renamed some filter functions to clarify the purpose.
> * Other nits.
> 
> v5 Changes:
> * Addressed some nits.
> * Use the new new iio_device_claim/release_direct() functions.
> 
> v4 Changes:
> * Sampling frequency table is dynamically updated after every
>   filter configuration.
> 
> v3 Changes:
> * removed unused variables.
> * included sinc3+rej60 filter type.
> * oversampling_ratio moved to info_mask_shared_by_type.
> * reordered functions to avoid forward declaration.
> * simplified regmap writes.
> * Removed locking.
> * replaced some helper functions for direct regmap_update_bits
>   calls.
> * Addressed other nits.
> 
> v2 Changes:
> * Decimation_rate attribute replaced for oversampling_ratio.
> ---
>  drivers/iio/adc/ad7768-1.c | 363 ++++++++++++++++++++++++++++++-------
>  1 file changed, 293 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 10791a85d2c5..e2b8f12260a5 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -20,6 +20,8 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +#include <linux/util_macros.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> @@ -77,7 +79,7 @@
>  #define AD7768_PWR_PWRMODE(x)		FIELD_PREP(AD7768_PWR_PWRMODE_MSK, x)
>  
>  /* AD7768_REG_DIGITAL_FILTER */
> -#define AD7768_DIG_FIL_FIL_MSK		GENMASK(6, 4)
> +#define AD7768_DIG_FIL_FIL_MSK		GENMASK(7, 4)

Bug?  If so does this belong in a precursor patch?

>  #define AD7768_DIG_FIL_FIL(x)		FIELD_PREP(AD7768_DIG_FIL_FIL_MSK, x)

> @@ -404,22 +473,110 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int ad7768_set_dig_fil(struct ad7768_state *st,
> -			      enum ad7768_dec_rate dec_rate)
> +static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
> +				     unsigned int dec_rate)
>  {
> -	unsigned int mode;
> +	unsigned int max_dec_rate;
> +	u8 dec_rate_reg[2];
> +	u16 regval;
>  	int ret;
>  
> -	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
> -		mode = AD7768_DIG_FIL_FIL(dec_rate);
> -	else
> -		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
> +	/*
> +	 * Maximum dec_rate is limited by the MCLK_DIV value

Oddly short wrap. Go nearer 80 chars.

> +	 * and by the ODR. The edge case is for MCLK_DIV = 2
> +	 * ODR = 50 SPS.
> +	 * max_dec_rate <= MCLK / (2 * 50)
> +	 */

> +static int ad7768_get_filter_type_attr(struct iio_dev *dev,
> +				       const struct iio_chan_spec *chan)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	int ret;
> +	unsigned int mode;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> +	if (ret)
> +		return ret;
> +
> +	mode = FIELD_GET(AD7768_DIG_FIL_FIL_MSK, mode);
> +
> +	/* From the register value, get the corresponding filter type */
> +	return ad7768_filter_regval_to_type[mode];
	return ad7768_filter_regval_to_type[FIELD_GET(AD7768_DIG_FIL_FIL_MSK, mode)];

Is fine (only just over 80 chars and I'm getting more relaxed as time moves forwards).

Also avoids the dual meaning of mode which I never like to see.

>  }

>  
> -static int ad7768_write_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int val, int val2, long info)
> +static int __ad7768_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return ad7768_set_freq(st, val);

Whilst I doubt anyone will notice this looks like a functional change
that should be called out in the patch description.
Previously we allowed frequency changes in buffered mode, now we don't.

> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = ad7768_configure_dig_fil(indio_dev, st->filter_type, val);
> +		if (ret)
> +			return ret;
> +
> +		/* Update sampling frequency */
> +		return ad7768_set_freq(st, st->samp_freq);
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static int ad7768_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = __ad7768_write_raw(indio_dev, chan, val, val2, info);
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}
;


