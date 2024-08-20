Return-Path: <linux-iio+bounces-8638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B087958C6E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 18:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B6D283F94
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF331C579E;
	Tue, 20 Aug 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAXys7ru"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217C1AE04F;
	Tue, 20 Aug 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171919; cv=none; b=iREbtoO6KtU3HC0TUk2ySqlnWDB4ArByKBBRdW+7BNzpyZuxEenZGM6WtsCths70axooBRt+qAihqyJw1gRgV0RoO+H4yyg3NnNQwom5L/1AzE2psrau0SykzcFFor4XD7yG/algzoMkJ9YYlT/htsjN31rowYy2OCCWbbyxms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171919; c=relaxed/simple;
	bh=eTAFu5MDjrr3QkWwNJyutsTNYLYlsNqI67cfpl+Qv9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXHWWMCc5P0JeZioJTeC9epqrtjMhfv5vWUDeoMKF1JPwkGb3QpU6gZO9oxsRkmcBiOxFeuy1q9+qsr1d0GC3gp2dIklyiv2+gPX6PgQVSzJY9nfg4pls+mpUEMN+iSOPGQbp3PaNO7BIs5OprIcqx2/hQ/ccnwxmZWY6S3Uopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAXys7ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECDAC4AF0B;
	Tue, 20 Aug 2024 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724171919;
	bh=eTAFu5MDjrr3QkWwNJyutsTNYLYlsNqI67cfpl+Qv9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAXys7rutrHrlW4Zyuz6HS3stTrofPuyIPs6AAcMEegfz062bJvYWe072vA5KIuy5
	 R6VTDQaBlgVQpxTo/ofP99jNXx+3sr0g/0XGJG6q0mQWWYiooJ8ld2/mKVvwMEV0lP
	 9Ylvt2UShnORRzCpuG/LQgyuGgh2uT1Z+q+RrfLPdToXo9yzvZ/yWCQx2tn1b8bbz5
	 Wdt9Usx8eUEZqDk8WLsKaD3yIXFVBwd3oNsLtQulh6h8ga1OfuV0WD1chxa8V02vTt
	 sm9ssfAiSBGjdTH+KgEE4e/mTy4Ocr/WJ/c51i/7b/Or1Yx8+Nyr3LjLS3cvLw2jMH
	 gZ6YH/xorjDIg==
Date: Tue, 20 Aug 2024 17:38:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo CV18XX SARADC binding
Message-ID: <20240820-borough-latch-17d785301aef@spud>
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
 <20240812-sg2002-adc-v4-1-599bdb67592f@bootlin.com>
 <20240812-unwary-mongrel-9f6758bf624c@spud>
 <89aabfbe-79bf-4da7-be44-b6cbd92b72a9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6ptQ2bA1w/WPJsRN"
Content-Disposition: inline
In-Reply-To: <89aabfbe-79bf-4da7-be44-b6cbd92b72a9@bootlin.com>


--6ptQ2bA1w/WPJsRN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 06:21:07PM +0200, Thomas Bonnefille wrote:
> Hello Conor,
>=20
> On 8/12/24 5:53 PM, Conor Dooley wrote:
> > On Mon, Aug 12, 2024 at 05:00:55PM +0200, Thomas Bonnefille wrote:
> > > The Sophgo SARADC is a Successive Approximation ADC that can be found=
 in
> > > the Sophgo SoC.
> > >=20
> > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > ---
> > >   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 85 +++++++++++=
+++++++++++
> > >   1 file changed, 85 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-=
saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-sarad=
c.yaml
> > > new file mode 100644
> > > index 000000000000..846590808e5f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.=
yaml
> > > @@ -0,0 +1,85 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
> >=20
> > Filename matching the compatible please.
> >=20
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title:
> > > +  Sophgo CV18XX SoC series 3 channels Successive Approximation Analo=
g to
> > > +  Digital Converters
> > > +
> > > +maintainers:
> > > +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > +
> > > +description:
> > > +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sophgo,cv1800b-saradc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +patternProperties:
> > > +  "^channel@[0-3]+$":
> > > +    $ref: adc.yaml
> > > +
> > > +    description: |
> >=20
> > This | is not required.
> >=20
> > > +      Represents the channels of the ADC.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: |
> > > +          The channel number. It can have up to 3 channels numbered =
=66rom 0 to 2.
> > > +        items:
> > > +          - minimum: 0
> > > +            maximum: 2
> >=20
> > Is this sufficient to limit the number of channels to 3? Aren't you rel=
ying
> > on the unique unit addresses warning in dtc to limit it, rather than
> > actually limiting with min/maxItems?
> >=20
> It seems like I can't use min/maxItems on this property. I think that it =
is
> using size-cells + address-cells to deduce that the number of items should
> be equal to 1.

I think I was mistaken in talking about mix/max items here. I had the
right idea, but mentioned an incorrect solution - sorry about that. I
wasn't talking about the number of elements in the reg property, what I
meant was limiting the number of channel nodes in the first place -
something which min/maxItems cannot do. As examples of the problem I was
thinking of, see the below two examples:

    adc@30f0000 {
        compatible =3D "sophgo,cv1800b-saradc";
        reg =3D <0x030f0000 0x1000>;
        clocks =3D <&clk CLK_SARADC>;
        interrupts =3D <100 IRQ_TYPE_LEVEL_HIGH>;
        #address-cells =3D <1>;
        #size-cells =3D <0>;

        channel@0 {
            reg =3D <0>;
        };
        channel@2 {
            reg =3D <2>;
        };
        channel@22 {
            reg =3D <2>;
        };
    };

    adc@30f0000 {
        compatible =3D "sophgo,cv1800b-saradc";
        reg =3D <0x030f0000 0x1000>;
        clocks =3D <&clk CLK_SARADC>;
        interrupts =3D <100 IRQ_TYPE_LEVEL_HIGH>;
        #address-cells =3D <1>;
        #size-cells =3D <0>;

        channel@0 {
            reg =3D <0>;
        };
        channel@2 {
            reg =3D <2>;
        };
        channel@22 {
            reg =3D <2>;
        };
    };

The solution is simple, remove the + from the regex. Sorry for sending
you on the wrong track Thomas.

Thanks,
Conor.

> Looking at the dtschema repository it seems to be the case in reg.yaml wi=
th
> address-cells/size-cells =3D 2/2, 1/1 and 2/1.
> If I try to use maxItems here :
>=20
>     properties:
>       reg:
>         maxItems: 1
>         items:
>           - minimum: 0
>             maximum: 2
>=20
> I get this strange error message from `make dt_binding_check`:
>=20
> DTEX
> Documentation/devicetree/bindings/iio/adc/sophgo,cv1800b-saradc.example.d=
ts
> /home/thomas/linux/Documentation/devicetree/bindings/iio/adc/sophgo,cv180=
0b-saradc.yaml:
> patternProperties:^channel@[0-2]+$:properties:reg: {'maxItems': 1, 'items=
':
> [{'minimum': 0, 'maximum': 2}]} should not be valid under {'required':
> ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /home/thomas/linux/Documentation/devicetree/bindings/iio/adc/sophgo,cv180=
0b-saradc.yaml:
> patternProperties:^channel@[0-2]+$:properties:reg: 'anyOf' conditional
> failed, one must be fixed:
> 	'items' is not one of ['maxItems', 'description', 'deprecated']
> 		hint: Only "maxItems" is required for a single entry if there are no
> constraints defined for the values.
> 	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum',
> 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
> 	'items' is not one of ['description', 'deprecated', 'const', 'enum',
> 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
> 	1 is less than the minimum of 2
> 		hint: Arrays must be described with a combination of
> minItems/maxItems/items
> 	hint: cell array properties must define how many entries and what the
> entries are when there is more than one entry.
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>=20
> Isn't it okay to just use minimum and maximum and rely on
> address-cells/size-cells for the number of items allowed ?
>=20

--6ptQ2bA1w/WPJsRN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsTGiQAKCRB4tDGHoIJi
0lmMAQCp1+yBiaWxL3PTB/rJ5FazFWt3PM2XHDc3R2L8MtUWpwD/dkGI2qROY760
7Swgkl94fpctemkgXSdKI98EEnnPEAE=
=3s0l
-----END PGP SIGNATURE-----

--6ptQ2bA1w/WPJsRN--

