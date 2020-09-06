Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52025EF06
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgIFQNo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 12:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgIFQNl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 12:13:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916C620709;
        Sun,  6 Sep 2020 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599408820;
        bh=cz5aQYAC3yke9ZtHAVVBjQ4XTML6af1XdQJyE47B34A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iG9vypk/SWy1aUjqmPK9lff1PiLgrGInTQsBQS1ntSMwlfb5jkuBRhWW6PNWZL6Wy
         AIcZmhozfju1yFsBCHJvUCWz7uCk5g6lm4gTQePdJYy5xs9GpGtbZ4MxZHf+M0/xd5
         2vPpCosxRZ9+kuaqlQT5ti/9GdxctY0AXo/j1J7Q=
Date:   Sun, 6 Sep 2020 17:13:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan Popa <stefan.popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [PATCH 15/20] dt-bindings:iio:adc:ad7768-1 yaml conversion
Message-ID: <20200906171336.4352ec49@archlinux>
In-Reply-To: <20200905173004.216081-16-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
        <20200905173004.216081-16-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  5 Sep 2020 18:29:59 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fairly straight conversion.  The one oddity in the original binding
> is that spi-cpha and spi-cpol were not marked as required, but were
> in the example.  Looking at the datasheet, there isn't any documented
> flexibility in the possible SPI modes, so I have moved these to requires.
> For spi-max-frequency I have gone the other way.  I absolutely agree
> that it is good to specify this in the dt-binding, but it's not
> strictly required.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Stefan Popa <stefan.popa@analog.com>

As Stefan bounced, I guess not the best choice for maintainer on this
binding going forwards.

Shall we go the same way as with the code Maintenance and make it
Michael's problem? :)

Jonathan
> ---
>  .../bindings/iio/adc/adi,ad7768-1.txt         | 41 ---------
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 89 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
> deleted file mode 100644
> index 9f5b88cf680d..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Analog Devices AD7768-1 ADC device driver
> -
> -Required properties for the AD7768-1:
> -
> -- compatible: Must be "adi,ad7768-1"
> -- reg: SPI chip select number for the device
> -- spi-max-frequency: Max SPI frequency to use
> -	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> -- clocks: phandle to the master clock (mclk)
> -	see: Documentation/devicetree/bindings/clock/clock-bindings.txt
> -- clock-names: Must be "mclk".
> -- interrupts: IRQ line for the ADC
> -	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -- vref-supply: vref supply can be used as reference for conversion
> -- adi,sync-in-gpios: must be the device tree identifier of the SYNC-IN pin. Enables
> -	synchronization of multiple devices that require simultaneous sampling.
> -	A pulse is always required if the configuration is changed in any way, for example
> -	if the filter decimation rate changes. As the line is active low, it should
> -	be marked GPIO_ACTIVE_LOW.
> -
> -Optional properties:
> -
> - - reset-gpios : GPIO spec for the RESET pin. If specified, it will be asserted during
> -	driver probe. As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> -
> -Example:
> -
> -	adc@0 {
> -		compatible = "adi,ad7768-1";
> -		reg = <0>;
> -		spi-max-frequency = <2000000>;
> -		spi-cpol;
> -		spi-cpha;
> -		vref-supply = <&adc_vref>;
> -		interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> -		interrupt-parent = <&gpio>;
> -		adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> -		reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> -		clocks = <&ad7768_mclk>;
> -		clock-names = "mclk";
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> new file mode 100644
> index 000000000000..a2c559d0c947
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7768-1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7768-1 ADC device driver
> +
> +maintainers:
> +  - Stefan Popa <stefan.popa@analog.com>
> +
> +description: |
> +  Datasheet at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
> +
> +properties:
> +  compatible:
> +    const: adi,ad7768-1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      ADC reference voltage supply
> +
> +  adi,sync-in-gpios:
> +    description:
> +      Enables synchronization of multiple devices that require simultaneous
> +      sampling. A pulse is always required if the configuration is changed
> +      in any way, for example if the filter decimation rate changes.
> +      As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  spi-cpol: true
> +  spi-cpha : true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - vref-supply
> +  - spi-cpol
> +  - spi-cpha
> +  - adi,sync-in-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad7768-1";
> +            reg = <0>;
> +            spi-max-frequency = <2000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            vref-supply = <&adc_vref>;
> +            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-parent = <&gpio>;
> +            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> +            reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +            clocks = <&ad7768_mclk>;
> +            clock-names = "mclk";
> +        };
> +    };
> +...

