Return-Path: <linux-iio+bounces-20952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB64AE73AF
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 02:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA563B8D10
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 00:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FEB17C77;
	Wed, 25 Jun 2025 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LibxaPiS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0030748D;
	Wed, 25 Jun 2025 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810639; cv=none; b=u6zgqc9GKy7JHLaY/mjiNv5xdDAJCbxwSmjcuExpSJxyyGfK70NbYiaAwSf11iGGinRbtHzjgF7hPC+jsP+MT1l03mCsqaNR6Dgq4lPL6tlvYDSKFZ+53Bpidu4uefGufzaY7crPgnoc0cd8ldlR39lzxXDkhumMjMeVZPAJeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810639; c=relaxed/simple;
	bh=8F+5VJe6FB70M4AQuQJYZ1+ifX1/9f77z7JvHI4bcog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFWuRhd097VBVeG8pSrf1UOPAWNRTRQSsF/ZFthoFJ7qZQZm1okb6hu9Hccs9HtkNgPTrudrHrKv02b135E2deh7O/VO/3A4dKVOsVjqSY+VhTR+gbqeVr76+FyWVOVSoDzhmz+NInpe9uz9i7YH67lv+13OnD+sC4BB+lbLvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LibxaPiS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c3d06de3so6844208b3a.0;
        Tue, 24 Jun 2025 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750810637; x=1751415437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMuWEhNS0QYEHfBsmjFKrwhF+mL6kz9BNUIZdfev/+U=;
        b=LibxaPiSbH9gM/Q2z8ZANqaxEdfT9f2yKyrb0cdWtjmNq84nR8A8//D5AuIWN7exD5
         WxzmWzfsW0OG2RjFLdntRv0yHq7XGKasZ311Eg0rXVpWs5ED8jzNB2Fsubokg4XHAnrV
         4B8aOFamN1ScWEmtuUhwP75XKYZetVl9m5W0y68EQMU8jPQXww62Tm9V+zg9govlXXGn
         8KY+Z38L4eC5LUdSrEG9HxZC5+csu59Gr7GeSIxAe4gaFNs/F6dFsalaJUEChVh0ueM9
         ff0KzpYdrqvLtCaYKj+cfZS2+f7F++jUycYTKz0JOpOG0GYkF0OnJgf+TQcP4HSfEjDJ
         f9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810637; x=1751415437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMuWEhNS0QYEHfBsmjFKrwhF+mL6kz9BNUIZdfev/+U=;
        b=MN9bkPiOgzXgXpaKwrCWpdxexqrVXSGCuU9o/oPoQGe+TCJzLyGHP/YkZYDdVvJcRt
         /lEI8h4gjTn3NcwPSxpne9C2D2POy2tkLShvD5GofvfibyXHLI3ubGJukH7/xatZqQka
         kJ1ODaC24FdlK8XhY4iC6ezTNNLQdqQgXJJdln2LR/bLszkULS+LKda+ciujXukwYOj6
         YLZMQBtElZhY4kkD0Fiikafiynrvd32/EwyLZzEhBEvUDJTU/DCY1BuZhCFFOz9NQxcR
         pE0t0Zlp0Ghu8ReatfxKR7qRZVCs9lkgYI4BRrDGWQmFFQX6YLKaysEj6fAPsDY6Rx/p
         zV9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvLnioPS4cCgZpZVcUohOn6Y1LHwaCowEBmPk0q/HZBwrRmZ4+b8sD3ZykvfWYLUiamK7vMjDEnsHxL22T@vger.kernel.org, AJvYcCVPESUOwtLqbEtAog9Fs1jlL/MvR+zzDparsq46VxjiB3m9EENaq4lTWs4iLbrJBOZ0HPk5fCCjCjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cOxULx4RV7S1tHtWPaguhGagQaEMFHXL84vgDeiLWjbwUMtJ
	uw8KCBE/YyooJX6GSZcOMcU9AHBE3qKQF0O1a+hkjuo7EUwS/X368Oti
X-Gm-Gg: ASbGncs2pckBdXFtQzpPg7w3Tc0wTseNU4OZmoBJY3IC/P2qzvw0WqNszTNpjbeikJA
	DyGvFYk+4c7JtdtUDj8K6ERtsHZs/NOvNKjeVtIhj0T8LsbCX2tXPh5LdFXbwKMQy0PVHHU2iRo
	Li7W5GImsEJZ46UyN7DXJYfpgVDTdDhH4E/qvyoIgJ0QjTldT0y3qKVc8JDhFvoaZVOuufAPwqc
	jiYgggBToJMWXEDGjtsEPGniEVDYu4ET8wsGF3hbA/NfWYbAM2QG9+R9BJMHeiJy0XXSjWktCb3
	9rxN+B3RP5Byb6nm191oU+O7UgvYvF6DnGnEm8xWz9rNwUisc50RBwtag7WA5L+XeQ==
X-Google-Smtp-Source: AGHT+IGrnaMXw6owasaNuxUam8tvd0LaSbXuxrDukfAd4n+I/N8D50xe/q8P4mWxhhtFqkTPTOJ+zQ==
X-Received: by 2002:a05:6a21:9991:b0:21c:fc27:aee6 with SMTP id adf61e73a8af0-2207f2b44ffmr1365642637.22.1750810636620;
        Tue, 24 Jun 2025 17:17:16 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:477c:f086:933f:4c16:eb28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882cd77sm2856632b3a.88.2025.06.24.17.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:17:16 -0700 (PDT)
Date: Tue, 24 Jun 2025 21:17:03 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v3 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <d5kbjtjofknv4qkbak7ujr2lyckpio5kly55hpqlcrkajjzlzn@vr3c27deyumc>
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
 <20250616-bmi270-events-v3-3-16e37588604f@gmail.com>
 <20250622144240.02845c0a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622144240.02845c0a@jic23-huawei>

On Sun, Jun 22, 2025 at 02:42:40PM +0100, Jonathan Cameron wrote:
> Hi Gustavo,
> 
> Main question in here is about the scaling of the motion threshold.
> It seems to be based on units of g.  We use m/s^2 for IIO acceleration channels
> and also the expectation is that threshold events match scaling of the main channels
> (_scale applies to them).  Hence here we will need to do something a little
> fiddly to maintain the threshold scale if the main channel scaling changes.
>
Hi Jonathan,

Thanks for the review.
> 
> Jonathan
> 
> 
> > @@ -114,6 +134,10 @@
> >  #define BMI270_STEP_COUNTER_FACTOR			20
> >  #define BMI270_STEP_COUNTER_MAX				20460
> >  
> > +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) ((val) * (scale) + \
> > +						  ((val2) * (scale)) / MEGA)
> > +#define BMI270_RAW_TO_MICRO(raw, scale) ((((raw) % (scale)) * MEGA) / scale)
> 
> I'm struggling a bit with what this is doing.  Perhaps a comment?
> 
These macros convert register values to the range defined in
'in_accel_{period,value}_available' and vice versa.
The same macros are defined in the bmi323 driver, so I used them here
for the sake of consistency.
> 
> 
> 
> > @@ -827,6 +977,20 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
> >  	}
> >  }
> >  
> > +static IIO_CONST_ATTR(in_accel_value_available, "[0.0 0.00049 1.0]");
> This aligns with below.  Scaling definitely shouldn't be in g and is likely more
> complex because of the relationship expected with the overall channels scaling
> controls.
> 
> > @@ -848,21 +1016,58 @@ static int bmi270_read_event_config(struct iio_dev *indio_dev,
> >  				    enum iio_event_direction dir)
> >  {
> 
> 
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		ret = bmi270_read_feature_reg(data, reg, &regval);
> > +		if (ret)
> > +			return ret;
> > +
> > +		raw = FIELD_GET(BMI270_FEAT_MOTION_THRESHOLD_MSK, regval);
> > +		*val = raw / BMI270_MOTION_THRES_SCALE;
> > +		*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_THRES_SCALE);
> 
> Why this particular scaling? Is effectively just dividing 1g / number of
> values and hence providing a scaling to g?
> 
That's correct. In the bmi323 there's an actual scaling factor of 512 to
the register value. In the bmi270 the register value is not scaled.

> Full scale is described as being 1G.
> As this device is providing _RAW data for the relevant channels I'd
> expect this to be scaled to match that. That will be a little fiddly here as
> this is apparently always 0-1g whereas the scaling of the channel varies.
> Thus irritatingly we'd need to adjust the scaling of this so it remains
> consistent as the full scale changes.
> 
> The events ABI documentation is rather weak / wrong on this as it refers to
> both _input_ and _raw_ thresholds whereas the true ABI just has one with
> the scaling always being to match _raw if that is present. So _threshold * _scale
> should be in the standards base units of m/s^2.
> 
Thanks for the clarification. I'll work on that in v4.
> 

