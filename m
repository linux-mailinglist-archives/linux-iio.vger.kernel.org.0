Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D682E7221
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 17:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2QLJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 11:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgL2QLJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 11:11:09 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5530720708;
        Tue, 29 Dec 2020 16:10:25 +0000 (UTC)
Date:   Tue, 29 Dec 2020 16:10:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop unnecessary *-supply schemas
 properties
Message-ID: <20201229161022.2df10815@archlinux>
In-Reply-To: <20201221234659.824881-1-robh@kernel.org>
References: <20201221234659.824881-1-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Dec 2020 16:46:59 -0700
Rob Herring <robh@kernel.org> wrote:

> *-supply properties are always a single phandle, so binding schemas
> don't need a type $ref nor 'maxItems'.
> 
> A meta-schema check for this is pending once these existing cases are
> fixed.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for-iio

> ---
>  Documentation/devicetree/bindings/display/bridge/anx6345.yaml | 2 --
>  .../devicetree/bindings/display/bridge/ite,it6505.yaml        | 2 --
>  .../devicetree/bindings/display/bridge/lvds-codec.yaml        | 3 +--
>  Documentation/devicetree/bindings/display/bridge/ps8640.yaml  | 2 --
>  .../devicetree/bindings/display/bridge/simple-bridge.yaml     | 1 -
>  .../bindings/display/bridge/thine,thc63lvd1024.yaml           | 1 -
>  .../devicetree/bindings/display/bridge/toshiba,tc358775.yaml  | 2 --
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml   | 4 +---
>  .../devicetree/bindings/iio/humidity/ti,hdc2010.yaml          | 3 +--
>  .../devicetree/bindings/input/fsl,mpr121-touchkey.yaml        | 3 +--
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml     | 3 +--
>  .../devicetree/bindings/media/i2c/maxim,max9286.yaml          | 1 -
>  Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml     | 3 ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml  | 3 ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml  | 3 ---
>  Documentation/devicetree/bindings/mfd/st,stmfx.yaml           | 3 +--
>  .../devicetree/bindings/regulator/anatop-regulator.yaml       | 1 -
>  17 files changed, 6 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.yaml b/Documentation/devicetree/bindings/display/bridge/anx6345.yaml
> index 8c0e4f285fbc..fccd63521a8c 100644
> --- a/Documentation/devicetree/bindings/display/bridge/anx6345.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.yaml
> @@ -26,11 +26,9 @@ properties:
>      description: GPIO connected to active low reset
>  
>    dvdd12-supply:
> -    maxItems: 1
>      description: Regulator for 1.2V digital core power.
>  
>    dvdd25-supply:
> -    maxItems: 1
>      description: Regulator for 2.5V digital core power.
>  
>    ports:
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index efbb3d0117dc..02cfc0a3b550 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -35,11 +35,9 @@ properties:
>      maxItems: 1
>  
>    ovdd-supply:
> -    maxItems: 1
>      description: I/O voltage
>  
>    pwr18-supply:
> -    maxItems: 1
>      description: core voltage
>  
>    interrupts:
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> index e5e3c72630cf..66a14d60ce1d 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> @@ -79,8 +79,7 @@ properties:
>        The GPIO used to control the power down line of this device.
>      maxItems: 1
>  
> -  power-supply:
> -    maxItems: 1
> +  power-supply: true
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
> index 7e27cfcf770d..763c7909473e 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
> @@ -35,11 +35,9 @@ properties:
>      description: GPIO connected to active low reset.
>  
>    vdd12-supply:
> -    maxItems: 1
>      description: Regulator for 1.2V digital core power.
>  
>    vdd33-supply:
> -    maxItems: 1
>      description: Regulator for 3.3V digital core power.
>  
>    ports:
> diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> index 3ddb35fcf0a2..64e8a1c24b40 100644
> --- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> @@ -60,7 +60,6 @@ properties:
>      description: GPIO controlling bridge enable
>  
>    vdd-supply:
> -    maxItems: 1
>      description: Power supply for the bridge
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.yaml b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.yaml
> index 469ac4a34273..3d5ce08a5792 100644
> --- a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.yaml
> @@ -74,7 +74,6 @@ properties:
>      description: Power down GPIO signal, pin name "/PDWN", active low.
>  
>    vcc-supply:
> -    maxItems: 1
>      description:
>        Power supply for the TTL output, TTL CLOCKOUT signal, LVDS input, PLL and
>        digital circuitry.
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> index fd3113aa9ccd..b5959cc78b8d 100644
> --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> @@ -28,11 +28,9 @@ properties:
>      description: i2c address of the bridge, 0x0f
>  
>    vdd-supply:
> -    maxItems: 1
>      description: 1.2V LVDS Power Supply
>  
>    vddio-supply:
> -    maxItems: 1
>      description: 1.8V IO Power Supply
>  
>    stby-gpios:
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> index 6a991e9f78e2..f04084fae5e8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> @@ -16,9 +16,7 @@ properties:
>      enum:
>        - lltc,ltc2496
>  
> -  vref-supply:
> -    description: phandle to an external regulator providing the reference voltage
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +  vref-supply: true
>  
>    reg:
>      description: spi chipselect number according to the usual spi bindings
> diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> index 7037f82ec753..88384b69f917 100644
> --- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> +++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> @@ -22,8 +22,7 @@ properties:
>        - ti,hdc2010
>        - ti,hdc2080
>  
> -  vdd-supply:
> -    maxItems: 1
> +  vdd-supply: true
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml b/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
> index 378a85c09d34..878464f128dc 100644
> --- a/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
> +++ b/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
> @@ -31,8 +31,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  vdd-supply:
> -    maxItems: 1
> +  vdd-supply: true
>  
>    linux,keycodes:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> index 4ce109476a0e..bfc3a8b5e118 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -55,8 +55,7 @@ properties:
>  
>    wakeup-source: true
>  
> -  vcc-supply:
> -    maxItems: 1
> +  vcc-supply: true
>  
>    gain:
>      description: Allows setting the sensitivity in the range from 0 to 31.
> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> index 9ea827092fdd..68ee8c7d9e79 100644
> --- a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> @@ -40,7 +40,6 @@ properties:
>  
>    poc-supply:
>      description: Regulator providing Power over Coax to the cameras
> -    maxItems: 1
>  
>    enable-gpios:
>      description: GPIO connected to the \#PWDN pin with inverted polarity
> diff --git a/Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml b/Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml
> index 0df0334d2d0d..bb3528315f20 100644
> --- a/Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml
> @@ -39,15 +39,12 @@ properties:
>  
>    vana-supply:
>      description: Analogue voltage supply (VANA), sensor dependent.
> -    maxItems: 1
>  
>    vcore-supply:
>      description: Core voltage supply (VCore), sensor dependent.
> -    maxItems: 1
>  
>    vio-supply:
>      description: I/O voltage supply (VIO), sensor dependent.
> -    maxItems: 1
>  
>    clocks:
>      description: External clock to the sensor.
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
> index 1a3590dd0e98..eb12526a462f 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
> @@ -37,15 +37,12 @@ properties:
>  
>    vdddo-supply:
>      description: Chip digital IO regulator (1.8V).
> -    maxItems: 1
>  
>    vdda-supply:
>      description: Chip analog regulator (2.7V).
> -    maxItems: 1
>  
>    vddd-supply:
>      description: Chip digital core regulator (1.12V).
> -    maxItems: 1
>  
>    flash-leds:
>      description: See ../video-interfaces.txt
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml
> index f697e1a20beb..a66acb20d59b 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml
> @@ -33,15 +33,12 @@ properties:
>  
>    vana-supply:
>      description: Sensor 2.8 V analog supply.
> -    maxItems: 1
>  
>    vdig-supply:
>      description: Sensor 1.8 V digital core supply.
> -    maxItems: 1
>  
>    vddl-supply:
>      description: Sensor digital IO 1.2 V supply.
> -    maxItems: 1
>  
>    port:
>      type: object
> diff --git a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
> index 888ab4b5df45..19e9afb385ac 100644
> --- a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
> +++ b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
> @@ -26,8 +26,7 @@ properties:
>  
>    drive-open-drain: true
>  
> -  vdd-supply:
> -    maxItems: 1
> +  vdd-supply: true
>  
>    pinctrl:
>      type: object
> diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml b/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
> index e7b3abe30363..0a66338c7e5a 100644
> --- a/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
> @@ -59,7 +59,6 @@ properties:
>      description: u32 value representing regulator enable bit offset.
>  
>    vin-supply:
> -    $ref: '/schemas/types.yaml#/definitions/phandle'
>      description: input supply phandle.
>  
>  required:

