Return-Path: <linux-iio+bounces-2978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D75861BEE
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 19:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9372E1F24572
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D114037E;
	Fri, 23 Feb 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMEiUv7+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962788526C;
	Fri, 23 Feb 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713787; cv=none; b=Eh6TAw2VdYKZeao7MMCFuGX3yEk59Dd5bW0mdRRCGMSTYXDpYPd5wKT5fiMj342iL0mO6lClFdeiTtYNThFt5ZxkGgEzMf2QGinE287M72sKyFySbNc3NL61NOgrozBQ+FFVjQajInkkem3HImO+/LToSs0BC7hiF/e+uLGcFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713787; c=relaxed/simple;
	bh=eEs9RUmVJWZdxO77k4IYZtSjMJBhJekiCKy5s+CRXKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrAhcWwFlP/4IaRCD7cYanBYr0qcJfxudoO5dM4pwCJ2nlPeRmtch8F+RbUasMYcyZ2iDcZGSa/EYBFo9OSwrv/iSMAZtAw3iqVA1cRPWIaGKv2kjJBpi2VMeV9fVL9Qxv1nXMKLzAkADup+O4tNI0pdcjhi4dctgT8ng5y03d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMEiUv7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607A1C43390;
	Fri, 23 Feb 2024 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713787;
	bh=eEs9RUmVJWZdxO77k4IYZtSjMJBhJekiCKy5s+CRXKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMEiUv7+JyjK0C6yDSOOqF9OuFkrhYuIf2VuAd9QjMks64Asy2+o3Djjrw1VuXOS1
	 9gyrJ19T2N6QV2hYWqKqVFlZRiKE2zM/Wjf1jJ+A2woBy8F2VoPFhu5FFiEzX/ByO5
	 tdeKVk41wTZqE3B/A6DVI/j4ThZw9mEo5zTmVfE117v9hJNunfW+PansjIiKZvJZ33
	 +0jptKEqdmZjFCZAytfSgbGqQFZq/ZATFJiOZbFfwlBQGflA+ktr6AeS5U6qnRKRvS
	 S1xzXm8Jm8zFQZysNsViQZzRgWqbhGUWsojVFhMBpBid8C9hTPAO5uenQhHWW2YZCt
	 mMTDsgz7/EjTQ==
Date: Fri, 23 Feb 2024 18:43:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: temperature: ltc2983: document
 power supply
Message-ID: <20240223-parameter-impeach-e0dabf83a356@spud>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
 <20240222-ltc2983-misc-improv-v1-5-cf7d4457e98c@analog.com>
 <20240222-component-stiffen-d046386433b3@spud>
 <f31abc7140dfa8477623d4fca8abece03d37926e.camel@gmail.com>
 <20240222-lance-sprinkled-04a7650ca316@spud>
 <8409a5bc71b995e3b738b817a074cfb131c3b2b5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rQzz2nXwN4OFNnc7"
Content-Disposition: inline
In-Reply-To: <8409a5bc71b995e3b738b817a074cfb131c3b2b5.camel@gmail.com>


--rQzz2nXwN4OFNnc7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 09:17:16AM +0100, Nuno S=E1 wrote:
> On Thu, 2024-02-22 at 17:54 +0000, Conor Dooley wrote:
> > On Thu, Feb 22, 2024 at 05:41:03PM +0100, Nuno S=E1 wrote:
> > > On Thu, 2024-02-22 at 15:40 +0000, Conor Dooley wrote:
> > > > On Thu, Feb 22, 2024 at 01:55:56PM +0100, Nuno Sa wrote:
> > > > > Add a property for the VDD power supply regulator.
> > > > >=20
> > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > ---
> > > > > =A0Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.=
yaml | 2
> > > > > ++
> > > > > =A01 file changed, 2 insertions(+)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.y=
aml
> > > > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.y=
aml
> > > > > index dbb85135fd66..8aae867a770a 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc29=
83.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc29=
83.yaml
> > > > > @@ -57,6 +57,8 @@ properties:
> > > > > =A0=A0 interrupts:
> > > > > =A0=A0=A0=A0 maxItems: 1
> > > > > =A0
> > > > > +=A0 vdd-supply: true
> > > >=20
> > > > Although technically an ABI break, should we make this supply requi=
red?
> > > > It is, at the end of the day, required by the hardware for operatio=
n.
> > > >=20
> > >=20
> > > I thought about it but then realized it could break some existing use=
rs
> > > which is
> > > never a nice thing.
> >=20
> > Could you explain what scenario it actually breaks a system (not
> > produces warnings with dtbs_check)?
>=20
> Oh, I guess I could not explain myself :). I did not meant breaking the s=
ystem
> (I'm aware of the dummy regulator) but I meant exactly what you mention a=
bove
> about dtbs_check. Like, if someone already validated a devicetree against=
 the
> current bindings, that same devicetree will fail to validate now right? A=
nd I
> had the idea that we should not allow that... If not the case, I'm perfec=
tly
> fine in making the supply required.

I think that's fine, the system will still work which is the important
part of the ABI.

Cheers,
Conor.

--rQzz2nXwN4OFNnc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjnNwAKCRB4tDGHoIJi
0vTLAPwLEc5QpEzl1o9+tzh6xjIPmFGIQRfDPcApXAHodG29lwD/bJSNLpuuycB+
FRlXn91eBDt/Puab+Q+r2RGw9+/MgwQ=
=lwVz
-----END PGP SIGNATURE-----

--rQzz2nXwN4OFNnc7--

