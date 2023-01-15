Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A5366B39E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jan 2023 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjAOTRe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Jan 2023 14:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjAOTR2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2023 14:17:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC9125B2
        for <linux-iio@vger.kernel.org>; Sun, 15 Jan 2023 11:17:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x10so35236786edd.10
        for <linux-iio@vger.kernel.org>; Sun, 15 Jan 2023 11:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNy8Ed1dQVkCck3Yrixd5a7dXF6hx057okDs4An96m8=;
        b=J9u8jotCkPnE07dQeMS/V2VfXKl4wSsLemI/NPc1H9UTsGW1jLShEW9IifSiE1V9bP
         03MemjO0vISX5316LeQd08YOsDuiSJJn7DhDydQ1eX9VnPh7nsNMJNS0u4Suj4qozLdH
         5T+ksi59EtayJ3L77eJZGTcNnbiShr/O4FhKNDt/Qc3UnnMZco4aNiPUtE5TCTXZPwzD
         oAvss0B44SPVPxgZiyDO1DuQ1U7UITaJt39K8eLqjeIwtdC8TDy5YCkFLsM2eetT7nL8
         6ifnVVFvvaLkNdbb/lC0/9IMw2YS33UmoYr5e3lutS5X+FrZCcc5sr49AzNassyo7E6s
         hsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNy8Ed1dQVkCck3Yrixd5a7dXF6hx057okDs4An96m8=;
        b=8LXYnk8+H9Uhhd96l0j61bDglEdLAlT9/TS5S5cFTLccglGJnlG27lwbNl7fIIbfOh
         19ukAqfzIv+t2eI3afdyK8SVH+uubG23PYEh1o2x3yqzMOE/9ovnagZqY7i0OPPnl1l0
         K1OBc64vBkDznteT5VJwgSddWVNuwXDmnauR5QyyJ1v7hpUtB+jYPLbvipopJ/t8+Q5M
         0WVgfjBJv6LVmzLlXURO12S1EpFTNuV3fDbtgs1Mw0spluLe9fZrnhScaWDqFe0Vd4ol
         jHPJRg/menKs8zWvJ1o/GM0KhEJ0DDWE+M33iebCHGaGuxGuVFaUYw4FR27anp60DFl6
         3ITA==
X-Gm-Message-State: AFqh2koHW7AE1ThvlgLJ/xBZuTb4TtDDLcJ99ZNebMTfpLcKWJCnmRux
        vyAs6JqEnXp+EjAgwCMUYd2AZw==
X-Google-Smtp-Source: AMrXdXuu7deMsLziMX+f5y3yyfP4oYwu1gZcHnWOxhlz1HM7IMfRK3+mV5HRCYinCSuzyRrA9LwpSA==
X-Received: by 2002:a05:6402:2484:b0:46c:6ed1:83ac with SMTP id q4-20020a056402248400b0046c6ed183acmr84595212eda.9.1673810246439;
        Sun, 15 Jan 2023 11:17:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7cb8e000000b00499b6b50419sm7636491edt.11.2023.01.15.11.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 11:17:25 -0800 (PST)
Message-ID: <e30a869a-5585-901b-6a56-3e327e0cf60a@linaro.org>
Date:   Sun, 15 Jan 2023 20:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230113194959.3276433-1-hugo@hugovil.com>
 <20230113194959.3276433-3-hugo@hugovil.com>
 <dee8fbdc-5399-d5ce-8d01-2c48e85e2919@linaro.org>
 <20230115112205.e46ab8d017b99dd987d003e4@hugovil.com>
 <20230115164326.7f03f6d9@jic23-huawei>
 <20230115113250.d8a0ec5a2638e24c1208539c@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230115113250.d8a0ec5a2638e24c1208539c@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15/01/2023 17:32, Hugo Villeneuve wrote:
>>>>> +    required:
>>>>> +      - reg
>>>>> +
>>>>> +    additionalProperties: false  
>>>>
>>>> You are not allowing anything else from adc.yaml. Is it on purpose?  
>>>
>>> I am really not an expert with this Yaml stuff, and reading the documentation makes me probably more confused than before reading it :)
>>>
>>> But one thing that is for sure is that these other properties in adc.yaml are not used in my driver:
>>>
>>>   bipolar
>>>   diff-channels
>>>   settling-time-us
>>>   oversampling-ratio
>>>
>>> So is it Ok then to use "additionalProperties: false"? I think so, but what is your recommandation?
>>
>> Makes sense to me.  Whilst there are lots of things a channel can support, most
>> of them are hardware related and not universal.
> 
> Ok, I think I am finally beginning to see the light here :)
> 
> So I will then leave "additionalProperties: false".
> 
> I will send a V4 soon with all the latest changes.
> 

Just to clarify - we talk about hardware, not your Linux driver. What
your driver uses or doesn't, should not matter here that much.

Best regards,
Krzysztof

