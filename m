Return-Path: <linux-iio+bounces-19498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135BAB575B
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66E57AABEA
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC723814A;
	Tue, 13 May 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7/yAH93"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194B1E5B9E;
	Tue, 13 May 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147186; cv=none; b=opoV6AdIyv6C66uhu3UIRwrgKFMT4q14q/wsQkLq88mpSZ+wPNTuiGqAqrNeYrQPpopDYkRCzYKu5AXZiM9EFiQ1rUVulP+jFg6ovPgqo6QEoP5aZGBedga2otfpYpQpqzD8GEl4+rTD7OFcDlX+JbavIGjw/zPciuKZFq4YzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147186; c=relaxed/simple;
	bh=PEDSbWPKZrAI4l87D8/IK5YIvcTjwzk9nO/2u32S7yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3pL9sEEO1o6uQkFMiVXd5E8ByiGs1n1cPRjKeTkeXDJCNtDR3MKq53dh16gWEJ+g3lQ+gAmI8DPpc4iuAN+oPKM53045WNau0r9pSDH59dAHhBqCxRJUHw3SJ0oDFuHxIGDVr38scmtcIwDy2g3C0tRrZSBl49vJxbd54Z86EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7/yAH93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6C8C4CEE4;
	Tue, 13 May 2025 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747147186;
	bh=PEDSbWPKZrAI4l87D8/IK5YIvcTjwzk9nO/2u32S7yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7/yAH93F/HJIQ0rlT28egWdPTGsssUyd8dLsTzcLU1JUd4bGH7FioygWll/ySvXm
	 AI4eCyvBDg2aeuGS8xkWBog6ipdDOhpqNu1b6NX3SnPAXt4amlsnXfq0tXsAdhos0w
	 Qt8zcgZsxIHbfZllTxPLPYQTzubAA4m7DkNplhHcgcbZp8WjhaWaIahzdWp/EBhNys
	 GY2XVi4nH0x9m4u1srz+1Z/CfZNWtcMiHkbv/M17/3J5cy04tCdnH+1LyJqvllEn+x
	 FPJiLeLlb4BoDR9+lLqMuzfhWjDjQXaP6o6AnINw0mCpgXN9p52R1gxWteWdPfefTH
	 d2asXwNSB5sWA==
Date: Tue, 13 May 2025 15:39:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add ROHM BD79100G
Message-ID: <20250513-unpaid-detection-f45c9a06b4c6@spud>
References: <cover.1747123883.git.mazziesaccount@gmail.com>
 <7deb4b69795c298ba51c9b198bc87000ad35cc9b.1747123883.git.mazziesaccount@gmail.com>
 <20250513-coconut-reconfirm-b90590efeb45@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ATzWI0fTp0b5znvq"
Content-Disposition: inline
In-Reply-To: <20250513-coconut-reconfirm-b90590efeb45@spud>


--ATzWI0fTp0b5znvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 03:39:11PM +0100, Conor Dooley wrote:
> On Tue, May 13, 2025 at 11:26:27AM +0300, Matti Vaittinen wrote:
> > The ROHM BD79100G is a 12-bit ADC which can be read over SPI. Device has
> > no MOSI pin. ADC results can be read from MISO by clocking in 16 bits.
> > The 4 leading bits will be zero, last 12 containig the data.
>=20
> I think it is probably worth mentioning why a rohm device is going into
> this binding (clone?) and that the 12-bit thing is a differentiator that
> is why you're not using a fallback.

Sent too soon, meant to say: with that
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> >=20
> > Device has only VCC supply pin, which acts also as a VFS, determining t=
he
> > voltage for full 12-bits. Specifying it is mandatory.
> >=20
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> > index 44c671eeda73..10fb6e14c2d0 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> > @@ -46,6 +46,7 @@ properties:
> >        - ti,ads7867
> >        - ti,ads7868
> >        - lltc,ltc2314-14
> > +      - rohm,bu79100g
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -96,6 +97,7 @@ allOf:
> >                - ti,adc121s
> >                - ti,ads7866
> >                - ti,ads7868
> > +              - rohm,bu79100g
> >      then:
> >        required:
> >          - vcc-supply
> > --=20
> > 2.49.0
> >=20
>=20
>=20



--ATzWI0fTp0b5znvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCNZrQAKCRB4tDGHoIJi
0jJ+AQD8KIvz7dHXlcRaaMq7tYvBbLSTZqPSi6ZmY4VCGJ5gKAD+PD34qn/neQjb
218u4O88q/9iICBLxkuwwJ6CipJVmgU=
=vRFd
-----END PGP SIGNATURE-----

--ATzWI0fTp0b5znvq--

