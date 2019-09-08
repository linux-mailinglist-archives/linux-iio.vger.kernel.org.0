Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F3ACCAC
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfIHM3w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:29:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728922AbfIHM3w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:29:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5537C214D9;
        Sun,  8 Sep 2019 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567945790;
        bh=0ME8lxQlgIXI2GTkHugQVSj2YHJKSsaTU8trcri8oB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mNSr/PVIPhGjv9a5n7+EYQ1GX8gflBbYS8shVzTsM8gfjTvAC7wIQd0BOTaJpI0Uz
         WWkiA7wu6twROYcG7HjnF01NppaNb+5aZmW4c/e2oiJWA5RmeRLmmZGP4x83aovNqE
         xEoKDJddRVEcSw+qKV5Qe3XMaCTpfiLvKBwRMT40=
Date:   Sun, 8 Sep 2019 13:29:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 10/11] dt-bindings: iio: adc: exynos: Convert Exynos
 ADC bindings to json-schema
Message-ID: <20190908132944.029f3a93@archlinux>
In-Reply-To: <20190907092007.9946-10-krzk@kernel.org>
References: <20190907092007.9946-1-krzk@kernel.org>
        <20190907092007.9946-10-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:20:06 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Convert Samsung Exynos Analog to Digital Converter bindings to DT schema
> format using json-schema.
> 
> This is a direct conversion of existing bindings so it also copies the
> existing error in the bindings regarding the requirement of two register
> address ranges for certain compatibles.  The inconsistency in binding
> was caused by commit fafb37cfae6d ("iio: exyno-adc: use syscon for PMU
> register access").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

To my less than experienced eye when it comes to yaml, this looks fine.
I'll wait on more experienced review before I apply it however!

Thanks,

Jonathan

> 
> ---
> 
> Changes since v1:
> 1. Rework reg, clocks and clock-names matching for specific compatibles,
> 2. Make samsung,syscon-phandle required only on certain compatibles,
> 3. Fix indentation.
> ---
>  .../bindings/iio/adc/samsung,exynos-adc.txt   | 107 ------------
>  .../bindings/iio/adc/samsung,exynos-adc.yaml  | 163 ++++++++++++++++++
>  2 files changed, 163 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
> deleted file mode 100644
> index e1fe02f3e3e9..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
> +++ /dev/null
> @@ -1,107 +0,0 @@
> -Samsung Exynos Analog to Digital Converter bindings
> -
> -The devicetree bindings are for the new ADC driver written for
> -Exynos4 and upward SoCs from Samsung.
> -
> -New driver handles the following
> -1. Supports ADC IF found on EXYNOS4412/EXYNOS5250
> -   and future SoCs from Samsung
> -2. Add ADC driver under iio/adc framework
> -3. Also adds the Documentation for device tree bindings
> -
> -Required properties:
> -- compatible:		Must be "samsung,exynos-adc-v1"
> -				for Exynos5250 controllers.
> -			Must be "samsung,exynos-adc-v2" for
> -				future controllers.
> -			Must be "samsung,exynos3250-adc" for
> -				controllers compatible with ADC of Exynos3250.
> -			Must be "samsung,exynos4212-adc" for
> -				controllers compatible with ADC of Exynos4212 and Exynos4412.
> -			Must be "samsung,exynos7-adc" for
> -				the ADC in Exynos7 and compatibles
> -			Must be "samsung,s3c2410-adc" for
> -				the ADC in s3c2410 and compatibles
> -			Must be "samsung,s3c2416-adc" for
> -				the ADC in s3c2416 and compatibles
> -			Must be "samsung,s3c2440-adc" for
> -				the ADC in s3c2440 and compatibles
> -			Must be "samsung,s3c2443-adc" for
> -				the ADC in s3c2443 and compatibles
> -			Must be "samsung,s3c6410-adc" for
> -				the ADC in s3c6410 and compatibles
> -			Must be "samsung,s5pv210-adc" for
> -				the ADC in s5pv210 and compatibles
> -- reg:			List of ADC register address range
> -			- The base address and range of ADC register
> -			- The base address and range of ADC_PHY register (every
> -			  SoC except for s3c24xx/s3c64xx ADC)
> -- interrupts: 		Contains the interrupt information for the timer. The
> -			format is being dependent on which interrupt controller
> -			the Samsung device uses.
> -- #io-channel-cells = <1>; As ADC has multiple outputs
> -- clocks		From common clock bindings: handles to clocks specified
> -			in "clock-names" property, in the same order.
> -- clock-names		From common clock bindings: list of clock input names
> -			used by ADC block:
> -			- "adc" : ADC bus clock
> -			- "sclk" : ADC special clock (only for Exynos3250 and
> -				   compatible ADC block)
> -- vdd-supply		VDD input supply.
> -
> -- samsung,syscon-phandle Contains the PMU system controller node
> -			(To access the ADC_PHY register on Exynos5250/5420/5800/3250)
> -Optional properties:
> -- has-touchscreen:	If present, indicates that a touchscreen is
> -			connected an usable.
> -
> -Note: child nodes can be added for auto probing from device tree.
> -
> -Example: adding device info in dtsi file
> -
> -adc: adc@12d10000 {
> -	compatible = "samsung,exynos-adc-v1";
> -	reg = <0x12D10000 0x100>;
> -	interrupts = <0 106 0>;
> -	#io-channel-cells = <1>;
> -	io-channel-ranges;
> -
> -	clocks = <&clock 303>;
> -	clock-names = "adc";
> -
> -	vdd-supply = <&buck5_reg>;
> -	samsung,syscon-phandle = <&pmu_system_controller>;
> -};
> -
> -Example: adding device info in dtsi file for Exynos3250 with additional sclk
> -
> -adc: adc@126c0000 {
> -	compatible = "samsung,exynos3250-adc", "samsung,exynos-adc-v2;
> -	reg = <0x126C0000 0x100>;
> -	interrupts = <0 137 0>;
> -	#io-channel-cells = <1>;
> -	io-channel-ranges;
> -
> -	clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
> -	clock-names = "adc", "sclk";
> -
> -	vdd-supply = <&buck5_reg>;
> -	samsung,syscon-phandle = <&pmu_system_controller>;
> -};
> -
> -Example: Adding child nodes in dts file
> -
> -adc@12d10000 {
> -
> -	/* NTC thermistor is a hwmon device */
> -	ncp15wb473@0 {
> -		compatible = "murata,ncp15wb473";
> -		pullup-uv = <1800000>;
> -		pullup-ohm = <47000>;
> -		pulldown-ohm = <0>;
> -		io-channels = <&adc 4>;
> -	};
> -};
> -
> -Note: Does not apply to ADC driver under arch/arm/plat-samsung/
> -Note: The child node can be added under the adc node or separately.
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> new file mode 100644
> index 000000000000..dd58121f25b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/samsung,exynos-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos-adc-v1                 # Exynos5250
> +      - samsung,exynos-adc-v2
> +      - samsung,exynos3250-adc
> +      - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
> +      - samsung,exynos7-adc
> +      - samsung,s3c2410-adc
> +      - samsung,s3c2416-adc
> +      - samsung,s3c2440-adc
> +      - samsung,s3c2443-adc
> +      - samsung,s3c6410-adc
> +      - samsung,s5pv210-adc
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    description:
> +      Phandle to ADC bus clock. For Exynos3250 additional clock is needed.
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    description:
> +      Must contain clock names (adc, sclk) matching phandles in clocks
> +      property.
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  vdd-supply:
> +    description: VDD input supply
> +    maxItems: 1
> +
> +  samsung,syscon-phandle:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description:
> +      Phandle to the PMU system controller node (to access the ADC_PHY
> +      register on Exynos5250/5420/5800/3250).
> +
> +  has-touchscreen:
> +    description:
> +      If present, indicates that a touchscreen is connected and usable.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - "#io-channel-cells"
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos-adc-v1
> +              - samsung,exynos-adc-v2
> +              - samsung,exynos3250-adc
> +              - samsung,exynos4212-adc
> +              - samsung,s5pv210-adc
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            # For S5P and Exynos
> +            - description: base registers
> +            - description: phy registers
> +      required:
> +        - samsung,syscon-phandle
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - description: base registers
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos3250-adc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: adc
> +            - const: sclk
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: adc
> +
> +examples:
> +  - |
> +    adc: adc@12d10000 {
> +      compatible = "samsung,exynos-adc-v1";
> +      reg = <0x12d10000 0x100>;
> +      interrupts = <0 106 0>;
> +      #io-channel-cells = <1>;
> +      io-channel-ranges;
> +
> +      clocks = <&clock 303>;
> +      clock-names = "adc";
> +
> +      vdd-supply = <&buck5_reg>;
> +      samsung,syscon-phandle = <&pmu_system_controller>;
> +
> +      /* NTC thermistor is a hwmon device */
> +      ncp15wb473@0 {
> +        compatible = "murata,ncp15wb473";
> +        pullup-uv = <1800000>;
> +        pullup-ohm = <47000>;
> +        pulldown-ohm = <0>;
> +        io-channels = <&adc 4>;
> +      };
> +    };
> +
> +  - |
> +    adc@126c0000 {
> +      compatible = "samsung,exynos3250-adc";
> +      reg = <0x126C0000 0x100>;
> +      interrupts = <0 137 0>;
> +      #io-channel-cells = <1>;
> +      io-channel-ranges;
> +
> +      clocks = <&cmu 0>, // CLK_TSADC
> +               <&cmu 1>; // CLK_SCLK_TSADC
> +      clock-names = "adc", "sclk";
> +
> +      vdd-supply = <&buck5_reg>;
> +      samsung,syscon-phandle = <&pmu_system_controller>;
> +    };

