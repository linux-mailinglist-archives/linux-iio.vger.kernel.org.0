Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767E22BC781
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 18:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgKVRcQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 12:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgKVRcQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 12:32:16 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146842075A;
        Sun, 22 Nov 2020 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606066335;
        bh=/wu7ruYdNOr0Bdkqytlfkg3lpsrcA4CAvEwKu46dJ0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P4Bu4c88h0YaktyTyjwMUQQaXqPYqxFRLg6jUEEbI1khdWcwWlW55GIsK6hV8JZzo
         +DWzJho2R7gDCjWD9Mb8E2+RcCCY5B8LEwxJiBxtPi7zIGawKg65tiranFJZsjuwrX
         Dpw2uZbT5K/XYTr4sO2OoqZOvEAfANiKDO4qSQB0=
Date:   Sun, 22 Nov 2020 17:32:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 07/46] dt-bindings:iio:health:ti,afe4403: txt to yaml
 binding
Message-ID: <20201122173211.26f4a912@archlinux>
In-Reply-To: <20201031184854.745828-8-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-8-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 18:48:15 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A few questions came up whilst converting this one.
> 1) What is actually required?
>   - Checking Linux driver, interrupt is not, and the tx-supply could
>     be supplied by a stub regulator as long as it's always on.
>     As such I have reduced the required list to just compatible and reg.
> 2) What is the regulator called?
>   - It's tx-supply in the binding doc, but the driver request tx_sup
>     I've left this alone for now.  Andrew could you confirm what is
>     intended for this?

Andrew's email seems to be bouncing so I've reached out to him via another
means.  Will wait to see if that works before applying this or the next
patch given the questions.

Thanks,

Jonathan

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andrew F. Davis <afd@ti.com>
> ---
>  .../bindings/iio/health/afe4403.txt           | 33 ------------
>  .../bindings/iio/health/ti,afe4403.yaml       | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/afe4403.txt b/Documentation/devicetree/bindings/iio/health/afe4403.txt
> deleted file mode 100644
> index 8e412054d6d5..000000000000
> --- a/Documentation/devicetree/bindings/iio/health/afe4403.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -Texas Instruments AFE4403 Heart rate and Pulse Oximeter
> -
> -Required properties:
> - - compatible		: Should be "ti,afe4403".
> - - reg			: SPI chip select address of device.
> - - tx-supply		: Regulator supply to transmitting LEDs.
> - - interrupts		: The interrupt line the device ADC_RDY pin is
> -			  connected to. For details refer to,
> -			  ../../interrupt-controller/interrupts.txt.
> -
> -Optional properties:
> - - reset-gpios		: GPIO used to reset the device.
> -			  For details refer to, ../../gpio/gpio.txt.
> -
> -For other required and optional properties of SPI slave nodes
> -please refer to ../../spi/spi-bus.txt.
> -
> -Example:
> -
> -&spi0 {
> -	heart_mon@0 {
> -		compatible = "ti,afe4403";
> -		reg = <0>;
> -		spi-max-frequency = <10000000>;
> -
> -		tx-supply = <&vbat>;
> -
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <28 IRQ_TYPE_EDGE_RISING>;
> -
> -		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> new file mode 100644
> index 000000000000..5c86db65c033
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/health/ti,afe4403.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments AFE4403 Heart rate and Pulse Oximeter
> +
> +maintainers:
> +  - Andrew F. Davis <afd@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,afe4403
> +
> +  reg:
> +    maxItems: 1
> +
> +  tx-supply:
> +    description: Supply to transmitting LEDs.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Connected to ADC_RDY pin.
> +
> +  reset-gpios: true
> +
> +  spi-max-frequency: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        heart_mon@0 {
> +            compatible = "ti,afe4403";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            tx-supply = <&vbat>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <28 IRQ_TYPE_EDGE_RISING>;
> +            reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +...

