Return-Path: <linux-iio+bounces-22959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66FB2B3C2
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 23:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DE3560679
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F05121A434;
	Mon, 18 Aug 2025 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he4z3Zza"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8B5BAF0;
	Mon, 18 Aug 2025 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553991; cv=none; b=X5lXcS9wFnVUfnLAcBqGIbqAszlm+ZThrgltz0ZfVYLw3ZMl3cJRB1p8zo110yajepCJXGFhjK0zDdLmkKG0itlwNe4txkHtL7HzGAFLuWFvDRVqMTnp1T3o9s7MbBaFWVObu9vgGtb/ukU1oi0z5riVGpkv2ltbiNiQkcUN9bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553991; c=relaxed/simple;
	bh=WpVkZ962vo3YxUb0pfsS3lL0+QvmmNGnTY+hjEa6j10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5djh3CxYUl3PlkxeygV86ZtwkIfEQ2dnJU6QzWG+j4sfdNnaHnMAiRHLy/EjbIWy0VLmsmCCTaR2W7tk04by0Qx2xYhaNVNJEN8E5NXJOAd90UVH19kt+PrNTf0Ft4PXaxmy8dTUzQ6ENyU/aEklvDhtiCut3I2TbzvvGw9zyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he4z3Zza; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1fc6996aso3623405e9.0;
        Mon, 18 Aug 2025 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755553988; x=1756158788; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBGNms563wZgaaDJj4dOhSYcsPJCfcviioGsJ6pZrx4=;
        b=he4z3Zzai/IVvuped3KttgU7WY256F9iSXXj6g8bTTgIMI2QnJCJiJ1m8bk87rFnqM
         PqsEgTSVEhuXWSA6vWClodGHI73v25RJWj2kbavGnSpztNDH8escZpBbwTO0w2oABL5O
         2d4LqEZZpNlXW88cp6K8RT9/8egqq9dCHK4DKrp0r4isO1zwbSRip7PEnA9aUinvhwoV
         84kYc0FBW9JwUoBtniinfG1dNS6jAsNZBZoev3ZRgcEG/nRCIj64/oGNNIL4wWyC0uO6
         8VN6EXGnfOvW5kcTaBBORN0O0w/Mi2ia0HCRrrf258J2NhfNVrxFAd3TX86L0CQwHoz0
         mlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755553988; x=1756158788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBGNms563wZgaaDJj4dOhSYcsPJCfcviioGsJ6pZrx4=;
        b=BZDrIZbf0MclK/zJaY/HXu+4yKBHjWC/uNW240yiyq3MA/q5Qxo+wdhOcQuC1OieAl
         NpVnpddP7cA+gSQMPsCnmUtW53yHthykD/5WkJW8XeSPUcsBJrTqyVz02TtaXodIRr9C
         NJe+Ej9/3UgvZVN56DXfZxRj90NPhirClZXR62n9YIJsxBeOW+fr5aPc2MLNTFelmaJW
         CdAQAJOUpF4MRQm5TXxFSQK44PchvB+PmpWvzNr86G7U8jXRcCsfWVOe//CcxU7wGdQh
         KWD/Lx8yqaqqiZj+FSXftaMUzy87eyCh3jXuVBjAdbZMRlT3LdRHkoGTuhGy0yTphHG3
         3jKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbRytSd5vG527JWbddTpomoTOrk7BpDJVNKzqSp0FDD1t6rhOheOV4NiyTgMB4mT1UdUGStJUWIZJ3@vger.kernel.org, AJvYcCWjxK2eBjhM6GbjIXytZ1e+8jm9Mwlh6IsTMUHglVgUfI5jh2vFJuAxPbmYwRtwnTU7qOiKzaNAc4bz@vger.kernel.org, AJvYcCX+rQe5IuqVr/ODsbd/zyDgK33KrXZ6/ZPfeFhKGey2A7al/5oC/FCT3ARKTBYHxzxRil8UAxoErW03rvNl@vger.kernel.org
X-Gm-Message-State: AOJu0YyyH+uzXhIZTrfaSYA5eKjQbyYxZjw9xOEJEjMuiT+h9Eg//Dpo
	crxlBsEzcNCmAkE2yVwGMr3rSeH+2w5q/jz2DcobY0ldhI4G5/LB3Q7g
X-Gm-Gg: ASbGncuYuK3rHDgNLys3XdVF76c+adtFaVjWxWoHfd0FK9U2aRsNTu9SpQw6koAQ9Af
	m5iv3Xh8tFKhnvGvzoYK1QBCtm5NmhnGzpydIzVTVJCjZdnXFUhH+HxplEUga2oti8n7/C7btc6
	UR8B8+RF9XzyTT2MLmCYF1kZnR1GCoOfrJRfaeWFIwCvOkKpBWbkOoZNC2GcpkdxshO5t+0Z1vr
	FPT5VDgWr3wmyDP9D3fLgVo2O2CpRbzuvIXOB/xvp5zsAU3Sza1Wee77MqBxhUeThB8Gm4MlGLa
	pn6gtwzR4SplTSPvZgcZJisGhosp44VU3uDwiX7tsgN0XYZdt1g2jvr3gHSYURfb37O5sJu9Iul
	nEN+eWo9rgAuRxJThp78eeA93PanAkwsudEUVmpvk
X-Google-Smtp-Source: AGHT+IEkYKcv7TAT9SSyXMO7PdTbTBzp1hSjXgNAUXQnGzWIfIepF1ZKLGT9IaaBsZ0kjI58lMjitg==
X-Received: by 2002:a05:600c:6596:b0:459:dd09:856c with SMTP id 5b1f17b1804b1-45b43e12c3cmr397585e9.6.1755553987523;
        Mon, 18 Aug 2025 14:53:07 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.79.20.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c166bsm988404f8f.33.2025.08.18.14.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 14:53:07 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:53:01 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC
 Family
Message-ID: <aKOgvSHgiYQsuADy@JSANTO12-L01.ad.analog.com>
Reply-To: f7aeff222bf0f09dc32784640c81a870c9145320.camel@gmail.com
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
 <f7aeff222bf0f09dc32784640c81a870c9145320.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7aeff222bf0f09dc32784640c81a870c9145320.camel@gmail.com>

On 08/14, Nuno Sá wrote:
> On Tue, 2025-08-12 at 23:49 -0300, Jonathan Santos wrote:
> > Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> > Anti-aliasing filter (AAF) gains.
> > 
> > The PGA gain is configured in run-time through the scale attribute,
> > if supported by the device. The scale options are updated according
> > to the output data width.
> > 
> > The AAF gain is configured in the devicetree and it should correspond to
> > the AAF channel selected in hardware.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> 
> Hi Jonathan,
> 
> Some comments from me...
> 

...

> > +static int ad7768_set_pga_gain(struct ad7768_state *st,
> > +			       int gain_mode)
> > +{
> > +	int pgia_pins_value = abs(gain_mode - st->chip->pgia_mode2pin_offset);
> > +	int check_val;
> > +	int ret;
> > +
> > +	/* Check GPIO control register */
> > +	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &check_val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if ((check_val & AD7768_GPIO_PGIA_EN) != AD7768_GPIO_PGIA_EN) {
> > +		/* Enable PGIA GPIOs and set them as output */
> > +		ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
> > AD7768_GPIO_PGIA_EN);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	/* Write the respective gain values to GPIOs 0, 1, 2 */
> > +	ret = regmap_write(st->regmap, AD7768_REG_GPIO_WRITE,
> > +			   AD7768_GPIO_WRITE(pgia_pins_value));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	st->pga_gain_mode = gain_mode;
> > +
> 
> It looks the above function could use some locking.
> 
> > +	return 0;
> > +}
> > +
> >  static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int
> > offset)
> >  {
> >  	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> > @@ -782,13 +937,17 @@ static const struct iio_chan_spec ad7768_channels[] = {
> >  	AD7768_CHAN(0, AD7768_CHAN_INFO_NONE),
> >  };
> >  
> > +static const struct iio_chan_spec adaq776x_channels[] = {
> > +	AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
> > +};
> > +
> >  static int ad7768_read_raw(struct iio_dev *indio_dev,
> >  			   struct iio_chan_spec const *chan,
> >  			   int *val, int *val2, long info)
> >  {
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> >  	const struct iio_scan_type *scan_type;
> > -	int scale_uv, ret, temp;
> > +	int ret, temp;
> >  
> >  	scan_type = iio_get_current_scan_type(indio_dev, chan);
> >  	if (IS_ERR(scan_type))
> > @@ -809,12 +968,19 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
> >  		return IIO_VAL_INT;
> >  
> >  	case IIO_CHAN_INFO_SCALE:
> > -		scale_uv = st->vref_uv;
> > -		if (scale_uv < 0)
> > -			return scale_uv;
> > -
> > -		*val = (scale_uv * 2) / 1000;
> > -		*val2 = scan_type->realbits;
> > +		if (st->chip->has_pga) {
> > +			*val = st->scale_tbl[st->pga_gain_mode][0];
> > +			*val2 = st->scale_tbl[st->pga_gain_mode][1];
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		}
> > +		*val = st->vref_uv / 1000;
> > +		if (st->chip->has_variable_aaf)
> > +			*val = (*val * MILLI) / ad7768_aaf_gains[st->aaf_gain];
> > +		/*
> > +		 * ADC output code is two's complement so only (realbits - 1)
> > +		 * bits express voltage magnitude.
> > +		 */
> > +		*val2 = scan_type->realbits - 1;
> >  
> 
> I'm a bit confused. Is there something wrong with the original code that needs to be
> fixed? The above change seems to effectively change behavior of the code with had
> before.
> 
> - Nuno Sá

I think it is more of a semantic clarification than a behavioral change
per se. Previously, the calculation gave the impression of a bipolar 
unsigned input, since it was using the full scale. With the update, 
we’re explicitly considering the sign bit, which makes it clear 
that the input is a two’s complement signal.

Altough pehaps this should not be mixed into the patch.

> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  
> > @@ -869,18 +1035,42 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
> >  		*length = st->samp_freq_avail_len;
> >  		*type = IIO_VAL_INT;
> >  		return IIO_AVAIL_LIST;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*vals = (int *)st->scale_tbl;
> > +		*length = st->chip->num_pga_modes * 2;
> > +		*type = IIO_VAL_INT_PLUS_NANO;
> > +		return IIO_AVAIL_LIST;
> >  	default:
> >  		return -EINVAL;
> >  	}
> >  }
...

- Jonathan Santos

