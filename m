Return-Path: <linux-iio+bounces-23851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6AB47AFD
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34A27B00B3
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD94262FE7;
	Sun,  7 Sep 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIYQ5x+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D41DF26A;
	Sun,  7 Sep 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244805; cv=none; b=Sv41M+a8jvRymYL9IXH63GEry8XsY9wd7VAzBGpsAFOFAHUGvkwIH7IZ45hvvBkmnXKo+SXxnuhJeH41Wje0wsJhLOxsYavogAzTdL+y2POdTJG+WDDIktgTxOm7yWeQWfLHipEEDtpBlFgwcakl3blJIxyBFLm4BqfRBJdJmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244805; c=relaxed/simple;
	bh=urBdq2a4lKJDO9ZZYNrOKJ8eTnycxkF3tJJ4jFvOdfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNJ2EGXd8GjbLCyPLuAB1wIQ8VVo21Rhy2McowGos35Cd5VpqJlhDcqtXoH9bXucm2KiHstx4aJVsdMheUQFJTRQ18LhT7U3STODxD3G/p2YhnpNFFT+KI9a6jnARrumL78T9waVY5L/Q9CIsvWWFyzeLH7FxwrW3+yJ3Gz0XuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIYQ5x+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C0AC4CEF0;
	Sun,  7 Sep 2025 11:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757244804;
	bh=urBdq2a4lKJDO9ZZYNrOKJ8eTnycxkF3tJJ4jFvOdfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TIYQ5x+d/DzPvcNJCm/NtOMsAzyL32HodhmT79zBmt8OTF6SXvDFym49sX59odxsq
	 a3DwZFKp3kV5lCDWC7TSBXtouWwd/N6WpdsgwjPsQDynZ2pd0xFjo6toSDJpSee3PP
	 efgAdpISM0uq44R0Bskd5YZC0bEAntIgwC89s+OdXyofTb6KHxvvJYuf94Fr/aqeg4
	 Axj5swrReFGxPFIzsLm8GgyjwBiuIfM8jjKs0fR2YXfWisvh7cZPREDZJWsvc6XM+f
	 x12iVxA7LzjBPz8TyCt+0m0lH/lcnpAJhjFHLcTy4FMR7WG0QdprIk3Z/pwqEhDc26
	 6Zr5zZCEfjacw==
Date: Sun, 7 Sep 2025 12:33:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Esteban Blanc <eblanc@baylibre.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Hans de Goede <hansg@kernel.org>, Herve Codina
 <herve.codina@bootlin.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250907123310.2209f824@jic23-huawei>
In-Reply-To: <2c36496c-68bb-4c06-8580-3efc694429ea@gmail.com>
References: <cover.1757053456.git.mazziesaccount@gmail.com>
	<3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
	<CAHp75VdaAH+1mh16KWoYtYFMV+_ec8x9YipeD3K8g6yQr-2VjA@mail.gmail.com>
	<2c36496c-68bb-4c06-8580-3efc694429ea@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 10:10:55 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 05/09/2025 09:54, Andy Shevchenko wrote:
> > On Fri, Sep 5, 2025 at 9:42=E2=80=AFAM Matti Vaittinen <mazziesaccount@=
gmail.com> wrote: =20
> >>
> >> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs c=
an
> >> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> >>
> >> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate =
I/O
> >> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> >> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> >>
> >> The IC does also support CRC but it is not implemented in the driver. =
=20
> >=20
> > ...
> >  =20
> >> +config ROHM_BD79112
> >> +       tristate "Rohm BD79112 ADC driver"
> >> +       depends on I2C && GPIOLIB =20
> >=20
> > Still I2C? =20
>=20
> Thanks :) I didn't spot this @_@. I just switched the REGMAP_I2C to=20
> REGMAP_SPI. Will fix.
>=20
> >  =20
> >> +       select REGMAP_SPI
> >> +       select IIO_ADC_HELPER
> >> +       help
> >> +         Say yes here to build support for the ROHM BD79112 ADC. The
> >> +         ROHM BD79112 is a 12-bit, 32-channel, SAR ADC, which analog =
=20
> >=20
> > which --> where =20
>=20
> I thought which (as a genetive case) would work here just fine?

If you had 'on which' I think it would be fine.
With just 'which' it doesn't work.  I'm too lazy to figure out exactly
why though :(

I'd probably make it a separate sentence though.  Analog inputs can also
be used for GPIO.




