Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1637629F79
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 17:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKOQq4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 11:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiKOQqw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 11:46:52 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32931A220
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 08:46:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d3so18315492ljl.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 08:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sceBr5k80clJTRXCKFIVIMMX5ozvXAUs5Z1IN2Voph4=;
        b=gN9Y1flhTtF21icTbLQq488O0MR/imW0kXrtsgEPuMITvYukZvTqhlo659IanWVE+R
         5sYLx5o04Og3+y1e7oH8noDDOi/zzlJ1alUurwNFI10piZta+b5wCc9tuceh84PAMG6s
         yUU8sYVyVHgrhj9e+4jRB/k0B2kCzAfjZ3QQBjCBkPS7Cx1QhiZf+0P6NNz15fqL29lv
         CoOKs38WQ0J3abeVEmeSTZuSWJxbMzHmrx3IcmrrBPMibNlS2TE9pMzh/HVosbi58XHT
         QnD45MaEDxeyHmuD8gQoPVL8lTvjOOuyH+J6F14hncuOkvESBc8Q7iJOlKgCBRKgFVQ0
         l+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sceBr5k80clJTRXCKFIVIMMX5ozvXAUs5Z1IN2Voph4=;
        b=v/QKGaFQfqUnqqQYakRqLFWgP2MR/zq86SNqFvlp4byPxLmbo/qUjMoafjEfjJvWaX
         /xVSMR8qCNuXRTL4cYF4PsUYi+fA6EC67SOKoK/lZZQYu4fwFIR50IerjMkfo48qOFJZ
         AZ7z6xzacpO/BZ1M7uG/Fz+5Pk+++SqI9+MHkEf0YjxLysBf+IZS9z0DVc5Z+VURXH61
         pT3h/1rpwzM2j1nQppp6m85OpoSBQPAfmNXX22o0aVhKRw6XQqntgLbPI0xEq1iDwnVk
         Bp62P6FUk6yNU4d3yttIUACrTxA/TgL2yLep3QQBfMukuIQuCiMf67465zdxe4/Zmf36
         xknw==
X-Gm-Message-State: ANoB5pkxJRf992uTA/HGyI6VWYWngMKYb2AiVEkUIvRrImKVxiuoHrFu
        a0C022P+MbIvONnUv8GFHYE3wg==
X-Google-Smtp-Source: AA0mqf42JOJbwVkixEPLkVqAGG3duJa1LS45GbDm4xh7isDuj6cJjR4uaiZqHwFcfiOlFumAFn4uQA==
X-Received: by 2002:a2e:9798:0:b0:26f:bd6e:7f7f with SMTP id y24-20020a2e9798000000b0026fbd6e7f7fmr6271817lji.87.1668530809036;
        Tue, 15 Nov 2022 08:46:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c10-20020ac2414a000000b0049313f77755sm2265971lfi.213.2022.11.15.08.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:46:48 -0800 (PST)
Message-ID: <2664eb1f-3567-9b41-3aaa-b4af76f9ce1f@linaro.org>
Date:   Tue, 15 Nov 2022 17:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 11/11] arm64: dts: qcom: Add support for SONY Xperia
 X/X Compact
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-12-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
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
> This adds support for the Sony Xperia Loire/SmartLoire platform
> with a base configuration that is common across all of the
> devices that are based on this project.
> 
> Also adds a base DT configuration for the Xperia X and Xperia
> X Compact (respectively, Suzu and Kugo) which is valid for both
> their RoW (single-sim), DSDS (dual-sim) and other regional
> variants of these two smartphones, that makes us able to boot
> to a UART console.
> 
> Please note that, currently, the APC0/1 (cluster 0/1) vregs
> are set to a safe voltage in order to ensure boot stability
> until a proper solution for CPU DVFS scaling lands.
> 
> Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../qcom/msm8956-sony-xperia-loire-kugo.dts   |  35 +++
>  .../qcom/msm8956-sony-xperia-loire-suzu.dts   |  17 ++
>  .../dts/qcom/msm8956-sony-xperia-loire.dtsi   | 282 ++++++++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

