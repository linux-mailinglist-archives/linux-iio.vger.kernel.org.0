Return-Path: <linux-iio+bounces-7086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194B91D179
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 13:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B0DB2169D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9D13C3CC;
	Sun, 30 Jun 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvcdcw4y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7F2E419;
	Sun, 30 Jun 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719747816; cv=none; b=JPe/nYE5i8123L1pS8EhuDx32ciRqhWM/KQuHf3x28SnFbAiuDk2ALX6XlXB4My3Uu93ewlgZf7JKLED4GF9+jzzxZpux/xm4EE6F+raD0hdP0DUc3nbaaLsBVC6GmHlpfXHeXyNPxKUN7GaXeVlcNTJz2eZhOwgLNAqDa2iWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719747816; c=relaxed/simple;
	bh=lnHlEnqgGp94dnnzJe32XBDVLkt7LiVbT6eZ5HzhyaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8IPpRiV9uI0KKAr8XZts96A7G6spliqnh3doqRuM3xStN7bNJTFWtXoA2mp+2lXStCv7VzUditZIEBZw+HrhTR2LNOZxCVr6dWZvi4aP+9DEe4iWHrScJKFuhSZzY8maH16IrE1hlpRc/N3PgpWcAyhBqyP03OaBFSKXn6mLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvcdcw4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAE2C2BD10;
	Sun, 30 Jun 2024 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719747815;
	bh=lnHlEnqgGp94dnnzJe32XBDVLkt7LiVbT6eZ5HzhyaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvcdcw4yVOUU1ieo0faYj60C5UBjmdn/ebFgAaK1mx5zKdmWim94BRayPTJqbc6w7
	 FqvUKRw7ncSiVZCIBkYauiEvvLSJIlcYnZiVGangan3QIwcuvutgNtEkHLlhRCGPJ8
	 T2lZiaAWb6s80RiDnemIL43OFKHt12RX2I3yh5PbBbD9g3JwG9s4lHA5P7/kU1Vd8D
	 /S6KIQbLc0W1Bh2+phA9C1FMwZaiV/xJ3nKKHH9PfpIYEanGPpB1Qsh+cywMe4wevc
	 +VI+JR4O5A/pU/J/5w4mI1t3eIJlP9lW74FZlWTAecaQqbTgce04TGkQDBjUO0HUY/
	 muarSpI8i9LFQ==
Date: Sun, 30 Jun 2024 12:43:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 5/6] iio: adc: ad7192: Add clock provider
Message-ID: <20240630-jubilant-pyromania-d6b004a793a9@spud>
References: <20240624124941.113010-1-alisa.roman@analog.com>
 <20240624124941.113010-6-alisa.roman@analog.com>
 <CA+GgBR8r_W9X0hROUEw-xePyKAhOTBjJtf=cHbfWfvUUfk5j_g@mail.gmail.com>
 <a72569f7c1f5d9a7158fe774179ec8fc76016168.camel@gmail.com>
 <20240630105448.758dd131@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mi5L2Q7GuWi83TYj"
Content-Disposition: inline
In-Reply-To: <20240630105448.758dd131@jic23-huawei>


--Mi5L2Q7GuWi83TYj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 10:54:48AM +0100, Jonathan Cameron wrote:
>=20
> > > > +
> > > > =A0static int ad7192_clock_setup(struct ad7192_state *st)
> > > > =A0{
> > > > =A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D &st->sd.spi->dev;
> > > > @@ -412,6 +496,11 @@ static int ad7192_clock_setup(struct ad7192_st=
ate *st)
> > > > =A0=A0=A0=A0=A0=A0=A0 if (ret < 0) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->clock_sel =3D AD7=
192_CLK_INT;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fclk =3D AD7192_I=
NT_FREQ_MHZ;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D ad7192_register=
_clk_provider(st);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 return dev_err_probe(dev, ret,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Failed to =
register clock
> > > > provider\n"); =20
> > >=20
> > > A question here: do we want to fail the probe of this driver when it
> > > cannot register a clock provider?
> > > Or should we ignore it?
> > > No preference from my side. =20
> >=20
> > Sensible question... I would say it depends. On one side this is an opt=
ional
> > feature so we should not (arguably) error out. OTOH, someone may really=
 want
> > (and relies on) this feature so failing makes sense.
> >=20
> > Maybe we should have
> >=20
> > if (!device_property_present(&spi->dev, "#clock-cells"))
> > 	return 0;
>=20
> I'm not 100% sure from looking at the code, but if the absence of this pr=
operty
> (because the DT writer doesn't care about this) is sufficient to make the
> calls in ad7192_register_clk_provider() fail then we should check this.
> I don't think we need the complexity of get_provider_clk_node() as there =
is
> no reason to look in a parent of this device (it's not an mfd or similar)=
 so
> this check should be sufficient.
>=20
> Does this also mean the binding should not require this?  I suspect it sh=
ouldn't.

Per the binding (proposed and current) I think the code here is fine
w.r.t. probe failures. Before the series, it looks like clocks/clock-names
were required by the binding and the driver would fail to probe if they were
not provided. The current code only fails to probe if neither clocks
or clock-names and #clock-cells are not provided, so it is a weaker
restriction than before. The binding doesn't require #clock-cells at all
times, only if the clock consumer properties are not present, so it is
both fine backwards compatibility wise and seems to match how the driver
is behaving. I'm biased, but I don't buy "the DT writer doesn't care" as
an argument cos if they didn't care about adding the required clock
consumer properties now then they'd not have probed before either...

Cheers,
Conor.

> > in ad7192_register_clk_provider(). So that if we fail the function, the=
n yes, we
> > should fail probing as FW wants this to be a provider. Also, not provid=
ing
> > #clock-cells means we don't register the clock.
> >=20
> > Having said the above I think that failing devm_clk_hw_register() means=
 that
> > something is already really wrong (or we have a bug in the driver) so l=
ikely we
> > should keep it simple and just always provide the clock and return an e=
rror if
> > we fail to do so.
> >=20
> > my 2 cents...
> >=20
> > - Nuno S=E1
> >=20
> >=20
>=20

--Mi5L2Q7GuWi83TYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoFE4gAKCRB4tDGHoIJi
0rd8APwLmRCAOSGfaSnmDqSvcuqh7evVo0woKBO/UgxUyVuLsgD/TZkzpeKNRZEm
fQTButiI6kY4xg9gTIlu1fpoHUJUFAc=
=BG+3
-----END PGP SIGNATURE-----

--Mi5L2Q7GuWi83TYj--

