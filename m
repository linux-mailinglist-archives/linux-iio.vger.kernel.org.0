Return-Path: <linux-iio+bounces-13502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D79F247C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7752E7A10EB
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877018E050;
	Sun, 15 Dec 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upnra4WS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC2143C69;
	Sun, 15 Dec 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734274623; cv=none; b=ZVc8W9WNSOzJfpyb6hAgTkmpV75TFypjISbCVVdAbI3oUvKbiiKNYDdpo88fQZSqF0jIb/PqeEoKczDsZS8TF8Cu1EaMRR84wktgCdeKJQRg202XNLeQqZHVvTMWW0xaXdl9CsmCUPU0h0V8D5e5mYATCz00ANBwj4dYw56MFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734274623; c=relaxed/simple;
	bh=9QV+PHMTXlp02Zc634LB9+q/huRg5PsGVu+GEL9nvbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltt8lbAQi80sv0euBOmKqTgoL3WdWtTTET5cT7esLipwB1d0SisecuJIGcaVuOPnjflO3JQU1GAalt4wBaBlFTxQBPv4HNF8VaLQhiqIY44jvwGybW6djr43xDGqrcZJ95iupce14S3H1NqAucBmEAeNmU/aYDZGAA48rUYSOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upnra4WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7524C4CECE;
	Sun, 15 Dec 2024 14:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734274623;
	bh=9QV+PHMTXlp02Zc634LB9+q/huRg5PsGVu+GEL9nvbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upnra4WSGSE0jd5lRMUZveij74NqOwMUV6i9gyrGDbJKmh10S59+k7D8GKJgmZfDI
	 QEMuGLxiZtQK5g0KHK6BIQEdc3Wlz9yTxkWXELqPdV+lMv3X67SKYHwkpYRkVdRjUn
	 kWqgEYdsJya/28AIoDbxOD4KIwXQ/Oxxx4DgtunTo4ErIqRSUTBxSFB3OepPmmajGI
	 ZVD0Qky4tWuv671xzCcFky1fpnjSBkkiGYFCcm3fMXXjkzU/fezLteaEGhTCeQvZxt
	 zTKtseTuSyuGqNjrCxN9QmP1BgGME4XHx0aKqMOLnFxGEupAq6Yg88mt4vm5mhlJ5f
	 SbEnJCFgZ03Nw==
Date: Sun, 15 Dec 2024 14:56:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v7 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <20241215-satisfied-expiring-9200ec935768@spud>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
 <20241213211909.40896-4-l.rubusch@gmail.com>
 <20241214121057.5b12a236@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tPYxCPsmEU8y7dm7"
Content-Disposition: inline
In-Reply-To: <20241214121057.5b12a236@jic23-huawei>


--tPYxCPsmEU8y7dm7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 12:10:57PM +0000, Jonathan Cameron wrote:
> On Fri, 13 Dec 2024 21:19:05 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>=20
> > Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> > sensor.
> >=20
> > When one of the two interrupt lines is connected, the interrupt as its
> > interrupt-name, need to be declared in the devicetree. The driver then
> > configures the sensor to indicate its events on either INT1 or INT2.
> >=20
> > If no interrupt is configured, then no interrupt-name should be
> > configured, and vice versa. In this case the sensor runs in FIFO BYPASS
> > mode. This allows sensor measurements, but none of the sensor events.
> >=20
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>=20
> Just to repeat what I sent in reply to v6 (well after you'd posted this).
> Maybe we can maintain compatibility with the binding before this by adding
> a default of INT1.

But can you make that assumption? If we did, and it's not universally
true, we break systems that had INT2 connected that previously worked.

> Then you'd need to drop the dependency on interrupt-names.
>=20
> I'm not sure though if the checking of number of entries will work against
> a default. Give it a go and see what happens :)
>=20
> We are lucky that we can't have bindings in the wild assuming ordering
> of the two interrupts due to the maxItems being set for interrupts.
>=20
> It's a messy corner, perhaps we should just not bother in the binding,
> but keep that default handling in the driver?
>=20
> DT binding folk, what do you think the best way of handling this is?

--tPYxCPsmEU8y7dm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ17uOgAKCRB4tDGHoIJi
0re3AQD3VfA+g76cz3luJUYI2rPZ5UBT7Llfk0sig1CdWRYIdwD/Yd9SqNLnyo3K
Nj45N/klZKZtQe40EA9cQMlHnv5DUgc=
=qAMS
-----END PGP SIGNATURE-----

--tPYxCPsmEU8y7dm7--

