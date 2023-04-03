Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60656D41AF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjDCKQm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 06:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjDCKQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 06:16:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18EF65BC
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 03:16:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x17so37393678lfu.5
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680516994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNLlgEsfn6bQxY+FQHh506Gu9381zJcSolbDY70x5ZU=;
        b=HrudlRnK7SNQOf2sHLFFavkTomnUN1UBwsBinOR/UheKUEb44qEiNCZB7hU6SMrkfZ
         HBeARig6CpbXKz/rkoO2bHqjGdZS5nDI2COoVoeEtSaxJ8w8kdgtmoQB40ExRGwPTyND
         oua1G6m9pUgQiOA3HUX1XngQtwGMrCbg0IXI2rEYjNllhXpRAr3bS/Apl4MhWRrhOk5x
         w81Z5KHA/STMxQUAycPnz5iC+kDrnoYZNKWWAZlGDxGSz/E2f1hLREtTCXgQ1D6ZYrcp
         UDZZtQYdo6PuWjcU/hmgQXHd6lRJjy7W3i0Jes+rrTO2bS8PvJVWoq+FkJRD5MbhDI44
         Spfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680516994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNLlgEsfn6bQxY+FQHh506Gu9381zJcSolbDY70x5ZU=;
        b=qZ8o7x6fuZ6ZdPTpVyy2YRdrqXmqbQJeeRBV2J56wlmd5qshmRyuZQL35Es7yMhjmC
         bJr16MTTnZjO0XbmwpVASZISGwIbroefEq295VG0nlDWC34c9TInOcKxG6CozTnoS8bu
         iKiKg3ZTWPonz2rZygQ+Y7xC2ekagUdpyiTTsQY4V89A5AodUmyVQJQh4HBmui+vyRz8
         mMmAbqepNUoIIuCm+CfNuBqW1YVNrUu+TtOfwa4sPv3DzjD1qk+rP9Zth1GRtlJag9TX
         KXREConLbliVWqPPz0B7fkes7F2/Rm70OSgb2vQzSxzjtJxsSDxQmadibsoGwORZtQd6
         6KTg==
X-Gm-Message-State: AAQBX9dKNtkmU219o/nflXLqcHxrnqVkNy5h35pAo/ecLY8/Pqcv1IPu
        uMgenMMjDz/ljahHlNbakdCiNA==
X-Google-Smtp-Source: AKy350bKMrP5L/JGUjCvfiupcP57MKCco3MyphtZr/XCS0WLP0GXZyf8CySWYjdHvITft2ZJksIASQ==
X-Received: by 2002:ac2:5322:0:b0:4e9:5e28:f1c9 with SMTP id f2-20020ac25322000000b004e95e28f1c9mr9601564lfh.36.1680516994203;
        Mon, 03 Apr 2023 03:16:34 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24462000000b004db48ae69cbsm1685425lfl.206.2023.04.03.03.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:16:33 -0700 (PDT)
Message-ID: <f9b64593-0138-0fc6-6e05-2310531c19c9@linaro.org>
Date:   Mon, 3 Apr 2023 12:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/22] arm64: dts: qcom: pmk8350: use
 interrupts-extended for IRQ specification
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
 <20230401220810.3563708-11-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230401220810.3563708-11-dmitry.baryshkov@linaro.org>
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
> As stated in the commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
> Specify interrupt parent explicitly"), we should not use bare interrupts
> for our PMIC devices. Instead interrupts-extended should be used. Change
> pmk8350.dtsi to use interrupts-extended propery.
propery/property

It's not about using the interrupts-extended itself, as it's functionally
identical if it points to the same interrupt parent. The main point of this
is to designate the SPMI host as the interrupt provider for these nodes,
as that's what the DT spec expects.

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
For the change:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> index f26ff3daf119..87b8e4269c60 100644
> --- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> @@ -33,14 +33,14 @@ LABEL(pon): pon@1300 {
>  
>  			LABEL(pon_pwrkey): pwrkey {
>  				compatible = "qcom,pmk8350-pwrkey";
> -				interrupts = <PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				interrupts-extended = <&spmi_bus PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
>  				linux,code = <KEY_POWER>;
>  				status = "disabled";
>  			};
>  
>  			LABEL(pon_resin): resin {
>  				compatible = "qcom,pmk8350-resin";
> -				interrupts = <PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				interrupts-extended = <&spmi_bus PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
>  				status = "disabled";
>  			};
>  		};
> @@ -50,14 +50,14 @@ LABEL(vadc): adc@3100 {
>  			reg = <0x3100>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <PMIC_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			interrupts-extended = <&spmi_bus PMIC_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  			#io-channel-cells = <1>;
>  		};
>  
>  		LABEL(adc_tm): adc-tm@3400 {
>  			compatible = "qcom,adc-tm7";
>  			reg = <0x3400>;
> -			interrupts = <PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> +			interrupts-extended = <&spmi_bus PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			#thermal-sensor-cells = <1>;
> @@ -68,7 +68,7 @@ LABEL(rtc): rtc@6100 {
>  			compatible = "qcom,pmk8350-rtc";
>  			reg = <0x6100>, <0x6200>;
>  			reg-names = "rtc", "alarm";
> -			interrupts = <PMIC_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
> +			interrupts-extended = <&spmi_bus PMIC_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
>  			status = "disabled";
>  		};
>  
