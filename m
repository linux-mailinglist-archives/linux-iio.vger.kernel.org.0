Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2BF514980
	for <lists+linux-iio@lfdr.de>; Fri, 29 Apr 2022 14:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359311AbiD2Mjx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbiD2Mju (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 08:39:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA21C9B4F
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 05:36:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i5so10587551wrc.13
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eHBs6Wa9r1VbHh/2aicD7vVCojI5eLmVYJiucsgDFTk=;
        b=XqZ+y6bbbSv2+K44Xm6/VbTJoc9xIp1XuWEYMITpXxYMPU9cFVPOLnVUT4NgcviQtA
         WrRCGQYy21MIJC+ZIpySVhHvbyFGrgtvYyjQ+7gid1dXuUJW7pFE9eEzuzMmvnld4X5b
         k7zB4O+sjQOmCFfTpmo5mN9fI6D5M9hNyfQ5CogrFytmz9ZYe3xlLLv0RXXUOO54kmea
         LPQZvfAlXUrjM60hCjVsG/m9SxIlw7XwomTV3Do5+/X76KmpGbV5iz1W34zaISujW+O9
         6VvLpjZZ27GZAVe3ZMwPcASx3QyQ/DEXa2gIXlkxN+IHzUU6cIn5eUEi05Z24L9H8d2g
         2TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eHBs6Wa9r1VbHh/2aicD7vVCojI5eLmVYJiucsgDFTk=;
        b=avf52WT9Jkk4pnoR3DZenc2VAAxg3R541NkWfNaN1NsfmnsbobSNG5V39kKJpbrCp0
         VR7h0Z2VvBxi6wFY3inoR/GBylcvOQy/erSbsMVq7pn0I+JuhtRZpJN+/urt+R9bbUE2
         nd6hhe43UrTETjd+ncEQMYro3AKOTZRxRKWUJkrLzsJiMB/MifTITJDcIPGJs8xKgP9f
         Mc9nlSwWi6mHJJTnMxlYTtT0rmvL0V+TQ4EEcQqcx4GOwjFB7j/MuRpiZ3pBjUaG9rBw
         BF6Js1O+FYTRMiJ20wdWlMcweMTL9463Jkgv4nqBeyq2upCVyQqjVsFR+4vrB9i1EQBp
         YwZw==
X-Gm-Message-State: AOAM532Kt5IgsuwiK8RKyDWj24QaAzOmB5xEcRONsUMNzxgaoVRkRnBJ
        USEhcVw5DahffLEg8A5Z4vBB7Q==
X-Google-Smtp-Source: ABdhPJyy8JUFUfBnijB3GYFKp10PJWH4OqLaYHArQcZhhhkQ92FLDC0Q6RKTfrlQxwq7UZISf2kz9g==
X-Received: by 2002:a05:6000:188b:b0:20c:47af:1058 with SMTP id a11-20020a056000188b00b0020c47af1058mr2787417wri.58.1651235790067;
        Fri, 29 Apr 2022 05:36:30 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d5545000000b0020af6c38da3sm2334651wrw.33.2022.04.29.05.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 05:36:29 -0700 (PDT)
Message-ID: <d4d8d158-4f59-2158-1764-0c9ac61723eb@linaro.org>
Date:   Fri, 29 Apr 2022 13:36:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v13 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220323162820.110806-1-caleb@connolly.tech>
 <20220323162820.110806-3-caleb@connolly.tech> <Yma4T1+AglaISe2l@google.com>
 <2763f103-6947-e431-cef5-e202c324d678@linaro.org>
 <Ymq9Su3UE5IYiHnI@google.com>
 <cce2f4b7-3620-7a33-ef21-579eff9a7dac@linaro.org>
 <Ymu4jUup3YiX6p3X@google.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Ymu4jUup3YiX6p3X@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 29/04/2022 11:06, Lee Jones wrote:
> On Thu, 28 Apr 2022, Caleb Connolly wrote:
>> On 28/04/2022 17:14, Lee Jones wrote:
>>> On Wed, 27 Apr 2022, Caleb Connolly wrote:
>>>> On 25/04/2022 16:03, Lee Jones wrote:
>>>>>
>>>>> On Wed, 23 Mar 2022, Caleb Connolly wrote:
>>>>>> From: Caleb Connolly <caleb.connolly@linaro.org>
>>>>>>
>>>>>> Some PMIC functions such as the RRADC need to be aware of the PMIC
>>>>>> chip revision information to implement errata or otherwise adjust
>>>>>> behaviour, export the PMIC information to enable this.
>>>>>>
>>>>>> This is specifically required to enable the RRADC to adjust
>>>>>> coefficients based on which chip fab the PMIC was produced in,
>>>>>> this can vary per unique device and therefore has to be read at
>>>>>> runtime.
>>>>>>
>>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>> ---
>>>>>>     drivers/mfd/qcom-spmi-pmic.c      | 261 +++++++++++++++++++-----------
>>>>>>     include/soc/qcom/qcom-spmi-pmic.h |  60 +++++++
>>>>>>     2 files changed, 231 insertions(+), 90 deletions(-)
>>>>>>     create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
>>>
>>> [...]
>>>
>>>>>> +			/*
>>>>>> +			 * If the base USID for this PMIC hasn't probed yet
>>>>>> +			 * but the secondary USID has, then we need to defer
>>>>>> +			 * the function driver so that it will attempt to
>>>>>> +			 * probe again when the base USID is ready.
>>>>>> +			 */
>>>>>> +			if (pmic_addr == function_parent_usid  - (ctx->num_usids - 1))
>>>>>
>>>>> Double "  ".
>>>> Ack
>>>>>
>>>>> Over-bracketing of statements with matching operands.
>>>> I don't think x - (y - 1) is equal to x - y - 1? Or am I misunderstanding you here?
>>>
>>> Can you give me an example when this would be the case?
>> According to the Python interpreter:
>>>>> x=7
>>>>> y=4
>>>>> x - y - 1
>> 2
>>>>> x - (y - 1)
>> 4
>>
>> C does also respect the first rule of BODMAS - parenthesis are always
>> evaluated first.
> 
> Fair point, well presented.
> 
> Thanks for this - I understand the problem now.
Thanks,

Could you respond to my other two points in 
https://lore.kernel.org/linux-arm-msm/2763f103-6947-e431-cef5-e202c324d678@linaro.org/

Regarding

if (!of_match_device(pmic_spmi_id_table, dev))

and

ctx->num_usids = (long)of_device_get_match_data(&sdev->dev);
> 

-- 
Kind Regards,
Caleb (they/he)
