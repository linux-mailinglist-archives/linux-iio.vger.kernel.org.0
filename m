Return-Path: <linux-iio+bounces-6710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A245913310
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13521F22C61
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16E14D457;
	Sat, 22 Jun 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoZ62Aqj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1438818;
	Sat, 22 Jun 2024 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719053483; cv=none; b=kJxKqH32Pbg7lR7zb9TOZkyg4Yv+KE454hw5SyaO9hQWQ4zNK2T0F3I+djT2BZ7AWwgALRq3NhaxEFNWkFhNTAVnGIr2wLCGVCoLGQUVcx1+lq6AB+9fFGpHwt7FYsYlEeuftQX8aibPtbWbXVPiIqFC4p5gaFzftoOMwZ9BDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719053483; c=relaxed/simple;
	bh=960cXuebD/jrt7Pj4lCaavm+XD/B5zGQeG1Brjir1sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYMaHTy1kMMZz5/SJcjr8Z69S8nT2gN0nF0fu/osXrZGn7zoeETD+65GyeR1j3veYS91wvPjvL7P2ge7o+ixMBX1qDtCESqQHZ07IMK4AF5hOnHvutXx0F82Lp45dWSG1YaGUH3WyipzZq+kqhXuN0++SFNCf3K8S1rPQzQKG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoZ62Aqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D96AC32789;
	Sat, 22 Jun 2024 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719053482;
	bh=960cXuebD/jrt7Pj4lCaavm+XD/B5zGQeG1Brjir1sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CoZ62AqjvDX+KS4eXWJpXm0HTGnoXUg9yrukho6H31cjTAj+/OBuM82G3tlFk+sjH
	 Fq08ysJmvB6v5tlP/dpf1H5xT/cnsU6vd7m/7oPavBbHOT8D/gyrHPxGw4ExKbWpde
	 4Huz0jK97JWh4/LJU4tWXUdx+hJGzj94uE/E5o8RSXGVK4NKtY6YAMIf0lKvgQ/5Lk
	 zbbI5pCZvGdkvZv+5rmOc26lmGLU20eGVx4TiWMVGL4JwmGn7SHkyaVrzuTv/FG6cJ
	 dEuh6kPW/qZ+37fzT4A2xS5j8XOwzVu3eyMd2p+xKjjc8e9N9UwsPxdr+TVj0WuZ5k
	 vP6RYM3AZowPg==
Date: Sat, 22 Jun 2024 11:51:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
Message-ID: <20240622-superjet-dusk-cfd19f899cc2@spud>
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
 <20240621-add-tyhx-hx9023s-sensor-driver-v6-2-65196a9020f1@gmail.com>
 <d35f5eba-abb4-4924-89d6-0beb878a0bf7@kernel.org>
 <385a7a64-fc76-4655-bc7f-d89d00b053d5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gUJhbPKbgezA3PSV"
Content-Disposition: inline
In-Reply-To: <385a7a64-fc76-4655-bc7f-d89d00b053d5@gmail.com>


--gUJhbPKbgezA3PSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 01:56:42PM +0800, Yasin Lee wrote:
>=20
> On 2024/6/21 18:12, Krzysztof Kozlowski wrote:
>=20
> Hi ,Krzysztof
> Thank you for your reply. I have some questions inline.
>=20
> Best regards,
> Yasin
>=20
> > On 21/06/2024 09:40, Yasin Lee wrote:
> > > A capacitive proximity sensor
> > >=20
> > > Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> > > ---
> > >   .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 115 ++++++++++=
+++++++++++
> > >   1 file changed, 115 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9=
023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.ya=
ml
> > > new file mode 100644
> > > index 000000000000..beca70ce7609
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.ya=
ml
> > > @@ -0,0 +1,115 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TYHX HX9023S capacitive proximity sensor
> > > +
> > > +maintainers:
> > > +  - Yasin Lee <yasin.lee.x@gmail.com>
> > > +
> > > +description: |
> > > +  TYHX HX9023S proximity sensor. Datasheet can be found here:
> > > +    http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718=
336303992081.pdf
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/iio/iio.yaml#
> > Which part of iio.yaml binding do you use here? I cannot find anything,
> > so this looks wrong.=09
> >=20
>=20
> I will remove this reference.
>=20
>=20
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: tyhx,hx9023s
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    description:
> > > +      Generated by device to announce preceding read request has fin=
ished
> > > +      and data is available or that a close/far proximity event has =
happened.
> > > +    maxItems: 1
> > > +
> > > +  vdd-supply: true
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +
> > > +patternProperties:
> > > +  "^channel@[0-4]$":
> > > +    $ref: /schemas/iio/adc/adc.yaml
> > > +    type: object
> > > +
> > > +    properties:
> > > +      reg:
> > > +        minimum: 0
> > > +        maximum: 4
> > > +        description: The channel number.
> > > +
> > > +      input-channel:
> > Isn't this duplicating single-channel property?
> >=20
> > Where is this property defined (which common schema)?
> >=20
> |input-channel| is indeed intended for single-ended configuration, but I
> couldn't find a definition
>=20
> or reference for |single-channel| anywhere. If possible, should I rename
> |input-channel| to |single-channel|?

Single-channel is new, it should be the next branch of the iio tree and
in linux-next.

--gUJhbPKbgezA3PSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnaspgAKCRB4tDGHoIJi
0g9LAQDKw1UTXpFxh99pjDFg2oRBTymO7dw01m0Q/7sF+L+UHAEA71aE+1JxlQ5a
JjHRsQRT9Iv7LFLWklVexkyzhm1JHQE=
=szw6
-----END PGP SIGNATURE-----

--gUJhbPKbgezA3PSV--

