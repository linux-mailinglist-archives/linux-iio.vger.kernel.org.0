Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D297C6552C1
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiLWQYE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 11:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiLWQYA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 11:24:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D55B7F7
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 08:23:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p36so7608902lfa.12
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqbPtdN4Ga8jmbf4cA7qcYGgPp+8Cr3OAzvWEvWWVNE=;
        b=DTAu3kbsyBh6Rh8zBfqvr9pLjcOwfpVYU9Lt8Nfb+3RVpCQEG9VhJAagxg8t2ijg+f
         cGMkATIRp3sKr7poAgSxOiwzpmnC7lnxtDPXmJvc9VmXqX4dbtiwBwWRqYUe+vzfiq8p
         8osWt36RqOR7CnXs3rsmZdqswoQ1rRt4QXEvVG7eCXTKjXGQ79AiV+DSk7+Hz5CqkYyH
         B/jAcRENWk20wVjesXLrMb5lqU+GbslxqFdxfnoF7+zJ02YiiEXGQDGNV9wGd7JlbSgn
         CkwC+75RL76/51nrCnTv3seo1nbJqiGorEnrBdPYGkyR1wUCfIU39dHEfgGvVhEqWDzS
         ZKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqbPtdN4Ga8jmbf4cA7qcYGgPp+8Cr3OAzvWEvWWVNE=;
        b=5nRgKjqNrcahFNM8wI5TdbqV0+fqG0CfoRq2/2/8RTrRk0ElxE9gENaq/N5ANtN8OF
         IOeNm/BYPORtaIi10F4hGhQRuF1AC77vOm/1hv9tOC7aIp+sSlIXXNAHwbvdehV0xC58
         BIVOEK3wcgK/1RkZXNg7q9K5hkoECnRIeOQOv0Eii492Ob09EANy0hDMKd3D9f2qUNvL
         0+Y5P7atQDPVw4joF/ZmfcFjvkTglZuLgHgS3aZF901do+dWPal2JiXVm1uCK5fuwJTq
         SWfwjM0XbC5Fzvil01F4wmWtkMyrDcH92MifTOEyUSZbnM35na+6O2uOOwqDQQgH8HVq
         WKbg==
X-Gm-Message-State: AFqh2kqzDsOp0PITk1adbLvOiPZqEL0FvJNFvCQcfEB9WaaXyJpHYCat
        uSFzea1Wq/tQg4aZ1VkoUS/Ckw==
X-Google-Smtp-Source: AMrXdXsFDMYXg8JXISUy+Ue5UM8tHDF0Ayo8BBFfVXP0vcTdZYfoO4mJpcorsXJtcTOjF/YVeZXyIg==
X-Received: by 2002:a19:8c4e:0:b0:4b5:78e1:8924 with SMTP id i14-20020a198c4e000000b004b578e18924mr2673159lfj.19.1671812637234;
        Fri, 23 Dec 2022 08:23:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j11-20020ac253ab000000b004b585157b62sm573801lfh.258.2022.12.23.08.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:23:56 -0800 (PST)
Message-ID: <70b0b66a-550d-5b40-47d8-73dce197a2dd@linaro.org>
Date:   Fri, 23 Dec 2022 17:23:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: iio: adc: max1238: Fix a typo in the
 description
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Fabio Estevam <festevam@denx.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221216004015.2902966-1-festevam@denx.de>
 <e7b95521-9a2d-7c0f-a379-b32d4aaf1031@linaro.org>
 <20221223160405.32ba9716@jic23-huawei>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221223160405.32ba9716@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/12/2022 17:04, Jonathan Cameron wrote:
> On Fri, 16 Dec 2022 12:30:42 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 16/12/2022 01:40, Fabio Estevam wrote:
>>> Fix a typo in the description, where "interface" is spelled incorrectly.
>>>
>>> Signed-off-by: Fabio Estevam <festevam@denx.de>
>>> ---
>>>  Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
>>> index 50bcd72ac9d6..60d7b34e3286 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml  
>>
>> While fixing such, fix also max1363 in the same patch. Or maybe even
>> more files (but then usually split per maintainer).
> 
> Absolutely agree that it would be good to fix the other instances.
> Still, I'm not going to not take the one fix in front of me today
> whilst waiting on that ;)

It's also quite a churn to do reviews/commits/applies for such trivial
(without functional impact) stuff per each commit... but if that's okay
with you, let it be. I sent one for max1363.

More commits towards next LWN stats :)

Best regards,
Krzysztof

