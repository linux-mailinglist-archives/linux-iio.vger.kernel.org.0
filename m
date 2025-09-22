Return-Path: <linux-iio+bounces-24352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD08DB92B6F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523FA16AD16
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E3A31A7EB;
	Mon, 22 Sep 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiuqbOlg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948C1FF7C5
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567695; cv=none; b=tRcHZuUzL3Lqz5FIdgo3cQl81T1LERsl/F5NIkbF6APssRPnMtsiwPT0sPfeR1TRiItQRx/AsQvj8ftqZP4w4ninEE/+G/RLRdIaXILnz0JP7w74cSIbA4+XJCgpqE1YLZb8kSci7i8jbzUh6kUwGeDsxdUtBgd1WjvA+j3P2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567695; c=relaxed/simple;
	bh=v+AauHexqbsx+kMHbhzLmDqnPPDd/nh8wvUhdAuAo2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O57IupfhG37QU1y6i7pNVzXw0oa4aHZ2VMNcSQl3HggavBBRR8+3QkZuKC+TpU1dxim+uzvIaURvG929HuooIejUJ2W2cxAse+Kqkplm4QwUbF3rxiI94Kw5DPmFDwngPicTM1hmoet+SyelLoRad7QGDf+kWyTZGVS3Ba8vhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiuqbOlg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so18638715e9.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758567692; x=1759172492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ig+SGte1YlJLE1MPKQYUa5gbYQHEaBms1N5501hGvqU=;
        b=RiuqbOlgfp42KZzQgkifQt7JEJM9wlyltLH9yXu9xaFMopger7qPMiJFAqRaTFMTjS
         E7HnHwnRshV/xxKaURjiI1SqhJxMnGCII7M5JUiY8TS/KLG9jEsJ6jsZ5drw2NeNHTYa
         fe8QIkYs/BTvz1St1dO55Fr0EY0XWg5nkbWnKY3WcpIKQ9AX/hyKKO26fRs/K4cn4XRG
         JIGGefH6CZNzbFi062h8HZbSqRD3OMlL4ZqKCQBYKcHG2F1s8CUH/6HGLRyaEZd60JRV
         0iZ/Shv28ppWLFLDC0MuOUxBg1Vj9ajDnb0Yfh4RjkLyHEWqxHLLEQBf8loeHU9ixEaj
         wM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758567692; x=1759172492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ig+SGte1YlJLE1MPKQYUa5gbYQHEaBms1N5501hGvqU=;
        b=qH5cCgG8eGb4Fe1fgGtJqJgzSxAyQhYKXNb3Iw8LKg/88wuWgxXkg8dpw5aC2/5z9w
         xw3VKFs6h7iaJNJw8mx2K6UbcAj7k9XUzSIfMZz2MRhECz1nGaVpd8wsWD7xmUCCfwxx
         3V3dK1K22SeYD2WBLbGVeaWND8adRbJsANEgdg8q9SalgBEEIckXrzn7NYDoroja+bpg
         lEPLi+FA+2pIHVufyUr3JHfEyjrJE+5M123dl7Th7ioaSYIfJztVsOenkgOHAomZ8GVB
         vtHgkmeYTjhFuUrJSIKjzkDlP8IZ4u48y3KESXNlCiZcED2DTqRsPDjxa4109Q/yjs+X
         CmmA==
X-Forwarded-Encrypted: i=1; AJvYcCVJnfRvNHpSIEORc1vYkQ93T2YvdFO40dcxNoH9oNBnutenjRV2bbswglmXImI9dIFdJmhCCJ6zyxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5q2WvTl5Oc0IFrEy4WIElqVXMrem+4uNbGylSo0gzlOVaLwWC
	tyQ6wdw2v+w0J/lDd4H1EnKEz0g8E+OGZWE/pf8r5csb+usNCVzzrtjH
X-Gm-Gg: ASbGncvWqStiADcIbmcP/vqYhNmPCvkuVQBpK8FFkwl3WjNcoI4Z6zCFIsPIp/d8ZJG
	ClnhHHpKh8Dzn0HUdDt6+qbacLNjYN1+fZVDxPuFIOQVzLhLz2lWJ9jqKVyZZdCUdpwhO+5j45U
	hVUaKvRE9PpEYjN5a/pVc9X8J6ONFNJTA8wGuELzWtYP/UStLnccjtZRq9VHrpeTv6hgEVlMzBd
	UOAqUg3IDRQW5lP68sNiO2sEx0+5QvXP2rDlfWmsVZAi+u6e11RTzk9pprIYPzDh4AMGv2f9jy+
	C0PXtlz5oCIfQjuwQyi0jhpMO0bGqpG44/5+V/c51Ejna9CdDS0yrBhJt44J43COhau0S8v1oY/
	hhTkrBMoJFdEXlxjI8UGMyNFXJfqb6gd0SUtIvaYE6OUt0Ala+K9JrYOoWmXrTRVhHU8=
X-Google-Smtp-Source: AGHT+IEk5XBqJgHzPIl46kgroy3/wNhJN7w0G9fck0gvkY8FvZdMAEzr6qKdAfpmL8ZbDrvtXCU1dw==
X-Received: by 2002:a05:600c:350d:b0:45c:b6b1:29a7 with SMTP id 5b1f17b1804b1-46e1d98bf58mr151975e9.16.1758567691635;
        Mon, 22 Sep 2025 12:01:31 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([37.163.188.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad359sm244439725e9.22.2025.09.22.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:01:31 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:01:13 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com, naresh.solanki@9elements.com,
	michal.simek@amd.com, grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH 2/3] iio: mpl3115: add support for DRDY interrupt
Message-ID: <20250922190113.xjqujtts7uu4cucg@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250921133327.123726-1-apokusinski01@gmail.com>
 <20250921133327.123726-3-apokusinski01@gmail.com>
 <CAHp75Vd8Bwk8HVc3DhG4L=SgbSh3aFTQ2VRn7Tri8YhJrqaXgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd8Bwk8HVc3DhG4L=SgbSh3aFTQ2VRn7Tri8YhJrqaXgw@mail.gmail.com>

On Sun, Sep 21, 2025 at 10:29:28PM +0300, Andy Shevchenko wrote:
> On Sun, Sep 21, 2025 at 4:34 PM Antoni Pokusinski
> <apokusinski01@gmail.com> wrote:
> >
> > MPL3115 sensor features a "data ready" interrupt which indicates the
> > presence of new measurements.
> 
> ...
> 
> >  #include <linux/module.h>
> 
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger.h>
> >  #include <linux/delay.h>
> 
> > +#include <linux/property.h>
> 
> This is like delay.h is misplaced. What we do here, we group generic
> ones followed by subsystem (IIO) related ones, and this seems wrong in
> this driver.
> 
> Can you rather move delay.h to be the first, and add property.h after
> i2c.h followed by a blank line, so in the result it will be like
> 
> delay.h
> i2c.h
> module.h
> property.h
> ...blank.line...
> iio/*.h
> 
> ...
> 
Sure, will fix this in v2.

> > +#define MPL3115_CTRL_INT_SRC_DRDY BIT(7)
> > +
> > +#define MPL3115_PT_DATA_EVENT_ALL (BIT(2) | BIT(1) | BIT(0))
> 
> Not sure I understand this definition in the following aspects:
> 1) why is this disrupting the _CTRL_ definitions?
> 2) why is this using BIT(x) and not respective definitions?
> 3) why can't you use GENMASK() if you just select all bits in a
> certain bitfield?
> 
> 
1) I placed the definitions of the bits/masks in the order of the registers
that they correspond to, i.e.
  CTRL_INT_SRC_DRDY // bit in reg 0x12
  PT_DATA_EVENT_ALL // bits in reg 0x13
  CTRL_RESET        // bit in reg 0x14

Actually, the wrong name here is the INT_SRC_DRDY definition because it is a
bit in the INT_SOURCE register, not a control register. Therefore, the
name should be MPL3115_INT_SRC_DRDY instead of MPL3115_CTRL_INT_SRC_DRDY

2) I saw that e.g. CTRL_OS_258MS is defined using BIT(x), so I thought
that this is the convention in this driver that I did not want to
disrupt by using GENMASK()

3) Sure, I'd even prefer GENMASK(), the only reason why I didn't use it
is explained in 2)

> >  #define MPL3115_CTRL_RESET BIT(2) /* software reset */
> >  #define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
> >  #define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
> >  #define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
> 
> ...
> 
> >         mutex_lock(&data->lock);
> > -       ret = mpl3115_request(data);
> > -       if (ret < 0) {
> > -               mutex_unlock(&data->lock);
> > -               goto done;
> > +       if (!(data->ctrl_reg1 & MPL3115_CTRL_ACTIVE)) {
> > +               ret = mpl3115_request(data);
> > +               if (ret < 0) {
> 
> > +                       mutex_unlock(&data->lock);
> 
> Instead, I suggest adding a prerequisite that moves the driver to use
> cleanup.h, in particular scoped_guard(). This will reduce a churn
> here,
>
Will add in v2.
> > +                       goto done;
> > +               }
> >         }
> 
> ...
> 
> > +static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
> > +{
> > +       struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +       struct mpl3115_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +       u8 ctrl_reg1 = data->ctrl_reg1;
> > +
> > +       if (state)
> > +               ctrl_reg1 |= MPL3115_CTRL_ACTIVE;
> > +       else
> > +               ctrl_reg1 &= ~MPL3115_CTRL_ACTIVE;
> 
> > +       guard(mutex)(&data->lock);
> 
> Oh, and you already use this! Definitely, it misses the prerequisite patch.
> 
> > +       ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > +                                       ctrl_reg1);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
> > +                                       state ? MPL3115_CTRL_INT_EN_DRDY : 0);
> > +       if (ret < 0)
> > +               goto reg1_cleanup;
> > +
> > +       data->ctrl_reg1 = ctrl_reg1;
> > +
> > +       return 0;
> > +
> > +reg1_cleanup:
> > +       i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > +                                 data->ctrl_reg1);
> > +       return ret;
> > +}
> 
> ...
> 
> > +static int mpl3115_trigger_probe(struct mpl3115_data *data,
> > +                                struct iio_dev *indio_dev)
> > +{
> > +       struct fwnode_handle *fwnode;
> > +       int ret, irq, irq_type;
> > +       bool act_high, is_int2 = false;
> 
> > +       fwnode = dev_fwnode(&data->client->dev);
> > +       if (!fwnode)
> > +               return -ENODEV;
> 
> 
> Why is this fatal? Also, do we have a board file for users of this right now?
> 
Actually it seems it does not have to be fatal. If we get rid of this
if, then we'd simply return without setting up the trigger and with no
interrupt support, which is ok I guess.

As for the board file, do you mean some PCB schematics? I don't know
about any, I've only used the following datasheet from NXP:
https://www.nxp.com/docs/en/data-sheet/MPL3115A2S.pdf

> > +       irq = fwnode_irq_get_byname(fwnode, "INT1");
> > +       if (irq < 0) {
> > +               irq = fwnode_irq_get_byname(fwnode, "INT2");
> > +               if (irq < 0)
> > +                       return 0;
> > +
> > +               is_int2 = true;
> > +       }
> > +
> > +       irq_type = irq_get_trigger_type(irq);
> > +       switch (irq_type) {
> > +       case IRQF_TRIGGER_RISING:
> > +               act_high = true;
> > +               break;
> > +       case IRQF_TRIGGER_FALLING:
> > +               act_high = false;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_CFG,
> > +                                       MPL3115_PT_DATA_EVENT_ALL);
> > +       if (ret < 0)
> > +               return ret;
> 
> > +       if (!is_int2) {
> > +               ret = i2c_smbus_write_byte_data(data->client,
> > +                                               MPL3115_CTRL_REG5,
> > +                                               MPL3115_CTRL_INT_CFG_DRDY);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +       if (act_high) {
> > +               ret = i2c_smbus_write_byte_data(data->client,
> > +                                               MPL3115_CTRL_REG3,
> > +                                               is_int2 ? MPL3115_CTRL_IPOL2 :
> > +                                                         MPL3115_CTRL_IPOL1);
> > +               if (ret)
> > +                       return ret;
> > +       }
> 
> This if (!is_int2) and ternary with the same argument is kinda hard to
> read, can we refactor it somehow?
> 
> For example, if these two booleans are represented by a common enum, we can do
> 
> switch (cfg_flags) {
> case INT2_ACTIVE_HIGH:
>     _write_byte_data(REG3);
>     break;
> case INT2_ACTIVE_LOW:
>     break;
> case INT1_ACTIVE_HIGH:
>    _write_byte_data(REG5);
>    _write_byte_data(REG3);
>   break;
> case INT1_ACTIVE_LOW:
>    _write_byte_data(REG5);
>    break;
> default:
>     return -EINVAL;
> }
> 
> Yes, it's more verbose, but I find this better to read and understand.
> 
> Note, you may drop the switch case for IRQ with this approach as you
> can use a few bits together (separate bits for raising and falling to
> make the default case working here).
> 
Ok, your suggestion looks nice. I think to define maybe the enums like this:

  #define INT2 BIT(2) 
  enum {
    INT2_ACTIVE_LOW = INT2 | IRQF_TRIGGER_FALLING,
    INT2_ACTIVE_HIGH = INT2 | IRQF_TRIGGER_RISING,
    INT1_ACTIVE_LOW = !INT2 | IRQF_TRIGGER_FALLING,
    INT1_ACTIVE_HIGH = !INT2 | IRQF_TRIGGER_RISING, 
  };

This way the cfg_flags could be first |= INT_2 (after the call to the
fwnode_irq_get_byname) and then |= irq_type (after the call to the irq_get_trigger_type)

> > +       data->drdy_trig = devm_iio_trigger_alloc(&data->client->dev,
> > +                                                "%s-dev%d",
> > +                                                indio_dev->name,
> > +                                                iio_device_id(indio_dev));
> > +       if (!data->drdy_trig)
> > +               return -ENOMEM;
> > +
> > +       data->drdy_trig->ops = &mpl3115_trigger_ops;
> > +       iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> > +       ret = iio_trigger_register(data->drdy_trig);
> > +       if (ret)
> > +               return ret;
> > +
> > +       indio_dev->trig = iio_trigger_get(data->drdy_trig);
> > +
> > +       return devm_request_threaded_irq(&data->client->dev, irq,
> > +                                        NULL,
> > +                                        mpl3115_interrupt_handler,
> > +                                        IRQF_ONESHOT,
> > +                                        "mpl3115_irq",
> > +                                        indio_dev);
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Kind regards,
Antoni Pokusinski

