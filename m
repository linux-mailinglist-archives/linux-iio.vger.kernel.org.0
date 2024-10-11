Return-Path: <linux-iio+bounces-10475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E080E99AC5A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 21:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B57A28B961
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 19:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D51D0B96;
	Fri, 11 Oct 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU90VaFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F01D048C;
	Fri, 11 Oct 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673358; cv=none; b=plAqRXYlV9NVEJRP1H1NxWGDBjokr+sRCEtmYBGal8hQef/21gx1+Lyh3OQNvN0Avtht4Cg1UPDeqt91Jrc3HchPZyhwInqOA0T1fW+t7atTBPCnIACZQZATsA3WvWW6A3UJhhGj0gCPtsD9nNpCPZrhUkU4lRSJJWKU2+WVjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673358; c=relaxed/simple;
	bh=dwaO0PvTehoiSwlksKhTfqD+2fRrUnaNNJ7a0trqA3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We+xe7+NT04x7BM6/bidvcCZxn1NJEliXjLwwoPBz7QfKTEjwqXQ1UshrmgQjQm8kv5+StOswCtACF0Er0XM+O7E/llNuAycrPKiAcHvKHTlhuGSn1mJa+GxMtwwjb26Q228YgZDAzRK/BKFKoiVxUEeSKQ0RHIJqfZ+e4Z/jeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU90VaFv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d47eff9acso1278783f8f.3;
        Fri, 11 Oct 2024 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728673355; x=1729278155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/kVOmo9BqoY88B3lT5nnLLFJ6x+62zTyz4jnujbEDQ=;
        b=GU90VaFvTVTMR3xRJkZ/Zh1BiHaOMe9loLVOE01e8C2UM448nmTDj/b/3nMgdVQt7O
         IYxpbSyWbnL8onyUBueZSvEQd1I2owx339nQqjPSB7lm+r1UFa4jmHzfW7LMtLHg1Mpv
         NoMxuwxHIqorHMPGqyBi68WDJCI1DQXczWTpID5y2dzvz7JWaTR3OvCEEsx6nS2VcXn5
         6gHgLTrvHBkbs5vcRhmz1RA7P284V1ng4AoiebcgUXZpFRVyBchmZFetTxJjbB10zIJt
         2aVNVh4sZEfG7BnsgVR4J5LQ96ozAlrRQZEfA4OnzLdQ1kMGywfl6iadxUO7K+FqLr1L
         xMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728673355; x=1729278155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/kVOmo9BqoY88B3lT5nnLLFJ6x+62zTyz4jnujbEDQ=;
        b=pYuS584F43zBIaRihrUGRDPsvtjq3B3Qr8LXP/R7jbaoAEjajJhnl5d/Fo6D2IaL0a
         HhR1eS13q4zUqc3oSgL3/wXVby6wdeq2EidlExm1dd3qvDlB7LnikHmTNwXNf2BhiUUQ
         t1CYjd2H8IxB77VNrutUEW6lgXUG2tUF1/Ad7W+ebQucrBT/EytSMjaDoAin+mj0rPmj
         FmOEFemjJ+hZswwWMfxDE2xGiG7gvmfP+eSbYdG3bo329feeGpUUsNFqr1mht9ak6MFD
         VCSay0nugYU44cwmTZh5WK1J6ZlhkDYZfNcoEwfCgfUTvOjtOwSIWGqx2K700t34xf2I
         q7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8oVQ2RKxS7KdzK/4yQwrWKlEg8JuO3CP7S3HDKgkdX3cSFF5JXLs5y2lk/8AnycfECezMZAh9Ro3W@vger.kernel.org, AJvYcCVsGRUsT/an/BB6tZuvbbhO7iDnz9r5Ye32wAe5NTYFpRCN42cCIr2EV4LPs6edBjyOGrf37ftp7c0BCI7C@vger.kernel.org, AJvYcCXIpxPCdt8HH1ZiQNi0TA+7WcAD6DI0SJcgJi0K1GDbV5wdsqFTRBRgnKikxkL2OaAR1cYDpQhiPkCA@vger.kernel.org
X-Gm-Message-State: AOJu0YyVEuiJctYm828XglCvG93+5c8GCxrZchsFo3GSoFz5TbR/SbzI
	cI8g5fhxp+vuZvmkE7CFvLEzoiXtjnyHoGF9/W5Q+9VkodlV2TCl
X-Google-Smtp-Source: AGHT+IHUj2oVsncH/qIJKzxS3lwpcbXodpmZOU/4cWfVLqd8rmb31c3vvMckki/2cFXoIe5WQqhNhg==
X-Received: by 2002:a05:6000:118c:b0:37d:2ceb:ef92 with SMTP id ffacd0b85a97d-37d5fedbb12mr454693f8f.27.1728673355108;
        Fri, 11 Oct 2024 12:02:35 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd3e7sm4535930f8f.39.2024.10.11.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:02:34 -0700 (PDT)
Date: Fri, 11 Oct 2024 21:02:32 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/13] iio: chemical: bme680: add power management
Message-ID: <Zwl2SEmDqc-PTtqp@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-9-vassilisamir@gmail.com>
 <Zwj5jBm-_9_FX6ms@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwj5jBm-_9_FX6ms@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:10:20PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:25PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Add runtime power management to the device. To facilitate this, add also
> > a struct dev * inside the bme680_data structure to have the device
> > accesible from the data structure.
> 
> ...
> 
> > --- a/drivers/iio/chemical/bme680.h
> > +++ b/drivers/iio/chemical/bme680.h
> > @@ -75,6 +75,7 @@
> >  #define BME680_CALIB_RANGE_3_LEN               5
> >  
> >  extern const struct regmap_config bme680_regmap_config;
> > +extern const struct dev_pm_ops bmp280_dev_pm_ops;
> 
> Is pm.h being included already in this header? Otherwise you need to add it.
>

No it is not, and indeed I need to add it. Probably because it was
included by some other file I didn't get an error from gcc?

> ...
> 
> >  	struct regmap *regmap;
> >  	struct bme680_calib bme680;
> >  	struct mutex lock; /* Protect multiple serial R/W ops to device. */
> > +	struct device *dev;
> 
> Is it the same that you may get wia regmap_get_device()?
> 

Yes it is the same. Maybe I can try and see if I can use the following

	regmap_get_device(data->regmap)

in the places where the pm functions are used in order to not declare a
new value inside the struct bme680_data. But in general, is this approach
prefered?

> >  	u8 oversampling_temp;
> >  	u8 oversampling_press;
> >  	u8 oversampling_humid;
> 
> ...
> 
> > +	/* Enable runtime PM */
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US * 100);
> > +	pm_runtime_use_autosuspend(dev);
> > +	pm_runtime_put(dev);
> 
> Can we use devm_pm_runtime_enable() for some of the above?
>

I will have to check its use, and I will let you know.

> > +	ret = devm_add_action_or_reset(dev, bme680_pm_disable, dev);
> > +	if (ret)
> > +		return ret;
> 
> ...
> 
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
> 
> > +	ret = bme680_gas_config(data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> 	return bme680_gas_config(...);
> 

Indeed, much cleaner, thanks!

> > +}
> 
> ...
> 
> > +EXPORT_RUNTIME_DEV_PM_OPS(bme680_dev_pm_ops, bme680_runtime_suspend,
> > +			  bme680_runtime_resume, NULL);
> 
> You also need pm.h for the macro IIRC.
> 

ACK.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Cheers,
Vasilis

