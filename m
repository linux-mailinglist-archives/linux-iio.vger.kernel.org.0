Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B056263689
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 21:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIITTb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 15:19:31 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:32779 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgIITT2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 15:19:28 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 01DE41C0004;
        Wed,  9 Sep 2020 19:19:23 +0000 (UTC)
Date:   Wed, 9 Sep 2020 21:19:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 07/20] dt-bindings:iio:adc:nuvoton,nau7802 yaml
 conversion
Message-ID: <20200909191923.GV230586@piout.net>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-8-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-8-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 09/09/2020 18:59:33+0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A simple conversion from txt file to yaml.  I added the #io-channel-cells
> property as optional to allow the channels of this ADCs to be used
> to provide services to other drivers, for example if an analog
> accelerometer is connected.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../bindings/iio/adc/nuvoton,nau7802.yaml     | 50 +++++++++++++++++++
>  .../bindings/iio/adc/nuvoton-nau7802.txt      | 18 -------
>  2 files changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml
> new file mode 100644
> index 000000000000..bcd041ea28a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nau7802.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NAU7802 I2c Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +  - Maxime Ripard <maxime.ripard@free-electrons.com>
> +

Sorry, I meant to reply earlier. Can you make that:

 - Alexandre Belloni <alexandre.belloni@bootlin.com>
 - Maxime Ripard <mripard@kernel.org>

Else, this seems good to me!

> +properties:
> +  compatible:
> +    const: nuvoton,nau7802
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  nuvoton,vldo:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Internal reference voltage in millivolts to be configured.
> +    minimum: 2400
> +    maximum: 4500
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        nau7802@2a {
> +            compatible = "nuvoton,nau7802";
> +            reg = <0x2a>;
> +            nuvoton,vldo = <3000>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
> deleted file mode 100644
> index e9582e6fe350..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Nuvoton NAU7802 Analog to Digital Converter (ADC)
> -
> -Required properties:
> -  - compatible: Should be "nuvoton,nau7802"
> -  - reg: Should contain the ADC I2C address
> -
> -Optional properties:
> -  - nuvoton,vldo: Internal reference voltage in millivolts to be
> -    configured valid values are between 2400 mV and 4500 mV.
> -  - interrupts: IRQ line for the ADC. If not used the driver will use
> -    polling.
> -
> -Example:
> -adc2: nau7802@2a {
> -	compatible = "nuvoton,nau7802";
> -	reg = <0x2a>;
> -	nuvoton,vldo = <3000>;
> -};
> -- 
> 2.28.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
