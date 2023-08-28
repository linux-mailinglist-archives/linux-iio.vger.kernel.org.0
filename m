Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6FB78AE32
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjH1K6F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjH1K5m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 06:57:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F3E18D
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 03:57:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50091b91a83so4612923e87.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693220253; x=1693825053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScJJiUxyV9LKUy1UPNfuayMrh4/gBBz+Y4+3/4NfxE8=;
        b=LyN18tXJscr9QOCDJO9IqWgIn4vHblPj8NYlmAlqv3wJC0I+GKAQ2p3PMr5jaNWbW8
         Q3J9BmcZtreYsKb2WrbkklUwlaR9p6nzVQW/wjf9DpSij2eDXXS5kKajeMME54dmtkcu
         fs1cVPjCf3Gcz+Qyv7FPlI0aCN2YvE6BgQ3fA7MH/9bD2FXnLSl7LeKYKVkYi7KGA2/6
         HqHzlqLv1/f5ra68++VSmSoufeVkZN4Nv2SVemSyOuD0pvxcN99lsfLtj+yn+vR7m9Ea
         YS2dvFolH9fuMJ6MFryiWQAWhtzJtN06NCxhM7BvfwPjE3uEx374nmAOYxi405/dM9tW
         sNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693220253; x=1693825053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScJJiUxyV9LKUy1UPNfuayMrh4/gBBz+Y4+3/4NfxE8=;
        b=RGx7LmNN92TPe2x1kPBqnHLxfcSA7mEScCXRdX4L26ykuCjYwIzx6eo1pl3DNbZmkZ
         X/N4gOm7E+ZbelmFKKb3NBVL/0S7v0vmdynKz8FCHZVZRatjgxDABr2vXZQaCCv8PlVx
         mdy4ObNRam0gGPL98ec1x1zy6P8Xf1c9kvlx/qifMO7SJOgUQTuXxIpk39aqPK4i7sOj
         CJ0S6RJHmvSb8dapD/pP96liwViVt0BdDLqwfx/Cxok3tFhGJyNLzojrarIVtHSIlQUc
         dFTbn0C9cPWChPiJF3Q/8RFm/+6hotsBzMzkZ+NNuWdXabBEiEZ8yIOvsKyx5gBuzFbc
         oeDA==
X-Gm-Message-State: AOJu0Yx6/W1wq+ZFFaaZf+dBkuu60IfUy39Ya0hW//SmmzpPdF0k/efj
        wZfgGvQxC/Tw3r63UNSx9b3MTQ==
X-Google-Smtp-Source: AGHT+IFykMJKhRHj5gXoEIcbFTsFjHQv1CdJVv0O+4CFTrlWuhws1TjAclQfP4UIVoy3asWRMgvVmw==
X-Received: by 2002:a2e:9b01:0:b0:2bc:c064:7252 with SMTP id u1-20020a2e9b01000000b002bcc0647252mr15852281lji.5.1693220252909;
        Mon, 28 Aug 2023 03:57:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id w16-20020a2e9990000000b002b6d7682050sm1698240lji.89.2023.08.28.03.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:57:32 -0700 (PDT)
Message-ID: <d9aef01b-80c5-4b35-a246-7ef7bbdf00c6@linaro.org>
Date:   Mon, 28 Aug 2023 12:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/37] ARM: dts: qcom: msm8660: move PMIC interrupts to
 the board files
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
References: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
 <20230827132525.951475-16-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230827132525.951475-16-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27.08.2023 15:25, Dmitry Baryshkov wrote:
> The interrupt of SSBI PMICs is routed to the SoCs GPIO. As such, it is
> not a property of the SoC, it is a property of the particular board
> (even if it is standard and unified between all devices). Move these
> interrupt specifications to the board files.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts | 4 ++++
>  arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts        | 4 ++++
>  arch/arm/boot/dts/qcom/qcom-msm8660.dtsi            | 2 --
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
> index 48fd1a1feea3..e4261d729d35 100644
> --- a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
> @@ -273,6 +273,10 @@ kxsd9@18 {
>  	};
>  };
>  
> +&pm8058 {
> +	interrupts-extended = <&tlmm 88 IRQ_TYPE_LEVEL_LOW>;
> +};
> +
>  &pm8058_gpio {
>  	dragon_ethernet_gpios: ethernet-state {
>  		pinconf {
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts
> index 86fbb6dfdc2a..a5441aecd637 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts
> @@ -34,6 +34,10 @@ &gsbi12_serial {
>  	status = "okay";
>  };
>  
> +&pm8058 {
> +	interrupts-extended = <&tlmm 88 IRQ_TYPE_LEVEL_LOW>;
> +};
> +
>  &pm8058_keypad {
>  	linux,keymap = <
>  		MATRIX_KEY(0, 0, KEY_FN_F1)
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
> index 9217ced108c4..84b0366792d4 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
> @@ -341,8 +341,6 @@ ssbi@500000 {
>  
>  			pm8058: pmic {
>  				compatible = "qcom,pm8058";
> -				interrupt-parent = <&tlmm>;
> -				interrupts = <88 8>;
>  				#interrupt-cells = <2>;
>  				interrupt-controller;
>  				#address-cells = <1>;
