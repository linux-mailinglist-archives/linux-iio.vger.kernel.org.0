Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0D7CC84B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjJQQEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjJQQET (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 12:04:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844BEF2
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 09:04:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so2808533e87.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697558655; x=1698163455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1veKZLSVEBpGrCzXTq67yliRFwy0jPQ/mJLEVbdN9Q=;
        b=qusvTpY2sZydRjDoEc/NBTPEcGJ9jNcT/d+i2gs/2bynDEOXT4ske//Ft7od2B9+b3
         GflMb+0obccU3LYgsUZZv71ztCFfmy6ZS4TxrZLjIG8fXRPnWb7Cw3GzFtwX3KOJFTBU
         ly+tqHrUFfmP3KdK42b5ioO6tpdAkeTGI+wGJfdbvLtbpZM2e3Aw4Iv+aUirPJ3pgErN
         JH/O0a1MRZ68EezWLP3Iy5o9qXNgncPBViOVXtsq/uxGIGy9ZbnwAp1SghSUylHmU12F
         4vuGGUzjQkqXz8Moh/PmSn6dJhGo49TM3cXIqbLLqMmJQr5zNV4I06JV3g3xdw9fl6MR
         lroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558655; x=1698163455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1veKZLSVEBpGrCzXTq67yliRFwy0jPQ/mJLEVbdN9Q=;
        b=LGhbJ07CBCOLX11ga06r7wiIYLdRYMdX2vmWjcdSD1Zt/DjIMjvTFtw9rH91Esz6ZF
         A1WjqP848F772GtDVynv/1P8dVjsDiDqAv50LqXLPfCatYG/69Sf7WsAzDq7bRR2KfBm
         a1xTrzkwJvzrNWvMUiqntNBVeNKe+bOJXckgzAKTMTWx43CxbyMwQNHZ2umoJOkqfLUT
         EfUIbX5C6PO6gad/oB4iQf7XwzjyoRG+DdK1mFCLr2E69TafD3vpBTnVi3JV5aD/igtH
         cNWmhk63jvkWjeYkjv7Afu+4O8oSF3KfjDW8CKnoI+VTUq8YiPkWi7Dz35n9R4QH0ZZQ
         XP1g==
X-Gm-Message-State: AOJu0YyI1XM0lT9FSEaYjIOR/hkH1pUtziZbquvLiw0pzwauaywgJ+mF
        XN9bmmpYscPa03LLXpCGwGs6gA==
X-Google-Smtp-Source: AGHT+IFJYOwryDhZu4dJ2SmDAPhGp6d4B8Hxykl0HqjihjlL+gs2v84i9HOtlm4P9yv7vHe3+YyIMw==
X-Received: by 2002:a05:6512:312b:b0:503:385c:4319 with SMTP id p11-20020a056512312b00b00503385c4319mr2203745lfd.19.1697558654490;
        Tue, 17 Oct 2023 09:04:14 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w26-20020ac2443a000000b005030c533843sm329505lfl.154.2023.10.17.09.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:04:14 -0700 (PDT)
Message-ID: <577e5ddd-0a04-4497-ae2e-4f9a1e8fec19@linaro.org>
Date:   Tue, 17 Oct 2023 18:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8350-lemonade(p): new devices
Content-Language: en-US
To:     Nia Espera <nespera@igalia.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
 <20231016-nia-sm8350-for-upstream-v1-5-bb557a0af2e9@igalia.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231016-nia-sm8350-for-upstream-v1-5-bb557a0af2e9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/16/23 14:47, Nia Espera wrote:
> Device tree files for OnePlus 9 and 9 Pro. Details of supported features
> mentioned in the cover letter for this patch series, but for
> accessibility also repeated here:
> 
> - USB OTG
> - UFS
> - Framebuffer display
> - Touchscreen (for lemonade)
> - Power & volume down keys
> - Battery reading
> - Modem, IPA, and remoteproc bringup
> 
> Steps to get booting:
> 
> - Wipe dtbo partition
> - Flash vbmeta with disabled verity bit
> - Flash kernel and initfs to boot partition with CLI args pd_ignore_unused
> and clk_ignore_unused
> - Flash rootfs to some other partition (probably super or userdata)
> 
> Signed-off-by: Nia Espera <nespera@igalia.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile                  |    2 +
>   .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1247 ++++++++++++++++++++
>   .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   82 ++
>   .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   37 +
>   4 files changed, 1368 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2cca20563a1d..369ad4721b29 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -211,6 +211,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-csot.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-oneplus-lemonade.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-oneplus-lemonadep.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
> new file mode 100644
> index 000000000000..2f6768f35259
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
> @@ -0,0 +1,1247 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Caleb Connolly <caleb.connolly@linaro.org>
> + *
> + * Copyright (c) 2023 Igalia S.L.
> + * Authors:
> + *	Nia Espera <nespera@igalia.com>
> + */
> +
> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
> +#define SMB139x_1_SID 0x0b
> +#define SMB139x_2_SID 0x0c
> +#include <dt-bindings/iio/qcom,spmi-adc7-smb139x.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8350.dtsi"
> +#include "pm8350.dtsi"
> +#include "pm8350b.dtsi"
> +#include "pm8350c.dtsi"
> +#include "pmk8350.dtsi"
> +#include "pmr735a.dtsi"
> +#include "pmr735b.dtsi"
> +
> +/ {
> +	/* As with the Sony devices, msm-id and board-id aren't needed here */
This became "common knowledge" since then, we can omit the comment now.

> +	chassis-type = "handset";
> +	interrupt-parent = <&intc>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer: framebuffer@e4d00000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0xe4d00000 0 0x2400000>;
> +			width = <1080>;
> +			height = <2412>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +			/*
> +			 * That's (going to be) a lot of clocks, but it's
> +			 * necessary due to unused clk cleanup & no panel
> +			 * driver yet.
> +			 */
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +				 <&gcc GCC_DISP_SF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_down_n>;
> +
> +		key-vol-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pmk8350_gpios 6 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	bat: battery {
> +		compatible = "simple-battery";
> +		device-chemistry = "lithium-ion";
> +		voltage-min-design-microvolt = <3200000>;
> +		energy-full-design-microwatt-hours = <15840000>;
> +		charge-full-design-microamp-hours = <2225000>;
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	display_panel_avdd: display_regulator@1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "display_panel_avdd";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		regulator-enable-ramp-delay = <233>;
> +
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +
> +	/*
> +	 * Hack; OP9 bootloader specifically checks that the timer node has
> +	 * this label.
> +	 */
> +	arch_timer: timer {};
> +};
> +
> +&reserved_memory {
> +	/* EFI splash screen */
> +	memory@e1000000 {
framebuffer@e10...

> +		reg = <0 0xe4d00000 0 0x02400000>;
> +		no-map;
> +		label = "cont_splash_region";
This label is unnecessary (perhaps even unused?)

> +	};
> +
> +	ramoops: ramoops@E9700000 {
> +		compatible = "ramoops";
> +		reg = <0 0xe9700000 0 0x05b8000>;
> +		record-size =	<0x40000>;
> +		console-size =	<0x40000>;
> +		ftrace-size =	<0x200000>;
> +		pmsg-size =	<0x200000>;
> +		devinfo-size =	<0x08000>;
> +		dumpinfo-size =	<0x08000>;
> +		rsv01info-size=	<0x08000>;
> +		rsv02info-size=	<0x08000>;
> +		rsv03info-size=	<0x08000>;
> +		rsv04info-size=	<0x08000>;
> +		rsv05info-size=	<0x08000>;
> +		ecc-size=	<0x0>;
Please use a single space before and after the '=' sign.
Please drop the unused-and-undocumented properties (make CHECK_DTBS=1 
qcom/sm8350-oneplus-lemonade.dtb)

> +	};
> +
> +	/* bootloader log buffer */
> +	memory@9fff7000 {
bootloader-log@, drop comment

> +		reg = <0x00 0x9fff7000 0x00 0x8000>;
please be consistent with the usage of "different zeroes"

> +	};
> +
> +	/* unknown; "param_mem" downstream */
> +	memory@ea700000 {
reserved@, drop comment, probably it's for the kernel command line 
parameters in some hacky setup, but if so, it would be freed the moment
Linux is jumped to.

[...]

> +
> +	/* regulators-2 unused for now */
Any good reason?

> +
> +	regulators-3 {
> +		compatible = "qcom,pmr735a-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +
> +		vdd-l1-l2-supply = <&pmr735a_s2>;
> +		vdd-l3-supply = <&pmr735a_s1>;
> +		vdd-l4-supply = <&pm8350c_s1>;
> +		vdd-l5-l6-supply = <&pm8350c_s1>;
> +		vdd-l7-bob-supply = <&vreg_bob>;
> +
> +		pmr735a_s1: smps1 {
> +			regulator-name = "pmr735a_s1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1280000>;
> +		};
> +
> +		pmr735a_s2: smps2 {
> +			regulator-name = "pmr735a_s2";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		pmr735a_s3: smps3 {
> +			regulator-name = "pmr735a_s3";
> +			regulator-min-microvolt = <2208000>;
> +			regulator-max-microvolt = <2352000>;
> +		};
> +
> +		pmr735a_l1: ldo1 {
> +			regulator-name = "pmr735a_l1";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +		};
> +
> +		pmr735a_l2: ldo2 {
> +			regulator-name = "pmr735a_l2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pmr735a_l3: ldo3 {
> +			regulator-name = "pmr735a_l3";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pmr735a_l4: ldo4 {
> +			regulator-name = "pmr735a_l4";
> +			regulator-min-microvolt = <1776000>;
> +			regulator-max-microvolt = <1872000>;
> +		};
> +
> +		pmr735a_l5: ldo5 {
> +			regulator-name = "pmr735a_l5";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <800000>;
> +		};
> +
> +		pmr735a_l6: ldo6 {
> +			regulator-name = "pmr735a_l6";
> +			regulator-min-microvolt = <480000>;
> +			regulator-max-microvolt = <904000>;
> +		};
> +
> +		pmr735a_l7: ldo7 {
> +			regulator-name = "pmr735a_l7";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +	};
> +};
> +
> +&adsp {
> +	firmware-name = "qcom/OnePlus/lemonade/adsp.mbn";
> +	status = "okay";
> +};
> +
> +&cdsp {
> +	firmware-name = "qcom/OnePlus/lemonade/cdsp.mbn";
> +	status = "okay";
> +};
> +
> +&slpi {
> +	firmware-name = "qcom/OnePlus/lemonade/slpi.mbn";
> +	status = "okay";
> +};
> +
> +&ipa {
> +	qcom,gsi-loader = "self";
> +	memory-region = <&pil_ipa_fw_mem>;
> +	firmware-name = "qcom/OnePlus/lemonade/ipa_fws.mbn";
> +	status = "okay";
> +};
> +
> +&mpss {
> +	firmware-name = "qcom/OnePlus/lemonade/modem.mbn",
> +			"qcom/OnePlus/lemonade/mcfg_hw.mbn";
> +
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Touchscreens: Syna TCM oncell or Samsung s6sy761 */
Synaptics with a samsung panel? Are you sure it's not a reference device 
dt leftover?

[...]

> +&pm8350_gpios {
> +	usb2_vbus_boost_default: usb2_vbus_boost_default {
No underscores in node names, use '-', all throughout the file.


> +		pins = "gpio8";
> +		function = "normal";
> +		output-low;
> +		power-source = <0x00>; > +		phandle = <0x5e1>;
Please drop the decompiler-generated phandle= properties

[...]

> +	sde_dsi_active: sde-dsi-active {
> +		pins = "gpio24";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable = <0>;
This is a boolean property, should be "bias-disable;"

[...]

> +&usb_1 {
> +	/* Bug in interconnect driver breaks USB */
> +	/delete-property/ interconnects;
> +	/delete-property/ interconnect-names;
Can you elaborate?

> +
> +	/*
> +	 * USB3 is not tested (though it is enabled downstream) so limit to
> +	 * high-speed for now.
> +	 */
> +	qcom,select-utmi-as-pipe-clk;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	/* Mode switching is untested */
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	phys = <&usb_1_hsphy>;
> +	phy-names = "usb2-phy";
> +};
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&pm8350_l5>;
> +	vdda18-supply = <&pm8350c_l1>;
> +	vdda33-supply = <&pm8350_l2>;
> +
> +	status = "okay";
> +};
> +
> +/* Enabling this is necessary only for displayport */
If DP is wired up, I would strongly guess that USB3 is too.

> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&pm8350_l6>;
> +	vdda-pll-supply = <&pm8350_l1>;
> +
> +	status = "okay";
> +};
> +
> +&i2c2 {
Please sort the node references alphabetically

> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	bq27541: fuel-gauge@55 {
> +		compatible = "ti,bq27541";
> +		reg = <0x55>;
> +		monitored-battery = <&bat>;
> +	};
> +};
> +/* Crypto drivers currently fail & cause an XPU violation */
No need, see commit 4d29db2043610dd70be00a61f26fd64256a2a6c5
[...]

> +	/* Modem antenna pins exclusive to lemonade */
> +	rf_cable_ant1_active: rf_cable_ant1_active {
> +		pins = "gpio27";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +	rf_cable_ant2_active: rf_cable_ant2_active {
Please add a newline between subnodes

Konrad
