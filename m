Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2D660DB7
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jan 2023 11:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjAGKVV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Jan 2023 05:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjAGKVR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2023 05:21:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1954564A
        for <linux-iio@vger.kernel.org>; Sat,  7 Jan 2023 02:21:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bt23so5480813lfb.5
        for <linux-iio@vger.kernel.org>; Sat, 07 Jan 2023 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PznVjfd3B/ZmrH40OQITBZTOBnAxAksocBkNKDAfKY=;
        b=IzYijjztQ/k7BxPIpYTpfFtRhIcYe4oVXWjVXwgRfqcJM3Q/DOajytwc5ZK9sK9WVK
         GS1jhCONErzWS7uvcr5bCcUihxra7OyJo7iSh+edOM3JSO2FQYRTI9h3hrqTjqeBrk+W
         m9PNQPZ8rXEhNT5+GwHLLeuTrDeD6rC2yzGlHxxXyjdlZ4+YSqc7DeFp5vygscj5qfJN
         ot00PWvjtxENUGlv8rHnGOT+A/9sj/UFU925pb3F3tVDf335/hAKkYsY1fgNSUcQouxX
         AoYABrR/IUNLpm4e9SV32tW3tP/OVnjTa4x34HQa7pzj5Aav36lKDIA5NV3TpWD6VgBR
         gLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PznVjfd3B/ZmrH40OQITBZTOBnAxAksocBkNKDAfKY=;
        b=Cp0lZ0ytYoMZCBb54Mkdra0PNtJlB9BSTL/5aXpzHYYVSzsbWHYAjozDm0m2732mwl
         0+Ed8MRl7yW/bF6wAvC1ZoFfKyfHoUCjuNamiWTBm7w2blo0tztHeNmDiYEht1SHV7ZK
         mG6rmjINeWKSp4yBICVBrZ2dxKMIvoRYAKjjkbRviYB8Me7rxCFfBpcBZv4XVfqcSAA7
         ABJDtz66VK/fR3LugfoVIbdgOJyW6YUO/wOIDa+SkQh1DToJaHqdOU027DA+u25ZE2wS
         8GRm0i7eftUgCh7GhQ8UlTP8PGX8wJZDs/Y6Bx1QmMyaz6szodgFQ+CNOpJDzpVT5fkS
         GR9A==
X-Gm-Message-State: AFqh2kpUsLdD0FjGqND2IjgnP/dLqQPG5youmz0PFVp5CPZb5LMPH4Gr
        CIfrheX1oj/q71XwZhYE0zlMbw==
X-Google-Smtp-Source: AMrXdXtcpppwmWOHrHPYd5u2zJ9iw7R1EIkpliKjIk+7iCO/JsVL5HPXHmyUygkJIdAziw+gimNd3w==
X-Received: by 2002:a05:6512:3901:b0:4a4:68b7:f892 with SMTP id a1-20020a056512390100b004a468b7f892mr19676009lfu.54.1673086873397;
        Sat, 07 Jan 2023 02:21:13 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id c18-20020a196552000000b004b567e1f8e5sm528300lfj.125.2023.01.07.02.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 02:21:13 -0800 (PST)
Message-ID: <dab1227b-2ffb-5a8e-9c7b-f2a31d100b16@linaro.org>
Date:   Sat, 7 Jan 2023 11:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm7250b: Add BAT_ID vadc channel
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230106-pm7250b-bat_id-v1-0-82ca8f2db741@fairphone.com>
 <20230106-pm7250b-bat_id-v1-2-82ca8f2db741@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230106-pm7250b-bat_id-v1-2-82ca8f2db741@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 6.01.2023 16:39, Luca Weiss wrote:
> Add a node describing the ADC5_BAT_ID_100K_PU channel with the
> properties taken from downstream kernel.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> index 61f7a6345150..d709d955a2f5 100644
> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> @@ -110,6 +110,14 @@ adc-chan@1e {
>  				label = "chg_mid";
>  			};
>  
> +			adc-chan@4b {
> +				reg = <ADC5_BAT_ID_100K_PU>;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +				qcom,ratiometric;
> +				label = "bat_id";
> +			};
> +
>  			adc-chan@83 {
>  				reg = <ADC5_VPH_PWR>;
>  				qcom,pre-scaling = <1 3>;
> 
