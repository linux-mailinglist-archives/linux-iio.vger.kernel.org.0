Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045B96D4199
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjDCKL3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDCKL2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 06:11:28 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2459C1
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 03:11:27 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx10so11420967ljb.8
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680516685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GInAhPmAIwgyWtRDsv1xjQw8pq+TotAdGvzqjVLYP9k=;
        b=Cg5s0h9X6s81/uZKXczbiHg3kaG9ZwKs1NK+8gyb+Bq67lcR64ma32YSyqtsEHaEch
         BMhnMFqiKQj3j/oS7KmEWMztowkuK96yN8YP9IPrh3O2KBuxZ8vKfOzX80nhWEIGaHmx
         C92jEdTNzzzopG6oiuwysYpx2EIeNu/iNJRlNkWhOqPs3nLe1UNb9oqVlGX+FVe9kPZH
         R2xu6MGq366vQFGMRG8vdSzRUGHbNsRYN5944ydzJOfKteQmsOFYWZgRtFI7DXNa+TyU
         eJs/MuY6r0SVhSo2Z0l5kdbB3+DQDylucIpr8RfhzaE59NU9K2Yt+lI0iNKY4GFjMfUy
         uRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680516685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GInAhPmAIwgyWtRDsv1xjQw8pq+TotAdGvzqjVLYP9k=;
        b=XVqtx/DGZ8yvRNGRlvrX/rfeYK3XwT7XJixpmJ+6D7IlB5fAlGDG1SDOkBh7fnXifc
         MVsnMMGFYh+wTmm/pgxUSdSTE+fZd1OkBMQh1MMiVioCBsphM84ifxsP7m+Lr3rkCYh3
         VRJVo50+ukhwiDuJiOySa4OUhGycoU3bAIasFrBZ0+nPKCKC48IHQi6sK5latNvoTJ/v
         YgDVPACDF10FPCOhXynKSon3qUqIsomfEgbG6KX9RSrl0MSyK8aePxjBdf5rX1l2Bzc6
         KqhhO6Ai5h08pZXEge97vcRqwxevJL8hx61dkbqrjvBx9VU0W8X8N7wkypPAZyCdcHO8
         ZYsQ==
X-Gm-Message-State: AAQBX9fgLQFIoogbjxaWLA/rl2q14c8/3EMbL4Ibw+cqdvLvJ+lSStc2
        5eYUb31RuHd5XvnTY7RbNH+IRQ==
X-Google-Smtp-Source: AKy350aFRkjtx77M2RZsQECcEWJinLuiqHTd7ANg3/4+RZsKuDT75xM4j9Q+C/NcS2N7ZusUKtMTIQ==
X-Received: by 2002:a2e:904b:0:b0:299:ac61:dedd with SMTP id n11-20020a2e904b000000b00299ac61deddmr11531501ljg.40.1680516685390;
        Mon, 03 Apr 2023 03:11:25 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id w14-20020a2e9bce000000b00295a5aa9d05sm1651282ljj.120.2023.04.03.03.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:11:25 -0700 (PDT)
Message-ID: <6a33e0da-49fe-b5d2-35e7-9854505978a6@linaro.org>
Date:   Mon, 3 Apr 2023 12:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 08/22] arm64: dts: qcom: pmk8350: rename PMK8350_SID to
 PMIC_SID
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
 <20230401220810.3563708-9-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230401220810.3563708-9-dmitry.baryshkov@linaro.org>
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
> Several next patches are going to introduce flexibility into several
> other PMICs in order to support variable SID and node labels. This will
> result in close duplication of several similar preprocessor
> constructions. Having a 
drop the 'a'

per-PMIC defines would be error prone and can
> result in hard-to-notices
hard-to-notice

 mistakes. Thus rename PMK8350_SID to a generic
> PMIC_SID.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi         | 20 ++++++++++---------
>  .../qcom/sm6375-sony-xperia-murray-pdx225.dts |  7 ++++---
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  6 +++---
>  3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> index 26e40dbfc173..02e7518ab57b 100644
> --- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> @@ -9,14 +9,14 @@
>  #include <dt-bindings/spmi/spmi.h>
>  
>  /* (Sadly) this PMIC can be configured to be at different SIDs */
> -#ifndef PMK8350_SID
> -	#define PMK8350_SID 0
> +#ifndef PMIC_SID
> +	#define PMIC_SID 0
>  #endif
>  
>  &spmi_bus {
> -	pmk8350: pmic@PMK8350_SID {
> +	pmk8350: pmic@PMIC_SID {
>  		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
> -		reg = <PMK8350_SID SPMI_USID>;
> +		reg = <PMIC_SID SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> @@ -27,14 +27,14 @@ pmk8350_pon: pon@1300 {
>  
>  			pmk8350_pon_pwrkey: pwrkey {
>  				compatible = "qcom,pmk8350-pwrkey";
> -				interrupts = <PMK8350_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				interrupts = <PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
>  				linux,code = <KEY_POWER>;
>  				status = "disabled";
>  			};
>  
>  			pmk8350_pon_resin: resin {
>  				compatible = "qcom,pmk8350-resin";
> -				interrupts = <PMK8350_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				interrupts = <PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
>  				status = "disabled";
>  			};
>  		};
> @@ -44,14 +44,14 @@ pmk8350_vadc: adc@3100 {
>  			reg = <0x3100>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <PMK8350_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			interrupts = <PMIC_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  			#io-channel-cells = <1>;
>  		};
>  
>  		pmk8350_adc_tm: adc-tm@3400 {
>  			compatible = "qcom,adc-tm7";
>  			reg = <0x3400>;
> -			interrupts = <PMK8350_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> +			interrupts = <PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			#thermal-sensor-cells = <1>;
> @@ -62,7 +62,7 @@ pmk8350_rtc: rtc@6100 {
>  			compatible = "qcom,pmk8350-rtc";
>  			reg = <0x6100>, <0x6200>;
>  			reg-names = "rtc", "alarm";
> -			interrupts = <PMK8350_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
> +			interrupts = <PMIC_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
>  			status = "disabled";
>  		};
>  
> @@ -86,3 +86,5 @@ pmk8350_gpios: gpio@b000 {
>  		};
>  	};
>  };
> +
> +#undef PMIC_SID
> diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
> index b691c3834b6b..863fc1f4b0b6 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
> @@ -5,13 +5,14 @@
>  
>  /dts-v1/;
>  
> -/* PMK8350 is configured to use SID6 instead of 0 */
> -#define PMK8350_SID 6
> -
>  #include <dt-bindings/gpio/gpio.h>
>  #include "sm6375.dtsi"
>  #include "pm6125.dtsi"
> +
> +/* PMK8350 is configured to use SID6 instead of 0 */
> +#define PMIC_SID 6
>  #include "pmk8350.dtsi"
> +
>  #include "pmr735a.dtsi"
>  
>  /* PM6125 PON is used and we can't have duplicate labels */
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index af6cf4fbddc7..965b37245007 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -5,9 +5,6 @@
>  
>  /dts-v1/;
>  
> -/* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0 */
> -#define PMK8350_SID 6
> -
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/input/input.h>
> @@ -18,6 +15,9 @@
>  #include "pm6150l.dtsi"
>  #include "pm6350.dtsi"
>  #include "pm7250b.dtsi"
> +
> +/* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0 */
> +#define PMIC_SID 6
>  #include "pmk8350.dtsi"
>  
>  / {
