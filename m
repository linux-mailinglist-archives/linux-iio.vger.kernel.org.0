Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962A41397C5
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 18:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMRdF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 12:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgAMRdC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 12:33:02 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90B221739;
        Mon, 13 Jan 2020 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936781;
        bh=rauLnSZ+Spi8k3g+WMjDp6jay7fj+iymnbghI+P3bQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RddXxICLoCdCCO9dgj6wmhurfypiaN9GtaXGzj4dgkEVb5mi9HS76+FF242UgrREJ
         aLsams4gnFVdOClooLd+tB/2tfyqOboYsU5Ag7S1sol/KbgVm6WHuvb0cb49DtGxLp
         PGGTx78ZhER9KB9FKWnzW9T971iaq/6Ia4ecaMEg=
Received: by mail-qv1-f47.google.com with SMTP id m14so4364596qvl.3;
        Mon, 13 Jan 2020 09:33:00 -0800 (PST)
X-Gm-Message-State: APjAAAUdvQLrMNPl2zgQu/4UqWbuIfnW4zSKuAc6i7LvRy3hLCUB7eiD
        LmQJpj/c5BIVGSnRy2FW0TpR4c9Ut/oZbJSiDw==
X-Google-Smtp-Source: APXvYqwFeiDJjuedb+BcENgmijC/CtslUg6eGGSdj1HsV8+rVN0gYdrIBEkNEcRJ1aIamgYR+23QW0oWBRUQfNrErFY=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr12157541qvn.79.1578936779904;
 Mon, 13 Jan 2020 09:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20190807133137.11185-1-beniamin.bia@analog.com> <20190807133137.11185-3-beniamin.bia@analog.com>
In-Reply-To: <20190807133137.11185-3-beniamin.bia@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Jan 2020 11:32:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+3YibutT0kLVcLZEieWM7YkHWMhW4Pcb9Gd0AHtEtAVA@mail.gmail.com>
Message-ID: <CAL_Jsq+3YibutT0kLVcLZEieWM7YkHWMhW4Pcb9Gd0AHtEtAVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: Migrate AD7606
 documentation to yaml
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        biabeniamin@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 7, 2019 at 8:32 AM Beniamin Bia <beniamin.bia@analog.com> wrote=
:
>
> The documentation for ad7606 was migrated to yaml.
>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
> Changes in v2:
> -old txt file was deleted
>
>  .../bindings/iio/adc/adi,ad7606.txt           |  66 ---------
>  .../bindings/iio/adc/adi,ad7606.yaml          | 134 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 135 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.=
txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/D=
ocumentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> deleted file mode 100644
> index d8652460198e..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -Analog Devices AD7606 Simultaneous Sampling ADC
> -
> -Required properties for the AD7606:
> -
> -- compatible: Must be one of
> -       * "adi,ad7605-4"
> -       * "adi,ad7606-8"
> -       * "adi,ad7606-6"
> -       * "adi,ad7606-4"
> -       * "adi,ad7616"
> -- reg: SPI chip select number for the device
> -- spi-max-frequency: Max SPI frequency to use
> -       see: Documentation/devicetree/bindings/spi/spi-bus.txt
> -- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
> -- avcc-supply: phandle to the Avcc power supply
> -- interrupts: IRQ line for the ADC
> -       see: Documentation/devicetree/bindings/interrupt-controller/inter=
rupts.txt
> -- adi,conversion-start-gpios: must be the device tree identifier of the =
CONVST pin.
> -                 This logic input is used to initiate conversions on the=
 analog
> -                 input channels. As the line is active high, it should b=
e marked
> -                 GPIO_ACTIVE_HIGH.
> -
> -Optional properties:
> -
> -- reset-gpios: must be the device tree identifier of the RESET pin. If s=
pecified,
> -              it will be asserted during driver probe. As the line is ac=
tive high,
> -              it should be marked GPIO_ACTIVE_HIGH.
> -- standby-gpios: must be the device tree identifier of the STBY pin. Thi=
s pin is used
> -               to place the AD7606 into one of two power-down modes, Sta=
ndby mode or
> -               Shutdown mode. As the line is active low, it should be ma=
rked
> -               GPIO_ACTIVE_LOW.
> -- adi,first-data-gpios: must be the device tree identifier of the FRSTDA=
TA pin.
> -                   The FRSTDATA output indicates when the first channel,=
 V1, is
> -                   being read back on either the parallel, byte or seria=
l interface.
> -                   As the line is active high, it should be marked GPIO_=
ACTIVE_HIGH.
> -- adi,range-gpios: must be the device tree identifier of the RANGE pin. =
The polarity on
> -             this pin determines the input range of the analog input cha=
nnels. If
> -             this pin is tied to a logic high, the analog input range is=
 =C2=B110V for
> -             all channels. If this pin is tied to a logic low, the analo=
g input range
> -             is =C2=B15V for all channels. As the line is active high, i=
t should be marked
> -             GPIO_ACTIVE_HIGH.
> -- adi,oversampling-ratio-gpios: must be the device tree identifier of th=
e over-sampling
> -                               mode pins. As the line is active high, it=
 should be marked
> -                               GPIO_ACTIVE_HIGH.
> -
> -Example:
> -
> -       adc@0 {
> -               compatible =3D "adi,ad7606-8";
> -               reg =3D <0>;
> -               spi-max-frequency =3D <1000000>;
> -               spi-cpol;
> -
> -               avcc-supply =3D <&adc_vref>;
> -
> -               interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> -               interrupt-parent =3D <&gpio>;
> -
> -               adi,conversion-start-gpios =3D <&gpio 17 GPIO_ACTIVE_HIGH=
>;
> -               reset-gpios =3D <&gpio 27 GPIO_ACTIVE_HIGH>;
> -               adi,first-data-gpios =3D <&gpio 22 GPIO_ACTIVE_HIGH>;
> -               adi,oversampling-ratio-gpios =3D <&gpio 18 GPIO_ACTIVE_HI=
GH
> -                                               &gpio 23 GPIO_ACTIVE_HIGH
> -                                               &gpio 26 GPIO_ACTIVE_HIGH=
>;
> -               standby-gpios =3D <&gpio 24 GPIO_ACTIVE_LOW>;
> -       };
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> new file mode 100644
> index 000000000000..509dbe9c84d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7606 Simultaneous Sampling ADC
> +
> +maintainers:
> +  - Beniamin Bia <beniamin.bia@analog.com>
> +  - Stefan Popa <stefan.popa@analog.com>
> +
> +description: |
> +  Analog Devices AD7606 Simultaneous Sampling ADC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7606_7606-6_7606-4.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7616.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7605-4
> +      - adi,ad7606-8
> +      - adi,ad7606-6
> +      - adi,ad7606-4
> +      - adi,ad7616
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  adi,conversion-start-gpios:
> +    description:
> +      Must be the device tree identifier of the CONVST pin.
> +      This logic input is used to initiate conversions on the analog
> +      input channels. As the line is active high, it should be marked
> +      GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,
> +      it will be asserted during driver probe. As the line is active hig=
h,
> +      it should be marked GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  standby-gpios:
> +    description:
> +       Must be the device tree identifier of the STBY pin. This pin is u=
sed
> +       to place the AD7606 into one of two power-down modes, Standby mod=
e or
> +       Shutdown mode. As the line is active low, it should be marked
> +       GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  adi,first-data-gpios:
> +    description:
> +      Must be the device tree identifier of the FRSTDATA pin.
> +      The FRSTDATA output indicates when the first channel, V1, is
> +      being read back on either the parallel, byte or serial interface.
> +      As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  adi,range-gpios:
> +    description:
> +      Must be the device tree identifier of the RANGE pin. The polarity =
on
> +      this pin determines the input range of the analog input channels. =
If
> +      this pin is tied to a logic high, the analog input range is =C2=B1=
10V for
> +      all channels. If this pin is tied to a logic low, the analog input=
 range
> +      is =C2=B15V for all channels. As the line is active high, it shoul=
d be marked
> +      GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  adi,oversampling-ratio-gpios:
> +    description:
> +      Must be the device tree identifier of the over-sampling
> +      mode pins. As the line is active high, it should be marked
> +      GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  adi,sw-mode:
> +    description:
> +      Software mode of operation, so far available only for ad7616.
> +      It is enabled when all three oversampling mode pins are connected =
to
> +      high level. The device is configured by the corresponding register=
s. If the
> +      adi,oversampling-ratio-gpios property is defined, then the driver =
will set the
> +      oversampling gpios to high. Otherwise, it is assumed that the pins=
 are hardwired
> +      to VDD.
> +    maxItems: 1
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - avcc-supply
> +  - interrupts
> +  - adi,conversion-start-gpios
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +                compatible =3D "adi,ad7606-8";
> +                reg =3D <0>;
> +                spi-max-frequency =3D <1000000>;
> +                spi-cpol;
> +
> +                avcc-supply =3D <&adc_vref>;
> +
> +                interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> +                interrupt-parent =3D <&gpio>;
> +
> +                adi,conversion-start-gpios =3D <&gpio 17 GPIO_ACTIVE_HIG=
H>;
> +                reset-gpios =3D <&gpio 27 GPIO_ACTIVE_HIGH>;
> +                adi,first-data-gpios =3D <&gpio 22 GPIO_ACTIVE_HIGH>;
> +                adi,oversampling-ratio-gpios =3D <&gpio 18 GPIO_ACTIVE_H=
IGH
> +                                                &gpio 23 GPIO_ACTIVE_HIG=
H
> +                                                &gpio 26 GPIO_ACTIVE_HIG=
H>;

The schema defines there is only 1 GPIO, but there are 3 here. Please
fix (note this shows up in -next due to dtc update).

Rob
