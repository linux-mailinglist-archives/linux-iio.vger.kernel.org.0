Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1FC22ABBF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgGWJ1o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 05:27:44 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39835 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgGWJ1o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 05:27:44 -0400
X-Originating-IP: 93.34.118.233
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 69F50E0004;
        Thu, 23 Jul 2020 09:27:40 +0000 (UTC)
Date:   Thu, 23 Jul 2020 11:31:18 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: maxim,max11100 yaml conversion
Message-ID: <20200723093118.yxogewmcholhqxm3@uno.localdomain>
References: <20200722171224.989138-1-jic23@kernel.org>
 <20200722171224.989138-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200722171224.989138-2-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Wed, Jul 22, 2020 at 06:12:22PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Straight forward conversion for this SPI ADC.
> Added limits on spi-max-frequency from datasheet (0.1 to 4.8MHz)
>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

> ---
>  .../devicetree/bindings/iio/adc/max11100.txt  | 18 -------
>  .../bindings/iio/adc/maxim,max11100.yaml      | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/max11100.txt b/Documentation/devicetree/bindings/iio/adc/max11100.txt
> deleted file mode 100644
> index b7f7177b8aca..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/max11100.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Maxim max11100 Analog to Digital Converter (ADC)
> -
> -Required properties:
> -  - compatible: Should be "maxim,max11100"
> -  - reg: the adc unit address
> -  - vref-supply: phandle to the regulator that provides reference voltage
> -
> -Optional properties:
> -  - spi-max-frequency: SPI maximum frequency
> -
> -Example:
> -
> -max11100: adc@0 {
> -        compatible = "maxim,max11100";
> -        reg = <0>;
> -        vref-supply = <&adc0_vref>;
> -        spi-max-frequency = <240000>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
> new file mode 100644
> index 000000000000..0cf87556ef82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max11100.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX11100 ADC
> +
> +maintainers:
> +  - Jacopo Mondi <jacopo@jmondi.org>
> +
> +description: |
> +    Single channel 16 bit ADC with SPI interface.
> +
> +properties:
> +  compatible:
> +    const: maxim,max11100
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: External reference, needed to establish input scaling.
> +
> +  spi-max-frequency:
> +    minimum: 100000
> +    maximum: 4800000
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "maxim,max11100";
> +            reg = <0>;
> +            vref-supply = <&adc_vref>;
> +            spi-max-frequency = <240000>;
> +        };
> +    };
> +...
> --
> 2.27.0
>
