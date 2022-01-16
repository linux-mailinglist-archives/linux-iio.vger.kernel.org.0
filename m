Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E8A48FC6F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 12:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiAPLzo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 06:55:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46280 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiAPLzo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 06:55:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F5D60E06;
        Sun, 16 Jan 2022 11:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D12C36AE7;
        Sun, 16 Jan 2022 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642334142;
        bh=U3Y+dsKg2q+s7hrlGzf0zcBf9wHVqvdjVQQOcvU0nK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E1jcVanLjZrag4g2SxOQQ9IUEklVHspoJu2rGckNPNxThcDsd4XPtfUFKK4FhUPJi
         UWxC6jusIFx1t9YJDEnI4M/EzwowKkNQohFlWgfHrKQ/WqAosUu0xKkon64h+oGSBA
         KnTuTUIUK+A+pnmlhAwgZBtow+FydOXySIedVMm4cNjz3SAY/7CZw5E9PrNaa8IArc
         OGV3ZuPieBBfMFzwKPMQc8ICZMIq2Bb9lYcY6INUg+UZh6imakNr1qdZEXR55aSD9N
         b1juI4zqqDxffARQVIXkz0p1Ywk4OEszFkNByx2UZ4jR/LgqBcI+d1rDKe/GWiF9r8
         BSoPJI3EdHzbA==
Date:   Sun, 16 Jan 2022 12:01:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: Add ltc2688 documentation
Message-ID: <20220116120143.18e3e0f0@jic23-huawei>
In-Reply-To: <20220115092705.491-4-nuno.sa@analog.com>
References: <20220115092705.491-1-nuno.sa@analog.com>
        <20220115092705.491-4-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 Jan 2022 10:27:05 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Document the LTC2688 devicetree properties.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Hi Nuno,

A few minor comments inline.  I've reviewed this first so might
find answers to some of them when reading the driver code.

Thanks,

Jonathan

> ---
>  .../bindings/iio/dac/adi,ltc2688.yaml         | 147 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688=
.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> new file mode 100644
> index 000000000000..ecd0943fb813
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2688.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2688 DAC
> +
> +maintainers:
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> +
> +description: |
> +  Analog Devices LTC2688 16 channel, 16 bit, +-15V DAC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/lt=
c2688.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2688
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Analog Supply Voltage Input.
> +
> +  iovcc-supply:
> +    description: Digital Input/Output Supply Voltage.
> +
> +  vref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-s=
cale
> +      range of all channels. By default, the internal reference is route=
d to
> +      this pin.

Perhaps "If not provided the internal reference is used and also provided o=
n the
VREF pin".

> +
> +  clr-gpios:
> +    description:
> +      If specified, it will be asserted during driver probe. As the line=
 is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: The channel number representing the DAC output chan=
nel.
> +        maximum: 15
> +
> +      adi,toggle-mode:
> +        description:
> +          Set the channel as a toggle enabled channel. Toggle operation =
enables
> +          fast switching of a DAC output between two different DAC codes=
 without
> +          any SPI transaction. It will result in a different ABI for the
> +          channel.

The ABI bit is a linux specific part so shouldn't be in the binding.  Just =
leave
it unsaid.

> +        type: boolean
> +
> +      adi,output-range-microvolt:
> +        description: Specify the channel output full scale range.
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - enum: [5000000, 10000000]
> +          - items:
> +              - const: -5000000
> +              - const: 5000000
> +          - items:
> +              - const: -10000000
> +              - const: 10000000
> +          - items:
> +              - const: -15000000
> +              - const: 15000000

Not necessarily a thing to do now, but this is common enough we should
make it a standard DAC channel property.

> +
> +      adi,overrange:
> +        description: Enable 5% overrange over the selected full scale ra=
nge.
> +        type: boolean
> +
> +      clocks:
> +        maxItems: 1
> +
> +      adi,toggle-dither-input:
> +        description:
> +          Selects the TGPx pin to be associated with this channel. This =
setting
> +          only makes sense for toggle or dither enabled channels. If
> +          @adi,toggle-mode is not set and this property is given, the ch=
annel is
> +          assumed to be a dither capable channel. Note that multiple cha=
nnels
> +          can be mapped to the same pin. If this setting is given, the
> +          respective @clock must also be provided. Mappings between this=
 and
> +          clocks

That's not clear, mapping between this an input pin is probably more accura=
te?

> +            0 - TGP1
> +            1 - TGP2
> +            2 - TGP3
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +
> +    dependencies:
> +      adi,toggle-dither-input: [ clocks ]
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    spi {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +          ltc2688: ltc2688@0 {
> +                  compatible =3D "adi,ltc2688";
> +                  reg =3D <0>;
> +
> +                  vcc-supply =3D <&vcc>;
> +                  iovcc-supply =3D <&vcc>;
> +                  vref-supply =3D <&vref>;
> +
> +                  #address-cells =3D <1>;
> +                  #size-cells =3D <0>;
> +                  channel@0 {
> +                          reg =3D <0>;
> +                          adi,toggle-mode;

Can do this without adi,toggle-dither-input?

> +                          adi,overrange;
> +                  };
> +
> +                  channel@1 {
> +                          reg =3D <1>;
> +                          adi,output-range-microvolt =3D <0 10000000>;
> +
> +                          clocks =3D <&clock_tgp3>;
> +                          adi,toggle-dither-input =3D <2>;
> +                  };
> +          };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 16a7fd7f98ee..137d4ed992cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11188,6 +11188,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
>  F:	drivers/iio/dac/ltc2688.c
> =20
>  LTC2947 HARDWARE MONITOR DRIVER

