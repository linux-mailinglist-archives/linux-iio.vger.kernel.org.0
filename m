Return-Path: <linux-iio+bounces-25634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D7C1D9C6
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 23:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622CD4209D1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8812D593E;
	Wed, 29 Oct 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT0/J04D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D82773CA
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777992; cv=none; b=FFpgF39GR7zAQvnYPw75oyjbQPZc4dNbrstO5IFWWLYOmGJjAL00k46UX7TAwWB4gNJP7EYHtOMeeUrUvKwHxRzMV1LozOTedFj8Mest3oMOkBmn5JX7CUaCnMZqxrqrNEoHb444NrrQxeYcXStkSn0rT7OPx+tgqN/QvWNeit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777992; c=relaxed/simple;
	bh=jOXVNBp21d6LAP5gElhEiaLtnhLBJdjWja+P/lcNTeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0I/1L4j5T91GNHNSNGlW2lT9FqCxfIQaCPbYgofjKJ0VL1EzWO5n+uKcFsDbKkY77fP5VhVOHRSVQqhuiZvKZ9N6hyFjfSsXP/xWs+cjIzxVCLprKnWVD9QUh04UJJWB7TNhB5xsnxk5RewHO1+P1HpbMMhHB3dg9XmBUPJnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT0/J04D; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4270491e9easo326785f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761777988; x=1762382788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VF8ZKyr3ZTfy82XIYaeDjMzSL78nhQTOJhUiruXf8W8=;
        b=JT0/J04DLuTvaWhYLbDM862nK1dVcEkWH/ZBtg+HhEnIb+bOB62+SXmw/DBKyYErtl
         sTF/u/I0ImB9djBv3bUNZBeEvXRW3szJWJjGJLEQMAlNCsksdrZgn2M0dqr1rxCwocS/
         BW2nT94K+TalZlwFQYu5N3g4w5TU2KP6JfkinjSy7GgD4dQVu0OT4iH7D1S/+KvmG+F4
         awY3Gd3nrmsJDRxNhTecBgje+31q7WZdN0l8NYHC4lQLq8OC1f7AuWaF7yyzR4GGoz/5
         egz1iktqzDPA60C6gAKjkCnX05MSX/MVgx5MjLGaYRnjdrFA4p7/kS0wLTEH2m786iRu
         0axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761777988; x=1762382788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF8ZKyr3ZTfy82XIYaeDjMzSL78nhQTOJhUiruXf8W8=;
        b=Q5SkN/ezKtm/D6N2Ef7yJuwcIxOr8AAZXKX7l84r6b4UHfuvQ3O5F0t/eduAv6Ak91
         dbkOEWDiYV9HRVzV03fZLm0ZD+L/tCwCQ1tEKh0hpq4Rwn6QKR7S/yYFVwZl4e5/mV1f
         KCzD5sPe0bvoVLPZNT+q7PUEmKNFfcgK/qtAaNYulQLt486NpZdyxB/B3lE8+dBghiDl
         SFMSnXZhxEt5FMzHFSiWsYhzgfLvhV49DYp40jFoazB8GPFqSvUcpqUKpAKw+WD2c5mo
         2Dc86A+ByOCOemcUgjDZotinVjxgeuIzfSb/msan87y/th/wxr+RMsLy9+JgURhq69FI
         fYeQ==
X-Gm-Message-State: AOJu0YxDWFsE0DVbcEU3Fo9VKD8kDrYuFskehJEfu/wS4gMJ07RDbbKM
	1BYn4mUYZLMUzEaQRTbU2lrRqMCIwBYt3XDSxzeL9C8qWObAmeterc4m
X-Gm-Gg: ASbGncs1vpJy3yd24qYRvEVpKVHb28D2wPruMhjYapVg9vSf/2QZqg8/av/bkcwd2Fn
	Bk6U/RwEAg8QDVwzQo4T76JNV2G0yDyBIlBL7pJ21z3rTcfT3Cz7XLn88LHxyNp7+FgoI4SNBBE
	2KaOofXof/qoTlqBuCOGXZBk3C+vqz68xTpBlPIuvevUS4pWd0vCi1YpxzpAMV/eSyQsfFitEzP
	/bIJxTaHpiY8LaRQcWtZTSh7pNSE+VwVzT8MCpEIhXvGtHDQAU9YkwObKNup2AueuDXCoNe3Cza
	AFQPrHpOg35M1pwpqzRySXy5muLSjUha2ZiitzslZ7b+d596BdoYapeBs9W/TMyIYiL6BVYwT0L
	GOR9bot7NJLUPjKkPFORb2gX9HgpXZ3gLcWyt4XeIfoP2aO3YfOclV1mz+b5eH6UB4o2l+T4NH6
	hj/sT7z5N7DcPJg0v6DARugr+vgXVrMbAYCcKjb6pUP74=
X-Google-Smtp-Source: AGHT+IFIbAtMObhmtPyCgMPcO1Opp+Xy+pPXm2lE4u/n9a432p5A5AvgL2F2qHUK5dDeTjGyXPbmEw==
X-Received: by 2002:a05:6000:18a7:b0:428:3d75:b0e8 with SMTP id ffacd0b85a97d-429b4ca2941mr936653f8f.62.1761777988338;
        Wed, 29 Oct 2025 15:46:28 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.211.131.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7d1sm29049186f8f.16.2025.10.29.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:46:27 -0700 (PDT)
Date: Wed, 29 Oct 2025 23:46:05 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: mpl3115: add threshold events support
Message-ID: <20251029224605.3ixkvmmkm36iwh22@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
 <20251028213351.77368-3-apokusinski01@gmail.com>
 <aQHPUQ5bU7sFojul@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQHPUQ5bU7sFojul@smile.fi.intel.com>

On Wed, Oct 29, 2025 at 10:24:49AM +0200, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 10:33:52PM +0100, Antoni Pokusinski wrote:
> > Add support for pressure and temperature rising threshold events.
> 
> ...
> 
> > @@ -322,7 +339,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
> >  			.storagebits = 32,
> >  			.shift = 12,
> >  			.endianness = IIO_BE,
> > -		}
> > +		},
> > +		.event_spec = mpl3115_temp_press_event,
> > +		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
> >  	},
> >  	{
> >  		.type = IIO_TEMP,
> > @@ -338,7 +357,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
> >  			.storagebits = 16,
> >  			.shift = 4,
> >  			.endianness = IIO_BE,
> > -		}
> > +		},
> 
> Just a side note below, no action from you required on this!
> 
> Yeah, yet another reminder for the comma/not-a-comma choices made initially and
> why it's important to follow the advice
> 
> > +		.event_spec = mpl3115_temp_press_event,
> > +		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
> >  	},
> >  	IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> 
> ...
> 
> > -	if (!(ret & MPL3115_INT_SRC_DRDY))
> > +	if (!(ret & (MPL3115_INT_SRC_DRDY | MPL3115_INT_SRC_PTH |
> > +		     MPL3115_INT_SRC_TTH)))
> 
> Can we rather keep this split logical?
> 
> 	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
> 		     MPL3115_INT_SRC_DRDY)))
> 
> >  		return IRQ_NONE;
> 
> ...
> 
> > -	u8 ctrl_reg1 = data->ctrl_reg1;
> > -	u8 ctrl_reg4 = data->ctrl_reg4;
> > +	u8 ctrl_reg1, ctrl_reg4;
> 
> > +	guard(mutex)(&data->lock);
> 
> Why this is moved? Before the access to the data->ctrl* was done without
> locking. Is it an existing bug?
> 
Since this patchset adds `write_event_config()` in which CTRL_REG1.ACTIVE
and CTRL_REG4 are modified, the lock now needs to guard the read of
data->ctrl_regX as well. Otherwise, we could have e.g. 2 concurrent
threads executing `set_trigger_state()` and `write_event_config()` that
would read data->ctrl_regX at the same time and then one would overwrite
the other's values in `config_interrupt()`.

In the current driver I don't think there is any bug in here. The only
place (except probe) where the data->ctrl_regX is modified is
`config_interrupt()`, called from `set_trigger_state()`. If we had
concurrent calls to this function, then the final values of CTRL_REG1
and CTRL_REG4 would simply depend on which thread is scheduled as the last one.
With the `guard(mutex)` before accessing data->ctrl_reg1, the situation
would be exactly the same.

> > +	ctrl_reg1 = data->ctrl_reg1;
> > +	ctrl_reg4 = data->ctrl_reg4;
> >  
> >  	if (state) {
> >  		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> >  		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
> >  	} else {
> > -		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> >  		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
> > -	}
> >  
> > -	guard(mutex)(&data->lock);
> > +		if (!ctrl_reg4)
> > +			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> > +	}
> >  
> >  	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
> 
> ...
> 
> > +static int mpl3115_write_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      enum iio_event_type type,
> > +				      enum iio_event_direction dir,
> > +				      bool state)
> > +{
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	u8 int_en_mask;
> > +	u8 ctrl_reg1, ctrl_reg4;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PRESSURE:
> > +		int_en_mask = MPL3115_CTRL4_INT_EN_PTH;
> > +		break;
> > +	case IIO_TEMP:
> > +		int_en_mask = MPL3115_CTRL4_INT_EN_TTH;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> > +	guard(mutex)(&data->lock);
> 
> Similar Q here, why do you protect data that was (still is?) not protected before?
> 
Same situation here as in `set_trigger_state()`
> > +	ctrl_reg1 = data->ctrl_reg1;
> > +	ctrl_reg4 = data->ctrl_reg4;
> > +
> > +	if (state) {
> > +		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> > +		ctrl_reg4 |= int_en_mask;
> > +	} else {
> > +		ctrl_reg4 &= ~int_en_mask;
> > +
> > +		if (!ctrl_reg4)
> > +			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> > +	}
> > +
> > +	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
> > +}
> 
> ...
> 
> > +static int mpl3115_read_thresh(struct iio_dev *indio_dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       enum iio_event_type type,
> > +			       enum iio_event_direction dir,
> > +			       enum iio_event_info info,
> > +			       int *val, int *val2)
> > +{
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	int ret, press_pa;
> > +	__be16 tmp;
> > +
> > +	if (info != IIO_EV_INFO_VALUE)
> > +		return -EINVAL;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PRESSURE:
> > +		ret = i2c_smbus_read_i2c_block_data(data->client,
> > +						    MPL3115_PRESS_TGT, 2,
> 
> sizeof() ?
> 
> > +						    (u8 *) &tmp);
> 
> Here and elsewhere, drop the space between casting and operand.
> 
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/**
> 
> It's not a kernel-doc.
> 
> > +		 * Target value for the pressure is
> > +		 * 16-bit unsigned value in 2 Pa units
> > +		 */
> > +		press_pa = be16_to_cpu(tmp) << 1;
> > +		*val = press_pa / KILO;
> > +		*val2 = (press_pa % KILO) * MILLI;
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_TEMP:
> > +		ret = i2c_smbus_read_byte_data(data->client, MPL3115_TEMP_TGT);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* Target value for the temperature is 8-bit 2's complement */
> > +		*val = sign_extend32(ret, 7);
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> ...
> 
> > +static int mpl3115_write_thresh(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info,
> > +				int val, int val2)
> > +{
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	u8 tmp[2];
> 
> Use proper __be16 type.
> 
> > +	if (info != IIO_EV_INFO_VALUE)
> > +		return -EINVAL;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PRESSURE:
> > +		val = (val * KILO + val2 / MILLI) >> 1;
> 
> > +		if (val < 0 || val > 0xffff)
> > +			return -EINVAL;
> 
> U16_MAX?
> 
> > +		tmp[0] = FIELD_GET(GENMASK(15, 8), val);
> > +		tmp[1] = FIELD_GET(GENMASK(7, 0), val);
> > +
> > +		return i2c_smbus_write_i2c_block_data(data->client,
> > +						      MPL3115_PRESS_TGT, 2, tmp);
> 
> sizeof()
> 
> > +	case IIO_TEMP:
> > +		if (val < -128 || val > 127)
> > +			return -EINVAL;
> 
> S8_MIN, S8_MAX ?
> 
> > +		return i2c_smbus_write_byte_data(data->client,
> > +						 MPL3115_TEMP_TGT, val);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>
Kind regards,
Antoni


