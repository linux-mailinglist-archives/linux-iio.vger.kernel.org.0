Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6E460029
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 17:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhK0QZr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 11:25:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60416 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhK0QXr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 11:23:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E32AB82A02;
        Sat, 27 Nov 2021 16:20:31 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id ECF8FC53FBF;
        Sat, 27 Nov 2021 16:20:27 +0000 (UTC)
Date:   Sat, 27 Nov 2021 16:25:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings:iio:amplifiers: add ad7293 doc
Message-ID: <20211127162528.3da0b69b@jic23-huawei>
In-Reply-To: <20211122133639.132972-2-antoniu.miclaus@analog.com>
References: <20211122133639.132972-1-antoniu.miclaus@analog.com>
        <20211122133639.132972-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Nov 2021 15:36:39 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the AD7293 Power Amplifier.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

One comment inline but very minor so if Rob + anyone else is
happy with this we can leave that or I can tidy it up whilst applying.

Thanks,

Jonathan

> ---
> changes in v4:
>  - set `avdd-supply: true`
>  - set `maxItems` for reset-gpios
>  .../bindings/iio/dac/adi,ad7293.yaml          | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> new file mode 100644
> index 000000000000..7951ffe8805b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad7293.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AD7293 12-Bit Power Amplifier Current Controller with ADC,
> +       DACs, Temperature and Current Sensors
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Power Amplifier drain current controller containing functionality
> +   for general-purpose monitoring and control of current, voltage,
> +   and temperature, integrated into a single chip solution with an
> +   SPI-compatible interface.
> +
> +   https://www.analog.com/en/products/ad7293.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7293
> +
> +  avdd-supply: true
> +
> +  vdrive-supply:
> +    description:
> +      VDRIVE voltage regulator.
Could do the same with this one as with the avdd.

Telling us something called vdrive-supply is the VDRIVE supply doesn't
add much.  However, doesn't do that much harm either so I'm not that fussed.

Jonathan

> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - vdrive-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      ad7293@0 {
> +        compatible = "adi,ad7293";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        avdd-supply = <&avdd>;
> +        vdrive-supply = <&vdrive>;
> +        reset-gpios = <&gpio 10 0>;
> +      };
> +    };
> +...

