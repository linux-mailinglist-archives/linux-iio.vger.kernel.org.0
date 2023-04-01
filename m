Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B131D6D31B1
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjDAO7Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDAO7T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 10:59:19 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90F1CB8F
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 07:59:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a11so25978339lji.6
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680361155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gPMOE69jBTGLKDpiR4EhzZ6Rni9NUx5of8tHB4TsS4=;
        b=kGXPhFFYIYd4nz7JzHXJX6RN/ehsEJQk9r68a9GtUK9JMTg0S/EY7qOe2zfAJ+NP5U
         l929GKQ78z2NAPcZGcJmTsdbc/HwxYwn68FcGqX5rOaDER+kK9WHZf5JQg5FDRHei7KA
         nPIm8P1b3WKF7YVbLz/Fi7YnbgVdFEZItA3REyEfX2LMUTz6YIAzbVxb6dhGs7wR+Vuz
         xIigVr2aJDl88mT3aG3kNAk1/13cmi1nQkuIgZ7Wd7eWrVHAAUX+uzjJW77OEGY6Lz2v
         OYk4AelMgIWRDaM9CvtDA8pkAoZUXSH1rLsVV4ogBviKQB8MOmCskMrwOvVujkNjLZ0D
         HKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gPMOE69jBTGLKDpiR4EhzZ6Rni9NUx5of8tHB4TsS4=;
        b=Pm7Oa0/TyML/1RiuUIAvzBq0oi5CEUMNqcUYSeCj56WVU0+q18wRXSvSLqmAJ0MOfh
         w43iJttQdzSMEFqPYfNbsCcnwxiucvCs+mpTMV2JBKNjuOmh2l5mW+ayCM4wQd/FnMJz
         kTvPMdo388f2mp4jJ4jHzx/HVTlR1HqtFsu5KAUKRiWJmdbVwbKUVunuMMa9bsSsOHMs
         DcyIgh0DElcmjodgJ2un4qUaRJQrUstGTC9QciWcklpjZfZ5y6waWZ7+107g8oBVDEVs
         mfd6R75NfcWVziMOOuY8lr70Zp3dob1jiyyHMrFeiq+58IY+cmhSiL8Z1mZN8Pq9TpZ5
         madg==
X-Gm-Message-State: AAQBX9dALs9OXDxYC7dCASopjQG4HbjDLPwOE6Nj8bCTXVcNmyoFS+KL
        IQIEEb6XUnWWru0w/dbShgET6yP6GPYJc2HIP4E=
X-Google-Smtp-Source: AKy350ZmTb62nCpd/f4elmZMM6FRi2zD26Su/6iJPhRuVoDgHH8p7daYQIBlFsf9AyS5QuYsa+n6yQ==
X-Received: by 2002:a05:651c:10ac:b0:2a0:3848:6b27 with SMTP id k12-20020a05651c10ac00b002a038486b27mr3122051ljn.23.1680361155477;
        Sat, 01 Apr 2023 07:59:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 21-20020a05651c00d500b0029462e98c07sm841182ljr.35.2023.04.01.07.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 07:59:15 -0700 (PDT)
Message-ID: <eb044bbc-2a6d-1e2d-95cb-da0261451dfa@linaro.org>
Date:   Sat, 1 Apr 2023 17:59:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/6] dt-bindings: iio: qcom,spmi-adc7-pmk8350.h: include
 sid into defines
Content-Language: en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
 <20230329000833.2507594-2-dmitry.baryshkov@linaro.org>
 <20230401154812.62152900@jic23-huawei>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230401154812.62152900@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 01/04/2023 17:48, Jonathan Cameron wrote:
> On Wed, 29 Mar 2023 03:08:28 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
>> pmk8350 can take different addresses on SPMI bus. Rather than having a
>> default SID, follow the pm8350's example and make the sid explicit when
>> specifying ADC channels.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Hi Dmitry,
> 
> How do you want this applied? I can take it through IIO if you like but
> I'm not sure if that will cause trouble for other dts patches in flight.
> 
> I'm fine with it going via another tree though and don't expect
> to see any clashes. If so.

I think it would be better to get this through qcom -> arm-soc tree 
together with the rest of the patchset. Thank you for your permission.

> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>   .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  2 +-
>>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  4 +-
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
>>   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  2 +-
>>   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  4 +-
>>   .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  2 +-
>>   .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  | 52 +++++++++----------
>>   7 files changed, 32 insertions(+), 36 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> index bd6e0d6f6e0c..df317901e7d0 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> @@ -293,7 +293,7 @@ examples:
>>   
>>               /* Other properties are omitted */
>>               xo-therm@44 {
>> -                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
>> +                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>>                   qcom,ratiometric;
>>                   qcom,hw-settle-time = <200>;
>>               };
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
>> index 52ec18cf1eda..ff07d27775dc 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
>> @@ -218,7 +218,7 @@ examples:
>>   
>>               /* Other properties are omitted */
>>               xo-therm@44 {
>> -                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
>> +                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>>                   qcom,ratiometric;
>>                   qcom,hw-settle-time = <200>;
>>               };
>> @@ -240,7 +240,7 @@ examples:
>>   
>>               pmk8350-xo-therm@0 {
>>                   reg = <0>;
>> -                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
>> +                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>>                   qcom,decimation = <340>;
>>                   qcom,ratiometric;
>>                   qcom,hw-settle-time-us = <200>;
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 5dc9bee28e7f..14c9bdaa46ed 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -433,7 +433,7 @@ &pcie1_phy {
>>   
>>   &pmk8350_vadc {
>>   	pmk8350-die-temp@3 {
>> -		reg = <PMK8350_ADC7_DIE_TEMP>;
>> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>>   		label = "pmk8350_die_temp";
>>   		qcom,pre-scaling = <1 1>;
>>   	};
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> index cb0cc2ba2fa3..e3919e074ebd 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> @@ -389,7 +389,7 @@ &pm8350c_pwm {
>>   
>>   &pmk8350_vadc {
>>   	pmk8350-die-temp@3 {
>> -		reg = <PMK8350_ADC7_DIE_TEMP>;
>> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>>   		label = "pmk8350_die_temp";
>>   		qcom,pre-scaling = <1 1>;
>>   	};
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> index 46c7fdafb840..590400985055 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> @@ -824,13 +824,13 @@ &pmk8280_vadc {
>>   	status = "okay";
>>   
>>   	pmic-die-temp@3 {
>> -		reg = <PMK8350_ADC7_DIE_TEMP>;
>> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>>   		qcom,pre-scaling = <1 1>;
>>   		label = "pmk8350_die_temp";
>>   	};
>>   
>>   	xo-therm@44 {
>> -		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
>> +		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>>   		qcom,hw-settle-time = <200>;
>>   		qcom,ratiometric;
>>   		label = "pmk8350_xo_therm";
>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> index 7ae6aba5d2ec..af6cf4fbddc7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> @@ -516,7 +516,7 @@ &pmk8350_rtc {
>>   
>>   &pmk8350_vadc {
>>   	adc-chan@644 {
>> -		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
>> +		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>>   		qcom,ratiometric;
>>   		qcom,hw-settle-time = <200>;
>>   		qcom,pre-scaling = <1 1>;
>> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>> index 6c296870e95b..ca85a2d69453 100644
>> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>> +++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>> @@ -6,41 +6,37 @@
>>   #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
>>   #define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
>>   
>> -#ifndef PMK8350_SID
>> -#define PMK8350_SID					0
>> -#endif
>> -
>>   /* ADC channels for PMK8350_ADC for PMIC7 */
>> -#define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | 0x0)
>> -#define PMK8350_ADC7_1P25VREF			(PMK8350_SID << 8 | 0x01)
>> -#define PMK8350_ADC7_VREF_VADC			(PMK8350_SID << 8 | 0x02)
>> -#define PMK8350_ADC7_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
>> +#define PMK8350_ADC7_REF_GND(sid)			((sid) << 8 | 0x0)
>> +#define PMK8350_ADC7_1P25VREF(sid)			((sid) << 8 | 0x01)
>> +#define PMK8350_ADC7_VREF_VADC(sid)			((sid) << 8 | 0x02)
>> +#define PMK8350_ADC7_DIE_TEMP(sid)			((sid) << 8 | 0x03)
>>   
>> -#define PMK8350_ADC7_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
>> -#define PMK8350_ADC7_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
>> -#define PMK8350_ADC7_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
>> -#define PMK8350_ADC7_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
>> -#define PMK8350_ADC7_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
>> +#define PMK8350_ADC7_AMUX_THM1(sid)			((sid) << 8 | 0x04)
>> +#define PMK8350_ADC7_AMUX_THM2(sid)			((sid) << 8 | 0x05)
>> +#define PMK8350_ADC7_AMUX_THM3(sid)			((sid) << 8 | 0x06)
>> +#define PMK8350_ADC7_AMUX_THM4(sid)			((sid) << 8 | 0x07)
>> +#define PMK8350_ADC7_AMUX_THM5(sid)			((sid) << 8 | 0x08)
>>   
>>   /* 30k pull-up1 */
>> -#define PMK8350_ADC7_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
>> -#define PMK8350_ADC7_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
>> -#define PMK8350_ADC7_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
>> -#define PMK8350_ADC7_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
>> -#define PMK8350_ADC7_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
>> +#define PMK8350_ADC7_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
>> +#define PMK8350_ADC7_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
>> +#define PMK8350_ADC7_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
>> +#define PMK8350_ADC7_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
>> +#define PMK8350_ADC7_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
>>   
>>   /* 100k pull-up2 */
>> -#define PMK8350_ADC7_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
>> -#define PMK8350_ADC7_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
>> -#define PMK8350_ADC7_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
>> -#define PMK8350_ADC7_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
>> -#define PMK8350_ADC7_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
>> +#define PMK8350_ADC7_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
>> +#define PMK8350_ADC7_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
>> +#define PMK8350_ADC7_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
>> +#define PMK8350_ADC7_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
>> +#define PMK8350_ADC7_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
>>   
>>   /* 400k pull-up3 */
>> -#define PMK8350_ADC7_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
>> -#define PMK8350_ADC7_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
>> -#define PMK8350_ADC7_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
>> -#define PMK8350_ADC7_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
>> -#define PMK8350_ADC7_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
>> +#define PMK8350_ADC7_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
>> +#define PMK8350_ADC7_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
>> +#define PMK8350_ADC7_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
>> +#define PMK8350_ADC7_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
>> +#define PMK8350_ADC7_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
>>   
>>   #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */
> 

-- 
With best wishes
Dmitry

