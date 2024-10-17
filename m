Return-Path: <linux-iio+bounces-10691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B73C9A2BA8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 20:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2748AB2408C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD891E009B;
	Thu, 17 Oct 2024 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB8KkKna"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AFF1E0089;
	Thu, 17 Oct 2024 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188317; cv=none; b=OYnbOqSUupIT8a8chqIC5GkwaJ0U53lASFtZE+rEFFI9UirJaZig1oD6SUNHhjgXSNIthJ9UaO3et5K5LStUZ9NvIygZOLtJiluPJCenzqX9RKW7Ew111Prh245YtXmW6207ombIDeHaeMHUijwRPvqaBI2rUsgOAWN6DZkq1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188317; c=relaxed/simple;
	bh=RDfDcHscGDDn1krobGn9EY6WlG/idbfvbr+OBlw0sR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgswmIRtx5gr7vgrysh5hVb6CLJH5QBFNH6qTsZhcdQ3oOnuSM000KOBEdqE1AqECOis38dfVR5BSCoOKwQwlnxVDLg2UAzrzrCmVOVTnC8phlRTNbzxD77cu+rlNVrisbps2xpXZQi+Fo+7oRAdjRWzZC1aPaonN40YQ+Rezok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB8KkKna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771F2C4CECE;
	Thu, 17 Oct 2024 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729188316;
	bh=RDfDcHscGDDn1krobGn9EY6WlG/idbfvbr+OBlw0sR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nB8KkKnabc1hgY9VeiQy8U110IRxnLEtZmLwYPjdP8nfkmFFjbN5WXwjc3dzurhTV
	 4ng9ygBNojCXU3M5y9OM6MklUGeUFLcqSk3RMSghF8APGY/oMVZORTtkOuHd2t+QsE
	 JYMgmCetQgYIG1dRN+8Hl6IqAli8GyP6haS7aYlAtpAI3zuVebIM44cwsXWw7YQ1tF
	 A5gHGpf2StC+bc2Vm++g9LoBKAxgsiH3KXyIQ+4s4WPfKMOTl6AVw74tDKo6mTTzca
	 Rb0w14OGaG5CaCVjXBGAG1KGfrf7WxuSWTplpaRLh4h1vcctxoCz7xMk6u0QGHHNnw
	 fm704pb/lTUlw==
Date: Thu, 17 Oct 2024 19:05:00 +0100
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
Message-ID: <20241017190500.215b895e@jic23-huawei>
In-Reply-To: <20241015-ad7380-add-adaq4380-4-support-v1-1-d2e1a95fb248@baylibre.com>
References: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
	<20241015-ad7380-add-adaq4380-4-support-v1-1-d2e1a95fb248@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 11:09:06 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision data
> acquisition signal chain =CE=BCModule solutions compatible with the ad738x
> family, with the following differences:
>=20
> - configurable gain in front of each 4 adc
> - internal reference is 3V derived from refin-supply (5V)

Now I'm confused.=20

The earlier refin-supply change appears unused in this patch.
I was expecting it to be required for the additional devices.
With additions to the docs from the fix to explain the new
cases.  I'm not seeing that in here.


> - additional supplies
>=20
> To configure the gain a new patternProperties is added to describe each
> channel. It is restricted to adaq devices.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 117 +++++++++++++++=
++++++
>  1 file changed, 117 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> index 74d82721637c..3007d8e39684 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> @@ -25,6 +25,8 @@ description: |
>    * https://www.analog.com/en/products/ad7386-4.html
>    * https://www.analog.com/en/products/ad7387-4.html
>    * https://www.analog.com/en/products/ad7388-4.html
> +  * https://www.analog.com/en/products/adaq4370-4.html
> +  * https://www.analog.com/en/products/adaq4380-4.html
> =20
> =20
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
> @@ -46,6 +48,8 @@ properties:
>        - adi,ad7386-4
>        - adi,ad7387-4
>        - adi,ad7388-4
> +      - adi,adaq4370-4
> +      - adi,adaq4380-4
> =20
>    reg:
>      maxItems: 1
> @@ -59,6 +63,9 @@ properties:
>    vlogic-supply: true
>    refio-supply: true
>    refin-supply: true
> +  vs-p-supply: true
> +  vs-n-supply: true
> +  ldo-supply: true
> =20
>    aina-supply:
>      description:
> @@ -86,12 +93,43 @@ properties:
>        specify the ALERT interrupt.
>      maxItems: 1
> =20
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>  required:
>    - compatible
>    - reg
>    - vcc-supply
>    - vlogic-supply
> =20
> +patternProperties:
> +  "^channel@([0-3])$":
> +    $ref: adc.yaml
> +    type: object
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number. From 0 to 3 corresponding to channels A,B,=
C,D
> +        items:
> +          minimum: 0
> +          maximum: 3
> +
> +      adi,gain-milli:
> +        description:
> +          The hardware gain applied to the ADC input (in milli units).
> +          If not present, default to 1000 (no actual gain applied).
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 1000
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
>  unevaluatedProperties: false
> =20
>  allOf:
> @@ -128,7 +166,21 @@ allOf:
>          ainc-supply: false
>          aind-supply: false
> =20
> +  # Using channel to declare gain property only applies to adaq devices
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - adi,adaq4370-4
> +                - adi,adaq4380-4
> +    then:
> +      patternProperties:
> +        "^channel@([0-3])$": false
> +
>    # ad7380-4 uses refin-supply as external reference.
> +  # adaq devices use internal reference only, derived from refin-supply
>    # All other chips from ad738x family use refio as optional external re=
ference.
>    # When refio-supply is omitted, internal reference is used.
>    - if:
> @@ -136,6 +188,8 @@ allOf:
>          compatible:
>            enum:
>              - adi,ad7380-4
> +            - adi,adaq4370-4
> +            - adi,adaq4380-4
>      then:
>        properties:
>          refio-supply: false
> @@ -145,6 +199,24 @@ allOf:
>        properties:
>          refin-supply: false
> =20
> +  # adaq devices need more supplies
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - adi,adaq4370-4
> +            - adi,adaq4380-4
> +    then:
> +      required:
> +        - vs-p-supply
> +        - vs-n-supply
> +        - ldo-supply
> +    else:
> +      properties:
> +        vs-p-supply: false
> +        vs-n-supply: false
> +        ldo-supply: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> @@ -169,3 +241,48 @@ examples:
>              refio-supply =3D <&supply_2_5V>;
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,adaq4380-4";
> +            reg =3D <0>;
> +
> +            spi-cpol;
> +            spi-cpha;
> +            spi-max-frequency =3D <80000000>;
> +
> +            interrupts =3D <27 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent =3D <&gpio0>;
> +
> +            vcc-supply =3D <&supply_3_3V>;
> +            vlogic-supply =3D <&supply_3_3V>;
> +            refin-supply =3D <&supply_5V>;
> +            vs-p-supply =3D <&supply_5V>;
> +            vs-n-supply =3D <&supply_0V>;
> +            ldo-supply =3D <&supply_5V>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                adi,gain-milli =3D <300>;
> +            };
> +
> +            channel@2 {
> +                reg =3D <2>;
> +                adi,gain-milli =3D <600>;
> +            };
> +
> +            channel@3 {
> +                reg =3D <3>;
> +                adi,gain-milli =3D <1000>;
> +            };
> +        };
> +    };
>=20


