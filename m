Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A442D22ABBC
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgGWJ1S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 05:27:18 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:32853 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgGWJ1S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 05:27:18 -0400
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5364E240004;
        Thu, 23 Jul 2020 09:27:13 +0000 (UTC)
Date:   Thu, 23 Jul 2020 11:30:51 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: maxim,max9611 yaml conversions
Message-ID: <20200723093051.kq7nc72s6532zoct@uno.localdomain>
References: <20200722171224.989138-1-jic23@kernel.org>
 <20200722171224.989138-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200722171224.989138-4-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 06:12:24PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Straight forward conversion of this binding for this
> current sense amplifier and ADC.
>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../devicetree/bindings/iio/adc/max9611.txt   | 27 ----------
>  .../bindings/iio/adc/maxim,max9611.yaml       | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/max9611.txt b/Documentation/devicetree/bindings/iio/adc/max9611.txt
> deleted file mode 100644
> index ab4f43145ae5..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/max9611.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
> -
> -Maxim max9611/max9612 is an high-side current sense amplifier with integrated
> -12-bits ADC communicating over I2c bus.
> -The device node for this driver shall be a child of a I2c controller.
> -
> -Required properties
> -  - compatible: Should be "maxim,max9611" or "maxim,max9612"
> -  - reg: The 7-bits long I2c address of the device
> -  - shunt-resistor-micro-ohms: Value, in micro Ohms, of the current sense shunt
> -			        resistor
> -
> -Example:
> -
> -&i2c4 {
> -	csa: adc@7c {
> -		compatible = "maxim,max9611";
> -		reg = <0x7c>;
> -
> -		shunt-resistor-micro-ohms = <5000>;
> -	};
> -};
> -
> -This device node describes a current sense amplifier sitting on I2c4 bus
> -with address 0x7c (read address is 0xf9, write address is 0xf8).
> -A sense resistor of 0,005 Ohm is installed between RS+ and RS- current-sensing
> -inputs.
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml
> new file mode 100644
> index 000000000000..a9fc05e6b62c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max9611.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX9611 and similar current sense amplifiers with integrated ADCs
> +
> +maintainers:
> +  - Jacopo Mondi <jacopo@jmondi.org>
> +
> +description: |
> +   These devices combine a high-side current sense amplifier with a 12 bit ADC.
> +   They have an i2c interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max9611
> +      - maxim,max9612
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Value in micro Ohms of the shunt resistor connected between the RS+ and
> +      RS- inputs, across which the current is measured.  Value needed to compute
                                                          ^ Double space
> +      the scaling of the measured current.
> +

With additionalProperties added
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j
> +required:
> +  - compatible
> +  - reg
> +  - shunt-resistor-micro-ohms
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@7c {
> +            compatible = "maxim,max9611";
> +            reg = <0x7c>;
> +            shunt-resistor-micro-ohms = <5000>;
> +        };
> +    };
> +...
> --
> 2.27.0
>
