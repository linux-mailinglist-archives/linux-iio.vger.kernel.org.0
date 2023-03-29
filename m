Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB96CCEA8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjC2AVI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2AVI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:21:08 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB351BF6
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:21:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y35so11862733ljq.4
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680049264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Yv+4+rojIx0/DMTZ2oZjQ4of/uoIMErYg/VElerO+o=;
        b=u39uBkOIe03pbUlBbU097LRrcOyEOYP0NeuYwpqyc9Q/WceYyLsPHNr14tV3sS9+SY
         6YWVnfHf9irl6R4O+BYj/Jz0Gz/WNyCdPWNILZrHgvnFndHnz4Qjo4zGiT7K8msJZl1N
         Y+Ax9QjjlG065XaQ1iv3Fy5/pIubh8AkondGDI1xbM9VfU1AOUBeYcH/brh3vds2Ykob
         J8KTVVUQt2ZevihCETKVzuEGpEEanzk8JdXhaZ++6dJ9wi5XeFtLox9IAD9KqEgCWanw
         shOAZIxx63ub/5bNjq7aV6sRYoSylEZR0W0PNlfv2uRKIzjcQThaE0CDlqAqVahSz7/+
         3gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680049264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Yv+4+rojIx0/DMTZ2oZjQ4of/uoIMErYg/VElerO+o=;
        b=43glxpm3xd8hDspghBQmWjv9F+aoUHn8FrNb1HnZPgh2/vTBGnWgcftjCHEgiQzuFf
         5nGupfQOba/FKMtKe7Z/0UDDd0Hhng9xtyl8/jvPc81KLvH5GFBUsVRBWE59aLAuhASJ
         DBI2YMW8uDaR/SkMOTaTbkWjKMaAWgUKtOz2SsVjDPKDuaumhLE9HnGpMn8oLP9EHcfp
         BzazyS9oaDDeAYlZ2aUuQ5zr5sA2WtkkTtZmY2J5gxLFEx5wsnzPTXgVVm/IaOYqPIXk
         aUYtTOVXPKC5NN5EiQk7E9RtgilN75n18psS2TWDAzs7Mei46f/Mfur9r393BWmt1Fu+
         +PSw==
X-Gm-Message-State: AAQBX9c7FT2B2Ov9cooPiTsw6KJcsfhPZgHPEmSIpbFww2DwM4Qxb95b
        YgdMwiipFBQ+yLuy/4wsxNtVPw==
X-Google-Smtp-Source: AKy350ZBEkL34AEiSRudLefIgRPIcKCrBId08FtvCqyPeONNbmyGo4ecdv7ogR90FtJfjsVm1xsZjg==
X-Received: by 2002:a05:651c:1028:b0:2a2:c618:1f51 with SMTP id w8-20020a05651c102800b002a2c6181f51mr5201906ljm.24.1680049264560;
        Tue, 28 Mar 2023 17:21:04 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id b17-20020a2e9891000000b0029bd1e3f9easm4672440ljj.32.2023.03.28.17.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 17:21:04 -0700 (PDT)
Message-ID: <6da7382d-dbf2-e1cb-550e-6c5bb38c8974@linaro.org>
Date:   Wed, 29 Mar 2023 02:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/6] dt-bindings: iio: qcom,spmi-adc7-pmk8350.h: include
 sid into defines
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
 <20230329000833.2507594-2-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230329000833.2507594-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 29.03.2023 02:08, Dmitry Baryshkov wrote:
> pmk8350 can take different addresses on SPMI bus. Rather than having a
> default SID, follow the pm8350's example and make the sid explicit when
> specifying ADC channels.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  2 +-
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  4 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  2 +-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  4 +-
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  2 +-
>  .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  | 52 +++++++++----------
>  7 files changed, 32 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index bd6e0d6f6e0c..df317901e7d0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -293,7 +293,7 @@ examples:
>  
>              /* Other properties are omitted */
>              xo-therm@44 {
> -                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
>              };
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> index 52ec18cf1eda..ff07d27775dc 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -218,7 +218,7 @@ examples:
>  
>              /* Other properties are omitted */
>              xo-therm@44 {
> -                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
>              };
> @@ -240,7 +240,7 @@ examples:
>  
>              pmk8350-xo-therm@0 {
>                  reg = <0>;
> -                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>                  qcom,decimation = <340>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time-us = <200>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 5dc9bee28e7f..14c9bdaa46ed 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -433,7 +433,7 @@ &pcie1_phy {
>  
>  &pmk8350_vadc {
>  	pmk8350-die-temp@3 {
> -		reg = <PMK8350_ADC7_DIE_TEMP>;
> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>  		label = "pmk8350_die_temp";
>  		qcom,pre-scaling = <1 1>;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index cb0cc2ba2fa3..e3919e074ebd 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -389,7 +389,7 @@ &pm8350c_pwm {
>  
>  &pmk8350_vadc {
>  	pmk8350-die-temp@3 {
> -		reg = <PMK8350_ADC7_DIE_TEMP>;
> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>  		label = "pmk8350_die_temp";
>  		qcom,pre-scaling = <1 1>;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 46c7fdafb840..590400985055 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -824,13 +824,13 @@ &pmk8280_vadc {
>  	status = "okay";
>  
>  	pmic-die-temp@3 {
> -		reg = <PMK8350_ADC7_DIE_TEMP>;
> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>  		qcom,pre-scaling = <1 1>;
>  		label = "pmk8350_die_temp";
>  	};
>  
>  	xo-therm@44 {
> -		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
>  		label = "pmk8350_xo_therm";
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index 7ae6aba5d2ec..af6cf4fbddc7 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -516,7 +516,7 @@ &pmk8350_rtc {
>  
>  &pmk8350_vadc {
>  	adc-chan@644 {
> -		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  		qcom,pre-scaling = <1 1>;
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
> index 6c296870e95b..ca85a2d69453 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
> +++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
> @@ -6,41 +6,37 @@
>  #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
>  #define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
>  
> -#ifndef PMK8350_SID
> -#define PMK8350_SID					0
> -#endif
> -
>  /* ADC channels for PMK8350_ADC for PMIC7 */
> -#define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | 0x0)
> -#define PMK8350_ADC7_1P25VREF			(PMK8350_SID << 8 | 0x01)
> -#define PMK8350_ADC7_VREF_VADC			(PMK8350_SID << 8 | 0x02)
> -#define PMK8350_ADC7_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
> +#define PMK8350_ADC7_REF_GND(sid)			((sid) << 8 | 0x0)
> +#define PMK8350_ADC7_1P25VREF(sid)			((sid) << 8 | 0x01)
> +#define PMK8350_ADC7_VREF_VADC(sid)			((sid) << 8 | 0x02)
> +#define PMK8350_ADC7_DIE_TEMP(sid)			((sid) << 8 | 0x03)
>  
> -#define PMK8350_ADC7_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
> -#define PMK8350_ADC7_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
> -#define PMK8350_ADC7_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
> -#define PMK8350_ADC7_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
> -#define PMK8350_ADC7_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
> +#define PMK8350_ADC7_AMUX_THM1(sid)			((sid) << 8 | 0x04)
> +#define PMK8350_ADC7_AMUX_THM2(sid)			((sid) << 8 | 0x05)
> +#define PMK8350_ADC7_AMUX_THM3(sid)			((sid) << 8 | 0x06)
> +#define PMK8350_ADC7_AMUX_THM4(sid)			((sid) << 8 | 0x07)
> +#define PMK8350_ADC7_AMUX_THM5(sid)			((sid) << 8 | 0x08)
>  
>  /* 30k pull-up1 */
> -#define PMK8350_ADC7_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
> -#define PMK8350_ADC7_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
> -#define PMK8350_ADC7_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
> -#define PMK8350_ADC7_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
> -#define PMK8350_ADC7_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
> +#define PMK8350_ADC7_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
> +#define PMK8350_ADC7_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
> +#define PMK8350_ADC7_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
> +#define PMK8350_ADC7_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
> +#define PMK8350_ADC7_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
>  
>  /* 100k pull-up2 */
> -#define PMK8350_ADC7_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
> -#define PMK8350_ADC7_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
> -#define PMK8350_ADC7_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
> -#define PMK8350_ADC7_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
> -#define PMK8350_ADC7_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
> +#define PMK8350_ADC7_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
> +#define PMK8350_ADC7_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
> +#define PMK8350_ADC7_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
> +#define PMK8350_ADC7_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
> +#define PMK8350_ADC7_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
>  
>  /* 400k pull-up3 */
> -#define PMK8350_ADC7_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
> -#define PMK8350_ADC7_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
> -#define PMK8350_ADC7_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
> -#define PMK8350_ADC7_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
> -#define PMK8350_ADC7_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
> +#define PMK8350_ADC7_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
> +#define PMK8350_ADC7_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
> +#define PMK8350_ADC7_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
> +#define PMK8350_ADC7_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
> +#define PMK8350_ADC7_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
>  
>  #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */
