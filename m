Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8221C909
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgGLLW0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 07:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbgGLLW0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 07:22:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 663FC2075F;
        Sun, 12 Jul 2020 11:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594552945;
        bh=ZselvpBXx8fvRjXcrydYqfW7ObsUAVRjBnXH31XHV40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HmSPwmhUhokYPC5svIpG9xyv9N62LQcH9CPsa82fkLzWHfZC5PoyR93qeAwPxJk9d
         80LKKbnFOiUVwswt4qXrqzJvXcLzi48Sgz3/D4MxAW2dHr4xSCaM3fTyVqjggGD++w
         hl1wi6t6RKPddPQgiR/QbsIpUWzH6Zh1T3VPi2nU=
Date:   Sun, 12 Jul 2020 12:22:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 1/6] dt-bindings: iio/adc: Convert ingenic-adc docs
 to YAML.
Message-ID: <20200712122219.6c9e1e62@archlinux>
In-Reply-To: <20200709152200.10039-2-contact@artur-rojek.eu>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
        <20200709152200.10039-2-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  9 Jul 2020 17:21:55 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Convert the textual documentation of Device Tree bindings for the
> Ingenic JZ47xx SoCs ADC controller to YAML.
> 
> The `interrupts` property is now explicitly listed and marked as
> required. While missing from the previous textual documentation, this
> property has been used with all the boards which probe this driver.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Rob Herring <robh@kernel.org>

Given this is a good change on it's own. I'll apply it before even
reading the rest of the series.  If we do need to go to a v9 at least
it'll be shorter ;) 

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
> 
>  Changes:
> 
>  v6: new patch
> 
>  v7: - specify `maxItems: 1` for single entry properties
>      - get rid of redundant descriptions of said properties
> 
>  v8: no change
> 
>  .../bindings/iio/adc/ingenic,adc.txt          | 49 -------------
>  .../bindings/iio/adc/ingenic,adc.yaml         | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> deleted file mode 100644
> index cd9048cf9dcf..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -* Ingenic JZ47xx ADC controller IIO bindings
> -
> -Required properties:
> -
> -- compatible: Should be one of:
> -  * ingenic,jz4725b-adc
> -  * ingenic,jz4740-adc
> -  * ingenic,jz4770-adc
> -- reg: ADC controller registers location and length.
> -- clocks: phandle to the SoC's ADC clock.
> -- clock-names: Must be set to "adc".
> -- #io-channel-cells: Must be set to <1> to indicate channels are selected
> -  by index.
> -
> -ADC clients must use the format described in iio-bindings.txt, giving
> -a phandle and IIO specifier pair ("io-channels") to the ADC controller.
> -
> -Example:
> -
> -#include <dt-bindings/iio/adc/ingenic,adc.h>
> -
> -adc: adc@10070000 {
> -	compatible = "ingenic,jz4740-adc";
> -	#io-channel-cells = <1>;
> -
> -	reg = <0x10070000 0x30>;
> -
> -	clocks = <&cgu JZ4740_CLK_ADC>;
> -	clock-names = "adc";
> -
> -	interrupt-parent = <&intc>;
> -	interrupts = <18>;
> -};
> -
> -adc-keys {
> -	...
> -	compatible = "adc-keys";
> -	io-channels = <&adc INGENIC_ADC_AUX>;
> -	io-channel-names = "buttons";
> -	...
> -};
> -
> -battery {
> -	...
> -	compatible = "ingenic,jz4740-battery";
> -	io-channels = <&adc INGENIC_ADC_BATTERY>;
> -	io-channel-names = "battery";
> -	...
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> new file mode 100644
> index 000000000000..9f414dbdae86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019-2020 Artur Rojek
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/adc/ingenic,adc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Ingenic JZ47xx ADC controller IIO bindings
> +
> +maintainers:
> +  - Artur Rojek <contact@artur-rojek.eu>
> +
> +description: >
> +  Industrial I/O subsystem bindings for ADC controller found in
> +  Ingenic JZ47xx SoCs.
> +
> +  ADC clients must use the format described in iio-bindings.txt, giving
> +  a phandle and IIO specifier pair ("io-channels") to the ADC controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ingenic,jz4725b-adc
> +      - ingenic,jz4740-adc
> +      - ingenic,jz4770-adc
> +
> +  '#io-channel-cells':
> +    const: 1
> +    description:
> +      Must be set to <1> to indicate channels are selected by index.
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: adc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#io-channel-cells'
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/jz4740-cgu.h>
> +    #include <dt-bindings/iio/adc/ingenic,adc.h>
> +
> +    adc@10070000 {
> +            compatible = "ingenic,jz4740-adc";
> +            #io-channel-cells = <1>;
> +
> +            reg = <0x10070000 0x30>;
> +
> +            clocks = <&cgu JZ4740_CLK_ADC>;
> +            clock-names = "adc";
> +
> +            interrupt-parent = <&intc>;
> +            interrupts = <18>;
> +    };

