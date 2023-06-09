Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023F5729E94
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jun 2023 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbjFIPdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jun 2023 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbjFIPdI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jun 2023 11:33:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F4630D8
        for <linux-iio@vger.kernel.org>; Fri,  9 Jun 2023 08:33:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso3345441a12.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Jun 2023 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686324784; x=1688916784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ur31KDmwW2Vamx0iLWm8eg6eZn3xEBjuZ8itz/0+GJ8=;
        b=mdsstRzL1QzvciUaKcbVLGU5Xu4erVa66pzYFwSDmbTqK10o6fleyMabNyzGT2Vylr
         zsKdcQQcxcccKeNdC7iRPc7v9j5B0cpKHto6OR1Zhl6ijtRroUJCbvb44JOBxPvOI0bc
         C93vTwtSB1Sjlgh/zaI+HPLS2r+eqJLRT4PG2CmH40Zck2w3jxN9gANBo4S0nkD6NRy/
         ACXeLJR0qtn5HU2RdtFkK/L+AFCqwZB2hpRFz7Nr5PVGjyyeIZ7c15hlBVuuyz1L68bf
         FdCP86LpyK2HBGj0rP9yli/1eRC8ioYTEGOOob6vWkvYMiAIAqG586uZ2t4mIAUGkJxx
         AKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324784; x=1688916784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur31KDmwW2Vamx0iLWm8eg6eZn3xEBjuZ8itz/0+GJ8=;
        b=NmKGTs6NioJ/+OQPv3Ndk1qVGioIsFAf5SuyS8wgBucaXPGz1loOxzTA0kxLKkyLYD
         LTix2k+sKgRBvEuPMOQ9UqwX8gezAeip9m8Ge7lALCcK300UdAOMAGBu3HNjJf1KPp/v
         d/YjTSpS+MkCfibJjLl1ZluTc7qBVfvSnBMG1on6CBidsH4wnmydP5auFvKGeZHkOW1I
         V+3B9brj9tEFokUKulisn9X4lLDrFzmYNQ0G824njqQ6xkhFHxTt88dZizYgR/RF1G6Y
         kQffnfWMK3UfH33rXPRwcc+Q0Bk8y8ordbf+ThrM+ZlX4IJFrmoCOJXWK5NoSnfuaFra
         qiRw==
X-Gm-Message-State: AC+VfDzF4vT1tQT6O+FJA5Qt1GeQy+qY+0HBkBre5R/Y9iBib90vXRZW
        aGm0UZLv1RjwSODmW/wycASPLg==
X-Google-Smtp-Source: ACHHUZ6y/JtCqm1Lj+q+Mwlen94gR/wsS1Sunol9iGCi91EQ5CdAJ2o7vqnELK3VT2rNmemmAe/ldw==
X-Received: by 2002:a17:906:dc8e:b0:968:4ce9:677a with SMTP id cs14-20020a170906dc8e00b009684ce9677amr2279333ejc.38.1686324784301;
        Fri, 09 Jun 2023 08:33:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1400632ejd.221.2023.06.09.08.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:33:03 -0700 (PDT)
Message-ID: <b913e3a3-bc32-8d2f-c2a9-9c7e860b7b15@linaro.org>
Date:   Fri, 9 Jun 2023 17:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/2] dt-bindings:iio:adc: add max14001
Content-Language: en-US
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230608175517.40217-1-kimseer.paller@analog.com>
 <20230608175517.40217-2-kimseer.paller@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608175517.40217-2-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/06/2023 19:55, Kim Seer Paller wrote:
> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.

Subject: still missing spaces, no improvements.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

With subject fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

