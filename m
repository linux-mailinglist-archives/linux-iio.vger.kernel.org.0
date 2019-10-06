Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94DCD17B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 12:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJFK5e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 06:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJFK5e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 06:57:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7840A2084D;
        Sun,  6 Oct 2019 10:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570359453;
        bh=n7QM4sLo7An8JpEGyrQcWqrBu9VaS4JLDAsXZTgQJ/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iu+qFbXsokAeEEV5w4Ke2guehbG+TBKw+L9J7JZTXYtocOoS4KJwzPy5PBGjQArIB
         Ia6tyjE+9csNVeShyQXaLuQZcTbcsELWRAty27UrdViK45g6bg80xixlaMMIAhMtrV
         Lbc722PQ/IMkEg4Y4jSUr9S4TZfkymp3FujOufPU=
Date:   Sun, 6 Oct 2019 11:57:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 5/7 v3] mfd: ab8500: augment DT bindings
Message-ID: <20191006115727.7a4175d3@archlinux>
In-Reply-To: <20191001221356.19317-6-linus.walleij@linaro.org>
References: <20191001221356.19317-1-linus.walleij@linaro.org>
        <20191001221356.19317-6-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Oct 2019 00:13:54 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> As we migrate the AB8500 GPADC driver to use IIO, we need to augment
> the bindings to account for defining the ADC channels in the device
> tree.
> 
> Cc: devicetree@vger.kernel.org
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This looks good now as far as our generic channel bindings go.
I'd like to leave it a little longer for Rob or Mark to have the chance
to comment before taking it though.

Good to have these in yaml at some point as well :)
I know we haven't done many of the older IIO bindings yet though
so I can't really talk.

Thanks,

Jonathan

> ---
> ChangeLog v2->v3:
> - Change "adc-channel@" to "channel@" as per preferred notation.
> - Add some full stops to the end of sentences.
> - Reference the new ADC-specific documentation for channel specifier
>   etc.
> - Collect Lee's ACK.
> - Rebased on v5.4-rc1
> ChangeLog v1->v2:
> - Rebased on v5.3-rc5
> ---
>  .../devicetree/bindings/mfd/ab8500.txt        | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
> index cd9e90c5d171..ff517e5d7ee0 100644
> --- a/Documentation/devicetree/bindings/mfd/ab8500.txt
> +++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
> @@ -69,6 +69,18 @@ Required child device properties:
>  - compatible             : "stericsson,ab8500-[bm|btemp|charger|fg|gpadc|gpio|ponkey|
>                                                 pwm|regulator|rtc|sysctrl|usb]";
>  
> +  A few child devices require ADC channels from the GPADC node. Those follow the
> +  standard bindings from iio/iio-bindings.txt and iio/adc/adc.txt
> +
> +  abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
> +			   temperatures.
> +  ab8500_fg		 : io-channel "main_bat_v" for measuring main battery voltage,
> +  ab8500_btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
> +			   battery voltage.
> +  ab8500_charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
> +			   "usb_charger_c" for measuring voltage and current of the
> +			   different charging supplies.
> +
>  Optional child device properties:
>  - interrupts             : contains the device IRQ(s) using the 2-cell format (see above)
>  - interrupt-names        : contains names of IRQ resource in the order in which they were
> @@ -102,8 +114,115 @@ ab8500 {
>                                39 0x4>;
>                  interrupt-names = "HW_CONV_END", "SW_CONV_END";
>                  vddadc-supply = <&ab8500_ldo_tvout_reg>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#io-channel-cells = <1>;
> +
> +		/* GPADC channels */
> +		bat_ctrl: channel@01 {
> +			reg = <0x01>;
> +		};
> +		btemp_ball: channel@02 {
> +			reg = <0x02>;
> +		};
> +		main_charger_v: channel@03 {
> +			reg = <0x03>;
> +		};
> +		acc_detect1: channel@04 {
> +			reg = <0x04>;
> +		};
> +		acc_detect2: channel@05 {
> +			reg = <0x05>;
> +		};
> +		adc_aux1: channel@06 {
> +			reg = <0x06>;
> +		};
> +		adc_aux2: channel@07 {
> +			reg = <0x07>;
> +		};
> +		main_batt_v: channel@08 {
> +			reg = <0x08>;
> +		};
> +		vbus_v: channel@09 {
> +			reg = <0x09>;
> +		};
> +		main_charger_c: channel@0a {
> +			reg = <0x0a>;
> +		};
> +		usb_charger_c: channel@0b {
> +			reg = <0x0b>;
> +		};
> +		bk_bat_v: channel@0c {
> +			reg = <0x0c>;
> +		};
> +		die_temp: channel@0d {
> +			reg = <0x0d>;
> +		};
> +		usb_id: channel@0e {
> +			reg = <0x0e>;
> +		};
> +		xtal_temp: channel@12 {
> +			reg = <0x12>;
> +		};
> +		vbat_true_meas: channel@13 {
> +			reg = <0x13>;
> +		};
> +		bat_ctrl_and_ibat: channel@1c {
> +			reg = <0x1c>;
> +		};
> +		vbat_meas_and_ibat: channel@1d {
> +			reg = <0x1d>;
> +		};
> +		vbat_true_meas_and_ibat: channel@1e {
> +			reg = <0x1e>;
> +		};
> +		bat_temp_and_ibat: channel@1f {
> +			reg = <0x1f>;
> +		};
>          };
>  
> +	ab8500_temp {
> +		compatible = "stericsson,abx500-temp";
> +		io-channels = <&gpadc 0x06>,
> +			      <&gpadc 0x07>;
> +		io-channel-name = "aux1", "aux2";
> +	};
> +
> +	ab8500_battery: ab8500_battery {
> +		stericsson,battery-type = "LIPO";
> +		thermistor-on-batctrl;
> +	};
> +
> +	ab8500_fg {
> +		compatible = "stericsson,ab8500-fg";
> +		battery	   = <&ab8500_battery>;
> +		io-channels = <&gpadc 0x08>;
> +		io-channel-name = "main_bat_v";
> +	};
> +
> +	ab8500_btemp {
> +		compatible = "stericsson,ab8500-btemp";
> +		battery	   = <&ab8500_battery>;
> +		io-channels = <&gpadc 0x02>,
> +			      <&gpadc 0x01>;
> +		io-channel-name = "btemp_ball",
> +				"bat_ctrl";
> +	};
> +
> +	ab8500_charger {
> +		compatible	= "stericsson,ab8500-charger";
> +		battery		= <&ab8500_battery>;
> +		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
> +		io-channels = <&gpadc 0x03>,
> +			      <&gpadc 0x0a>,
> +			      <&gpadc 0x09>,
> +			      <&gpadc 0x0b>;
> +		io-channel-name = "main_charger_v",
> +				"main_charger_c",
> +				"vbus_v",
> +				"usb_charger_c";
> +	};
> +
>          ab8500-usb {
>                  compatible = "stericsson,ab8500-usb";
>                  interrupts = < 90 0x4

