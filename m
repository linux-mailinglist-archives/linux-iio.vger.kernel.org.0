Return-Path: <linux-iio+bounces-8763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801495DDB4
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CD41F22307
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31399161310;
	Sat, 24 Aug 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB72uCTt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424991CD31;
	Sat, 24 Aug 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724500949; cv=none; b=OoltnIXiOplQeapWUTCLpvPWV+5N0KROSCSHyHyxOyQ4CJim8hjM/nO12aSwKwaQri+Rn7kJKSPcmIVPx6x4NGtsm3FNM0UTr2/McQs30aw35GxRbp5n2QKZ2mjdGf6WtIohOTFesxeinh7niyWDfKSJctSG+bOeZ1p7oLMm+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724500949; c=relaxed/simple;
	bh=HsOzfSOy3aKGBAfkhX1w1VTlDG8BUJdBoxUAafhwagE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuKvaRjc3DPS1KWVyUfAzG+NmRGi0PcHlpJp9Hh0mUf/dPviTnr+jZft4esQ/2yLLL3iveSYGG0yNlQVQi+DDofoBWTnmt21Zx/UGSLpgzYBIWOOFknZqcZ2D49/MzASmd6NazA4f3O3/Mcfv5KUOjCTpb0Zt1Ta1b6FLQGNLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB72uCTt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso29823235e9.3;
        Sat, 24 Aug 2024 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724500945; x=1725105745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2ItJXwls8LLC6xWQ1PTr24F5BP1jKP9kLXBVlYcNIE=;
        b=AB72uCTtvj7wIFxwvCSZiB3r2nDiNZ/RBrxv2v4cIFPJIBuBk9PlWYJ31hBYK5sp+7
         xc9yZLbF6k9SiOb1C1Un10MKG/MSeO+MjJvzUypFnunHkCXyy6vedUBeS+U+wwljupby
         1oHG6z6rEB6OxYE0yMKquYaOpjLi2XOynvY3bDWGnNBsB0L2Ijk2yTvi/qKE5ymWBPdD
         ZUR2Y1BRM/4CqXddMAkpID0z/faV5Tobm445iS69eUYd8zIuw7bxKVFhPk1/VPQWlnB5
         lqVmBjgbqbIkU9Svkr4p0JAZZHmvzMoP+ZJYUCOsn1EgKPk3NtGB1rEeKJOA2pPpe4eu
         eYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724500945; x=1725105745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2ItJXwls8LLC6xWQ1PTr24F5BP1jKP9kLXBVlYcNIE=;
        b=ElhgHZJQ4VAlYIReLZZJmbAat05yC9hdKDPVymAI+B9CfChYzp2whC+IY7RcRjBPyW
         2rTgommaTbp0GmDYeC7NpeFaebirpin+4aZsOPtGM1WCr1S3OzqHK4KUU0jULM3eAr9T
         qwxPrwBQuIZR/aWeWEAcmRlUOCBHhxdpV6LvwjSLalz0+DxykvfM2T0sxhSF5sNhlEzS
         xIfqD07q7AfppePcuZhfc50nKW2BPAAdS3Jdc2GanMb0V2Gf8Y9Zzh0yXK9aeS8Non+d
         MZTuKyGPOweLLmhlgbQYVuLaa9OxCprlRpUxOzfhqfJGL2G13u/qsIET1kLteetO0MP+
         QJag==
X-Forwarded-Encrypted: i=1; AJvYcCVzL/jFw+aajAqFGKV+s3iWhY4JN4+0NDMCwpCRcaCq7vPYH8jTm9Zs7ww8Jhn7QPtIGKS41GFJgRjc2PO2@vger.kernel.org, AJvYcCXrOFUPpkZ7u1RlqyUB2v83u5ubguCseE5ceiz9OH4M0++hCHq016K3iH4WTejkFv8l0MWdTh73pa9j@vger.kernel.org, AJvYcCXsN01YmxnTQcsyQAHrYrnhgdyWMbrzJYLmBtHlItCZlCx2Ca/Rwsrv+xvTmdBOElX9GBA1e2vIwSD0@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUrPQeA6eD/FHkNhEX2iUqbyN/f97onnEu/1L2+DgT5EeRDE9
	C7CKdlF6SU5Z2DgRx3i17bpQuX35wFtyLsKAZOd7FokFecsfUZc4
X-Google-Smtp-Source: AGHT+IEHG5urjexhfKt+kdk+33zQTRwrsiCFjFCtfzt9SkHMQ584LriCwKdofi79rsLfEA+WOtfi7g==
X-Received: by 2002:a05:600c:5128:b0:426:6857:3156 with SMTP id 5b1f17b1804b1-42acd5dcaa8mr37460795e9.27.1724500944879;
        Sat, 24 Aug 2024 05:02:24 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37307c0c9c7sm6513375f8f.0.2024.08.24.05.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 05:02:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 14:02:22 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240824120222.GG9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-7-vassilisamir@gmail.com>
 <ZsjrxLlhmx-TzwXF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsjrxLlhmx-TzwXF@smile.fi.intel.com>

On Fri, Aug 23, 2024 at 11:06:28PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 08:17:13PM +0200, Vasileios Amoiridis wrote:
> > The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> > a trigger for when there are data ready in the sensor for pick up.
> > 
> > This use case is used along with NORMAL_MODE in the sensor, which allows
> > the sensor to do consecutive measurements depending on the ODR rate value.
> > 
> > The trigger pin can be configured to be open-drain or push-pull and either
> > rising or falling edge.
> > 
> > No support is added yet for interrupts for FIFO, WATERMARK and out of range
> > values.
> 
> ...
> 
> > +static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
> > +				  const struct iio_trigger_ops *trigger_ops,
> > +				  int (*int_config)(struct bmp280_data *data),
> 
> > +				  irqreturn_t (*irq_thread_handler)(int irq, void *p))
> 
> irq_handler_t
> 

But the function returns an irqreturn_t type, no?

> ...
> 
> > +	fwnode = dev_fwnode(data->dev);
> > +	if (!fwnode)
> > +		return -ENODEV;
> 
> Why do you need this? The below will fail anyway.

Because If I don't make this check then fwnode might be garbage and I will
pass garbage to the fwnode_irq_get() function. Or do I miss something?

> 
> > +	irq = fwnode_irq_get(fwnode, 0);
> > +	if (!irq)
> 
> Are you sure this is correct check?
> 
Well, I think yes, because the function return either the Linux IRQ number
on success or a negative errno on failure.

https://elixir.bootlin.com/linux/v6.10.6/source/drivers/base/property.c#L987

> > +		return dev_err_probe(data->dev, -ENODEV,
> 
> Shadowed error code.
> 

I am not sure I understand what you mean here. You mean that there is no
chance that the first one will pass and this one will fail?

> > +				     "No interrupt found.\n");
> 
> > +	desc = irq_get_irq_data(irq);
> > +	if (!desc)
> > +		return -EINVAL;
> 
> When may this fail?
> 

I think that this will fail when Linux were not able to actually
register that interrupt.

> > +	irq_type = irqd_get_trigger_type(desc);
> > +	switch (irq_type) {
> > +	case IRQF_TRIGGER_RISING:
> > +		data->trig_active_high = true;
> > +		break;
> > +	case IRQF_TRIGGER_FALLING:
> > +		data->trig_active_high = false;
> > +		break;
> > +	default:
> > +		return dev_err_probe(data->dev, -EINVAL,
> > +				     "Invalid interrupt type specified.\n");
> > +	}
> 
> > +	data->trig_open_drain = fwnode_property_read_bool(fwnode,
> > +							  "int-open-drain");
> 
> Better
> 
> 	data->trig_open_drain =
> 		fwnode_property_read_bool(fwnode, "int-open-drain");
> 

Indeed, thanks!

> ...
> 
> > +static int bmp380_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > +					     bool state)
> > +{
> > +	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
> > +	int ret;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
> > +				 BMP380_INT_CTRL_DRDY_EN,
> > +				 FIELD_PREP(BMP380_INT_CTRL_DRDY_EN,
> > +					    state ? 1 : 0));
> 
> 				 FIELD_PREP(BMP380_INT_CTRL_DRDY_EN, !!state));
> 
> ? ( Even <= 80 characters)

Well, that's true.

> 
> > +	if (ret) {
> > +		dev_err(data->dev, "Could not enable/disable interrupt\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> 
> 	if (ret)
> 		dev_err(data->dev, "Could not enable/disable interrupt\n");
> 
> 	return ret;
> 
> ?

All the other if statements follow the style that I typed. If I
follow yours, will make it different just for this one, does it
make sense?

Cheers,
Vasilis
> 
> > +}
> 
> ...
> 
> > +static int bmp380_int_config(struct bmp280_data *data)
> > +{
> > +	int ret, int_cfg = FIELD_PREP(BMP380_INT_CTRL_OPEN_DRAIN,
> > +				      data->trig_open_drain) |
> > +			   FIELD_PREP(BMP380_INT_CTRL_LEVEL,
> > +				      data->trig_active_high);
> 
> Split these two variables and make the indentation better for int_cfg.
> 

True, makes sense.

> > +	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
> > +				 BMP380_INT_CTRL_SETTINGS_MASK, int_cfg);
> > +	if (ret) {
> > +		dev_err(data->dev, "Could not set interrupt settings\n");
> 
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> 
> 	return ret;
> 
> ?

Yes, you are right.

> 
> > +}
> 
> ...
> 
> > +static int bmp580_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > +					     bool state)
> > +{
> > +	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
> > +	int ret;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
> > +				 BMP580_INT_CONFIG_INT_EN,
> 
> > +				 FIELD_PREP(BMP580_INT_CONFIG_INT_EN,
> > +					    state ? 1 : 0));
> 
> !!state ?
> 

ACK.

> > +	if (ret) {
> > +		dev_err(data->dev, "Could not enable/disable interrupt\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> 
> 	return ret;
> 
> ?
> 
> > +}
> 
> ...
> 
> > +static int bmp580_int_config(struct bmp280_data *data)
> 
> Same comments as per above.
> 
> ...
> 
> > +	if (irq > 0) {
> > +		if (chip_id == BMP180_CHIP_ID) {
> > +			ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +		if (data->chip_info->trigger_probe) {
> > +			ret = data->chip_info->trigger_probe(indio_dev);
> > +			if (ret)
> > +				return ret;
> > +		}
> >  	}
> 
> Can be
> 
> 	if (irq > 0) {
> 		if (chip_id == BMP180_CHIP_ID)
> 			ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
> 		if (data->chip_info->trigger_probe)
> 			ret = data->chip_info->trigger_probe(indio_dev);
> 		if (ret)
> 			return ret;
> 	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Well, it looks much more beautiful indeed. Thanks again for the feedback
Andy, I really appreciate it a lot!

Cheers,
Vasilis

