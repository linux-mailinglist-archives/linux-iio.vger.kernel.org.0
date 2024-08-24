Return-Path: <linux-iio+bounces-8757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B095DD7C
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 13:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524D51C211AD
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC7156C74;
	Sat, 24 Aug 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOR89TlK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171E154434;
	Sat, 24 Aug 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498293; cv=none; b=paqjy+BxeQBk0X+0sMoUeh31sjHWaLhS1CQH+QLfdNlHQz1HTdXfQ70Sk+/gwLRSESYKbfGlueWF8xeNrRbctMa51t9HiyuhjWN2PCe0I46AyMkXHSkofzaS0yVPWFZONNryEO3mahqVtvSbGw9wN7PoCCU7YSgsjHi6j6mHBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498293; c=relaxed/simple;
	bh=73akXDIT6x+t8HVba2/WfACcRmVzxu9G1QEECH+1q54=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcDov3xDLrCdVRuf//mOZK4in11x0WS5XQ9cMEqSexrgSF+qCQnt72spPJ7H/whQhPPjgHHyPX0LIu7DsZoc36dI8n1JYiQ1Cd/zIcaHWefSFPY0+UcnJ+Kpk1OhHDvQ1Zy4Rwbc/fuuQCO9BKrorjHm4jFzO03z37s0KA4y8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOR89TlK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83562f9be9so282546766b.0;
        Sat, 24 Aug 2024 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724498290; x=1725103090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/A6F6r+xpUjirIExuOh0Ulxu8srp4hJUZW216K+I750=;
        b=QOR89TlK35GlMjbpG32Wuhm6pL0+lnjgJQH/VJc8wVI6hvJIRfahaBDroAwA6gCCfd
         c2QORE+PqiEwGokCP8u1lw5zHn4AGu+QMNW3n8+2UTQXnMY9STQfNXH7lQ0E3NrNwFYI
         Un7rZ3Vj6/Tbacm0nEROJXaSlqNPXDkO4gcrYeXxDM5QUyR6vVsx7FdzZUWFYXy76E0E
         kBn0DmPZcfqH7yR0dzeki5vblvNTNfYemswaflrJHs1X+kK45d6x7vYnAUo6IRLTnRlj
         6uVJB9Cro32Ge7fYhzPETcntF2fQQIBxf2+PT2D7Th0jFeLdybUWvJ4xbHu1pHuNom6s
         nFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724498290; x=1725103090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A6F6r+xpUjirIExuOh0Ulxu8srp4hJUZW216K+I750=;
        b=d3d7rXZc78TDSvloUTnrOjYMoZFrQoRDGgMsbfn+BmUFnI2Cn+EM1zDd6k2o/q+h2N
         hHLd8ajuXvjI55H660drBOr6kzo2DC2JRtkPNr9249qH0eUgtEznEFpsapxHMKn2O4rv
         dABjUFKT47faUkxxXPrmBg98tlI74ik09HD04H6Ek7qc6HdnNPl5GVaP6uFK1q+LJInb
         rSKVrRltXqTaOBjytC2uCLo0xffTNU368qnUH9onbwBRpEvnisDqv4QIPa5lMrRPMpQF
         jMHBKn6QffWLDhmflrH8YbBWiSv62+7sxALaDaVYTA/+NRkg4uUByXHA5R1VfSsdkcKq
         vvbg==
X-Forwarded-Encrypted: i=1; AJvYcCWJd1iNoYdGFmg/7+uedFcUnnFGa3ZqWjIsWtvDDilYpFuEjDWuFUZAs7nKlZwu8eqR+8cXmz3Q3FyTC6A5@vger.kernel.org, AJvYcCWlY1XL1nBW/YgfdXycMky1fPz0jmuOGt8xx30q1/kLOUj/bLfyVSeblp3auzhictm8y7doRmUTmOXg@vger.kernel.org, AJvYcCX5H/bQ7ReOdEhDHgkbZ5M0Ecxlb+2L/U6L2xweVfsDGMvPSWIMyv40k4O1+q6EukIuCw/kKRZZVG46@vger.kernel.org
X-Gm-Message-State: AOJu0YzeszEBEflT++q2NlBQG3ePIdG4+EefHs4tPyRm99MkMrrSOLAN
	KzJCWD7KtV10ZzNoXdwIm2ALgNYoXOmnMI1TauGCNILQzIT0Dx22
X-Google-Smtp-Source: AGHT+IGzB2eHKwoUui/j53rDbfKAjdc8hNAQs+DFcvnxm80hKS/EoGaluVwNhqbI/KoHGSyiqnmMEQ==
X-Received: by 2002:a17:907:728f:b0:a71:ddb8:9394 with SMTP id a640c23a62f3a-a86a52c6177mr311743966b.40.1724498289368;
        Sat, 24 Aug 2024 04:18:09 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47c579sm387041166b.153.2024.08.24.04.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:18:08 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 13:18:06 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iio: pressure: bmp280: Remove config error check
 for IIR filter updates
Message-ID: <20240824111806.GC9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-4-vassilisamir@gmail.com>
 <Zsjf0bVLZyPqBxru@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsjf0bVLZyPqBxru@smile.fi.intel.com>

On Fri, Aug 23, 2024 at 10:15:29PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 08:17:10PM +0200, Vasileios Amoiridis wrote:
> > When there is a change in the configuration of the BMP3xx device, several
> > steps take place. These steps include:
> > 
> > 1) Update the OSR settings and check if there was an update
> > 2) Update the ODR settings and check if there was an update
> > 3) Update the IIR settings and check if there was an update
> > 4) Check if there was an update with the following procedure:
> > 	a) Set sensor to SLEEP mode and after to NORMAL mode to trigger
> > 	   a new measurement.
> > 	b) Wait the maximum amount possible depending on the OSR settings
> > 	c) Check the configuration error register if there was an error
> > 	   during the configuration of the sensor.
> > 
> > This check is necessary, because there could be a case where the OSR is
> > too high for the requested ODR so either the ODR needs to be slower or the
> > OSR needs to be less. This is something that is checked internally by the
> > sensor when it runs in NORMAL mode.
> > 
> > In the BMP58x devices the previous steps are done internally by the sensor.
> > 
> > The IIR filter settings do not depend on the OSR or ODR settings, and there
> > is no need to run a check in case they change.
> 
> ...
> 
> > +	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
> > +				 BMP580_DSP_IIR_PRESS_MASK |
> > +				 BMP580_DSP_IIR_TEMP_MASK, reg_val);
> 
> Better to split on logical bounds
> 
> 	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
> 				 BMP580_DSP_IIR_PRESS_MASK | BMP580_DSP_IIR_TEMP_MASK,
> 				 reg_val);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


This goes beyond the 80 char limit. I know that there is the relaxed
limit of 100 chars but I didn't feel it was more readable like this.
I could definitely use it though, thanks!

Cheers,
Vasilis

