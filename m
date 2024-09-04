Return-Path: <linux-iio+bounces-9131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C596B879
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 12:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6AC1F2233E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286D31CF5ED;
	Wed,  4 Sep 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flMk+hiU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392553FE55;
	Wed,  4 Sep 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445699; cv=none; b=b3fpzl9MgvTJYV2pipVM1uDfQFnT5TKXtKKpIhjNV9J+8gqNjmzw2BRvyDtt3uQZRCETcS710yTYGf/cWvIWGjc/se252JXEKHeL7Aikuw6pbp2zxfr4Nb7EIVwN3EypDnFS2CZg32UEGYlCmIE0OX7Ny4Ge6i+grMhZvjxE1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445699; c=relaxed/simple;
	bh=bEDwC6P0xjlxvRvvmGGw5C86eeMHSi/vfZxzztdojmI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwyyPM78jnNJ74JKBQeprzvvJEHhEi1EK+OA5L/gWzpTr/xRejlakTC5r8VlepvOM0cFb/WLNiBC9wV2cg+pt7RO/e8Rg0aNcxyRqVXOqLcBl3EKGRB4l0ojgKwBgqicHZYaDqTG4VV83lm+BaJve5VO/q6bMM1rbroIUMi3tbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flMk+hiU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5334879ba28so8805707e87.3;
        Wed, 04 Sep 2024 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725445696; x=1726050496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYL0sYGdXC/I/pHzO8WanzF6Y9Cg7VaPORJxEUAHEEM=;
        b=flMk+hiUzR2FwhlhxIsU/SjE7qBnOkrcSX5Ump/2RJm086MTEn4OQDfahaiefba36Z
         NnDxKNXiFb9IBKx/T7yr/m6G3P8+IuIbfjZWbYCNjxLXP0Wg9vJ41b+agyLdYn17WnQr
         jiiVetZIHSoR4UEPyCxygfo6obEl3XXLpMNlgDSBqQ4iCeiqxwkUVfJPUqfccofmeqXn
         9jzKGXE08Bz2FDHIIJCQryOAeUvtpY9TBmwuW1UEBtlGTgiDVA20XYLowG1GDhjPerL4
         pKMX/X33ElkmwBLKjPTK4QUwonAx+Q5swmxhnXKUV3xIZ72HDUyfBFFSE9i2zpqK4IUK
         zq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445696; x=1726050496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYL0sYGdXC/I/pHzO8WanzF6Y9Cg7VaPORJxEUAHEEM=;
        b=d3sH9MlN+v7nIOWfITOb/LLTnlVELjcxSGgU0aERMB3oo2mYUMxTnz5KAdpZplOO4E
         wbc3Lyhg9D6BTg5yUKuImT8UuoSl1/sYlaiAf8UR+qXSOHEhnExeajkxQKgEihmoa1Gx
         HLaz1JVasSBp/7GpeYYP5N1q3HV5bsCRoyQ/h/ywNdDXnGyIDyzE+Cm9fQOGO4cf8SVD
         sB55CUj2zgcA+9WMzQcRLESHSSCf0isBmeYTZtlukwfs2KrAizhLDh5H8+9ylbazb3Uz
         TzFfA94U9TVGx/gS6lS6atAfmHimfIylqYMcqPHjPOaIkoFdUc9yuyPHDNCBHCktZNKO
         Ca/A==
X-Forwarded-Encrypted: i=1; AJvYcCVbPKrnyKGB7QZHsYwT6Aiu3HtsBSampa6I6JCj2FG2LFpY+fotomjRyx+cympX83xGIx5mBEhVYn74@vger.kernel.org, AJvYcCW9lYKvsQubYIPJ7Q1TEAx890nQnh6bN2G5DLMQsvST2Npl2xuo0EUvuv9AtabwqSaQf6nc9ykhi4j5@vger.kernel.org, AJvYcCWjy9+dbjNR48w9+7ZjsvIX31NuNcHm51G6c2KfOF+JQBg3pgK+NglkKm/dufqKbADPzM6aQ+EV8qjlxBK/@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvEVtk53eSG09te3PL1MFQvQsS0IE48FmMg9MnfZYUybP9x36
	89smZxxORDimMAkWUg4qgULeNeOG5LrgOQtYXdTyhcTDpvwlGC2Y
X-Google-Smtp-Source: AGHT+IG0jYC415UmOsI2K9f8so+E1NXCaskDfn0PHPmvNdSFyZkKWPDFpAjwBjE7nv2N7jA8sZB3dg==
X-Received: by 2002:a05:6512:3352:b0:535:6992:f2cb with SMTP id 2adb3069b0e04-5356992f407mr750590e87.42.1725445695259;
        Wed, 04 Sep 2024 03:28:15 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6dc3sm783627266b.156.2024.09.04.03.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:28:14 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 4 Sep 2024 12:28:12 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240904102812.GB44250@vamoiridPC>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-7-vassilisamir@gmail.com>
 <Ztce3XuXZ-hxwU8h@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztce3XuXZ-hxwU8h@smile.fi.intel.com>

On Tue, Sep 03, 2024 at 05:36:13PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 02, 2024 at 08:42:21PM +0200, Vasileios Amoiridis wrote:
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
> > +				  irq_handler_t irq_thread_handler)
> 
> Would it make sense (note, I do *not* know the correct answer!) to have
> something like
> 
> struct foo {
> 	const struct iio_trigger_ops *trigger_ops;
> 	int (*int_config)(struct bmp280_data *data);
> 	irq_handler_t irq_thread_handler;
> };
> 
> and pass it around?
> 

From my point of view it won't be more clear, it might complicate things,
I feel like this *looks* better.

> Also int_config sounds non-related to interrupt, however it's about interrupt
> pin, right? perhaps name it differently here?
> 
> E.g.,
> 
> 	interrupt_pin_config
> 
> ?
> 

This sounds good yes!

> > +{
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	struct device *dev = data->dev;
> > +	struct fwnode_handle *fwnode;
> > +	u32 irq_type;
> > +	int ret, irq;
> > +
> > +	irq = fwnode_irq_get(dev_fwnode(dev), 0);
> > +	if (irq < 0)
> > +		return dev_err_probe(dev, irq, "No interrupt found.\n");
> > +
> > +	irq_type = irq_get_trigger_type(irq);
> > +	switch (irq_type) {
> > +	case IRQF_TRIGGER_RISING:
> > +		data->trig_active_high = true;
> > +		break;
> > +	case IRQF_TRIGGER_FALLING:
> > +		data->trig_active_high = false;
> > +		break;
> > +	default:
> > +		return dev_err_probe(dev, -EINVAL, "Invalid interrupt type specified.\n");
> > +	}
> > +
> > +	data->trig_open_drain =
> > +		fwnode_property_read_bool(fwnode, "int-open-drain");
> 
> 
> Where do you initialise fwnode?
> 

Ok, I need to retest this with the device-tree.

> > +	ret = int_config(data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> > +					    indio_dev->name,
> > +					    iio_device_id(indio_dev));
> > +	if (!data->trig)
> > +		return -ENOMEM;
> > +
> > +	data->trig->ops = trigger_ops;
> > +	iio_trigger_set_drvdata(data->trig, data);
> > +
> > +	ret = devm_request_threaded_irq(data->dev, irq, NULL,
> > +					irq_thread_handler, IRQF_ONESHOT,
> > +					indio_dev->name, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "request irq failed.\n");
> 
> IRQ
> 

ACK.

> > +	ret = devm_iio_trigger_register(data->dev, data->trig);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "iio trigger register failed.\n");
> > +
> > +	indio_dev->trig = iio_trigger_get(data->trig);
> > +
> > +	return 0;
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
> > +				 FIELD_PREP(BMP580_INT_CONFIG_INT_EN, !!state));
> > +	if (ret)
> > +		dev_err(data->dev,
> > +			"Could not %s interrupt.\n", str_enable_disable(state));
> > +	return ret;
> 
> Somewhere above (or in another patch) you used the style with 'return 0;' at
> the end. Please, check the resulting code for the consistency and choose one
> style for all.
> 

ACK.

> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

