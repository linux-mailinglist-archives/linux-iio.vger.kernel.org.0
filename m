Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCFB9C507
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2019 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfHYRXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Aug 2019 13:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbfHYRXb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 13:23:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4406320870;
        Sun, 25 Aug 2019 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566753809;
        bh=Gy5VbonUoyBBwkCMGlcJzsai8tLLq8emMnvB8ZP7Tss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G/OHQcmlLQxMn/fv+kWK40ABktENeT89c/onNMBbMOBEetZ8kFsZQSP2QkyQoDcT6
         jfWemS6YbB9Z5tyKBVgJZDsS5TBAo+w1VuqhPLySq+UuTdfQnUOXKg9w3zTAkquFT2
         g22uqA28xefuXjOBhiCkA4j0uVrsjtMIAWENlZ/s=
Date:   Sun, 25 Aug 2019 18:23:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: adc: Migrate AD7606
 documentation to yaml
Message-ID: <20190825182323.21d6ef76@archlinux>
In-Reply-To: <20190821141656.4815-3-beniamin.bia@analog.com>
References: <20190821141656.4815-1-beniamin.bia@analog.com>
        <20190821141656.4815-3-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 17:16:55 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> The documentation for ad7606 was migrated to yaml.
>=20
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/i=
io/adc/adi,ad7606.yaml

3 things needed fixing beyond the tweak Rob mentioned (also done).

2 missing headers + one required property isn't present in the example.

I'll be grumpy next time...  Particularly as the warnings don't exactly
point clearly to what is wrong for missing headers.

Applied with those changes to the togreg branch of iio.git and pushed out
as testing.

Thanks,

Jonathan

> ---
> Changes in v3:
> -nothing changed
>=20
>  .../bindings/iio/adc/adi,ad7606.txt           |  66 ---------
>  .../bindings/iio/adc/adi,ad7606.yaml          | 134 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 135 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.=
txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.=
yaml
>=20
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
> -	* "adi,ad7605-4"
> -	* "adi,ad7606-8"
> -	* "adi,ad7606-6"
> -	* "adi,ad7606-4"
> -	* "adi,ad7616"
> -- reg: SPI chip select number for the device
> -- spi-max-frequency: Max SPI frequency to use
> -	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> -- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
> -- avcc-supply: phandle to the Avcc power supply
> -- interrupts: IRQ line for the ADC
> -	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.=
txt
> -- adi,conversion-start-gpios: must be the device tree identifier of the =
CONVST pin.
> -		  This logic input is used to initiate conversions on the analog
> -		  input channels. As the line is active high, it should be marked
> -		  GPIO_ACTIVE_HIGH.
> -
> -Optional properties:
> -
> -- reset-gpios: must be the device tree identifier of the RESET pin. If s=
pecified,
> -	       it will be asserted during driver probe. As the line is active h=
igh,
> -	       it should be marked GPIO_ACTIVE_HIGH.
> -- standby-gpios: must be the device tree identifier of the STBY pin. Thi=
s pin is used
> -		to place the AD7606 into one of two power-down modes, Standby mode or
> -		Shutdown mode. As the line is active low, it should be marked
> -		GPIO_ACTIVE_LOW.
> -- adi,first-data-gpios: must be the device tree identifier of the FRSTDA=
TA pin.
> -		    The FRSTDATA output indicates when the first channel, V1, is
> -		    being read back on either the parallel, byte or serial interface.
> -		    As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
> -- adi,range-gpios: must be the device tree identifier of the RANGE pin. =
The polarity on
> -	      this pin determines the input range of the analog input channels.=
 If
> -	      this pin is tied to a logic high, the analog input range is =C2=
=B110V for
> -	      all channels. If this pin is tied to a logic low, the analog inpu=
t range
> -	      is =C2=B15V for all channels. As the line is active high, it shou=
ld be marked
> -	      GPIO_ACTIVE_HIGH.
> -- adi,oversampling-ratio-gpios: must be the device tree identifier of th=
e over-sampling
> -				mode pins. As the line is active high, it should be marked
> -				GPIO_ACTIVE_HIGH.
> -
> -Example:
> -
> -	adc@0 {
> -		compatible =3D "adi,ad7606-8";
> -		reg =3D <0>;
> -		spi-max-frequency =3D <1000000>;
> -		spi-cpol;
> -
> -		avcc-supply =3D <&adc_vref>;
> -
> -		interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> -		interrupt-parent =3D <&gpio>;
> -
> -		adi,conversion-start-gpios =3D <&gpio 17 GPIO_ACTIVE_HIGH>;
> -		reset-gpios =3D <&gpio 27 GPIO_ACTIVE_HIGH>;
> -		adi,first-data-gpios =3D <&gpio 22 GPIO_ACTIVE_HIGH>;
> -		adi,oversampling-ratio-gpios =3D <&gpio 18 GPIO_ACTIVE_HIGH
> -						&gpio 23 GPIO_ACTIVE_HIGH
> -						&gpio 26 GPIO_ACTIVE_HIGH>;
> -		standby-gpios =3D <&gpio 24 GPIO_ACTIVE_LOW>;
> -	};
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
> +                                                &gpio 23 GPIO_ACTIVE_HIGH
> +                                                &gpio 26 GPIO_ACTIVE_HIG=
H>;
> +                standby-gpios =3D <&gpio 24 GPIO_ACTIVE_LOW>;
> +                adi,sw-mode;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 052d7a8591fb..d2e465772071 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -900,7 +900,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7606.c
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> =20
>  ANALOG DEVICES INC AD7768-1 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>

