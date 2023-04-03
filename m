Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC666D4162
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 11:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjDCJ4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjDCJzn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 05:55:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BA540FA
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 02:55:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z42so29671713ljq.13
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE1GC8bNsZjh91M2uvZ6GJDekN3UycynkCAMIfYoBuU=;
        b=rtXx2LnasUzfGMdHPJhXjl18xhcNTvKvsCn+K9hiyWahs3KWHn+C82uykFyV8jHjgR
         p871ozxTl13KN2NUgxCetr/S9VORwsLlCq7Wkfq2kqiKY5a3N/IdpxdWN7dLDvyLBepg
         JWbSUI+Ww5BnzkCo053+IcLl08XZF4l1kCEszOTCwZVfAUSGboj+TALWuyO8arSBeEjh
         YLNeg0wpNcynFmOKguyM81NjfBnit1vEZa+fNey+1pCEGHqAjCeahV/nmQv7ns5+l5yI
         ca5C4s8eKX9A4g76Ct19EnVDt9kEmFyeqGenVop3ObJv5lqYaqYLMHH1Lks2VNSlgBG2
         tf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE1GC8bNsZjh91M2uvZ6GJDekN3UycynkCAMIfYoBuU=;
        b=rvB5+0p60EvCjaZPpIRoo8e5LVsPgZlvjO0EaeJrm2jWkoPnynI875XtsZhvPimfOo
         yN9GNugxXKitkhJxPcaAsTOMFVtz3hoUKvLOBbLr43c+iAF8BbWR9ewbeo0Xu/b5isJp
         VNZHaQLT5zWtquxysSFT71ghNGdr+dRX/hP585w1M1LfeMwWoS4e3VD6d+lWOi3As7eR
         TZQMMZFwRPreuZ46OO/kEpCBaCLu/vEbQT9fRdCf+f6YIxUYkSGfGAX5vcikf0bCQyVZ
         r9UUpoWw1K7GV+9UR86OqcYXnMQ4KJoHCgmYX0WTtg0txscBsLw5kHXbhvIHY4I8C30I
         GiAQ==
X-Gm-Message-State: AAQBX9c+S91tPexXvDW2acdirShTGCCLsaC1uDYPnuMBOrJNHQWav+4V
        C5FdHVcyk7PqRpHrhlEw7d/qsw==
X-Google-Smtp-Source: AKy350ZL/zOJDep07oVQ1KtvNKU/eySDxYXdtkGk81hwLJblc1drCHXJNLF8P5B2guL8xgr04LVLVA==
X-Received: by 2002:a2e:9450:0:b0:29f:1e4f:a71d with SMTP id o16-20020a2e9450000000b0029f1e4fa71dmr10645231ljh.44.1680515714691;
        Mon, 03 Apr 2023 02:55:14 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id y26-20020a05651c021a00b002a2b9d9429esm1650733ljn.117.2023.04.03.02.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:55:14 -0700 (PDT)
Message-ID: <d42c59fd-f1f6-eb31-49ad-f3eda31f021b@linaro.org>
Date:   Mon, 3 Apr 2023 11:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 01/22] arm64: dts: qcom: pm8350: fix thermal zone node
 name
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
 <20230401220810.3563708-2-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230401220810.3563708-2-dmitry.baryshkov@linaro.org>
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
> Correct the thermal zone node names to remove the clash with
> pm8350c.dtsi. Remove unused labels.
> 
> Fixes: 7a79b95f4288 ("arm64: dts: qcom: pm8350: add temp sensor and thermal zone config")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm8350.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8350.dtsi b/arch/arm64/boot/dts/qcom/pm8350.dtsi
> index 2dfeb99300d7..9fb963df4b41 100644
> --- a/arch/arm64/boot/dts/qcom/pm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8350.dtsi
> @@ -8,19 +8,19 @@
>  
>  / {
>  	thermal-zones {
> -		pm8350_thermal: pm8350c-thermal {
> +		pm8350-thermal {
>  			polling-delay-passive = <100>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&pm8350_temp_alarm>;
>  
>  			trips {
> -				pm8350_trip0: trip0 {
> +				trip0 {
>  					temperature = <95000>;
>  					hysteresis = <0>;
>  					type = "passive";
>  				};
>  
> -				pm8350_crit: pm8350c-crit {
> +				crit {
>  					temperature = <115000>;
>  					hysteresis = <0>;
>  					type = "critical";
