Return-Path: <linux-iio+bounces-21705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BCAB06A14
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 01:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A329562837
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 23:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F02D6614;
	Tue, 15 Jul 2025 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqNk8XhL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6232D193B;
	Tue, 15 Jul 2025 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623572; cv=none; b=Wfyfu3cLGjJlTO65rQ7Tz2AiOI2r6IEJl4go687hhPMyxsR2SlfEAJx/s7nGF9MBGhTBs6zuiBKdZFR2JoXOkCmdMV/JLahEM87LqY4y25cehTm7d2uKcChCpcQeLNpK3NG1YL1aEYge4Wq/osW2MyOlD/qI4NO70bMJudlkyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623572; c=relaxed/simple;
	bh=czTSnmQZoMiy5TK1Ct9tL8399jK72D95In0ilZZL9lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNq4F01CrI8hKEITa/smep1qkBvPpeV20V1oohw6uz0qAKUlR5QPR1fERXufKav+4XFc1250dBkcTlOx5VqhSHWo2Z9wmdEL8CobOLXiVvQmk5OkABYbfg5W5iFkLPq3m7sVqRp6zFm7CaSNiT0+s207fP+eaRjpAq3t45qcLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqNk8XhL; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so3153820a12.2;
        Tue, 15 Jul 2025 16:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752623570; x=1753228370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGHHrN8JsKR4gY0/pw+GWrDAy1lLsV7ujzD4k3qGWvM=;
        b=CqNk8XhLJCe8+mc6JQDEpH8dZVgn7UnpQtF8EntkqAaK/5qo5mHDxYsiyRClSJrzHn
         Bz+7EpzA6eqjWEEjRoTTBAXZCO+Jdy56Eiv9Nlaoe4cKLJPJVyt/fA3mQv7Ysd8N28h5
         tep0/AfgdAFW94EvyKZR/5WrXYPG83l6qW4YQg04Ov6MiGXefPPlr786gUSZYAm3ErqH
         GI791oXK/W6MzEOjjeAeB6IJu58/97ESB09XkGYaERkb6JwbIF6+MyIozo3JOixTw/hZ
         UOmI/qP5Un2ehdflHfNBpWoeNshqn4IVa1KbPlhhGx19RmiEcsxhj2Ww2noncdSyzbkl
         ObgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752623570; x=1753228370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGHHrN8JsKR4gY0/pw+GWrDAy1lLsV7ujzD4k3qGWvM=;
        b=qN1svlnsCx1svWoNG1aVPLGuAjwuwia1fe+AVyMQyfb0T5MgAUbxiGuXkWuQUpBadx
         gL/ARwiKnVUrhdNsa+P2e+E1NJ8BJenuO8m7r/+EN4lOsl7cUIZSpB63V5o4lM0rq8i/
         svT3LIFadd0afLIXDFztrdo7TNZNNa59F/m8dBYIAPx+YA4MEvsvm1c5j1flKuczqngu
         kZKMyV2BsgpLrmH3G9jR/uINVHsZ5UWdFDfVrfvvlSur8PUEAJwzRWeNaCt55Oy6UmJR
         m5f1WSoV3ZDu7m3p8DlDAdsR5rWdp0GGTAEYN1BlNiTVlSLnm0PiipauSYGuspQRuzgy
         fXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP3fYLbSmLGbTCLcb+ARX3n3yBK2v/SBYxmhRAOhQRs9WJmjGbOcnBJigCtDuZvvUsVkWhWlinPQH768if@vger.kernel.org, AJvYcCXmigB3MM+jxtEHmckaUa3wfai3BYLM3o2KuAAzydnx+8wc+fLr+uG36ljeMQ4z2auIM3dG3vFGq34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64jR68X5cbbJU2iAKTWmCUTIB+ucjwCBPe316ocCUft3PRPjh
	CbKzo/KAepX1OLV8aICvaygow65cYT7GEKsUyk9vrwpwYpsIuuDrtQP/
X-Gm-Gg: ASbGncvMp+eNRF5W52jEH+wkBlX+XKpPadaZbGs4njNR7TjxNnn9R4ZtpPYpaRQyNBL
	Dy60H/vhkhWwETAOFBUQr2z9znQFBQ0LxL6rS2ywt1V1JgLXnYu7EUj+lPBNPV/+BMFXQy/PQMD
	r+0dfGu/zTcDyis51ibN3FDr6i0Wn1T2xUDXS9rN6/m/7wmAOcMFzLpa9nDROUJvJQ52hCtG51C
	rGX5v2hqLUaSkLB8u2BjJB96lYC91OL1x8V6rP+Jj9c+2cDmaea0hSAgYyt/D25hKSFrnUiOIj+
	td29AwDu+FJ+Z0CKYR9U0xsH4BxzHXOtcu3NkH0VauUQHXedHqNu5OlZwq2rJwCIsgXrQNM4Elt
	5WBVD7Q==
X-Google-Smtp-Source: AGHT+IGNy5qd9CuTs7TFznYInQMK879Oxb96CDqoKKabupROJlrG8Ql7h2WpkN9d2Rlw/sXsDQAKpQ==
X-Received: by 2002:a17:903:1252:b0:235:f49f:479d with SMTP id d9443c01a7336-23e24f36476mr12100015ad.3.1752623570416;
        Tue, 15 Jul 2025 16:52:50 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498::13a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4287217sm114085435ad.9.2025.07.15.16.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:52:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:52:41 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <j7vqnxx3d6cws2zsveqohr6iqtno5thlauypnowlijifiwx5ow@6arfipnjkfh7>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
 <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
 <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>

On Tue, Jul 15, 2025 at 10:37:21AM +0300, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:
> > Any-motion event can be enabled on a per-axis basis and triggers a
> > combined event when motion is detected on any axis.
> > 
> > No-motion event is triggered if the rate of change on all axes falls
> > below a specified threshold for a configurable duration. A fake channel
> > is used to report this event.
> > 
> > Threshold and duration can be configured from userspace.
> 
Hi Andy. Thanks for the review.

> ...
> 
> > +/* 9.81 * 1000000 m/s^2 */
> > +#define BMI270_G_MEGA_M_S_2				9810000
> 
> I thought this is MICRO...
> 
> ...
> 
> > +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
> > +	((val) * (scale) + ((val2) * (scale)) / MEGA)
> 
> Side note: Perhaps good candidate to have it in math.h
> (AFAIR there are more users of the same.)
> 
Sure. I can submit a follow-up patch for that.

> > +#define BMI270_RAW_TO_MICRO(raw, scale) \
> > +	((((raw) % (scale)) * MEGA) / scale)
> 
> > +static ssize_t bmi270_show_accel_value_avail(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct bmi270_data *data = iio_priv(indio_dev);
> > +	int ret, scale, uscale;
> > +	unsigned int step, max;
> > +
> > +	ret = bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);
> > +	if (ret)
> > +		return ret;
> > +
> > +	max = BMI270_G_MEGA_M_S_2 / uscale;
> 
> ...as here we divide 10^6/10^-6 semantically speaking.
> 
Agreed. It makes more sense to call it MICRO.

> > +	step = max / BMI270_MOTION_THRES_FULL_SCALE;
> > +
> > +	return sysfs_emit(buf, "[0 %u %u]\n", step, max);
> > +}
> 
> Is this already documented in ABI?
> 
Not yet. Should this have a device-specific ABI entry?

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

