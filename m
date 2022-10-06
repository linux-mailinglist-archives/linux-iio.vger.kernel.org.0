Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8EF5F6A77
	for <lists+linux-iio@lfdr.de>; Thu,  6 Oct 2022 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiJFPXN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Oct 2022 11:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiJFPXK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Oct 2022 11:23:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F8CB517E
        for <linux-iio@vger.kernel.org>; Thu,  6 Oct 2022 08:23:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r22so1296607ljn.10
        for <linux-iio@vger.kernel.org>; Thu, 06 Oct 2022 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=v5igb7gwPlo9b9xJTbh+HYwPUReqdxp8k/iwdLyM9EU=;
        b=eYmYAeveDQX8Z1ffiggnnncFTrH0EMubH0QAEpO8D/gyMnPafpdvTGP9eXlvnw3D9J
         w+oQ2nUztfJsZGp2tcgdPc/p+J75svQrhKVDOc+Td3WCwhHTA2drZVu8In+81LMjzjbq
         uySqjkaH9Z/0S5D54Q9qyt0EsT7YB6Ghb5fMGYczJaW7V6mrDmBZkeQRN4dKFkrD4BrL
         OPMavks5I21EWR+f+6gcCGPdddaaZLaXEekgD5ZEbyFW+HdX44SANbqIvAazGzk3mLYc
         /fuZ8o04YBbHa7SqE4pX9unLbv3WT3a96qfGd95H+iUqNXNozqHBKrpt794HpBHjJ0Ts
         U09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=v5igb7gwPlo9b9xJTbh+HYwPUReqdxp8k/iwdLyM9EU=;
        b=BZ4Bjldh3fG8ewLv+iclXiAIeirywLpYzh4Iu5LXZKfwRtsfJMfd1EzY+qen95RngV
         9jWfZ8JfrddtB0gJ2Jxov+OVF7vfiTDaI1SLidRenKrZ0SKa5u+axGExeREtmRcx4WEK
         0VyTJipCWg2QO4ueM6575XzWHEkmPZ8gK65g0Yca8bzartX9gqOaobuJPPpUlb5gO9rk
         JVBwomULOyINa00GbPnYNz60hN2IXdFNAp1X9BlFo67waYaWGeui35yal3nDr+6OajIt
         +dhjKUSzQdz5iQkXETHV9kWS/8v1GoD7ThOYQCG7w35HWOWsAjEqbAtlyB1BVTz6lBNF
         oArA==
X-Gm-Message-State: ACrzQf35cnYYOmFPdQnKMidAfLB6avxPwgsaUwvooQZCqbzXfL+6mf0n
        gCO4J+j5b035HRXEvlmKmGQILA==
X-Google-Smtp-Source: AMsMyM4KRHyhdJ+ushWbyAxsX2Gt18Zz+oPfj/QUFJpmQFKOOZ3Ubpx37LQSn2biWbCb1WfiIh0y3w==
X-Received: by 2002:a05:651c:1509:b0:26c:6194:9c03 with SMTP id e9-20020a05651c150900b0026c61949c03mr74583ljf.314.1665069786936;
        Thu, 06 Oct 2022 08:23:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w20-20020a05651c119400b0026ab83298d6sm1910856ljo.77.2022.10.06.08.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 08:23:06 -0700 (PDT)
Message-ID: <fc7c064f-074a-e66a-07b3-541f2ad56804@linaro.org>
Date:   Thu, 6 Oct 2022 17:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH v2 3/5] dt-bindings: iio: Add KX022A accelerometer
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <80fa42040f385eb47f4f3c71b9b02f643a643e38.1665066397.git.mazziesaccount@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <80fa42040f385eb47f4f3c71b9b02f643a643e38.1665066397.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/10/2022 16:37, Matti Vaittinen wrote:
> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The sensor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g) and probably some other cool features.
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +properties:
> +  compatible:
> +    const: kionix,kx022a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2

This allows any order, which I assume was your intention. However maybe
at least fix it a bit like:
minItems: 1
items:
  - enum: [ int1, int2]
  - const: int2

OTOH, the names are not really descriptive. Do they match pin names?


Best regards,
Krzysztof

