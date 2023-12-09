Return-Path: <linux-iio+bounces-783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC21180B63D
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 21:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C116280FD3
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD31B277;
	Sat,  9 Dec 2023 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKWROmca"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41179D0;
	Sat,  9 Dec 2023 20:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7CAC433C8;
	Sat,  9 Dec 2023 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702153782;
	bh=/f4nL+h729f2HFNSb1HuznrKH1nxHo9UVx5loVYPQ40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKWROmcai3xl5k0HAh3O8z+ulrR/D8IaS2izC/Zely4Wt2bLjPt09vOcnvUwt9Dyx
	 evPQc9YPKTiw+OcYivwUJykQZ8GRaFco5No/GNUk5fzdNQ7i5MzJGmpxe6G8tak5fd
	 W5jpeDH7n4HA9hb9HqIcPfE9gsFd1RmLOuSF4OA3CbRVtMSpts9O5u4RbmgFW0SHoK
	 zfTNhnZ6PC3ui8+LgzxL3wRkSFEhF+8YShQuXZPkaCg3ChfD6N4vRZgf2rO+Q7aXy+
	 wWvQz2eCYj9VirSVzg1IJU5EadK3U8eGEoL0e4lT/zZwY03AWXO1SavKA6ybb1BeE3
	 yAbAvcIqWztwQ==
Date: Sat, 9 Dec 2023 20:29:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Li peiyu <579lpy@gmail.com>, jic23@kernel.org,
	javier.carrasco.cruz@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/4] dt-bindings: iio: humidity: Add TI HDC302x support
Message-ID: <20231209-fleshed-eating-90b4e487139b@spud>
References: <20231209105217.3630-1-579lpy@gmail.com>
 <20231209105926.3965-1-579lpy@gmail.com>
 <261094ae-b14e-464f-9d01-87a2bbcb40e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sMlmX3kZQzkIVEEc"
Content-Disposition: inline
In-Reply-To: <261094ae-b14e-464f-9d01-87a2bbcb40e0@linaro.org>


--sMlmX3kZQzkIVEEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 12:49:45PM +0100, Krzysztof Kozlowski wrote:
> On 09/12/2023 11:59, Li peiyu wrote:
> > Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> > temperature sensors.
> >=20
> > Signed-off-by: Li peiyu <579lpy@gmail.com>
> > ---
> >  .../bindings/iio/humidity/ti,hdc3020.yaml     | 55 +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,h=
dc3020.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.=
yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> > new file mode 100644
> > index 000000000000..f04b09fdca5e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
> > +
> > +maintainers:
> > +  - Li peiyu <579lpy@gmail.com>
> > +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > +
> > +description:
> > +  https://www.ti.com/lit/ds/symlink/hdc3020.pdf
> > +
> > +  The HDC302x is an integrated capacitive based relative humidity (RH)
> > +  and temperature sensor.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - ti,hdc3021
> > +              - ti,hdc3022
> > +          - const: ti,hdc3020
> > +      - items:
> > +          - const: ti,hdc3020
>=20
>=20
> Three of my comments were ignored.

> Also Conor's tag.

tbh, that's not a problem for me given there were mistakes that I
overlooked and they persisted into this version.

>=20
> This is a friendly reminder during the review process.
>=20
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>=20
> Thank you.
>=20
> Best regards,
> Krzysztof
>=20

--sMlmX3kZQzkIVEEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXTOMgAKCRB4tDGHoIJi
0o1pAQCdDy7BQe16dRze7wCtL6IPV2Pa9BuvGhiHdWNts9oWoAEAqeV15oyC0KEa
QkAjGjjVHrhj+/I3lO+YVdfL3OWzsQo=
=KLlY
-----END PGP SIGNATURE-----

--sMlmX3kZQzkIVEEc--

