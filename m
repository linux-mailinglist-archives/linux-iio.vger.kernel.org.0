Return-Path: <linux-iio+bounces-8883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42472964E49
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 21:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95B0B20EA4
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C11B86D2;
	Thu, 29 Aug 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LolUGmzR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE31B78FB;
	Thu, 29 Aug 2024 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958017; cv=none; b=MRj7EnAhVhCAXOiLFsP4mm3y99GmDGjX9KNh6JdMmKSX+cw2N0tEfbQqHG2xXSLEBKxlruIDF5HstxvDdZE3mIvH53ymKnpHCISyCVWDEHku/6sMgH187sX+yspwqN8jOjabHwFV7SjQw27dgAOHWDu3kC68L7cixxN+fncIr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958017; c=relaxed/simple;
	bh=7+ggEBBhu/QOeMtFqgg3a1o5eP6Nzl6/6KHyT9M9FXg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqJaRQACYqDUe6SrXkK4H4AoBVnp07ebEfhG9d8Ogrwa9UYIgGCBn08xSuB5SaNW/MgU6bLEuI32HEdvfrPUwgG+Xz4OUG5iLXLlAz8gyw7oKb0Ol2y1aroa6xcuCVj5HOBx8/z+4RnqElTwIVlVvWZGilhouW3+X2GQPluRcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LolUGmzR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c218866849so1254275a12.0;
        Thu, 29 Aug 2024 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724958007; x=1725562807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWjSA8ItuPZiWtr0SUiMPcq0+G3JZcX9bYjSkUjh5xA=;
        b=LolUGmzRX0m0DflAD3e8whnvWeaWIK83APRrriiA1bPeGOwwaOXd7aepFOKjg4rSaf
         SU0FhUNQBJHLHrnjHx7XwavtUOm0MPn8IKbuyjt3vLnTrSAWxhUBJchFCOXkD24a4cCQ
         q0RbNBpSvk7DGfFdIWainB3E+EK0R2wQPZSX5HXIKP/LlMqHZtd0CndvPid+gvOkyWJZ
         jJzhFXYGiJwLPRauhF92/ReaaqUTP0lZ//SYgdiB9tMEjC0NsGC7nP0Z3j9sApmRzkgB
         FBVCbFwMweIUKwnpUG7FrCeyGoHguh8xVfXeSId5ub5jzrYb4zvx0Et4D8zi+TgbGYIS
         wjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958007; x=1725562807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWjSA8ItuPZiWtr0SUiMPcq0+G3JZcX9bYjSkUjh5xA=;
        b=dd6alGFWF2RypxwnZ9rwb/dJlIJoXXah0ZcGnEYZklvMIVJJSCNGhXmXFU+mXG28IY
         FniT5ZlCDMyuZwbiYdarM5DWA3qma4T3sqBefC9v50IDudW04WCfROT1CsKTKZExl+qM
         F5y7+LR+rwJo83FKqrrF3l/B+xdgXRHD8ysnj5zkl1b8N4Uos/q0y/Ca+yx9L7UPVRK+
         BqNoMO1TD62Fkg+W6S4OQeT3MrC2aWhP6KAkMOJD5g1lVhA6vd8dq9oMnwpeapXV+1tG
         55O5NVHDTIZ4T1ujEzOmDUX2pbaJPPOG7+EMPbYC5D0pzbpk3oY8GnBUp06TcCgHI1Ig
         BjCA==
X-Forwarded-Encrypted: i=1; AJvYcCUqIradrjF8UTAcaeL8Oa2ua20Zz1ELOzqCqfkbD6h6W2l17HkStpJKiiDdS9e5rnixiovdthtQQlnIl62k@vger.kernel.org, AJvYcCWt6m4EPIfQqFZUYEgRc7Su/ByO0dv79cPTWdgSadnkU1KbIfbC7r4NYxr9k49WWWtETev18zLPXCHE@vger.kernel.org, AJvYcCXypMX3vIZRCnAKdNaHwhJBmRwW0+y/2zfzZmo5Tw12J6WEK4pkIXwimRq4aHDZUE09JlnSFiYz3lnb@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyHZCQcPT8X0HWYBEyD6lHnhKjheUj/NKs/yKOyi0BTblgvIc
	iEMXK1Z1kKF2IC4YahNaY24LkaA4d4g6SCzxuRTCazUXvCNIsN+l
X-Google-Smtp-Source: AGHT+IFzdSMMmgYmIXTsEkQkhQi7hdRa5zgJXxur9UtcDHL5X8La5hlmG3ZeJOJ62BWRSKZ6MoBypg==
X-Received: by 2002:a17:906:f589:b0:a86:9d14:dbb8 with SMTP id a640c23a62f3a-a897f77fd62mr350472666b.6.1724958006851;
        Thu, 29 Aug 2024 12:00:06 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:f22f:934f:9b88:e7ce])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898904c70asm111122466b.90.2024.08.29.12.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:00:06 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 29 Aug 2024 21:00:04 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <20240829190004.GB3493@vamoiridPC>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-3-vassilisamir@gmail.com>
 <ZtBlLqLgpi2h6kMl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBlLqLgpi2h6kMl@smile.fi.intel.com>

On Thu, Aug 29, 2024 at 03:10:22PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 10:51:22PM +0200, Vasileios Amoiridis wrote:
> > The BM(P/E)28x devices have an option for soft reset which is also
> > recommended by the Bosch Sensortech BME2 Sensor API to be used before the
> > initial configuration of the device.
> 
> ...
> 
> > +static int bmp280_preinit(struct bmp280_data *data)
> > +{
> 
> With
> 
> 	struct device *dev = data->dev;
> 
> it will look better?
> 

Yes, that could be used.

> > +	unsigned int reg;
> > +	int ret;
> 
> > +	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
> > +	if (ret)
> 
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Failed to reset device.\n");
> 
> 		return dev_err_probe(dev, ret, "Failed to reset device.\n");
> 

ACK.

> > +	/*
> > +	 * According to the datasheet in Chapter 1: Specification, Table 2,
> > +	 * after resetting, the device uses the complete power-on sequence so
> > +	 * it needs to wait for the defined start-up time.
> > +	 */
> > +	fsleep(data->start_up_time);
> > +
> > +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> > +	if (ret)
> 
> > +		return dev_err_probe(data->dev, ret,
> > +				     "Failed to read status register.\n");
> 
> 		return dev_err_probe(dev, ret, "Failed to read status register.\n");
> 

ACK.

> > +	if (reg & BMP280_REG_STATUS_IM_UPDATE)
> 
> > +		return dev_err_probe(data->dev, -EIO,
> > +				     "Failed to copy NVM contents.\n");
> 
> 		return dev_err_probe(dev, -EIO, "Failed to copy NVM contents.\n");
> 

ACK.

> > +	return 0;
> > +}
> 
> Yes, it's up to 84 characters long, but I think it improves readability.
> 

In all the previous cases though, shouldn't checkpatch.pl generate errors?
I didn't notice that they were below 80 chars and I never checked more
because checkpatch.pl didn't say anything...

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

