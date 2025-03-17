Return-Path: <linux-iio+bounces-16952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEDA64C1B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418007A4A4E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57C2356B7;
	Mon, 17 Mar 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="cKtWN5YO"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE131D79B3;
	Mon, 17 Mar 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210248; cv=none; b=cXJ360xRlOHN8hln06qKgqyGuSoI00jTVL1s4HVW+JWQcgVnmqLHIAn4yn8iCVesUMKDzPUy0+qkg90eE8fFKAzj2cEbr0pLY+VDj/a+kkEiuqb8SY3Mc0+3qdQV1aIm/2gRZ4Xkd//RDE9wE3NAO8cMgfwkMGDxfkeChmfctd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210248; c=relaxed/simple;
	bh=uYoF2XU04ed3cUfLW0Zv5oZ4ni4Gbd2nEZjhSx/oo3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsAVZt/IuB10JEM8RpO+vz1sxwi51Japnu4MYAB/SlTyKxfSGaeIcmxNQXvIc1iFQE8HmuMvrDktCZzgolfnTJZAPHHqGkm+SdEg/9k3SaQpCWjGTmZDFvPoF5v05n9noNVkK+AJ2Ehsy+/z3npLs8mOUzPS+I8u3frhxyh4huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=cKtWN5YO; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XE0nklv5FnGcO0JcWnNv2Mt7qztg3JvxQsyWfUqHEME=; b=cKtWN5YOCkrZIyY9o5Xa0JW0T6
	fYKwfZ1BbksJSQHb35XcdgRkifJDyPiEFuO8RtmDI1rkEIOKHDrb+GHcKK4qiKircGrC+8w76X9PL
	ieL2IdKXmYljon5XV8XvQGRNRrqxBdQh87gZp+JSjhVOJ9zPhdac3GjvYzI1XhLoGiBqBBjOMsqKS
	wgsDBE/npELYE6gd0b6jQqsCwe5eDcTQaEhp3zE2DAd+ZRA9lbhD/Eiebo2qQoA9jjyryJw7K1+88
	2rWx/qr2ged3Ljm0qqHSqRoGf9YlurbrTQDMBRTEU70qGzB1PfW1DnRPbSbS3o/74BbQV0neKqY+U
	L5r0U1qA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1tu8TA-0006DP-20;
	Mon, 17 Mar 2025 12:17:20 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=mail.your-server.de)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1tu8TA-0003Yc-2H;
	Mon, 17 Mar 2025 12:17:20 +0100
Date: Mon, 17 Mar 2025 12:17:17 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	subhajit.ghosh@tweaklogic.com, muditsharma.info@gmail.com,
	arthur.becker@sentec.com, ivan.orlov0322@gmail.com
Subject: Re: [PATCH 1/3] dt-bindings: iio: light: veml6046x00: add color
 sensor
Message-ID: <Z9gEveqC91o8Ojks@mail.your-server.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-2-ak@it-klinger.de>
 <20250317110012.2ad89cb9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XEGLpz3pfiqoz7zZ"
Content-Disposition: inline
In-Reply-To: <20250317110012.2ad89cb9@jic23-huawei>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27580/Mon Mar 17 10:42:01 2025)


--XEGLpz3pfiqoz7zZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,


Jonathan Cameron <jic23@kernel.org> schrieb am Mo, 17. M=C3=A4r 11:00:
> On Sun, 16 Mar 2025 12:31:29 +0100
> Andreas Klinger <ak@it-klinger.de> wrote:
>=20
> > Add a new compatible for Vishay high accuracy RGBIR color sensor
> > veml6046x00.
> >=20
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../iio/light/vishay,veml6046x00.yaml         | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,=
veml6046x00.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml604=
6x00.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.=
yaml
> > new file mode 100644
> > index 000000000000..3207800fc539
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.ya=
ml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/vishay,veml6046x00.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Vishay VEML6046X00 High accuracy RGBIR color sensor
> > +
> > +maintainers:
> > +  - Andreas Klinger <ak@it-klinger.de>
> > +
> > +description:
> > +  VEML6046X00 datasheet at https://www.vishay.com/docs/80173/veml6046x=
00.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - vishay,veml6046x00
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        color-sensor@29 {
> > +            compatible =3D "vishay,veml6046x00";
> > +            reg =3D <0x29>;
> > +            vdd-supply =3D <&vdd_reg>;
> > +            interrupt-parent =3D <&gpio2>;
> > +            interrupts =3D <3 IRQ_TYPE_EDGE_FALLING>;
> Need an include for this I think.  Make sure to test build your
> bindings following the instructions in the bot message.

I already sent out an version 2 yesterday which is with the include, tested=
 and
already reviewed by Krzysztof.

Andreas

>=20
> Thanks,
>=20
> Jonathan
>=20
> > +        };
> > +    };
> > +...
>=20

--XEGLpz3pfiqoz7zZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmfYBL0ACgkQyHDM+xwP
AVE2lQv9GdwIjbFFQpSvLsazG5OU3K07IvPqo35rsS/LWbOon1cgXXLdLbpO/qZY
uz6I/70wIzNxh2TFTKBZZYwMGJW76erVQbnRQV1tb+OLDqYgvGNIa7BAqqsrYGcP
t1VTvDoiR5+xawWbaeiIaAMtNtaM2jDBJRslmdmx7zwCSsHaTRLCEe83oiuEDlYL
FmcIQqixuiupDtjdXkj8dTciGUAtpS9pOqihxT/5EOueA6+e8B0LAlhLcKhNKEKD
qKx5VTwWU8F1gaX/4BawUXhMY9ZmJzuEwMqQkMIWtOYVDTIT/2WMyowrQJ998vQ5
F0CqB+P9lmnOnrMX7rK8kw6b0qJgNMm1nX3weyE8QSZfhktHyjide90SqREbsENn
r05jziiGjpCrJwOO0FizygmA/3xs3cr4f6YzGt3viE9tjXmeMpK/6fFjATmReTXP
DVaduXUwY5v2vj3jnU90aEBJn2gVCrtB/8inSCqAUSH+IBekuLh+K9W3PWrCEVr6
Ft/LQ0id
=H3cW
-----END PGP SIGNATURE-----

--XEGLpz3pfiqoz7zZ--

