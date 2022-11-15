Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73282629F4F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 17:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKOQn3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 11:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiKOQnL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 11:43:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B92F665
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 08:43:06 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a29so25312829lfj.9
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 08:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DMVuHRBp4GftrN1V1KSQlvwpB/mUouGhCJfxN5gy/c=;
        b=jK6kVEMwqFDOzl7o4MlPKo19vnfhcEnL2VbjT8hTvUAQw4mSgZYYnmwwTTKA8HpFvn
         SM1B8KN7Oa2eJ8C0mAgFGeQ6WTR1gAlgp2h8luDz8FGbBjjuqTWCf1/EoicijscLzY1N
         iL3Nb0+LtTbFFN1FQ9dOzcSLVUl/IJVeY5eDZK565Zo0+hF+So0nM8KWj3s0c5XJUwm4
         j1HA3KndtMPmiPGZdTd4EbWiB7waHIV4SlkReHrpzjyalC79ZMgEhpb4wtBS69PmegDy
         ehAwuYEZgCz/iZ9nw65cEgXJ0D5N+R4CrPo2Fni6th3cw6BpPCDBFtOHE/EUgHcpyWIB
         c8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DMVuHRBp4GftrN1V1KSQlvwpB/mUouGhCJfxN5gy/c=;
        b=d+N+8m2+U2sLoG01pK9YxGU+/Z4KeBEedE2gYjb46LhlHW5XExRlBjbyDVsqUKHQEZ
         Q2XsgtIGNsIqJHuftNTVJcOZmrv60Yop/3HW+QJG9kwCfijS8ZGTI4X2OQOjv910YBhF
         DDv/V5ydUybt3UbScZfVC4butdZ1wG93dffnlK5Q8fCBXe2Ymuf/bFkQroMWKZ0lzirT
         yvWQwB5htrwFvD9vMeAjetxW2TIKh1hRU4OgeOXAnsHNDhTjtApWBfSF6Qz7kTLZRHkw
         Vcc6jcfjbQ+agd1jdWKMdlv4p4iQ+A4w4tprLwsXgWlsq4nVEb706D9Qjr0bfVHUAeYC
         5Uiw==
X-Gm-Message-State: ANoB5pk5oAix6wnxJ7FZ2UsOV80IAiKVza3u42uFl/2dFp3Io16PNvW0
        h9MbHmDkuy4M6ZjnGw3WHawzJw==
X-Google-Smtp-Source: AA0mqf5a13CZKGFrmN4xsbVr2cltGfCaGtn+odnP/5EobiQd89vK+ZWQb9JqN5euCAiUAqg8/6jTNg==
X-Received: by 2002:a05:6512:a86:b0:4a4:72b0:9a2b with SMTP id m6-20020a0565120a8600b004a472b09a2bmr5745325lfu.469.1668530585022;
        Tue, 15 Nov 2022 08:43:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 17-20020a2eb951000000b002770fb5722fsm2559896ljs.123.2022.11.15.08.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:43:04 -0800 (PST)
Message-ID: <0051d380-7bba-f19a-2455-4f09b94caafe@linaro.org>
Date:   Tue, 15 Nov 2022 17:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 06/11] dt-bindings: arm: qcom,ids: Add SoC IDs for
 MSM8956 and MSM8976
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
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
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
> Document the identifier of MSM8956/76.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 2 ++
>  1 file changed, 2 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

