Return-Path: <linux-iio+bounces-11826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242B9B9E67
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 10:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B421F22F47
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945B1684A1;
	Sat,  2 Nov 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN7JLOH3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74251684A3;
	Sat,  2 Nov 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540782; cv=none; b=PP1GnmTXZsNqP3nKZ7DUNEWORDZIZ52xS6y918z8qJ8ZBdUuRRmmneIFG+jHUCVRpVRIwKwH+ACGZMKGGo9Twgr4FJEcOrw0/qb/CHHwISCXOox9d62zxtDP6l0bZ2pvjPOHaw6/UF0ov8snxEOHmecO/CzCedS1Y/S0WARMu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540782; c=relaxed/simple;
	bh=EEpXsLH7FMnOH77EQNDaG9sFaWCGs5J4qvhA6IoQ+gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUfcQQdie4g/Y814BqwtsssIvikoFLGrjjFP4tnXBI8Qwb3Z+vBvYxL8Aik+sPUrGEYNlxTSBBwele8llrINEfzRTMwhWWLzEPverFT5xxkp0PbZnnD8hUZbCRrdztKnqxGEaAjZwVVKs5oipYFD7CxJb2KzMRc2ePpxJL4Hsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN7JLOH3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fe02c386so3353306e87.0;
        Sat, 02 Nov 2024 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730540779; x=1731145579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6h31oGAUdhzBo1I0jU3FfVnne5DJXap7lGCy6/tdAUQ=;
        b=HN7JLOH3bD73eR674wBxV4HVVyNVQ9Bna63SVv/ukML0TzPu3CnDKytRuMmw5OZjdD
         yoH3fug3IU08qt926Y2yHmDaCMS0i82qWMDKzzat1cr4xq9BK7OzXScJ0XB9HvzzC39N
         pB9Z2IytyhOTsaNfCZvlWt/hEqaBByUvT9V4V9f/1tQ47PKG8a4qhgdyIwesqY+myYbO
         N2m7WDdiA1ltS/uGXyA8jw7GkIdyshO2wcyvtjx/ZRjNgYBE7vEZ63r0UqDKQ92zctSE
         UtjRHUWShITogLZvlRsRTrA3w495QZs1yVWSQU1ZoX/hxHo6GAAiipMEwzO5hYIkmc7o
         InkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730540779; x=1731145579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6h31oGAUdhzBo1I0jU3FfVnne5DJXap7lGCy6/tdAUQ=;
        b=MzyM+l61s/PnL5KjDFZ1f8WjRFUE+ikHcPq8ve0IFlVEcsNEXIrR45/p2VL7at8H4W
         Qy6BjIXQtXv8Q4AdLAu7nSL4+JkRqicS09Bxf1LCGEcaAR3d85kFOYrCUAW5FH3D9Hq5
         y/RT1bWgdU+MUEZpaLb9Cecf31xOlLTVDobPo6+lSi3eu7FtX+1bjFq741QhiYh4cOHR
         /RQEOQXIdTkCvG1KZ6D6mQz7OXa/ZrF/0kg6WP50q/53vX9qsN5X2wey6J9DNRS/eVGf
         irE2l00SePgSlANLUdj95EUXeLaScALXdyMSwCefISUcdEVA0JvRGeKb1hXXVbBOO/ZF
         SH0w==
X-Forwarded-Encrypted: i=1; AJvYcCWEc5bGbzYarRkRRekfKkMS5FUSulKRIxLDWWWWXkLnGgQbX6UD2hv/348I6x7Y28EsBYAVasmEFYM=@vger.kernel.org, AJvYcCWRBCbxqOOK86uuMX20graRL45MTXHvS+nwSFyYSkM9+Z94gyC3xZeutR8mBEv6raAyaJt6mAWafJh6Rp5M@vger.kernel.org
X-Gm-Message-State: AOJu0YylnBjOo37ZpL9OFbdQnpNwLZnGvkXfNHtcWrjgzE9zydLKnEb4
	YsvvT/22CTBsK2rFJ8uDxyqPQprXvAV19tIpIsxZCLUfM4MnD59ek3dW5/OS
X-Google-Smtp-Source: AGHT+IHyDFat3XfhzSWUxcywYA3sZfddwzxFakOJXkr6GNompHCyshO7KL2NhMV8bPtY4oCeOMaXcg==
X-Received: by 2002:a05:6512:692:b0:53a:a3:907a with SMTP id 2adb3069b0e04-53c7bbcbd7dmr3447393e87.6.1730540778438;
        Sat, 02 Nov 2024 02:46:18 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdd03f2sm846431e87.232.2024.11.02.02.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 02:46:16 -0700 (PDT)
Message-ID: <d13887a9-a321-4329-82e5-34afd33e0300@gmail.com>
Date: Sat, 2 Nov 2024 11:46:14 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix uninitialized symbol 'ret'
To: Jonathan Cameron <jic23@kernel.org>
Cc: Zicheng Qu <quzicheng@huawei.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
References: <20241031014505.2313035-1-quzicheng@huawei.com>
 <5f80c1a2-118a-4685-ac1b-81b3479f5064@gmail.com>
 <20241031214715.50c4788d@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241031214715.50c4788d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2024 23:47, Jonathan Cameron wrote:
> On Thu, 31 Oct 2024 09:13:16 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Zicheng,
>>
>> Thanks for the patch.
>>
>> On 31/10/2024 03:45, Zicheng Qu wrote:
>>> Initialize the variable ret at the time of declaration to prevent it from
>>> being returned without a defined value. Fixes smatch warning:
>>> drivers/iio/industrialio-gts-helper.c:256 gain_to_scaletables() error:
>>> uninitialized symbol 'ret'.
>>>
>>> Cc: stable@vger.kernel.org # v6.6+
>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
>>> ---
>>>    drivers/iio/industrialio-gts-helper.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>>> index 59d7615c0f56..c5dc5b51693d 100644
>>> --- a/drivers/iio/industrialio-gts-helper.c
>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>> @@ -167,7 +167,7 @@ static int iio_gts_gain_cmp(const void *a, const void *b)
>>>    
>>>    static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>>>    {
>>> -	int ret, i, j, new_idx, time_idx;
>>> +	int i, j, new_idx, time_idx, ret = 0;
>>>    	int *all_gains;
>>>    	size_t gain_bytes;
>>>      
>>
>> So, if I read it right, this handles a (corner) case where there is no
>> times given. I am not sure how well such use has been considered because
>> the point of GTS is helping out with cases where the gain and
>> integration time both impact to scale.
>>
>> How do you see the benefits of the gts if there is no such shared impact
>> to scale? Sure the gts could still provide the 'standard table format'
>> to present the gains (or times), and conversions from the register
>> values to gains (or times), and perhaps the available scale table(s) -
>> but I suppose it also brings a lot of unused code and some
>> initialization overhead. (I have a vague feeling this was discussed with
>> Jonathan during the reviews).
>>
>> Reason I am asking these questions is that I wonder if the usage should
>> be limited to cases where we have both gains and times? We could check
>> this in the iio_gts_sanity_check(). (And, I am actually a bit surprized
>> this check was not implemented).
>>
>> Well, initialization fixes a potential bug here and does not really cost
>> much - so big thanks to you :)
>>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Indeed I'm not convinced this is a a bug that can be hit, but it is
> obviously good hardening so applied to the fixes togreg branch of iio.git.
> Note I'd like a follow up to use __free() + early returns in this function.
> Will reduce complexity and that last line will become a return 0;

I suppose it is time for me to adapt to use the __cleanup based 
helpers... I'll add this to my TODO-list :)

Yours,
	-- Matti

