Return-Path: <linux-iio+bounces-6299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D6A90985A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 14:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F701C212A5
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D83C684;
	Sat, 15 Jun 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYHgRhxn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866D10A11;
	Sat, 15 Jun 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718455276; cv=none; b=Ji8J4MZWikiOUoM6eM8CungVMa5NOE630ehUFJ5R7DO5KBGqwbGV1a7aeg+GOvYf4UX79OA9Unc+hsQQBhCAUf3C5WKQkGexLXbjsf8qp3ynwUcmtIYNVqFfm+aNQzaRgRw08QXpquKQuy0jPzy6+O2LdgCqMRvPdycNPjpr8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718455276; c=relaxed/simple;
	bh=ytTZO/5oUgCiBXsiJTJMB65kjRXhDWV2N1/kQ8qgIwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQTRkjjazIcSPqsGcRm5O9Wp86mbIYV/2g18f0Nn5M2HsIWREKGqrr9mYme42iIbcb29NcMIWmUgWyvxcbdmFTiCng7HA0twIXW/UQLMndn5WE6goYLFrbYU4lsIv0SpJ2XpNh9vrn00VnYwp3ADnqwUhWuzWtnLoM0LIAQ/nh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYHgRhxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F57DC116B1;
	Sat, 15 Jun 2024 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718455275;
	bh=ytTZO/5oUgCiBXsiJTJMB65kjRXhDWV2N1/kQ8qgIwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BYHgRhxnRgajieLPyUgZhNScTlYciCDoRzeXcBcNUuHsEvnBDYiY621tnsmRU29iC
	 eZCjcKI7VklED2SnlMoUqwuLpy0ydSGxww6SWy03jRfn1Yk4v1uCMXJFonQLibaZXb
	 wSYIFZ4COXsg2C4+Ud84lyx+Tw4anIfaY12l2ES5moHIA60k+ujl4t2yNpdSycmocp
	 7C1z4DwSKmyrh38n+NupLKsq+PWzMWykpOaTS6gR6cDroK/jNylkbfD8+EfIbnfSa0
	 B761yhhbKpZUAdgK2JQRsw4qXygC5/vN/qXEmuqTsiS+f7pvYPw0nn/RJuJzXUX2U2
	 wMBxwXqolJRSg==
Date: Sat, 15 Jun 2024 13:41:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
Message-ID: <20240615134106.40e55e16@jic23-huawei>
In-Reply-To: <20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
	<20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 14:20:40 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add device tree bindings for AD4695 and similar ADCs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 297 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   9 +
>  2 files changed, 306 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> new file mode 100644
> index 000000000000..8ff5bbbbef9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> @@ -0,0 +1,297 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4695.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices Easy Drive Multiplexed SAR Analog to Digital Conve=
rters
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> +
> +description: |
> +  A family of similar multi-channel analog to digital converters with SP=
I bus.
> +
> +  * https://www.analog.com/en/products/ad4695.html
> +  * https://www.analog.com/en/products/ad4696.html
> +  * https://www.analog.com/en/products/ad4697.html
> +  * https://www.analog.com/en/products/ad4698.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - adi,ad4695
> +          - adi,ad4697
> +      # same chips in WLCSP package with more pins
> +      - items:
> +          - const: adi,ad4695-wlcsp
> +          - const: adi,ad4695
> +      - items:
> +          - const: adi,ad4697-wlcsp
> +          - const: adi,ad4697
> +      # same chips with higher max sample rate
> +      - items:
> +          - const: adi,ad4696
> +          - const: adi,ad4695
> +      - items:
> +          - const: adi,ad4698
> +          - const: adi,ad4697
> +      # same chips with higher max sample rate in WLCSP package
> +      - items:
> +          - const: adi,ad4696-wlcsp
> +          - const: adi,ad4696
> +          - const: adi,ad4695-wlcsp
> +          - const: adi,ad4695
> +      - items:
> +          - const: adi,ad4698-wlcsp
> +          - const: adi,ad4698
> +          - const: adi,ad4697-wlcsp
> +          - const: adi,ad4697
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 80000000
> +
> +  spi-cpol: true
> +  spi-cpha: true
> +
> +  spi-rx-bus-width:
> +    minimum: 1
> +    maximum: 4
> +
> +  avdd-supply:
> +    description: A 2.7 V to 5.5 V supply that powers the analog circuitr=
y.

I'm a cynic.  Do we care about the supported voltages in this binding doc?
Feels just somewhere we might make a mistake.

> +
> +  ldo-in-supply:
> +    description: A 2.4 V to 5.5 V supply connected to the internal LDO i=
nput.
> +
> +  vdd-supply:
> +    description: A 1.8V supply that powers the core circuitry.
> +
> +  vio-supply:
> +    description: A 1.2V to 1.8V supply for the digital inputs and output=
s.
> +
> +  ref-supply:
> +    description: A 2.4 V to 5.1 V supply for the external reference volt=
age.
> +
> +  refin-supply:
> +    description: A 2.4 V to 5.1 V supply for the internal reference buff=
er input.
> +
> +  com-supply:
> +    description: Common voltage supply for pseudo-differential analog in=
puts.

These last few have more info in them so definitely good to have the descri=
ptions

> +
> +  adi,no-ref-current-limit:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      When this flag is present, the REF Overvoltage Reduced Current pro=
tection
> +      is disabled.
> +
> +  adi,no-ref-high-z:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable this flag if the ref-supply requires Reference Input High-Z=
 Mode
> +      to be disabled for proper operation.
> +
> +  cnv-gpios:
> +    description: The Convert Input (CNV). If omitted, CNV is tied to SPI=
 CS.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: The Reset Input (RESET). Should be configured GPIO_ACTI=
VE_LOW.
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description:
> +          Signal coming from the BSY_ALT_GP0 or GP3 pin that indicates a=
 busy
> +          condition.
> +      - description:
> +          Signal coming from the BSY_ALT_GP0 or GP2 pin that indicates a=
n alert
> +          condition.
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: busy
> +      - const: alert
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: |
> +      The first cell is the GPn number: 0 to 3.
> +      The second cell takes standard GPIO flags.
> +
> +  "#address-cells":
> +    const: 1
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +    description:
> +      Describes each individual channel. In addition the properties defi=
ned
> +      below, bipolar from adc.yaml is also supported.
> +
> +    properties:
> +      reg:
> +        maximum: 15
> +        description: Input pin number (INx).

I'd drop this description as the pin pairing makes it messy.
If you switch to diff-channels etc, just leave it as a index value not
connected to the pin numbers.

> +
> +      adi,pin-pairing:
> +        description: |
> +          The input pin pairing for the negative input. This can be:
> +          - REFGND, normally 0V (single-ended)
> +          - COM, normally V_REF/2, see com-supply (pseudo-differential)
> +          - For even numbered pins, the next odd numbered pin (different=
ial)
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum: [refgnd, com, next]

Next is full on differential, just provide both channels via
diff-channels. You can constrain the particular combinations in the binding.

Refcnd is normal single ended.  Probably want to use the new single-channel
property for that as we are mixing differential and single ended channels
so reg is pretty much just an index.

Hmm. For comm we haven't had done a recent binding for a chip with the opti=
on
of pseudo differential that is per channel, they've been whole device only.
That feels like it will be common enough we need to support it cleanly
with a 'general' scheme.

Problem is I know someone will have a chip with 2 vincom pins and selecting
between them, so we can't just have pseudo-differential as a boolean and ad=
c.yaml

There are horrible solutions like a magic channel number that changes the
meaning of diff-channels but that's ugly.
Maybe pseudo-differential for now and we have to later we add
pseudo-differential-comm  =3D <0> etc?


> +        default: refgnd
> +
> +      adi,no-high-z:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: |

Do we need the | given not really formatted?

> +          Enable this flag if the input pin requires the Analog Input Hi=
gh-Z
> +          Mode to be disabled for proper operation.
> +
> +    required:
> +      - reg
> +
> +    allOf:
> +      # only even number pins can be paired with the next pin
> +      - if:
> +          properties:
> +            reg:
> +              not:
> +                multipleOf: 2
> +        then:
> +          properties:
> +            adi,pin-pairing:
> +              enum: [refgnd, com]
> +      # bipolar mode is not supported with REFGND pairing
> +      - if:
> +          not:
> +            required:
> +              - adi,pin-pairing
> +        then:
> +          properties:
> +            bipolar: false
> +        else:
> +          if:
> +            properties:
> +              adi,pin-pairing:
> +                const: refgnd
> +          then:
> +            properties:
> +              bipolar: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - vio-supply
> +
> +allOf:
> +  - oneOf:
> +      - required:
> +          - ref-supply
> +      - required:
> +          - refin-supply
> +
> +  - oneOf:
> +      - required:
> +          - ldo-in-supply
> +      - required:
> +          - vdd-supply
> +
> +  # LFSCP package has fewer pins, so a few things are not valid in that =
case
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              pattern: -wlcsp$
> +    then:
> +      properties:
> +        refin-supply: false
> +        spi-rx-bus-width:
> +          maximum: 2
> +
> +  # the internal reference buffer always requires high-z mode
> +  - if:
> +      required:
> +        - refin-supply
> +    then:
> +      properties:
> +        adi,no-ref-high-z: false
> +
> +  # limit channels for 8-channel chips
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad4697
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          properties:
> +            reg:
> +              maximum: 7
> +        "^channel@[8-9a-f]$": false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad4695";
> +            reg =3D <0>;
> +            spi-cpol;
> +            spi-cpha;
> +            spi-max-frequency =3D <80000000>;
> +            avdd-supply =3D <&supply_2_5V>;
> +            vdd-supply =3D <&supply_1_8V>;
> +            vio-supply =3D <&supply_1_2V>;
> +            ref-supply =3D <&supply_5V>;
> +            reset-gpios =3D <&gpio 1 GPIO_ACTIVE_LOW>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            /* Differential channel between IN0 and IN1. */
> +            channel@0 {
> +                reg =3D <0>;
> +                adi,pin-pairing =3D "next";
> +                bipolar;
> +            };
> +
> +            /* Single-ended channel between IN2 and REFGND. */
> +            channel@2 {
> +                reg =3D <2>;
> +            };
> +
> +            /* Pseudo-differential channel between IN3 and COM. */
> +            channel@f {
> +                reg =3D <3>;
> +                adi,pin-pairing =3D "com";
> +                bipolar;
> +            };
> +        };
> +    };


