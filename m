Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D233EEF1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 11:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhCQK61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 06:58:27 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:7736 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230308AbhCQK6H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 06:58:07 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12HApwTB027743;
        Wed, 17 Mar 2021 11:57:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=ywy0JW8wYUOY2VcO+XEXq2HaVDdPgp6t1+DV/zS0bVI=;
 b=K3P5kFh0vPO8qD0+W7Ip0SxREySWHhHchyu7R+h94GNyb0WlCUadf/fRAybvdHWzcwqH
 Pnus+1LkWIobyUoM20+sEOdNRY0aHrz3lnkk7Dp5pFd+mro3V0xI9C2dO5rzGcai8hR8
 YH5DQeJ6Jw1z6vibs55WWQCoNnZHtYIAeDBLdE8riZmEq8P/sSsuYuWKsirr33mw1R85
 o7Pk+9/Lt2hkNSVKnaNcBTDCceRNHw6qHIEuE/6YzGKC4zh5jJFlBlNbAM81JUe8Yd/J
 1TSJvaIuW80W7C0QiXlPQGu2Md/cn1AfnPpg+fdaSA0VeyFnzV0ShTPOI9vvCZgyQKzx yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 378pr5xppd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 11:57:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6542100034;
        Wed, 17 Mar 2021 11:57:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7004D226D05;
        Wed, 17 Mar 2021 11:57:39 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Mar
 2021 11:57:38 +0100
Date:   Wed, 17 Mar 2021 11:57:31 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-clk@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-i3c@lists.infradead.org>, <linux-iio@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Clean-up undocumented compatible strings
Message-ID: <20210317105731.GA21081@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210316194918.3528417-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210316194918.3528417-1-robh@kernel.org>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_05:2021-03-17,2021-03-17 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 16, 2021 at 01:49:18PM -0600, Rob Herring wrote:
> Adding checks for undocumented compatible strings reveals a bunch of
> warnings in the DT binding examples. Fix the cases which are typos, just
> a mismatch between the schema and the example, or aren't documented at all.
> In a couple of cases, fixing the compatible revealed some schema errors
> which are fixed.
> 
> There's a bunch of others remaining after this which have bindings, but
> those aren't converted to schema yet.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-clk@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-i3c@lists.infradead.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../clock/allwinner,sun4i-a10-pll1-clk.yaml   |  2 +-
>  .../bindings/clock/milbeaut-clock.yaml        | 12 +++++----
>  .../bindings/display/brcm,bcm2835-dsi0.yaml   |  6 -----
>  .../bindings/display/panel/panel-dpi.yaml     |  2 +-
>  .../devicetree/bindings/dma/qcom,gpi.yaml     |  2 +-
>  .../devicetree/bindings/i3c/i3c.yaml          |  7 ++---
>  .../iio/adc/brcm,iproc-static-adc.yaml        |  5 ----
>  .../iio/gyroscope/nxp,fxas21002c.yaml         |  2 +-
>  .../bindings/iio/light/upisemi,us5182.yaml    |  4 +--
>  .../interrupt-controller/loongson,htpic.yaml  |  2 +-
>  .../devicetree/bindings/leds/leds-lgm.yaml    | 26 ++++++++++++++++---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        |  2 +-
>  .../bindings/power/supply/cw2015_battery.yaml |  2 +-
>  .../bindings/power/supply/power-supply.yaml   | 22 ----------------
>  .../devicetree/bindings/serial/serial.yaml    |  2 +-
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  4 +--
>  .../bindings/spi/spi-controller.yaml          | 21 ++++++++-------
>  .../devicetree/bindings/spi/spi-mux.yaml      |  8 ++----
>  .../devicetree/bindings/spi/st,stm32-spi.yaml |  6 -----

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

>  19 files changed, 58 insertions(+), 79 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll1-clk.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll1-clk.yaml
> index e9c4cf834aa7..e5d9d45dab8a 100644
> --- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll1-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll1-clk.yaml
> @@ -44,7 +44,7 @@ examples:
>    - |
>      clk@1c20000 {
>          #clock-cells = <0>;
> -        compatible = "allwinner,sun4i-a10-pll1";
> +        compatible = "allwinner,sun4i-a10-pll1-clk";
>          reg = <0x01c20000 0x4>;
>          clocks = <&osc24M>;
>          clock-output-names = "osc24M";
> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> index 0e8b07710451..6d39344d2b70 100644
> --- a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> @@ -18,10 +18,12 @@ description: |
>  
>  properties:
>    compatible:
> -    oneOf:
> -      - items:
> -          - enum:
> -              - socionext,milbeaut-m10v-ccu
> +    enum:
> +      - socionext,milbeaut-m10v-ccu
> +
> +  reg:
> +    maxItems: 1
> +
>    clocks:
>      maxItems: 1
>      description: external clock
> @@ -41,7 +43,7 @@ examples:
>    # Clock controller node:
>    - |
>      m10v-clk-ctrl@1d021000 {
> -        compatible = "socionext,milbeaut-m10v-clk-ccu";
> +        compatible = "socionext,milbeaut-m10v-ccu";
>          reg = <0x1d021000 0x4000>;
>          #clock-cells = <1>;
>          clocks = <&clki40mhz>;
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> index 55c60919991f..32608578a352 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> @@ -77,12 +77,6 @@ examples:
>  
>          clock-output-names = "dsi1_byte", "dsi1_ddr2", "dsi1_ddr";
>  
> -        pitouchscreen: panel@0 {
> -            compatible = "raspberrypi,touchscreen";
> -            reg = <0>;
> -
> -            /* ... */
> -        };
>      };
>  
>  ...
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> index 0cd74c8dab42..dae0676b5c6e 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> @@ -40,7 +40,7 @@ additionalProperties: false
>  examples:
>    - |
>      panel {
> -        compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
> +        compatible = "startek,startek-kd050c", "panel-dpi";
>          label = "osddisplay";
>          power-supply = <&vcc_supply>;
>          backlight = <&backlight>;
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index f8142adf9aea..2e66840a78fe 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -64,7 +64,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/dma/qcom-gpi.h>
>      gpi_dma0: dma-controller@800000 {
> -        compatible = "qcom,gpi-dma";
> +        compatible = "qcom,sdm845-gpi-dma";
>          #dma-cells = <3>;
>          reg = <0x00800000 0x60000>;
>          iommus = <&apps_smmu 0x0016 0x0>;
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
> index 52042aa44d19..1f82fc923799 100644
> --- a/Documentation/devicetree/bindings/i3c/i3c.yaml
> +++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
> @@ -157,9 +157,10 @@ examples:
>          i2c-scl-hz = <100000>;
>  
>          /* I2C device. */
> -        nunchuk: nunchuk@52 {
> -            compatible = "nintendo,nunchuk";
> -            reg = <0x52 0x0 0x10>;
> +        eeprom@57 {
> +            compatible = "atmel,24c01";
> +            reg = <0x57 0x0 0x10>;
> +            pagesize = <0x8>;
>          };
>  
>          /* I3C device with a static I2C address. */
> diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
> index c562d25bee3b..547697e8bc8b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
> @@ -53,11 +53,6 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <1>;
>  
> -        ts_adc_syscon: ts_adc_syscon@180a6000 {
> -            compatible = "brcm,iproc-ts-adc-syscon","syscon";
> -            reg = <0x180a6000 0xc30>;
> -        };
> -
>          adc {
>              compatible = "brcm,iproc-static-adc";
>              adc-syscon = <&ts_adc_syscon>;
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> index d97ee774d6a6..3f57a1b813e6 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> @@ -83,7 +83,7 @@ examples:
>          #size-cells = <0>;
>  
>          gyroscope@0 {
> -          compatible = "nxp,fxas2102c";
> +          compatible = "nxp,fxas21002c";
>            reg = <0x0>;
>  
>            spi-max-frequency = <2000000>;
> diff --git a/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
> index de5882cb3360..dd78abe0ec8d 100644
> --- a/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
> @@ -11,12 +11,12 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: upisemi,asd5182
> +    const: upisemi,usd5182
>  
>    reg:
>      maxItems: 1
>  
> -  upsemi,glass-coef:
> +  upisemi,glass-coef:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: |
>        glass attenuation factor - compensation factor of resolution 1000
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,htpic.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,htpic.yaml
> index d1d52d1db2be..d6bc1a687fc7 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,htpic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,htpic.yaml
> @@ -47,7 +47,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
>      htintc: interrupt-controller@1fb000080 {
> -      compatible = "loongson,htintc-1.0";
> +      compatible = "loongson,htpic-1.0";
>        reg = <0xfb000080 0x40>;
>        interrupt-controller;
>        #interrupt-cells = <1>;
> diff --git a/Documentation/devicetree/bindings/leds/leds-lgm.yaml b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
> index 32bbf146c01d..f8d7963c3a13 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lgm.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
> @@ -14,6 +14,17 @@ properties:
>    compatible:
>      const: intel,lgm-ssoled
>  
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: sso
> +      - const: fpid
> +
>    gpio-controller: true
>  
>    '#gpio-cells':
> @@ -36,8 +47,15 @@ properties:
>  
>      additionalProperties: false
>  
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
>      patternProperties:
> -      "^led@[0-23]$":
> +      "^led@[0-2]$":
>          type: object
>  
>          properties:
> @@ -81,7 +99,7 @@ examples:
>      #include <dt-bindings/leds/common.h>
>  
>      ssogpio: ssogpio@e0d40000 {
> -      compatible = "intel,sso-led";
> +      compatible = "intel,lgm-ssoled";
>        reg = <0xE0D40000 0x2E4>;
>        gpio-controller;
>        #gpio-cells = <2>;
> @@ -103,8 +121,8 @@ examples:
>            led-gpio = <&ssogpio 0 0>;
>          };
>  
> -        led@23 {
> -          reg = <23>;
> +        led@2 {
> +          reg = <2>;
>            function = LED_FUNCTION_POWER;
>            color = <LED_COLOR_ID_GREEN>;
>            led-gpio = <&ssogpio 23 0>;
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index bbbd85501ada..d0040255c591 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -218,7 +218,7 @@ examples:
>             };
>  
>             serdes@5000000 {
> -                  compatible = "cdns,ti,sierra-phy-t0";
> +                  compatible = "ti,sierra-phy-t0";
>                    reg-names = "serdes";
>                    reg = <0x5000000 0x10000>;
>                    #address-cells = <1>;
> diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> index 5fcdf5801536..c73abb2ff513 100644
> --- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> @@ -61,7 +61,7 @@ examples:
>          #size-cells = <0>;
>  
>          cw2015@62 {
> -            compatible = "cellwise,cw201x";
> +            compatible = "cellwise,cw2015";
>              reg = <0x62>;
>              cellwise,battery-profile = /bits/ 8 <
>                  0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
> diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> index c5c55f627251..259760167759 100644
> --- a/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> @@ -18,25 +18,3 @@ properties:
>  
>  additionalProperties: true
>  
> -examples:
> -  - |
> -    power {
> -      #address-cells = <1>;
> -      #size-cells = <0>;
> -
> -      usb_charger:charger@e {
> -        compatible = "some,usb-charger";
> -        reg = <0xe>;
> -      };
> -
> -      ac_charger:charger@c {
> -        compatible = "some,ac-charger";
> -        reg = <0xc>;
> -      };
> -
> -      battery:battery@b {
> -        compatible = "some,battery";
> -        reg = <0xb>;
> -        power-supplies = <&usb_charger>, <&ac_charger>;
> -      };
> -    };
> diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
> index 65e75d040521..eea300405816 100644
> --- a/Documentation/devicetree/bindings/serial/serial.yaml
> +++ b/Documentation/devicetree/bindings/serial/serial.yaml
> @@ -134,7 +134,7 @@ examples:
>              interrupts = <1>;
>  
>              bluetooth {
> -                    compatible = "brcm,bcm43341-bt";
> +                    compatible = "brcm,bcm4330-bt";
>                      interrupt-parent = <&gpio>;
>                      interrupts = <10>;
>              };
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> index 667dedefd69f..e3fb553d9180 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -90,8 +90,8 @@ examples:
>            #address-cells = <1>;
>            #size-cells = <0>;
>  
> -          ethernet-switch@0 {
> -              compatible = "micrel,ks8995m";
> +          display@0 {
> +              compatible = "lg,lg4573";
>                spi-max-frequency = <1000000>;
>                reg = <0>;
>            };
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 06786f1b43d2..0477396e4945 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -181,22 +181,23 @@ additionalProperties: true
>  
>  examples:
>    - |
> -    spi@f00 {
> +    spi@80010000 {
>          #address-cells = <1>;
>          #size-cells = <0>;
> -        compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
> -        reg = <0xf00 0x20>;
> -        interrupts = <2 13 0 2 14 0>;
> -        interrupt-parent = <&mpc5200_pic>;
> -
> -        ethernet-switch@0 {
> -            compatible = "micrel,ks8995m";
> +        compatible = "fsl,imx28-spi";
> +        reg = <0x80010000 0x2000>;
> +        interrupts = <96>;
> +        dmas = <&dma_apbh 0>;
> +        dma-names = "rx-tx";
> +
> +        display@0 {
> +            compatible = "lg,lg4573";
>              spi-max-frequency = <1000000>;
>              reg = <0>;
>          };
>  
> -        codec@1 {
> -            compatible = "ti,tlv320aic26";
> +        sensor@1 {
> +            compatible = "bosch,bme680";
>              spi-max-frequency = <100000>;
>              reg = <1>;
>          };
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> index 6c21a132b51f..d09c6355e22d 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mux.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> @@ -75,16 +75,12 @@ examples:
>              spi-flash@0 {
>                  compatible = "jedec,spi-nor";
>                  reg = <0>;
> -                #address-cells = <1>;
> -                #size-cells = <0>;
>                  spi-max-frequency = <40000000>;
>              };
>  
> -            spi-device@1 {
> -                compatible = "lineartechnology,ltc2488";
> +            sensor@1 {
> +                compatible = "bosch,bme680";
>                  reg = <1>;
> -                #address-cells = <1>;
> -                #size-cells = <0>;
>                  spi-max-frequency = <10000000>;
>              };
>          };
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index d11806b1ede3..2d9af4c506bb 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -96,12 +96,6 @@ examples:
>        dma-names = "rx", "tx";
>        cs-gpios = <&gpioa 11 0>;
>  
> -      aardvark@0 {
> -        compatible = "totalphase,aardvark";
> -        reg = <0>;
> -        spi-max-frequency = <4000000>;
> -        st,spi-midi-ns = <4000>;
> -      };
>      };
>  
>  ...
> -- 
> 2.27.0
> 
