Return-Path: <linux-iio+bounces-14291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42DFA0BB53
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809E47A14BC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D231FBBE0;
	Mon, 13 Jan 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH6kHYqT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4451FBBDB;
	Mon, 13 Jan 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780742; cv=none; b=chFq4LDelbEy+5dGn4/i+y/SjAe0rEUbv/GYaBVC5q1BXqXyu4U6cVcvFu5kYaKOJ0qGkLoWKvfvTk8JUpxAqpCHpN4XpkOMkHIS/Ddeu+XvMTJqDEX0v7JXKqoBptA/rVRZyLOIN/fx56OZ4mtEUdT41qaLCgPJcey6yXaokmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780742; c=relaxed/simple;
	bh=dJxG1+NkxSJ3zLBVV5odI2Lk9mkvbGJ8raackbstNDQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qgbL6KX1tMkwT+voiI+aVaFAHY0Vvlp5krEV+PhgneZIuvoWDEDAl7+IBHgN3fEAmx9jY/wwsmsRjPdHi5cj2l2pBwX0sfuZGvS8lwqaISzQ/YTs6ylcu2ZyJOIJ3alr0GLyX0xcv/AajybXhU7RmbNYni7ene1rgheTZ2Dx8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH6kHYqT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso31591475e9.1;
        Mon, 13 Jan 2025 07:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736780739; x=1737385539; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=na2J4vSWOKtMDV+CfYo5WCflbc1aa5pJno8iqSwOgP0=;
        b=iH6kHYqTCFzBe/msAi1sXoSffoQLFy7piWZoKjrrF3EsS2iV+Qkseqq6mUfX2ogrVC
         l45U20FsR/zhhx6VSGlXoE1rnb4UKD0amaM6tVGZ/YL89ICZsyXHas4K9qdyPuzHFRl6
         gzMZGSdqnlYr1K9Mq4WGQuinpfQubL4IIoN1lYQYo6FIl7Eb6m8L/IrtzNi3J+iTZQo6
         TO2oqHwTMjdr1ooxy4kHIPjxL7depKoe0tXs0ZPUhZeKEKOhUKqi92FYzy08MTQw+ZW7
         fcfA7U9v9+5HvqQmGERasCXcWeaBtHdGyHE38wtzElzNtfMuKh3L/pLL/WEGqfqx3cyJ
         J+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780739; x=1737385539;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=na2J4vSWOKtMDV+CfYo5WCflbc1aa5pJno8iqSwOgP0=;
        b=CPPdUm4oMpqt3VzbuMHNCmRqja7myggtE714infjMwT/mm5SvOt9hSRl1AAdX4oE31
         aHr/0TBRbj3Lp5Z6axOQpnBYCaaUpDcu7eSuMlBV7IL9jxzY7Vxt5VUsIL5NHJv2eykO
         c8UMGQLACAGHLxY6B+0Lj+YGM4a+g1Ft95DzGY1aeZOEUAFrPf6BAbqGuB/ePxSCXguI
         iJB0u6B6IRJUT2IXlVOV7jPR/0bqOWmqFzl2kQn/5v/3eReOzFAL4+B+uHtBj9iC2evq
         M5jnKNhEVZsbgCqJeKwY7P00cTWetUSPXCkrm4V7XpUZxWw1I5nLlilI6NEHa1indNBh
         YAhw==
X-Forwarded-Encrypted: i=1; AJvYcCXoC3v6hij0ieFAgM44YvOCf41Vd+jBztIHzXNWFyfxdnAvpUAciGmlE3XinMozw5qegIKjZMV93Zq1rXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjey7FFeYKBOJnRgA6FwGlcBqlSxLVsreSsMtgdW370CHRfrwq
	aXlx8o/TxQocDvg3KdgairlMWWxxZroMGM2/tnrFNDv2QAY8Af4x
X-Gm-Gg: ASbGncvDj4GkopSa2cv5M/wzKtnUbavQHddOy300lXdEPpLdhoIn8Dbsb7kQFw1NGRP
	+V7ptbjGWqgpkxf/8VdhKpcfysqZefLKtAnYkkMkblwuv593KQChZ1RlKRi9ZWR298esENEc3aZ
	UTIABs/D3iVytuz/sVZJp4kvnPSGUHDrO1oZVvJqqSaaT+DjrH/EqlAVW/MczzrV54DpgdqDi8z
	7seIBTlQX01LJT4qZUc339MgK8h+ITg0m7ARX6XiEZAgLgCSF9x5Kt6rWN7n1m266u75+O0u2Qy
	xoWnA0dQGSts8HfoZh1tdK0y5Btf9g==
X-Google-Smtp-Source: AGHT+IELvxSfhJvT3t4RcLEtyOm2hKbnUaX0hG+4tYvlsAW5nVp9lMteCxqiRA+fZ/Sr5ppQwASUPg==
X-Received: by 2002:a05:600c:25a:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-436ee0a061emr151544575e9.11.1736780738090;
        Mon, 13 Jan 2025 07:05:38 -0800 (PST)
Received: from localhost (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b81a4sm12675963f8f.68.2025.01.13.07.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:05:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jan 2025 16:05:36 +0100
Message-Id: <D711DZJWGQX5.2D4PLVQN7NB8Z@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rishi Gupta"
 <gupt21@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
 <129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>
In-Reply-To: <129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>

On Mon Jan 13, 2025 at 12:56 PM CET, Matti Vaittinen wrote:
> On 07/01/2025 22:50, Javier Carrasco wrote:
> > The current scale is not ABI-compliant as it is just the sensor gain
> > instead of the value that acts as a multiplier to be applied to the raw
> > value (there is no offset).
> >
> > Use the iio-gts helpers to obtain the proper scale values according to
> > the gain and integration time to match the resolution tables from the
> > datasheet and drop dedicated variables to store the current values of
> > the integration time, gain and resolution. When at it, use 'scale'
> > instead of 'gain' consistently for the get/set functions to avoid
> > misunderstandings.
> >
> > Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light=
 sensor")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> Thanks for the patch Javier.
>
> And, sorry for a review which is more about questions than suggested
> improvements. I find it hard to focus on reading code today.
>
> > ---
> >   drivers/iio/light/Kconfig    |   1 +
> >   drivers/iio/light/veml6030.c | 499 ++++++++++++++++------------------=
---------
> >   2 files changed, 189 insertions(+), 311 deletions(-)
> >
>
> I like the diffstats of this Fix! :) It's nice you found gts-helpers
> helpful :)

I wonder how painful the int. time/gain/scale issue in ALS was before
iio-gts existed :D

>
> ...
>
> > +
> > +static int veml6030_process_als(struct veml6030_data *data, int raw,
> > +				int *val, int *val2)
> > +{
> > +	int ret, scale_int, scale_nano;
> > +	u64 tmp;
> > +
> > +	ret =3D veml6030_get_scale(data, &scale_int, &scale_nano);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	tmp =3D (u64)raw * scale_nano;
> > +	*val =3D raw * scale_int + div_u64(tmp, NANO);
> > +	*val2 =3D div_u64(do_div(tmp, NANO), MILLI);
>
> do_div() is horrible on some platforms. Or, at least it used to be. Is
> there really no way to go without it? We're dealing with 16bit data and
> maximum of 512x total gain only, so maybe there was a way(?)
>
> Maybe a stupid question (in which case I blame mucus in my head) - could
> you just divide the raw value by the total gain?
>

In its current form we need the 64-bit operations to handle the scale,
and it will probably have to stay like that for the reasons I give you
below.

> ...
>
> >
> >   static irqreturn_t veml6030_event_handler(int irq, void *private)
> > @@ -1084,6 +968,13 @@ static int veml6030_hw_init(struct iio_dev *indio=
_dev, struct device *dev)
> >   	int ret, val;
> >   	struct veml6030_data *data =3D iio_priv(indio_dev);
> >
> > +	ret =3D devm_iio_init_iio_gts(dev, 2, 150400000,
>
> Can you please explain the seemingly odd choice for the max scale?
>
> Just a quick look at the sensor spec and this driver allows me to assume
> following:
>
> Maximum 'total gain' from both HWGAIN and integration time is 16 * 32 =3D=
 512.
>
> If we chose the 'total gain' 1x to match scale 1, then the smallest
> scale would be 1/512 =3D 0.001 953 125
>
> This is 1953125 NANOs. This would mean the max-scale 1X =3D> gain 1X woul=
d
> not cause precision loss. (Well, I'm not at my sharpest as I've caught
> cold - but I _think_ this is true, right?)
>
> If I read this correctly, the only channel where the scale gets applied
> is the INTENSITY channel, right? Hence it should be possible to chose
> the scale as we see best. (Unless the idea of this seemingly odd scale
> is to maintain the old intensity / scale values in order to not shake
> userland any more - in which case this could be mentioned).
>

The scale is applied to an IIO_LIGHT channel, not to the INTENSITY,
which forces us to provide the scale as a value that multiplied by the
raw measurement gives a result in lux. The maximum scale in that case,
as provided by the application note [1] (page 5, RESOLUTION AND MAXIMUM
DETECTION RANGE table) is 2.1504 to convert from cnt to lux.

The same applies for the rest of the device supported by this driver
(veml6035 and veml6035).

>
> Yours,
> 	-- Matti

Thank you for your feedback, I hope my reply could answer your
questions. If something is still not clear or simply wrong, please let
me know.

Best regards,
Javier Carrasco

Link to app note: https://www.vishay.com/docs/84367/designingveml6030.pdf [=
1]

