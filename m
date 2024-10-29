Return-Path: <linux-iio+bounces-11585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA809B56EC
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 00:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D289B22C9D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FE20C022;
	Tue, 29 Oct 2024 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ7Rsd6b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F920ADDC;
	Tue, 29 Oct 2024 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244489; cv=none; b=jCNnV2m26FI6x5NJUaDcXFkCfVZi09OVBLlaGIKWG6qLNmDOTrMF/NG6bdnEp0WLKzPG+KYG6pk1JW6eaAO1DDa3GBu67RiBxvn68aCz1EJ1xxaC6t1TjRg9Nch6V50iVlugAZ8w9TqVpiP2ba8uQyRgNpJOLVYe7HC7pWoRDcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244489; c=relaxed/simple;
	bh=dJ360g6wR0oB3al1wCLc2vvKC50BXvkFxNqeLxsxMOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1NyXWJJL2NiU0sX3oErBeZAWo/THCDdn7fYaGmrtBhrG/ZHDhuJCkDrzPqtvmEKidn+Idf7viSVn0F3CMgxBR6/UFSZWEn15ooJ6K6i2gqsZyiwNcT3c9nbyA/8yVt46/4elNTofOVSl328to1go5ameet7JCxj7toLYCeCAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ7Rsd6b; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so941078166b.0;
        Tue, 29 Oct 2024 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730244486; x=1730849286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzIxLUOYaE3vMGtIdY0G5UqFA4HTz9FjS4uuJtpOC/0=;
        b=RZ7Rsd6bWQWwjoE2D2MUPtt6Rsx9uK0uS12zjpvMQ3jexbsObB5ZYN54HzWM7A8xOr
         f1zyUuB4TislhLq91ASrqCnCpAzHbuz1hLZ8CBNCoFgOPAgnq/hXQtZhD20qDKqFMdrI
         wxQ1oY2qJ/2iWcYRizZffeR0mHoLs+lHH/7/m0TTuM3RO8TI5qQaoQ7LWGCiYRu0/c5O
         fBS8LwobKz9DRSH+iPUGLh78C6z9ugw5hAAmNIv4XS8CUlDVYKVU3xeTxVs99FNnRDgO
         PEdbPDzqZKbeH4c/3PtBlDO5wnyJYwIpCkKv2vXTGKjefxEI8MPe8NpuCcqhJ7kvk1v3
         5oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244486; x=1730849286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzIxLUOYaE3vMGtIdY0G5UqFA4HTz9FjS4uuJtpOC/0=;
        b=TjxodcvW7Bpj6pgkxNsHkdPcWRnKJv3Epoo8HDTlPOb322cAC8v9bLhHFzVnP0Dp0M
         1Ef3L9kenN0Dh13h/R2vcyagTuYBrXKAEq9cx78SWJeOCpLBs8o/RNYO017tdX/Rwy/7
         M6EVYijdkNaw/XhI+KouKzYImHeg/M6FoHq4E7UirELp6IldWq8TTypEch5rdgGezqLD
         QXboN6oMLN8+Jkm8BMJcnTRjTf7UMwKcS9pEP2g+rEVJktHjSzituke7USKgdoA0nOS/
         NQcmAihRd0xCKiVkFWv6E+SujCBJHL2GAMNJiokJCHHnm3NYMXJN5Z+zWHx3MV5j5V0U
         5uow==
X-Forwarded-Encrypted: i=1; AJvYcCUBoTzL8oT+A8WwFKAxkw6dbmWVpaQdYPC5ohrJ60gT8z5CVW0evLRGNgr20JRl6Dcy+/TR9OvquynK@vger.kernel.org, AJvYcCV7f9vEdOrxa+bPwPwAPHJ6jms/vVEJCujrywgCbsUmLBYmPtuwvtbg+a92lAs+Nvs52mtI//IKe54UaH6f@vger.kernel.org, AJvYcCWAk2SocXC8bMuf++r37QocolmG5cRMwF6Mi27tkyMwLGjvUcT0rrdGtv7ieiRxB24CbdwRPwfDgeUe@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7R+NBZpv0UvptWdXKIWLeyjtr9XlA/Q0G0wP6ir7xse+OFe8
	BPeqjl9AKfLnJJkXrryCwVCC4fBKpYZR3l67hzxiWCmjTawfa9Wp
X-Google-Smtp-Source: AGHT+IENOuf55S7BPSy+6UBBkR0PUVAFo5/qztlIUA5f3Xh/wyAfuDl0DXdRgwTzNReTidfTZkKNSA==
X-Received: by 2002:a17:907:7289:b0:a99:fa4e:ba97 with SMTP id a640c23a62f3a-a9de5ff9192mr1243038566b.39.1730244485596;
        Tue, 29 Oct 2024 16:28:05 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2982e1sm517969166b.99.2024.10.29.16.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:28:05 -0700 (PDT)
Date: Wed, 30 Oct 2024 00:28:03 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] iio: chemical: bme680: refactorize set_mode()
 mode
Message-ID: <ZyFvg5JyA2IJp4v0@vamoirid-laptop>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
 <20241021195316.58911-5-vassilisamir@gmail.com>
 <20241027095939.5ad376ad@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027095939.5ad376ad@jic23-huawei>

On Sun, Oct 27, 2024 at 09:59:39AM +0000, Jonathan Cameron wrote:
> On Mon, 21 Oct 2024 21:53:07 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Refactorize the set_mode() function to use an external enum that
> > describes the possible modes of the BME680 device instead of using
> > true/false variables for selecting SLEEPING/FORCED mode.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> I changed my mind on this one...
> 
> > ---
> >  drivers/iio/chemical/bme680_core.c | 30 +++++++++++++-----------------
> >  1 file changed, 13 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index d228f90b4dc6..9002519d2c33 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> > @@ -95,6 +95,11 @@ struct bme680_calib {
> >  	s8  range_sw_err;
> >  };
> >  
> > +enum bme680_op_mode {
> > +	BME680_SLEEP,
> > +	BME680_FORCED,
> Use this enum to replace the existing BME680_MODE_SLEEP etc definitions
> rather than adding another one.
> Also assign explicit values as you are going to write this into a register
> so they matter.
> 
> 

Hi Jonathan,

Thank you very much once again for the review! I totally understand what
you mean and I will fix it for next version.

Cheers,
Vasilis

> > +};
> > +
> >  struct bme680_data {
> >  	struct regmap *regmap;
> >  	struct bme680_calib bme680;
> > @@ -502,23 +507,16 @@ static u8 bme680_calc_heater_dur(u16 dur)
> >  	return durval;
> >  }
> >  
> > -static int bme680_set_mode(struct bme680_data *data, bool mode)
> > +static int bme680_set_mode(struct bme680_data *data, enum bme680_op_mode mode)
> >  {
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  	int ret;
> >  
> > -	if (mode) {
> > -		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> > -					BME680_MODE_MASK, BME680_MODE_FORCED);
> > -		if (ret < 0)
> > -			dev_err(dev, "failed to set forced mode\n");
> > -
> > -	} else {
> > -		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> > -					BME680_MODE_MASK, BME680_MODE_SLEEP);
> > -		if (ret < 0)
> > -			dev_err(dev, "failed to set sleep mode\n");
> > -
> > +	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> > +				BME680_MODE_MASK, mode);
> This is the problematic code.  No obvious reason the enum should match the original
> values. It does, but that should be made true by only having an enum, not definitions
> and an enum.
> 
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to set ctrl_meas register\n");
> > +		return ret;
> >  	}
> >  
> >  	return ret;
> > @@ -615,8 +613,7 @@ static int bme680_gas_config(struct bme680_data *data)
> >  	int ret;
> >  	u8 heatr_res, heatr_dur;
> >  
> > -	/* Go to sleep */
> > -	ret = bme680_set_mode(data, false);
> > +	ret = bme680_set_mode(data, BME680_SLEEP);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -756,8 +753,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
> >  
> >  	guard(mutex)(&data->lock);
> >  
> > -	/* set forced mode to trigger measurement */
> > -	ret = bme680_set_mode(data, true);
> > +	ret = bme680_set_mode(data, BME680_FORCED);
> >  	if (ret < 0)
> >  		return ret;
> >  
> 

