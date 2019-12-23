Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0181297A3
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 15:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLWOos (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 09:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfLWOos (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 09:44:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DD2206B7;
        Mon, 23 Dec 2019 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577112287;
        bh=E08yqOhu7Xd1YyiLHcsgDcU023NeuxfnDULWj5IV3cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k7mwKgQuYZocNv7Oz3H1+ESmiu85b7GDXaqQG8E/U/v7Vh5p6Uy5YCtuTSyFHsI9E
         KVikn16eWyO1ozLcppfTz9ezb2M651o0H6MqloR3zt5gJ/+yjUUl1rLM6ezKeIeQgj
         qyBE7bUnLa/bYPtjeB0p9Q0WKokWCyiKn640wZGo=
Date:   Mon, 23 Dec 2019 14:44:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-binding: iio: dac8771: Add TI DAC8771 binding
Message-ID: <20191223144442.3171e641@archlinux>
In-Reply-To: <20191217140731.30504-2-dmurphy@ti.com>
References: <20191217140731.30504-1-dmurphy@ti.com>
        <20191217140731.30504-2-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 08:07:30 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Add the TI DAC8771 DT binding.
>=20
> Datasheet:
> http://www.ti.com/lit/ds/symlink/dac8771.pdf
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Rob Herring <robh+dt@kernel.org>
> ---
>  .../bindings/iio/dac/ti,dac8771.yaml          | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac8771.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml b/=
Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml
> new file mode 100644
> index 000000000000..6aba6789d36c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0
If possible, it is preferred for new bindings to be dual licensed as=20

(GPL-2.0-only OR BSD-2-Clause)


> +# Copyright (C) 2019 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/bindings/iio/dac/ti,dac8771.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Texas Instruments DAC8771
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  The DAC8771 is a single channel, precision, fully integrated 16-bit di=
gital
> +  to analog converter (DAC) with adaptive power management, and is desig=
ned to
> +  meet the requirements of industrial control applications.
> +
> +  Specifications can be found at:
> +    http://www.ti.com/lit/ds/symlink/dac8771.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dac8771
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: |
> +       GPIO used for hardware reset.
> +
> +  loaddacs-gpios:
> +    description: |
> +       GPIO used to shift the data from the SPI FIFO to the processing e=
ngine.
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +
> +  vref-supply:
> +    description: Phandle to the external reference voltage supply.
> +
> +  ti,output-range:
> +    description: Output range of the DAC
> +       0 - Voltage output 0 to +5 V (default)
Hmm. I'm never keen on opaque bindings, but sometimes things
are just too complex to break out as individual fields.

So I guess this is the best we can do.

> +       1 - Voltage output 0 to +10 V
> +       2 - Voltage output =C2=B15 V
> +       3 - Voltage output =C2=B110 V
> +       4 - Current output 3.5 mA to 23.5 mA
> +       5 - Current output 0 to 20 mA
> +       6 - Current output 0 to 24 mA
> +       7 - Current output =C2=B124 mA
> +       8 - Voltage output 0 to +6 V
> +       9 - Voltage output 0 to +12 V
> +       10 - Voltage output =C2=B16 V
> +       11 - Voltage output =C2=B112 V
> +       12 - Current output 4 mA to 20 mA
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +      - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
> +
> +  interrupts:
> +    description: IRQ line for the DAC
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> + =20
> +      dac@0 {
> +        compatible =3D "ti,dac8771";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <25000000>;
> +        vref-supply =3D <&ldo3_reg>;
> +        ti,output-range =3D <2>;
> +        interrupts =3D <16>;
> +        interrupt-parent =3D <&gpio1>;
> +        loaddacs-gpios =3D <&gpio1 17 GPIO_ACTIVE_LOW>;
> +        reset-gpios =3D <&gpio1 27 GPIO_ACTIVE_LOW>;
> +      };
> +    };

