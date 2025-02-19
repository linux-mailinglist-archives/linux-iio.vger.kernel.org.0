Return-Path: <linux-iio+bounces-15756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F3A3B0F3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 06:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C2C173635
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 05:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E591B0F20;
	Wed, 19 Feb 2025 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvykzmNA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0A1AB51F
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943393; cv=none; b=gGlhM/hCBMmqMkLEHAjAzVYW3maL7w3XMwzehHTtKX3152+ZJZ/2S0t46AMDSvD0PWtrkOZCzZHx3xCXZNGh3AuZiOyjFGHLtJ7g6G8wYlrJ38WlEu/SLoglnZKO6DzjhfalfZchra87s1sOs+gV5xMjEQwCWELaW5JgkEubj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943393; c=relaxed/simple;
	bh=e1hTBGmpaJrR80X1HQFrSY+G2Tp2v+c8wk2MFt8btm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaQxp4vd9ZXs+dVs8kjxi92p4BAGhzAovR3N20qbZwmvabxURjU2R/t4TbNiSPjmhcpDZ3U6S71oiHkwDgdioURWi6zrrsSxhRfO441XREODAAaBOKgcIGQS0v782vlMypAGPDyp2lEV8nqwTI5mf8tk7RoMPFHM/S/9X2Razgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvykzmNA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso3603399e87.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 21:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739943390; x=1740548190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ei/M5O/VN7vosorEG++K/gmAWADL1M1JxOy1RLnBG9E=;
        b=OvykzmNAprkG6S5DNbPei1OHsPaWouB+SMhyXV1DH8Hn4r76z9Qedq+fT+bchrEgIx
         x+V3g1I4sCllsR6bJHjy86uS+WuwIpcXaWiHHX+lXXRJIHiInKhC+G3q9tjoDCRZtz9G
         ugt8W32fO/cSriX9vrpK80eqy/n8ok3UQVL4IeYhNBWvnybRlvfYAqyid2KcFKNeYcKb
         Xq7tVO07bffywh0YXhsgmdj19SEzWRFWN/+mkGXZijDSmGfzrD8AkOGKTGB0dbpocLX4
         eg4Fjg78HuYZDufV2J7KiiglbY6LQHCvP4UxjgUCgElJ1VEfxbqW+zhLR2VXBrPTpXON
         lBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943390; x=1740548190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei/M5O/VN7vosorEG++K/gmAWADL1M1JxOy1RLnBG9E=;
        b=MIkEWL7vz5/00W0Wa6z90dJFYZfTL9FjmuwWSE/Wl9MBolYB8ABAM79wFZCD3h6x/t
         VaYuz4Djjq+plvtftLOLImXMhNsJJPb+jYPQvhdOqPG9ITWBNASIYqUeUKclQxftC2GB
         YJgi0gwcJlCCjHwmKkO1GEDdC7rTO8Grkab8+Y9eZSagSCy5ZAazIe1TpB9JutR40ocK
         UMUypOof6t4nCdHabHZNPcj8dhXIBcbZao6FrTdOKoZ8I2oTymUy6+VqOabSvLz91Vqu
         iuYb6X+5x/myiSxU47kja7hNq78CtvKVaY1k4THphp1LVVmn4EqAVaquLNaDIBgTjJTl
         pOgg==
X-Forwarded-Encrypted: i=1; AJvYcCXqhSWJC3DhbeQ9Vhl4nAx6OU6Cf/amYjg69hxxhOyvTBT9lXLd1FmXcXS63u2ZbfesBWwl9uta77Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqDfqvd3B/wydZPkSK9vAp/qXpoRh0nbcZoQaFvqMUCCvBzuT
	YuMZrdJvZ4FSwXJj51aF/Y56Y9hRC2u657IEGdJMxL7/hZBoskbw
X-Gm-Gg: ASbGnctaVgB0a3SDfqUyZzw3WoXkcZMY3EwSmwOJ8TO3075FRBopHuhzkocNEkGTaqC
	wLgDqmCeHXaLrWSRwIqICJQliQnMD+lanSHkD+qYwUcZ0Zm8WtQyAJ4HpQGZoT6uBxR1uWoBHRa
	HqWY+pYQZyP8I5Hk+EzSPvmSBqpXSEo3jTjYkOXcEzl5Fj0YA8aVkEeRdcKh6xTpxAl0fZFd17P
	0I5l/wytH0B1gFYzjdwtMwv5k3EPGtKt/bIiTXWfJbpa79PQiCD/0QHcqBF94sD+RHEEEe7J2p4
	fVoxvrvhBDEl8MHi1cWxmutX12kW7RWN56W9sK16OohCMKasMCUibbAE91zzaAXNWZ9Weq20
X-Google-Smtp-Source: AGHT+IEFp4vucHe3/A71EVKJL6UH17MwBjSH6heI6zBwiiF+Dk9c3Fr1d01rAq3SirdEVi/tHp6x8g==
X-Received: by 2002:a05:6512:1593:b0:545:cc2:acd7 with SMTP id 2adb3069b0e04-5452fe633d8mr5809891e87.27.1739943389657;
        Tue, 18 Feb 2025 21:36:29 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545ae7f3ae5sm1236383e87.25.2025.02.18.21.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 21:36:27 -0800 (PST)
Message-ID: <ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
Date: Wed, 19 Feb 2025 07:36:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
 <20250217140135.896574-6-jic23@kernel.org>
 <0e17116e-6160-4920-83d9-086218245299@gmail.com>
 <85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/02/2025 17:42, David Lechner wrote:
> On 2/18/25 1:39 AM, Matti Vaittinen wrote:
>> On 17/02/2025 16:01, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> These new functions allow sparse to find failures to release
>>> direct mode reducing chances of bugs over the claim_direct_mode()
>>> functions that are deprecated.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
>>> ---
>>>    drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
>>>    1 file changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
>>> index 727e007c5fc1..07dcf5f0599f 100644
>>> --- a/drivers/iio/accel/kionix-kx022a.c
>>> +++ b/drivers/iio/accel/kionix-kx022a.c
>>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *idev,
>>>         * issues if users trust the watermark to be reached within known
>>>         * time-limit).
>>>         */
>>> -    ret = iio_device_claim_direct_mode(idev);
>>> -    if (ret)
>>> -        return ret;
>>> +    if (!iio_device_claim_direct(idev))
>>> +        return -EBUSY;
>>
>> Not really in the scope of this review - but in my opinion the logic of this check is terribly counter intuitive. I mean,
>>
>>> +    if (iio_device_claim_direct(idev))
>>> +        return -EBUSY;
> 
> I'm curious how you read this then. I read this as:
> 
> "If claiming direct mode succeeded, then return an error!"

I am used to seeing a pattern where function returning zero indicates a 
success. I have no statistics but I believe this is true for a vast 
majority of functions in the kernel. I believe this was the case with 
the old 'iio_device_claim_direct_mode(idev)' too.

I am not saying this is 'absolutely' bad. I can only tell that _I_ 
really had to go and look up the implementation of the 
iio_device_claim_direct() in order to review this change to ensure the 
return value check was not inverted.

Yours,
	-- Matti


