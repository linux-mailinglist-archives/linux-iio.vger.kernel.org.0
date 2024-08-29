Return-Path: <linux-iio+bounces-8886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDF964EA6
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 21:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE091F23A51
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306F1B654B;
	Thu, 29 Aug 2024 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsQugL+e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCE15C120;
	Thu, 29 Aug 2024 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959204; cv=none; b=stY3o+zYdyDmJtRwaoIGoBzjZoFJOA7FFMwpb/P4ra0c2gItGNr5v5gwso+vYpfrKV1w88TQSDbd/Qv9PGYwuElWNyVnYvAvryWYVv24gxXS/w0rhYGhGgfE/4qZySc7cmU5b+iG4DYJ+qvUkJxeaeQT8SNAi5c9Qk+bm0h7rJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959204; c=relaxed/simple;
	bh=C2Ywd8aEuPBFjcUmfmPFUWScoJ69+USMtPOY55wndc0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mvz3NvPn9r7oouR7FNOVTuqfr5apQrBGiZTrJiZxTKsiqAYjgVncQ0Rx6zl9KAylh5h5xklxCZPbwBFQYuaT6EgtV3fMhKUJLPWoqLDnV7zxMUE2mCVMY3sL3AAWtHtCs63a7n6e43fXHIXI14rD/SvslsP/u7B6SsbkqORq8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsQugL+e; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f50966c448so11013011fa.2;
        Thu, 29 Aug 2024 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724959201; x=1725564001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCnS5FSw7TMJ/OXfihwq0KTpadDAzKSgwFWbwVheRb4=;
        b=AsQugL+ekZhoZXl4EVtG1mGRmnt7RNxzAJho9JQLN51ifPyrxTmGWtKJTbhuUpBiIS
         LHBglX0dpfpv5PFnZLTJatuNsuHEU5yxq/qLpUB6rXmaoOXi/vIJ/WZdtY1KxwB8Eujd
         /pOXL/9MhXV370pnRr4G8p1O8WrU1c6Cadc+u46FXfG0QYOBreFGQ2cvTmhRRNY49VkM
         amQIn2X4PDoqYcW0qllLm6VlkCApt7ahpDJTQF6P/WFsEKs5WqJ/ZeR93piZgXk+xIw1
         c38PBKGzpg4ysOlTIpInVycX91C9zOf1/S9Juhog8KyZutnaybFDY5WqJp9M/Nz1hl6m
         YvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959201; x=1725564001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCnS5FSw7TMJ/OXfihwq0KTpadDAzKSgwFWbwVheRb4=;
        b=j/okbhusujUrtuZcvVjV5AWh+ddjuyvBirVSV788ibkRpXgXORpXFREl95T6FPyKqu
         KTiY5SaFk3pzOOyjv/bUvwRx8cpfPbFECr71L2aRGqFwqojRnFvbO6ubgFf89blBfo24
         Bb4WeH5+Z3FOAIHIch8lXyk1iRNao5n5r8SZPNoNU08cr9Z1xn5KXRUaWlwQ8scYWA7B
         JF7WiIPdWqmlu0sMYa1NGvD2uYGNpIxE/PJriMvP05PU6OPE3jTn81dIABBmN5YuFh8W
         Ha+5X/PbAyCL/iVEYO0xnIoEo4oDA6xXT55OAnMLliu1cLiow2/lqNL4Geow15qCihgz
         Ugqw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Dl4gxMv6N+3n1kshBLcr3bFkPhVq0JOLuC77SKd4LEFaGS9jKEav2j4XdaVXvtVPlVwXL5KVz2wIbKgX@vger.kernel.org, AJvYcCUxBkBDJxM6fR1FnINPW+dPk3KyisLOw+7bCMHwR8F/00ZggxrGGXpjQ/NeiGcaYe6xMAMIS0Heztmz@vger.kernel.org, AJvYcCWMX9/abxuY/Bdo1Ca+AMLZ4oqxC+ustkyRrctRBdfkOVN/btubyS3CdaYXFN+Vh59in0iaowong8a0@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwE9sRsgd8pB+tKj/EYmxmVvTax7zk26W4q6rdWePfxsUVU8w
	UdlIM1rTI/xTPF2gJc3ktz2Hgcf0w7dMztoJ2/doDZ+6YJe4oc2XvPNsZ6xA
X-Google-Smtp-Source: AGHT+IEuz0kNDOVzjnxAD+FDporBf7yDu94yPDfedBAR9V+NN+eMedrksZ1TjqtxSa77Cknr5xq/hA==
X-Received: by 2002:a2e:4609:0:b0:2ef:3126:390d with SMTP id 38308e7fff4ca-2f61054aaf9mr26135871fa.42.1724959199831;
        Thu, 29 Aug 2024 12:19:59 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:f22f:934f:9b88:e7ce])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm1046971a12.32.2024.08.29.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:19:59 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 29 Aug 2024 21:19:57 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240829191957.GE3493@vamoiridPC>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-7-vassilisamir@gmail.com>
 <ZtBsQg_JIcY4F-0h@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBsQg_JIcY4F-0h@smile.fi.intel.com>

On Thu, Aug 29, 2024 at 03:40:34PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 10:51:26PM +0200, Vasileios Amoiridis wrote:
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
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 231 ++++++++++++++++++++++++++++-
> >  drivers/iio/pressure/bmp280.h      |  21 +++
> >  2 files changed, 250 insertions(+), 2 deletions(-)
> 
> ...
> 
> > +static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
> > +				  const struct iio_trigger_ops *trigger_ops,
> > +				  int (*int_config)(struct bmp280_data *data),
> > +				  irq_handler_t irq_thread_handler)
> > +{
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> 
> With
> 
> 	struct device *dev = data->dev;
> 
> you may shorten some lines below and collapse a few.
> 

ACK.

> > +	struct fwnode_handle *fwnode;
> > +	int ret, irq, irq_type;
> 
> Why irq_type is signed?
> 

True, this can be made u32.

> Also try to make that returned variable is closer to the end of the definition
> block. And it might be worth to follow reversed xmas tree order (longer lines
> first).
> 
> > +	struct irq_data *desc;
> > +
> > +	irq = fwnode_irq_get(dev_fwnode(data->dev), 0);
> > +	if (irq < 0)
> > +		return dev_err_probe(data->dev, irq, "No interrupt found.\n");
> > +
> > +	desc = irq_get_irq_data(irq);
> > +	irq_type = irqd_get_trigger_type(desc);
> 
> So, altogether it may be written as
> 
> 	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
> 
> And looking further, we have a helper for that:
> irq_get_trigger_type(). Why not use it?
> 

I was not aware of that, I can definitely change it.

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
> > +
> > +	data->trig_open_drain =
> > +		fwnode_property_read_bool(fwnode, "int-open-drain");
> > +
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
> > +		return dev_err_probe(data->dev, ret, "request irq failed.\n");
> > +
> > +	ret = devm_iio_trigger_register(data->dev, data->trig);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "iio trigger register failed.\n");
> > +
> > +	indio_dev->trig = iio_trigger_get(data->trig);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int bmp380_int_config(struct bmp280_data *data)
> > +{
> > +	int pin_drive_cfg = FIELD_PREP(BMP380_INT_CTRL_OPEN_DRAIN,
> > +				       data->trig_open_drain);
> > +	int pin_level_cfg = FIELD_PREP(BMP380_INT_CTRL_LEVEL,
> > +				       data->trig_active_high);
> > +	int ret, int_cfg = pin_drive_cfg | pin_level_cfg;
> > +
> > +	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
> > +				 BMP380_INT_CTRL_SETTINGS_MASK, int_cfg);
> > +	if (ret) {
> > +		dev_err(data->dev, "Could not set interrupt settings\n");
> 
> > +		return ret;
> > +	}
> > +
> > +	return ret;
> 
> One of them is redundant or the last one should be return 0, but why not just
> leave one of them?
> 

I can just leave one of them, true!

> > +}
> 
> ...
> 
> > +static int bmp580_int_config(struct bmp280_data *data)
> > +{
> > +	int ret, int_cfg = FIELD_PREP(BMP580_INT_CONFIG_OPEN_DRAIN,
> > +				      data->trig_open_drain) |
> > +			   FIELD_PREP(BMP580_INT_CONFIG_LEVEL,
> > +				      data->trig_active_high);
> > +
> > +	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
> > +				 BMP580_INT_CONFIG_MASK, int_cfg);
> > +	if (ret) {
> > +		dev_err(data->dev, "Could not set interrupt settings\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = regmap_set_bits(data->regmap, BMP580_REG_INT_SOURCE,
> > +			      BMP580_INT_SOURCE_DRDY);
> > +	if (ret) {
> > +		dev_err(data->dev, "Could not set interrupt source\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> 
> So far you have three different styles in the same patch for this!
> Choose one and be consistent with it.
> 
> > +}
> 
> ...
> 
> > +	int (*trigger_probe)(struct iio_dev *indio_dev);
> >  	irqreturn_t (*trigger_handler)(int irq, void *p);
> 
> Yeah, at some point this can be changed to
> 
> 	irq_handler_t trigger_handler;
> 

I can definitely try that in a separate patch, thanks for pointing
all these out!

Cheers,
Vasilis

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

