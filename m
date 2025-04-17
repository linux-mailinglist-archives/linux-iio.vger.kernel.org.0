Return-Path: <linux-iio+bounces-18183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B9A912F3
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 07:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7370F1888692
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD701F237B;
	Thu, 17 Apr 2025 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5D8VjIv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0B1E5216;
	Thu, 17 Apr 2025 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868607; cv=none; b=aNAt5+CbeoF5j1Q/3Ok3Wqt4InkZSItVYmSZxK1Gv8odLkZJFIcVdZVpi/UZp7Fo/FVq88RWPcgdGOK//AU+m5JGgZeBOKQ4uiHHR5T8uplMEBJPJTfkgdBIdMR2TvStmfq/Sgr76ve8fKYy1AAjtuI3ePp7SaUNAjW2EJ7uAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868607; c=relaxed/simple;
	bh=FMIpPYafwfnkDabtlrEmI7ulS7B4pPOqair5B9WAoBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3JdZUrt+ND6v/aBYlUMMfrCmdNRRu40huacE1FNDY2jcW+SvMYrzwyWZFkb/eYcGx/qx/8xYD5JKww7722rRYNyV6tQAqLnAfZ4fzmkUdegJwDRuwhouzC8X84qtEd9X02fIFsoYHZopzOrEUDBwBmh3YTjoPHVxObTosKzlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5D8VjIv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so260015a12.3;
        Wed, 16 Apr 2025 22:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744868605; x=1745473405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g+SVkavFRSacmyVfOEHphPFAH3/AYZFW+0PJY+HSIA=;
        b=b5D8VjIvGC5XDDKEvWy2z+f+K+PiH6K0OaCzgE2OtlHUnjqojXu4z+VTkCkMAsdzEn
         TaGkSMrEK6tN2WKRA55m8tomOZuyQr7pAq9JgYI0BGpM4cGfXsXieIOFNsAzT5AZkMqI
         qZFU6twUA5BmDJ6Lq2hnakI74p/Tq3EtZj89yhMJdcvAHBw/PGpnwY3I+weXA6ArBJj9
         NdIGHrqB5Z/OUNIt5wR06Z1UjOziJVIBKWuLFMvEn92y65dLPYl2bUBSRcw94pXQXYOn
         sA2qCyWx8PM5LJPZ1t6Ueu04wXYKzHYIWTu6aDB3U3IAQp/yruPbu+NSY4fSE/lkkset
         mcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868605; x=1745473405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9g+SVkavFRSacmyVfOEHphPFAH3/AYZFW+0PJY+HSIA=;
        b=IDOzg0BCIrsOurJAF7TesLHB41CEjv+w3YUj1BgFyestH6lgVhXOfcdaKXykONDYSB
         umKB6fjZngXDSXV2mmOduSy8+jhv02NYUuRN4mUV1wKwLWwGBsR6U2CbHS+63V6L8tIx
         awYMaYeMQrRPDxpdVft6MGVYBTsTk1FP/6MNYjRK0JGpzwgrN6MeKSbr8yo6z4T4HUWV
         4M01LDVeFJs5enWXkNHBtwDHVzvNjZWh1bnU9sIviowewU4guGJXoCGzyVGgXn7RXq0G
         gMSyarze0eTJ2Za9qimCX1KqGi1y0RiNMXlthgSSrb0Kq7s+jhwWAEiUjdAQlUiU76J2
         fZqg==
X-Forwarded-Encrypted: i=1; AJvYcCUioEPMq8KfIgtVA7mltYZcSa+48L5Y9wOCN1Q4TdzWZArUhoNq4p9tI7ubwc7TSj7TgQ13iSj5ahzSMVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZlmlW9YhR3mxrfWwVc9tgbcGFjbhFP0BUpbDhFNWmfB4nBr4
	rXnlRARi+yGwIsiryuB5vFiwYchTIrX7fsl1Lg9PtlPhLBtjhWp4
X-Gm-Gg: ASbGncuagXxyEL3NPYHwuAHdgPgoPA56qLgtV98aUSpQGZfdsEh1bDFHuhNAVOzeAFR
	Vr0pC7nld9y5X48x3xE1AjgrKPkylepKTEuR0uY92C0pZqdetrN9Kik8BKuNO12hx/D7d2swZqk
	fExh82Rk+SJUoMHgURT0tmPG/3u57vqaRD8EiTf78FqNeUZDIWU78w9soOsk6xfO9b9Cbh9obEF
	qUW+Ru45TVOFV8IWvLphBnZ3MmmEnIHRz1ugyxUwS5uUwYpgJfSC7nNlbacoWVKiyxI63dCvE3X
	UML86HXLylFkTv2aP28nw54O9Mm7mm/4pT2oM9+1FZmuZtAv+g==
X-Google-Smtp-Source: AGHT+IGDFwjAU8gK8vB7c4HiWkRT1h+o4JFppXo1da2T6aikyD9BsPygXAqD6QGn+Ck9y4Ccqmemnw==
X-Received: by 2002:a17:90b:5683:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-30863f303f7mr6544849a91.21.1744868604686;
        Wed, 16 Apr 2025 22:43:24 -0700 (PDT)
Received: from [192.168.0.161] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861212c3esm2698249a91.25.2025.04.16.22.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 22:43:24 -0700 (PDT)
Message-ID: <383030aa-2312-4f11-ba80-c8dd54fc9010@gmail.com>
Date: Thu, 17 Apr 2025 11:13:19 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: addac: ad74115: Fix use of uninitialized variable
 rate
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 David Lechner <dlechner@baylibre.com>, cosmin.tanislav@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409202945.205088-1-purvayeshi550@gmail.com>
 <1254dfd7-e872-4c65-bd17-8015e1b2eba4@baylibre.com>
 <10a9dd5cdf55b6a9845fb9543cdef5f2251ffa6a.camel@gmail.com>
 <f5f40475-fae5-487f-b5ce-dc6c5dfe3600@gmail.com>
 <5cb7ab70be67f8b97b5fd09eefab0f2c33d99d20.camel@gmail.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <5cb7ab70be67f8b97b5fd09eefab0f2c33d99d20.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/25 17:47, Nuno Sá wrote:
> On Fri, 2025-04-11 at 14:39 +0530, Purva Yeshi wrote:
>> On 11/04/25 11:19, Nuno Sá wrote:
>>> On Thu, 2025-04-10 at 09:51 -0500, David Lechner wrote:
>>>> On 4/9/25 3:29 PM, Purva Yeshi wrote:
>>>>> Fix Smatch-detected error:
>>>>> drivers/iio/addac/ad74115.c:823 _ad74115_get_adc_code() error:
>>>>> uninitialized symbol 'rate'.
>>>>>
>>>>> The variable rate was declared but not given any value before being used
>>>>> in a division. If the code reached that point without setting rate, it
>>>>> would cause unpredictable behavior.
>>>>>
>>>>> Declare and initialize 'rate' to zero inside the 'else' block where it
>>>>> is
>>>>> used. This ensures 'rate' is always initialized before being passed to
>>>>> DIV_ROUND_CLOSEST.
>>>>>
>>>>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>>>>> ---
>>>>>    drivers/iio/addac/ad74115.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
>>>>> index a7e480f2472d..26770c68e5fa 100644
>>>>> --- a/drivers/iio/addac/ad74115.c
>>>>> +++ b/drivers/iio/addac/ad74115.c
>>>>> @@ -814,7 +814,7 @@ static int _ad74115_get_adc_code(struct
>>>>> ad74115_state *st,
>>>>>    			return -ETIMEDOUT;
>>>>>    	} else {
>>>>>    		unsigned int regval, wait_time;
>>>>> -		int rate;
>>>>> +		int rate = 0;
>>>>>    
>>>>>    		ret = ad74115_get_adc_rate(st, channel, &rate);
>>>>>    		if (ret < 0)
>>>>
>>>> I don't see how rate could be used uninitialized since we are
>>>> returning the error if ad74115_get_adc_rate() fails.
>>>>
>>>> Also, initializing to 0 would then cause a divide by 0 error
>>>> if that value was actually used later in the code.
>>>>
>>>
>>> Agreed... A better check could actually be (in ad74115_get_adc_rate()):
>>>
>>>
>>> if (i >= ARRAY_SIZE(ad74115_get_adc_rate))
>>>       return -EIO;
>>>
>>> Kind of a paranoid check but just making sure a faulty chip does not lead to
>>> an out
>>> of bounds access.
>>>
>>> - Nuno Sá
>>
>> Hi Nuno,
>>
>> Thank you for your suggestion regarding the paranoid check.
>>
>> However, ad74115_get_adc_rate is a function, not an array, pointer, or
>> vector. Therefore, using ARRAY_SIZE on it results in a compilation error.
>>
>> I believe the intended check was:
>>
>> if (i >= ARRAY_SIZE(ad74115_adc_conv_rate_tbl))
>>       return -EIO;
>>
> 
> Oh yes, bad copy-paste...
> 
>>
>> This ensures that the index i does not exceed the bounds of the
>> ad74115_adc_conv_rate_tbl array, preventing potential out-of-bounds access.
>>
>> This check prevents potential out-of-bounds access, it does not address
>> the Smatch warning about the uninitialized variable 'rate'. Smatch may
>> still flag 'rate' as potentially uninitialized if it cannot determine
>> that ad74115_get_adc_rate() always initializes it before use.
>>
> 
> Well, as said, this is a false positive...
> 
> - Nuno Sá
> 

Hi Nuno,

Thank you for the review. I'll drop the patch.

Best regards,
Purva


