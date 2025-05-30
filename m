Return-Path: <linux-iio+bounces-20042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857CAC92C3
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233B84A4743
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDE622F169;
	Fri, 30 May 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGL9zKJw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499E19CC3A;
	Fri, 30 May 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620521; cv=none; b=QD99kZSoSuiqy6IEJ/kssPCau9h0KGV5V36O8I1ymWsJh/QFfcFUrsbvWdD78/ObYpb94toyEJDWYFJxNKxsaDf6HQtxiCNzk+EKr830geLK29tXvJ+anTRoRYm28QkeUeUF9P+VSPgKecrkg7QhSpUwK9Y0KSOsGSccBP9gPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620521; c=relaxed/simple;
	bh=8PdC2kYuXqxW3YVc+vbFC1LPwUWHTwY8QdyF2cDROX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHjusrJBt3looYqHlUwPm94j+sCfuLzC+Dl2Z1T6lFyGtR5aw0Kt1E9hcShE0/B/CBuGkDu6LOhURQvK5xDifybj2WX3+LfX75roMvLXRfLnz+s4OH17+uaBK5NjTj61vQ7P80+tHudai52Ecw7T0aRUdag1tTzWoP8r/mkGclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGL9zKJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EB0C4CEE9;
	Fri, 30 May 2025 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748620520;
	bh=8PdC2kYuXqxW3YVc+vbFC1LPwUWHTwY8QdyF2cDROX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGL9zKJwZJh+pfq2qvhUTrfetVdx3bxBkvY0kaxFYn8ts/y4uzf/jeJU0m0umP2SV
	 SOnPULjLjdsJRi5FveA2YMtGpMjPnIOX5M9HSkaBn63im/bK4HPGkv8+o5BhpzUlvR
	 RMsgD8aiTHejNbqeZsMVCJHaOJqyINrcktakPCjKEHKif7m3Lw8aTG7TIGKnpedhSv
	 5lqpzYs066S6Jcz0A4bCl6OsPWA3Wbiemfu9XsnfSAkkGUYUHKrwSPdwHi20h+Wn6g
	 f+mI9yxfXOBgkKKvh4bmNKLaiSvJGMeQxuO0ac1um6axB83LI4TLPiFT1+lhZuo3mO
	 EcUACd9T2wcRA==
Date: Fri, 30 May 2025 16:55:16 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: victor.duicu@microchip.com, jic23@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marius.cristea@microchip.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Message-ID: <20250530-dramatize-camisole-0a1aa9a38281@spud>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
 <20250529093628.15042-2-victor.duicu@microchip.com>
 <0f68e3f9-cba5-4df3-8e56-2cccbccf35ce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e/ifQMFPjIAS9lJY"
Content-Disposition: inline
In-Reply-To: <0f68e3f9-cba5-4df3-8e56-2cccbccf35ce@baylibre.com>


--e/ifQMFPjIAS9lJY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 01:13:38PM -0500, David Lechner wrote:
> On 5/29/25 4:36 AM, victor.duicu@microchip.com wrote:
> > From: Victor Duicu <victor.duicu@microchip.com>
> >=20
> > This is the devicetree schema for Microchip MCP998X/33 and
> > MCP998XD/33D Multichannel Automotive Temperature Monitor Family.
> >=20
> > Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> > ---
> >  .../iio/temperature/microchip,mcp9982.yaml    | 174 ++++++++++++++++++
> >  1 file changed, 174 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/m=
icrochip,mcp9982.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/microchi=
p,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchi=
p,mcp9982.yaml
> > new file mode 100644
> > index 000000000000..249470c8953b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp99=
82.yaml
> > @@ -0,0 +1,174 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9982.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive
> > +       Temperature Monitor Family
> > +
> > +maintainers:
> > +  - Victor Duicu <victor.duicu@microchip.com>
> > +
> > +description: |
> > +  The MCP998X/33 and MCP998XD/33D family is a high-accuracy 2-wire mul=
tichannel
> > +  automotive temperature monitor.
> > +  The datasheet can be found here:
> > +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/Pr=
oductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,mcp9933
> > +      - microchip,mcp9933d
> > +      - microchip,mcp9982
> > +      - microchip,mcp9982d
> > +      - microchip,mcp9983
> > +      - microchip,mcp9983d
> > +      - microchip,mcp9984
> > +      - microchip,mcp9984d
> > +      - microchip,mcp9985
> > +      - microchip,mcp9985d
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    description:
> > +      alert1 indicates a HIGH or LOW limit was exceeded.
> > +      alert2 indicates a THERM limit was exceeded.
>=20
> I think we need minItems: 1 here.
>=20
> > +    items:
> > +      - const: alert1
> > +      - const: alert2
>=20
> Typically, interrupts are named after the pin they are wired to, not
> the signal. This is especially true when a single pin can be configured
> for different signals as is the case here.
>=20
> There is a /ALERT//THERM pin on all chips and a /THERM//ADDR pin on some
> chips.
>=20
> So I would expect the names to match that:
>=20
>     items:
>       - const: alert-therm
>       - const: therm-addr
>=20
> And then extra descriptions probably aren't needed.
>=20
> If we want to be extra careful, we could also add an -if: below to set
> maxItems: 1 for interrupts and interrupt-names on chips that only have
> the one pin.
>=20
> And I assume that the /SYS_SHDN pin would never be wired up as an interru=
pt?
>=20
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  microchip,apdd-state:
> > +    description:
> > +      Enable anti-parallel diode mode operation.
> > +      MCP9984/84D/85/85D and MCP9933/33D support reading two external =
diodes
> > +      in anti-parallel connection on the same set of pins.
> > +      Omit this tag to disable anti-parallel diode mode.
> > +    type: boolean
> > +
> > +  microchip,recd12:
> > +    description:
> > +      Enable resistance error correction for external channels 1 and 2.
> > +      Omit this tag to disable REC for channels 1 and 2.
> > +    type: boolean
> > +
> > +  microchip,recd34:
> > +    description:
> > +      Enable resistance error correction for external channels 3 and 4.
> > +      Omit this tag to disable REC for channels 3 and 4.

Why are these two devicetree properties, rather than runtime controls?

> > +    type: boolean
> > +
> > +  label:
> > +    description: Unique name to identify which device this is.
> > +
> > +  vdd-supply: true
> > +
> > +patternProperties:
> > +  "^channel@[1-4]$":
> > +    description:
> > +      Represents the external temperature channels to which
> > +      a remote diode is connected.
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        items:
> > +          minimum: 1
> > +          maximum: 4
> > +
> > +      microchip,ideality-factor:
> > +        description:
> > +          Each channel has an ideality factor.
> > +          Beta compensation and resistance error correction automatica=
lly
> > +          correct for most ideality errors. So ideality factor does no=
t need
> > +          to be adjusted in general.
> > +          Omit this tag in order to set the default value.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        default: 18
> > +
> > +      label:
> > +        description: Unique name to identify which channel this is.
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - microchip,mcp9982
> > +              - microchip,mcp9982d
> > +              - microchip,mcp9983
> > +              - microchip,mcp9983d
> > +    then:
> > +      properties:
> > +        microchip,apdd-state: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - microchip,mcp9982
> > +              - microchip,mcp9982d
> > +              - microchip,mcp9933
> > +              - microchip,mcp9933d
> > +    then:
> > +      properties:
> > +        microchip,recd34: false
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        temperature-sensor@4c {
> > +            compatible =3D "microchip,mcp9985";
> > +            reg =3D <0x4c>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            label =3D "temperature-sensor";
>=20
> This is the same as the node name, so probably not the best
> example of a label.

Ye, I'm not convinced this property has any value, when the channels
themselves can have labels.

>=20
> > +
> > +            microchip,apdd-state;
> > +            microchip,recd12;
> > +            microchip,recd34;
> > +            vdd-supply =3D <&vdd>;
> > +
> > +            channel@1 {
> > +                reg =3D <0x1>;
>=20
> Why 0x here?
>=20
> > +                label =3D "CPU Temperature";
> > +            };
> > +
> > +            channel@2 {
> > +                reg =3D <0x2>;
> > +                label =3D "GPU Temperature";
> > +            };
> > +        };
> > +    };
> > +
> > +...
>=20

--e/ifQMFPjIAS9lJY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDnU5AAKCRB4tDGHoIJi
0jhcAQDkD/eIZOanXqiKJ11EUmuSbVgbIE//E+mQmRkb4zrMCgEA6aK7uAeokpJM
jECgVIoOVJt//Kb9FoilMSTZfau47wE=
=qiRt
-----END PGP SIGNATURE-----

--e/ifQMFPjIAS9lJY--

