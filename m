Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2E629F41
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 17:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiKOQmL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 11:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiKOQmK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 11:42:10 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070C2D764
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 08:42:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id d20so18234390ljc.12
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jb1svEkUmggBlpVRHrknk39IWZlG+Y0uIqQEOYSyi8=;
        b=w3GCgTOUTD0J7IW0L/hJ91pCWBJ3IwmBduHmODYjszPNbLFxeDh5/wKwrQzbQr4Kq0
         YtGAT6VzrwHcOMb5i+8Sj0vbU+Twb9VNxJSISKn1r2yRx6as4Y+kY3vazoKVnURObgvW
         ntpuceelBv+C1adAUHTFEx3vXbWdgkmRMhZVJZp393VZ0LNmbyAeBdxe8eIibe1e/34v
         y6pGrGlcOD2Hw/LMbzVXjTVk7g5e63S+gqvUMJGYM0Rw55Q+wydi6Coht0BVgBMCcsTe
         +xbyvkZ5D9kokEOZBQRvRV5sGoCPNO86Yj25VxCW1p2S5g7GKUwKFcaLCns9AJDI1oIN
         RVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jb1svEkUmggBlpVRHrknk39IWZlG+Y0uIqQEOYSyi8=;
        b=FhmmoVBtdWIX3c6YnGtOgQ9OaQ8TZucU7ctmoYuRuMJOFCPmJaogveVzC6jKt6GwFl
         9mAwydix8zalSHdUC1Kj9CUyGl3W7GMzpjiW/eJZU0Sh3+QOoR8PkWmiS1N3bIAqxMuJ
         9uiK5UYZYooCP+j+wst6LMX5acoac/YEUHAp8CUCu+/nJSqNVPxvjVXoIIlv5QW4dQco
         MdpKaNDGtnQRHcpjjobqA+pyzdaenf1gEA7nzEL8eGOuoz52tzHJJ7zLYWpu6w17+TRA
         ovMIQdUj5Z6vxVRko70/RDZWlyCfpJmMABUfUqDfnWjY98kFfAbxINUqd2XlTF4+cLLw
         1gvQ==
X-Gm-Message-State: ANoB5pmy0+PhQPXJ9/DcquW/YnPhzN4zQ+px62AD1PbLVHI984mSRgE/
        tFzSRaEfQlyyFvVrh/xfjnOoRw==
X-Google-Smtp-Source: AA0mqf75eymhe8iemrFEPOiuBlkfykZb27qfQ/xZRMN9Wv45n2T8ywkw2TqFyFY7j1uwmWrbhHSVyg==
X-Received: by 2002:a2e:2201:0:b0:275:a127:cace with SMTP id i1-20020a2e2201000000b00275a127cacemr6071141lji.378.1668530526951;
        Tue, 15 Nov 2022 08:42:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a12-20020a19f80c000000b004ac088fdfd2sm2269353lff.85.2022.11.15.08.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:42:06 -0800 (PST)
Message-ID: <b611f647-c46f-3780-c6b4-3cfb4fe402e7@linaro.org>
Date:   Tue, 15 Nov 2022 17:42:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 02/11] dt-bindings: nvmem: Fix qcom,qfprom compatibles
 enum ordering
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
 <20221111120156.48040-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-3-angelogioacchino.delregno@collabora.com>
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
> Move qcom,msm8974-qfprom after qcom,msm8916-qfprom to respect
> alphabetical ordering.
> 
> Fixes: c8b336bb1aeb ("dt-bindings: nvmem: Add soc qfprom compatible strings")

It's a style, code readability, but not a bug. I propose to drop the tag.

With that:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

