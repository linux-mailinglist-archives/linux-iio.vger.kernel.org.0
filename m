Return-Path: <linux-iio+bounces-19253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C4AAE9FF
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93B4520358
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A1A1DDC23;
	Wed,  7 May 2025 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmhq0fTT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD304214813
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643789; cv=none; b=fHWH5tkWjNRTNRNFA653Wfe7EZ/w9Ya9FfJ4J2EQOlQ60BdoC5dbkzuMdYLDGQUvsXA4XZbOMNKg1pDJ2D4MO6oQYu3WxMysiToAdheUNIXtZ/rcy25ceyIheWsFCQ3F6XMKR3gdBqaeypl4Lh7wOsZSTtDM+34aHj0p+HTA390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643789; c=relaxed/simple;
	bh=JU5dUNgNZCS+vg/0qo2p/Dt6nurlxL7dHhzmHZvOE/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emVh9FwwA7Oi3TTzxmsWwPhqzipofFUbkCw+yy7PCuMzTR8PR84UMn1XrpvkW9E9nRebtLfhqIR6JPE2VuQHuGbkUNwtmjffV8rP5z5dffudN1tSAA34fBfc2AeW5Y/uk/FkMDFmf9pp79UT3JnNbP2hT1Zse1JQVsnn2/NI/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmhq0fTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B046AC4CEEB;
	Wed,  7 May 2025 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746643789;
	bh=JU5dUNgNZCS+vg/0qo2p/Dt6nurlxL7dHhzmHZvOE/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hmhq0fTToEyPxjUuwpmsO8ySQ0HHIrHZad2CXOsHvKsFrd/ATZSJGD2b12qbAdOe7
	 XQV/02RMLb4pL6DginKb2/IDFQUcXO+nkObvdtgc9j5cp+0ZlNnZ0+8gblzDJsAcdj
	 Sk1tRpwKsSfVe0v3HtNG400lJTufFlVgl8u1exhycaCPJgvytfp7AqMX3G6a9Xey6b
	 mXvBRV9zqFmeUKaBrLIKZPaQ/JbJHaS2ZUwh6k26SFxG7oqYjl2iQVGEtgiEo52z0d
	 za5INkZSpqHuC1JqPqdIi8/G/daF247bgvypm/2XKSOMFJIsZr0zr3BeW42wGLos8q
	 hSs2N4+88hU7w==
Date: Wed, 7 May 2025 19:49:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: r2.arthur.prince@gmail.com
Cc: linux-iio@vger.kernel.org, arthur.prince@ime.usp.br, Mariana
 =?UTF-8?B?VmFsw6lyaW8=?= <mariana.valerio2@hotmail.com>
Subject: Re: [PATCH] iio: adc: Kconfig: add kfifo dependency to fix module
 build
Message-ID: <20250507194944.438bf897@jic23-huawei>
In-Reply-To: <20250504174643.40feaa67@jic23-huawei>
References: <20250430191131.120831-1-r2.arthur.prince@gmail.com>
	<20250504174643.40feaa67@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 4 May 2025 17:46:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 30 Apr 2025 16:07:37 -0300
> r2.arthur.prince@gmail.com wrote:
>=20
> > From: Arthur-Prince <r2.arthur.prince@gmail.com>
> >=20
> > Add dependency to Kconfig=E2=80=99s ti-ads1298 because compiling it as =
a module
> > failed with an undefined kfifo symbol.
> >=20
> > Fixes: 00ef7708fa6 ("iio: adc: ti-ads1298: Add driver")
> > Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
> > Co-developed-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
> > Signed-off-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com> =20
> Applied and marked for stable

So we had a clash between this which was in the fixes-togreg branch
with a tidy up of ordering that was in the togreg branch.

Given this wasn't a new bug, I've shifted this to the togreg branch so
I could resolve this without much mess (the ordering patch was way down
my togreg branch whereas this was near the top of the fixes one)

Slight delay in this fix getting upstream as a result.

Jonathan

>=20
> > ---
> >  drivers/iio/adc/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 849c90203071..513f2238fdee 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1492,6 +1492,7 @@ config TI_ADS1298
> >  	tristate "Texas Instruments ADS1298"
> >  	depends on SPI
> >  	select IIO_BUFFER
> > +	select IIO_KFIFO_BUF
> >  	help
> >  	  If you say yes here you get support for Texas Instruments ADS1298
> >  	  medical ADC chips =20
>=20
>=20


