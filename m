Return-Path: <linux-iio+bounces-8663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00A95A730
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DC62834DB
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A517AE19;
	Wed, 21 Aug 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QadsvmsW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753C179957;
	Wed, 21 Aug 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277389; cv=none; b=mzGsZVf2pTs91QsWEHfdlVXG7Hmq/iDoL8zgJphMjeDqePr4ldaZp79opocKbxlqTcH9bWIeYs60m7LJISfdMlCFRm3oih1bY+js1AJRhyXJByNBoxNHRRHv2J6e0C5nPLz+MI4woVsawKu+WKEQ4AuH/Misk5I6JtsoKjEXlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277389; c=relaxed/simple;
	bh=LpwV+wCXV9VUNCXIJWwpdFq8kMMQkK1UndLAiyq50dQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd8WUESDdrm+wSk8eP3Zsh4j/siuDHQXliSkShbrVkTNTBzTlkQ5PcJ0dfjkYnwhjfxJhUdtu3CQ/iLWOPw1WZHntq8HudYCSnCb2TCYr2sgPhcQA91DmQ3qiwbcXzZSyAc0zc7Ti6X7wZeBepgWZObQs563CyQ/KAOHTeLiMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QadsvmsW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83597ce5beso21981066b.1;
        Wed, 21 Aug 2024 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277386; x=1724882186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bhJPrmFRdKDUykod1xQwmOhwV8MFti4H7go02tXSqUU=;
        b=QadsvmsWWHX22b2f8JPg+t8En3kfCDQdsLm6cV60AVqaPMQbawC3dLQe5vLnXEBi+1
         G4D8xTNJR1jbnCJ0moIUKNJtms7Fk3n0ynoKkBix7e+KhGO4hg1p6Ad6kv4KVEo1/RG9
         Q6LVp4HIJHGNtFnEcEvi796K3Tw1fQUWD94AZacVHvO77kWeRqOJf2cdyjP/TNBc8/D+
         WezMTUzcEnzPiRsuBxOgnwwwjdeb+9MzUF/2AayhkI22IXuDUn4dfC/vWjL5inLyj3ab
         t6Oz7QBKCczZfxiI6DMBNJp5a/Jo0qonIxl27vLKFWYDo4gNAgjiDzH4xgDACxejR8z4
         Az0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277386; x=1724882186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhJPrmFRdKDUykod1xQwmOhwV8MFti4H7go02tXSqUU=;
        b=YvEV2KK4ZuNW5ehHptgxDg3oBmzF6pSMPuhAkNIFtLQ7B/vw2IO+zllxJUrkHHusg6
         LkzbmCqp241jF8z/qKTNImOLpg5vnTHW8PTFDMLVBAJ0dAlNe9x+nFZTh4qFmpNRu7eb
         deKLtBDXPpPsJEi+TFR4HfSiJ8NpBl7Q3NJbeJn1XChfXWSlmgt7XV1Qb9qwxMGLyVQz
         7DxKmdfKZf7fxYAJ76RASFS7b90t2OPlBc4dBvaLAI0/YCePOXdh+BRhTsnO23HQJKaW
         p3y2tHo4JVc4slCpMYunQyEhoLtoY+OIUNEizxUte7Ai/egvUVxJDfdFVKObjEgreLQ3
         1rCw==
X-Forwarded-Encrypted: i=1; AJvYcCUO1UGMtiIFA3fvCT9qboW386G15Sx87Dm6YXH0kaxGffJl8f0F2Eb6HMDgC1KlncqQYSMglXcnBy2i@vger.kernel.org, AJvYcCUdHI+vlKnpyx7A0y9riWxRYQaq08RbXutydPrIxftxwDWn5mxJoomms7QVPukG7F0f2WA/QNT6DoRJ@vger.kernel.org, AJvYcCWtKHxCC+gAZCMw1qaq47cLCdHnULXv7az+bkkdgc5EBhNydLi6ZeYf3cTs2v87xCKew1jp0alsj4LB9bcc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyuw1oIaUJXShgwj4FkomQlqQCV4e5a8TVzVh6xOLjII4dGuMz
	9APWAuWTNVZUdYzZacgzLVPjlbYbdFsLUiscETLXXalPj/QyluPb
X-Google-Smtp-Source: AGHT+IFnBa8+USclyYF6ggOmc27EGbPBSkDewOuK9iHWFHjiNclSIGgbIXw/WTF7JcL4dkISzZO/eg==
X-Received: by 2002:a17:907:6d17:b0:a72:4207:479b with SMTP id a640c23a62f3a-a868a5ac64bmr76019466b.5.1724277384807;
        Wed, 21 Aug 2024 14:56:24 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:1594:887e:30dd:c59e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f62f1sm15479866b.218.2024.08.21.14.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:56:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 21 Aug 2024 23:56:22 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240821215622.GA478206@vamoiridPC>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
 <20240725231039.614536-7-vassilisamir@gmail.com>
 <20240728170650.649839e7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728170650.649839e7@jic23-huawei>

On Sun, Jul 28, 2024 at 05:06:50PM +0100, Jonathan Cameron wrote:
> On Fri, 26 Jul 2024 01:10:38 +0200
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
> Hi Vasileios,
> 
> A few minor things inline, including a suggestion that perhaps the trigger_probe()
> functions can be combined to reduce duplication. That would use a
> __bmp280_trigger_probe(struct iio_dev *, struct iio_trigger_ops *,
>                        + some function pointers).
> 
> Perhaps it's not worth it - I didn't try writing the actual code!
> 
> Jonathan
> 

Hi Jonathan,

Initially, in the v1 of the series, I had designed differently the handling of the
interrupts, and having split functions was making more sense in case you had
sensors with extra interrupts.

Since you explained to me how to do it properly, I think that now, what you are
proposing makes sense.

> > ---
> >  drivers/iio/pressure/bmp280-core.c   | 309 ++++++++++++++++++++++++++-
> >  drivers/iio/pressure/bmp280-regmap.c |   2 +-
> >  drivers/iio/pressure/bmp280.h        |  23 +-
> >  3 files changed, 328 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 4a8d2ed4a9c4..4238f37b7805 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -37,12 +37,14 @@
> 
> 
> 
> > +static irqreturn_t bmp380_irq_thread_handler(int irq, void *p)
> > +{
> > +	struct iio_dev *indio_dev = p;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	unsigned int int_ctrl;
> > +	int ret;
> > +
> > +	scoped_guard(mutex, &data->lock) {
> > +		ret = regmap_read(data->regmap, BMP380_REG_INT_STATUS, &int_ctrl);
> > +		if (ret)
> > +			return IRQ_NONE;
> > +	}
> > +
> > +	if (FIELD_GET(BMP380_INT_STATUS_DRDY, int_ctrl))
> > +		iio_trigger_poll_nested(data->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int bmp380_trigger_probe(struct iio_dev *indio_dev)
> 
> Two of these functions are very similar.  Perhaps define a common
> function that takes a function call for int config, the ops, and
> interrupt handler as arguments then add device specific
> calls that use that.
> 

True, I will think if it could generate any issues in the future with newer
sensors adding more interrupts or with the current ones (bmp580 supports much
more interrupts than the bmp380) and I will act accordingly.

> 
> 
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
> > +	irq = fwnode_irq_get(fwnode, 0);
> > +	if (!irq) {
> > +		dev_err(data->dev, "No interrupt found\n");
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
> > +	ret = devm_request_threaded_irq(data->dev, irq, NULL,
> > +					bmp380_irq_thread_handler, IRQF_ONESHOT,
> > +					indio_dev->name, indio_dev);
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
> 
> one blank line only.
> 

Ack.

> >  static irqreturn_t bmp380_trigger_handler(int irq, void *p)
> >  {
> >  	struct iio_poll_func *pf = p;
> > @@ -1854,6 +1998,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
> >  	.wait_conv = bmp380_wait_conv,
> >  	.preinit = bmp380_preinit,
> >  
> > +	.trigger_probe = bmp380_trigger_probe,
> >  	.trigger_handler = bmp380_trigger_handler,
> >  };
> >  EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
> > @@ -2390,6 +2535,154 @@ static int bmp580_chip_config(struct bmp280_data *data)
> >  	return 0;
> >  }
> >
> 
> ...
> 
> > +static irqreturn_t bmp580_irq_thread_handler(int irq, void *p)
> > +{
> > +	struct iio_dev *indio_dev = p;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	unsigned int int_ctrl;
> > +	int ret;
> > +
> > +	scoped_guard(mutex, &data->lock) {
> 
> Indent wrong.
> 

Ack.

> > +	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &int_ctrl);
> > +	if (ret)
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	if (FIELD_GET(BMP580_INT_STATUS_DRDY_MASK, int_ctrl))
> > +		iio_trigger_poll_nested(data->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int bmp580_trigger_probe(struct iio_dev *indio_dev)
> > +{
> ...
> 
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
> > +	ret = devm_request_threaded_irq(data->dev, irq, NULL,
> > +					bmp580_irq_thread_handler, IRQF_ONESHOT,
> > +					indio_dev->name, indio_dev);
> > +	if (ret) {
> > +		dev_err(data->dev, "request irq failed\n");
> 
> Only in probe paths I think, so return dev_err_probe() thoughout these
> trigger setup callbacks.
> 

Ack.

> 
> 
> > +}
> 
> > diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
> > index d27d68edd906..cccdf8fc6c09 100644
> > --- a/drivers/iio/pressure/bmp280-regmap.c
> > +++ b/drivers/iio/pressure/bmp280-regmap.c
> > @@ -109,7 +109,7 @@ static bool bmp380_is_writeable_reg(struct device *dev, unsigned int reg)
> >  	case BMP380_REG_FIFO_WATERMARK_LSB:
> >  	case BMP380_REG_FIFO_WATERMARK_MSB:
> >  	case BMP380_REG_POWER_CONTROL:
> > -	case BMP380_REG_INT_CONTROL:
> > +	case BMP380_REG_INT_CTRL:
> 
> Unrelated change.  I'm also not sure it's worth making.
> 

I did it because this is tha name in the datasheet and it was also helping
with the 80 char limit. But I can leave it as it is, there is no problem.

> >  	case BMP380_REG_IF_CONFIG:
> >  	case BMP380_REG_ODR:
> >  	case BMP380_REG_OSR:
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index f5d192509d61..754eda367941 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -55,8 +55,17 @@
> >  #define BMP580_CMD_NVM_WRITE_SEQ_1	0xA0
> >  #define BMP580_CMD_SOFT_RESET		0xB6
> >  
> > +#define BMP580_INT_STATUS_DRDY_MASK	BIT(0)
> >  #define BMP580_INT_STATUS_POR_MASK	BIT(4)
> >  
> > +#define BMP580_INT_SOURCE_DRDY		BIT(0)
> > +
> > +#define BMP580_INT_CONFIG_MASK		GENMASK(3, 0)
> > +#define BMP580_INT_CONFIG_LATCH		BIT(0)
> > +#define BMP580_INT_CONFIG_LEVEL		BIT(1)
> > +#define BMP580_INT_CONFIG_OPEN_DRAIN	BIT(2)
> > +#define BMP580_INT_CONFIG_INT_EN	BIT(3)
> > +
> >  #define BMP580_STATUS_CORE_RDY_MASK	BIT(0)
> >  #define BMP580_STATUS_NVM_RDY_MASK	BIT(1)
> >  #define BMP580_STATUS_NVM_ERR_MASK	BIT(2)
> > @@ -117,7 +126,7 @@
> >  #define BMP380_REG_OSR			0x1C
> >  #define BMP380_REG_POWER_CONTROL	0x1B
> >  #define BMP380_REG_IF_CONFIG		0x1A
> > -#define BMP380_REG_INT_CONTROL		0x19
> > +#define BMP380_REG_INT_CTRL		0x19
> As above.
> 
> Jonathan
> 

Cheers,
Vasilis

