Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6933969B369
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 20:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjBQTzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 14:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQTzh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 14:55:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C9F5CF38
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 11:55:36 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id l3so2115734ljq.9
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbzURFTMz/Pnj2kNnaUN6eLz+Iv5pF9QTyg7r5dDDQo=;
        b=BUiEPkmlEqNgV5AnYxjS5i8pWl8rtJlht/G9ElWNUHzQG7Ikp7+0/Auk3gJX6QSodM
         Zcd90kBjMh1K3b5/J6nm15+dJT6+54o0kycj1Aq+5qGytcne6aqWLW1uvNlgaPhdestu
         3Ff18AUKxEscPpU1Yr1UFozl3P8TNXlLMKaTmubK7hkshh0sJmwlZki7u6wzNp6Vu+xq
         FZHKh7EqBmsKQ7gOriL+eLoMUyTmYvBOJHTztzZSigUyNa77qUlRorE1UlJef/UbCvMe
         z9gYCCvbYe8AM2+o2xXw20WciN6ITUn+Htc38cOi6yx1NwtpinuumjDqzkbX4GWRy7iW
         kDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbzURFTMz/Pnj2kNnaUN6eLz+Iv5pF9QTyg7r5dDDQo=;
        b=0Ei0X98lV2SfIyXO0dKIUBScQ/7X8fEYlB1WR5sGGsu4VDyqjIvpzoFjS+mN6ZjSTj
         mKaDXOB04ptZA6h/ZDcC80++b/UZJ1y8EBBmWNXnVbfGQ3B3db7h+sxRCjf5TrSZwksI
         l/j2ASYcm/nkDaF7RdmUOiyCHifCIMEBHFDKxiixakGe/ryHLHAtCw4PSBR4bq3KpLRx
         PzHGMYXyrzk7NRRu4dHKBlJvnU0rgo8j/YIbnVh5gGdN1pg0pO+lw85tivvf6OMwWvMX
         kSy7G8wjvBjubyHfxBZKJIexJ1k6RwjrcvmnzgcP8z3mc9/772aq2uJIyuCum84hnN0S
         bETA==
X-Gm-Message-State: AO0yUKVVWNXuSGSWWqHbt7hL5Z5swZZfguGhlIcdxBn164MVsveFIgi8
        loqCZKyQWlaAmeutOoWiyfE=
X-Google-Smtp-Source: AK7set/79FOZ64zUAKE39zsKX8Cl5sHFh44sYF31QdxHxz8gWUVHEvb+mYo/MzHQhAAmvfEzO/mpqQ==
X-Received: by 2002:a2e:3c0f:0:b0:294:6f14:473e with SMTP id j15-20020a2e3c0f000000b002946f14473emr1444193lja.41.1676663735016;
        Fri, 17 Feb 2023 11:55:35 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y7-20020a2eb007000000b00293464d3f74sm692056ljk.76.2023.02.17.11.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 11:55:34 -0800 (PST)
Message-ID: <aba1ea66-b5cc-d43e-b1e6-5d5101da5e9a@gmail.com>
Date:   Fri, 17 Feb 2023 21:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] iio: accel: kionix-kx022a: Get the timestamp from the
 driver's private data in the trigger_handler
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de
References: <cover.1676661174.git.mehdi.djait.k@gmail.com>
 <d81610c45af55b1c5eab5d0597f71650ff908203.1676661174.git.mehdi.djait.k@gmail.com>
 <1a565f66-7e2a-9ec5-441a-d33ef420cfab@gmail.com>
In-Reply-To: <1a565f66-7e2a-9ec5-441a-d33ef420cfab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/17/23 21:52, Matti Vaittinen wrote:
> On 2/17/23 21:19, Mehdi Djait wrote:
>> The trigger_handler gets called from the IRQ thread handler using
>> iio_trigger_poll_chained() which will only call the bottom half of the
>> pollfunc and therefore pf->timestamp will not get set.
>>
>> Use instead the timestamp from the driver's private data which is always
>> set in the IRQ handler.
>>
>> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Oh. I just noticed there is no Fixes tag. It'd be good to have one as it 
usually helps fixes like this being back-ported to stable.

>> ---
>>   drivers/iio/accel/kionix-kx022a.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/kionix-kx022a.c 
>> b/drivers/iio/accel/kionix-kx022a.c
>> index f866859855cd..1c3a72380fb8 100644
>> --- a/drivers/iio/accel/kionix-kx022a.c
>> +++ b/drivers/iio/accel/kionix-kx022a.c
>> @@ -864,7 +864,7 @@ static irqreturn_t kx022a_trigger_handler(int irq, 
>> void *p)
>>       if (ret < 0)
>>           goto err_read;
>> -    iio_push_to_buffers_with_timestamp(idev, data->buffer, 
>> pf->timestamp);
>> +    iio_push_to_buffers_with_timestamp(idev, data->buffer, 
>> data->timestamp);
>>   err_read:
>>       iio_trigger_notify_done(idev->trig);
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

