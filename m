Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1161784A8
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbgCCVLA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 16:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732393AbgCCVK4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Mar 2020 16:10:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016A120848;
        Tue,  3 Mar 2020 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583269855;
        bh=9dEoSv6yhh8eJqi6eAzmQv1Qv1OJbIQTQcJqOl9NTSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KVIb0g+Ahx/1VYlGJAxPd5CEkpyzquEQtzufQEAaJxDeduvzknsXvzBpqSFcPWAwX
         +l4Eox4toEbgMQlt3Dy/JBBgiG6lB58k0nHc5FfZG2q+usUKI+sGH2zM2sq7sVVRdI
         j/GZ0Kwc1Bi2Ytwg6pK5n+QUK/QWjpnOO2HpMWno=
Date:   Tue, 3 Mar 2020 21:10:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Message-ID: <20200303211045.31f977bb@archlinux>
In-Reply-To: <20200225124152.270914-6-nuno.sa@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
        <20200225124152.270914-6-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 13:41:52 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Document the ADIS16475 device devicetree bindings.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

One thing inline on the burst mode stuff.

Thanks,

Jonathan

> ---
>  .../bindings/iio/imu/adi,adis16475.yaml       | 130 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis164=
75.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> new file mode 100644
> index 000000000000..c0f2146e000c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16475.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16475 and similar IMUs
> +
> +maintainers:
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> +
> +description: |
> +  Analog Devices ADIS16475 and similar IMUs
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
IS16475.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16475-1
> +      - adi,adis16475-2
> +      - adi,adis16475-3
> +      - adi,adis16477-1
> +      - adi,adis16477-2
> +      - adi,adis16477-3
> +      - adi,adis16470
> +      - adi,adis16465-1
> +      - adi,adis16465-2
> +      - adi,adis16465-3
> +      - adi,adis16467-1
> +      - adi,adis16467-2
> +      - adi,adis16467-3
> +      - adi,adis16500
> +      - adi,adis16505-1
> +      - adi,adis16505-2
> +      - adi,adis16505-3
> +      - adi,adis16507-1
> +      - adi,adis16507-2
> +      - adi,adis16507-3
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    oneOf:
> +      - const: sync
> +      - const: direct-sync
> +      - const: pulse-sync
> +      - const: scaled-sync
> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,
> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  adi,scaled-output-hz:
> +    description:
> +      This property must be present if the clock mode is scaled-sync thr=
ough
> +      clock-names property. In this mode, the input clock can have a ran=
ge
> +      of 1Hz to 128HZ which must be scaled to originate an allowable sam=
ple
> +      rate. This property specifies that rate.
> +    minimum: 1900
> +    maximum: 2100
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - adi,adis16500
> +          - adi,adis16505-1
> +          - adi,adis16505-2
> +          - adi,adis16505-3
> +          - adi,adis16507-1
> +          - adi,adis16507-2
> +          - adi,adis16507-3
> +
> +then:
> +  properties:
> +    clock-names:
> +      oneOf:
> +        - const: sync
> +        - const: direct-sync
> +        - const: scaled-sync
> +
> +    adi,burst32-enable:
> +      description:
> +        Enable burst32 mode. In this mode, a burst reading contains cali=
brated
> +        gyroscope and accelerometer data in 32-bit format.

Why is this in DT?  Is it not a runtime decision
(ideally automatically selected)

> +      type: boolean
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            adis16475: adis16475-3@0 {
> +                    compatible =3D "adi,adis16475-3";
> +                    reg =3D <0>;
> +                    spi-cpha;
> +                    spi-cpol;
> +                    spi-max-frequency =3D <2000000>;
> +                    interrupts =3D <4 IRQ_TYPE_EDGE_RISING>;
> +                    interrupt-parent =3D <&gpio>;
> +            };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f11262f1f3bb..f8ccc92ab378 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1015,6 +1015,7 @@ W:	http://ez.analog.com/community/linux-device-driv=
ers
>  S:	Supported
>  F:	drivers/iio/imu/adis16475.c
>  F:	Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> =20
>  ANALOG DEVICES INC ADM1177 DRIVER
>  M:	Beniamin Bia <beniamin.bia@analog.com>

