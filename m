Return-Path: <linux-iio+bounces-26956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA3CAE368
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 22:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC0F3066DD1
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422D2DF13F;
	Mon,  8 Dec 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVpPqNLb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5E281341
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765228662; cv=none; b=QqTZRi3T4PnK3OI0s2u2IfVFp52DHgVHO0t+zGEjbXT7zCJ5PzWTy8agg9JTkyad3l+w8atsD12nLB1/MsgsM0o+zvQYUVL0wzYempIKhD7Um7zEaIkCu7755ueh4ieXyyAHYdNQzOoDZtlTqtwMYSzSCAvucMYMBeD9bdheP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765228662; c=relaxed/simple;
	bh=NNqIvuGpLjQMPEj4QC/nBJ+WPSIvMTF2BhAIRM29pSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGA0w5j3Q16zMGP7rv0O9y/5svUsC9HWyPP1OM44nlFgf+UIEDLGBJXRczrcwH6XB7ySnw7kqxrJt7kASbGiEjtoZ8E6yM6qNLCaCDm2N+ZqqcKKAR+2oBmJtu88K8LiK0wxBB8Oyj0XQEBO4IxsQ3ewL39v6hH4U6KPv/eV2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVpPqNLb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so3802547f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 13:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765228657; x=1765833457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjAa+tL8foDO4YKK+oOCQIucxN94BgeKXz19r3glztc=;
        b=aVpPqNLbwgtAWViJfxpEtUeN2oplDsYSe//8dM9eJK0JtVUJ1Fay0s1isIDIeffrb8
         jjWnnz42rgp0Y2mZ+iQF2ZLEl5VS2JLiP6Bve0PtBxEFUFMY8HvyLOR+fJQG5sf/83b7
         YAYMEbPJTdwNb+hwqLDBeRXadX2f7mY0SzweEc+zfcPef3Rhmp4VIr+2BpYklFeWIhiz
         aYMykyZmHfULkQ6d0iMQk0rg/REl26hciJdoQYgnZgC+GEYsb+2P9J/tRiDYDMXROG6E
         kWhQxt01xDE2DrUdn+J6lwgYACcAKAJLUzclALPIpqHZu/EMkZJN1i4M4VdhqQ5jergr
         eZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765228658; x=1765833458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjAa+tL8foDO4YKK+oOCQIucxN94BgeKXz19r3glztc=;
        b=UdviCoAriRszC2rifpPj/VlAfgaNQG2g8AohDDwS81QphzCfu82VLL7g6drC3FX9c0
         Kt5N8s8gWCjQYZnfir6VYl+TUm8G7LnqZ/NO+Si2/B0UeguovLIEyDyv5JbHjiCuAZVY
         i4+AkzdWVbc+hlRLo2L4UNKke+hW3rWU089L6cFF5tOJAbaZDkTgMI9yWHhVs5KmSrtK
         tc7lkFXBz4aPIFdRE2i+c8LOfRZXi3BofqTw+oTt8U19Ns4frWjfQ35huC0z6X6w8/RJ
         yz8jp3W0AF65xOWz9ZfystjBwe6Qgqftvc23gi+iZxVS45UvDfti8qIzJwjEq8jSqxKs
         d5cg==
X-Forwarded-Encrypted: i=1; AJvYcCU/wIHgCB7SjQ0UMg5rht2nuf25+KCUtcs7M9uQ8se3ldeLrdpRNKwqMFNajJ8hubSoyiTCuWmxs6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIgt53z3B7H6mWD0J+dtSkn0VTcnOhdFA77sKYfKQx50ZhaWU
	GE29zU4RsKKvkIbrdbGyZIUMinLH2FEXDLxJC8JEcPM5VI91OmbRVW1W
X-Gm-Gg: ASbGncsoKq6UNmTAXBgpqK1WHO1bhbzTC3QkIgyVQeRfp5oswAhpOpwhfMSWEAnTx5t
	bANlNmDasFKBOun8q1uPrEwlg1jZQHTiIZBxgHrQC1glSqXtYYbkWfs0XQjk3OwqqEjgZ9UCMtE
	FQ9vu2YFKBO+KtHHqKQLh9b649oYM85xM2hHWk8b11tV6jjIGVPNrFFiRnMK2c8p3Th1zSFmPDg
	BUtk+QtGAljiaNLcFuKCOhRcXDSAANIfW/3ozd53XGz9H3tDIy1ivvCYv5KHPaJk/OxxyHY4pVX
	lHijvb3qOBt4XXYl5Ja9/+wcCu06/nAi7Ad0Zt42pxsf3f520JkhvWbmJOQSdE7hecAOhd17zE5
	2oCfK0ChJLg3iHsIAmYbf12URHaIZ/ADH6pHEi6p/qTjCjfXdgRTmOgbhO3fP8P/qBu8p11lmTn
	7SqXz/lRgE/h7b2Q10Nw/rqCG2Ej/4UXmJeMlsKY6nWDuOIlBjk3N57NLb6Ftyh1bQn8kcP1XRZ
	HeB4g==
X-Google-Smtp-Source: AGHT+IGNd59VvLmychchreSMZoeBMpONDnnmpIEaET4vlM4skg+riGq4zi2jQMnjOwK9B+g2Ewuf+A==
X-Received: by 2002:a05:6000:178d:b0:42f:8817:7ed with SMTP id ffacd0b85a97d-42f9df56428mr882799f8f.30.1765228657426;
        Mon, 08 Dec 2025 13:17:37 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1226:7701:cdbc:9893:8abf:1309])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226e7sm28774409f8f.27.2025.12.08.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 13:17:37 -0800 (PST)
Date: Mon, 8 Dec 2025 22:17:20 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 5/9] iio: adc: ad4062: Add IIO Trigger support
Message-ID: <h6d6bjuhb4ovnz5jghj4h3vkcqzypzbdgi5ufdmbv24x34a3px@nawt5lt7dsux>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
 <20251205-staging-ad4062-v3-5-8761355f9c66@analog.com>
 <20251206174503.3c008cea@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206174503.3c008cea@jic23-huawei>

On Sat, Dec 06, 2025 at 05:45:03PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Dec 2025 16:12:06 +0100
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
Hi Jonathan,
> > Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
> > signal, if not present, fallback to an I3C IBI with the same role.
> > The software trigger is allocated by the device, but must be attached by
> > the user before enabling the buffer. The purpose is to not impede
> > removing the driver due to the increased reference count when
> > iio_trigger_set_immutable() or iio_trigger_get() is used.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> 
> +CC Rafael; I'd like input on the ACQUIRE + take extra reference pattern
> and whether Rafael thinks it is a good idea!
> 
> > ---
> >  drivers/iio/adc/Kconfig  |   2 +
> >  drivers/iio/adc/ad4062.c | 188 +++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 175 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index e506dbe83f488..ddb7820f0bdcc 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -74,6 +74,8 @@ config AD4062
> >  	tristate "Analog Devices AD4062 Driver"
> >  	depends on I3C
> >  	select REGMAP_I3C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say yes here to build support for Analog Devices AD4062 I3C analog
> >  	  to digital converters (ADC).
> > diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> > index 54f7f69e40879..080dc80fd1621 100644
> > --- a/drivers/iio/adc/ad4062.c
> > +++ b/drivers/iio/adc/ad4062.c
> 
> > +static void ad4062_trigger_work(struct work_struct *work)
> > +{
> > +	struct ad4062_state *st =
> > +		container_of(work, struct ad4062_state, trig_conv);
> > +	int ret;
> > +
> > +	/*
> > +	 * Read current conversion, if at reg CONV_READ, stop bit triggers
> > +	 * next sample and does not need writing the address.
> > +	 */
> > +	struct i3c_priv_xfer t[2] = {
> > +		{
> > +			.data.in = &st->buf.be32,
> > +			.len = sizeof(st->buf.be32),
> > +			.rnw = true,
> > +		},
> > +		{
> > +			.data.out = &st->reg_addr_conv,
> > +			.len = sizeof(st->reg_addr_conv),
> > +			.rnw = false,
> > +		},
> > +	};
> > +
> > +	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[0], 1);
> > +	if (ret)
> > +		return;
> > +
> > +	iio_push_to_buffers_with_timestamp(st->indio_dev, &st->buf.be32,
> > +					   iio_get_time_ns(st->indio_dev));
> 
> Use push_to_buffers_with_ts() (this function is deprecated)
> which would have had the helpful result here of pointing out the buffer
> isn't big enough for the timestamp.  So this will write the timestamp
> over later fields in the st structure.
> 
> Given that this sometimes fits in a be16 I wonder if it is worth
> storing those in a be16 element of the kfifo. That will halve it's size
> if the timestamp isn't enabled which would be a nice thing to have.
> Storing in a be32 isn't an ABI issue, it's just a bit unusual
> so if I'm missing some reason it makes more sense then fair enough.
> 
Per last e-mail, due to ad4062 burst avg, it will be kept as 32-bits.
	const bool is_32b = st->chip->prod_id == 0x7C;
	const size_t _sizeof = is_32b ? sizeof(st->buf.be32) : sizeof(st->buf.be16);
	//...
	iio_push_to_buffers_with_ts(st->indio_dev, &st->buf.be32, _sizeof,
				    iio_get_time_ns(st->indio_dev));
> > +	if (st->gpo_irq[1])
> > +		return;
> > +
> > +	i3c_device_do_priv_xfers(st->i3cdev, &t[1], 1);
> > +}
> 
> ...
> 
> > +		{
> > +			.data.out = &st->reg_addr_conv,
> > +			.len = sizeof(st->reg_addr_conv),
> > +			.rnw = false,
> > +		},
> > +		{
> > +			.data.in = &st->buf.be32,
> > +			.len = sizeof(st->buf.be32),
> > +			.rnw = true,
> > +		}
> >  	};
> 
> > @@ -687,6 +782,55 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
> >  	return ret;
> >  }
> >  
> > +static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> > +	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> 
> This may also be affected by Rafael's patch set to provide some helpers
> to make this more readable.
> 
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4062_set_operation_mode(st, st->mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* CONV_READ requires read to trigger first sample. */
> > +	struct i3c_priv_xfer t[2] = {
> > +		{
> > +			.data.out = &st->reg_addr_conv,
> > +			.len = sizeof(st->reg_addr_conv),
> > +			.rnw = false,
> > +		},
> > +		{
> > +			.data.in = &st->buf.be32,
> > +			.len = sizeof(st->buf.be32),
> > +			.rnw = true,
> > +		}
> > +	};
> > +
> > +	ret = i3c_device_do_priv_xfers(st->i3cdev, t, st->gpo_irq[1] ? 2 : 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_get_noresume(&st->i3cdev->dev);
> As per my late reply I'm not keen on the double increment as a complex way
> to steal the ACQUIRED() reference. Might be better to just factor the stuff
> where you currently have acquired a reference out into a helper and use
> the traditional runtime pm calls in this outer function.
>  
I will use a helper pm_ad4062_monitor_mode_enable() and
pm_ad4062_triggered_buffer_postenable().

> > +	return 0;
> 
> 
Best regards,
Jorge

