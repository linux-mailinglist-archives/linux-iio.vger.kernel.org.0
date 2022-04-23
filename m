Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445D550C98E
	for <lists+linux-iio@lfdr.de>; Sat, 23 Apr 2022 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiDWL1G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Apr 2022 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiDWL1E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2022 07:27:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FDA1CDEF6
        for <linux-iio@vger.kernel.org>; Sat, 23 Apr 2022 04:24:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a21so1111288edb.1
        for <linux-iio@vger.kernel.org>; Sat, 23 Apr 2022 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=heQS+dVDN4frEP6+SfBzBy/7n2LAR927HAbPZjQGj7M=;
        b=MfWiWls5g93yczv8pKIuH1nSQpXT+An1g1Jjy2cu4chEvZ+evhwj38xixM8gAPEnds
         A4RbYm155hHZpz36972BG4sADLOS4lOdJFBw56/vhTLLDznrq/KcvZrazH/XsyEl5fZQ
         mG7+LCJxti2y/ASHqoDLw3/yMiqmcRnMPujDq5iAD5jdnkQTfPz+6aKDRoGKdqAu1BJ7
         +pwNPdfqPO9Dfp08If2Juyf7NfxTIBpaFxojcNiE3wz3Xu4r+KOjHJ/JHRu/+seO520O
         HDTPDqYvuFFoyUFxGEGQNIDzS0bVOHswQdpLLP7x6ATZOyYXLRn2g42SgrVUYdcf3yMr
         ua3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=heQS+dVDN4frEP6+SfBzBy/7n2LAR927HAbPZjQGj7M=;
        b=ygkJbuyk9yIVxUmxKLbCHmjujXRBVMUPSMLRPUUjWSxOAsyARwAIBuFqvBj8PYOZgr
         7a/iFsWwTRD1Q/HQuN6Jkkgt+nNJZa0AYI8LpM0KXhHlyQdaj0k6goxIkwsiYzcCRbAC
         QgoMslSZc/3EIvuC5/6+2WLfZBkLs9zeQlnC8IhIcFlnatqN6lnuBiVX6hzhZV66e4ww
         /uG1Txt7R6u5bsXFIsM2jn2YKfOCeY7+SlI0n2SPUnWDyM9AM65BSUQpFQY4UkE/UGC+
         FxJQVmyjOw3tN3A9xkfiODmz2VqtNfQKHpQsyGm25xq2sXPzBB3c9chdpdB/0mHuMuHM
         uqgg==
X-Gm-Message-State: AOAM531SxeJAWMLq8XgIStyBHKdB09tviQd+0HdWx6LvG0aNFS4Ppsg6
        byVZa4nGJSedUjUOmfO4Pxme3Q==
X-Google-Smtp-Source: ABdhPJzHXBavCT4NUJHxfqpxC8uchKX6t2PgRhUD0mpd+tE/7tS9xtxwSeUtkCJo9vLrt8TEnxdtbw==
X-Received: by 2002:a05:6402:1541:b0:41c:bfb9:d56b with SMTP id p1-20020a056402154100b0041cbfb9d56bmr9585687edx.344.1650713046706;
        Sat, 23 Apr 2022 04:24:06 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm1587342ejc.42.2022.04.23.04.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 04:24:06 -0700 (PDT)
Message-ID: <1bdfdfff-0de7-6fa1-b308-31691168d4fd@linaro.org>
Date:   Sat, 23 Apr 2022 13:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: iio: Fix incorrect compatible strings in
 examples
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Slawomir Stepien <sst@poczta.fm>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220422192039.2590548-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422192039.2590548-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22/04/2022 21:20, Rob Herring wrote:
> Fix a couple of examples using incorrect compatible strings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml     | 2 +-
>  .../bindings/iio/potentiometer/microchip,mcp4131.yaml           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
