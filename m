Return-Path: <linux-iio+bounces-23325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AC6B37861
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 04:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7064362349
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 02:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4187304985;
	Wed, 27 Aug 2025 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzRP5HjE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A41F239B;
	Wed, 27 Aug 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756263472; cv=none; b=CEeoWwype3dTrJj3ep6AJVzaq+/tqPxEnUzZOWF5V1DAb9wWutQ3/7KLOpcpLfkpThLzOUfkel4AUMeIwq3zTVAqMsa9jeZgJpJ2nf5IMmAihBHVYh70D3qjOpE2cuSpGYmpswECr/QuiMID4/8+zNOnbfwSZMD7AZgy90HhtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756263472; c=relaxed/simple;
	bh=OS9XKGKCwfQ81ImIRQTTnSNG/ZJnad/H3FjTp1backo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpwFoKgDQmBFs82VvM2ss46I4MutlWm+9I422dCFUD0AzSpswlzKYhm+fPtfUkUOT9GI6AHzrGtQkZkB45Sa2t0L/UePjXYjB1rtNdNZ3I+gFKoiSm7lnvxXHS49SxKabbHA6LN5ejdbsTAAciCnfyFlzYYyM83mDCm67R1PEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzRP5HjE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b2e15925baso3601561cf.3;
        Tue, 26 Aug 2025 19:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756263470; x=1756868270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HBZCpsuQnPL+5lAKzEnCUX7wus/0U9FS0iIyVBA2aY=;
        b=DzRP5HjEQ1Rs4uzF5RMZ7Er9TnKZyNmUFok/3gzHc78VENKFlqR8QDfrU0YOIxyFbE
         jUflP0QCre1XbMT+4b+V1RuESDEWohbJa2Mj5g0R5hZi3xRAe2DlPv7m589NlDAeae7R
         pD5aSO/F7IaZEOdqhog5TbnKaGbshNRmPWD9FDiUIIjCKReiecIagz8g+K731WucRtfx
         1WGqKZXGcpvPwI5Ko5LukfVvXrMS1+gmAD4AheCX8L2OCMPaDwanZ3pRJZJCvtfilMNQ
         /DvUpNNWDyEcIIWpBc30yY4rYokfe53dP68OjFFr193rHMcuk2gLwUrfBdhPG3KP50YO
         XUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756263470; x=1756868270;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HBZCpsuQnPL+5lAKzEnCUX7wus/0U9FS0iIyVBA2aY=;
        b=mCknAHuSmlpIvKw8DMK559QzcLwyJySW0UsSm/qsjV+/5wdK+hY9zwYb0mguqEt7Kr
         v+w7QO7DIRTcOQl8AFmLYACbrBPlZWX+04AcRqzAOulTMJ0SFQJssI3GbFq57o7UAxM/
         TuXb3K0Asows3IPmSK7tB0o/v4eQ3ATFkMkOZ/i7vGrWgWCtP9XLet/JxQeMQqF7/Vpu
         xP70D8t9k50WH6GiRPE+4aJBKtWusBv4guaAiOO6TRAQ2W7u9/DeDlPUxtI57fCYzSa/
         jJxwU+2jtmMPoApEO+G0rXUyzu5AaL0sLCUxWjHbE2lEjIOck/xs/2RRerCPypnqixUi
         0akw==
X-Forwarded-Encrypted: i=1; AJvYcCUG7bKXTgwgl4hvJDAFbWe56Lk1ZDHp3TCLNqm8HadYuzl716EExaGXVxpL5TtGWwtRAfBNpaIlE/KHRRlD@vger.kernel.org, AJvYcCWdkOr0cg1w9XB8Yb0Ye2REEiTUD7l94gJzGR0pChQ0CNNAlEApu7NQIcc149/s1P4bRupxZSGLYFKh@vger.kernel.org, AJvYcCXEm+9bdTWsuuCwyPe223iezLjCS+L2TyZLfCUl+xBAvwDgyf039zvt7BWFQsQJ+9X3pAfP6spUneXY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5oDBsqal8+fY28bgRR5xXZRKrkKpIe8gp5pREQK4n9ZPZPobI
	1VRK25/NPCb9UjPTS9ot8xQEhuF2XZ1dYMlhY01jpc7eulkjap/OheaP
X-Gm-Gg: ASbGncv5VH4lwz5+SzSCMm8siwKXENbKOTqw/8xbLXhCIRxZMxJKxLcuHLkGoZE8wUd
	xobahltqn0qleHOWAisCOFDyJI3Fr5eTPwVtqceF84AJM9SEFcuuoEwL4FLX9xUCO51+3MjyNg5
	4mSIj8tnACuZWsZz/toW6HGXo+bm401t2cPU4TlvxDE00bI/olztgNIadOokmOx6NkTNHNsRbsR
	inAa5z+wt4/mB+6t+/qJ7OQi0//mEgIV9GMP10bZ11yFR0cyq4ODSRm+SHImSV+qtttKxMgM8zU
	yz9nvF8D23WS79Q51wFQQdMWxitHYkFOPPieKMePAFvANlwv+6Tl7ARKudRxXdJnQoPAPpfheDv
	6AGGZfCUcgPFiBNRpPDZYlDVhzY4fhYCrBzgFJBOg1FNLEMb1VuOs9s5gl+N4ONHpMZkLcgtc3g
	x2IY+1KV8=
X-Google-Smtp-Source: AGHT+IFSfa5GYk5QmCJjdHdRMKQADkgfyX6o0m9SGO3yxL81gJezgkl6751jBAPS2FI2TkNOz1tVTA==
X-Received: by 2002:a05:620a:4590:b0:7e6:28a9:db0d with SMTP id af79cd13be357-7ea10f5a14dmr1443206985a.1.1756263469617;
        Tue, 26 Aug 2025 19:57:49 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com (200-100-113-66.dial-up.telesp.net.br. [200.100.113.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7f0929c268asm528589485a.35.2025.08.26.19.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:57:49 -0700 (PDT)
Date: Tue, 26 Aug 2025 23:57:44 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Michael.Hennerich@analog.com,
	lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <aK50KITsXoPTkRbA@JSANTO12-L01.ad.analog.com>
Reply-To: 20250825154450.75eedc9b@jic23-huawei.smtp.subspace.kernel.org
References: <20250824041013.9872-1-Jonathan.Santos@analog.com>
 <20250825154450.75eedc9b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825154450.75eedc9b@jic23-huawei>

On 08/25, Jonathan Cameron wrote:
> On Sun, 24 Aug 2025 01:10:13 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
> > Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> > Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> > provide a VCM regulator interface.
> > 
> > The PGA gain is configured in run-time through the scale attribute,
> > if supported by the device. PGA is enabled and controlled by the GPIO
> > controller (GPIOs 0, 1 and 2) provided by the device with the SPI
> > interface.
> > 
> > The AAF gain is defined by hardware connections and should be specified
> > in device tree.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Hi Jonathan
> 
> Various minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 
...
> >  	/* Register VCM output regulator */
> > -	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
> > -	if (ret)
> > -		return ret;
> > +	if (st->chip->has_vcm_regulator) {
> > +		ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	st->aaf_gain = AD7768_AAF_IN1;
> > +	ret = device_property_read_u32(&spi->dev, "adi,gain-milli", &val);
> > +	if (ret && st->chip->has_variable_aaf)
> > +		dev_warn(&spi->dev, "AAF gain not specified, using default\n");
> > +
> > +	if (!ret && !st->chip->has_variable_aaf)
> > +		dev_warn(&spi->dev, "AAF gain not supported for %s\n", st->chip->name);
> 
> I'm confused.  If you hit this warn, you then go ahead and set it anyway. How does that
> work?
> 

I would be setting a variable that will not be used, so no functional impact.
I could add another condition to avoid assigning it, or do you believe it
is better to return error like before? 

> > +
> > +	if (!ret) {
> use a local bool for ret here with a suitable name. Carrying on using ret is
> fragile against later code changes where someone doesn't realise it is still in use.
> 

Maybe it is better to handle this in a helper function and apply the
suggestion.

> > +		/* If provided, validate and set the gain */
> > +		switch (val) {
> > +		case 1000:
> > +			st->aaf_gain = AD7768_AAF_IN1;
> > +			break;
> > +		case 364:
> > +			st->aaf_gain = AD7768_AAF_IN2;
> > +			break;
> > +		case 143:
> > +			st->aaf_gain = AD7768_AAF_IN3;
> > +			break;
> > +		default:
> > +			return dev_err_probe(&spi->dev, -EINVAL,
> > +					     "Invalid firmware provided AAF gain\n");
> > +		}
> > +	}

Regards,
Jonathan S.

