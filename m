Return-Path: <linux-iio+bounces-18721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA86A9DE17
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 02:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A12461C42
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 00:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA9A202F9C;
	Sun, 27 Apr 2025 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4ksTpCo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C418C91F;
	Sun, 27 Apr 2025 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745715451; cv=none; b=CMeNfrHRdy486A6jbHI8w36or80HNOTknqPzuYHEb6jpqwehxVMHxyzpezDxv3mEOoGoTCinvkds8/zEcF44IpcFvKwoQd3zxuggq9KTdrVknXyvbgziSGUGsJgGG9+o3UH7OZ50H1EZ/JkYG3Z9zrLRSShlqJw2UGDEEwKauR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745715451; c=relaxed/simple;
	bh=TLdbKcVANIvORdb92beANb5wwAMnvuZ2YMbFhmmtkJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDy5Kbe+NeZzk6ra5Bks9mSBJHyLyosF02csZeQoXLQ3H9Icpv95ug5XHpJmz25/pBq7htyKyKZlJmujPeerpuBKEvp497pXE+9pVxCQZc29eI+XIU+4O43hduA97GoGxH3Hp2iKC4RQl6vjy3MPLSXhLl3feiYUhLQJje65nPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4ksTpCo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af51596da56so2956702a12.0;
        Sat, 26 Apr 2025 17:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745715449; x=1746320249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m17Zwf83H94H2bOxPIG7Ac4FBEqLgx3MSxKhyxakfLY=;
        b=S4ksTpCoa6FPXOepucv3VtPIZumzTQiNyDwGh8EKy9IXTARogreWyZRgUNLe3reiFZ
         KbzRlNmL7tYP7HBA3ndvZpTZdapwguf8Tbxulb8UkUvN8qz9Y/6sl5BXJiN2Ss2SrPCw
         uqpz72IZTtPVrYkK/7RsfJRQgDX0rFbSUq3m9TKcL8dzKwrTeU1gxQCsGLj8cXzH9fwO
         nxLX7U4pvcTKQME0LT9zyU1os9hIJ+l5tzVoLj7RLGEey7x2aAbcUGoiq5YWv3YoDrwo
         /+tUcYuBUEDD7Br3xFGfK8EHpYjGImjMBMUdmf5rZ7/B26WIkwmAMRfy+rnyr+UQ+k7h
         EtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745715449; x=1746320249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m17Zwf83H94H2bOxPIG7Ac4FBEqLgx3MSxKhyxakfLY=;
        b=XckWx5EX/6Uc2eeUcMh10oh/GY5b5buFArHpjXc8Mudv/7WYUuL/MQ055kvbccCi+9
         jwOYabkqgoofitKvKsJZFMASJ6WZvURqoBEQOvMSfNJbQTJjg94xylRI9A6pd6U3wTjy
         22/+Gb5Cx6Cozvum+ePdAbwccQAPqNvgTAg4v0xr+wKiz6LePvLIrwJ1Tl5qX/rfH2Mz
         b3sEsu6ZEjlhd1dhzlqnMxIF9ropUV3bYFV0hCiXzd9Sd4u7tHIaLnIFtYsevEBwhSLF
         S/9D/zW1IZRRc1g6OVQnT3TAG4K/JpMgvIT4T0kLA0xYraSh0M3wyGp+D9TEgudpKyfQ
         72BA==
X-Forwarded-Encrypted: i=1; AJvYcCUeCL4qcUG7REF8s6iLJV/umJZhJkW7ZxljAinHzqrC+6sizMLq/V37EIo1VnPG1Y5mKmk0F80B1qEO9YfH@vger.kernel.org, AJvYcCW5Hrd5XHRjQ/GTaoPhRryjB89QXd53bUVw2ATBvaua4idneYUFkOhFAN733O0OAJgym6Y3fCXZ0WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dJbtX4t2Tcd7a/h6KPq/thmqY0Uig3p+G/bhIHcwnWuchWUH
	YB7trAaRm0K43axRR42vEGQLc+m5twMlX3Z1pUrkxtSw+WIP4SEt
X-Gm-Gg: ASbGncs8UbVUPkMjw2sDXlMDMRIXWDtpJWaf9kOn/Yg7azg5DT696ILmKYJRgdC4Xim
	4DkyemGfBwr+xtoCMfHozpTv5VuA9cGo+c2QhVA5GlnyI7DqI966RXER4UCFQ8kqX+5jr/6B7PG
	0gCJ7V5+cYy3k/V1azbpcxe/TXuw7zRlf0acFPEFxyPeFmcJ5B4sM52UmsYC2oRh4fHnjK9pVDY
	67xT6YzPmj/aMmsl2tKwYc8HAnksp2StuVrJaIyPy41i34NJR0ZS03UDhPcEOZYgDdXhm9NphMI
	e2VfzROdm+Dqis1K+UXDMSmjyQ==
X-Google-Smtp-Source: AGHT+IFaHvUcEnqFi4Lr0hCCB5O6qB3QQ0++BclRzCTeW4p+KMMla0oQd7fun1jrfkmdumF49GKpGw==
X-Received: by 2002:a05:6a21:32a9:b0:1f5:77ed:40b9 with SMTP id adf61e73a8af0-2045b9f4009mr11881966637.40.1745715449262;
        Sat, 26 Apr 2025 17:57:29 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acc600sm5575820b3a.173.2025.04.26.17.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 17:57:28 -0700 (PDT)
Date: Sat, 26 Apr 2025 21:57:21 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: bmi270: add step counter watermark event
Message-ID: <yudy5vbwblqzkx34pgekqi3noyctaxo77n2lb6mqidb4veqadm@534j4towopou>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
 <20250424-bmi270-events-v1-2-a6c722673e5f@gmail.com>
 <20250426144739.31b8bd36@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426144739.31b8bd36@jic23-huawei>

On Sat, Apr 26, 2025 at 02:47:39PM +0100, Jonathan Cameron wrote:
> On Thu, 24 Apr 2025 21:14:51 -0300
> Gustavo Silva <gustavograzs@gmail.com> wrote:
> 
> > Add support for generating events when the step counter reaches the
> > configurable watermark.
> > 
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> 
> Main thing in here is I think the event type isn't the right one.
>

Hi Jonathan,

Thanks for the review.
I think the answers to your questions in this patch come down to me
trying to keep this driver consistency with the bmi323 driver, since
the two devices are very similar.
However I have no objections to change the event type if you think it
is appropriate.

> > @@ -119,6 +128,7 @@ struct bmi270_data {
> >  	 /* Protect device's private data from concurrent access */
> >  	struct mutex mutex;
> >  	int steps_enabled;
> > +	unsigned int feature_events;
> 
> Why do we need this rather than just checking the register?
> 
Not really needed, I just tried to keep it similar to the bmi323 driver.

> 
> > +
> > +static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
> > +{
> > +	int ret, reg, field_value;
> > +
> > +	guard(mutex)(&data->mutex);
> > +	if (!data->steps_enabled)
> > +		return -EINVAL;
> > +
> > +	reg = bmi270_int_map_reg(data->irq_pin);
> > +	if (reg < 0)
> > +		return -EINVAL;
> > +
> > +	field_value = FIELD_PREP(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, state);
> > +	ret = regmap_update_bits(data->regmap, reg,
> > +				 BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
> > +				 field_value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	set_mask_bits(&data->feature_events,
> > +		      BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, field_value);
> 
> Given we wrote the register, why do we need a cached value?  Can't we just read
> it back again (or rely on a regmap cache for it if enabled in this driver)
>
Ditto.

> > +	return 0;
> > +}
> > +
> >  static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
> >  {
> >  	int i;
> > @@ -539,19 +585,32 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
> >  {
> >  	struct iio_dev *indio_dev = private;
> >  	struct bmi270_data *data = iio_priv(indio_dev);
> > -	unsigned int status;
> > +	unsigned int status0, status1;
> > +	s64 timestamp = iio_get_time_ns(indio_dev);
> >  	int ret;
> >  
> >  	scoped_guard(mutex, &data->mutex) {
> > +		ret = regmap_read(data->regmap, BMI270_INT_STATUS_0_REG,
> > +				  &status0);
> > +		if (ret)
> > +			return IRQ_NONE;
> > +
> >  		ret = regmap_read(data->regmap, BMI270_INT_STATUS_1_REG,
> > -				  &status);
> > +				  &status1);
> >  		if (ret)
> >  			return IRQ_NONE;
> >  	}
> >  
> > -	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status))
> > +	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))
> >  		iio_trigger_poll_nested(data->trig);
> >  
> > +	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))
> > +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
> > +							     IIO_NO_MOD,
> why use IIO_MOD_EVENT_CODE() if not modified?
> 
My bad, I blindly followed what is implemented in the bmi323 driver.
I'll fix it in v2.

> > +							     IIO_EV_TYPE_CHANGE,
> > +							     IIO_EV_DIR_NONE),
> As below. This looks like a rising threshold event.
> 
> Change tends to be for things like activity detection (walking/standing etc)
>  
Using rising threshold event is fine by me, but then shouldn't we
update the bmi323 driver as well?

> > +			       timestamp);
> > +
> >  	return IRQ_HANDLED;
> >  }
> >  
> > @@ -761,10 +820,111 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
> >  	}
> >  }
> >
> > +
> > +static const struct iio_event_spec bmi270_step_wtrmrk_event = {
> > +	.type = IIO_EV_TYPE_CHANGE,
> 
> Change would be a per step event.
> IIUC this is a rising threshold.
>
Yeah, if the watermark level is configured to N steps, an event is
generated every time the step counter counts N steps.

> > +	.dir = IIO_EV_DIR_NONE,
> > +	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> > +			       BIT(IIO_EV_INFO_VALUE),
> > +};
> 
> 

