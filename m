Return-Path: <linux-iio+bounces-7776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BCC9386BB
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 01:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABDD1F2121D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 23:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F66171CD;
	Sun, 21 Jul 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjT2KbsQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE515E86;
	Sun, 21 Jul 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721605879; cv=none; b=UbS/v2iZsPGiFWtu8GsVszyF+Zi9e8N+a5wjooiellSQ45KE1mBVAZ/yrTjeVvUOHofncWjz+h8xNlgFge7owbjVsHiTc4pXoNWHdWV5tWQFuDzgIgJ6EpDieArloz94z0Q3FKq6G58Qzandg2GWDt0uaLD91jV/WyeFdDB70nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721605879; c=relaxed/simple;
	bh=FVwJHdRoGmgkHrYwN+HKRj2Tiq9dkaCOm0RxRtnkXgk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiXSKq8IeNK+4Q83OXQarSOjH6wdb5yyFuwgAIelLR8ALSv+qiniJ/+c+5xUlaB9inNyKJ+X8Qydqxx8ZZDtSR8ZSJx4cLYMq3b6eejspHvSzPD5xifKYMCsC5dLuzxP7aB4nZZ6sPUffyi/2SlgdORjTnOevgzcQ/Y6mNqGRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjT2KbsQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-368313809a4so1515149f8f.0;
        Sun, 21 Jul 2024 16:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721605876; x=1722210676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zsPglJLs+PwhCt6JJKTY4dDbSwrlyFnUYucnwVGvbU=;
        b=GjT2KbsQZNECQuAZCzTxI7pm7g7QVYI478OioVXiIHGRkWe5oMnQQ0NyY0nh7nOR/z
         vL3xkYjbB6rpUixyXW84ZMOZuSdVN0D38UkSKpn744Fn427Utwg25LtPG8S1vSlRxEZf
         uhgqtrT4P3IK8Bb8hadKrqhH+YgdW0UTs1JKtGOSigYLyCD2bkNtfVr2Q44HMTt7j+Bq
         L0NUVvVKEsnPdwEQhe2xJoVmgSpW3qjVRxhYVqPhwrtCtTzrTOr4grMz90ta2aMYwIV7
         8NqP4laxa/iJT4f2lUQjx9nqYIm/6yOTGLMba6yG8lBrPcWln31Scx3hFy68xmSfwOAy
         2cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721605876; x=1722210676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zsPglJLs+PwhCt6JJKTY4dDbSwrlyFnUYucnwVGvbU=;
        b=leeGb/fVlRMEy02xtAdDMdJ8w7WZM8MJqKagxKnJ0FbORA8/F+6J0Er9Cbkx1VtGQZ
         x5pGjQMq1MSPFAwYPmB+r/9ZKBqrRxE29Mpc2nk3LhHcWNlcLoccgj/176ruRWK1zcYH
         7ijT18LTj6szn8+JW4inh9anV8yPglO+HLQscguFdtNwd4dpLXYhxSMDM39shbOINxzu
         smEVS/Rg4ilDVf5no2b0SqUz9zbD2wLyDHQ+iT5B9RvAhEiHUNaIlm8jxKPhUxRGQVmJ
         cEYdlodaifCboTXeh3SvgCshnPKlHRiVh/AoaYPRKmhkk5Smw8qTgD7kEpk4NddBR/Op
         0jfw==
X-Forwarded-Encrypted: i=1; AJvYcCUs3wlw3OonDMajCE9SRuovS1M7KpOSbnk1iRgR2os4iMGohta9KpEkhOuXGkFNUCOabRFcazb5EdstxxmBmS4oiOLYzVwuitc8iK4hxGwf4AkZ/15ERpWphfiT7PW8MLsndwFF7R6Aox1vGM89nAxk5fv8voFLJlWr37HGkDuQcwJrkA==
X-Gm-Message-State: AOJu0YxvRVo6bbqxmrgM3fMMwa0I5mUXVw6TrqW2XpFIqj87zZi5/sXg
	1XGEFVuciVxqgXE6nOCZnhU4h2fovnA30eI1TlpbfD0nId+gY56p
X-Google-Smtp-Source: AGHT+IEbS7SHcqwkg4hBL0pZxDwQxKYDkXPyAUdWr9KBE9CHQhbmBU78f/9G5P2BV/i+k0poCmoVIQ==
X-Received: by 2002:a5d:6745:0:b0:367:8a6a:ec50 with SMTP id ffacd0b85a97d-369b66a18d5mr3396153f8f.6.1721605876062;
        Sun, 21 Jul 2024 16:51:16 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:bc21:fb27:f4e6:6867])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ced1dsm6946149f8f.72.2024.07.21.16.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 16:51:15 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 22 Jul 2024 01:51:13 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/10] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240721235113.GF325365@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-10-vassilisamir@gmail.com>
 <20240720123727.7598111b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720123727.7598111b@jic23-huawei>

On Sat, Jul 20, 2024 at 12:37:27PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jul 2024 23:15:57 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
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
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> A few minor things inline.
> 
> It might be worth thinking a bit about future fifo support as that can
> get a little messy in a driver that already supports a dataready trigger.
> We end up with no trigger being set meaning use the fifo.  Sometimes
> it makes more sense to not support triggers at all.
> 
> What you have here is fine though as we have a bunch of drivers
> that grew dataready trigger support before adding fifos later
> particularly as often it's a 'new chip' that brings the fifo
> support but maintains backwards compatibility if you don't use it.
> 

Hi Jonathan,

Thank you very much for your thorough review again!

What I could do to make the code even better to be able to accept
FIFO irq support are the following:

1) in the bmp{380/580}_trigger_handler() currently, the data registers
are being read. What I could do is to move the reading of registers
to a separe function like bmpxxx_drdy_trigger_handler() and calling
it inside the bmp{380/580}_trigger_handler() when I have DRDY or
sysfs irq. In order to check the enabled irqs I propose also no.2

2) in the following bmp{380/580}_trigger_probe() functions instead of
just doing:

       irq = fwnode_irq_get_byname(fwnode, "DRDY");
       if (!irq) {
               dev_err(data->dev, "No DRDY interrupt found\n");
               return -ENODEV;
       }

I could also use some type of variable like we do for the active
channels in order to track "active/existing irqs".

Like this it would be easier to track the active irqs of the sensor.

Let me know what you think, or if I manage to have time I might send
a v2 with those changes even earlier :)

Cheers,
Vasilis

> > +
> > +static int bmp380_trigger_probe(struct iio_dev *indio_dev)
> > +{
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	struct fwnode_handle *fwnode;
> > +	int ret, irq, irq_type;
> > +	struct irq_data *desc;
> > +
> > +	fwnode = dev_fwnode(data->dev);
> > +	if (!fwnode)
> > +		return -ENODEV;
> > +
> > +	irq = fwnode_irq_get_byname(fwnode, "DRDY");
> > +	if (!irq) {
> > +		dev_err(data->dev, "No DRDY interrupt found\n");
> > +		return -ENODEV;
> As below. return dev_err_probe() for anything that is only
> called from probe()
> 
> > +	}
> > +
> > +	desc = irq_get_irq_data(irq);
> > +	if (!desc)
> > +		return -EINVAL;
> > +
> > +	irq_type = irqd_get_trigger_type(desc);
> > +	switch (irq_type) {
> > +	case IRQF_TRIGGER_RISING:
> > +		data->trig_active_high = true;
> > +		break;
> > +	case IRQF_TRIGGER_FALLING:
> > +		data->trig_active_high = false;
> > +		break;
> > +	default:
> > +		dev_err(data->dev, "Invalid interrupt type specified\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	data->trig_open_drain = fwnode_property_read_bool(fwnode,
> > +							  "int-open-drain");
> > +
> > +	ret = bmp380_int_config(data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> > +					    indio_dev->name,
> > +					    iio_device_id(indio_dev));
> > +	if (!data->trig)
> > +		return -ENOMEM;
> > +
> > +	data->trig->ops = &bmp380_trigger_ops;
> > +	iio_trigger_set_drvdata(data->trig, data);
> > +
> > +	ret = devm_request_irq(data->dev, irq,
> > +			       &iio_trigger_generic_data_rdy_poll,
> > +			       IRQF_ONESHOT, indio_dev->name, data->trig);
> > +	if (ret) {
> > +		dev_err(data->dev, "request irq failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_iio_trigger_register(data->dev, data->trig);
> > +	if (ret) {
> > +		dev_err(data->dev, "iio trigger register failed\n");
> > +		return ret;
> > +	}
> > +
> > +	indio_dev->trig = iio_trigger_get(data->trig);
> > +
> > +	return 0;
> > +}
> > +
> > +
> One blank line only.
> 
> >  static irqreturn_t bmp380_trigger_handler(int irq, void *p)
> 
> 
> > +
> > +static int bmp580_trigger_probe(struct iio_dev *indio_dev)
> > +{
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	struct fwnode_handle *fwnode;
> > +	int ret, irq, irq_type;
> > +	struct irq_data *desc;
> > +
> > +	fwnode = dev_fwnode(data->dev);
> > +	if (!fwnode)
> > +		return -ENODEV;
> > +
> > +	irq = fwnode_irq_get_byname(fwnode, "DRDY");
> > +	if (!irq) {
> > +		dev_err(data->dev, "No DRDY interrupt found\n");
> 
> As this only gets called from probe(), use return dev_err_probe() throughout.
> 
> > +		return -ENODEV;
> > +	}
> > +
> > +	desc = irq_get_irq_data(irq);
> > +	if (!desc)
> > +		return -EINVAL;
> > +
> > +	irq_type = irqd_get_trigger_type(desc);
> > +	switch (irq_type) {
> > +	case IRQF_TRIGGER_RISING:
> > +		data->trig_active_high = true;
> > +		break;
> > +	case IRQF_TRIGGER_FALLING:
> > +		data->trig_active_high = false;
> > +		break;
> > +	default:
> > +		dev_err(data->dev, "Invalid interrupt type specified\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	data->trig_open_drain = fwnode_property_read_bool(fwnode,
> > +							  "int-open-drain");
> > +
> > +	ret = bmp580_int_config(data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> > +					    indio_dev->name,
> > +					    iio_device_id(indio_dev));
> > +	if (!data->trig)
> > +		return -ENOMEM;
> > +
> > +	data->trig->ops = &bmp580_trigger_ops;
> > +	iio_trigger_set_drvdata(data->trig, data);
> > +
> > +	ret = devm_request_irq(data->dev, irq,
> > +			       &iio_trigger_generic_data_rdy_poll,
> > +			       IRQF_ONESHOT, indio_dev->name, data->trig);
> > +	if (ret) {
> > +		dev_err(data->dev, "request irq failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_iio_trigger_register(data->dev, data->trig);
> > +	if (ret) {
> > +		dev_err(data->dev, "iio trigger register failed\n");
> > +		return ret;
> > +	}
> > +
> > +	indio_dev->trig = iio_trigger_get(data->trig);
> > +
> > +	return 0;
> > +}
> >
> >  
> 

