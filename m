Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333367CAB91
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjJPOdj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjJPOdh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 10:33:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305FEA
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 07:33:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso6940122a12.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697466812; x=1698071612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9cl0XfvFGjZ0mqviaREEg8s3S3kUfmqVuMt9DyXc4w=;
        b=v2/A+YX3CQs2o4ZwMir1Mnidixkzi2QzekDZZ0O6J1+xVlv23vT7Tuy1wMF4Bq9MQV
         zrjEM2UHcS7kGG5bJYyY1ldL6r1hpl75Ad/yJDWRoeHYtAT2THXP5svRgzN7owQS5cIQ
         TVVj/y50SYfqx3ppDBlAx4ZiTpgGomDfkL0QILbo5vHuXdaiIdCCvjd8IGL7wmYX2gxF
         mMZBiSbO6eez8GsmpQNcQcGVu9+1j3p4O1+k9UQN/bJAVp0xb6vj7UfKTZRONPBR0OwG
         w6YdxilxVsSrhfzHNiW1wmXRI/4/kyp5YXrAnGWLiYRmJS+VZVhsMPet2rfAdM20VBYR
         zyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697466812; x=1698071612;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9cl0XfvFGjZ0mqviaREEg8s3S3kUfmqVuMt9DyXc4w=;
        b=wymxdkTDiM7SKJllV6oVO8FretMeiNySYPoQUD5GvrIDVmjRKZw4NcOHJcz47x9XkJ
         s2PgEmGkPDfmmMT8BFnucvwr9uEaB88T+jS0WJXoxsr6BGULf/DD7FIWzn8bjPF9WoZD
         UhJ+XTpWJ+Wlv11a8Bt/WIrF4mLaEpyCD04rMFRa9SWfVpG6YGliOjW9ITP2h23nLKDd
         a4ZZANhtmnQkd+M3bKbbYWL+4sucMxGB6+YGcLUXYQF20f5uO1YZj7NkmsJP7cjVrj2u
         wP3LxxI1OJQTULiYTlcCJdtQXXkrA2InAF2fXEl8cJmHuWYebEMS8zKLYn6VOowUFjqF
         qxuQ==
X-Gm-Message-State: AOJu0YzburyLu7d0gVMtBzglHnKKw0VyPKMN9T//jgwboeiPm/GLdxO0
        fR+nU1ci4rnJmcf9+41GWkNfhA==
X-Google-Smtp-Source: AGHT+IFyslTLdtWQZke/7rtFGYyKU93k4ENx8+WP6tj6Xir/n8aujyNL4Zw2dxteSst2mumDrkqtYA==
X-Received: by 2002:a17:906:1ca:b0:9a5:9f3c:9615 with SMTP id 10-20020a17090601ca00b009a59f3c9615mr25894460ejj.63.1697466812422;
        Mon, 16 Oct 2023 07:33:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id gw11-20020a170906f14b00b0098669cc16b2sm4105580ejb.83.2023.10.16.07.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:33:31 -0700 (PDT)
Message-ID: <3a57e697-3958-4f6b-912d-e2ee0c41d4a1@linaro.org>
Date:   Mon, 16 Oct 2023 16:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8350-lemonade(p): new devices
Content-Language: en-US
To:     Nia Espera <nespera@igalia.com>, Andy Gross <agross@kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231016-nia-sm8350-for-upstream-v1-5-bb557a0af2e9@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 16/10/2023 14:47, Nia Espera wrote:
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

...

> +};
> +
> +&pmk8350_adc_tm {
> +	status = "okay";
> +
> +	pm8350_msm_therm {

No, underscores are not allowed. Do not usptream junky DTS from
downstream. Instead take upstream, good quality DTS and customize it.
Why do we need to point the issue fixed long, long time ago?


> +		reg = <0x144>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <0xc8>;
> +	};
> +
> +	pm8350_cam_flash_therm {
> +		reg = <0x145>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <0xc8>;
> +	};
> +
> +	pm8350_hot_pocket_therm {
> +		reg = <0x146>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <0xc8>;
> +	};
> +
> +	pm8350_wide_rfc_therm {
> +		reg = <0x147>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <0xc8>;
> +	};
> +
> +	pm8350_rear_tof_therm {
> +		reg = <0x148>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <0xc8>;
> +	};
> +
> +	pm8350b_usb_conn_therm {
> +		reg = <0x347>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <0xc8>;
> +	};
> +
> +	pm8350b_wl_chg_therm {
> +		reg = <0x34b>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <0xc8>;
> +	};
> +
> +	pmk8350_xo_therm {
> +		reg = <0x44>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <0xc8>;
> +	};
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEUP>;
> +	status = "okay";
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&qupv3_id_2 {
> +	status = "okay";
> +};
> +
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
> +&removed_mem {

Hm, what is removed_mem?

> +	reg = <0x0 0xd8800000 0x0 0x8e00000>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <52 8>;
> +
> +	pcie0_default_state: pcie0-default-state {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +		perst-pins {
> +			pins = "gpio94";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +


> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts
> new file mode 100644
> index 000000000000..f2c27894f3c4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Igalia S.L.
> + * Authors:
> + *	Nia Espera <nespera@igalia.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm8350-oneplus-common.dtsi"
> +
> +/ {
> +	model = "OnePlus 9";
> +	compatible = "oneplus,lemonade", "qcom,sm8350";
> +};
> +
> +&i2c4 {
> +	touchscreen@48 {
> +		compatible = "samsung,s6sy761";
> +		reg = <0x48>;
> +		interrupts-extended = <&tlmm 23 0x2008>;
> +
> +		vdd-supply = <&pm8350c_l8>;
> +		avdd-supply = <&pm8350c_l13>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&tp_rst_active &tp_irq_active>;

Multiple phandles <>, not one.

> +		pinctrl-1 = <&tp_rst_suspend &tp_irq_suspend>;
> +	};
> +};
> +
> +&tlmm {
> +	tp_rst_suspend: tp_rst_suspend {

Ehh...
> +		pins = "gpio22";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	tp_enable_2v8: tp_enable_2v8 {
> +		pins = "gpio74";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +		output-high;
> +	};
> +
> +	/* Modem antenna pins exclusive to lemonade */
> +	rf_cable_ant1_active: rf_cable_ant1_active {
> +		pins = "gpio27";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +	rf_cable_ant2_active: rf_cable_ant2_active {
> +		pins = "gpio92";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +	rf_cable_ant3_active: rf_cable_ant3_active {
> +		pins = "gpio44";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +	rf_cable_ant7_active: rf_cable_ant7_active {
> +		pins = "gpio155";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&mpss {

Wrong order. t is after m

> +	pinctrl-names = "default";
> +	pinctrl-1 = <&rf_cable_ant0_active

Same problem.

> +		     &rf_cable_ant1_active
> +		     &rf_cable_ant2_active
> +		     &rf_cable_ant3_active
> +		     &rf_cable_ant7_active>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts
> new file mode 100644
> index 000000000000..de8597d26091
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Igalia S.L.
> + * Authors:
> + *	Nia Espera <nespera@igalia.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm8350-oneplus-common.dtsi"
> +
> +/ {
> +	model = "OnePlus 9 Pro";
> +	compatible = "oneplus,lemonadep", "qcom,sm8350";

Missing bindings.

> +};
> +
> +&tlmm {
> +	tp_rst_suspend: tp_rst_suspend {

No underscores in node names. This wasn't tested.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).



Best regards,
Krzysztof

