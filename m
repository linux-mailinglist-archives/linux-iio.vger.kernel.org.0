Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3E16D418C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 12:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjDCKHY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 06:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjDCKHX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 06:07:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6F526E
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 03:07:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id br6so37293565lfb.11
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 03:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680516439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okbVzjpphuSURTBwLwWsz3d/UlpOfVGoKqvP11/IIQU=;
        b=kzHcRw145Tq/JE+dEAFtzVZmKjjSoP2eaaYfw0szz1lZettc8oUTufHAVffNbF7PxO
         QXbPvRwQeHbEa1d47xqMmXh4eTncbQ1Ljt4GkFUrnG1dfeWv7t8U54qhtRzNQHyJ0vcr
         LDWZ/ghGyygFkA+MrOG70NLEKjSFfOWyAuwWvOnCyAFt4516VzHT4Aq4/J9YWYtpg/uo
         ctp4kMxlYAxEqTS7w8z/sPX9x8Y5tssOEo/XJ5UeaMqPHSmS42VKOiz3QWYq1DFr51qu
         aGlpwFPiAwJ2f02XoKG3AaKXvfNw5FopUdjIw01UNtLhhIJGlDXPU5HDzDJp/dZ0a21L
         DCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680516439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okbVzjpphuSURTBwLwWsz3d/UlpOfVGoKqvP11/IIQU=;
        b=arndET8j+tGT7yNFF8rxNW4hisfe4VSPzVoF1EJtmo4uHQJYpTHdal1i8uvjXwaeKn
         amBmF/mIWHZwjJh5+NyZ7/LME6DgsdTERXWR+bKPGyxeBrjpY7mS7qLgddafFMAJlFq0
         eIctjWq4ah5ilK37gb9co3OJmPlMolLdiEq3aqI/+NdIt+1gZqj44v8PaQ8hNAqkKLYC
         ZJ9+Vea+otJ10Pld4ow2QHff1nG92bRo8S1gwFDnDlAkqktLqXEd+B2iT8f/EPuSs2WI
         wfqiTshQxXbb8gVPItzeA3iyMt0ng726goF+wiDZkHWJuO4MbS0F4GnxRg2DHJuBl6Qp
         kbxg==
X-Gm-Message-State: AAQBX9fBTfKhUm5UQ+FRLveN10ssdWFYGic4nYgtNX64lc5ZtNUbuRAz
        CefbDokQUrJne1UgvinmamSoBA==
X-Google-Smtp-Source: AKy350bEVPXVYmqwfOkf81gG9dW9SP4lc7NBMKw+Vwl7C+AeAKsHhRRe4JaSoZR6Vqo8JL9DsE/ToA==
X-Received: by 2002:ac2:522c:0:b0:4dd:ad88:ba65 with SMTP id i12-20020ac2522c000000b004ddad88ba65mr8747235lfl.67.1680516439665;
        Mon, 03 Apr 2023 03:07:19 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004e84b79de9bsm1678722lft.254.2023.04.03.03.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:07:19 -0700 (PDT)
Message-ID: <e95b347a-83dc-b530-b242-8f335996b7ce@linaro.org>
Date:   Mon, 3 Apr 2023 12:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 04/22] arm64: dts: qcom: sc8280xp-pmics: correct
 interrupt routing for pm8280_2_temp_alarm
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
 <20230401220810.3563708-5-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230401220810.3563708-5-dmitry.baryshkov@linaro.org>
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
> The PMIC pm8280_2 has SID equal to 3, thus it interrupts-extended should
> use 3 as the first argument value. Fix the interrupts-extended value for
> pm8280_2_temp_alarm device node.
> 
> Fixes: 6c82f40ec94e ("arm64: dts: qcom: sc8280xp-pmics: Add temp alarm for PM8280_{1/2} PMICs")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index a3c7369f9594..254337345e45 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -176,7 +176,7 @@ pmc8280_2: pmic@3 {
>  		pm8280_2_temp_alarm: temp-alarm@a00 {
>  			compatible = "qcom,spmi-temp-alarm";
>  			reg = <0xa00>;
> -			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts-extended = <&spmi_bus 0x3 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>  			#thermal-sensor-cells = <0>;
>  		};
>  
