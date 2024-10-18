Return-Path: <linux-iio+bounces-10741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC619A4579
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 20:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB81B1F232EF
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467F62040B6;
	Fri, 18 Oct 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlYib0X4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A488472;
	Fri, 18 Oct 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274986; cv=none; b=EkztLX9Y6XU4ziQ7Du+d4t6wpUhsWmcwCPqdoKBKJ/Haung6WJUsWODoR2Im1O5TYznP0ovz0HfV7QQcwaTKTNeisAcHJ7P28XeDaZKemZsl1e5cExMw6DoiR0XPp3AdHAxP7WVfLT+02vurbRySUcaR20yLYSyQl2tvjRgD20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274986; c=relaxed/simple;
	bh=sXIqeDR8KfRnIo7WqdszBU9gzyDxJUvTxH0U262dlnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pkb3pwIX8WpOnRzQ5EwBV9pL/ihCbPPB2OvYtEpP5/OW3hUnzCGnHozU0DeewCvuLczs9b9SO4BNp64t+qgOnlYwVbBswkockQFjTcuLs6eyktbJHfUQ7o3tp2eJtp1jC8sZ6kQr9sQmVoWMDAB5QKhntRagrgdXsenvP0rOhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlYib0X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98905C4CEC3;
	Fri, 18 Oct 2024 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729274985;
	bh=sXIqeDR8KfRnIo7WqdszBU9gzyDxJUvTxH0U262dlnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FlYib0X4kf45PiJ9ZI3yaOOF+ZXC8sqO02Bv5EMVEyQSHZJ7HdsB4NSrTfwRmwi14
	 P/jBeo8olteF3vX3au/Hc9taArKbMPH7TT4Tb39z1+vBNdn3x3/NwdiLpDCyQeMLVF
	 1AiXyjHb8aJdkQQWoSg4mqxWqqjTJIfxzUDnqqPJ6ksZQJQgLdqrLFzyT25rQtTlWC
	 sZmpOYxntQWhBEBAypgkTHn991mtLFMOBpKvL2J9nJC66NKe6/KRocjnHX1ypQ4htA
	 AbmlYjRhUHiIvPLW/hKQN4qHFKE3G2v8VuL6FRYfxIxrCV3JKARTDw7RpZNVHKpJYG
	 Yn2BYXW6RtVXg==
Date: Fri, 18 Oct 2024 19:09:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] dt-bindings: iio: adc: ad7380: add adaq4370-4
 and adaq4380-4 compatible parts
Message-ID: <20241018190928.6f0ee863@jic23-huawei>
In-Reply-To: <CAEHHSvZrXNrh_DsyrnjjBfZJ3STYmA+HdysakO-54T6qYwTfrQ@mail.gmail.com>
References: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
	<20241015-ad7380-add-adaq4380-4-support-v1-1-d2e1a95fb248@baylibre.com>
	<20241017190500.215b895e@jic23-huawei>
	<CAEHHSvZrXNrh_DsyrnjjBfZJ3STYmA+HdysakO-54T6qYwTfrQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 09:36:52 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Le jeu. 17 oct. 2024 =C3=A0 20:05, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
> >
> > On Tue, 15 Oct 2024 11:09:06 +0200
> > Julien Stephan <jstephan@baylibre.com> wrote:
> > =20
> > > adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision =
data
> > > acquisition signal chain =CE=BCModule solutions compatible with the a=
d738x
> > > family, with the following differences:
> > >
> > > - configurable gain in front of each 4 adc
> > > - internal reference is 3V derived from refin-supply (5V) =20
> >
> > Now I'm confused.
> >
> > The earlier refin-supply change appears unused in this patch.
> > I was expecting it to be required for the additional devices.
> > With additions to the docs from the fix to explain the new
> > cases.  I'm not seeing that in here.
> >
> > =20
> > > - additional supplies
> > >
> > > To configure the gain a new patternProperties is added to describe ea=
ch
> > > channel. It is restricted to adaq devices.
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 117 +++++++++++=
++++++++++
> > >  1 file changed, 117 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yam=
l b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > > index 74d82721637c..3007d8e39684 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > > @@ -25,6 +25,8 @@ description: |
> > >    * https://www.analog.com/en/products/ad7386-4.html
> > >    * https://www.analog.com/en/products/ad7387-4.html
> > >    * https://www.analog.com/en/products/ad7388-4.html
> > > +  * https://www.analog.com/en/products/adaq4370-4.html
> > > +  * https://www.analog.com/en/products/adaq4380-4.html
> > >
> > >
> > >  $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > @@ -46,6 +48,8 @@ properties:
> > >        - adi,ad7386-4
> > >        - adi,ad7387-4
> > >        - adi,ad7388-4
> > > +      - adi,adaq4370-4
> > > +      - adi,adaq4380-4
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -59,6 +63,9 @@ properties:
> > >    vlogic-supply: true
> > >    refio-supply: true
> > >    refin-supply: true
> > > +  vs-p-supply: true
> > > +  vs-n-supply: true
> > > +  ldo-supply: true
> > >
> > >    aina-supply:
> > >      description:
> > > @@ -86,12 +93,43 @@ properties:
> > >        specify the ALERT interrupt.
> > >      maxItems: 1
> > >
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > >    - vcc-supply
> > >    - vlogic-supply
> > >
> > > +patternProperties:
> > > +  "^channel@([0-3])$":
> > > +    $ref: adc.yaml
> > > +    type: object
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description:
> > > +          The channel number. From 0 to 3 corresponding to channels =
A,B,C,D
> > > +        items:
> > > +          minimum: 0
> > > +          maximum: 3
> > > +
> > > +      adi,gain-milli:
> > > +        description:
> > > +          The hardware gain applied to the ADC input (in milli units=
).
> > > +          If not present, default to 1000 (no actual gain applied).
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        default: 1000
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +    additionalProperties: false
> > > +
> > >  unevaluatedProperties: false
> > >
> > >  allOf:
> > > @@ -128,7 +166,21 @@ allOf:
> > >          ainc-supply: false
> > >          aind-supply: false
> > >
> > > +  # Using channel to declare gain property only applies to adaq devi=
ces
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          not:
> > > +            contains:
> > > +              enum:
> > > +                - adi,adaq4370-4
> > > +                - adi,adaq4380-4
> > > +    then:
> > > +      patternProperties:
> > > +        "^channel@([0-3])$": false
> > > +
> > >    # ad7380-4 uses refin-supply as external reference.
> > > +  # adaq devices use internal reference only, derived from refin-sup=
ply =20
>=20
> Hi Jonathan,
>=20
> here I add a quick description on how adaq devices are using refin-supply=
 ...
>=20
> > >    # All other chips from ad738x family use refio as optional externa=
l reference.
> > >    # When refio-supply is omitted, internal reference is used.
> > >    - if:
> > > @@ -136,6 +188,8 @@ allOf:
> > >          compatible:
> > >            enum:
> > >              - adi,ad7380-4
> > > +            - adi,adaq4370-4
> > > +            - adi,adaq4380-4 =20
>=20
> ... and adaq devices are added here to require refin-supply.
>=20
> Maybe I am missing your point? or I still need to improve the description?
Nope. I just misread the diff!  Thanks for pointing out the key bits.

Jonathan

>=20
> Cheers
> Julien
>=20
> > >      then:
> > >        properties:
> > >          refio-supply: false
> > > @@ -145,6 +199,24 @@ allOf:
> > >        properties:
> > >          refin-supply: false
> > >
> > > +  # adaq devices need more supplies
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          enum:
> > > +            - adi,adaq4370-4
> > > +            - adi,adaq4380-4
> > > +    then:
> > > +      required:
> > > +        - vs-p-supply
> > > +        - vs-n-supply
> > > +        - ldo-supply
> > > +    else:
> > > +      properties:
> > > +        vs-p-supply: false
> > > +        vs-n-supply: false
> > > +        ldo-supply: false
> > > +
> > >  examples:
> > >    - |
> > >      #include <dt-bindings/interrupt-controller/irq.h>
> > > @@ -169,3 +241,48 @@ examples:
> > >              refio-supply =3D <&supply_2_5V>;
> > >          };
> > >      };
> > > +
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    spi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        adc@0 {
> > > +            compatible =3D "adi,adaq4380-4";
> > > +            reg =3D <0>;
> > > +
> > > +            spi-cpol;
> > > +            spi-cpha;
> > > +            spi-max-frequency =3D <80000000>;
> > > +
> > > +            interrupts =3D <27 IRQ_TYPE_EDGE_FALLING>;
> > > +            interrupt-parent =3D <&gpio0>;
> > > +
> > > +            vcc-supply =3D <&supply_3_3V>;
> > > +            vlogic-supply =3D <&supply_3_3V>;
> > > +            refin-supply =3D <&supply_5V>;
> > > +            vs-p-supply =3D <&supply_5V>;
> > > +            vs-n-supply =3D <&supply_0V>;
> > > +            ldo-supply =3D <&supply_5V>;
> > > +
> > > +            #address-cells =3D <1>;
> > > +            #size-cells =3D <0>;
> > > +
> > > +            channel@0 {
> > > +                reg =3D <0>;
> > > +                adi,gain-milli =3D <300>;
> > > +            };
> > > +
> > > +            channel@2 {
> > > +                reg =3D <2>;
> > > +                adi,gain-milli =3D <600>;
> > > +            };
> > > +
> > > +            channel@3 {
> > > +                reg =3D <3>;
> > > +                adi,gain-milli =3D <1000>;
> > > +            };
> > > +        };
> > > +    };
> > > =20
> > =20


