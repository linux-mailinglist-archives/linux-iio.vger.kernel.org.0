Return-Path: <linux-iio+bounces-13636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FD9F7B24
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062CD189356A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1AF224898;
	Thu, 19 Dec 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CemdOb59"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF5224888;
	Thu, 19 Dec 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610839; cv=none; b=bvOGFfhIHeD8x4fKRxiXn58Mur7HCHkt+P1dbQFUPdZGge6bYGZp+fQ/jgfkwjlhaVHhI6NoP/FTPzs4Vu2i4dQ5w3P5AbkcNO3aSOZfYwFb0M1HcKsea0Z+ePkVzbr5JHLBGrOyTowtYdpjQn3l6OQaXP+smViJdBsVeWWKlOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610839; c=relaxed/simple;
	bh=oG/gbXEG/mHuSCKwaPuuo2uIRwY3FD4w9Pk7bT437iY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+tUHpo0QzLCHIjTcLlv+/4CMZOL+ql8VoX+uFpmBEpesiyoY8bRS3Ltd/rSwmaF838z56AdeWNWocIYjBUkS51JJ4ZKH3jNI6+7oCb+YMJVVP2xz4dOovZHoTZ278VniLWAbUxfUtflyLbkIvm2HtrzMr4zoF9qacmfMoWmVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CemdOb59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F47C4CECE;
	Thu, 19 Dec 2024 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734610839;
	bh=oG/gbXEG/mHuSCKwaPuuo2uIRwY3FD4w9Pk7bT437iY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CemdOb593uLG6QKc1GEGT5FuWIGnqtLCP20ugRTZKBmCyZ/Q8CEEzC7qYGPK8qZpf
	 TckqlhsL8npsSEz0vnkOxUPbHI1E8spT113bLWC19gTp53yB6ETmDnB98BP012LH30
	 A6t7ELgf42AxZuQrnxB3LIm3Lodc1u5+yP3h/s80Tl15+W1ZhhDxUi/37HR89xKcMu
	 kQDAu1OrZmve+7Dofs2NLimITOlug3gBWgaT5x0RZW0lZ1sce99FV2GTbekUVv6xFV
	 Qn10nRgp2SUB1xlrx4qSEJh1ZnNhxFJzcpB7sVwJ0g4sKlIgR0GWuuJgfj790HCpxZ
	 CBSGcX4vSToyw==
Date: Thu, 19 Dec 2024 12:20:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: iio: dac: ad5624r_spi.c - use of scan_type
Message-ID: <20241219122030.31ee7ff5@jic23-huawei>
In-Reply-To: <c1795ffa-c2e7-428f-8897-2b8846e9fa44@gmail.com>
References: <3f5ff01b-8c32-423f-b3cc-a95399b69399@gmail.com>
	<296d9e03-1153-4589-95b8-87195d7bbdef@baylibre.com>
	<c1795ffa-c2e7-428f-8897-2b8846e9fa44@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec 2024 08:05:17 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 18/12/2024 22:53, David Lechner wrote:
> > On 12/18/24 2:38 AM, Matti Vaittinen wrote: =20
> >> Hi dee Ho peeps,
> >>
> >> I started drafting a driver for a ROHM DAC. I took a quick look at the=
 ad5624r_spi.c, and the use of the 'scan_type' -field in the struct iio_cha=
n_spec puzzled me.
> >>
> >> I think this field is used by the driver to convert the data from user=
 to register format while performing the INDIO_DIRECT_MODE raw writes. I do=
n't spot any buffer usage. Furthermore, as far as I can say the 'sign' and =
'storagebits' are unused.
> >>
> >> My understanding has been that the scan_type is only intended for pars=
ing the buffered values, and usually when the data direction is from driver=
 to user.
> >>
> >> I suppose I shouldn't copy the ad5624r_spi.c use of scan_type to a new=
 driver. I'm somewhat tempted to send a patch which drops the scan_type fro=
m the ad5624r_spi.c, and adds the 'realbits' and 'shift' to the driver's in=
ternal struct ad5624r_state. This, however, will change the interface to us=
erland so maybe it's best to not do that. =20
>=20
> I think I was wrong here. I suppose plain scan_type population does not=20
> result user visible entries if buffer is not created. So, confusion=20
> stays in driver - but it also means changes wouldn't impact the userland.
>=20
> >>
> >> I wonder if I am missing something? (That wouldn't be unheard of XD). =
If not, then at least a documentary patch with a comment "don't do this in =
new drivers" might be Ok, or how do you see this?
> >>
> >> Yours,
> >>  =C2=A0=C2=A0=C2=A0=C2=A0-- Matti
> >> =20
> >=20
> > I think scan_type is a convenient place to store this information even =
if
> > buffers aren't implemented. The struct is there whether we use it or no=
t, =20
>=20
> Valid point.
>=20
> > so
> > might as well use it. And if buffer support is ever added, that is one =
less
> > thing to do (removing the duplicate fields). =20
>=20
> I find populating the scan_type still somewhat confusing for a reader.=20
> Kinda willing to hear what Jonathan thinks of it, he probably has=20
> broadest view on how to keep things consistent in IIO. If it is usual to=
=20
> use the scan_type without buffer, then this is totally fine with me.

I'm against filling it in if there is no use being made of it (which people
sometimes do) but I don't mind it being used for this sort of purpose.
The reasoning being that we wouldn't want duplication if buffered mode
was supported, and this is just using it in the way we would use it
under those circumstances.

I'm also against carrying it around if it's actually a constant, so bring
this in only when dealing with a driver supporting multiple values (either
multiple devices or channels where this is the only difference).

>=20
> I suppose the shifts and amount of bits are constants? In that regard=20
> one could also just use a define, which would make it possible to not=20
> add this information to any of the structs.

Absolutely. If there is only one value used and no buffered support I'd
prefer to see it as a define used inline in the code.  The usual principle
of don't generalize until you need to applies here.


>=20
> Out of the curiosity, do we use 'input buffers' in IIO? This far I've=20
> mostly worked with IIO devices focusing on output.

There are some.  Look for IIO_BUFFER_DIRECTION_OUT. Eg. dac/ad3552r.c

It's relatively new infrastructure and for many DACs we support it isn't
worth the effort as they are more about tuning a signal than waveform
generation etc. Hence, not that many drivers yet and some of those
are using the IIO backend stuff with fpga IPs to get the data rates.

Jonathan

>=20
> Thanks for sharing your opinion!
>=20
> Yours,
> 	-- Matti
>=20


