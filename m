Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109C5381DC8
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhEPJ5a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 16 May 2021 05:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhEPJ53 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 05:57:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100E160698;
        Sun, 16 May 2021 09:56:08 +0000 (UTC)
Date:   Sun, 16 May 2021 10:57:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jozsef Horvath <info@ministro.hu>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Gene Chen <gene_chen@richtek.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: devicetree bindings for
 texas instruments ads7142
Message-ID: <20210516105720.2b9cf46a@jic23-huawei>
In-Reply-To: <a8200f9ce6a4b3fdf5a9b1e61bbc7c4ced8361b6.1621105931.git.info@ministro.hu>
References: <9f9c64ca70f80d8a024ea66e3963350e35f27c1d.1621105931.git.info@ministro.hu>
        <a8200f9ce6a4b3fdf5a9b1e61bbc7c4ced8361b6.1621105931.git.info@ministro.hu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 07:31:05 +0000
Jozsef Horvath <info@ministro.hu> wrote:

> This is a device tree schema for iio driver for
>  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
> 
> Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> 
> Signed-off-by: Jozsef Horvath <info@ministro.hu>

Hi József,

A few comments inline.

thanks,

Jonathan
> ---
> 
> changes v1
>   - Redundant parameters (ti,threshold-rising, etc.)
>     are removed
>   - Supply name changed(vref -> avdd)
>   - Added dvdd supply
>   - All the properties are removed with prefix "ti,"
> changes v2
>   - "ti,prealert-count" parameter added, just for completeness.
> ---
>  .../bindings/iio/adc/ti,ads7142.yaml          | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> new file mode 100644
> index 000000000000..6e52079c68f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/adc/ti,ads7142.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Texas Instruments ADS7142 adc driver device tree bindings

ADC

> +
> +maintainers:
> +  - József Horváth <info@ministro.hu>
> +
> +description: |
> +  This document is for describing the required device tree parameters
> +   for ads7142 adc

ADC

> +  The required parameters for proper operation are described below.
> +
> +  Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> +
> +properties:
> +  compatible:
> +    const: ti,ads7142
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      The BUSY/PDY pin is used as interrupt line

RDY ?

> +       in autonomous monitoring mode.
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: Regulator for the reference voltage
> +
> +  dvdd-supply: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  ti,prealert-count:
> +    description: |
> +      Sets the Pre-Alert Event Count for both,
> +       high and low comparators, for both the channels.

Interesting.  Why is this a device tree property rather than something
we want to configure from userspace?  Looks like it would map to _period
after scaling by the sampling frequency.

https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-iio#L1003


> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 15
> +    minimum: 0
> +
> +patternProperties:
> +  "^channel@[0-1]$":
> +    $ref: "adc.yaml"
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +    properties:
> +      reg:
> +        description: |
> +          The channel number.
> +        items:
> +          minimum: 0
> +          maximum: 1

enum: [0 1]
is a more compact way of putting this IIRC.
 
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      adc@1f {
> +        compatible = "ti,ads7142";
> +        reg = <0x1f>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        #io-channel-cells = <1>;
> +
> +        avdd-supply = <&vdd_3v3_reg>;
> +        dvdd-supply = <&vdd_1v8_reg>;
> +
> +        interrupt-parent = <&gpio>;
> +        interrupts = <7 2>;
> +
> +        ti,prealert-count = <4>;
> +
> +        channel@0 {
> +          reg = <0>;
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +        };
> +      };
> +    };
> +...
> +

