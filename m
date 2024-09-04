Return-Path: <linux-iio+bounces-9127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C1C96B658
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 11:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A83B1C24731
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC619DF50;
	Wed,  4 Sep 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP+udyLc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703A189911;
	Wed,  4 Sep 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441601; cv=none; b=ZcxrIDAfHwglSZpJvSVWJWuiT33dlc5EhxDerKrVLitTP6OaLlS1VSm7MRf4SEh1irLrjfpuBsA9HUoVoDhC5nQcGCYMCj/z6uDlZGCfZ4G/L/sLzfPGanS/ps0nYjmzspdMSJHuJ0DlnTcPgGQ6lxBpgJAanfo5oiz1ktkn2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441601; c=relaxed/simple;
	bh=6razxB3XTRNpTtjx5k2asc6Vi4m/sy8jDxjHmpj8T+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iqxywc4tsANj8YEvi275ldzQY04bNtQGrxpOBkS1a1GKK0WQZK0ASUV9Ki+DWRw51082TprBpEPOM6rKiTf2vmLxUWwXLIzv8rLTJGlKLdgHaxllLTvPoCV2jwDWPY8R3o9lffW7MIonx2J0NOB6HFJdRyUzDLeQi+iq0lKKl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP+udyLc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71446767885so808453b3a.1;
        Wed, 04 Sep 2024 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725441600; x=1726046400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxhuHC0JvOevWNQu8AZfhKCuLUtBcUPOpy8EHD7yMss=;
        b=WP+udyLc0+SxFZ0GWLpDzczZW8hXbwWl0ifW6nXFN3nsUTHMkDPC/N9q82X3/mpoHe
         F1MvqGNApa/Ftiq6M4D/RmtiNuWp4sSekp+cZ9F4PHNyCsNrqf0u+G99YoLWjcrIJUsg
         umEs8nwBNm+Ia4PlugGxN/RDByg/g1ltyNOQAwX6OB1BrTg18neXPwgzVnI7/07mAbb/
         6CKyKx7YrHiaeTwQXQmrqDSPP8aN8pJAa8eCyR580pqYiJqateO55D71lQxXIrGensaE
         W56MxOn0WIUP6XNhR/iibj4agVR9j8ztjj4Jp+ZIjns4vkzxakMfkmJ7YERmpdp8Ns5y
         KzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441600; x=1726046400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxhuHC0JvOevWNQu8AZfhKCuLUtBcUPOpy8EHD7yMss=;
        b=b7c7FiRoF9YxVXdrsRPksPKaFoaMJbB6e/qXUF6JGu8YMt+VqbSuazt9zOMoIhTWaK
         s+z5jzt2xAOfd3NTrBBXiBTEvS71UBWqZT7z2PLUOmkv1giBnjc7IC3U4uQbdnxzLFmn
         2xWZkOfighwAJMV5x/hct8PuDpVX+RLud10CzoRpUh6+UaR1h7O9f90d7+zJ/KnuiCcl
         PBBQjnPLgF26639/KiKAbLzTX1gQ514AclcZPzRHRt0c9RD24XiKuJzgI1UEPCgWINdt
         iIuyzLDf20k7GLSz1DbfmTILYoSBX9Pz5rYF9pD3Cb38irOkU5D1qMBIpFD6aiD6sJHe
         ItNw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pfMsqXguh2R+SAQ76+mCxWHrpss+2lNEBpfAtqL9EzA4ngXz0MeDwky/YgZYqdCxb3cW6v6g2hq2PQol@vger.kernel.org, AJvYcCWBXz5tb5ZIm0N1WqgtTpGlIqGLi1ysLGkROCZuh/KyNAZ4S3DGG62zy9fdMj7qny0JDyz0AjQvN8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOy5bj04mQPhRWyIXjtc/k7MNGRKk4ir1GLFt/OOnifex/I7J4
	bKAnLf0CZsmjIJgG7tLz+fZceORgVUf9y2uDR4L+1mqnh9zj8nec
X-Google-Smtp-Source: AGHT+IG5r6LxxwSLcNuPIJYghUjnmKjDnBlTWOs1dfy7rWXAbChhgR1aoLhCrrGTbYXoCyfbbXZqDQ==
X-Received: by 2002:a05:6a00:949f:b0:710:5d11:ec2e with SMTP id d2e1a72fcca58-71730436186mr9661376b3a.0.1725441599555;
        Wed, 04 Sep 2024 02:19:59 -0700 (PDT)
Received: from [100.116.227.126] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785227cfsm1196764b3a.34.2024.09.04.02.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 02:19:58 -0700 (PDT)
Message-ID: <e477448a-6bf9-4ef6-bf53-25a278430f24@gmail.com>
Date: Wed, 4 Sep 2024 17:19:53 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: Use 'CLOCK_BOOTTIME' as the
 default clock source
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, dan.carpenter@linaro.org, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240902103210.31369-1-yasin.lee.x@gmail.com>
 <e2106a4f-ed3a-4b02-b1d2-d54c096fcab8@metafoo.de>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <e2106a4f-ed3a-4b02-b1d2-d54c096fcab8@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/24 18:43, Lars-Peter Clausen wrote:
> On 9/2/24 12:32, Yasin Lee wrote:
>> Override the default (CLOCK_REALTIME) clock source to 'CLOCK_BOOTTIME'.
> Why? Won't this break existing applications that rely on the current 
> default?
>
Dear Lars-Peter,

Thank you very much for your careful review. After careful 
consideration, I agree that changing the clock source from 
CLOCK_REALTIME to CLOCK_BOOTTIME was not the right approach.

This submission is incorrect and will be discarded.

Best regards,
Yasin Lee


>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> ---
>>   drivers/iio/proximity/hx9023s.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iio/proximity/hx9023s.c 
>> b/drivers/iio/proximity/hx9023s.c
>> index 8b9f84400e00..5363357a9a46 100644
>> --- a/drivers/iio/proximity/hx9023s.c
>> +++ b/drivers/iio/proximity/hx9023s.c
>> @@ -1074,6 +1074,10 @@ static int hx9023s_probe(struct i2c_client 
>> *client)
>>                            "iio trigger register failed\n");
>>       }
>>   +    ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "clock boottime set failed\n");
>> +
>>       ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>>                             iio_pollfunc_store_time,
>>                             hx9023s_trigger_handler,
>
>

