Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8131D6D41A1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjDCKOi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 06:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjDCKOg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 06:14:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021ED65BC
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 03:14:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y20so37398976lfj.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680516872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Na57ZHj0VVWc1XAS5PcpihHRU75SwpkIAHxgRH3hVYk=;
        b=cSfy2YRKuy2PT65PPZrIb+dh0RQRv/5f2zuxFj00lpE0ApF+Toxbrs/3RUSms5s0YD
         nJUDQwNNSKN19kN4kb90qKwu+TsKgq0IvF34pzOFZjhBB18cD9FtxmIuH8sFQX1JOYcv
         TiqOMQnIM5HaehSgf6tC0A0+zMEfw4NmgjcH35PluGqOekwdBQj1Km+hzWRxOql6pVbZ
         +WMncG1mmd1JgKxuXZ9L2gxPoqQau6OEfvDxAs57O+p4VOcx5mKlywX8dg4uUMjSfZ46
         w3l2NqNeFCIr1BL/qyP4j7g7N+WjQtwAhSuMwpuTrct3hbDZ4xUhlO4saVufUTd0Dbws
         +z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680516872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na57ZHj0VVWc1XAS5PcpihHRU75SwpkIAHxgRH3hVYk=;
        b=6NCMKSrWZ4zTXW8BEuwRQATpKbYS9Rsf1UsvqmEzbb1BjUDxzoLNiIpRlUzXRXWJqs
         dbpZnMyrCanc1csfC6omrdGTzN5HBPCBFf1WAltqlskpkkEjxi8anTLKXxR7DuFa63sb
         dxaG+YwQYzCd2K5SU8vOCV0etTRdDXM25Typ9CUh5BDS6Mz75vantIuEZiu3LjjucebF
         Kzb1RIWhZrcYuYZN9Su3a96O5mK+muSLiVNLrmK8pjBParJVb9yF8oEfHjIrqzBaDBHU
         afWqCjLFd4yHynzIELFVnS6dpn4etf1x7Zo7g6uG3Osd7avsMSczIEZwlKbYnBjWSwNx
         hycg==
X-Gm-Message-State: AAQBX9dWi+92a+i2x3vt+tUxVUM/9Sdaj4iCEHlHD/n5VdXyIzOOqqIx
        8x4MT6OCPsWlE5FopVCFgVbBUQ==
X-Google-Smtp-Source: AKy350bN0bYuQcO9F3MW9FJNtiAGFiQqGEEEbFnqdNUiiB4nMH6iU1Q5a7MO8pI0UE4jeVkwrbQ0+Q==
X-Received: by 2002:ac2:43a4:0:b0:4ea:f526:5bee with SMTP id t4-20020ac243a4000000b004eaf5265beemr8882116lfl.11.1680516872273;
        Mon, 03 Apr 2023 03:14:32 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id j18-20020a19f512000000b004eb2eb63144sm1618158lfb.120.2023.04.03.03.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:14:31 -0700 (PDT)
Message-ID: <e6d47121-fb3f-7536-1f73-923fc489e6aa@linaro.org>
Date:   Mon, 3 Apr 2023 12:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 09/22] arm64: dts: qcom: pmk8350: allow overriding the
 label
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-10-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230401220810.3563708-10-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2.04.2023 00:07, Dmitry Baryshkov wrote:
> sc8280xp-pmics.dtsi incorporates a copy of pmk8350, but the dts files
> use labels following the markings found in the schematics. Allow
> overriding the labels in pmk8350.dtsi.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi | 13 +++++++++
>  arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi | 14 ++++++++++
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi         | 28 +++++++++++--------
>  3 files changed, 44 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> new file mode 100644
> index 000000000000..1c81269f0783
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/* cleanly revert the effects pmic-dyn-header.dtsi */
> +
> +#undef LABEL
> +#undef _LABEL
> +#undef __LABEL
> +
> +#undef PMIC_SID
> +#undef PMIC_LABEL
> diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> new file mode 100644
> index 000000000000..75f0448568bd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/*
> + * Preprocessor symbols to assist in describing PMICs which have configurable
> + * SID. All effects of this header (or its parameters) must be reverted in
> + * pmic-dyn-footer.dtsi.
> + */
> +
> +#define LABEL(name) _LABEL(PMIC_LABEL, name)
> +#define _LABEL(pmic, name) __LABEL(pmic, name)
> +#define __LABEL(pmic, name) pmic ## _ ## name
#define PMIC_LABEL pmk8350
#define LABEL(name) PMIC_LABEL##_##name

?

Konrad
> diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> index 02e7518ab57b..f26ff3daf119 100644
> --- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> @@ -13,33 +13,39 @@
>  	#define PMIC_SID 0
>  #endif
>  
> +#ifndef PMIC_LABEL
> +#define PMIC_LABEL pmk8350
> +#endif
> +
> +#include "pmic-dyn-header.dtsi"
> +
>  &spmi_bus {
> -	pmk8350: pmic@PMIC_SID {
> +	PMIC_LABEL: pmic@PMIC_SID {
>  		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
>  		reg = <PMIC_SID SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		pmk8350_pon: pon@1300 {
> +		LABEL(pon): pon@1300 {
>  			compatible = "qcom,pmk8350-pon";
>  			reg = <0x1300>, <0x800>;
>  			reg-names = "hlos", "pbs";
>  
> -			pmk8350_pon_pwrkey: pwrkey {
> +			LABEL(pon_pwrkey): pwrkey {
>  				compatible = "qcom,pmk8350-pwrkey";
>  				interrupts = <PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
>  				linux,code = <KEY_POWER>;
>  				status = "disabled";
>  			};
>  
> -			pmk8350_pon_resin: resin {
> +			LABEL(pon_resin): resin {
>  				compatible = "qcom,pmk8350-resin";
>  				interrupts = <PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
>  				status = "disabled";
>  			};
>  		};
>  
> -		pmk8350_vadc: adc@3100 {
> +		LABEL(vadc): adc@3100 {
>  			compatible = "qcom,spmi-adc7";
>  			reg = <0x3100>;
>  			#address-cells = <1>;
> @@ -48,7 +54,7 @@ pmk8350_vadc: adc@3100 {
>  			#io-channel-cells = <1>;
>  		};
>  
> -		pmk8350_adc_tm: adc-tm@3400 {
> +		LABEL(adc_tm): adc-tm@3400 {
>  			compatible = "qcom,adc-tm7";
>  			reg = <0x3400>;
>  			interrupts = <PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> @@ -58,7 +64,7 @@ pmk8350_adc_tm: adc-tm@3400 {
>  			status = "disabled";
>  		};
>  
> -		pmk8350_rtc: rtc@6100 {
> +		LABEL(rtc): rtc@6100 {
>  			compatible = "qcom,pmk8350-rtc";
>  			reg = <0x6100>, <0x6200>;
>  			reg-names = "rtc", "alarm";
> @@ -66,7 +72,7 @@ pmk8350_rtc: rtc@6100 {
>  			status = "disabled";
>  		};
>  
> -		pmk8350_sdam_6: nvram@8500 {
> +		LABEL(sdam_6): nvram@8500 {
>  			compatible = "qcom,spmi-sdam";
>  			reg = <0x8500>;
>  			#address-cells = <1>;
> @@ -75,11 +81,11 @@ pmk8350_sdam_6: nvram@8500 {
>  			status = "disabled";
>  		};
>  
> -		pmk8350_gpios: gpio@b000 {
> +		LABEL(gpios): gpio@b000 {
>  			compatible = "qcom,pmk8350-gpio", "qcom,spmi-gpio";
>  			reg = <0xb000>;
>  			gpio-controller;
> -			gpio-ranges = <&pmk8350_gpios 0 0 4>;
> +			gpio-ranges = <&LABEL(gpios) 0 0 4>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> @@ -87,4 +93,4 @@ pmk8350_gpios: gpio@b000 {
>  	};
>  };
>  
> -#undef PMIC_SID
> +#include "pmic-dyn-footer.dtsi"
