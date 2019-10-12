Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA626D4EB3
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJLJqR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 05:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbfJLJoo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 05:44:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18FA7206A1;
        Sat, 12 Oct 2019 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570873483;
        bh=7nesmRVdeqXmrUrcZBzK7PXJwI/0y8O+/4B+PM1WZGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N93qvl1a2ohoyXNYwAMogPlc7bikfh0lBr0MxyohBL1ne8acAsgbb5CVLSCiWhCXw
         /IxbVcMsHmgNMLUgB8hEotjfVUK/csvbE2SJ+KziIv6b7anjeViRUiiBUfYu10dr6G
         alR0o23uLGhe8gmJ2FLY5LlbOxQmE+S50Xz73Yao=
Date:   Sat, 12 Oct 2019 10:44:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Clean-up regulator '-supply' schemas
Message-ID: <20191012104437.460694f9@archlinux>
In-Reply-To: <20191011190231.9779-1-robh@kernel.org>
References: <20191011190231.9779-1-robh@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 14:02:31 -0500
Rob Herring <robh@kernel.org> wrote:

> Regulator '*-supply' properties are always a single phandle, so
> 'maxItems: 1' or a $ref is not necessary. All that's needed is either
> 'true' or an optional 'description'. Following this clean-up, the
> meta-schema will enforce this pattern.
> 
> There's one case in tree with 'innolux,n156bge-l21' having 2 phandles.
> This appears to be a mistake or abuse of simple-panel as it's 2 different
> voltage rails connected to 'power-supply'.

Nice to centralise bits of schema like this, though perhaps it does
make everything feel a bit unpredictable as not obvious to someone writing
a binding that a particular corner has been centralized but others haven't.

Oh well, I guess they should look at the relevant docs for each bit.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for iio

Thanks,

Jonathan

> 
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml   | 2 --
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml  | 3 +--
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml  | 3 +--
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml   | 3 +--
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml    | 3 ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml    | 5 +----
>  Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml    | 1 -
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml    | 1 -
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml      | 4 +---
>  .../devicetree/bindings/iio/chemical/plantower,pms7003.yaml  | 1 -
>  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml   | 2 --
>  .../devicetree/bindings/phy/amlogic,meson-g12a-usb2-phy.yaml | 1 -
>  .../devicetree/bindings/regulator/fixed-regulator.yaml       | 1 -
>  13 files changed, 5 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
> index fb747682006d..0da42ab8fd3a 100644
> --- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
> @@ -79,8 +79,6 @@ properties:
>  
>    hdmi-supply:
>      description: phandle to an external 5V regulator to power the HDMI logic
> -    allOf:
> -      - $ref: /schemas/types.yaml#/definitions/phandle
>  
>    port@0:
>      type: object
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 5f1fd6d7ee0f..e50a0cc78fff 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -37,8 +37,7 @@ properties:
>    clocks:
>      maxItems: 1
>  
> -  mali-supply:
> -    maxItems: 1
> +  mali-supply: true
>  
>    operating-points-v2: true
>  
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> index 47bc1ac36426..5c576e5019c6 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> @@ -69,8 +69,7 @@ properties:
>        - const: core
>        - const: bus
>  
> -  mali-supply:
> -    maxItems: 1
> +  mali-supply: true
>  
>    resets:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> index c5d93c5839d3..afde81be3c29 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> @@ -97,8 +97,7 @@ properties:
>  
>    memory-region: true
>  
> -  mali-supply:
> -    maxItems: 1
> +  mali-supply: true
>  
>    power-domains:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 9692b7f719f5..e932d5aed02f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -45,15 +45,12 @@ properties:
>  
>    refin1-supply:
>      description: refin1 supply can be used as reference for conversion.
> -    maxItems: 1
>  
>    refin2-supply:
>      description: refin2 supply can be used as reference for conversion.
> -    maxItems: 1
>  
>    avdd-supply:
>      description: avdd supply can be used as reference for conversion.
> -    maxItems: 1
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index cc544fdc38be..6eb33207a167 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -31,10 +31,7 @@ properties:
>  
>    spi-cpha: true
>  
> -  avcc-supply:
> -    description:
> -      Phandle to the Avcc power supply
> -    maxItems: 1
> +  avcc-supply: true
>  
>    interrupts:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> index d1109416963c..9acde6d2e2d9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> @@ -39,7 +39,6 @@ properties:
>    avdd-supply:
>      description:
>        The regulator supply for the ADC reference voltage.
> -    maxItems: 1
>  
>    powerdown-gpios:
>      description:
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index d76ece97c76c..91ab9c842273 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -41,7 +41,6 @@ properties:
>    avdd-supply:
>      description:
>        Definition of the regulator used as analog supply
> -    maxItems: 1
>  
>    clock-frequency:
>      minimum: 20000
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index b4c6c26681d9..9218b2efa62f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -46,9 +46,7 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> -  vdd-supply:
> -    description: VDD input supply
> -    maxItems: 1
> +  vdd-supply: true
>  
>    samsung,syscon-phandle:
>      $ref: '/schemas/types.yaml#/definitions/phandle'
> diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
> index a551d3101f93..19e53930ebf6 100644
> --- a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
> +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
> @@ -25,7 +25,6 @@ properties:
>  
>    vcc-supply:
>      description: regulator that provides power to the sensor
> -    maxItems: 1
>  
>    plantower,set-gpios:
>      description: GPIO connected to the SET line
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index c6721a7e8938..519137e5c170 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -28,12 +28,10 @@ properties:
>    vddd-supply:
>      description:
>        digital voltage regulator (see regulator/regulator.txt)
> -    maxItems: 1
>  
>    vdda-supply:
>      description:
>        analog voltage regulator (see regulator/regulator.txt)
> -    maxItems: 1
>  
>    reset-gpios:
>      description:
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb2-phy.yaml
> index 51254b4e65dd..57d8603076bd 100644
> --- a/Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb2-phy.yaml
> @@ -36,7 +36,6 @@ properties:
>      const: 0
>  
>    phy-supply:
> -     maxItems: 1
>       description:
>         Phandle to a regulator that provides power to the PHY. This
>         regulator will be managed during the PHY power on/off sequence.
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> index a78150c47aa2..e56d97b233f4 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> @@ -64,7 +64,6 @@ properties:
>  
>    vin-supply:
>      description: Input supply phandle.
> -    $ref: /schemas/types.yaml#/definitions/phandle
>  
>  required:
>    - compatible

