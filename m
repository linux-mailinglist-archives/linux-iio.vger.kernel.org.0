Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45E9627923
	for <lists+linux-iio@lfdr.de>; Mon, 14 Nov 2022 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiKNJj3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Nov 2022 04:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNJj1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2022 04:39:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499AC1A830
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 01:39:26 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j16so18268147lfe.12
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 01:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9XCkUeelflv0OvZlPTdiVOkOo+oSDAdHLbSak8ToQo=;
        b=mCY53LUKaJZ5o4feNXdaLfJEoFH+MlvQ9YtHKi3BBSBaY1U7P8fnx/yl5U0F0mFS2D
         LMdhxt9HYMFtwmbxbMfdElHaXEw8+6sdgCeO9N/gXbccLW1/wbAOzXX1YzR+8E8snThn
         lLP7HF32qRYZe/eC2BigWPU+RBKf9rQXvlELML585STcgmcFS6DPP2rMz6AhUW9tl8B4
         B2j6f4banrRSrHIm2sf8SyVkpwqFoO9reAaf/44+EKl2dp9ZX/8XCtDUjYz1OJXu6m/B
         C4ALWI0KC9g3gGEKCn2k/h6v8jRNWDScxGpyr9kJccrTh4qmEiNoCd5hwndogsqwFVT3
         4ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k9XCkUeelflv0OvZlPTdiVOkOo+oSDAdHLbSak8ToQo=;
        b=XAfrRysKuf/Mh+Aownc7TKuV1rIORM1b9mn/G/+w0x2A1DsVIrZr3VYcDfVPFHjBBn
         Niwkt1rarIGQaCxd3R/5zZnPS/5ng79xLNGwe0T3rx0nufNxu7CtrVMoy/9wiBtWgyFb
         7o6uRWKJecUUWrLmqLmDgNGwDOLhgLe2V/rPY9jC4QkRT8BeistQ6fgt2eyuAJH31oQL
         1UygK8j/1mrvfSY/DmNgls3FNEYmxzj1qy99538lDixa5Wns0JRhElfp3urwd1w7SxXY
         jgtugdp3FuCGzOgXBke2/edRpTn1gRZIWc9sr94EsQ79bx1+j3LeF9Pp1uN4qXOlwI6R
         AUNw==
X-Gm-Message-State: ANoB5plXGdoaWz4XDkah7A0eA4VWP4ER3kmmcjhIrGx7/DisxUl+iFfS
        sZ63g6+DUIh825i67XlBhNXxtw==
X-Google-Smtp-Source: AA0mqf6BjkXQmHn8zZLevpw4U3qXzZF296n/9D4aB48QjECYDiMKnX7ASO/YTJr4Odu2XE+Ni5hr4Q==
X-Received: by 2002:a05:6512:3baa:b0:4b1:2aab:7cc4 with SMTP id g42-20020a0565123baa00b004b12aab7cc4mr3564609lfv.241.1668418764651;
        Mon, 14 Nov 2022 01:39:24 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bi39-20020a0565120ea700b004a91df49508sm1767001lfb.177.2022.11.14.01.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:39:24 -0800 (PST)
Message-ID: <b69afa6a-119a-41cc-a1d8-da900d452941@linaro.org>
Date:   Mon, 14 Nov 2022 10:39:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 06/11] dt-bindings: arm: qcom,ids: Add SoC IDs for
 MSM8956 and MSM8976
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> Document the identifier of MSM8956/76.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

>   include/dt-bindings/arm/qcom,ids.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index 8b1a0f43bd93..91633da5fcf6 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -78,6 +78,8 @@
>   #define QCOM_ID_MSM8616			250
>   #define QCOM_ID_MSM8992			251
>   #define QCOM_ID_APQ8094			253
> +#define QCOM_ID_MSM8956			266
> +#define QCOM_ID_MSM8976			278
>   #define QCOM_ID_MDM9607			290
>   #define QCOM_ID_APQ8096			291
>   #define QCOM_ID_MSM8998			292
