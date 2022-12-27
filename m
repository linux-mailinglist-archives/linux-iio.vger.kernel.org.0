Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC8656870
	for <lists+linux-iio@lfdr.de>; Tue, 27 Dec 2022 09:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiL0IaO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Dec 2022 03:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiL0IaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Dec 2022 03:30:13 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F522AC9
        for <linux-iio@vger.kernel.org>; Tue, 27 Dec 2022 00:30:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so18724225lfb.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Dec 2022 00:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qDAQFGFKisCDF6gxJMaF1fpqHenJ8t2xj5flIPrPV8=;
        b=J/oLnUBKPORky9QR2+9UjdVLkTDmQ7gt5vcdZZYZ4MujY0PpnhDXXkMxEllfYOKPy5
         6n87+xRgu94h0Z6Kj3zyA/L5AcSjwEk09UoZpKjx3pk3q1AUmklA/ZX8PiA90Rld6rvO
         IqLKXGq8NVmFEaLy3N1n4mnEgF6EpKCRYQNn1gRGcU3R+rdkcDSBzWrxn9ONKsBm7Xso
         LqOAk8WZ878GiHJjbab66QQSvBq+FZ2yh1hDMXqm+/pstNGek2Rg3DZhGb6d86DPEcQz
         Nl0g/vmCEVqyetOWR+J2fqvdjeSltvdnI6ihfKAo0u710SGnGaACuplolmbcJ3iz8XCG
         jRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qDAQFGFKisCDF6gxJMaF1fpqHenJ8t2xj5flIPrPV8=;
        b=EP8gazNjK4CgSpKE4WC79O6aqcZ0mqbuiQO28c9DORPppQz9v9jryplr2XUk8532+w
         /Nqv/U4cV7rnLGOVOFePJ1vrQDR+EWiwqFyGLeKwAvBvR7DNLQ/FqkXKuuEc+nzFyhTC
         LROqg2N/dcRM59Rh7cgvrha4Uj2aPdXfTL4sKz54N87bDW2MIHl5lgugThWb6rUHEaJi
         q+JSKvWFC4UZ3OJxMdOA0N70uVL1FhO75cAlPu/AeXKlHbLSu40EEzHniOV/Q1A2S4RH
         73ST0mNl0oAJ7NRSMMtBNm8lXTsU+jgbiM6kpj1ofherOZd958j7eAfq2vG/8jsO+YIg
         a0Bg==
X-Gm-Message-State: AFqh2kqOeMp3qEpUkFMfDVDRAR0qaumksyW1G3RObaW24+D0jnFdXMSj
        rMO+QOQ6EiThUqHrZeb0Van1nUXVuFs08bCr
X-Google-Smtp-Source: AMrXdXuCtARxFHfdCJkSF28ohFPykZlxzj97ttM9yIKHfWB0NDKv3WBwjJf5X5JbHx6Y+0Py5vmSKA==
X-Received: by 2002:ac2:563a:0:b0:4cb:cfd:98c6 with SMTP id b26-20020ac2563a000000b004cb0cfd98c6mr726076lff.36.1672129810513;
        Tue, 27 Dec 2022 00:30:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b57a810e09sm2169880lfs.288.2022.12.27.00.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 00:30:10 -0800 (PST)
Message-ID: <34b6b5b3-079d-3f6b-b55a-6d05a775e3b8@linaro.org>
Date:   Tue, 27 Dec 2022 09:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/4] iio: temperature: tmp117: add TI TMP116 support
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
 <20221221092801.1977499-4-m.felsch@pengutronix.de>
 <20221223151056.4f7d4b7e@jic23-huawei>
 <20221223150728.34d5agqr4ruixjbu@pengutronix.de>
 <20221223153929.3fbad6b2@jic23-huawei>
 <20221223161359.wla6l5kd5gddloid@pengutronix.de>
 <20221223171647.43a6153e@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221223171647.43a6153e@jic23-huawei>
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

On 23/12/2022 18:16, Jonathan Cameron wrote:
> On Fri, 23 Dec 2022 17:13:59 +0100
> Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
>> On 22-12-23, Jonathan Cameron wrote:
>>
>> ...
>>
>>>>>> @@ -118,27 +127,28 @@ static int tmp117_identify(struct i2c_client *client)
>>>>>>  	int dev_id;
>>>>>>  
>>>>>>  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
>>>>>> -	if (dev_id < 0)    
>>>>>
>>>>> Keep this handling of the smbus read returning an error.
>>>>> Otherwise, you end up replacing the error code with -ENODEV rather than
>>>>> returning what actually happened.
>>>>>
>>>>> 	if (dev_id < 0)
>>>>> 		return dev_id;    
>>>>
>>>> You're right, I will change this thanks.
>>>>   
>>>>> 	switch (dev_id) {
>>>>> ...
>>>>>     
>>>>>> +	switch (dev_id) {
>>>>>> +	case TMP116_DEVICE_ID:
>>>>>> +	case TMP117_DEVICE_ID:
>>>>>>  		return dev_id;
>>>>>> -	if (dev_id != TMP117_DEVICE_ID) {
>>>>>> -		dev_err(&client->dev, "TMP117 not found\n");
>>>>>> +	default:
>>>>>> +		dev_err(&client->dev, "TMP116/117 not found\n");
>>>>>>  		return -ENODEV;  
>>>
>>> As per the other branch of this thread.  This isn't an error.
>>> If we want fallback compatibles to work in their role of allowing
>>> for newer devices that are actually compatible, the most we should
>>> do here is warn.
>>>
>>> Say a new tmp117b device is released. It's fully backwards compatible
>>> with the exception of an ID - or supports only new features + backwards
>>> compatibility then that would have a fallback to tmp117 and we need
>>> it to work.  
>>
>> This isn't part of this patchset and IMHO implementing something which
>> may happen in the future is not the way we should go.
> 
> I held a similar view, but the response I got from the DT maintainers was
> that a driver should not reject a DTS that says it is compatible based
> on an unknown ID - because it prevents that case of an old kernel working
> absolutely fine with a completely compatible newer part.

I don't think that there was such generic recommendation. Accepting
unknown devices (unknown register IDs) is a risk - device might behave
correct or not. If it is a critical device, like regulator, misbehave
might damage something.

What's more, how Linux driver behaves on device IDs (not compatibles) is
also a bit outside of DT scope.

If a driver claims it handles compatibles tmp117, then indeed it should
work fine with any DTS node claiming to be compatible with tmp117.
However driver is free to make further checks (if possible) whether the
device (e.g. tmp116 or tmp11X) is really compatible and reject unknown
devices for safety reason.

The same as x86 kernel is fine to reject to work on newest (unknown) x86
processors for safety reasons... which is terrible from user-experience
point of view unless it is real safety case.

Best regards,
Krzysztof

