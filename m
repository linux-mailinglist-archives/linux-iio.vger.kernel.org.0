Return-Path: <linux-iio+bounces-14337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5022CA0FE0C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 02:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65847167632
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 01:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA90224B19;
	Tue, 14 Jan 2025 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI1nQC4b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6FEC5;
	Tue, 14 Jan 2025 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818071; cv=none; b=hx6/8X7YRaseES/SOWSedyVL5uqT+R1Oa4PzpM6OjiI5mxSExQ5n3M9Kpxcc3effkpOUdQGIIXgcBNrutt7cf+MQ+r7Kj/DeulxXB8c3uQ91M/rTRhBZGzmsOx6hmCVy+7uiiwi7afGe4nq224VnwtGG0GDJXJYVKgttyILpnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818071; c=relaxed/simple;
	bh=WCggxWWV3oV68JBkKmkabRt5is9NA4JYFDu3t/aH4a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKvOfERvmfC5MwA1zhd1cE9yHfmvo/xCAiCBNbK5KCkTz/bM+u7zJ/Er9G2Rdxlc16FBEMJP9QfRggZHO9/EI8zmTAC46TtzVzHZ1qwu7LUz1b7hmvvXrbxLB/7hX1/WBXHgPxuObGReHmHvs+SYO1RW9bnFkVwdF41p9qYFcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI1nQC4b; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b702904ec9so34955685a.1;
        Mon, 13 Jan 2025 17:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736818068; x=1737422868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6wQqjIyZG0pseRLgwiBkNM80mdE2E2o/L23/EzsOQU=;
        b=DI1nQC4bIFsoeGcNH/yqkC8WH6nOHTyxVTpc2aRlNLNf0WDdUn+QTQfP0BbevYkGgd
         LznLDcLLIsHBzbLQXhYnPbq777E5zwLQmEo1nSUPDazV0vkQTf/rMuMIPeOgj0pJ2189
         1kG9PMGIPwX0CqqaB9jR3fp78OIEAAlQQUlGVgmINvfAoZ60JG8XZzXzxKAi3DfZQekU
         Xwl128x+NZyagno1LuxsF4DQU5oCpN96ORC0w96OZDhAKUqXfAFg/zdECOp5xVsN5swc
         bhhacIizUFDp98xyroUyj0F0/kvoXKr610e5xHt7ji07T8LB0yKCgrCA5/WjQ1ea4xrv
         TMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736818068; x=1737422868;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6wQqjIyZG0pseRLgwiBkNM80mdE2E2o/L23/EzsOQU=;
        b=TGqHJr6m7LkXlL1c5h3qgFjp7cb2GtbSUnKm5oWW6Xvt0DL/hVa7N6q45BMDSL6Zwn
         QxuOt5lhNw00BVe6zBPyl2x9XGyRfEXzje2rtAiuC7fzRkT3FlpkaDDVU7c2E1zafhVI
         8FZI/+rH0FQEXqoStbhsA0Z41MuQve3hnABXcZ75MmoYSLDkXpZNZdXIWsNliK+vDCFp
         c6Z4uuVOLKgIkVNxXXK9JMSX7asgdKFbJFDZBB5FINq4EuT5U0APTAOjxX/0FBIJWHXK
         Dw5ehkNR4DHeJRsQZ8FFzsekXyLnQ2trHOGRtQo02vYf0c9bAKpbJkF7GIqMKNj+VRC2
         QJHA==
X-Forwarded-Encrypted: i=1; AJvYcCV5YuC9NQZvMvvPZ4PetsPnyeyvfLX7JYnTKvD4ESe1hTSyt+osWFji3rM9KSeZcRnE8izJDs5R0nyT@vger.kernel.org, AJvYcCXDemp6bVs6eMpblVfNoWCHbqWwTM52ZREPUWsEYfSv2nzeCK+JofvY4JjIYJ8lVLXYE5EjUfrIEYA5VBDv@vger.kernel.org, AJvYcCXQvzDqyG5T/Y2MeQqlhEBw+ycnhanXdERwrBgJ5+mhORuLaPpXaFv75f6D/NTySEPyLm5ZCqB7W1Hh@vger.kernel.org
X-Gm-Message-State: AOJu0YyZiHIay+AuwvjVX67wRQzW8XKHK7fWyB+t2N1wu+nnj3Utde7b
	IGzUjfr9C11HRnX1/e1zykoHatgTq7Cw52yPJ2P8abITUXWrj+gz
X-Gm-Gg: ASbGncvULmkIcKxonB1lJIchmtw5uijIPjWD+PA3bCfOLIewP45znAB/XxWp4ETUR1C
	uHqY6NiQFpEceh323ra7kk4L2zrlZOINMSOL/Au1ukgleFDkNjgm8jH63/1wQ/gUt6mu6RsxBmx
	Vz5WAKliv7r0c964Yi9B7vwKO9/gnDFYaUhDb2u0EwDjeV1ufvS+8Pk6ZQoEgY8JkwW142K0qoE
	qQVw1DfLc4Fx0088sB5OGAYjs35/bWVfTchcLdUGkTMiqaOrXBZEPJbHbfFU4yhkOqwitBR40H0
	fA==
X-Google-Smtp-Source: AGHT+IHo36fDgVCJSgk8h43SxIGW0pr30V3NwybNkBlh1hzdqopei/0Q9uc41O87BMYlLsXEsgdwSw==
X-Received: by 2002:a05:620a:4589:b0:7b6:dc4f:8874 with SMTP id af79cd13be357-7bcd975ddcbmr1309403085a.12.1736818068436;
        Mon, 13 Jan 2025 17:27:48 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce327bac8sm553113785a.55.2025.01.13.17.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 17:27:47 -0800 (PST)
Date: Mon, 13 Jan 2025 22:27:43 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 14/15] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <Z4W9j9/UNOMnHtFK@JSANTO12-L01.ad.analog.com>
Reply-To: 20250112125913.3ea9c71b@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <0f9a15e6e2e6b7b2c82ef79d8cb883d9eb6c55dd.1736201898.git.Jonathan.Santos@analog.com>
 <c0981545-5e0e-4b6e-93d9-cb2871b583e8@baylibre.com>
 <20250112125913.3ea9c71b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112125913.3ea9c71b@jic23-huawei>

On 01/12, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 17:50:29 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 1/7/25 9:27 AM, Jonathan Santos wrote:
> > > The synchronization method using GPIO requires the generated pulse to be
> > > truly synchronous with the base MCLK signal. When it is not possible to
> > > do that in hardware, the datasheet recommends using synchronization over
> > > SPI, where the generated pulse is already synchronous with MCLK. This
> > > requires the SYNC_OUT pin to be connected to SYNC_IN pin.
> > > 
> > > Add the option to handle device synchronization over SPI.
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---  
> > 
> > ...
> > 
> > >  static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> > > @@ -697,11 +708,21 @@ static int ad7768_setup(struct ad7768_state *st)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
> > > -					  GPIOD_OUT_LOW);
> > > +	st->gpio_sync_in = devm_gpiod_get_optional(&st->spi->dev, "adi,sync-in",
> > > +						   GPIOD_OUT_LOW);
> > >  	if (IS_ERR(st->gpio_sync_in))
> > >  		return PTR_ERR(st->gpio_sync_in);
> > >  
> > > +	if (device_property_present(&st->spi->dev, "adi,sync-in-spi"))
> > > +		st->en_spi_sync = true;
> > > +
> > > +	/*
> > > +	 * GPIO and SPI Synchronization are mutually exclusive.
> > > +	 * Return error if both are enabled  
> > 
> > Should it also be an error if we have neither? Otherwise it sounds like
> > decimation won't work correctly since there is a comment that says we have
> > to toggle this after updating the decimation rate register.
> 
> I'm not quite sure how this interacts with potential future support
> for daisy chaining but for now, if we have no GPIO specified why can't
> we assume spi sync is the way to go?
> 
> If no GPIO is provided and for a single device SYNC_OUT is not wired
> to SYNC_IN I think the board is broken anyway and we don't have to care.
> 
> Jonathan
> 

I also think it is safe to assume the spi sync if we don't have the GPIO
defined. For Daisy chaining it would be as problem if we decided for
multiple instances in case of multiple devices. With the single device
approach it still works.

> > 
> > > +	 */
> > > +	if (st->gpio_sync_in && st->en_spi_sync)
> > > +		return -EINVAL;  
> > 
> > A dev_err_probe() message would be helpful here when creating a new DT and
> > bringing up a new system since it is easy to forget a property or make a typo
> > that could lead to this error.
> > 
> > > +
> > >  	ret = ad7768_gpio_init(st);
> > >  	if (ret < 0)
> > >  		return ret;  
> > 
> > 
> 

