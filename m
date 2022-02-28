Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E4D4C6DCE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 14:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiB1NTi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 08:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbiB1NTh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 08:19:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DEAD22529
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 05:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646054336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3S17ktpShuLkpMCDawhKpZmIUnAd7X+YczocvP8k9U=;
        b=D6XJiKcQR2vQVfW9qmiip9hSyuFO4BInJIzfhMmfAtl9hkK+FbKV0nqvOT6y386yIlxw1h
        /F1sK60ktUeUae4Xzhmiceh1Wl1JksVXwBcBIhr+qxbprq+MnbZtbdr5J0Uy0rXtwxJoXO
        HuYEzUYZw6G/gomw8xPpwiK9wYeBik4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-potyN4cmM4mxZyYobkJPFg-1; Mon, 28 Feb 2022 08:18:55 -0500
X-MC-Unique: potyN4cmM4mxZyYobkJPFg-1
Received: by mail-qk1-f200.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so10855848qkb.23
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 05:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V3S17ktpShuLkpMCDawhKpZmIUnAd7X+YczocvP8k9U=;
        b=hK5F1gCTT0cSg+wnotw0TtD0ITE+7aqX2CpM7zHG0AdvVovaANP1i/ErF5dFUNCwNS
         k003qETpeu9djBVEMF1nraCXXqg7GyHBGXlBWFi43a6E1bWmkgx+wRcNvHT8dgf5P3cg
         ok3i82Ffp2rMyUc1Ybh9MvlQ117Q3QEZ/XWcA2/+6+sS9/BxD2F2ZQzVnkRGSNBFcDU+
         QxrDEA+fWhinfnupOIfl1Z5cAuZfHODGXgqJUQPckzB6pOaZ0beALwrsSUctKVotDwgI
         cXEcqitItrtfGElKHR5PZxV+RTjmH7I+RCRBbNQKHItR8UMv20DwCmSzoPYWsLU/s3Ie
         MaOg==
X-Gm-Message-State: AOAM533Q8DoCtldzfcD2vCYOkFTqwAK3PiDZV1uFIJl/9B2mnDkdM2PR
        0eaPKTTQFM6Eruat15fFqmJ9AjeABJWvdP5r56PcCt6g5NCQyT3nXqWswLiOFL4tBqahEkSTwLU
        TW0SiBWsUhO9iU4tyyYoF
X-Received: by 2002:a37:a514:0:b0:5f1:8c59:ea45 with SMTP id o20-20020a37a514000000b005f18c59ea45mr10813967qke.169.1646054334681;
        Mon, 28 Feb 2022 05:18:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGeFcU+I1XCZpbdq3sBwWpimaNVMlZLAq4Jix+zHUTpG3vRZyRyR8N2XAlTQiq4xGgw1qpVg==
X-Received: by 2002:a37:a514:0:b0:5f1:8c59:ea45 with SMTP id o20-20020a37a514000000b005f18c59ea45mr10813955qke.169.1646054334442;
        Mon, 28 Feb 2022 05:18:54 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a15d800b00648a9cf86e7sm4951492qkm.33.2022.02.28.05.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 05:18:54 -0800 (PST)
Subject: Re: [PATCH] counter: add defaults to switch-statements
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220227161746.82776-1-trix@redhat.com>
 <20220227174610.0e0e73e4@jic23-huawei> <YhzIFofXbnbFe9N6@ishi>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fc462e60-9a33-39a4-a0be-b6331923be74@redhat.com>
Date:   Mon, 28 Feb 2022 05:18:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YhzIFofXbnbFe9N6@ishi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 2/28/22 5:03 AM, William Breathitt Gray wrote:
> On Sun, Feb 27, 2022 at 05:46:10PM +0000, Jonathan Cameron wrote:
>> On Sun, 27 Feb 2022 08:17:46 -0800
>> trix@redhat.com wrote:
>>
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> Clang static analysis reports this representative problem
>>> counter-chrdev.c:482:3: warning: Undefined or garbage value
>>>    returned to caller
>>>    return ret;
>>>    ^~~~~~~~~~
>>>
>>> counter_get_data() has a multilevel switches, some without
>>> defaults, so ret is sometimes not set.
>>> Add returning -EINVAL similar to other defaults.
>>>
>>> Fixes: b6c50affda59 ("counter: Add character device interface")
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>> I'm fairly sure this one is warning supression rather than a fix as
>> that type u8 being used in the switch is storing an enum which is
>> set only by kernel code and all values of the enum are covered.
>>
>> However, that's not locally visible so to me the addition looks good, I'd
>> just be tempted to drop the fixes tag as backporting this looks like noise
>> to me.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Yes, this isn't really a bug because the only values available are those
> from the enum, but I see how this is not immediately obvious at first.
> If Tom has no objections, I'll pick this up and drop the fixes tag so
> that we have it along with the other counter changes for the 5.18 merge.

Sounds good.

Thanks,

Tom

> Thanks,
>
> William Breathitt Gray
>
>>> ---
>>>   drivers/counter/counter-chrdev.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
>>> index b7c62f957a6a8..69d340be9c93f 100644
>>> --- a/drivers/counter/counter-chrdev.c
>>> +++ b/drivers/counter/counter-chrdev.c
>>> @@ -477,6 +477,8 @@ static int counter_get_data(struct counter_device *const counter,
>>>   		case COUNTER_SCOPE_COUNT:
>>>   			ret = comp->count_u8_read(counter, parent, &value_u8);
>>>   			break;
>>> +		default:
>>> +			return -EINVAL;
>>>   		}
>>>   		*value = value_u8;
>>>   		return ret;
>>> @@ -496,6 +498,8 @@ static int counter_get_data(struct counter_device *const counter,
>>>   		case COUNTER_SCOPE_COUNT:
>>>   			ret = comp->count_u32_read(counter, parent, &value_u32);
>>>   			break;
>>> +		default:
>>> +			return -EINVAL;
>>>   		}
>>>   		*value = value_u32;
>>>   		return ret;

