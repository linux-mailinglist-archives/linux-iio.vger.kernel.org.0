Return-Path: <linux-iio+bounces-6091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202FF90154C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67C02820C4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4871CD39;
	Sun,  9 Jun 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMAtueyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D70D51E;
	Sun,  9 Jun 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717925092; cv=none; b=kfU2hTl2GvAwcjs+1wjHfWWFTYU1Pui7h7kOHYWM6W9dGQiaXK9gDpn/PDk3cz8XdGAUBsuaPY8MR1Vx6aOyUFd/wCUY7R3pWyl7VGuea0pss7Tf1KukcLin3btYAA1zh5ySofuWm4B6YkqyizQ1yBKQnkqxHm2encmE2EFlEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717925092; c=relaxed/simple;
	bh=xpS2UVJTHLfMzGovcrHDahu4ifYS5FIZ4ZUPdzJlcgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuapQZBqQlYn+yqROygheABTulO2KJZ6NEvjEtD4iJj8INHqqXMBKkw5koFNOnWvP+qejDif4uDDtzPSDG8HAm9LlUuGQJh3wSnuTcw7UhfMiZkU65Mr8IKeaYvm/tmhH+dUule4kNBt6nUhCuIaNQtUzGX/bpabiECxwjQsRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMAtueyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BCDC2BD10;
	Sun,  9 Jun 2024 09:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717925092;
	bh=xpS2UVJTHLfMzGovcrHDahu4ifYS5FIZ4ZUPdzJlcgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMAtueyWTaoEuVOVe3xpC/L/XE5zn+t5KALBqOssMFZYtBaly6LxL2DlN7gSR/1sv
	 JhGa3KPtdK9jfHGK0caFDrDoT6114G/j88bDeOnKNseJavFrus+CwrdBceEG7Ih4mu
	 wXOV+HZutP8EJHEIF4/gWo0PldV276ZeaqUFtEkPHJtRvwtdKCtXY7ulOAJoc0fEjA
	 j0vgHNTrioeSgZMYzPp9x+L7QB1HhwyRhVCqjyjSD7M2kMGiTinoawyTZzTYXTXqWZ
	 acozRdNaNL1bP/+vp7kTbl8KVC0NIR1p5c6MxS/p1QluWJhk3pDnM+SG7WmpADJQC2
	 G9Ttgxc8zLVSA==
Date: Sun, 9 Jun 2024 10:23:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, marcelo.schmitt1@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 6/6] iio: adc: Add support for AD4000
Message-ID: <20240609102354.02aa1128@jic23-huawei>
In-Reply-To: <e92871489d416e4f8a350fd24fc5ed0012b3cf2b.camel@gmail.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	<e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>
	<e92871489d416e4f8a350fd24fc5ed0012b3cf2b.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +
> > +static int ad4000_convert_and_acquire(struct ad4000_state *st)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * In 4-wire mode, the CNV line is held high for the entire
> > conversion
> > +	 * and acquisition process. In other modes st->cnv_gpio is NULL and
> > is
> > +	 * ignored (CS is wired to CNV in those cases).
> > +	 */
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);  
> 
> Not sure it's a good practise to assume internal details as you're going for
> GPIO. I would prefer to have an explicit check for st->cnv_gpio being NULL or
> not.

Hmm. I had it in my head that this was documented behaviour, but
I can't find such in the docs, so agreed checking it makes sense.

I would be very surprised if this ever changed as it's one of the
things that makes optional gpios easy to work with but who knows!

+CC Linus and Bartosz for feedback on this one.


>   
> > +	ret = spi_sync(st->spi, &st->msg);
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> > +
> > +	return ret;
> > +}
> > +

> > +static int ad4000_config(struct ad4000_state *st)
> > +{
> > +	unsigned int reg_val;
> > +
> > +	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
> > +		reg_val |= FIELD_PREP(AD4000_CFG_HIGHZ, 1);
> > +
> > +	/*
> > +	 * The ADC SDI pin might be connected to controller CS line in which
> > +	 * case the write might fail. This, however, does not prevent the
> > device
> > +	 * from functioning even though in a configuration other than the
> > +	 * requested one.
> > +	 */  
> 
> This raises the question if there's any way to describe that through DT (if not
> doing it already)? So that, if SDI is connected to CS we don't even call this?
> Other question that comes to mind is that in case SDI is connected to CS, will
> all writes fail? Because if that's the case we other writes (like scale) that
> won't work and we should take care of that...

Definitely needs describing and all configuration sysfs etc needs to be read only
if we can't control it.

> 
> > +	return ad4000_write_reg(st, reg_val);
> > +}
> > +

Jonathan

