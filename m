Return-Path: <linux-iio+bounces-18702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A8A9DBD2
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A691BA6AFC
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEEC25CC75;
	Sat, 26 Apr 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJIO5SeP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95D1F873B;
	Sat, 26 Apr 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680701; cv=none; b=jNuqkNqsey3PsnDB7tQZEqmCOkk0qDOId24ZJ/DOsPnVhphNwtABWig2q0Rvyj9Zr0/xpjNlNOhGpieogxfyXfDc9NVJP83TlGeN9/m9GWZpcL+dX8o0YY6+thbOJaQtXLhVUltlyByiKu9vUuJxS0A8ltPzv1qHORKmQCjLtoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680701; c=relaxed/simple;
	bh=C7/O7O0dxVQ3nzhqfm/kahbYvAquYBqLQUriqFqOhdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfCuFI0fxB3x9UfO6l+PBeYb5/LxV+q6GyrKGSeeKftGCOuSDWSBq6zH7X0gtD1Kiy0txTW3yoOgrLKrSdse0ucvGkFBbQX7gDXMPUU8XRMW+ghqRdugmTpfWigLaON+RVi95pDQqvfl/as1ZyMifNtHImXIxxJh7d1vL7jnDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJIO5SeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83F8C4CEE2;
	Sat, 26 Apr 2025 15:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745680701;
	bh=C7/O7O0dxVQ3nzhqfm/kahbYvAquYBqLQUriqFqOhdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJIO5SePF0aMU+NxRvKnLSDMepsmyLJmU8MaMlJ5TxECbGculKZBrSfZbJgoA+dF7
	 oYV8Xw0lmZp4w8/D9SgL0WtROCvDb8S0kRHOum+ULkNKx+bzKHPElXGBK6iNfk0f45
	 MlX+AXvg2rAHfTvZCJb96RjXNyqsUR5xkL8hnBsUTsekk+wJWNx7jIQUFAfpk1wAaO
	 A19omaMh3AtqWYwoSbmc5OI3m7QzXsjOPCzC69pBJq0mdA9RRvTRoFvEeTWKs2EY/d
	 uvxKy4H7kAPCMyLf4/IP1WRQAF9ezglojT4qbuGEAuQFRv511kjKFmx3jwQZ4CPesp
	 q5/smRjEMyimQ==
Date: Sat, 26 Apr 2025 16:18:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Guillaume Ranquet <granquet@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ad7173: fix compiling without gpiolib
Message-ID: <20250426161814.1bbf7f82@jic23-huawei>
In-Reply-To: <CAHp75VfHkKC81EinO+oN1b0=NRkwmNBLPky=HkrvPJCmt4njDQ@mail.gmail.com>
References: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
	<CAHp75VfHkKC81EinO+oN1b0=NRkwmNBLPky=HkrvPJCmt4njDQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 00:03:38 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 22, 2025 at 11:12=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote:
> >
> > Fix compiling the ad7173 driver when CONFIG_GPIOLIB is not set by
> > selecting GPIOLIB to be always enabled and remove the #if. =20
>=20
> I'm not sure we need to select GPIOLIB. If you want it, depend on it.
> GPIOLIB is not a hidden symbol, so why "select"?
>=20
> > Commit 031bdc8aee01 ("iio: adc: ad7173: add calibration support") placed
> > unrelated code in the middle of the #if IS_ENABLED(CONFIG_GPIOLIB) block
> > which caused the reported compile error.
> >
> > However, later commit 7530ed2aaa3f ("iio: adc: ad7173: add openwire
> > detection support for single conversions") makes use of the gpio regmap
> > even when we aren't providing gpio controller support. So it makes more
> > sense to always enable GPIOLIB rather than trying to make it optional. =
=20
>=20
> ...
>=20
> > Not related to the fix, but I also question the use of the regmap here.
> > This is one of the ad_sigma_delta drivers that does funny things with
> > the SPI bus, like keeping it locked during the entire time a buffer is
> > enabled. So, if someone tried to use a GPIO during a buffered read, the
> > GPIO call could block (waiting for the SPI bus mutex) until the buffer
> > is disabled, which could be an indefinitely long time. And to make it
> > even worse, this is not an interruptible wait, so the GPIO consumer
> > would effectively be deadlocked. =20
>=20
> I would say either the entire buffer mode is broken (in software), or
> hardware is broken and GPIO shouldn't be supported at all if the
> buffer mode is enabled. I think the best solution here is to remove
> the GPIO chip before enabling buffered mode. If GPIO is in use, fail
> the buffer mode.
I'd kind of assume that anyone using these GPIOs is doing it in a fashion
related closely to the ADC itself.

Can we make any other use fail more cleanly?=20

J
>=20


