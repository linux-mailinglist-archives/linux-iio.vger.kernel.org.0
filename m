Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847975C68E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGUMHz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 08:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjGUMHx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 08:07:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528721BDC
        for <linux-iio@vger.kernel.org>; Fri, 21 Jul 2023 05:07:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99357737980so296130666b.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Jul 2023 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689941267; x=1690546067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnaJZllXk7/bDz5bL7Xem7eehrCa/S2AFbCxOH9yeVg=;
        b=fZwtbMpYsPkZGJMyF8pFbcP/a3bZ5iBU+4NnH04AkEvJEdDGWZUqiHZi9o+5RnxdAM
         rmhJukHBwjAWirz3SkeCIT9KcxMMWYDuBpz0+vTtJOPbNVvBL+sFViYZFKmxZxx8EYvu
         FQ73eipxktA9gUrmyJFIdrbpbnT2vNP+B3QApRYtwRhnqQvaCYpO0bglY6brYkHq+6/K
         ah2jAupmBqh4bH2CWNsPmLLq9krwU2zqtcgPxkTU/bqsXJ4raUMhzIbWF5U4jc0LaQej
         O2+6KJo+vd8Axe4BiTo0vDSHNQX2FJCo+OiJO/gLF8Qug9nGoCBAZ4wi+v6dzdpxHNbJ
         zjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941267; x=1690546067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnaJZllXk7/bDz5bL7Xem7eehrCa/S2AFbCxOH9yeVg=;
        b=Tk9GEZXIOnN49ynXEpupMCuvDVdF6j14auQyLQJgGH6uV/86YoT68Gu0/VQZOaLuWx
         CYDC2aPTg2gSxFHC4yAlgW/APzibF4TO/RKUXKZlnrf98fV3GangucYkN6aSeJRu6kiB
         gcETRR8t98dN+WAjYhX/pAhQurG+UcfLA7osVfzXS53MChYL9iA3a/AN516HoC//92Vy
         62A63jPMwDDgUMcyKhcangww/ZAWllOy2L1JMIzZzHYm8M43vn2zwWoTfzknn8y7R+bP
         ZgRY3bTlI4LgIEvUft0ZUGXuh7YDyRqcPlRXNeZk0AtBZvl/3v6YA8Q5ffpqZNkZn5Aj
         jpMA==
X-Gm-Message-State: ABy/qLZi2eQBpx5j/HEsv3fAXqr8zYozL+1WzLifQDBDd9/0iFT41DPs
        iMDPzR009Q9VA71lLvAlLsGB4A==
X-Google-Smtp-Source: APBJJlHluQWVEzu0sJ/PrWjshX/401eG7m9xwGfKfw97KqNLFANPd8vq1eMtLADPF4i+eyWPPSmktQ==
X-Received: by 2002:a17:906:cc0e:b0:997:e79c:99dc with SMTP id ml14-20020a170906cc0e00b00997e79c99dcmr1364395ejb.74.1689941266697;
        Fri, 21 Jul 2023 05:07:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090608d300b0098d2f703408sm2089541eje.118.2023.07.21.05.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 05:07:46 -0700 (PDT)
Message-ID: <25efdb2c-21e0-9a98-03d2-0d4cdeaaaf8f@linaro.org>
Date:   Fri, 21 Jul 2023 14:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Content-Language: en-US
To:     Andrea Collamati <andrea.collamati@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
 <4898bc33-5245-8fb2-e5e6-8ea1a8f32e1e@linaro.org>
 <d010f085-ea0e-5086-260e-c5a9be94ebfb@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d010f085-ea0e-5086-260e-c5a9be94ebfb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21/07/2023 13:58, Andrea Collamati wrote:
> Hi Krzysztof,
> 
> On 7/21/23 10:21, Krzysztof Kozlowski wrote:
>>> Add documentation for MCP4728
>>>
>>> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
>>> ---
>>>  .../bindings/iio/dac/microchip,mcp4728.yaml   | 48 +++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>>> new file mode 100644
>>> index 000000000000..6fd9be076245
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>>> @@ -0,0 +1,48 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Microchip MCP4728 DAC
>>> +
>>> +description:
>>> +  MCP4728 is a quad channel, 12-bit voltage output
>>> +  Digital-to-Analog Converter with non-volatile
>>> +  memory and I2C compatible Serial Interface.
>>> +  https://www.microchip.com/en-us/product/mcp4728
>>> +
>>> +maintainers:
>>> +  - Andrea Collamati <andrea.collamati@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - microchip,mcp4728
>> This is a friendly reminder during the review process.
> 
> Sorry but I didn't understand all your requests:
> 
> - I changed in the title mcp4728 with MCP4728
> 
> - I added description
> 
> but I don't know which blank line or whitespaces should be removed.
> 
> Can you tell me please?

You forgot to add blank line. Open example-schema and compare.

Also, you had white-space errors. Editors should show it to you. Git
maybe as well.

Best regards,
Krzysztof

