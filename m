Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE54C7B5A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 22:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiB1VHV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 16:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiB1VHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 16:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 087B4642A
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646082397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYnovbPtGcgc9E/8oVMTSKgr3ODQnP2MrUjRdl+DpK0=;
        b=DaQrxhFrGf+T9cKOhjDsAkWVxK4/zMgREB5gNq9ORHQgUcnJu1mKE1Lxif0hhAPpGBu0Uj
        /KHE5gvWH19Mm6FUqp887zGOxn6YddQgfEmsHl14miLTVEgPy7rT2d7HJeNNArIfstuZKZ
        ZWnxnDt2acDqv3kfv8gcwzyngjqYW0Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-tP97XL8jNHy6r5Ws7llKUg-1; Mon, 28 Feb 2022 16:06:36 -0500
X-MC-Unique: tP97XL8jNHy6r5Ws7llKUg-1
Received: by mail-qv1-f69.google.com with SMTP id fh12-20020a0562141a0c00b00432f7fe8804so6062548qvb.4
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 13:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LYnovbPtGcgc9E/8oVMTSKgr3ODQnP2MrUjRdl+DpK0=;
        b=S1G46WQHnVD0Cy9tY44hHfDqMxeLxm3SggUzYeEyY1K90eHwsBFwCB94gprZ0jK/DA
         kA134SZRTA+ho/GE69KFdBFZPnGa/CYvG1NY5FtJ+zs4OEM+m3e+crc22L6xjbz6Ip/f
         RNOxs7qKHVksDkfeWB53oJnJnt89OaUnqti0KuF39ZJhn1huX6cKTWatdI496wKv8KVq
         XCFYhr4uzm7/Jq4HwX2A+2sYQTYhed96PtJmgC5aOACDRcl11jaD+I9SDqsyD6EIteiX
         jtDR+I6dzeR805jUJn1poQSxEejKqn8ZDff5hfGWCm6sgEKCKRtru4tTm5dTdctugrTP
         aZCA==
X-Gm-Message-State: AOAM533mrt2esoc29Xki7d1cpDHa7fMWEJsHp20MJDoTWjJLkm3MMjFl
        EWJMZM6OfrUvKMvvDmXisl+Y0WbbjuYhcUPJ4wJ0qVM76nirtalFKgZgwQVScBgOvFOsZodGTcy
        PaHcZPtkfVsdMNOnnx6ui
X-Received: by 2002:a05:6214:2421:b0:432:843f:b437 with SMTP id gy1-20020a056214242100b00432843fb437mr15149193qvb.102.1646082395634;
        Mon, 28 Feb 2022 13:06:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYR48coK6y+4ntjFW3gm3X78BcUfrEpCL4Q9kP1stQ4+ZmgiQnbNc7mm9sQd0BlLKJGiAMPA==
X-Received: by 2002:a05:6214:2421:b0:432:843f:b437 with SMTP id gy1-20020a056214242100b00432843fb437mr15149181qvb.102.1646082395416;
        Mon, 28 Feb 2022 13:06:35 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a152800b00648e52be61bsm5437078qkk.37.2022.02.28.13.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 13:06:35 -0800 (PST)
Subject: Re: [PATCH] iio: scd4x: check return of scd4x_write_and_fetch
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     roan@protonic.nl, lars@metafoo.de, nathan@kernel.org,
        ndesaulniers@google.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220227154331.80338-1-trix@redhat.com>
 <20220227174850.73520e39@jic23-huawei>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b13706f7-4a9e-ba3d-2828-8570c409096c@redhat.com>
Date:   Mon, 28 Feb 2022 13:06:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220227174850.73520e39@jic23-huawei>
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


On 2/27/22 9:48 AM, Jonathan Cameron wrote:
> On Sun, 27 Feb 2022 07:43:31 -0800
> trix@redhat.com wrote:
>
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this problem
>> scd4x.c:474:10: warning: The left operand of '==' is a
>>    garbage value
>>    if (val == 0xff) {
>>        ~~~ ^
>> val is only set from a successful call to scd4x_write_and_fetch()
>> So check it's return.
>>
>> Fixes: 49d22b695cbb ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Good find, but I'd prefer a separate check on ret inline with what the
> other error checking paths in that function are doing.
>
>> ---
>>   drivers/iio/chemical/scd4x.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
>> index 20d4e7584e923..b978330fb761c 100644
>> --- a/drivers/iio/chemical/scd4x.c
>> +++ b/drivers/iio/chemical/scd4x.c
>> @@ -471,7 +471,7 @@ static ssize_t calibration_forced_value_store(struct device *dev,
>>   	ret = scd4x_write_and_fetch(state, CMD_FRC, arg, &val, sizeof(val));
>>   	mutex_unlock(&state->lock);
>>   
>> -	if (val == 0xff) {
>> +	if (!ret && val == 0xff) {
>>   		dev_err(dev, "forced calibration has failed");
>>   		return -EINVAL;
>>   	}
> Prefer
>
> 	if (ret)
> 		return ret;
>
> 	if (val == 0xff) {
> 		dev_err(dev, "...
> 		return -EINVAL;
> 	}

ok and the next line can be simplified to

return len;

Tom

> Thanks,
>
> Jonathan
>

