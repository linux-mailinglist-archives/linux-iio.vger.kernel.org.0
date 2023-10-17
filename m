Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E367CBB40
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 08:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjJQGcC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 02:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQGcC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 02:32:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B54495
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 23:31:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso832601666b.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697524308; x=1698129108; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd1cuvjnsCFz5/VAxY8vz3JoJaf+u0F0+wnrPt/XfyE=;
        b=HTg+7eUzQKayRktLWsf+lvK5i2MWAEFAKI2YtNEX09jNP4+KadIAEOLTkXCoCTWgqD
         ij7IYSgmSjPCKCOOCoYhQtmO06N1ZFe/b1XYLgwZ8GftrqWcSCHi0F7Csl74v9Wvat+s
         DVlHOC588Yi24ruflin+q0s1+oQC7fzG56Zwo/vb7inDLPA0M+jGSGspsSlxclRf6skU
         JwqoxvNj/jidDhGNtuvpzyNXh8hVo9n15TJYz5ZrOW2vq/uhCp7D4PeU7hEnWIT2qAe6
         XLxWPQsy2/HG9bc9xxB6pjht/a7Q7FcnOwG2psSCnK7SWclIp2U+uk2qluH6dYZoYM2y
         PGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697524308; x=1698129108;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zd1cuvjnsCFz5/VAxY8vz3JoJaf+u0F0+wnrPt/XfyE=;
        b=WJn3OCd9SfGG3sEu9lttQiQex7IQ0t527vT8l7F98Cb+ybTrAxHWPwVRHnOIMjZ+Vq
         sgc0Dh3Rs/flNMLtoeikWGVocVDJC6Fz06XEhZ6FREFbny/8EHCU7XE+K6PPrbwnDU3f
         9PFuLdNuivbFwOEXLadxgyixCb3o/fClC1jb/i/1dWNkWsFGWQ/EfoCRmcjhGu849VJx
         GBOQ+lZr9c29lwhy2m/77wmrV8mxkVe0bzVDTiBEBoV9NinnXl0sjUFFrLhO3cfsoNaZ
         hVEISmmTNdRE3bHwfeEr+A+QZsqqWem+vYb5PnrRPfLUaZ4l+f9tzCkll12Kesus5W65
         tv6Q==
X-Gm-Message-State: AOJu0Yzvd7hS6ny1avppLFyInftO80eAJJVG7qolGeoKsmUkUvDd6gUq
        xd6mkMRJr3yqk7JTdMaeWv4JTw==
X-Google-Smtp-Source: AGHT+IEhR7c8dUqiaCj3DIT3rrJxgozthHCF+4KJgyDxnie8TRUx4DC2UW6dOOGAlBy93fuLYRjhJg==
X-Received: by 2002:a17:906:7309:b0:9bd:d405:4e7e with SMTP id di9-20020a170906730900b009bdd4054e7emr943430ejc.6.1697524307596;
        Mon, 16 Oct 2023 23:31:47 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906358200b009a1dbf55665sm591821ejb.161.2023.10.16.23.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 23:31:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 08:31:46 +0200
Message-Id: <CWAI58LU9PXA.3N99LXRT1NWIM@fairphone.com>
To:     "Nia Espera" <nespera@igalia.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <phone-devel@vger.kernel.org>,
        "Rob" <Me@orbit.sh>, "Clayton Craft" <clayton@igalia.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8350-lemonade(p): new devices
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
 <20231016-nia-sm8350-for-upstream-v1-5-bb557a0af2e9@igalia.com>
 <CW9WUOLK18R1.2HI2MM4P47HPV@fairphone.com>
 <49850e9c-5307-489f-9587-f016188bb59a@igalia.com>
In-Reply-To: <49850e9c-5307-489f-9587-f016188bb59a@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Oct 16, 2023 at 11:41 PM CEST, Nia Espera wrote:
> Hi,
>
> On 10/16/23 15:50, Luca Weiss wrote:
> > Hi Nia,
> >=20
> > On Mon Oct 16, 2023 at 2:47 PM CEST, Nia Espera wrote:
> >> Device tree files for OnePlus 9 and 9 Pro. Details of supported featur=
es
> >> mentioned in the cover letter for this patch series, but for
> >> accessibility also repeated here:
> >>
> >> - USB OTG
> >> - UFS
> >> - Framebuffer display
> >> - Touchscreen (for lemonade)
> >> - Power & volume down keys
> >> - Battery reading
> >> - Modem, IPA, and remoteproc bringup
> >>
> >> Steps to get booting:
> >>
> >> - Wipe dtbo partition
> >> - Flash vbmeta with disabled verity bit
> >> - Flash kernel and initfs to boot partition with CLI args pd_ignore_un=
used
> >> and clk_ignore_unused
> >> - Flash rootfs to some other partition (probably super or userdata)
> >>
> >> Signed-off-by: Nia Espera <nespera@igalia.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/Makefile                  |    2 +
> >>   .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1247 ++++++++++=
++++++++++
> >>   .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   82 ++
> >>   .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   37 +
> >>   4 files changed, 1368 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/q=
com/Makefile
> >> index 2cca20563a1d..369ad4721b29 100644
> >> --- a/arch/arm64/boot/dts/qcom/Makefile
> >> +++ b/arch/arm64/boot/dts/qcom/Makefile
> >> @@ -211,6 +211,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8250-xiaomi-elish-c=
sot.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8350-hdk.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8350-microsoft-surface-duo2.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8350-mtp.dtb
> >> +dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8350-oneplus-lemonade.dtb
> >> +dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8350-oneplus-lemonadep.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8350-sony-xperia-sagami-pdx214.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8350-sony-xperia-sagami-pdx215.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)	+=3D sm8450-hdk.dtb
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi b/arc=
h/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
> >> new file mode 100644
> >> index 000000000000..2f6768f35259
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
> >> @@ -0,0 +1,1247 @@
> >> +// SPDX-License-Identifier: BSD-3-Clause
> >> +/*
> >> + * Copyright (c) 2023 Caleb Connolly <caleb.connolly@linaro.org>
> >> + *
> >> + * Copyright (c) 2023 Igalia S.L.
> >> + * Authors:
> >> + *	Nia Espera <nespera@igalia.com>
> >> + */
> >> +
> >> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> >> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
> >> +#define SMB139x_1_SID 0x0b
> >> +#define SMB139x_2_SID 0x0c
> >> +#include <dt-bindings/iio/qcom,spmi-adc7-smb139x.h>
> >> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> >> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >> +#include "sm8350.dtsi"
> >> +#include "pm8350.dtsi"
> >> +#include "pm8350b.dtsi"
> >> +#include "pm8350c.dtsi"
> >> +#include "pmk8350.dtsi"
> >> +#include "pmr735a.dtsi"
> >> +#include "pmr735b.dtsi"
> >> +
> >> +/ {
> >> +	/* As with the Sony devices, msm-id and board-id aren't needed here =
*/
> >> +	chassis-type =3D "handset";
> >> +	interrupt-parent =3D <&intc>;
> >> +
> >> +	chosen {
> >> +		#address-cells =3D <2>;
> >> +		#size-cells =3D <2>;
> >> +		ranges;
> >> +
> >> +		framebuffer: framebuffer@e4d00000 {
> >> +			compatible =3D "simple-framebuffer";
> >> +			reg =3D <0 0xe4d00000 0 0x2400000>;
> >> +			width =3D <1080>;
> >> +			height =3D <2412>;
> >> +			stride =3D <(1080 * 4)>;
> >> +			format =3D "a8r8g8b8";
> >> +			/*
> >> +			 * That's (going to be) a lot of clocks, but it's
> >> +			 * necessary due to unused clk cleanup & no panel
> >> +			 * driver yet.
> >> +			 */
> >> +			clocks =3D <&gcc GCC_DISP_HF_AXI_CLK>,
> >> +				 <&gcc GCC_DISP_SF_AXI_CLK>;
> >> +		};
> >> +	};
> >> +
> >> +	gpio-keys {
> >> +		compatible =3D "gpio-keys";
> >> +
> >> +		pinctrl-names =3D "default";
> >> +		pinctrl-0 =3D <&vol_down_n>;
> >> +
> >> +		key-vol-up {
> >> +			label =3D "Volume Up";
> >> +			linux,code =3D <KEY_VOLUMEUP>;
> >> +			gpios =3D <&pmk8350_gpios 6 GPIO_ACTIVE_LOW>;
> >> +			debounce-interval =3D <15>;
> >> +			linux,can-disable;
> >> +			wakeup-source;
> >> +		};
> >> +	};
> >> +
> >> +	bat: battery {
> >> +		compatible =3D "simple-battery";
> >> +		device-chemistry =3D "lithium-ion";
> >> +		voltage-min-design-microvolt =3D <3200000>;
> >> +		energy-full-design-microwatt-hours =3D <15840000>;
> >> +		charge-full-design-microamp-hours =3D <2225000>;
> >> +	};
> >> +
> >> +	vph_pwr: vph-pwr-regulator {
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "vph_pwr";
> >> +		regulator-min-microvolt =3D <3700000>;
> >> +		regulator-max-microvolt =3D <3700000>;
> >> +
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +	};
> >> +
> >> +	display_panel_avdd: display_regulator@1 {
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "display_panel_avdd";
> >> +		regulator-min-microvolt =3D <5500000>;
> >> +		regulator-max-microvolt =3D <5500000>;
> >> +		regulator-enable-ramp-delay =3D <233>;
> >> +
> >> +		enable-active-high;
> >> +		regulator-boot-on;
> >> +	};
> >> +
> >> +	/*
> >> +	 * Hack; OP9 bootloader specifically checks that the timer node has
> >> +	 * this label.
> >> +	 */
> >> +	arch_timer: timer {};
> >> +};
> >> +
> >> +&reserved_memory {
> >> +	/* EFI splash screen */
> >> +	memory@e1000000 {
> >=20
> > Don't use memory@ names, this was decided a while ago to not be correct=
.
> > I think other devices here use e.g. splash@[..] or something.
>
> Noted, okay.
>
> >=20
> >> +		reg =3D <0 0xe4d00000 0 0x02400000>;
> >> +		no-map;
> >> +		label =3D "cont_splash_region";
> >> +	};
> >> +
> >> +	ramoops: ramoops@E9700000 {
> >> +		compatible =3D "ramoops";
> >> +		reg =3D <0 0xe9700000 0 0x05b8000>;
> >> +		record-size =3D	<0x40000>;
> >> +		console-size =3D	<0x40000>;
> >> +		ftrace-size =3D	<0x200000>;
> >> +		pmsg-size =3D	<0x200000>;
> >> +		devinfo-size =3D	<0x08000>;
> >> +		dumpinfo-size =3D	<0x08000>;
> >> +		rsv01info-size=3D	<0x08000>;
> >> +		rsv02info-size=3D	<0x08000>;
> >> +		rsv03info-size=3D	<0x08000>;
> >> +		rsv04info-size=3D	<0x08000>;
> >> +		rsv05info-size=3D	<0x08000>;
> >> +		ecc-size=3D	<0x0>;
> >=20
> > Half of these flags don't exist. Did you run dtbs_check? Also
> > indentation normally doesn't get padded out in mainline, just do e.g.
> > record-size =3D <0x40000>; without the tab.
> >=20
>
> Mea culpa. Will fix, and run a check.
>
> >> +	};
> >> +
> >> +	/* bootloader log buffer */
> >> +	memory@9fff7000 {
> >> +		reg =3D <0x00 0x9fff7000 0x00 0x8000>;
> >> +	};
> >> +
> >> +	/* unknown; "param_mem" downstream */
> >> +	memory@ea700000 {
> >> +		reg =3D <0x00 0xea700000 0x00 0x800000>;
> >> +	};
> >> +};
> >> +
> >> +&apps_rsc {
> >> +	regulators-0 {
> >> +		compatible =3D "qcom,pm8350-rpmh-regulators";
> >> +		qcom,pmic-id =3D "b";
> >> +
> >> +		vdd-s1-supply =3D <&vph_pwr>;
> >> +		vdd-s2-supply =3D <&vph_pwr>;
> >> +		vdd-s3-supply =3D <&vph_pwr>;
> >> +		vdd-s4-supply =3D <&vph_pwr>;
> >> +		vdd-s5-supply =3D <&vph_pwr>;
> >> +		vdd-s6-supply =3D <&vph_pwr>;
> >> +		vdd-s7-supply =3D <&vph_pwr>;
> >> +		vdd-s8-supply =3D <&vph_pwr>;
> >> +		vdd-s9-supply =3D <&vph_pwr>;
> >> +		vdd-s10-supply =3D <&vph_pwr>;
> >> +		vdd-s11-supply =3D <&vph_pwr>;
> >> +		vdd-s12-supply =3D <&vph_pwr>;
> >> +
> >> +		vdd-l1-l4-supply =3D <&pm8350_s11>;
> >> +		vdd-l2-l7-supply =3D <&vreg_bob>;
> >> +		vdd-l3-l5-supply =3D <&vreg_bob>;
> >> +		vdd-l6-l9-l10-supply =3D <&pm8350_s11>;
> >> +		vdd-l8-supply =3D <&pmr735a_s2>;
> >> +
> >> +		/*
> >> +		 * ARC regulators:
> >> +		 * S5 - mx.lvl
> >> +		 * S6 - gfx.lvl
> >> +		 * S9 - mxc.lvl
> >> +		 */
> >> +
> >> +		pm8350_s10: smps10 {
> >> +			regulator-name =3D "pm8350_s10";
> >> +			regulator-min-microvolt =3D <1800000>;
> >> +			regulator-max-microvolt =3D <1800000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350_s11: smps11 {
> >> +			regulator-name =3D "pm8350_s11";
> >> +			regulator-min-microvolt =3D <752000>;
> >> +			regulator-max-microvolt =3D <1012000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350_s12: smps12 {
> >> +			regulator-name =3D "pm8350_s12";
> >> +			regulator-min-microvolt =3D <1224000>;
> >> +			regulator-max-microvolt =3D <1360000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350_l1: ldo1 {
> >> +			regulator-name =3D "pm8350_l1";
> >> +			regulator-min-microvolt =3D <912000>;
> >> +			regulator-max-microvolt =3D <920000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350_l2: ldo2 {
> >> +			regulator-name =3D "pm8350_l2";
> >> +			regulator-min-microvolt =3D <3072000>;
> >> +			regulator-max-microvolt =3D <3072000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350_l3: ldo3 {
> >> +			regulator-name =3D "pm8350_l3";
> >> +			regulator-min-microvolt =3D <904000>;
> >> +			regulator-max-microvolt =3D <904000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		/* L4 - lmx.lvl (ARC) */
> >> +
> >> +		pm8350_l5: ldo5 {
> >> +			regulator-name =3D "pm8350_l5";
> >> +			regulator-min-microvolt =3D <880000>;
> >> +			regulator-max-microvolt =3D <888000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +			regulator-allow-set-load;
> >> +			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
> >> +						   RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350_l6: ldo6 {
> >> +			regulator-name =3D "pm8350_l6";
> >> +			regulator-min-microvolt =3D <1200000>;
> >> +			regulator-max-microvolt =3D <1208000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +			regulator-allow-set-load;
> >> +			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
> >> +						   RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350_l7: ldo7 {
> >> +			regulator-name =3D "pm8350_l7";
> >> +			regulator-min-microvolt =3D <2400000>;
> >> +			regulator-max-microvolt =3D <3008000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +			regulator-allow-set-load;
> >> +			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
> >> +						   RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		/* L8 - lcx.lvl (ARC) */
> >> +
> >> +		pm8350_l9: ldo9 {
> >> +			regulator-name =3D "pm8350_l9";
> >> +			regulator-min-microvolt =3D <1200000>;
> >> +			regulator-max-microvolt =3D <1200000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +			regulator-allow-set-load;
> >> +			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
> >> +						   RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +	};
> >> +
> >> +	regulators-1 {
> >> +		compatible =3D "qcom,pm8350c-rpmh-regulators";
> >> +		qcom,pmic-id =3D "c";
> >> +
> >> +		vdd-s1-supply =3D <&vph_pwr>;
> >> +		vdd-s2-supply =3D <&vph_pwr>;
> >> +		vdd-s3-supply =3D <&vph_pwr>;
> >> +		vdd-s4-supply =3D <&vph_pwr>;
> >> +		vdd-s5-supply =3D <&vph_pwr>;
> >> +		vdd-s6-supply =3D <&vph_pwr>;
> >> +		vdd-s7-supply =3D <&vph_pwr>;
> >> +		vdd-s8-supply =3D <&vph_pwr>;
> >> +		vdd-s9-supply =3D <&vph_pwr>;
> >> +		vdd-s10-supply =3D <&vph_pwr>;
> >> +
> >> +		vdd-l1-l12-supply =3D <&pm8350c_s1>;
> >> +		vdd-l2-l8-supply =3D <&pm8350c_s1>;
> >> +		vdd-l3-l4-l5-l7-l13-supply =3D <&vreg_bob>;
> >> +		vdd-l6-l9-l11-supply =3D <&vreg_bob>;
> >> +		vdd-l10-supply =3D <&pm8350_s12>;
> >> +
> >> +		vdd-bob-supply =3D <&vph_pwr>;
> >> +
> >> +		pm8350c_s1: smps1 {
> >> +			regulator-name =3D "pm8350c_s1";
> >> +			regulator-min-microvolt =3D <1800000>;
> >> +			regulator-max-microvolt =3D <1952000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		/* S2 - ebi.lvl (ARC) */
> >> +
> >> +		pm8350c_s3: smps3 {
> >> +			regulator-name =3D "pm8350c_s3";
> >> +			regulator-min-microvolt =3D <300000>;
> >> +			regulator-max-microvolt =3D <704000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		/*
> >> +		 * ARC regulators:
> >> +		 * S4 - mss.lvl
> >> +		 * S6 - cx.lvl
> >> +		 * S8 - mmcx.lvl
> >> +		 */
> >> +
> >> +		pm8350c_s10: smps10 {
> >> +			regulator-name =3D "pm8350c_s10";
> >> +			regulator-min-microvolt =3D <1048000>;
> >> +			regulator-max-microvolt =3D <1128000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l1: ldo1 {
> >> +			regulator-name =3D "pm8350c_l1";
> >> +			regulator-min-microvolt =3D <1800000>;
> >> +			regulator-max-microvolt =3D <1800000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l2: ldo2 {
> >> +			regulator-name =3D "pm8350c_l2";
> >> +			regulator-min-microvolt =3D <1800000>;
> >> +			regulator-max-microvolt =3D <1800000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l3: ldo3 {
> >> +			regulator-name =3D "pm8350c_l3";
> >> +			regulator-min-microvolt =3D <3000000>;
> >> +			regulator-max-microvolt =3D <3300000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l4: ldo4 {
> >> +			regulator-name =3D "pm8350c_l4";
> >> +			regulator-min-microvolt =3D <1704000>;
> >> +			regulator-max-microvolt =3D <3000000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l5: ldo5 {
> >> +			regulator-name =3D "pm8350c_l5";
> >> +			regulator-min-microvolt =3D <1704000>;
> >> +			regulator-max-microvolt =3D <3000000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l6: ldo6 {
> >> +			regulator-name =3D "pm8350c_l6";
> >> +			regulator-min-microvolt =3D <1800000>;
> >> +			regulator-max-microvolt =3D <2960000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l7: ldo7 {
> >> +			regulator-name =3D "pm8350c_l7";
> >> +			regulator-min-microvolt =3D <3008000>;
> >> +			regulator-max-microvolt =3D <3008000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l8: ldo8 {
> >> +			regulator-name =3D "pm8350c_l8";
> >> +			regulator-min-microvolt =3D <1800000>;
> >> +			regulator-max-microvolt =3D <1800000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l9: ldo9 {
> >> +			regulator-name =3D "pm8350c_l9";
> >> +			regulator-min-microvolt =3D <2800000>;
> >> +			regulator-max-microvolt =3D <3008000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l10: ldo10 {
> >> +			regulator-name =3D "pm8350c_l10";
> >> +			regulator-min-microvolt =3D <1200000>;
> >> +			regulator-max-microvolt =3D <1200000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l11: ldo11 {
> >> +			regulator-name =3D "pm8350c_l11";
> >> +			regulator-min-microvolt =3D <2400000>;
> >> +			regulator-max-microvolt =3D <3008000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l12: ldo12 {
> >> +			regulator-name =3D "pm8350c_l12";
> >> +			regulator-min-microvolt =3D <1800000>;
> >> +			regulator-max-microvolt =3D <2000000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		pm8350c_l13: ldo13 {
> >> +			regulator-name =3D "pm8350c_l13";
> >> +			regulator-min-microvolt =3D <3000000>;
> >> +			regulator-max-microvolt =3D <3200000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >> +		};
> >> +
> >> +		vreg_bob: bob {
> >> +			regulator-name =3D "vreg_bob";
> >> +			regulator-min-microvolt =3D <3400000>;
> >> +			regulator-max-microvolt =3D <3960000>;
> >> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_AUTO>;
> >> +		};
> >> +	};
> >> +
> >> +	/* regulators-2 unused for now */
> >=20
> > Is there some PMIC that will be here? Since it's just numbered I also
> > don't see a problem renaming regulators-2 to regulators-3 if anything
> > was added later here.
> >=20
>
> Yep, pm8350b; no driver exists for it upstream and it's a single=20
> regulator that isn't particularly important (cannot find any references=
=20
> to it downstream, at least). I'll renumber the others.
>
> >> +
> >> +	regulators-3 {
> >> +		compatible =3D "qcom,pmr735a-rpmh-regulators";
> >> +		qcom,pmic-id =3D "e";
> >> +
> >> +		vdd-s1-supply =3D <&vph_pwr>;
> >> +		vdd-s2-supply =3D <&vph_pwr>;
> >> +		vdd-s3-supply =3D <&vph_pwr>;
> >> +
> >> +		vdd-l1-l2-supply =3D <&pmr735a_s2>;
> >> +		vdd-l3-supply =3D <&pmr735a_s1>;
> >> +		vdd-l4-supply =3D <&pm8350c_s1>;
> >> +		vdd-l5-l6-supply =3D <&pm8350c_s1>;
> >> +		vdd-l7-bob-supply =3D <&vreg_bob>;
> >> +
> >> +		pmr735a_s1: smps1 {
> >> +			regulator-name =3D "pmr735a_s1";
> >> +			regulator-min-microvolt =3D <1200000>;
> >> +			regulator-max-microvolt =3D <1280000>;
> >> +		};
> >> +
> >> +		pmr735a_s2: smps2 {
> >> +			regulator-name =3D "pmr735a_s2";
> >> +			regulator-min-microvolt =3D <500000>;
> >> +			regulator-max-microvolt =3D <976000>;
> >> +		};
> >> +
> >> +		pmr735a_s3: smps3 {
> >> +			regulator-name =3D "pmr735a_s3";
> >> +			regulator-min-microvolt =3D <2208000>;
> >> +			regulator-max-microvolt =3D <2352000>;
> >> +		};
> >> +
> >> +		pmr735a_l1: ldo1 {
> >> +			regulator-name =3D "pmr735a_l1";
> >> +			regulator-min-microvolt =3D <912000>;
> >> +			regulator-max-microvolt =3D <912000>;
> >> +		};
> >> +
> >> +		pmr735a_l2: ldo2 {
> >> +			regulator-name =3D "pmr735a_l2";
> >> +			regulator-min-microvolt =3D <1200000>;
> >> +			regulator-max-microvolt =3D <1200000>;
> >> +		};
> >> +
> >> +		pmr735a_l3: ldo3 {
> >> +			regulator-name =3D "pmr735a_l3";
> >> +			regulator-min-microvolt =3D <1200000>;
> >> +			regulator-max-microvolt =3D <1200000>;
> >> +		};
> >> +
> >> +		pmr735a_l4: ldo4 {
> >> +			regulator-name =3D "pmr735a_l4";
> >> +			regulator-min-microvolt =3D <1776000>;
> >> +			regulator-max-microvolt =3D <1872000>;
> >> +		};
> >> +
> >> +		pmr735a_l5: ldo5 {
> >> +			regulator-name =3D "pmr735a_l5";
> >> +			regulator-min-microvolt =3D <800000>;
> >> +			regulator-max-microvolt =3D <800000>;
> >> +		};
> >> +
> >> +		pmr735a_l6: ldo6 {
> >> +			regulator-name =3D "pmr735a_l6";
> >> +			regulator-min-microvolt =3D <480000>;
> >> +			regulator-max-microvolt =3D <904000>;
> >> +		};
> >> +
> >> +		pmr735a_l7: ldo7 {
> >> +			regulator-name =3D "pmr735a_l7";
> >> +			regulator-min-microvolt =3D <2800000>;
> >> +			regulator-max-microvolt =3D <2800000>;
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +&adsp {
> >> +	firmware-name =3D "qcom/OnePlus/lemonade/adsp.mbn";
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&cdsp {
> >> +	firmware-name =3D "qcom/OnePlus/lemonade/cdsp.mbn";
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&slpi {
> >> +	firmware-name =3D "qcom/OnePlus/lemonade/slpi.mbn";
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ipa {
> >> +	qcom,gsi-loader =3D "self";
> >> +	memory-region =3D <&pil_ipa_fw_mem>;
> >> +	firmware-name =3D "qcom/OnePlus/lemonade/ipa_fws.mbn";
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&mpss {
> >> +	firmware-name =3D "qcom/OnePlus/lemonade/modem.mbn",
> >> +			"qcom/OnePlus/lemonade/mcfg_hw.mbn";
> >=20
> > All these firmware-name attributes don't follow what's already in
> > mainline.
> >=20
> > Use e.g. qcom/sm8350/lemonade/*
>
> Noted, alright
>
> >=20
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&i2c4 {
> >> +	clock-frequency =3D <400000>;
> >> +	status =3D "okay";
> >> +
> >> +	/* Touchscreens: Syna TCM oncell or Samsung s6sy761 */
> >> +};
> >> +
> >> +&i2c13 {
> >> +	clock-frequency =3D <100000>;
> >> +	status =3D "okay";
> >> +
> >> +	fsa4480@42 {
> >> +		compatible =3D "fcs,fsa4480";
> >> +		reg =3D <0x42>;
> >> +		mode-switch;
> >> +		orientation-switch;
> >> +	};
> >> +
> >> +	/* Qualcomm PM8008i/PM8008j (?) @ 8, 9, c, d */
> >=20
> > Check again in downstream if the @c and @d are actually enabled, at
> > least they're not on my boards and the PM8008 is only addressable on @8
> > and @9.
>
> Seems like they all are used on this device; (d) in particular seems to=
=20
> be needed for the camera.

PM8008 is a I2C-addressable regulator that is just used for camera. But
still if you have some time, double check if really both 8+9 and c+d are
used. For example you could use i2cdetect on the bus, I think the PM8008
shows up without manually flipping some enable GPIO. Or check downstream
dmesg to see what it says, or at runtime in /sys (e.g. in TWRP should be
enough).

>
> >> +};
> >> +
> >> +&i2c15 {
> >> +	clock-frequency =3D <400000>;
> >> +	status =3D "okay";
> >> +
> >> +	/* sn-nci NFC controller @ 28 */
> >> +};
> >> +
> >> +&pm8350_gpios {
> >> +	usb2_vbus_boost_default: usb2_vbus_boost_default {
> >> +		pins =3D "gpio8";
> >> +		function =3D "normal";
> >> +		output-low;
> >> +		power-source =3D <0x00>;
> >> +		phandle =3D <0x5e1>;
> >> +	};
> >> +
> >> +	usb2_vbus_det_default: usb2_vbus_det_default {
> >> +		pins =3D "gpio9";
> >> +		function =3D "normal";
> >> +		input-enable;
> >> +		bias-disable;
> >> +		power-source =3D <0x00>;
> >> +		phandle =3D <0x5e0>;
> >> +	};
> >=20
> > Node name should not have underscores, use dashes.
> >=20
> > Also here again I doubt you ran the dtbs_check, I think also the pmic
> > gpios need have have a -state suffix.
> >=20
> >   =3D> usb2_vbus_det_default: usb2-vbus-det-default-state {
> >=20
> >> +
> >> +	gpio1_adc_default: gpio1-adc-default {
> >> +		pins =3D "gpio1";
> >> +		function =3D "normal";
> >> +		bias-high-impedance;
> >> +		bias-disable;
> >> +		phandle =3D <0x566>;
> >> +	};
> >> +
> >> +	gpio3_adc_default: gpio3-adc-default {
> >> +		pins =3D "gpio3";
> >> +		function =3D "normal";
> >> +		bias-high-impedance;
> >> +		bias-disable;
> >> +		phandle =3D <0x567>;
> >=20
> > Drop the random phandles you copied from the decompiled dtb?
>
> Oops...
>
> >=20
> >> +	};
> >> +};
> >> +
> >> +&pm8350b_gpios {
> >> +	vol_down_n: vol-down-n-state {
> >> +		pins =3D "gpio6";
> >> +		function =3D "normal";
> >> +		power-source =3D <1>;
> >> +		bias-pull-up;
> >> +		input-enable;
> >> +	};
> >> +};
> >> +
> >> +&pmk8350_rtc {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&pmk8350_vadc {
> >> +	pinctrl-0 =3D <&gpio1_adc_default &gpio1_adc_default>;
> >> +	pinctrl-names =3D "default";
> >> +
> >> +	pmk8350_ref_gnd {
> >=20
> > Doesn't follow the format in the docs.
> >=20
> >> +		reg =3D <0x00>;
> >> +		label =3D "pmk8350_ref_gnd";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >=20
> > Don't use hex here.
> >=20
> >> +	};
> >> +
> >> +	pmk8350_vref_1p25 {
> >> +		reg =3D <0x01>;
> >> +		label =3D "pmk8350_vref_1p25";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pmk8350_die_temp {
> >> +		reg =3D <0x03>;
> >> +		label =3D "pmk8350_die_temp";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pmk8350_xo_therm {
> >> +		reg =3D <0x44>;
> >> +		label =3D "pmk8350_xo_therm";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >=20
> > Make this also decimal.
> >=20
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pm8350_ref_gnd {
> >> +		reg =3D <0x100>;
> >> +		label =3D "pm8350_ref_gnd";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pm8350_vref_1p25 {
> >> +		reg =3D <0x101>;
> >> +		label =3D "pm8350_vref_1p25";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pm8350_die_temp {
> >> +		reg =3D <0x103>;
> >> +		label =3D "pm8350_die_temp";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pm8350_vph_pwr {
> >> +		reg =3D <0x18e>;
> >> +		label =3D "pm8350_vph_pwr";
> >> +		qcom,pre-scaling =3D <0x01 0x03>;
> >> +	};
> >> +
> >> +	pm8350b_ref_gnd {
> >> +		reg =3D <0x300>;
> >> +		label =3D "pm8350b_ref_gnd";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pm8350b_vref_1p25 {
> >> +		reg =3D <0x301>;
> >> +		label =3D "pm8350b_vref_1p25";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pm8350b_die_temp {
> >> +		reg =3D <0x303>;
> >> +		label =3D "pm8350b_die_temp";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pm8350b_vph_pwr {
> >> +		reg =3D <0x38e>;
> >> +		label =3D "pm8350b_vph_pwr";
> >> +		qcom,pre-scaling =3D <0x01 0x03>;
> >> +	};
> >> +
> >> +	pm8350b_vbat_sns {
> >> +		reg =3D <0x38f>;
> >> +		label =3D "pm8350b_vbat_sns";
> >> +		qcom,pre-scaling =3D <0x01 0x03>;
> >> +	};
> >> +
> >> +	pm8350_msm_therm {
> >> +		reg =3D <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
> >> +		label =3D "pm8350_msm_therm";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <200>;
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	pm8350_cam_flash_therm {
> >> +		reg =3D <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
> >> +		label =3D "pm8350_cam_flash_therm";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <200>;
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	pm8350_hot_pocket_therm {
> >> +		reg =3D <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
> >> +		label =3D "pm8350_hot_pocket_therm";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <200>;
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	pm8350_wide_rfc_therm {
> >> +		reg =3D <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
> >> +		label =3D "pm8350_wide_rfc_therm";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <200>;
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	pm8350_rear_tof_therm {
> >> +		reg =3D <PM8350_ADC7_AMUX_THM5_100K_PU(1)>;
> >> +		label =3D "pm8350_rear_tof_therm";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <200>;
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	pm8350b_usb_conn_therm {
> >> +		reg =3D <PM8350B_ADC7_AMUX_THM4_100K_PU>;
> >> +		label =3D "pm8350b_usb_conn_therm";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <200>;
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	pm8350b_wl_chg_therm {
> >> +		reg =3D <PM8350B_ADC7_GPIO2_100K_PU>;
> >> +		label =3D "pm8350b_wl_chg_therm";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <200>;
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	pm8350b_chg_temp {
> >> +		reg =3D <PM8350B_ADC7_CHG_TEMP>;
> >> +		label =3D "pm8350b_chg_temp";
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	pmr735a_ref_gnd {
> >> +		reg =3D <0x400>;
> >> +		label =3D "pmr735a_ref_gnd";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pmr735a_vref_1p25 {
> >> +		reg =3D <0x401>;
> >> +		label =3D "pmr735a_vref_1p25";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pmr735a_die_temp {
> >> +		reg =3D <0x403>;
> >> +		label =3D "pmr735a_die_temp";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pmr735b_ref_gnd {
> >> +		reg =3D <0x500>;
> >> +		label =3D "pmr735b_ref_gnd";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pmr735b_vref_1p25 {
> >> +		reg =3D <0x501>;
> >> +		label =3D "pmr735b_vref_1p25";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	pmr735b_die_temp {
> >> +		reg =3D <0x503>;
> >> +		label =3D "pmr735b_die_temp";
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	smb139x_1_smb_temp {
> >> +		reg =3D <SMB139x_1_ADC7_SMB_TEMP>;
> >> +		label =3D "smb139x_1_smb_temp";
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	smb139x_2_smb_temp {
> >> +		reg =3D <SMB139x_2_ADC7_SMB_TEMP>;
> >> +		label =3D "smb139x_2_smb_temp";
> >> +		qcom,pre-scaling =3D <1 1>;
> >> +	};
> >> +
> >> +	gpio1_v {
> >> +		reg =3D <0x128>;
> >> +		label =3D "gpio1_v";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0x2bc>;
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +
> >> +	gpio3_v {
> >> +		reg =3D <0x12b>;
> >> +		label =3D "gpio3_v";
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0x2bc>;
> >> +		qcom,pre-scaling =3D <0x01 0x01>;
> >> +	};
> >> +};
> >> +
> >> +&pmk8350_adc_tm {
> >> +	status =3D "okay";
> >> +
> >> +	pm8350_msm_therm {
> >> +		reg =3D <0x144>;
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >=20
> > Here also. Node name doesn't follow docs, missing io-channels (used her=
e
> > instead of reg), etc.
> >=20
> >> +	};
> >> +
> >> +	pm8350_cam_flash_therm {
> >> +		reg =3D <0x145>;
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >> +	};
> >> +
> >> +	pm8350_hot_pocket_therm {
> >> +		reg =3D <0x146>;
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >> +	};
> >> +
> >> +	pm8350_wide_rfc_therm {
> >> +		reg =3D <0x147>;
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >> +	};
> >> +
> >> +	pm8350_rear_tof_therm {
> >> +		reg =3D <0x148>;
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >> +	};
> >> +
> >> +	pm8350b_usb_conn_therm {
> >> +		reg =3D <0x347>;
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >> +	};
> >> +
> >> +	pm8350b_wl_chg_therm {
> >> +		reg =3D <0x34b>;
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >> +	};
> >> +
> >> +	pmk8350_xo_therm {
> >> +		reg =3D <0x44>;
> >> +		qcom,ratiometric;
> >> +		qcom,hw-settle-time =3D <0xc8>;
> >> +	};
> >> +};
> >> +
> >> +&pon_pwrkey {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&pon_resin {
> >> +	linux,code =3D <KEY_VOLUMEUP>;
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&qupv3_id_0 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&qupv3_id_1 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&qupv3_id_2 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&gpi_dma0 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&gpi_dma1 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&gpi_dma2 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&removed_mem {
> >> +	reg =3D <0x0 0xd8800000 0x0 0x8e00000>;
> >> +};
> >> +
> >> +&tlmm {
> >> +	gpio-reserved-ranges =3D <52 8>;
> >> +
> >> +	pcie0_default_state: pcie0-default-state {
> >> +		perst-pins {
> >> +			pins =3D "gpio94";
> >> +			function =3D "gpio";
> >> +			drive-strength =3D <2>;
> >> +			bias-pull-down;
> >> +		};
> >> +
> >> +		clkreq-pins {
> >> +			pins =3D "gpio95";
> >> +			function =3D "pcie0_clkreqn";
> >> +			drive-strength =3D <2>;
> >> +			bias-pull-up;
> >> +		};
> >> +
> >> +		wake-pins {
> >> +			pins =3D "gpio96";
> >> +			function =3D "gpio";
> >> +			drive-strength =3D <2>;
> >> +			bias-pull-up;
> >> +		};
> >> +
> >> +		sleep-pins {
> >> +			pins =3D "gpio95";
> >> +			function =3D "gpio";
> >> +			drive-strength =3D <2>;
> >> +			bias-pull-up;
> >> +		};
> >> +	};
> >> +
> >> +	pcie1_default_state: pcie1-default-state {
> >> +		perst-pins {
> >> +			pins =3D "gpio97";
> >> +			function =3D "gpio";
> >> +			drive-strength =3D <2>;
> >> +			bias-pull-down;
> >> +		};
> >> +
> >> +		clkreq-pins {
> >> +			pins =3D "gpio98";
> >> +			function =3D "pcie1_clkreqn";
> >> +			drive-strength =3D <2>;
> >> +			bias-pull-up;
> >> +		};
> >> +
> >> +		wake-pins {
> >> +			pins =3D "gpio99";
> >> +			function =3D "gpio";
> >> +			drive-strength =3D <2>;
> >> +			bias-pull-up;
> >> +			/* wil6210_refclk_en_pin lives here also */
> >> +		};
> >> +	};
> >> +
> >> +	tp_rst_active: tp_rst_active {
> >=20
> > Wrong node name and more below.
> >=20
> >> +		pins =3D "gpio22";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <8>;
> >> +		bias-pull-up;
> >> +	};
> >> +
> >> +	/* tp_rst_suspend pin is different per device, don't specify here */
> >> +
> >> +	tp_irq_active: tp_irq_active {
> >> +		pins =3D "gpio23";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <8>;
> >> +		bias-disable;
> >> +		input-enable;
> >> +	};
> >> +
> >> +	tp_irq_suspend: tp_irq_suspend {
> >> +		pins =3D "gpio23";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	sde_dsi_active: sde-dsi-active {
> >> +		pins =3D "gpio24";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <8>;
> >> +		bias-disable =3D <0>;
> >> +	};
> >> +
> >> +	sde_dsi_suspend: sde-dsi-suspend {
> >> +		pins =3D "gpio24";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	sde_te_active: sde-te-active {
> >> +		pins =3D "gpio82";
> >> +		function =3D "mdp_vsync";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	sde_te_suspend: sde-te-suspend {
> >> +		pins =3D "gpio82";
> >> +		function =3D "mdp_vsync";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	aw_irq: aw_irq {
> >> +		pins =3D "gpio14";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-up;
> >> +	};
> >> +
> >> +	aw_reset: aw_reset {
> >> +		pins =3D "gpio75";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-disable;
> >> +	};
> >=20
> > Skip unused pinctrl for now?
>
> Some of these I had meant to use but wasn't able to get everything quite=
=20
> working. Forgot to remove, sorry.
>
> >=20
> >> +
> >> +	display_panel_avdd_default: display_panel_avdd_default {
> >> +		pins =3D "gpio12";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <8>;
> >> +		bias-disable =3D <0>;
> >> +		output-high;
> >> +	};
> >> +
> >> +	/* Modem-related pin common on both devices */
> >> +	rf_cable_ant0_active: rf_cable_ant0_active {
> >> +		pins =3D "gpio165";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-up;
> >> +	};
> >> +
> >> +	usb_int_default: usb_int_default {
> >> +		pins =3D "gpio198";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-down;
> >> +		input-enable;
> >> +	};
> >> +
> >> +	qupv3_se18_default_cts: qupv3_se18_default_cts {
> >> +		pins =3D "gpio68";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-disable;
> >> +	};
> >> +
> >> +	qupv3_se18_default_rtsrx: qupv3_se18_default_rtsrx {
> >> +		pins =3D "gpio69", "gpio71";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	qupv3_se18_default_tx: qupv3_se18_default_tx {
> >> +		pins =3D "gpio70";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-up;
> >> +	};
> >> +
> >> +	qupv3_se18_ctsrx: qupv3_se18_ctsrx {
> >> +		pins =3D "gpio68", "gpio71";
> >> +		function =3D "qup18";
> >> +		drive-strength =3D <2>;
> >> +		bias-disable;
> >> +	};
> >> +
> >> +	qupv3_se18_rts: qupv3_se18_rts {
> >> +		pins =3D "gpio69";
> >> +		function =3D "qup18";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	qupv3_se18_tx: qupv3_se18_tx {
> >> +		pins =3D "gpio70";
> >> +		function =3D "qup18";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-up;
> >> +	};
> >> +
> >> +	usb3phy_portselect_default: usb3phy_portselect_default {
> >> +		pins =3D "gpio81";
> >> +		function =3D "usb_phy";
> >> +		drive-strength =3D <2>;
> >> +		bias-disable;
> >> +	};
> >> +
> >> +	usb3phy_portselect_gpio: usb3phy_portselect_gpio {
> >> +		pins =3D "gpio81";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-disable;
> >> +	};
> >> +
> >> +	ext1_otg_default: ext1_otg_default {
> >> +		pins =3D "gpio8";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <16>;
> >> +		bias-pull-down;
> >> +		input-enable;
> >> +	};
> >> +
> >> +	cnss_wlan_en_active: cnss_wlan_en_active {
> >> +		pins =3D "gpio64";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <16>;
> >> +		output-high;
> >> +		bias-pull-up;
> >> +	};
> >> +
> >> +	cnss_wlan_en_sleep: cnss_wlan_en_sleep {
> >> +		pins =3D "gpio64";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		output-low;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	bt_en_sleep: bt_en_sleep {
> >> +		pins =3D "gpio65";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		output-low;
> >> +		bias-pull-down;
> >> +	};
> >> +};
> >> +
> >> +&ufs_mem_hc {
> >> +	reset-gpios =3D <&tlmm 203 GPIO_ACTIVE_LOW>;
> >> +
> >> +	vcc-supply =3D <&pm8350_l7>;
> >> +	vcc-voltage-level =3D <2504000 2950000>;
> >> +	vcc-max-microamp =3D <800000>;
> >> +	vccq-supply =3D <&pm8350_l9>;
> >> +	vccq-max-microamp =3D <900000>;
> >> +
> >> +	qcom,vddp-ref-clk-supply =3D <&pm8350_l9>;
> >> +	qcom,vddp-ref-clk-max-microamp =3D <100>;
> >> +
> >> +	qcom,vddp-ref-clk-supply =3D <&pm8350_s12>;
> >> +	qcom,vccq-parent-max-microamp =3D <210000>;
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ufs_mem_phy {
> >> +	vdda-phy-supply =3D <&pm8350_l5>;
> >> +	vdda-phy-always-on;
> >=20
> > Property doesn't exist
> >=20
> >> +	vdda-max-microamp =3D <91600>;
> >> +	vdda-pll-supply =3D <&pm8350_l6>;
> >> +	vdda-pll-max-microamp =3D <19000>;
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&usb_1 {
> >> +	/* Bug in interconnect driver breaks USB */
> >> +	/delete-property/ interconnects;
> >> +	/delete-property/ interconnect-names;
> >=20
> > Any chance on fixing this? Or add some extra explanation? Not sure how
> > liked such workarounds are in dts files.
>
> Enabling that makes USB perma-broken as the regulators get stuck at off;=
=20
> I can investigate more if that would be necessary.
>
> >> +
> >> +	/*
> >> +	 * USB3 is not tested (though it is enabled downstream) so limit to
> >> +	 * high-speed for now.
> >> +	 */
> >> +	qcom,select-utmi-as-pipe-clk;
> >=20
> > You never plugged the device into a USB 3.0 port? Should be trivial to
> > test I think?
>
> Will test for v2.
>
> >=20
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&usb_1_dwc3 {
> >> +	/* Mode switching is untested */
> >> +	dr_mode =3D "peripheral";
> >> +	maximum-speed =3D "high-speed";
> >> +	phys =3D <&usb_1_hsphy>;
> >> +	phy-names =3D "usb2-phy";
> >> +};
> >> +
> >> +&usb_1_hsphy {
> >> +	vdda-pll-supply =3D <&pm8350_l5>;
> >> +	vdda18-supply =3D <&pm8350c_l1>;
> >> +	vdda33-supply =3D <&pm8350_l2>;
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +/* Enabling this is necessary only for displayport */
> >=20
> > Do you have displayport support with this dts? If not why enable it?
>
> Fair enough, no. Panel driver is still WIP, will upstream this bit when=
=20
> that's working.
>
> >=20
> >> +&usb_1_qmpphy {
> >> +	vdda-phy-supply =3D <&pm8350_l6>;
> >> +	vdda-pll-supply =3D <&pm8350_l1>;
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&i2c2 {
> >> +	clock-frequency =3D <100000>;
> >> +	status =3D "okay";
> >> +
> >> +	bq27541: fuel-gauge@55 {
> >> +		compatible =3D "ti,bq27541";
> >> +		reg =3D <0x55>;
> >> +		monitored-battery =3D <&bat>;
> >> +	};
> >> +};
> >> +/* Crypto drivers currently fail & cause an XPU violation */
> >=20
> > Missing newline between nodes.
> >=20
> >> +&cryptobam {
> >> +	status =3D "disabled";
> >> +};
> >> +
> >> +&crypto {
> >> +	status =3D "disabled";
> >> +};
> >=20
> > These disables are not useful since they're already disabled in
> > sm8350.dtsi because of that problem.
>
> This was here before that fix landed, but I missed it; will remove.
>
> >=20
> >> +
> >> +&pcie0 {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-0 =3D <&pcie0_default_state>;
> >> +
> >> +	perst-gpios =3D <&tlmm 94 GPIO_ACTIVE_HIGH>;
> >> +	wake-gpios =3D <&tlmm 96 GPIO_ACTIVE_HIGH>;
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&pcie0_phy {
> >> +	vdda-phy-supply =3D <&pm8350_l5>;
> >> +	vdda-pll-supply =3D <&pm8350_l6>;
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&pcie1 {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-0 =3D <&pcie1_default_state>;
> >> +
> >> +	perst-gpios =3D <&tlmm 97 GPIO_ACTIVE_HIGH>;
> >> +	wake-gpios =3D <&tlmm 99 GPIO_ACTIVE_HIGH>;
> >> +
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&pcie1_phy {
> >> +	vdda-phy-supply =3D <&pm8350_l5>;
> >> +	vdda-pll-supply =3D <&pm8350_l6>;
> >> +
> >> +	status =3D "okay";
> >> +};
> >=20
> > Everywhere in this file make sure the nodes are sorted alphabetically,
> > it's a wild west right now.
>
> Understandable, will do.
>
> >=20
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts b/ar=
ch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts
> >> new file mode 100644
> >> index 000000000000..f2c27894f3c4
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts
> >> @@ -0,0 +1,82 @@
> >> +// SPDX-License-Identifier: BSD-3-Clause
> >> +/*
> >> + * Copyright (c) 2023 Igalia S.L.
> >> + * Authors:
> >> + *	Nia Espera <nespera@igalia.com>
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "sm8350-oneplus-common.dtsi"
> >> +
> >> +/ {
> >> +	model =3D "OnePlus 9";
> >> +	compatible =3D "oneplus,lemonade", "qcom,sm8350";
> >> +};
> >> +
> >> +&i2c4 {
> >> +	touchscreen@48 {
> >> +		compatible =3D "samsung,s6sy761";
> >> +		reg =3D <0x48>;
> >> +		interrupts-extended =3D <&tlmm 23 0x2008>;
> >=20
> > Replace the 0x2008 with the GPIO_* flags from include/dt-bindings/gpio/=
gpio.h
>
> There doesn't seem to be a flag for 0x2000 and it's not documented=20
> downstream; is it okay to replace with (0x2000|GPIO_TRANSITORY)?

As Krzysztof already replied, my fault, should be the defines from irq.h
since this is obviously an interrupt, not a gpio property.

Regards
Luca

>
> >=20
> >> +
> >> +		vdd-supply =3D <&pm8350c_l8>;
> >> +		avdd-supply =3D <&pm8350c_l13>;
> >> +
> >> +		pinctrl-names =3D "default", "sleep";
> >> +		pinctrl-0 =3D <&tp_rst_active &tp_irq_active>;
> >> +		pinctrl-1 =3D <&tp_rst_suspend &tp_irq_suspend>;
> >> +	};
> >> +};
> >> +
> >> +&tlmm {
> >> +	tp_rst_suspend: tp_rst_suspend {
> >> +		pins =3D "gpio22";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	tp_enable_2v8: tp_enable_2v8 {
> >> +		pins =3D "gpio74";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <8>;
> >> +		bias-pull-up;
> >> +		output-high;
> >> +	};
> >=20
> > Some pinctrl comments as in the .dtsi file
> >=20
> >> +
> >> +	/* Modem antenna pins exclusive to lemonade */
> >> +	rf_cable_ant1_active: rf_cable_ant1_active {
> >> +		pins =3D "gpio27";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-up;
> >> +	};
> >> +	rf_cable_ant2_active: rf_cable_ant2_active {
> >> +		pins =3D "gpio92";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-up;
> >> +	};
> >> +	rf_cable_ant3_active: rf_cable_ant3_active {
> >> +		pins =3D "gpio44";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-up;
> >> +	};
> >> +	rf_cable_ant7_active: rf_cable_ant7_active {
> >> +		pins =3D "gpio155";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <2>;
> >> +		bias-pull-up;
> >> +	};
> >> +};
> >> +
> >> +&mpss {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-1 =3D <&rf_cable_ant0_active
> >> +		     &rf_cable_ant1_active
> >> +		     &rf_cable_ant2_active
> >> +		     &rf_cable_ant3_active
> >> +		     &rf_cable_ant7_active>;
> >> +};
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts b/a=
rch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts
> >> new file mode 100644
> >> index 000000000000..de8597d26091
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts
> >> @@ -0,0 +1,37 @@
> >> +// SPDX-License-Identifier: BSD-3-Clause
> >> +/*
> >> + * Copyright (c) 2023 Igalia S.L.
> >> + * Authors:
> >> + *	Nia Espera <nespera@igalia.com>
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "sm8350-oneplus-common.dtsi"
> >> +
> >> +/ {
> >> +	model =3D "OnePlus 9 Pro";
> >> +	compatible =3D "oneplus,lemonadep", "qcom,sm8350";
> >> +};
> >> +
> >> +&tlmm {
> >> +	tp_rst_suspend: tp_rst_suspend {
> >> +		pins =3D "gpio22";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <8>;
> >> +		bias-pull-down;
> >> +	};
> >> +
> >> +	tp_enable_2v8: tp_enable_2v8 {
> >> +		pins =3D "gpio31";
> >> +		function =3D "gpio";
> >> +		drive-strength =3D <8>;
> >> +		bias-pull-up;
> >> +		output-high;
> >> +	};
> >=20
> > And don't forget about fixing the nodes here. But why define them now i=
f
> > you don't have any users of them?
>
> Oopsies- same as previous pins, op9p touchscreen isn't ready yet and I=20
> left these in.
>
> >=20
> >> +};
> >> +
> >> +&mpss {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-1 =3D <&rf_cable_ant0_active>;
> >> +};
> >=20
> > I'm sure others will have more comments but fixing the comments I added
> > is a good step forward :)
>
> Thanks for your time! I'll fix up everything mentioned.
>
> >=20
> > Regards
> > Luca

