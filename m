Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443B774C68D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jul 2023 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGIRS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jul 2023 13:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGIRS0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jul 2023 13:18:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3612A
        for <linux-iio@vger.kernel.org>; Sun,  9 Jul 2023 10:18:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso5576200e87.1
        for <linux-iio@vger.kernel.org>; Sun, 09 Jul 2023 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688923103; x=1691515103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4ESr9ycTlv2oyhDdfMdroTzsv1FcuY2XELb8Cinj9g=;
        b=plrOflODvDRg6EplaXi1Kbv7vSI/ij+/ROSCoK/v8rJnX9j2Sxdk3U+VncxJ5kjxz0
         1iA6K0Sqk7l3kIAoFDtkLxBdncWSAlf4TZ9Oilqc4iAZ7PgLeoBhH2cPFPmxqjsHGbHm
         xbw95cttVEdbWkleNdSbTIUUe3gldUTb2+SgaWMB9wA+QyB+lZa7dedtdQ36w8I2qDQA
         /N+AQDuydcTNKxAaetdmIg5JaLWvYrGLbHUpSYVEGudzs9ir62EsDQ6Pmz9btkBHKZqU
         3Ol5cdALdzyzxICPvymN6s+/cxEmRiGBJKdb0KEvmvl3mKilRCK/yQJOGOIaRprBpXAT
         A5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923103; x=1691515103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4ESr9ycTlv2oyhDdfMdroTzsv1FcuY2XELb8Cinj9g=;
        b=NOSHl8dt3YMM1owpOHZ1NHKgod9cu9yB2PSvhyGpyOFq/S4QHYpgIJnfl56FaCCx1w
         qjMJumMUzNMcjIfKVip4QOSBcgA04AsMtNj3/d5+YBmaFerCVDn5PmtvvXMP9WxUkgdZ
         x0o2dsDMDECzyRXacykaFJRR+QNCOK2GJvQplqlCdDx/vNivnK7YAL0VJNd7TIpPx2oe
         GOpQt5CQmVakR8mFVidKkHDasyqNw3167qzZVTReepOkuHpitE/GKAwVJPTfu9OeM5Wg
         w9cb9n2r4oMMBwljIOO9QcGxaejIh+jiWH4EX9Pq1M+vjGd/sdUagrekfwBij574+snk
         +8MQ==
X-Gm-Message-State: ABy/qLZZYbaLdza4VlkwU0pFdCqwOcz3uoQUfR8w3tL8yv2yHyfaQTcr
        A9PPBUcZ/GFvb0fSJWQpAh/KMg==
X-Google-Smtp-Source: APBJJlEF3q8C9/RXRj0i6X1QW9hyoU2aZchYK6HK5qdXq5LupCCj5k9C+09fwOMNhreTqE5GdS2zhQ==
X-Received: by 2002:a05:6512:3d0f:b0:4f8:58ae:8ea8 with SMTP id d15-20020a0565123d0f00b004f858ae8ea8mr8776912lfv.58.1688923102661;
        Sun, 09 Jul 2023 10:18:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v7-20020a056402184700b0051de2455041sm4685273edy.24.2023.07.09.10.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:18:22 -0700 (PDT)
Message-ID: <839cfac2-8f74-3386-5854-e3fb2ba4e07f@linaro.org>
Date:   Sun, 9 Jul 2023 19:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/11] ARM: dts: qcom: Update devicetree for ADC7 rename
 for QCOM PMICs
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-4-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-4-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> The name "ADC7" needs to be replaced with the name "ADC5_GEN2"
> everywhere to match the convention used for these ADC peripherals
> on Qualcomm Technologies, Inc. PMICs. Update devicetree files for

We do not rename compatibles to match convention. Please provide proper
rationale.

> the corresponding name change done in bindings and driver.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi         |  4 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  4 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  4 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  8 ++--
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 48 +++++++++----------
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  2 +-
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  4 +-
>  7 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> index bc6297e7253e..149d2bb43d2d 100644
> --- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> @@ -50,7 +50,7 @@ pon_resin: resin {
>  		};
>  
>  		pmk8350_vadc: adc@3100 {
> -			compatible = "qcom,spmi-adc7";
> +			compatible = "qcom,spmi-adc5-gen2";

You break all users without explaining it.

Best regards,
Krzysztof

