Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF67C7CB560
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 23:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjJPVmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 17:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 17:42:13 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2CAA1;
        Mon, 16 Oct 2023 14:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DhJ136nE4Gqh+NkSzscm9jdsp2eoLvdRgD+KzFiQiBs=; b=CXZWtf3wdok8QOYi+Qim0P3c7V
        LopSsd49a163a9h4abVGeJohUnaJtMGa9GtgyJsRgNIayo++yg7q/vYVJaiMEKoF8c6fTzk6fcVug
        o0HfAXiE7PifcCNPNl1aSJfFBYMjT83bWwXm8rTIcb1OLtHYhGvtEN55i+f6Tmkqj98DwsSUUlOsQ
        ivGSKsWoHlKPVPXAz2aK3VSJAWZC2V8JlDlB/wW+gWr2LgzudLPGTwGnI0yKLQVBY1hlEwpV4Q/eS
        ecfqo/hISYnYanttEa+dsvZcmSx7AbbDD9N1mXHDl3Kos2pNJTBD4my0ZWpt0igTOaUbnvR1EZM5M
        a3lzBgRg==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qsVLS-001EZn-AI; Mon, 16 Oct 2023 23:41:50 +0200
Message-ID: <49850e9c-5307-489f-9587-f016188bb59a@igalia.com>
Date:   Mon, 16 Oct 2023 23:41:45 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8350-lemonade(p): new devices
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <CW9WUOLK18R1.2HI2MM4P47HPV@fairphone.com>
From:   Nia Espera <nespera@igalia.com>
Autocrypt: addr=nespera@igalia.com; keydata=
 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
 T+I7o407lOB8a/PJA2YXM4VVC/iyMBM=
In-Reply-To: <CW9WUOLK18R1.2HI2MM4P47HPV@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 10/16/23 15:50, Luca Weiss wrote:
> Hi Nia,
> 
> On Mon Oct 16, 2023 at 2:47 PM CEST, Nia Espera wrote:
>> Device tree files for OnePlus 9 and 9 Pro. Details of supported features
>> mentioned in the cover letter for this patch series, but for
>> accessibility also repeated here:
>>
>> - USB OTG
>> - UFS
>> - Framebuffer display
>> - Touchscreen (for lemonade)
>> - Power & volume down keys
>> - Battery reading
>> - Modem, IPA, and remoteproc bringup
>>
>> Steps to get booting:
>>
>> - Wipe dtbo partition
>> - Flash vbmeta with disabled verity bit
>> - Flash kernel and initfs to boot partition with CLI args pd_ignore_unused
>> and clk_ignore_unused
>> - Flash rootfs to some other partition (probably super or userdata)
>>
>> Signed-off-by: Nia Espera <nespera@igalia.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile                  |    2 +
>>   .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1247 ++++++++++++++++++++
>>   .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   82 ++
>>   .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   37 +
>>   4 files changed, 1368 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 2cca20563a1d..369ad4721b29 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -211,6 +211,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-csot.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-oneplus-lemonade.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-oneplus-lemonadep.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
>> new file mode 100644
>> index 000000000000..2f6768f35259
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
>> @@ -0,0 +1,1247 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Caleb Connolly <caleb.connolly@linaro.org>
>> + *
>> + * Copyright (c) 2023 Igalia S.L.
>> + * Authors:
>> + *	Nia Espera <nespera@igalia.com>
>> + */
>> +
>> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
>> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
>> +#define SMB139x_1_SID 0x0b
>> +#define SMB139x_2_SID 0x0c
>> +#include <dt-bindings/iio/qcom,spmi-adc7-smb139x.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "sm8350.dtsi"
>> +#include "pm8350.dtsi"
>> +#include "pm8350b.dtsi"
>> +#include "pm8350c.dtsi"
>> +#include "pmk8350.dtsi"
>> +#include "pmr735a.dtsi"
>> +#include "pmr735b.dtsi"
>> +
>> +/ {
>> +	/* As with the Sony devices, msm-id and board-id aren't needed here */
>> +	chassis-type = "handset";
>> +	interrupt-parent = <&intc>;
>> +
>> +	chosen {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		framebuffer: framebuffer@e4d00000 {
>> +			compatible = "simple-framebuffer";
>> +			reg = <0 0xe4d00000 0 0x2400000>;
>> +			width = <1080>;
>> +			height = <2412>;
>> +			stride = <(1080 * 4)>;
>> +			format = "a8r8g8b8";
>> +			/*
>> +			 * That's (going to be) a lot of clocks, but it's
>> +			 * necessary due to unused clk cleanup & no panel
>> +			 * driver yet.
>> +			 */
>> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
>> +				 <&gcc GCC_DISP_SF_AXI_CLK>;
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vol_down_n>;
>> +
>> +		key-vol-up {
>> +			label = "Volume Up";
>> +			linux,code = <KEY_VOLUMEUP>;
>> +			gpios = <&pmk8350_gpios 6 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <15>;
>> +			linux,can-disable;
>> +			wakeup-source;
>> +		};
>> +	};
>> +
>> +	bat: battery {
>> +		compatible = "simple-battery";
>> +		device-chemistry = "lithium-ion";
>> +		voltage-min-design-microvolt = <3200000>;
>> +		energy-full-design-microwatt-hours = <15840000>;
>> +		charge-full-design-microamp-hours = <2225000>;
>> +	};
>> +
>> +	vph_pwr: vph-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vph_pwr";
>> +		regulator-min-microvolt = <3700000>;
>> +		regulator-max-microvolt = <3700000>;
>> +
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	display_panel_avdd: display_regulator@1 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "display_panel_avdd";
>> +		regulator-min-microvolt = <5500000>;
>> +		regulator-max-microvolt = <5500000>;
>> +		regulator-enable-ramp-delay = <233>;
>> +
>> +		enable-active-high;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	/*
>> +	 * Hack; OP9 bootloader specifically checks that the timer node has
>> +	 * this label.
>> +	 */
>> +	arch_timer: timer {};
>> +};
>> +
>> +&reserved_memory {
>> +	/* EFI splash screen */
>> +	memory@e1000000 {
> 
> Don't use memory@ names, this was decided a while ago to not be correct.
> I think other devices here use e.g. splash@[..] or something.

Noted, okay.

> 
>> +		reg = <0 0xe4d00000 0 0x02400000>;
>> +		no-map;
>> +		label = "cont_splash_region";
>> +	};
>> +
>> +	ramoops: ramoops@E9700000 {
>> +		compatible = "ramoops";
>> +		reg = <0 0xe9700000 0 0x05b8000>;
>> +		record-size =	<0x40000>;
>> +		console-size =	<0x40000>;
>> +		ftrace-size =	<0x200000>;
>> +		pmsg-size =	<0x200000>;
>> +		devinfo-size =	<0x08000>;
>> +		dumpinfo-size =	<0x08000>;
>> +		rsv01info-size=	<0x08000>;
>> +		rsv02info-size=	<0x08000>;
>> +		rsv03info-size=	<0x08000>;
>> +		rsv04info-size=	<0x08000>;
>> +		rsv05info-size=	<0x08000>;
>> +		ecc-size=	<0x0>;
> 
> Half of these flags don't exist. Did you run dtbs_check? Also
> indentation normally doesn't get padded out in mainline, just do e.g.
> record-size = <0x40000>; without the tab.
> 

Mea culpa. Will fix, and run a check.

>> +	};
>> +
>> +	/* bootloader log buffer */
>> +	memory@9fff7000 {
>> +		reg = <0x00 0x9fff7000 0x00 0x8000>;
>> +	};
>> +
>> +	/* unknown; "param_mem" downstream */
>> +	memory@ea700000 {
>> +		reg = <0x00 0xea700000 0x00 0x800000>;
>> +	};
>> +};
>> +
>> +&apps_rsc {
>> +	regulators-0 {
>> +		compatible = "qcom,pm8350-rpmh-regulators";
>> +		qcom,pmic-id = "b";
>> +
>> +		vdd-s1-supply = <&vph_pwr>;
>> +		vdd-s2-supply = <&vph_pwr>;
>> +		vdd-s3-supply = <&vph_pwr>;
>> +		vdd-s4-supply = <&vph_pwr>;
>> +		vdd-s5-supply = <&vph_pwr>;
>> +		vdd-s6-supply = <&vph_pwr>;
>> +		vdd-s7-supply = <&vph_pwr>;
>> +		vdd-s8-supply = <&vph_pwr>;
>> +		vdd-s9-supply = <&vph_pwr>;
>> +		vdd-s10-supply = <&vph_pwr>;
>> +		vdd-s11-supply = <&vph_pwr>;
>> +		vdd-s12-supply = <&vph_pwr>;
>> +
>> +		vdd-l1-l4-supply = <&pm8350_s11>;
>> +		vdd-l2-l7-supply = <&vreg_bob>;
>> +		vdd-l3-l5-supply = <&vreg_bob>;
>> +		vdd-l6-l9-l10-supply = <&pm8350_s11>;
>> +		vdd-l8-supply = <&pmr735a_s2>;
>> +
>> +		/*
>> +		 * ARC regulators:
>> +		 * S5 - mx.lvl
>> +		 * S6 - gfx.lvl
>> +		 * S9 - mxc.lvl
>> +		 */
>> +
>> +		pm8350_s10: smps10 {
>> +			regulator-name = "pm8350_s10";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350_s11: smps11 {
>> +			regulator-name = "pm8350_s11";
>> +			regulator-min-microvolt = <752000>;
>> +			regulator-max-microvolt = <1012000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350_s12: smps12 {
>> +			regulator-name = "pm8350_s12";
>> +			regulator-min-microvolt = <1224000>;
>> +			regulator-max-microvolt = <1360000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350_l1: ldo1 {
>> +			regulator-name = "pm8350_l1";
>> +			regulator-min-microvolt = <912000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350_l2: ldo2 {
>> +			regulator-name = "pm8350_l2";
>> +			regulator-min-microvolt = <3072000>;
>> +			regulator-max-microvolt = <3072000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350_l3: ldo3 {
>> +			regulator-name = "pm8350_l3";
>> +			regulator-min-microvolt = <904000>;
>> +			regulator-max-microvolt = <904000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		/* L4 - lmx.lvl (ARC) */
>> +
>> +		pm8350_l5: ldo5 {
>> +			regulator-name = "pm8350_l5";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <888000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350_l6: ldo6 {
>> +			regulator-name = "pm8350_l6";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1208000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350_l7: ldo7 {
>> +			regulator-name = "pm8350_l7";
>> +			regulator-min-microvolt = <2400000>;
>> +			regulator-max-microvolt = <3008000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		/* L8 - lcx.lvl (ARC) */
>> +
>> +		pm8350_l9: ldo9 {
>> +			regulator-name = "pm8350_l9";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	regulators-1 {
>> +		compatible = "qcom,pm8350c-rpmh-regulators";
>> +		qcom,pmic-id = "c";
>> +
>> +		vdd-s1-supply = <&vph_pwr>;
>> +		vdd-s2-supply = <&vph_pwr>;
>> +		vdd-s3-supply = <&vph_pwr>;
>> +		vdd-s4-supply = <&vph_pwr>;
>> +		vdd-s5-supply = <&vph_pwr>;
>> +		vdd-s6-supply = <&vph_pwr>;
>> +		vdd-s7-supply = <&vph_pwr>;
>> +		vdd-s8-supply = <&vph_pwr>;
>> +		vdd-s9-supply = <&vph_pwr>;
>> +		vdd-s10-supply = <&vph_pwr>;
>> +
>> +		vdd-l1-l12-supply = <&pm8350c_s1>;
>> +		vdd-l2-l8-supply = <&pm8350c_s1>;
>> +		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
>> +		vdd-l6-l9-l11-supply = <&vreg_bob>;
>> +		vdd-l10-supply = <&pm8350_s12>;
>> +
>> +		vdd-bob-supply = <&vph_pwr>;
>> +
>> +		pm8350c_s1: smps1 {
>> +			regulator-name = "pm8350c_s1";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1952000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		/* S2 - ebi.lvl (ARC) */
>> +
>> +		pm8350c_s3: smps3 {
>> +			regulator-name = "pm8350c_s3";
>> +			regulator-min-microvolt = <300000>;
>> +			regulator-max-microvolt = <704000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		/*
>> +		 * ARC regulators:
>> +		 * S4 - mss.lvl
>> +		 * S6 - cx.lvl
>> +		 * S8 - mmcx.lvl
>> +		 */
>> +
>> +		pm8350c_s10: smps10 {
>> +			regulator-name = "pm8350c_s10";
>> +			regulator-min-microvolt = <1048000>;
>> +			regulator-max-microvolt = <1128000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l1: ldo1 {
>> +			regulator-name = "pm8350c_l1";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l2: ldo2 {
>> +			regulator-name = "pm8350c_l2";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l3: ldo3 {
>> +			regulator-name = "pm8350c_l3";
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l4: ldo4 {
>> +			regulator-name = "pm8350c_l4";
>> +			regulator-min-microvolt = <1704000>;
>> +			regulator-max-microvolt = <3000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l5: ldo5 {
>> +			regulator-name = "pm8350c_l5";
>> +			regulator-min-microvolt = <1704000>;
>> +			regulator-max-microvolt = <3000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l6: ldo6 {
>> +			regulator-name = "pm8350c_l6";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <2960000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l7: ldo7 {
>> +			regulator-name = "pm8350c_l7";
>> +			regulator-min-microvolt = <3008000>;
>> +			regulator-max-microvolt = <3008000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l8: ldo8 {
>> +			regulator-name = "pm8350c_l8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l9: ldo9 {
>> +			regulator-name = "pm8350c_l9";
>> +			regulator-min-microvolt = <2800000>;
>> +			regulator-max-microvolt = <3008000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l10: ldo10 {
>> +			regulator-name = "pm8350c_l10";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l11: ldo11 {
>> +			regulator-name = "pm8350c_l11";
>> +			regulator-min-microvolt = <2400000>;
>> +			regulator-max-microvolt = <3008000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l12: ldo12 {
>> +			regulator-name = "pm8350c_l12";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <2000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		pm8350c_l13: ldo13 {
>> +			regulator-name = "pm8350c_l13";
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_bob: bob {
>> +			regulator-name = "vreg_bob";
>> +			regulator-min-microvolt = <3400000>;
>> +			regulator-max-microvolt = <3960000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
>> +		};
>> +	};
>> +
>> +	/* regulators-2 unused for now */
> 
> Is there some PMIC that will be here? Since it's just numbered I also
> don't see a problem renaming regulators-2 to regulators-3 if anything
> was added later here.
> 

Yep, pm8350b; no driver exists for it upstream and it's a single 
regulator that isn't particularly important (cannot find any references 
to it downstream, at least). I'll renumber the others.

>> +
>> +	regulators-3 {
>> +		compatible = "qcom,pmr735a-rpmh-regulators";
>> +		qcom,pmic-id = "e";
>> +
>> +		vdd-s1-supply = <&vph_pwr>;
>> +		vdd-s2-supply = <&vph_pwr>;
>> +		vdd-s3-supply = <&vph_pwr>;
>> +
>> +		vdd-l1-l2-supply = <&pmr735a_s2>;
>> +		vdd-l3-supply = <&pmr735a_s1>;
>> +		vdd-l4-supply = <&pm8350c_s1>;
>> +		vdd-l5-l6-supply = <&pm8350c_s1>;
>> +		vdd-l7-bob-supply = <&vreg_bob>;
>> +
>> +		pmr735a_s1: smps1 {
>> +			regulator-name = "pmr735a_s1";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1280000>;
>> +		};
>> +
>> +		pmr735a_s2: smps2 {
>> +			regulator-name = "pmr735a_s2";
>> +			regulator-min-microvolt = <500000>;
>> +			regulator-max-microvolt = <976000>;
>> +		};
>> +
>> +		pmr735a_s3: smps3 {
>> +			regulator-name = "pmr735a_s3";
>> +			regulator-min-microvolt = <2208000>;
>> +			regulator-max-microvolt = <2352000>;
>> +		};
>> +
>> +		pmr735a_l1: ldo1 {
>> +			regulator-name = "pmr735a_l1";
>> +			regulator-min-microvolt = <912000>;
>> +			regulator-max-microvolt = <912000>;
>> +		};
>> +
>> +		pmr735a_l2: ldo2 {
>> +			regulator-name = "pmr735a_l2";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +		};
>> +
>> +		pmr735a_l3: ldo3 {
>> +			regulator-name = "pmr735a_l3";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +		};
>> +
>> +		pmr735a_l4: ldo4 {
>> +			regulator-name = "pmr735a_l4";
>> +			regulator-min-microvolt = <1776000>;
>> +			regulator-max-microvolt = <1872000>;
>> +		};
>> +
>> +		pmr735a_l5: ldo5 {
>> +			regulator-name = "pmr735a_l5";
>> +			regulator-min-microvolt = <800000>;
>> +			regulator-max-microvolt = <800000>;
>> +		};
>> +
>> +		pmr735a_l6: ldo6 {
>> +			regulator-name = "pmr735a_l6";
>> +			regulator-min-microvolt = <480000>;
>> +			regulator-max-microvolt = <904000>;
>> +		};
>> +
>> +		pmr735a_l7: ldo7 {
>> +			regulator-name = "pmr735a_l7";
>> +			regulator-min-microvolt = <2800000>;
>> +			regulator-max-microvolt = <2800000>;
>> +		};
>> +	};
>> +};
>> +
>> +&adsp {
>> +	firmware-name = "qcom/OnePlus/lemonade/adsp.mbn";
>> +	status = "okay";
>> +};
>> +
>> +&cdsp {
>> +	firmware-name = "qcom/OnePlus/lemonade/cdsp.mbn";
>> +	status = "okay";
>> +};
>> +
>> +&slpi {
>> +	firmware-name = "qcom/OnePlus/lemonade/slpi.mbn";
>> +	status = "okay";
>> +};
>> +
>> +&ipa {
>> +	qcom,gsi-loader = "self";
>> +	memory-region = <&pil_ipa_fw_mem>;
>> +	firmware-name = "qcom/OnePlus/lemonade/ipa_fws.mbn";
>> +	status = "okay";
>> +};
>> +
>> +&mpss {
>> +	firmware-name = "qcom/OnePlus/lemonade/modem.mbn",
>> +			"qcom/OnePlus/lemonade/mcfg_hw.mbn";
> 
> All these firmware-name attributes don't follow what's already in
> mainline.
> 
> Use e.g. qcom/sm8350/lemonade/*

Noted, alright

> 
>> +
>> +	status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	/* Touchscreens: Syna TCM oncell or Samsung s6sy761 */
>> +};
>> +
>> +&i2c13 {
>> +	clock-frequency = <100000>;
>> +	status = "okay";
>> +
>> +	fsa4480@42 {
>> +		compatible = "fcs,fsa4480";
>> +		reg = <0x42>;
>> +		mode-switch;
>> +		orientation-switch;
>> +	};
>> +
>> +	/* Qualcomm PM8008i/PM8008j (?) @ 8, 9, c, d */
> 
> Check again in downstream if the @c and @d are actually enabled, at
> least they're not on my boards and the PM8008 is only addressable on @8
> and @9.

Seems like they all are used on this device; (d) in particular seems to 
be needed for the camera.

>> +};
>> +
>> +&i2c15 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	/* sn-nci NFC controller @ 28 */
>> +};
>> +
>> +&pm8350_gpios {
>> +	usb2_vbus_boost_default: usb2_vbus_boost_default {
>> +		pins = "gpio8";
>> +		function = "normal";
>> +		output-low;
>> +		power-source = <0x00>;
>> +		phandle = <0x5e1>;
>> +	};
>> +
>> +	usb2_vbus_det_default: usb2_vbus_det_default {
>> +		pins = "gpio9";
>> +		function = "normal";
>> +		input-enable;
>> +		bias-disable;
>> +		power-source = <0x00>;
>> +		phandle = <0x5e0>;
>> +	};
> 
> Node name should not have underscores, use dashes.
> 
> Also here again I doubt you ran the dtbs_check, I think also the pmic
> gpios need have have a -state suffix.
> 
>   => usb2_vbus_det_default: usb2-vbus-det-default-state {
> 
>> +
>> +	gpio1_adc_default: gpio1-adc-default {
>> +		pins = "gpio1";
>> +		function = "normal";
>> +		bias-high-impedance;
>> +		bias-disable;
>> +		phandle = <0x566>;
>> +	};
>> +
>> +	gpio3_adc_default: gpio3-adc-default {
>> +		pins = "gpio3";
>> +		function = "normal";
>> +		bias-high-impedance;
>> +		bias-disable;
>> +		phandle = <0x567>;
> 
> Drop the random phandles you copied from the decompiled dtb?

Oops...

> 
>> +	};
>> +};
>> +
>> +&pm8350b_gpios {
>> +	vol_down_n: vol-down-n-state {
>> +		pins = "gpio6";
>> +		function = "normal";
>> +		power-source = <1>;
>> +		bias-pull-up;
>> +		input-enable;
>> +	};
>> +};
>> +
>> +&pmk8350_rtc {
>> +	status = "okay";
>> +};
>> +
>> +&pmk8350_vadc {
>> +	pinctrl-0 = <&gpio1_adc_default &gpio1_adc_default>;
>> +	pinctrl-names = "default";
>> +
>> +	pmk8350_ref_gnd {
> 
> Doesn't follow the format in the docs.
> 
>> +		reg = <0x00>;
>> +		label = "pmk8350_ref_gnd";
>> +		qcom,pre-scaling = <0x01 0x01>;
> 
> Don't use hex here.
> 
>> +	};
>> +
>> +	pmk8350_vref_1p25 {
>> +		reg = <0x01>;
>> +		label = "pmk8350_vref_1p25";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pmk8350_die_temp {
>> +		reg = <0x03>;
>> +		label = "pmk8350_die_temp";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pmk8350_xo_therm {
>> +		reg = <0x44>;
>> +		label = "pmk8350_xo_therm";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
> 
> Make this also decimal.
> 
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pm8350_ref_gnd {
>> +		reg = <0x100>;
>> +		label = "pm8350_ref_gnd";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pm8350_vref_1p25 {
>> +		reg = <0x101>;
>> +		label = "pm8350_vref_1p25";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pm8350_die_temp {
>> +		reg = <0x103>;
>> +		label = "pm8350_die_temp";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pm8350_vph_pwr {
>> +		reg = <0x18e>;
>> +		label = "pm8350_vph_pwr";
>> +		qcom,pre-scaling = <0x01 0x03>;
>> +	};
>> +
>> +	pm8350b_ref_gnd {
>> +		reg = <0x300>;
>> +		label = "pm8350b_ref_gnd";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pm8350b_vref_1p25 {
>> +		reg = <0x301>;
>> +		label = "pm8350b_vref_1p25";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pm8350b_die_temp {
>> +		reg = <0x303>;
>> +		label = "pm8350b_die_temp";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pm8350b_vph_pwr {
>> +		reg = <0x38e>;
>> +		label = "pm8350b_vph_pwr";
>> +		qcom,pre-scaling = <0x01 0x03>;
>> +	};
>> +
>> +	pm8350b_vbat_sns {
>> +		reg = <0x38f>;
>> +		label = "pm8350b_vbat_sns";
>> +		qcom,pre-scaling = <0x01 0x03>;
>> +	};
>> +
>> +	pm8350_msm_therm {
>> +		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
>> +		label = "pm8350_msm_therm";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	pm8350_cam_flash_therm {
>> +		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
>> +		label = "pm8350_cam_flash_therm";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	pm8350_hot_pocket_therm {
>> +		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
>> +		label = "pm8350_hot_pocket_therm";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	pm8350_wide_rfc_therm {
>> +		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
>> +		label = "pm8350_wide_rfc_therm";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	pm8350_rear_tof_therm {
>> +		reg = <PM8350_ADC7_AMUX_THM5_100K_PU(1)>;
>> +		label = "pm8350_rear_tof_therm";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	pm8350b_usb_conn_therm {
>> +		reg = <PM8350B_ADC7_AMUX_THM4_100K_PU>;
>> +		label = "pm8350b_usb_conn_therm";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	pm8350b_wl_chg_therm {
>> +		reg = <PM8350B_ADC7_GPIO2_100K_PU>;
>> +		label = "pm8350b_wl_chg_therm";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	pm8350b_chg_temp {
>> +		reg = <PM8350B_ADC7_CHG_TEMP>;
>> +		label = "pm8350b_chg_temp";
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	pmr735a_ref_gnd {
>> +		reg = <0x400>;
>> +		label = "pmr735a_ref_gnd";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pmr735a_vref_1p25 {
>> +		reg = <0x401>;
>> +		label = "pmr735a_vref_1p25";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pmr735a_die_temp {
>> +		reg = <0x403>;
>> +		label = "pmr735a_die_temp";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pmr735b_ref_gnd {
>> +		reg = <0x500>;
>> +		label = "pmr735b_ref_gnd";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pmr735b_vref_1p25 {
>> +		reg = <0x501>;
>> +		label = "pmr735b_vref_1p25";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	pmr735b_die_temp {
>> +		reg = <0x503>;
>> +		label = "pmr735b_die_temp";
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	smb139x_1_smb_temp {
>> +		reg = <SMB139x_1_ADC7_SMB_TEMP>;
>> +		label = "smb139x_1_smb_temp";
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	smb139x_2_smb_temp {
>> +		reg = <SMB139x_2_ADC7_SMB_TEMP>;
>> +		label = "smb139x_2_smb_temp";
>> +		qcom,pre-scaling = <1 1>;
>> +	};
>> +
>> +	gpio1_v {
>> +		reg = <0x128>;
>> +		label = "gpio1_v";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0x2bc>;
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +
>> +	gpio3_v {
>> +		reg = <0x12b>;
>> +		label = "gpio3_v";
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0x2bc>;
>> +		qcom,pre-scaling = <0x01 0x01>;
>> +	};
>> +};
>> +
>> +&pmk8350_adc_tm {
>> +	status = "okay";
>> +
>> +	pm8350_msm_therm {
>> +		reg = <0x144>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
> 
> Here also. Node name doesn't follow docs, missing io-channels (used here
> instead of reg), etc.
> 
>> +	};
>> +
>> +	pm8350_cam_flash_therm {
>> +		reg = <0x145>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
>> +	};
>> +
>> +	pm8350_hot_pocket_therm {
>> +		reg = <0x146>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
>> +	};
>> +
>> +	pm8350_wide_rfc_therm {
>> +		reg = <0x147>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
>> +	};
>> +
>> +	pm8350_rear_tof_therm {
>> +		reg = <0x148>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
>> +	};
>> +
>> +	pm8350b_usb_conn_therm {
>> +		reg = <0x347>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
>> +	};
>> +
>> +	pm8350b_wl_chg_therm {
>> +		reg = <0x34b>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
>> +	};
>> +
>> +	pmk8350_xo_therm {
>> +		reg = <0x44>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <0xc8>;
>> +	};
>> +};
>> +
>> +&pon_pwrkey {
>> +	status = "okay";
>> +};
>> +
>> +&pon_resin {
>> +	linux,code = <KEY_VOLUMEUP>;
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_id_1 {
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_id_2 {
>> +	status = "okay";
>> +};
>> +
>> +&gpi_dma0 {
>> +	status = "okay";
>> +};
>> +
>> +&gpi_dma1 {
>> +	status = "okay";
>> +};
>> +
>> +&gpi_dma2 {
>> +	status = "okay";
>> +};
>> +
>> +&removed_mem {
>> +	reg = <0x0 0xd8800000 0x0 0x8e00000>;
>> +};
>> +
>> +&tlmm {
>> +	gpio-reserved-ranges = <52 8>;
>> +
>> +	pcie0_default_state: pcie0-default-state {
>> +		perst-pins {
>> +			pins = "gpio94";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-down;
>> +		};
>> +
>> +		clkreq-pins {
>> +			pins = "gpio95";
>> +			function = "pcie0_clkreqn";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		wake-pins {
>> +			pins = "gpio96";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		sleep-pins {
>> +			pins = "gpio95";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +
>> +	pcie1_default_state: pcie1-default-state {
>> +		perst-pins {
>> +			pins = "gpio97";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-down;
>> +		};
>> +
>> +		clkreq-pins {
>> +			pins = "gpio98";
>> +			function = "pcie1_clkreqn";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		wake-pins {
>> +			pins = "gpio99";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +			/* wil6210_refclk_en_pin lives here also */
>> +		};
>> +	};
>> +
>> +	tp_rst_active: tp_rst_active {
> 
> Wrong node name and more below.
> 
>> +		pins = "gpio22";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	/* tp_rst_suspend pin is different per device, don't specify here */
>> +
>> +	tp_irq_active: tp_irq_active {
>> +		pins = "gpio23";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +		input-enable;
>> +	};
>> +
>> +	tp_irq_suspend: tp_irq_suspend {
>> +		pins = "gpio23";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	sde_dsi_active: sde-dsi-active {
>> +		pins = "gpio24";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-disable = <0>;
>> +	};
>> +
>> +	sde_dsi_suspend: sde-dsi-suspend {
>> +		pins = "gpio24";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	sde_te_active: sde-te-active {
>> +		pins = "gpio82";
>> +		function = "mdp_vsync";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	sde_te_suspend: sde-te-suspend {
>> +		pins = "gpio82";
>> +		function = "mdp_vsync";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	aw_irq: aw_irq {
>> +		pins = "gpio14";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	aw_reset: aw_reset {
>> +		pins = "gpio75";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
> 
> Skip unused pinctrl for now?

Some of these I had meant to use but wasn't able to get everything quite 
working. Forgot to remove, sorry.

> 
>> +
>> +	display_panel_avdd_default: display_panel_avdd_default {
>> +		pins = "gpio12";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-disable = <0>;
>> +		output-high;
>> +	};
>> +
>> +	/* Modem-related pin common on both devices */
>> +	rf_cable_ant0_active: rf_cable_ant0_active {
>> +		pins = "gpio165";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	usb_int_default: usb_int_default {
>> +		pins = "gpio198";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +		input-enable;
>> +	};
>> +
>> +	qupv3_se18_default_cts: qupv3_se18_default_cts {
>> +		pins = "gpio68";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	qupv3_se18_default_rtsrx: qupv3_se18_default_rtsrx {
>> +		pins = "gpio69", "gpio71";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	qupv3_se18_default_tx: qupv3_se18_default_tx {
>> +		pins = "gpio70";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	qupv3_se18_ctsrx: qupv3_se18_ctsrx {
>> +		pins = "gpio68", "gpio71";
>> +		function = "qup18";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	qupv3_se18_rts: qupv3_se18_rts {
>> +		pins = "gpio69";
>> +		function = "qup18";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	qupv3_se18_tx: qupv3_se18_tx {
>> +		pins = "gpio70";
>> +		function = "qup18";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	usb3phy_portselect_default: usb3phy_portselect_default {
>> +		pins = "gpio81";
>> +		function = "usb_phy";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	usb3phy_portselect_gpio: usb3phy_portselect_gpio {
>> +		pins = "gpio81";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	ext1_otg_default: ext1_otg_default {
>> +		pins = "gpio8";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		bias-pull-down;
>> +		input-enable;
>> +	};
>> +
>> +	cnss_wlan_en_active: cnss_wlan_en_active {
>> +		pins = "gpio64";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		output-high;
>> +		bias-pull-up;
>> +	};
>> +
>> +	cnss_wlan_en_sleep: cnss_wlan_en_sleep {
>> +		pins = "gpio64";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		output-low;
>> +		bias-pull-down;
>> +	};
>> +
>> +	bt_en_sleep: bt_en_sleep {
>> +		pins = "gpio65";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		output-low;
>> +		bias-pull-down;
>> +	};
>> +};
>> +
>> +&ufs_mem_hc {
>> +	reset-gpios = <&tlmm 203 GPIO_ACTIVE_LOW>;
>> +
>> +	vcc-supply = <&pm8350_l7>;
>> +	vcc-voltage-level = <2504000 2950000>;
>> +	vcc-max-microamp = <800000>;
>> +	vccq-supply = <&pm8350_l9>;
>> +	vccq-max-microamp = <900000>;
>> +
>> +	qcom,vddp-ref-clk-supply = <&pm8350_l9>;
>> +	qcom,vddp-ref-clk-max-microamp = <100>;
>> +
>> +	qcom,vddp-ref-clk-supply = <&pm8350_s12>;
>> +	qcom,vccq-parent-max-microamp = <210000>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&ufs_mem_phy {
>> +	vdda-phy-supply = <&pm8350_l5>;
>> +	vdda-phy-always-on;
> 
> Property doesn't exist
> 
>> +	vdda-max-microamp = <91600>;
>> +	vdda-pll-supply = <&pm8350_l6>;
>> +	vdda-pll-max-microamp = <19000>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +	/* Bug in interconnect driver breaks USB */
>> +	/delete-property/ interconnects;
>> +	/delete-property/ interconnect-names;
> 
> Any chance on fixing this? Or add some extra explanation? Not sure how
> liked such workarounds are in dts files.

Enabling that makes USB perma-broken as the regulators get stuck at off; 
I can investigate more if that would be necessary.

>> +
>> +	/*
>> +	 * USB3 is not tested (though it is enabled downstream) so limit to
>> +	 * high-speed for now.
>> +	 */
>> +	qcom,select-utmi-as-pipe-clk;
> 
> You never plugged the device into a USB 3.0 port? Should be trivial to
> test I think?

Will test for v2.

> 
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_dwc3 {
>> +	/* Mode switching is untested */
>> +	dr_mode = "peripheral";
>> +	maximum-speed = "high-speed";
>> +	phys = <&usb_1_hsphy>;
>> +	phy-names = "usb2-phy";
>> +};
>> +
>> +&usb_1_hsphy {
>> +	vdda-pll-supply = <&pm8350_l5>;
>> +	vdda18-supply = <&pm8350c_l1>;
>> +	vdda33-supply = <&pm8350_l2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +/* Enabling this is necessary only for displayport */
> 
> Do you have displayport support with this dts? If not why enable it?

Fair enough, no. Panel driver is still WIP, will upstream this bit when 
that's working.

> 
>> +&usb_1_qmpphy {
>> +	vdda-phy-supply = <&pm8350_l6>;
>> +	vdda-pll-supply = <&pm8350_l1>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <100000>;
>> +	status = "okay";
>> +
>> +	bq27541: fuel-gauge@55 {
>> +		compatible = "ti,bq27541";
>> +		reg = <0x55>;
>> +		monitored-battery = <&bat>;
>> +	};
>> +};
>> +/* Crypto drivers currently fail & cause an XPU violation */
> 
> Missing newline between nodes.
> 
>> +&cryptobam {
>> +	status = "disabled";
>> +};
>> +
>> +&crypto {
>> +	status = "disabled";
>> +};
> 
> These disables are not useful since they're already disabled in
> sm8350.dtsi because of that problem.

This was here before that fix landed, but I missed it; will remove.

> 
>> +
>> +&pcie0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie0_default_state>;
>> +
>> +	perst-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
>> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +	vdda-phy-supply = <&pm8350_l5>;
>> +	vdda-pll-supply = <&pm8350_l6>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie1_default_state>;
>> +
>> +	perst-gpios = <&tlmm 97 GPIO_ACTIVE_HIGH>;
>> +	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +	vdda-phy-supply = <&pm8350_l5>;
>> +	vdda-pll-supply = <&pm8350_l6>;
>> +
>> +	status = "okay";
>> +};
> 
> Everywhere in this file make sure the nodes are sorted alphabetically,
> it's a wild west right now.

Understandable, will do.

> 
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts
>> new file mode 100644
>> index 000000000000..f2c27894f3c4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Igalia S.L.
>> + * Authors:
>> + *	Nia Espera <nespera@igalia.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm8350-oneplus-common.dtsi"
>> +
>> +/ {
>> +	model = "OnePlus 9";
>> +	compatible = "oneplus,lemonade", "qcom,sm8350";
>> +};
>> +
>> +&i2c4 {
>> +	touchscreen@48 {
>> +		compatible = "samsung,s6sy761";
>> +		reg = <0x48>;
>> +		interrupts-extended = <&tlmm 23 0x2008>;
> 
> Replace the 0x2008 with the GPIO_* flags from include/dt-bindings/gpio/gpio.h

There doesn't seem to be a flag for 0x2000 and it's not documented 
downstream; is it okay to replace with (0x2000|GPIO_TRANSITORY)?

> 
>> +
>> +		vdd-supply = <&pm8350c_l8>;
>> +		avdd-supply = <&pm8350c_l13>;
>> +
>> +		pinctrl-names = "default", "sleep";
>> +		pinctrl-0 = <&tp_rst_active &tp_irq_active>;
>> +		pinctrl-1 = <&tp_rst_suspend &tp_irq_suspend>;
>> +	};
>> +};
>> +
>> +&tlmm {
>> +	tp_rst_suspend: tp_rst_suspend {
>> +		pins = "gpio22";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	tp_enable_2v8: tp_enable_2v8 {
>> +		pins = "gpio74";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-up;
>> +		output-high;
>> +	};
> 
> Some pinctrl comments as in the .dtsi file
> 
>> +
>> +	/* Modem antenna pins exclusive to lemonade */
>> +	rf_cable_ant1_active: rf_cable_ant1_active {
>> +		pins = "gpio27";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +	rf_cable_ant2_active: rf_cable_ant2_active {
>> +		pins = "gpio92";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +	rf_cable_ant3_active: rf_cable_ant3_active {
>> +		pins = "gpio44";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +	rf_cable_ant7_active: rf_cable_ant7_active {
>> +		pins = "gpio155";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +};
>> +
>> +&mpss {
>> +	pinctrl-names = "default";
>> +	pinctrl-1 = <&rf_cable_ant0_active
>> +		     &rf_cable_ant1_active
>> +		     &rf_cable_ant2_active
>> +		     &rf_cable_ant3_active
>> +		     &rf_cable_ant7_active>;
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts
>> new file mode 100644
>> index 000000000000..de8597d26091
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Igalia S.L.
>> + * Authors:
>> + *	Nia Espera <nespera@igalia.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm8350-oneplus-common.dtsi"
>> +
>> +/ {
>> +	model = "OnePlus 9 Pro";
>> +	compatible = "oneplus,lemonadep", "qcom,sm8350";
>> +};
>> +
>> +&tlmm {
>> +	tp_rst_suspend: tp_rst_suspend {
>> +		pins = "gpio22";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	tp_enable_2v8: tp_enable_2v8 {
>> +		pins = "gpio31";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-up;
>> +		output-high;
>> +	};
> 
> And don't forget about fixing the nodes here. But why define them now if
> you don't have any users of them?

Oopsies- same as previous pins, op9p touchscreen isn't ready yet and I 
left these in.

> 
>> +};
>> +
>> +&mpss {
>> +	pinctrl-names = "default";
>> +	pinctrl-1 = <&rf_cable_ant0_active>;
>> +};
> 
> I'm sure others will have more comments but fixing the comments I added
> is a good step forward :)

Thanks for your time! I'll fix up everything mentioned.

> 
> Regards
> Luca

