Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24F3FF6FD
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 00:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbhIBWSa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 18:18:30 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50135 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbhIBWS3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 18:18:29 -0400
X-Greylist: delayed 35517 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 18:18:28 EDT
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7C2B1C0005;
        Thu,  2 Sep 2021 22:17:26 +0000 (UTC)
Date:   Fri, 3 Sep 2021 00:17:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 45/46] ARM: dts: am43xx: Describe the magnetic
 reader/ADC1 hardware module
Message-ID: <20210903001725.59833f05@xps13>
In-Reply-To: <20210902215144.507243-46-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-46-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu,  2 Sep 2021
23:51:43 +0200:

> This hardware module is close to the am33xx ADC module but instead of
> featuring a touchscreen it has a magnetic reader capability.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  arch/arm/boot/dts/am437x-l4.dtsi     | 31 ++++++++++++++++++++++++++--
>  arch/arm/boot/dts/am43xx-clocks.dtsi |  7 +++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
> index 370c4e64676f..7a3dcfc7bfc9 100644
> --- a/arch/arm/boot/dts/am437x-l4.dtsi
> +++ b/arch/arm/boot/dts/am437x-l4.dtsi
> @@ -2350,11 +2350,38 @@ hdq: hdq@0 {
>  		};
>  
>  		target-module@4c000 {			/* 0x4834c000, ap 114 72.0 */
> -			compatible = "ti,sysc";
> -			status = "disabled";
> +			compatible = "ti,sysc-omap4", "ti,sysc";
> +			reg = <0x4c000 0x4>,
> +			      <0x4c010 0x4>;
> +			reg-names = "rev", "sysc";
> +			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> +					<SYSC_IDLE_NO>,
> +					<SYSC_IDLE_SMART>;
> +			clocks = <&l3s_clkctrl AM4_L3S_ADC1_CLKCTRL 0>;
> +			clock-names = "fck";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x0 0x4c000 0x2000>;
> +
> +			magadc: magadc@0 {
> +				compatible = "ti,am4372-magadc";
> +				reg = <0x0 0x2000>;
> +				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&adc_mag_fck>;
> +				clock-names = "fck";
> +				dmas = <&edma 54 0>, <&edma 55 0>;;

Small typo here, should have a single ';'.
As the series is fairly long, we will see if there is a need to resend
it or not.

> +				dma-names = "fifo0", "fifo1";
> +				status = "disabled";
> +
> +				mag {
> +					compatible = "ti,am4372-mag";
> +				};
> +
> +				adc {
> +					#io-channel-cells = <1>;
> +					compatible ="ti,am4372-adc";
> +				};
> +			};
>  		};
>  
>  		target-module@80000 {			/* 0x48380000, ap 123 42.0 */
> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
> index c726cd8dbdf1..59b1f592a743 100644
> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
> @@ -444,6 +444,13 @@ wdt1_fck: wdt1_fck@422c {
>  		reg = <0x422c>;
>  	};
>  
> +	adc_mag_fck: adc_mag_fck@424c {
> +		#clock-cells = <0>;
> +		compatible = "ti,mux-clock";
> +		clocks = <&sys_clkin_ck>, <&dpll_per_m2_ck>;
> +		reg = <0x424c>;
> +	};
> +
>  	l3_gclk: l3_gclk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-factor-clock";

Thanks,
Miquèl
