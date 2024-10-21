Return-Path: <linux-iio+bounces-10885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0EC9A7229
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 20:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09C6B231A9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351A1FA24F;
	Mon, 21 Oct 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWy+/52V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E01991D7;
	Mon, 21 Oct 2024 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534663; cv=none; b=QR4PYnhsuMNHXZ4UFnX2Hq6cgz9IPRzdaGwOdGK3nGqGGSpjeVKgVFAlffGaU6pHGhOMSwul6KVNd+GVOwJTTNr4CfyNcf1RdOcfZVh7XmNMbpDmT+K7k1UzW1j+DX+vVHcOowmFrkGB+U2KEKIa5coZCaiGT7gJhBBFZAOuosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534663; c=relaxed/simple;
	bh=d2SeStnmhq8JEyrMJZ5WkqXAeS7OgZrjtjXl7ImqqM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrYXuB1MhsyJqtSn81lK8vHT/8g7CYo95JkoM/Fh/cGrGbFv0/YQUhSrxFIh/hB9r1rYbzm1fqd56mRsCG1i42UoVgcq0ufwkwhc9pLSPxfn+he8MOzpomkSVZjigNlBToj15Kn89NHXuw+pvRfK3hEJuloVUM79bXZeKECxSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWy+/52V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175E5C4CEC3;
	Mon, 21 Oct 2024 18:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729534663;
	bh=d2SeStnmhq8JEyrMJZ5WkqXAeS7OgZrjtjXl7ImqqM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iWy+/52VE8UGx+zVeUlWkWGyTVJj0e7oBdybTVDHNOc4hvrffxrtussawXxvs/aO5
	 5WNX5wtX9x3lg49FL3LDT2WaYXMjLC/gE7kaQ+RnVUJDSZR0PIbhVzzN+syUE8HV18
	 +aqLf0/atKlztaU/HV62ERN1ySwbw5baVzyi6uUrroyoOsHjoanra9u979JWA8Yo4k
	 YT4f1/zfHKIEKKMue6VOFWraRK4PFUEfQsMR09caANiXK3x2r6mJWEFNBPPwqDxubQ
	 RfnzuLfeYwsxzvatpCTW5kpB8YLLo0dwzvhLPzx5/GNv6NoSog6g6wVQTsGyDPlHgP
	 grA0E6twIxD4Q==
Date: Mon, 21 Oct 2024 19:17:34 +0100
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
Message-ID: <20241021191734.16f33178@jic23-huawei>
In-Reply-To: <CAEHHSvaHo102=133Jpzj0N=qh4_x7e9ZZG47S7Vgr6z3W9qisA@mail.gmail.com>
References: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
	<20241015-ad7380-add-adaq4380-4-support-v1-1-d2e1a95fb248@baylibre.com>
	<20241020142058.6ce576f8@jic23-huawei>
	<CAEHHSvaHo102=133Jpzj0N=qh4_x7e9ZZG47S7Vgr6z3W9qisA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Oct 2024 15:25:23 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Le dim. 20 oct. 2024 =C3=A0 15:21, Jonathan Cameron <jic23@kernel.org> a =
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
> > > - configurable gain in front of each 4 adc =20
> > As per quick review I gave for the driver code, I'm not seeing why
> > a configurable gain is a DT thing on an ADC vs something that belongs
> > in userspace control.  I may be missing something though.
> >
> > It exists for the ad4000 because the control isn't via registers
> > but via pin straps so we can't control it sensibly from userspace. =20
>=20
>=20
> Hi Jonathan,
> I indeed based my work on ad4000. I think my commit description is
> erroneous and confusing.
> On the first page of the datasheet
> (https://www.analog.com/media/en/technical-documentation/data-sheets/adaq=
4380-4.pdf)
> it's written : Pin selectable Gain/attenuation. So I guess adaq4380-4
> and adaq4370-4 are working the same way as the adaq4000 series.
> I'll rewrite my commit message. Also, I didn't want to restrict users
> to the gain values in the datasheet, because I thought they are just
> examples and users can always use additional resistance to change the
> gain. Am I correct? Or should I use the datasheet values (as adaq4000
> series does) ?
Ah. Now seeing how this works.

Hmm. For completely external circuitry we have the various analog front
end drivers that act as a consumer of an ADC.  For this case it is messier
as there are internal resistors.  However I don't immediately see examples
of using external registers to some of the pins and not others.
So I'd be inclined to just allow the pin strap values as show in figure
50 to 55.=20

So I'd just add docs to give the pin wiring as well as the gain.
Afterall DT writer probably has a circuit diagram, not a statement
of the gain of that circuit.

Jonathan


>=20
> Cheers
> Julien
>=20
> >
> > Jonathan
> > =20
> > > - internal reference is 3V derived from refin-supply (5V)
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
ply
> > >    # All other chips from ad738x family use refio as optional externa=
l reference.
> > >    # When refio-supply is omitted, internal reference is used.
> > >    - if:
> > > @@ -136,6 +188,8 @@ allOf:
> > >          compatible:
> > >            enum:
> > >              - adi,ad7380-4
> > > +            - adi,adaq4370-4
> > > +            - adi,adaq4380-4
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


