Return-Path: <linux-iio+bounces-23793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1968B45FAF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329E2A08735
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11F0313261;
	Fri,  5 Sep 2025 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u02FQyfX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F930B52F
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092138; cv=none; b=AtF1uG0XGRCPOA9c6ivvwuH61cTagVA1KmDsvna2K7K9HP8lXS2jZ2iZK3Logs857ShX+fxqz+TLmNxNtXQePRxCwUvwcjn0/Ox6/mxtCHZadh7Vn5EkSD5wDFZoLsFmHfX9/lirqLEn8kGKMV2nC7vi4uWpWWtGx4TbX7qGWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092138; c=relaxed/simple;
	bh=Tkbn50qn/hhS/M6+NYFtTjOUIs5BN8FyqJf3T2PkPA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXvnMtY849MpTfMKaa2125AUKrLYQccUHsFOrQXgZg9DUYKKFxYshOga9iOvdwV44ix4hYX8kUU3nSXHc383vQVJMuPTqdhnmMP+ItLwbArXh+U9C+DRpstNcr89rC9k8OARqlO77g5FIusWvOwMMYKGt/nXY5m21yO/bjTMhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u02FQyfX; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61ff7638f4eso691545eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757092135; x=1757696935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=es5BenmFY8/wYi/7jlHuxSPUlpqWojpQjFWnnzqMqrI=;
        b=u02FQyfXpWypqPuYJQBppcCdtuq3aPY65QiOQFZXC9R/y6cOJ3WmJXx+V+g1XehFzr
         tgBjhrLYefqNKmf0TVX7HDPBoowFpc23OpMsITsKmNsyQwZGBhLBIygZf3BQUhwRte91
         yJbuAP3l3Nw3lFZUJi8B85AiHh9gkvkvKAbce+sebR7afeNLLC2k+Y6X9L130m4sW+pp
         cB1C+w4mU5I8E170AkZ5B4kkJpKsCv+4Uf9bxG4MQj7+ybsPee6QYSvHsiRlJeU8fh7s
         kkJ0ZE+uzeul/PBR413KlIu2EQDkgdhFrgM3ssIuqevxhgIVaRR6i7z6bCGge4680Ax/
         0k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092135; x=1757696935;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=es5BenmFY8/wYi/7jlHuxSPUlpqWojpQjFWnnzqMqrI=;
        b=WTLVQPExTSQKTJjX7c2KH1fxGmVyMQkvNgg211+G8CrzEJbEUSaaw53Fj55PWTBHTr
         sYP3zQg+0GcL0j72xCLmHP2paAtdoro37yoBrbcjJzXCKmfsnqp0l1+thfmY72R7GNSj
         VfzP8+qmxTEGL2dT+WmcAzBpglcX17UNh74KzK+9sETEIayHs/pPfBe30HaRkg9unsDx
         SLB908Gf/gNMToNXYlmRqN7Ie2jqD7oPL+/ZIOeMDIc1cmuH/fXVUHQYYdSOPRN1TFLP
         u1Ce0cGfe1eaFJABVJDT05n3esPs/cn9DjDlWTgAwqLgxvkj3SGvhJhEwHFSofsXuCMk
         5/EA==
X-Forwarded-Encrypted: i=1; AJvYcCWBYstvpRdVNRseeI6K8jAS1cu8ydNBdwHfu5fLr7gOslBXPSuCu3VOSTF2XlB6CdnyRu5dOdfCX3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8p862yrjADX4ZzOKUjz4vV8ujqmtbobmuYsZB7aeZFQWWULVr
	o+Wa1OAxLB+94LeQLWMN8YPewOt/SEmg0LNNJaIQiARLzc7n7UaXsAlW8LbfjzRFQ20=
X-Gm-Gg: ASbGnctYSEXuhlDOgEfixaBy4161XvZ/MdRzoQVGi/W0qgOAwnVtjIc38X2ktGdk2DC
	HfoyL0UmVaC3dJwcUFJpPqZRH/f4n2EhqLt0yIsjf0kNHJsmFEQyBlie2Bbvm1fy9dWVgcG2E6A
	2iHPlNcFt8cT3qmNpW9+r89jDwuDoMhFBrNY3lvfyWDXmNBAsgkJFGuk3aB0wM6OXhMhklqQSib
	5JCjYqKo0QUtDaZvWKd/qdPvsswSMN6WYFvND3LYq4+8bfnFhgp7SZrU6OodpDZ2VBuc78pJPgT
	dAVdCNLtQ/ctybhtjNi1T4vaJP6TgT6qQJ9RQlqKY+EPALNsDvIibX9VD7y+9oXm4ydNzi43I6X
	COoSyHVSdleLmxc3p5ECEgpl2+cc08mUsOqe3BSvnRTx2zGJ0yd4BUfzVlxA+ukrxEzx+wY2o
X-Google-Smtp-Source: AGHT+IH9e9QHKGKP9WAtZWwX8qx9tCZXNF7ybfkvHwaIe8Iwg6dM/XI66Ifyq30xrOvrMd8TWLRguA==
X-Received: by 2002:a05:6870:d915:b0:2bc:7811:5bb8 with SMTP id 586e51a60fabf-319630cb2d2mr10627124fac.18.1757092135573;
        Fri, 05 Sep 2025 10:08:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b5886e78sm3801891fac.4.2025.09.05.10.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:08:55 -0700 (PDT)
Message-ID: <598ec4ca-5b36-4ddf-877c-3617711c3aed@baylibre.com>
Date: Fri, 5 Sep 2025 12:08:54 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC
 Family
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
 <6228c10d731b6946a68e1c3c95643065cc81329a.1757001160.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <6228c10d731b6946a68e1c3c95643065cc81329a.1757001160.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 4:49 AM, Jonathan Santos wrote:
> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> provide a VCM regulator interface.
> 

...

> +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	const struct iio_scan_type *scan_type;
> +	int val, val2, tmp0, tmp1, i;
> +	struct u64_fract fract;
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
> +			fract.denominator *= 10000;
> +		}
> +
> +		rational_best_approximation(fract.numerator, fract.denominator,
> +					    INT_MAX, INT_MAX, &n, &d);
> +
> +		val = mult_frac(st->vref_uv, d, n);
> +		/* Would multiply by NANO here, but value is already in milli */
> +		tmp2 = shift_right((u64)val * MICRO, val2);

shift_right() is only needed for signed values. Can just use >> since this is
dealing with unsigned.

> +		tmp0 = div_u64_rem(tmp2, NANO, &tmp1);
> +		st->scale_tbl[i][0] = tmp0; /* Integer part */
> +		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
> +	}
> +}
> +

...

> +static int ad7768_set_pga_gain(struct ad7768_state *st,
> +			       int gain_mode)
> +{
> +	int pgia_pins_value = abs(gain_mode - st->chip->pgia_mode2pin_offset);
> +	int ret;
> +
> +	guard(mutex)(&st->pga_lock);
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_PGIA_EN);

Hiding multiple fields in a macro makes it harder to see what this is doing.

> +	if (ret)
> +		return ret;
> +
> +	/* Write the respective gain values to GPIOs 0, 1, 2 */
> +	ret = regmap_write(st->regmap, AD7768_REG_GPIO_WRITE,
> +			   AD7768_GPIO_WRITE(pgia_pins_value));

Hiding the FIELD_PREP() in a macro makes this a bit harder to understand.

> +	if (ret)
> +		return ret;
> +
> +	st->pga_gain_mode = gain_mode;
> +
> +	return 0;
> +}
> +
>  static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> @@ -778,6 +925,10 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  	AD7768_CHAN(0, 0),
>  };
>  
> +static const struct iio_chan_spec adaq776x_channels[] = {
> +	AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
> +};
> +
>  static int ad7768_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
> @@ -805,7 +956,19 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = (st->vref_uv * 2) / 1000;
> +		if (st->chip->has_pga) {
> +			guard(mutex)(&st->pga_lock);
> +
> +			*val = st->scale_tbl[st->pga_gain_mode][0];
> +			*val2 = st->scale_tbl[st->pga_gain_mode][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +
> +		temp = (st->vref_uv * 2) / 1000;
> +		if (st->chip->has_variable_aaf)
> +			temp = (temp * 10000) / ad7768_aaf_gains_bp[st->aaf_gain];

Should we add a BASIS_POINTS macro to units.h since we are calling this a
standard unit?

> +
> +		*val = temp;
>  		*val2 = scan_type->realbits;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;

...

> +static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
> +{
> +	bool aaf_gain_provided;
> +	u32 val;
> +	int ret;
> +
> +	st->aaf_gain = AD7768_AAF_IN1;

No sense in setting this if we return early on -EINVAL.

> +	ret = device_property_read_u32(dev, "adi,aaf-gain-bp", &val);
> +	aaf_gain_provided = (ret == 0);

Only -EINVAL means the property is not present. Other errors can be returned.
Or add a comment explaining why we don't care about other errors.

> +	if (!aaf_gain_provided && st->chip->has_variable_aaf) {
> +		dev_warn(dev, "AAF gain not specified, using default\n");

Using the default seems like a normal thing to do, so should not be a warning.

> +		return 0;
> +	}
> +
> +	if (aaf_gain_provided && !st->chip->has_variable_aaf) {
> +		dev_warn(dev, "AAF gain not supported for %s\n", st->chip->name);

Returning error here would be senseible. Clearly there is something wrong with
the devicetree. But it could be something else, like the wrong compaible string.

> +		return 0;
> +	}
> +
> +	if (aaf_gain_provided) {
> +		switch (val) {
> +		case 10000:
> +			st->aaf_gain = AD7768_AAF_IN1;
> +			break;
> +		case 3640:
> +			st->aaf_gain = AD7768_AAF_IN2;
> +			break;
> +		case 1430:
> +			st->aaf_gain = AD7768_AAF_IN3;
> +			break;
> +		default:
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid firmware provided AAF gain\n");
> +		}
> +	}
> +
> +	return 0;
> +}
> +

...

>  static int ad7768_probe(struct spi_device *spi)
> @@ -1399,7 +1669,13 @@ static int ad7768_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	/* Register VCM output regulator */
> -	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
> +	if (st->chip->has_vcm_regulator) {
> +		ret = ad7768_register_regulators(&spi->dev, st, indio_dev);

ad7768_register_regulators() now seems mis-named since it only handles VMC
supply.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ad7768_parse_aaf_gain(&spi->dev, st);
>  	if (ret)
>  		return ret;
>  

