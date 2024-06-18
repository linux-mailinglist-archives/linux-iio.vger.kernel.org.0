Return-Path: <linux-iio+bounces-6528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8774A90DACA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B088DB24F1A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A37714A08D;
	Tue, 18 Jun 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgfrAkew"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54258148820;
	Tue, 18 Jun 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732285; cv=none; b=a13yIxwuRW9pbvqTD0tmqkzLn3ZYq2VSPRZrriqNQ33KvkoLGfP0ybbUBDwhLiqLGH1r7CDjY5Etuc8UkhToDaIU8XYigRCnWJXnJMyamtYsDle7v5XSv+15ejx8eYV+swHXI8KsFU+vojTYCfk7qKbWdZDJdgDcg0llpNdNiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732285; c=relaxed/simple;
	bh=d4LuWCXxsQxAIvV5QrYmZOM3ONbE8EejCcHEBUy16WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak2pFiSP3qDfF1TdVodjpEZ0oj9qfZKjtEKoVZ48r/oLTGUFRAkjXft2Ly8Q7eUgCepO1NqA9x7j2Q2hlH+YKx5N066QD5pIUMKn+qdFQd8o2KrpIyhTzmp0I72VzAOP7SvAGW+ZdY7+LUOIhHRbNqo51sXPmZBXwvl9hojotuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgfrAkew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53487C3277B;
	Tue, 18 Jun 2024 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718732284;
	bh=d4LuWCXxsQxAIvV5QrYmZOM3ONbE8EejCcHEBUy16WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgfrAkew1R9HzqBV9wRpvVqUPFVYgZ7V8dMWsu+LycP4i3RG6js2UUezXC4+PXknu
	 pmGoFARubOWBI4DY5izdvHh5cPlBmaK4pVgRFwJQ8/mHvaRD/6TZLbKP7KcK19LJzU
	 6b2KBnCVigJ1yIyxLyomsvlCdOFsbFOUMqsl0a29tzQ/u2B3DdFo6F1DhhhV9Sp9j8
	 PXnqwOWNZxzExO3eNjBLpqSQI5w1KC46XFFhTMt/yoFiAqJ+3MxLlIElGrCECJthwa
	 1U2/LSNg4b3rbsvl4d6MLl4Dj6hdKBICHdfL64+xasn3YVUHi98Uu416DkWd5s/ILs
	 XZhx1GJ/HAdVg==
Date: Tue, 18 Jun 2024 18:38:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	denis.ciocca@st.com, devicetree@vger.kernel.org,
	linus.walleij@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
Message-ID: <20240618-jockstrap-gains-de25ff6a969b@spud>
References: <20240611160821.13941-1-kauschluss@disroot.org>
 <20240611160821.13941-2-kauschluss@disroot.org>
 <20240611-reassign-eliminate-b05e4a302cfb@spud>
 <56ab50d7c542356b7e377023b84a6018@disroot.org>
 <20240615144948.61e7f519@jic23-huawei>
 <157b613ce552e1060e856625d37e927e@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zomALF0VpkOjWMkg"
Content-Disposition: inline
In-Reply-To: <157b613ce552e1060e856625d37e927e@disroot.org>


--zomALF0VpkOjWMkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:21:17PM +0000, Kaustabh Chakraborty wrote:
> On 2024-06-15 13:49, Jonathan Cameron wrote:
> > On Sat, 15 Jun 2024 09:46:59 +0000
> > Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> >=20
> >> On 2024-06-11 18:17, Conor Dooley wrote:
> >> > On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wrote=
: =20
> >> >> Add compatible for LIS2DS12 accelerometer by STMicroelectronics. =
=20
> >> >=20
> >> > I can see that! Your commit message should mention why this device
> >> > is not compatible with existing variants. =20
> >>=20
> >> Sure, is adding the WhoAmI value enough? Or do I also have to
> >> explain the different registers and sensor settings.
> >>=20
> > Who ami is not enough, but a statement along the lines of
> > "The register interface is not compatible with existing parts, for
> > example addresses and contents of numerous registers are different"
> >=20
> > With whatever the actual differences are.
>=20
> "LIS2DS12 is an accelerometer by STMicroelectronics. It is identifiable by
> its WhoAmI value 0x43.
>=20
> Its register interface is not compatible with existing parts. For example=
:=20
>=20
> - The full-scale values are present in register 0x20, in bits 2 and 3
>   (mask 0x0c).
>=20
> - The full-scale values 2G, 4G, 8G, and 16G correspond to the register
>   values 0x00, 0x02, 0x03, 0x01 respectively.
>=20
> Add the compatible string without any fallback."
>=20
> Is this good enough?

I don't know the other devices, so please highlight how the examples you
give here are different to the existing ones please.

--zomALF0VpkOjWMkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHF+QAKCRB4tDGHoIJi
0nLFAP9MWu3wz0B9H1UOZYlPQ/Mj5ZUW2aszB7e/1NtfQzSPZwEAzpzYAep8CEXa
YmmalWUP7ljH0K0cr3DSOL4fv7HLFQQ=
=fh1R
-----END PGP SIGNATURE-----

--zomALF0VpkOjWMkg--

