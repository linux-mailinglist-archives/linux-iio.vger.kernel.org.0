Return-Path: <linux-iio+bounces-18720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C33EAA9DE02
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 02:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3DF7A7908
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 00:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EFA227E98;
	Sun, 27 Apr 2025 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8TPcr0G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7E1E7C34;
	Sun, 27 Apr 2025 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745713163; cv=none; b=Kr6VGZJpfXAzni8yZEH94WfEjb/JuBcEKYNlV73qqMJCPWxJxFwEjtL+CzPfg+qk9CothBhy3CMsErr5MuFgi17CrOy4y7h+8OxvLKhOpfBkVtydq0yIh2CUeAq9CCRuuD6TTu5j282YtDzc+ctp5eCOEOT8N1qXqP4WcVuQERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745713163; c=relaxed/simple;
	bh=a7V465Pnb0f2w4dhkEaaWoTgBkHgSut2RRbb3EpwUAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/lpeY7TBW95HYjfNUEKP55xWA7rhFNSQZMfDCJ9dZFFoF5Vhr8EpxLWiXuGUPYZOteT6twP+2mX6BcicKt9kt0uSZVdJxo9kmGSUV3dfWluSso4+rZEXccvMciR+jXk6Rh4W1Ws1ISLDu2TjiOhFuUflq7T3TCSbyyaN8YhP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8TPcr0G; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af50f56b862so2438505a12.1;
        Sat, 26 Apr 2025 17:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745713161; x=1746317961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JnKXQVQP1G5EmBVoHbI7bOC2UWFlET3osHcdLyJY8/g=;
        b=M8TPcr0GOCZwtCmPROgpeASdDYJQZNWZnnyypkT9qXPNly4oFeYRQLZ3/VrMpjMrZV
         Ny55Ss3GynhsuPPIfaTO8P2YYvoZLWPKF4iT9Ur32YXDbJNTFVbfxAxf5UIJPwQrKQAN
         opQNXkPvUBXe55LnhyHn9rVAMqKmHjNXG4TIBV1wlTqd71gXXFHMaZPchENEn7C+n7El
         Y6zaBSQLt1QB7W/lXtyG3UtK4yIlYrV/En9xCZ/yrnJVJmtjry5SJF2tcFvbH3pLg2Gs
         O6BGUODA5dOL72OV7P6eZJQkLdCgnQtR3Tx9yafyoyFmIskpAEyaxUUxwyn2//iy7vR2
         KRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745713161; x=1746317961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnKXQVQP1G5EmBVoHbI7bOC2UWFlET3osHcdLyJY8/g=;
        b=FK8p0FjZ7oPW5IQr+n/nxWCxSzta258djJrUF3ha6wwd/AS61VlrhAm9lraF14LsIq
         VRE+W3PnM9zbZv9Fjwrze70kW/FwI2GfWnEoUjsCY2p8y12QRqGkxSgooageNsJE9QUS
         JxvJb5S1bB1oOg9icH7DNc4IxfE7oiuwTKr4Wy2WNVK/he0ONHd8srrNUMl6mL6B4Cat
         cQHHBzLU8fFRvTcVy0Y9akLx/y3eg/NegdLGiO/F1tucBPjYD/VVxS25VyULOamCnszb
         4ILtHy39/xuOUYZUzFmee7FT6WI2Nec0bXG95nFQhdsHbCectwlSsJbSg0DAK219JdZk
         AibQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4oInbyJk7zrl49HAddlGBrrDxRNwcjIrtphKZQLm7TP1ea+FJdePBLcxQWzsX2H3KNPVvz7f3PB4=@vger.kernel.org, AJvYcCVcyLc8evyXhyUa/TDNzMo3TFFoVBCAI+0TToMQKioexx2gQmq9+ApaGb9dzBN2gtAger0EPLwBGNl3G7nr@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBpivbkiFod+MVF6VtfG+X//GG17gB3aqRJ4/hqLIfuo439xD
	N22tiT4M5TQN14Pw+iZqahLfUw3nAdnt13uIwQwV1NmRDpoH0hIN
X-Gm-Gg: ASbGnctPAII+xfH/j7yv8cKHQ4urdCL7QO3ardIbMr9OPTUvh+uBHEeu0lt8hQKMvv9
	mAO4oZkJ/GmH9ARWHAUm3g0zYCTufcIF7Kzv3oMlalG3oZN1vISuPaabfR8eGwRXpeQzxMjM80U
	No95gIYDK0ctE4mERlJ4SkyEs9bxa9WZqdj+o8BvUI3W5MiwoIEGz7Z8uShM26NJKDrVwQmfaQp
	c/pMbXpODEx5osRBG+stEYLXANukAD7s6dKWoD1x3/yar/BiF0XeIdhwZ1mcAfFlLDFAu75d6bX
	S+XyKeqpM4c5XaaR4L80JnEyGA==
X-Google-Smtp-Source: AGHT+IEYd8G9M8x1pe1vUFr5IKvTA5J6eKVxfAdZtMNz+ArYub3Viv8ApF9NP/skxqnOWjl2Szzz2A==
X-Received: by 2002:a17:903:2384:b0:21f:7880:8472 with SMTP id d9443c01a7336-22dc6a54586mr69760965ad.35.1745713160902;
        Sat, 26 Apr 2025 17:19:20 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76f8asm55650305ad.35.2025.04.26.17.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 17:19:20 -0700 (PDT)
Date: Sat, 26 Apr 2025 21:19:13 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <swswxbwejqyrekr2bvjf4p5lglodg3hlgl5ckiluxpazzl3chn@ga3uriqvmv7b>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
 <20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>
 <20250426144020.2633f9cb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426144020.2633f9cb@jic23-huawei>

On Sat, Apr 26, 2025 at 02:40:20PM +0100, Jonathan Cameron wrote:
> On Thu, 24 Apr 2025 21:14:50 -0300
> Gustavo Silva <gustavograzs@gmail.com> wrote:
> 
> > Add a channel for enabling/disabling the step counter, reading the
> > number of steps and resetting the counter.
> > 
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> Hi Gustavo,
> 
> This is tripping over the somewhat theoretical requirement for
> regmap to be provided with DMA safe buffers for bulk accesses.
> 
> Jonathan
> 

Hi Jonathan,

Thanks for the review. I've got a few questions inline.

> > ---
> >  drivers/iio/imu/bmi270/bmi270_core.c | 127 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> > index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..f09d8dead9df63df5ae8550cf473b5573374955b 100644
> > --- a/drivers/iio/imu/bmi270/bmi270_core.c
> > +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> > @@ -31,6 +31,8 @@
> 
> >  /* See datasheet section 4.6.14, Temperature Sensor */
> >  #define BMI270_TEMP_OFFSET				11776
> >  #define BMI270_TEMP_SCALE				1953125
> > @@ -111,6 +118,7 @@ struct bmi270_data {
> >  	struct iio_trigger *trig;
> >  	 /* Protect device's private data from concurrent access */
> >  	struct mutex mutex;
> > +	int steps_enabled;
> 
> Seems a little odd to have a thing called _enabled as an integer.
> Probably better as a bool even though that will require slightly more
> code to handle read / write.
> 
I agree that a bool might be more appropriate in this case. I decided to
use an int to keep consistency with other drivers, specifically bma400
and the iio dummy driver.
If you prefer, I'll use a bool here and after this series submit a patch
updating those drivers as well.

> 
> >  
> >  	/*
> >  	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
> > @@ -282,6 +290,99 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
> >  	},
> >  };
> >  
> > +enum bmi270_feature_reg_id {
> > +	BMI270_SC_26_REG,
> > +};
> > +
> > +struct bmi270_feature_reg {
> > +	u8 page;
> > +	u8 addr;
> > +};
> > +
> > +static const struct bmi270_feature_reg bmi270_feature_regs[] = {
> > +	[BMI270_SC_26_REG] = {
> > +		.page = 6,
> > +		.addr = 0x32,
> > +	},
> > +};
> > +
> > +static int bmi270_write_feature_reg(struct bmi270_data *data,
> > +				    enum bmi270_feature_reg_id id,
> > +				    u16 val)
> > +{
> > +	const struct bmi270_feature_reg *reg = &bmi270_feature_regs[id];
> > +	int ret;
> > +
> > +	ret = regmap_write(data->regmap, BMI270_FEAT_PAGE_REG, reg->page);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_bulk_write(data->regmap, reg->addr, &val, sizeof(val));
> 
> For a regmap on top of an SPI bus. I think we are still requiring DMA safe
> buffers until we can get confirmation that the API guarantees that isn't
> needed.  (there is another thread going on where we are trying to get that
> confirmation).
> 
> That is a pain here because this can run concurrently with buffered
> capture and as such I think we can't just put a additional element after
> data->data but instead need to mark that new element __aligned(IIO_DMA_MINALIGN)
> as well (and add a comment that it can be used concurrently with data->data).
>
Just to clarify, when you say data->data, are you referring to the
bmi270_data::buffer variable? That used to be called 'data' but it was
changed to 'buffer' in commit 16c94de2a.

> This hole thing is a mess because in reality I think the regmap core is always
> bouncing data today. In theory it could sometimes be avoiding copies
> and the underlying regmap_spi does require DMA safe buffers. This all relies
> on an old discussion where Mark Brown said that we should not assume any
> different requirements from the the underlying bus.
> 
> > +}
> > +
> > +static int bmi270_read_feature_reg(struct bmi270_data *data,
> > +				   enum bmi270_feature_reg_id id,
> > +				   u16 *val)
> > +{
> > +	const struct bmi270_feature_reg *reg = &bmi270_feature_regs[id];
> > +	int ret;
> > +
> > +	ret = regmap_write(data->regmap, BMI270_FEAT_PAGE_REG, reg->page);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_bulk_read(data->regmap, reg->addr, val, sizeof(*val));
> > +}
> > +
> > @@ -551,6 +652,8 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
> >  	struct bmi270_data *data = iio_priv(indio_dev);
> >  
> >  	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		return bmi270_read_steps(data, val);
> >  	case IIO_CHAN_INFO_RAW:
> >  		if (!iio_device_claim_direct(indio_dev))
> >  			return -EBUSY;
> > @@ -571,6 +674,10 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> >  		ret = bmi270_get_odr(data, chan->type, val, val2);
> >  		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_ENABLE:
> > +		scoped_guard(mutex, &data->mutex)
> > +			*val = data->steps_enabled;
> 
> What race is this protecting against?  Protecting the write is fine because it
> is about ensuring we don't race an enable against a clear of the counter.
> A race here would I think just give the same as either the race to take the lock
> being won by this or not (so not a race as such, just ordering of calls)
> So I don't think you need the lock here.
>
Understood. I'll fix it in v2.

> > +		return IIO_VAL_INT;
> 
> 

