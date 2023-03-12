Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C36B64C5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 11:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCLKPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCLKPG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 06:15:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424F631E3F
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 03:15:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so8156487edo.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678616103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftc13AeA8t3IcoWqIEgQomy23Jg//eoNjxchphe7r3I=;
        b=l/meP0wxj9w0bsD+ThNVSfLh5pGTg/z+vP+YRSv3oTJYPVJs/+jxnlh1+TtYpi3kGY
         /BLqnmxL18mS66/LI4FmlrMhL7Ax24bOkGoFcbkn/rFy8BrBO8Ida42AikCbAILZZxZg
         /burAHCQv9W/PQlhEE8ZuWYX7OO5/42/sYNr4QhU+faxig3gxqIwjkUWwadc6zr4ikee
         GSt7v1sd93k1vKdUVdOyQDdRUJdU4rwHjzam8CCdNrWJEf7SeytYhuzL86+d1AZa0ZPE
         u8TgMtxhOJzsFwkBWZ+xid6XFXTFF7JFTF5KY/GpXx6ZpdqAK43ChcBVeYIu1vwYZRLk
         7Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678616103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftc13AeA8t3IcoWqIEgQomy23Jg//eoNjxchphe7r3I=;
        b=K7MMw2pV8h3EIwGCQ9a31e9F62yw9+rcqAg38GU8PrHjo7tTTSk5hTZFntg607r4ea
         y6NbJQzVP26wPTris/oVe4r2Dl4Gt9uahT7HPgRDLWCExs39yaW+Efy5rN/V3uM1iQRs
         O1A3W3P50mKPubd8t7Ap60u+yUKU72mialCIVVQ2/DeE5DgH+Q15b0DvqyS7YCL5tWXc
         RniQDDi47HcTiUg+p9L4ZUk5Glvla4T/gO7Ii54cpDaqxu+vJachDDy7ZbktCxO+zzYK
         EYUumEswX5i6RwxNNBk/PFIwx1eBNbILomB3xvT5JSWto4NEocx+GO64XlTNRFMkPEc2
         2aKw==
X-Gm-Message-State: AO0yUKVhRiT1ojir22TOimDJfyuGRkj+z5gR9QWPXVe5Wpll6t8GyoOj
        5HegrVCEBwHctyqyCN1yb+oq2Q==
X-Google-Smtp-Source: AK7set9WdVZa20JlEqtArNMIKQ5FZKuBp1LV9C2WDdyLc338ZZE68jaOQGXKPpuWy3VNvq1nUtHJxg==
X-Received: by 2002:a05:6402:1adc:b0:4ac:bcf9:6d6c with SMTP id ba28-20020a0564021adc00b004acbcf96d6cmr27232017edb.36.1678616102722;
        Sun, 12 Mar 2023 03:15:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id n13-20020a50934d000000b004c13fe8fabfsm2023066eda.84.2023.03.12.03.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:15:02 -0700 (PDT)
Message-ID: <c9cfb54e-1418-ac98-9021-0c27a8bc3c20@linaro.org>
Date:   Sun, 12 Mar 2023 11:15:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] iio: light: max44009: add missing OF device matching
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
 <20230311111457.251475-3-krzysztof.kozlowski@linaro.org>
 <20230311122619.2d8bfaf5@jic23-huawei>
 <8f448bc9-2f2b-77cb-ffe2-895593a6047e@linaro.org>
 <20230311183534.1d0dfd64@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311183534.1d0dfd64@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/03/2023 19:35, Jonathan Cameron wrote:
> On Sat, 11 Mar 2023 13:28:17 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 11/03/2023 13:26, Jonathan Cameron wrote:
>>> On Sat, 11 Mar 2023 12:14:56 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>   
>>>> The driver currently matches only via i2c_device_id, but also has
>>>> of_device_id table:
>>>>
>>>>   drivers/iio/light/max44009.c:545:34: error: ‘max44009_of_match’ defined but not used [-Werror=unused-const-variable=]
>>>>
>>>> Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
>>>
>>> Don't use of_match_ptr() unless you are absolutely sure no other firmware
>>> route will make use of the of_match_table.
>>>
>>> In this particular case ACPI using PRP0001 is broken by that macro.  
>>
>> It's not broken because there was no matching via PRP0001 due to missing
>> table.
>>
>>>
>>> So good to set the of_match_table, but make sure to always set it
>>> and hence you don't need the __maybe_unused.  
>>
>> So you want to add PRP0001? We can, the fix is for different issue, though.
> 
> There is nothing to add.  You need to do less than you have done in this patch.
> Drop the of_match_ptr() and the __maybe_unused and PRP0001 based matching will just
> work. The PRP0001 path just uses the of_device_id table and needs no

Sure, but that's *adding a feature*. You said that "ACPI using PRP0001
is broken", but it was never here in the first place. PRP0001 *was*
already broken here, not *is*. The patch does not decrease the
functionality.

> specific support in a driver - it doesn't need an ACPI id table or anything like
> that.
> 
> It's a long story, but hindsight says that of_match_ptr() should never have
> existed as it only serves to stop things working that otherwise work for free.

Sure, I can go with ID table always present.

Best regards,
Krzysztof

