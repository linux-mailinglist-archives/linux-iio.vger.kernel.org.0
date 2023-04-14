Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08936E1DA3
	for <lists+linux-iio@lfdr.de>; Fri, 14 Apr 2023 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDNH4q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Apr 2023 03:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDNH4i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2023 03:56:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B17D8A
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 00:56:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id z9so16522877ejx.11
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681458987; x=1684050987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW+MbmxIJNrbIzKdDNHsLz5HCe2p5XocFzky4ID/b28=;
        b=SQuOmnpYAOKYWLP2/Hb5F/pB9ial8nLpK3cS1BU9upFDDlnw3Nphv73mLmqzPdvQfB
         TNzaw7yq7FXlkQkwp01QVsq3wwJsWn0kC11GJT8mjmQdupiuwPolDVLPPc2EV3D4Omnl
         7rWfnT2x3piw64ezhXCeNktfmwX4GuUwiOtk3glbb2BqUIv+j3aSF+H0t7asOAcUTNPI
         BQXW/eoYu+4S3oRW7NMlbE1gclUx4Q22X9T0FX+d2PNzYRo5C9FluWJMmpJqvIWRz+2W
         IO13S4c9e1+A82Kv0VkgGz1X9fvTCQMxWeXkin2MPnbQgVjJAY/Shld9AfMpObvElKnu
         7WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681458987; x=1684050987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW+MbmxIJNrbIzKdDNHsLz5HCe2p5XocFzky4ID/b28=;
        b=e2Req9dzPR7CddKXmhJyTnST0h0Qt72eWdJ0XRRTOzZTt1iS+FP/obrgJIBUWwSzpD
         vPqsmtTwqoB9oNeU204KMrEd94HBunn6WN9U0/k7SDAqlINiScIo8hSQlZcYJSnFgsPG
         T7sTMj5ndvStBAQy9otcrtJfixyMgt87HzDwQlcwaSSpRbtOqjLD4HGqUT6AJ7Mf88ww
         cE4J0oy5hcdx/nSxtkeBnfkWcnAFP7OMrzpvlCIuxeD/FlwuwLfIwZWqJdcMcGSryZw2
         FoT/AUNEmgqhn5HSa9Aj/RPchCgoev07k4NI6qw2suOR1IzOYx0O6yn2BnUCCDqbaCa5
         pEyA==
X-Gm-Message-State: AAQBX9dUzDWN4aDJnhcvDdh9Frhf8t13Aa2FXwnc8QESP7Tuv0/a/J4T
        nuWvanS//XmusrQHDCA/W99cZQ==
X-Google-Smtp-Source: AKy350bWhmK5DRYJSe1ViYwTt7BS/VNalYNzgHTzxjWODRHBfJ99m+BsYbrrBLJS7qShnrdAbySENg==
X-Received: by 2002:a17:906:33c8:b0:94a:653b:ba41 with SMTP id w8-20020a17090633c800b0094a653bba41mr4042099eja.15.1681458987112;
        Fri, 14 Apr 2023 00:56:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b008ec4333fd65sm2047171ejb.188.2023.04.14.00.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:56:26 -0700 (PDT)
Message-ID: <7a73d76c-ede1-6852-6544-acd2ee990ca1@linaro.org>
Date:   Fri, 14 Apr 2023 09:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 6/8] dt-bindings: mfd: qcom-spmi-pmic: Add PMI632
 compatible
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
 <20230414-pmi632-v1-6-fe94dc414832@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414-pmi632-v1-6-fe94dc414832@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/04/2023 01:17, Luca Weiss wrote:
> Document support for the pmi632, often found with the sdm632 SoC.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

