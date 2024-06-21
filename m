Return-Path: <linux-iio+bounces-6680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C172791278D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C91428BFF9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC91CFB5;
	Fri, 21 Jun 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8+r96bF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B9482E2;
	Fri, 21 Jun 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979698; cv=none; b=DeTXW1UtYbdE+45pAEYlY7vC72uGDxv9l+uvP8QxjKp2ewX/8bTnuLNxURoRxT9KxfPaCeMAHCm8+wFCzxAhBY2ixHw/Nm4UgH5kH3BjJyVgEjHwhrXF55PZ3X+ETezXVdU05q/X4GNovaFkqQuKURU2EFwjEeM9pu0qEJCokLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979698; c=relaxed/simple;
	bh=OQPO5vQZl5riqUdlNrU5QnmW+tWrPynwH15KZnCsdDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maZkMXZQCzErOmiZoaxL1UgjhW7tkCrHNJccZWQhWDBOj9LtxbfcbqBu8N8EcBGu/JxxJHxCzkXjW0f8T4nZV79Wxbpn36IVZJipnv1kn2cRiP5+EsMAcnRTA2sBSmpKlSiKWC3Q2egME6OAOltHkpQcomvuG9Wv7NKaBiS5yAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8+r96bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3621DC2BBFC;
	Fri, 21 Jun 2024 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718979697;
	bh=OQPO5vQZl5riqUdlNrU5QnmW+tWrPynwH15KZnCsdDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8+r96bF44lTTMmJq0L1Z3QwIvfzrQkT+daQyH45XLr7xlXPR6bk1ORkKwJi92SAc
	 xIekqPlx8TBLIWXB4j8Ek3OkqkXn4r9X3KzocDyLxas7/DlwTFcRhxQ0ok+ns2nj9w
	 0QwFftwFEvQwPepjn18NILQ3ana2bbFbgPC0BXEKIXxJSDvjyrrVKLdPYAon7iscH7
	 NYLUGxLUoAyX2oG+iPpI2lfuAOD9/GQ24IlrkU7zFD53ukjtzthuq3meOpe2we8fiz
	 0duHYQ74lalYG0hRmoQ2ywfCTauZQy0xLphP9g5F9jJJXKwLiG6DRoI9uG1yZwNFFD
	 Izj9JOxBpG33Q==
Date: Fri, 21 Jun 2024 15:21:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	denis.ciocca@st.com, devicetree@vger.kernel.org,
	linus.walleij@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
Message-ID: <20240621-vaporizer-dealt-02a1d8a8d423@spud>
References: <20240611160821.13941-1-kauschluss@disroot.org>
 <20240611160821.13941-2-kauschluss@disroot.org>
 <20240611-reassign-eliminate-b05e4a302cfb@spud>
 <56ab50d7c542356b7e377023b84a6018@disroot.org>
 <20240615144948.61e7f519@jic23-huawei>
 <157b613ce552e1060e856625d37e927e@disroot.org>
 <20240618-jockstrap-gains-de25ff6a969b@spud>
 <c4c7532b6b2ba08e24043b432431303b@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EobNpeVPbdRbwVux"
Content-Disposition: inline
In-Reply-To: <c4c7532b6b2ba08e24043b432431303b@disroot.org>


--EobNpeVPbdRbwVux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 04:42:39PM +0000, Kaustabh Chakraborty wrote:
> On 2024-06-18 17:38, Conor Dooley wrote:
> > On Tue, Jun 18, 2024 at 12:21:17PM +0000, Kaustabh Chakraborty wrote:
> >> On 2024-06-15 13:49, Jonathan Cameron wrote:
> >> > On Sat, 15 Jun 2024 09:46:59 +0000
> >> > Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> >> >=20
> >> >> On 2024-06-11 18:17, Conor Dooley wrote:
> >> >> > On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wr=
ote: =20
> >> >> >> Add compatible for LIS2DS12 accelerometer by STMicroelectronics.=
 =20
> >> >> >=20
> >> >> > I can see that! Your commit message should mention why this device
> >> >> > is not compatible with existing variants. =20
> >> >>=20
> >> >> Sure, is adding the WhoAmI value enough? Or do I also have to
> >> >> explain the different registers and sensor settings.
> >> >>=20
> >> > Who ami is not enough, but a statement along the lines of
> >> > "The register interface is not compatible with existing parts, for
> >> > example addresses and contents of numerous registers are different"
> >> >=20
> >> > With whatever the actual differences are.
> >>=20
> >> "LIS2DS12 is an accelerometer by STMicroelectronics. It is identifiabl=
e by
> >> its WhoAmI value 0x43.
> >>=20
> >> Its register interface is not compatible with existing parts. For exam=
ple:=20
> >>=20
> >> - The full-scale values are present in register 0x20, in bits 2 and 3
> >>   (mask 0x0c).
> >>=20
> >> - The full-scale values 2G, 4G, 8G, and 16G correspond to the register
> >>   values 0x00, 0x02, 0x03, 0x01 respectively.
> >>=20
> >> Add the compatible string without any fallback."
> >>=20
> >> Is this good enough?
> >=20
> > I don't know the other devices, so please highlight how the examples you
> > give here are different to the existing ones please.
>=20
> Are these acceptable?
>=20
> - The full-scale values are present in register 0x20, in bits 2 and 3
>   (mask 0x0c).
>   Most other supported sensors have the register address set to 0x21,
>   0x23, 0x24, or 0x25.
>   There is one sensor setting though (bearing WhoAmI 0x3b) which has
>   it's address set to 0x20, but the mask is set to 0x20, not 0x0c.
>=20
> - The full-scale values 2G, 4G, 8G, and 16G correspond to the register
>   values 0x00, 0x02, 0x03, 0x01 respectively.
>   None of the sensor settings have the value 0x01 associated with 16G.

Yeah, that sounds good to me. Thanks for the updates.

--EobNpeVPbdRbwVux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnWMbgAKCRB4tDGHoIJi
0pYVAQDsXaMiTz4nVsnrOb1sLALm92WhmvswS/cTd3J4e7gpUgD/X8jyhJDSLMJZ
QrASEU5b0zodsRfS5PEf1SYmTTJUCgA=
=VJ9T
-----END PGP SIGNATURE-----

--EobNpeVPbdRbwVux--

