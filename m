Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781E19CBE5
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2019 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfHZIvj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 04:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfHZIvj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Aug 2019 04:51:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4426C20874;
        Mon, 26 Aug 2019 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566809498;
        bh=OE7zjy04MsoDOM5j2Vdm4Uu5Ja0NJXf0MIYywRR9a3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HCIMA+yPdFLi0nYKdXiimHKFuqFGD+aM/qcjLur0hFeWblQbM94FwSynEJs2tMbas
         UDnAX4pW9OxvLBBuc9ZcF6Y8Re02Pz8+4VtsfqWwdnJqkfsz73Rxy262MIpSo36w3C
         sICO1duOCLw+o8Rnvlq/SAfivFmITUUApsEsUgvg=
Date:   Mon, 26 Aug 2019 09:51:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: Re: [PATCH 8/8 v2] ARM: dts: ux500: declare GPADC IIO ADC channels
Message-ID: <20190826095133.0e21c55b@archlinux>
In-Reply-To: <20190822145233.18222-9-linus.walleij@linaro.org>
References: <20190822145233.18222-1-linus.walleij@linaro.org>
        <20190822145233.18222-9-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Aug 2019 16:52:33 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds the IIO channels for the GPADC after converting it
> to using the standard IIO ADC bindings and moving the driver
> over to the IIO subsystem. We also add IIO hwmon standard
> driver node to support reading channels in a standard manner.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I'll ask the 'stupid' question. Doesn't this break compatibility
with old DTs?

One comment inline to do with IIO standardization that occurred in
the meantime.

Thanks,

Jonathan
> ---
> ChangeLog v1->v2:
> - Rebased on v5.3-rc5
> ---
>  arch/arm/boot/dts/ste-dbx5x0.dtsi | 102 +++++++++++++++++++++++++++++-
>  1 file changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> index b1a31134f860..80016521333b 100644
> --- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> @@ -52,6 +52,20 @@
>  		};
>  	};
>  
> +	/* Essential housekeeping hardware monitors */
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&gpadc 0x02>, /* Battery temperature */
> +			    <&gpadc 0x03>, /* Main charger voltage */
> +			    <&gpadc 0x08>, /* Main battery voltage */
> +			    <&gpadc 0x09>, /* VBUS */
> +			    <&gpadc 0x0a>, /* Main charger current */
> +			    <&gpadc 0x0b>, /* USB charger current *
> +			    <&gpadc 0x0c>, /* Backup battery voltage */
> +			    <&gpadc 0x0d>, /* Die temperature */
> +			    <&gpadc 0x12>; /* Crystal temperature */
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -623,12 +637,84 @@
>  					interrupt-names = "60S", "ALARM";
>  				};
>  
> -				ab8500-gpadc {
> +				gpadc: ab8500-gpadc {
>  					compatible = "stericsson,ab8500-gpadc";
>  					interrupts = <32 IRQ_TYPE_LEVEL_HIGH
>  						      39 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-names = "HW_CONV_END", "SW_CONV_END";
>  					vddadc-supply = <&ab8500_ldo_tvout_reg>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#io-channel-cells = <1>;
> +
> +					/* GPADC channels */
> +					bat_ctrl: adc-channel@01 {
> +						reg = <0x01>;

We standardised recently on just channel@01 etc
Curiously we didn't document a reg value for that in the shared doc
but we have used them in drivers so that is fine.

> +					};
> +					btemp_ball: adc-channel@02 {
> +						reg = <0x02>;
> +					};
> +					main_charger_v: adc-channel@03 {
> +						reg = <0x03>;
> +					};
> +					acc_detect1: adc-channel@04 {
> +						reg = <0x04>;
> +					};
> +					acc_detect2: adc-channel@05 {
> +						reg = <0x05>;
> +					};
> +					adc_aux1: adc-channel@06 {
> +						reg = <0x06>;
> +					};
> +					adc_aux2: adc-channel@07 {
> +						reg = <0x07>;
> +					};
> +					main_batt_v: adc-channel@08 {
> +						reg = <0x08>;
> +					};
> +					vbus_v: adc-channel@09 {
> +						reg = <0x09>;
> +					};
> +					main_charger_c: adc-channel@0a {
> +						reg = <0x0a>;
> +					};
> +					usb_charger_c: adc-channel@0b {
> +						reg = <0x0b>;
> +					};
> +					bk_bat_v: adc-channel@0c {
> +						reg = <0x0c>;
> +					};
> +					die_temp: adc-channel@0d {
> +						reg = <0x0d>;
> +					};
> +					usb_id: adc-channel@0e {
> +						reg = <0x0e>;
> +					};
> +					xtal_temp: adc-channel@12 {
> +						reg = <0x12>;
> +					};
> +					vbat_true_meas: adc-channel@13 {
> +						reg = <0x13>;
> +					};
> +					bat_ctrl_and_ibat: adc-channel@1c {
> +						reg = <0x1c>;
> +					};
> +					vbat_meas_and_ibat: adc-channel@1d {
> +						reg = <0x1d>;
> +					};
> +					vbat_true_meas_and_ibat: adc-channel@1e {
> +						reg = <0x1e>;
> +					};
> +					bat_temp_and_ibat: adc-channel@1f {
> +						reg = <0x1f>;
> +					};
> +				};
> +
> +				ab8500_temp {
> +					compatible = "stericsson,abx500-temp";
> +					io-channels = <&gpadc 0x06>,
> +						      <&gpadc 0x07>;
> +					io-channel-name = "aux1", "aux2";
>  				};
>  
>  				ab8500_battery: ab8500_battery {
> @@ -639,17 +725,31 @@
>  				ab8500_fg {
>  					compatible = "stericsson,ab8500-fg";
>  					battery	   = <&ab8500_battery>;
> +					io-channels = <&gpadc 0x08>;
> +					io-channel-name = "main_bat_v";
>  				};
>  
>  				ab8500_btemp {
>  					compatible = "stericsson,ab8500-btemp";
>  					battery	   = <&ab8500_battery>;
> +					io-channels = <&gpadc 0x02>,
> +						      <&gpadc 0x01>;
> +					io-channel-name = "btemp_ball",
> +							"bat_ctrl";
>  				};
>  
>  				ab8500_charger {
>  					compatible	= "stericsson,ab8500-charger";
>  					battery		= <&ab8500_battery>;
>  					vddadc-supply	= <&ab8500_ldo_tvout_reg>;
> +					io-channels = <&gpadc 0x03>,
> +						      <&gpadc 0x0a>,
> +						      <&gpadc 0x09>,
> +						      <&gpadc 0x0b>;
> +					io-channel-name = "main_charger_v",
> +							"main_charger_c",
> +							"vbus_v",
> +							"usb_charger_c";
>  				};
>  
>  				ab8500_chargalg {

