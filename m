Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD101553195
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350389AbiFUMDs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 08:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350392AbiFUMDq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 08:03:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CD2B247
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 05:03:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c13so14569875eds.10
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=20hOXgHS4fSMKzf2+VEVhuMt/xTY7rwW+BkuR688jQI=;
        b=G0fDoM6iYkilX2J2us0oDAnu2OXLTFoGwQGcIQ61gW+KroUP3F34RD4BJ1IlsFeOKi
         8f8+8bvCxI+BjoQhqGDC8Bmih/uM2UMNh0HfP5LHcTP5thFbXw57Wl/JjRk3EIaphPgC
         /r9iH8r0MZLQ/ZiseG3jh/J+adm1eZ8inUGHNLerNsDK1bRyGyI9t7y5tTAvDDVdeB1B
         xwLgffZMmNEJhBSsXCtiJaQ53o6MWqYnFwBx1ozBtod/JlyyMz+pR8DZEdtPNbe/8IO5
         pZskEbg504lpOOtekPsnMcsUaoBfJ2WNfNfE5rDxevNShYsJWXp++OGVY0izxGKuJIRl
         k4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=20hOXgHS4fSMKzf2+VEVhuMt/xTY7rwW+BkuR688jQI=;
        b=IMlRHhEtJ87pXKBQ8q2f5YnZ9fc6FLtXOzZrrhTE4da6UMYpQb2iMkCrgbNRiY27uv
         rKuS3zk0h+KEuRvQ7K7Cybb5YLs4MIQSS63agMF+v1cAlkBp2+N1Quriqd+3j9IDnbH9
         TGC2974bpBdv8j+bZYOvNJocPOSQxgOVmGX5s2RDCjnS3M1H86m93eQx1Gu6rqOhLGvx
         +j75KQynT7QCAnmxMRY5hFUqtDEZGhGGhPLXvEDiw1T5eK+9nxBCsd5ILQl6ImGOZp6V
         N6gBeUYHW6tYLiuQFV0R8aj+6Rk6HSr0ZdN+cFp2DQlR1Cai/KDQLM1DciLf3QDmNVyG
         P/Gw==
X-Gm-Message-State: AJIora/uDiI+CtLDRVEkLtU7UqlIA77LkzlOnUG0TY1c/RS3m4itNtbq
        6mb+t9cCjOtOJbHZe1AQ/b87Zg==
X-Google-Smtp-Source: AGRyM1vuqpi73lfGfP1AhQV/V6GZDUbkiFuWxRqJMB+M0pVkbVaH3yMP1muhb8X6319Kpo4FNFG3DQ==
X-Received: by 2002:a05:6402:3689:b0:435:95b0:edf2 with SMTP id ej9-20020a056402368900b0043595b0edf2mr3480378edb.279.1655813021696;
        Tue, 21 Jun 2022 05:03:41 -0700 (PDT)
Received: from [192.168.0.220] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906840c00b00706c50870a0sm7470520ejx.194.2022.06.21.05.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 05:03:41 -0700 (PDT)
Message-ID: <3e02909d-131a-7899-f02b-fa0afcbef1d9@linaro.org>
Date:   Tue, 21 Jun 2022 14:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 03/15] dt-bindings: leds: mt6370: Add Mediatek mt6370
 current sink type LED indicator
Content-Language: en-US
To:     szuni chen <szunichen@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-4-peterwu.pub@gmail.com>
 <91e9e3af-8208-7535-1864-08744f934593@linaro.org>
 <CA+hk2fZbh0=8gurGS95XpXrYyF3NbwFbFMcygcrW_q10m0zinA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+hk2fZbh0=8gurGS95XpXrYyF3NbwFbFMcygcrW_q10m0zinA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/06/2022 05:07, szuni chen wrote:
> Dear Krzysztof,
> 
> Thank you for the valuable command.
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年6月17日 週五 清晨5:09寫道：
>>
>> On 13/06/2022 04:11, ChiaEn Wu wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Add Mediatek mt6370 current sink type LED indicator binding documentation.
>>>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>>  .../leds/mediatek,mt6370-indicator.yaml       | 48 +++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
>>> new file mode 100644
>>> index 000000000000..42b96c8047a3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
>>> @@ -0,0 +1,48 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: LED driver for MT6370 PMIC from MediaTek Integrated.
>>> +
>>> +maintainers:
>>> +  - Alice Chen <alice_chen@richtek.com>
>>> +
>>> +description: |
>>> +  This module is part of the MT6370 MFD device.
>>> +  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,mt6370-indicator
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  "^(multi-)?led@[0-3]$":
>>
>> If this is multi-led, then you should reference
>> /schemas/leds/leds-pwm-multicolor.yaml
>>
>> See other examples using it.
> 
> In my opinion, leds-pwm-multicolor.yaml is used for external pwm
> signals, and needs to assign an external pwm property.
> But our pwm leds use an internal clock to generate the pwm signal. Is
> leds-class-multicolor.yaml more appropriate?

Yeah, I meant the latter but pasted wrong file.
/schemas/leds/leds-class-multicolor.yaml#

Best regards,
Krzysztof
