Return-Path: <linux-iio+bounces-11586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B469B588C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 01:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C55283BB5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 00:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941112E5D;
	Wed, 30 Oct 2024 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgMH5OhM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B50DDCD;
	Wed, 30 Oct 2024 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247878; cv=none; b=K/AVNyx2BJY1l/0JmFRCvBWDq1exVM0Svjc0RjPzw5KiSJcwUCRt04cVYoI+Nmv7suIfuBcPZaH6j4ckQzTRxwB+lFTp0zDFYTtFP+A3M6IdGyUCj+ihoJOxNtwL1lAxEJpUXenmwQKibEM4pXd7Jkgi+wVeziJqJvoUyr/HlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247878; c=relaxed/simple;
	bh=PrElOmEssvK26oznLQMInvfhKRnqn8lwkgHhxR6Go9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUB83UfBscmLut3NPR6AC626AUn7lQpUH0Va5WKaEzl+UyQX14/6DdLmFDacA/agCGYDWpgoD5rMgNm622iShcYOjqNv6s9/vVWXtZWMurjrEL8ZLui8xfU7jXUqShxXlyW0ob4RRqIT9bkoDVHiqCPhJjAI1tBMzqDN/S48Gws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgMH5OhM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ea294480so421785066b.2;
        Tue, 29 Oct 2024 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730247874; x=1730852674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZpksF7f/yfbrJdjziEbXmkVW9JxR3yvcKKkC3H24NQ=;
        b=KgMH5OhM5kgNTMd6uswwhWaEN3CgGO/VKLYaKgs6CWInhfKG3WVGEoWndA+8VOWHF9
         lXZRbN0lFsLd8yYteer3B5piPEW3I2fjUgMzR/tAkh9lJS7shbmZVxgvTzOcl9gxOJ2K
         xh8oSouj+oVhJyu86FenLO1qZplOCNn4NEpzv1K1pWV+F4bG8sWadZSjLf2glVO6Booe
         bYLke/00uhdb+plbJnCjpeNYAKOEr5wR38NiK0g8YlL7ZDqnPVFkWwCnfNSCbNlBVr74
         0jdcIrqGArYYQCFKLAgh6Ovzi4hDsU0CUHebPkb0ByT7DDyLp+5zncSxWpbFrS96hUgk
         iCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247874; x=1730852674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZpksF7f/yfbrJdjziEbXmkVW9JxR3yvcKKkC3H24NQ=;
        b=AW+4EzcrK9Cr6BHFOW+twHAxYwtPuzl+esDqnQaKzSEMu7TRCOoglq2Mjcv5M6HpC+
         edp/NcEYzcr1J+mA4ZV4k4FsXRs6A9Okl/lnh0CP3oB7uZFVrmFxT7nVqtU5BkHfwPM4
         nFYjiQmFOlJVyuMYiLIlpswpZ+pONHv+vSNHU+JV/kD+vgpuyBv9DMzMCLviC2JSjBeq
         TVuTp9e8oXimOBy/obEnGHGFthpAuow/jz1qju77rIOTWoMBMbojXP7Qbz1EGxGZzssf
         hYvn7DjbnfG+PheLZEyahqz9gGT80uO20TNW1/L2RrGOI+FoBm9632YOw15p5JdYYKOn
         x2/w==
X-Forwarded-Encrypted: i=1; AJvYcCU0U8xyWzZHY5/f8AQl2VQi1p3kaFTwunJEcN+kclRsRl6Yy0hBMJ/fPl4+6uL5xbwNp2B/BVH4rPeq@vger.kernel.org, AJvYcCWgnbL7cd9MI5SIndZSLd4Sob1b3SOVAX7X12oWsrFgcPExTh2u6GkVK2dUC0RqdNC3+k71FloFfnDr@vger.kernel.org, AJvYcCWq0LFTaRKQb4HQx5y0FBUE+vul9hFfCcUtspKA/qe+nOJMLC5gVjqNo+tQVUYLJfPiuWthn5HXAG7ssItR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bH4d4hkOrdIvhz8kfQpSDOnKKTYRalLGTrCE3xOyHup5QU1d
	pfaBaHlplNPoe9F2MuLmer0Ev/vL5NC4vyyoTPr4/zTgKU+ZO2yQlexy6A==
X-Google-Smtp-Source: AGHT+IEj5xqVmWcWQW4+UVsLcEMosfXnQ35TQdWIrCkiMIpaIqL+uVtw/O5bGLbqlp5wckOVIfX0AQ==
X-Received: by 2002:a05:6402:2345:b0:5ca:1598:15ad with SMTP id 4fb4d7f45d1cf-5cbbf8899ccmr12723651a12.3.1730247874289;
        Tue, 29 Oct 2024 17:24:34 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec81adsm519159366b.27.2024.10.29.17.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:24:33 -0700 (PDT)
Date: Wed, 30 Oct 2024 01:24:30 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] iio: chemical: bme680: add power management
Message-ID: <ZyF8vtLiVUEHojl4@vamoirid-laptop>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
 <20241021195316.58911-14-vassilisamir@gmail.com>
 <20241027103013.06daac42@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027103013.06daac42@jic23-huawei>

On Sun, Oct 27, 2024 at 10:30:13AM +0000, Jonathan Cameron wrote:
> On Mon, 21 Oct 2024 21:53:16 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Add runtime power management to the device. To facilitate this, add also
> > a struct dev* inside the bme680_data structure to have the device
> > accesible from the data structure.
> 
> Needs an update as you are now getting that from the regmap.
> 
> 

Hi Jonathan,

Thanks for noticing, I will fix it for next version.

> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/chemical/bme680.h      |   2 +
> >  drivers/iio/chemical/bme680_core.c | 126 +++++++++++++++++++++++++++--
> >  2 files changed, 121 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> > index e5d82a6d5b59..74e97e35e35a 100644
> > --- a/drivers/iio/chemical/bme680.h
> > +++ b/drivers/iio/chemical/bme680.h
> > @@ -2,6 +2,7 @@
> >  #ifndef BME680_H_
> >  #define BME680_H_
> >  
> > +#include <linux/pm.h>
> >  #include <linux/regmap.h>
> >  
> >  #define BME680_REG_CHIP_ID			0xD0
> > @@ -82,6 +83,7 @@
> >  #define BME680_CALIB_RANGE_3_LEN               5
> >  
> >  extern const struct regmap_config bme680_regmap_config;
> > +extern const struct dev_pm_ops bme680_dev_pm_ops;
> 
> You seem to have missed the changes that use this in the i2c and spi drivers.
> 
> 

You are totally right.

> >  static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
> >  
> >  static IIO_CONST_ATTR(oversampling_ratio_available,
> > @@ -1091,6 +1125,39 @@ static irqreturn_t bme680_trigger_handler(int irq, void *p)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > +static int bme680_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +
> > +	pm_runtime_get_sync(dev);
> > +	return 0;
> > +}
> > +
> > +static int bme680_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> > +	return 0;
> > +}
> > +
> > +static const struct iio_buffer_setup_ops bme680_buffer_setup_ops = {
> > +	.preenable = bme680_buffer_preenable,
> > +	.postdisable = bme680_buffer_postdisable,
> > +};
> > +
> > +static void bme680_pm_disable(void *data)
> > +{
> > +	struct device *dev = data;
> > +
> > +	pm_runtime_get_sync(dev);
> > +	pm_runtime_put_noidle(dev);
> This dance is to get the device powered up on runtime pm tear down
> I think?  Whilst we sometimes do this, why is it needed in this particular driver?
> 

Actually this one is not needed indeed, I was using it to test that the
device was coming up but it is not really needed. And the whole disable
sequence is perfectly handled by the devm_pm_runtime_enable so it is not
even needed at all actually.

> > +	pm_runtime_disable(dev);
> > +}
> > +
> >  int bme680_core_probe(struct device *dev, struct regmap *regmap,
> >  		      const char *name)
> >  {
> > @@ -1164,15 +1231,60 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
> >  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> >  					      iio_pollfunc_store_time,
> >  					      bme680_trigger_handler,
> > -					      NULL);
> > +					      &bme680_buffer_setup_ops);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret,
> >  				     "iio triggered buffer setup failed\n");
> >  
> > +	/* Enable runtime PM */
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US * 100);
> > +	pm_runtime_use_autosuspend(dev);
> > +	pm_runtime_set_active(dev);
> > +	ret = devm_pm_runtime_enable(dev);
> 
> Take a look at what this unwinds in the devm handler. You don't need to do
> as much (or possibly anything) yourself.
> 
> 

Well, in general what I see that could probably be dropped here is the
extra add_action_or_reset because of the devm_*. About the functions
get_noresume() and put(), I feel that they could be dropped as well
because the device registration will happen well before the autosuspend
delay, but does it make sense to depend on something like this?

Cheers,
Vasilis

> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_put(dev);
> > +
> > +	ret = devm_add_action_or_reset(dev, bme680_pm_disable, dev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	return devm_iio_device_register(dev, indio_dev);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(bme680_core_probe, IIO_BME680);
> >  
> > +static int bme680_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +
> > +	return regulator_bulk_disable(BME680_NUM_SUPPLIES, data->supplies);
> > +}
> > +
> > +static int bme680_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = regulator_bulk_enable(BME680_NUM_SUPPLIES, data->supplies);
> > +	if (ret)
> > +		return ret;
> > +
> > +	fsleep(BME680_STARTUP_TIME_US);
> > +
> > +	ret = bme680_chip_config(data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return bme680_gas_config(data);
> > +}
> > +
> > +EXPORT_RUNTIME_DEV_PM_OPS(bme680_dev_pm_ops, bme680_runtime_suspend,
> > +			  bme680_runtime_resume, NULL);
> > +
> >  MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> >  MODULE_DESCRIPTION("Bosch BME680 Driver");
> >  MODULE_LICENSE("GPL v2");
> 

