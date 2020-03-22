Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42E18EB7C
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 19:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgCVSXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 14:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVSXX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 14:23:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEE620719;
        Sun, 22 Mar 2020 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584901402;
        bh=5kXlQUFhN/OsSbu6PFT1ivfOoWp7NepQJnoeulgEEac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hkb+yF6iLCOKhAJjZmv+4HYex2N/RGNlMz8pgfqQwU8v5Uw72G5wK/PIDFHgA5Sta
         FvmZgaMyhoY5cxVx2D8jJ/zPmMtaiYxn21t8vnEk7CxwtTTXsyuxfH6t/41JlvFfrZ
         LxjKCdDUpW7xnLnpXuj9CEbsPLds1MNMDOTdDcB8=
Date:   Sun, 22 Mar 2020 18:23:18 +0000
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
Subject: Re: [PATCH v2 6/6] dt-bindings: iio: Add adis16475 documentation
Message-ID: <20200322182318.5029a402@archlinux>
In-Reply-To: <20200316125312.39178-7-nuno.sa@analog.com>
References: <20200316125312.39178-1-nuno.sa@analog.com>
        <20200316125312.39178-7-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 13:53:12 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Document the ADIS16475 device devicetree bindings.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Hmm. A bit fiddly so definitely want a review from Rob.

Thanks,

Jonathan
> ---
> Changes in v2:
>  * Remove burst32 property;
>  * Rename clk-mode to adi,sync-mode;
>  * Remove clock-names;
>  * Add conditionals to state that clocks is only needed depending on adi,=
sync-mode property
>=20
>  .../bindings/iio/imu/adi,adis16475.yaml       | 146 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis164=
75.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> new file mode 100644
> index 000000000000..9eeb42773edd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> @@ -0,0 +1,146 @@
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
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,
> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  adi,sync-mode:
> +    description:
> +      Configures the device SYNC pin. The following modes are supported
> +      0 - output_sync
> +      1 - direct_sync
> +      2 - scaled_sync
> +      3 - pulse_sync
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
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
> +    adi,sync-mode:
> +      minimum: 0
> +      maximum: 2
> +
> +  if:
> +    properties:
> +      adi,sync-mode:
> +        enum: [1, 2]
> +
> +  then:
> +    dependencies:
> +      adi,sync-mode: [ clocks ]
> +
> +else:
> +  if:
> +    properties:
> +      adi,sync-mode:
> +        enum: [1, 2, 3]
> +
> +  then:
> +    dependencies:
> +      adi,sync-mode: [ clocks ]
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            adis16475: adis16475-3@0 {

Generic name for nodes.  imu I guess here.

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

