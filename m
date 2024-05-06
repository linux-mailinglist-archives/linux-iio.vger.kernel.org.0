Return-Path: <linux-iio+bounces-4854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C48BD1DA
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 17:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2141F21EF4
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F990155731;
	Mon,  6 May 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBFmFcWp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C55142E8A;
	Mon,  6 May 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010865; cv=none; b=r33voeuJL0+mLF9qWrI/+dctKlCBFPnuPPMKta5S4fnrmb/Aj8DYTLIKcgy+9NK9XDewvriXP0JXtwWjZ4HdgrD3mgJ4zPEF3Wk5pKDEJ1KC4kDcuqR1BXVIdbe7E4CbUvAaYLiYcIPBXA5eDMyDE1KRRf9MMlTjbaT6c3mS7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010865; c=relaxed/simple;
	bh=iMkABcd0DBv9az9njPuwUR8B35ghWS0eM5Q6/tVyFFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PexXVVpcELLsjQwoi4g1iEtrl9OCqPXnswySAhLpC0MGhFjb+CTEzKVRSX20PrHqfp9m4CbBDyGfobRbfGx2acK3barms8bgHXvfbB28c5QC0Zz3xM1RXQ+Ae26npKn1g/fbOPiL+ie2WF005OVaJ0RSV22ZwQw8mRnQNlZormo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBFmFcWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F11CC116B1;
	Mon,  6 May 2024 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715010863;
	bh=iMkABcd0DBv9az9njPuwUR8B35ghWS0eM5Q6/tVyFFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBFmFcWpT3kV6HurFA95Zrh/LmeCRaqezdk3DoQYk/aLBYZ+L3gAyVz5NqXKvX+vz
	 7n0xFXEaXrsRXdlIxcvN7QlT/Rla8dyzXrn9ucwfdQIRHoSODel+ZPgCC+QgVO9S18
	 u5S40ECc1sn/JIPIwMPf8xJ4lMfowrIXHrC2cjyQORtERne/Xj7l9oeLxatwQ4pnnt
	 ylO0EvoObjnuc7w0IztkvR2/EzTH9PZg8DcwaavNKs90YF6kmt7RdqyeyQ2UQpPcK+
	 a9dMh6pI5M4JKRHN6snHWHHI+yI0MiSigOYqAh81tGpDTDiX/dDi5NNlju23f5n6GB
	 rknbZDEf4aUVA==
Date: Mon, 6 May 2024 16:54:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
	michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandru.tachici@analog.com, lars@metafoo.de, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
	nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, dlechner@baylibre.com, okan.sahin@analog.com,
	fr0st61te@gmail.com, alisa.roman@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: Re: [PATCH v7 5/6] dt-bindings: iio: adc: ad7192: Add AD7194 support
Message-ID: <20240506-evaluate-darkroom-b0f8a7bf4598@spud>
References: <20240430162946.589423-1-alisa.roman@analog.com>
 <20240430162946.589423-6-alisa.roman@analog.com>
 <20240430-winnings-wrongness-32328ccfe3b5@spud>
 <20240505204602.5d4cbfa0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Aufn4Dkbz1VH4dr"
Content-Disposition: inline
In-Reply-To: <20240505204602.5d4cbfa0@jic23-huawei>


--3Aufn4Dkbz1VH4dr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2024 at 08:46:02PM +0100, Jonathan Cameron wrote:
> On Tue, 30 Apr 2024 18:21:01 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Apr 30, 2024 at 07:29:45PM +0300, Alisa-Dariana Roman wrote:
> > > +      diff-channels:
> > > +        description:
> > > +          Both inputs can be connected to pins AIN1 to AIN16 by choo=
sing the
> > > +          appropriate value from 1 to 16.
> > > +        items:
> > > +          minimum: 1
> > > +          maximum: 16
> > > +
> > > +      single-channel:
> > > +        description:
> > > +          Positive input can be connected to pins AIN1 to AIN16 by c=
hoosing the
> > > +          appropriate value from 1 to 16. Negative input is connecte=
d to AINCOM.
> > > +        items:
> > > +          minimum: 1
> > > +          maximum: 16 =20
> >=20
> > Up to 16 differential channels and 16 single-ended channels, but only 16
> > pins? Would the number of differential channels not max out at 8?
>=20
> May not really be limited to 16 differential. Many chips use general purp=
ose
> muxes on both sides so you can do all combinations. In practice that's no=
rmally
> pointless.
>=20
> A more useful case is to do all but one channel as positive inputs and th=
e remaining
> channel as the negative for those 15 differential channels.

Yah, 15 is what I had in my head as the highest reasonable number given
the information given about the AIN# pins.

> This is effectively the same as doing pseudo differential channels, but
> on more flexible hardware.  This is in contrast to a device that only sup=
ports
> pseudo differential where there is a special pin for the negative
> (this device has that as well as full muxes on the other 16 lines).
>=20
> Having said all that.  The ad7194 datasheet says 8 differential channels..
> I have no idea why though... Maybe something to do with the mux switching?
> Or maybe assumption is that if you want to do pseudo differential you'll =
use
> the pseudo differential mode rather than wasting hardware?

I didn't look at the datasheet tbf, I was just asking given the
description didn't make sense to me and looking for an explanation from
the author.

--3Aufn4Dkbz1VH4dr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjj9KQAKCRB4tDGHoIJi
0tgjAP0UT0hwLpfAghyxJPc+yxfShQLZbRCoHngwKOZZsGSlDwEAj4SyQghwbeUF
1Y3RvIXr04WBMoljrmHNA3+f2Vm99QI=
=f95D
-----END PGP SIGNATURE-----

--3Aufn4Dkbz1VH4dr--

