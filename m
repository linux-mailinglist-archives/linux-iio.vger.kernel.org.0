Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0654669BB5B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBRSIO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 13:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRSIO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 13:08:14 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2649CA3E
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 10:08:12 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v11so1751787lft.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl9tgPPYFxrQpmprB+vgYGTiu41VNXm5piFVf6wb47E=;
        b=WQIk2T2ASEegCfrMr6AYhJMRoUOqOIoHz2AIXOu9njP/hkmb2fMHmQ4MyfTl3XrWGI
         NF0kw7KIoT/dYvc0P/GhVfEaDp4PW828scufUilBFNK00kCpX8jVJiiJfCOKhqCRvxef
         SoAcZBHCvuzSldrH9iJqM7IsOPLan26GD+GzJo8aXH5XIxCZ8OjHgOxP3mRmtS4DI5hc
         2GzZVVV8QSssa8k1fXiAvwxMIFP1bQCIFhtzR/3vGCxi9SwL8ngoappro6rais5vTxOY
         SuPAlILmExnDc3/B4w6WnVRjsM+GqHINH4p2Vfve6KQzcCN7kGqHIOdDFF9/DFm7AMzl
         +OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl9tgPPYFxrQpmprB+vgYGTiu41VNXm5piFVf6wb47E=;
        b=ZJ0nff9SiqcIYFAfS4sERkCQGAvAqcx36URRagOx/h8JpItTQ0WsH0u038N1TRFTtD
         1pnHguQR230X9g5jpI6OZVcLFWdy8jxchG7YQe3IAusO9yJdg/uIQ73w4R6DH9NLp02o
         iBk4+hraHIN/9hjZjhOkHbrvjzBeyAa3Au8254S31grW+Xou/SotOXl8PVxLBp3AQspz
         7uIch8S4DEBDlsQfQ7dQMm1T9lXn2I8efZRtA0hAw8nxHmHwKYbq+w/P++hDmMWFTc9Y
         QM/TSIkVth0rDXGnYrMNnxmCSSMTQ+flIXsGe40xTTIjIR97M4s0j2LpfxOFVmqUJw/i
         BotQ==
X-Gm-Message-State: AO0yUKVVwYFIv1FRDnnW/jzOGsVYandchp7vM7vvSdvbH4rId6LU3aMO
        I2iNEVZdr2TLQZyBvhQ37Tw=
X-Google-Smtp-Source: AK7set8PFXMUlY5yaJGiYTP6VzsnBn6j84DQBUNlft3Xf61HPny3XweVt/wXeCJsXnJsHRudF2Ge4g==
X-Received: by 2002:ac2:4a74:0:b0:4d0:90f0:f81f with SMTP id q20-20020ac24a74000000b004d090f0f81fmr1477369lfp.31.1676743691064;
        Sat, 18 Feb 2023 10:08:11 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s9-20020ac25fe9000000b004db4ec844c2sm1026926lfg.254.2023.02.18.10.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 10:08:10 -0800 (PST)
Message-ID: <18a6709b-4d26-2672-b056-669750b4828c@gmail.com>
Date:   Sat, 18 Feb 2023 20:08:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
 <20230130130231.000013b6@Huawei.com>
 <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
 <20230202165714.0a1c37ac@jic23-huawei>
 <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
 <20230218172052.12c44aa5@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: ROHM ALS, integration time
In-Reply-To: <20230218172052.12c44aa5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks a lot Jonathan,

You have been super helpful :) Thanks!

On 2/18/23 19:20, Jonathan Cameron wrote:
>>>> such it can't compensate the scale change.
>>
>> Regarding the scale:
>>
>> When scale is changed by user, the driver attempts to maintain
>> integration time and perform only the gain change. If requested scale
>> can not be supported by any available gain using the current integration
>> time, then the driver attempts to change both the gain and integration
>> time to achieve requested scale. (If this also fails, then an error is
>> returned).
>>
>> I guess this is what is expected to happen in "normal mode".
> 
> Interesting. I was actually thinking prefer to change integration time
> but your way may make more sense.
> 
>>
>> As I mentioned earlier, this does not allow a great control over the
>> integration time for users who (may?) wish to have shorter time with
>> gain bigger than 1x.
>>
>> Hence the writeable integration time.
>> Now, an user may request different integration time by writing the
>> integration time. I assumed this is also normal operation assuming this
>> does not cause a scale change?
> 
> If magic mode write hasn't happened, then integration time should reject
> writes. Interface is too complex otherwise because if a user writes the
> integration time then the scale, they'll expect that their integration
> time has not changed.

I agree that changing the integration time set by the user could be 
unexpected. OTOH, if we take the approach I explained above (Eg. try 
keeping integration time intact when scale is changed and only change 
int-time if gain alone can't provide requested scale), then the 
integration time would not change is user asks for scale we can support 
with the set integration time.

There is few bumps on the road though... I am not exactly sure how to 
decide available scales to advertise. Nor am I sure how to deal with the 
scale settings when requested scale can't be met with gain change alone 
but where scale is also not at the one of the extreme ends (which could 
clearly warrant the integration time change) - but is somewhere in the 
mid-range. This can happen because the supported gains have "jumps". 1x 
to 4x (skipping 2x), to 16x (skipping 8x) to 32, 64, and then to 256 
(skip 128), 512, 1024, 2048 and 4096.

Integration times are 50, 100, 200, 400 - which means that some of the 
'mid range' scales can be only supported by some integration times.

I will try to cook an RFC next week to show what I have drafted if there 
is no big surprizes on the road..

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

