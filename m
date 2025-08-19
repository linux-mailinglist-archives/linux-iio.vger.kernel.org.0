Return-Path: <linux-iio+bounces-23015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9AAB2CCCD
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 21:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A40B1BC6DD3
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968D2D2480;
	Tue, 19 Aug 2025 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2DvkIXI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62B267B92;
	Tue, 19 Aug 2025 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630846; cv=none; b=UShRKBg1wmVEq3afUME8RZ3YibKQ7PUY/gEhRGRHJkuNGzGicNQJ5rNBSknfszfuZDzRznieGBAKKvYftrxRDCq46Mf40WHK9OOZba0ZpLh7qiesrfzhkAKuqIAP6/GGkUwC2jFh5607GCwMONu8yMlAK5YpDTJxogqiLYCIfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630846; c=relaxed/simple;
	bh=QBZBFA8qX0CEUGaG7Ekodl0NUlye9JPmtd+b5ybqcNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLuDxsKLOg99bKPI4HqBmepF6fHeIysi9cQ8GaBjfjFjvoK/RzSfat9eX31FnwnRYsJyDGavcYjvvY3Bkgn3bzez2lMvy14RMkeJ+skN/bZzLLq1DUR3Cd5nXI/3BnddUN/mk4Rp6UOPJUSX+h+zb4iffNtVwSwsd0uNmht4hfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2DvkIXI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2046594b3a.1;
        Tue, 19 Aug 2025 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755630844; x=1756235644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSoFs1dPwZPLyXDgW16htuCQo6gneHJl/XJEcVM4CC0=;
        b=V2DvkIXIIBQP0mX+tkigIdZFJZ226e9ilS7tOPv26dzBEY+WH4GlQ19bXy/qfvgdLT
         MFZe2SoQtJPgcjICHIKfwe3tbF+Bq55+cGVym4WQB5uKZHBir0JtJvT1dCUE+o/RJDwi
         oHIDB+JtZDvj5j6PMlUm/DuYwzL1VJZljX4PqDWp7hFmiWUG5xJ9N/DR+KYVHn8i9b/b
         g6zkZkmULe/is8JFAXulYtYeQf8wCQCQ9ixQvukDWcYzggJK9WuPzTlf1KKfYE7WL/0w
         GQzhneGhkHNhqn5RjL/l4tCkMKM54spf9WecTLGIFQH42Dp4ZFRaY3Lp6DFT4aClJ+jU
         /iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630844; x=1756235644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSoFs1dPwZPLyXDgW16htuCQo6gneHJl/XJEcVM4CC0=;
        b=Yl1GOCWuxKgVbxll4gFc2AWgGm1Mjc59qt/hJuMPNalDzV7snyhQXUXGHAHFYUh5te
         HmZ35KeOUWSnt74S50fAAZljvWnBJP8I/qsTZdi00YoKoaY/183OKSEaMUTZlAywv/7e
         FYQ7C3siWsJ3kZWZuVvHwRY0uzGqe4yla5onvVqhWxeCIeSc8gpsYL1yelMa6eFjqhRx
         Vyk18vp96qTPMmhTr0aWwaX1OumWm7P72fbNPy66A2egpPRRSNaks+hFnWnVlau4njUm
         aEakg8pYd1oqizY+rCdNUP+l3cjHQLkAoH4/GHda0Tvey/Eo0HkSEi1XPT+fnrUpEdQ+
         PQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcQJyLWHnltc6vASxgbevUpK49/RPJBwq8j2PrQ67ItkQdM93TuMNXp4Nle2mbd5pXjVFBN08heAM9@vger.kernel.org, AJvYcCXQx+dUNEcCYF2KTTmo8M87ZsNkpKNnyd9cpvVc2MzJi9CL5mMSqTr+B4ZI+8ZsPBsoKAb/48ziqk9jnduW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqw2Wwj98sT6P+q1rv0a9GyRHOfCoXBmRedwUwHUIAJjAWLGNu
	kaSo1vHzLWePZc46JzJNNtg4CWuVD/YE7JFfijwRRwJfb9Ac1eASmNO7
X-Gm-Gg: ASbGncuN8fWpoMUntYjZPe5TDsk9+hmdpVJtyTFVI+zjEfx7QxOMD3l+tGGlETyETWU
	FdAPCPip0U/kh4Bp1+HcVcUFXm+Lh/dzT+kFOfpsmgCIc72Z5SjfpNfz9EUyAMdZPmmtiX/x5lH
	2XyVRvzSmE0+kuGwKJ3Ut/R1TWIhqJXe7HVv9KFf0SRvM7yxc7qg5mRus+CAxRSNUEkAbD2uRCE
	YS3KEka7YzI9q/F8FKPMfRoKmtPDe6drU1WP/jP0eQTw8qu2SK5znsfCkldopnVU3mOinLIgf0O
	+uYeb8BqPiE01MSATTI70d565k+LQ1sGDvvbcvc9zDMPXzQxCVc2C1nav/jLD8oFuaNbIBGWgOF
	2x2lafczvp2Tk6QupAfVDBCba33Vj4mMkHJBW0xqorw==
X-Google-Smtp-Source: AGHT+IEfPjCc/ljnWC4zpCiipCHTl8WeltuyKwOT/Jqk648q/rc8KulyEUXYKf/xSJhnTCuf1lFDmA==
X-Received: by 2002:a05:6a00:190e:b0:76b:d363:4a3f with SMTP id d2e1a72fcca58-76e8db9bedamr369223b3a.3.1755630844184;
        Tue, 19 Aug 2025 12:14:04 -0700 (PDT)
Received: from localhost ([2804:30c:2767:3c00:70b9:40f2:fa7f:19cd])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e7d5246e2sm3223800b3a.82.2025.08.19.12.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:14:03 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:14:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jonath4nns@gmail.com
Subject: Re: [PATCH 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC
 Family
Message-ID: <aKTNEP7pNY9ZbrPe@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>

Hi Jonathan,

A few thoughts from me.

On 08/12, Jonathan Santos wrote:
> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains.
> 
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. The scale options are updated according
> to the output data width.
This could provide more information/context. How the PGA is controlled/configured?

> 
> The AAF gain is configured in the devicetree and it should correspond to
> the AAF channel selected in hardware.
Would this be more clear if stated the other way around? 

The AAF gain is defined by hardware connections and thus is specified in device tree. ?

> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 286 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 279 insertions(+), 7 deletions(-)
> 
...
>  
> +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	const struct iio_scan_type *scan_type;
> +	int val, val2, tmp0, tmp1, i;
> +	unsigned long denominator, numerator;
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
> +		numerator = st->chip->pga_gains[i];
> +		denominator = MILLI;
> +		if (st->chip->has_variable_aaf) {
> +			numerator *= ad7768_aaf_gains[st->aaf_gain];
> +			denominator *= MILLI;
> +		}
> +
> +		rational_best_approximation(numerator, denominator, __INT_MAX__, __INT_MAX__,
> +					    &numerator, &denominator);
> +
> +		val = st->vref_uv / 1000;
What about keeping the reference in µV (not dividing by MILLI)?

> +		/* Multiply by MILLI here to avoid losing precision */
> +		val = mult_frac(val, denominator * MILLI, numerator);
then this can be just 
		val = mult_frac(val, denominator, numerator);

> +		/* Would multiply by NANO here but we already multiplied by MILLI */
> +		tmp2 = shift_right((u64)val * MICRO, val2);
> +		tmp0 = (int)div_s64_rem(tmp2, NANO, &tmp1);
val is never negative here so can use div_u64_rem() or maybe do_div().

> +		st->scale_tbl[i][0] = tmp0; /* Integer part */
> +		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
> +	}
> +}
> +
...
>  
> +static int ad7768_calc_pga_gain(struct ad7768_state *st, int gain_int,
> +				int gain_fract, int precision)
> +{
> +	u64 gain_nano, tmp;
> +	int gain_idx;
> +
> +	precision--;
This is odd out of context.
Also, it only applies to ADCs that provide output codes in two's complement
format. See comment below.


> +	gain_nano = gain_int * NANO + gain_fract;
> +	if (gain_nano < 0 || gain_nano > ADAQ776X_GAIN_MAX_NANO)
I've seen some build tools complain about comparisons like gain_nano < 0 with
gain_nano being u64. Since that's unsigned, it can never be < 0. And in the
context of gain/attenuation, we know gain_nano shall never be negative.
Would just drop the gain_nano < 0 comparison. Or maybe clamp() the value?

> +		return -EINVAL;
> +
> +	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
> +	gain_nano = DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);
> +	if (st->chip->has_variable_aaf)
> +		/* remove the AAF gain from the overall gain */
> +		gain_nano = DIV_ROUND_CLOSEST_ULL(gain_nano *  MILLI,
> +						  ad7768_aaf_gains[st->aaf_gain]);
> +	tmp = st->chip->num_pga_modes;
> +	gain_idx = find_closest(gain_nano, st->chip->pga_gains, tmp);
> +
> +	return gain_idx;
> +}
> +
...
> +
> +	/* Write the respective gain values to GPIOs 0, 1, 2 */
> +	ret = regmap_write(st->regmap, AD7768_REG_GPIO_WRITE,
> +			   AD7768_GPIO_WRITE(pgia_pins_value));
> +	if (ret < 0)
I think regmap_write() doesn't return positive values so we can have 'if (ret)' here.

> +		return ret;
> +
> +	st->pga_gain_mode = gain_mode;
> +
> +	return 0;
> +}
> +
...
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = st->vref_uv;
> -		if (scale_uv < 0)
> -			return scale_uv;
> -
> -		*val = (scale_uv * 2) / 1000;
> -		*val2 = scan_type->realbits;
> +		if (st->chip->has_pga) {
> +			*val = st->scale_tbl[st->pga_gain_mode][0];
> +			*val2 = st->scale_tbl[st->pga_gain_mode][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +		*val = st->vref_uv / 1000;
> +		if (st->chip->has_variable_aaf)
> +			*val = (*val * MILLI) / ad7768_aaf_gains[st->aaf_gain];
Similar thing here. Would it make sense to use st->vref_uv without dividing it
by MILLI?

> +		/*
> +		 * ADC output code is two's complement so only (realbits - 1)
> +		 * bits express voltage magnitude.
> +		 */
> +		*val2 = scan_type->realbits - 1;
I see the rationally for this. Instead of doing 'scale_uv * 2' to account for
the range of negative values, this is now using one less precision bit which
shall lead to the same result after going through IIO_VAL_FRACTIONAL_LOG2
handling. I personally prefer the realbits - 1 logic, but others may prefer
to avoid this change since it was already working with 'scale_uv * 2'.

>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> @@ -869,18 +1035,42 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
>  		*length = st->samp_freq_avail_len;
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_tbl;
> +		*length = st->chip->num_pga_modes * 2;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
...
> @@ -892,6 +1082,13 @@ static int __ad7768_write_raw(struct iio_dev *indio_dev,
>  
>  		/* Update sampling frequency */
>  		return ad7768_set_freq(st, st->samp_freq);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!st->chip->has_pga)
> +			return -EOPNOTSUPP;
> +
> +		gain_mode = ad7768_calc_pga_gain(st, val, val2,
> +						 scan_type->realbits);
Check scan_type.sign and pass scan_type->realbits - 1 to ad7768_calc_pga_gain()
if the ADC output codes are in two's complement format.

> +		return ad7768_set_pga_gain(st, gain_mode);
>  	default:
>  		return -EINVAL;
>  	}
...
> +static const struct ad7768_chip_info adaq7767_chip_info = {
> +	.name = "adaq7767-1",
> +	.channel_spec = ad7768_channels,
> +	.num_channels = ARRAY_SIZE(ad7768_channels),
> +	.available_masks = ad7768_channel_masks,
> +	.has_pga = false,
I think these flag initialization can be omitted when they are false.

> +	.has_variable_aaf = true
> +};
> +
> +static const struct ad7768_chip_info adaq7768_chip_info = {
> +	.name = "adaq7768-1",
> +	.channel_spec = adaq776x_channels,
> +	.num_channels = ARRAY_SIZE(adaq776x_channels),
> +	.available_masks = ad7768_channel_masks,
> +	.pga_gains = adaq7768_gains,
> +	.default_pga_mode = AD7768_PGA_GAIN_2,
> +	.num_pga_modes = ARRAY_SIZE(adaq7768_gains),
> +	.pgia_mode2pin_offset = 6,
> +	.has_pga = true,
> +	.has_variable_aaf = false
Same here.

> +};
> +
...
> @@ -1418,6 +1652,35 @@ static int ad7768_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	st->aaf_gain = AD7768_AAF_IN1;
> +	ret = device_property_read_u32(&spi->dev, "adi,aaf-gain", &val);
> +	if (ret) {
> +		/* AAF gain required, but not specified */
> +		if (st->chip->has_variable_aaf)
> +			return dev_err_probe(&spi->dev, -EINVAL, "AAF gain not specified\n");
> +
> +	} else if (!st->chip->has_variable_aaf) {
> +		/* AAF gain provided, but not supported */
> +		return dev_err_probe(&spi->dev, -EINVAL, "AAF gain not supported for %s\n",
> +				     st->chip->name);
Not really sure what to do in these cases. Can't we just ignore or warn on
properties for unsupported features?


Best regards,
Marcelo

