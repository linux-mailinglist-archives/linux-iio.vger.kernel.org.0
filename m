Return-Path: <linux-iio+bounces-15822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2DA3D168
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 07:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C4E3B7BEB
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 06:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E420E18C322;
	Thu, 20 Feb 2025 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/wKANef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2A8F7D
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033090; cv=none; b=tn68Qf7Ho+lVXsZKqA2ASHuCiSws8vRX8eJCwLkDv3H2zW6MjoGmUPVjQYOF2ftYUO/QhFjcb3zmc0GH/MH6QnvtGnFNz0ep6TKUP6GfIQh1isEbM61aI0RbKFFU+hlVX9GSI0O2Tm3BkdYmEP+4mlfvxR7HpX32vL/Aur4vy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033090; c=relaxed/simple;
	bh=eI9nqXk6bs0plK0bOgUWh8E3ffjnNFJdjIK3yIH5wZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qew96t/+Q+95HmrGSv6NIIp6XZeUrPeR485uTMjg65Ox1MxynDRKOJqL6hqSC9pY80T/0UGCJBd/GskiKR7kvfjjFe6VgV5s287QgQl4y4r6zN9S/jB7sVR+V/ewsE/OtsnfFz2p9hxRlnDiOm3aceSlcooUIg/ZTgRgRc0v0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/wKANef; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54527a7270eso663216e87.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 22:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740033086; x=1740637886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSMyboiE9MCCSqerJ1iQuuVIo6eW/E6lbtQdRYWao74=;
        b=j/wKANefVVvegbwx2xnAF5KnFRuJGxUkGoeVzC3R6NmppmN3p+TJVjupqHjo/5JMNr
         8/X6FT9YW46smzw6G6CCuv7BO21NRJjipvQ54BD3uoqR8iqR1y8Bb1ZKoVq9VCi/EW0Q
         kE0TYALgr4Cx99PZchVsBDufuFFVfkKDbKCgdVucDEaaywpIZSHF9BKcmNU0vWoP8MsC
         hqGP1qvRDYhYdNuechYSkkbl9gz73VojpmWfFPUXfwgEIBmCbfAf/vaZXLOjGkRwta1D
         u5sfLpTIUu4hbV8nC1pOamD9tB1eoiZLVO/ObEwiFN/ltzXiMuym8+Pe7wlnXvai2eoY
         0Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740033086; x=1740637886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSMyboiE9MCCSqerJ1iQuuVIo6eW/E6lbtQdRYWao74=;
        b=vO+fKbXpW4vP72zwpMPevTgQfimjI7da/2QZmQ5Uug8MDicQpbMHW13NmxvvXQHrOF
         girJv9sDJ+LRzHOPPqovhy6/m/ila9pDNAA6QEBpSSkqHmH+e+Zc8QCxS6ZQw8RP2cjV
         4Vfk6poasKj+Nbye00wPvjO9pcTB3rVZgfY4B7SfyvfC89+cBUeJEo9ctZku95aFwtxI
         X3Efsj7EOKM9XGaRXxJrkcaTEFFCoFMGBL8Evk70FwjguTb9eGdFOmGyLn7vE6tMjZfK
         fZbg2PswH2oqtla3SCWEdwyTQprx2ZpCe/VaZTbT4h2S9jDABiQdz+E5imyO6owMAAbf
         CB0A==
X-Forwarded-Encrypted: i=1; AJvYcCWE3YJoMh+rqjRsn3KDqq5/9iX0uBdGWtbijLchiJSMAws9LzzNlI1BdkXQIPq5M7AiN3jZeW84GDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcx8Id+PW+mjpHdyWjYju1a7BT2UN2OLlMjmihKrPyA5jGrkv
	vALOw7kaNQUOfhyosVYi0cESAtG25AurWnjCegdWglI+0t+wlUAN
X-Gm-Gg: ASbGncsjo/Pi8HSHP1oKuScL0VGiv+gB45mIx0vnNqxkGv/yDtY0E4TM7rTKEdtiK92
	QsT1AKMJXhG7iKdxyEe7Ey7SCjSxfry6NhvQHot75wMLspIyrCbso6QsROd6OsKWMAXmET8JWXX
	hDfK8TlU6gilEyZ0BMlfGDjNm8xHIR6eqvEQcVniWAwoomXv1+t2c9H1lcuPdFcRAzfDrb8sk53
	zgp2SSqUOXhq8meYWPeJ/5eUXs6T60D+hK3QNkmSGrtrKy0VEAzuZV+QQuX5p5uq//8kbGhxL36
	L+qqwZiDAi/gLuLdIgrBmcHkcj7/UwpSchbMARIDiMPVuP1iB9SzODjbYxRdHuaYcwWUOMxs
X-Google-Smtp-Source: AGHT+IHJG7J/5oN4qfaP+UqbmLcAL5HSaqgk/wb1WfqtBCljJrY6fExwmvo6lN0ue1UDOb9GNzBi8g==
X-Received: by 2002:a05:6512:1092:b0:545:ece:82da with SMTP id 2adb3069b0e04-5452fe2f226mr7681425e87.4.1740033085707;
        Wed, 19 Feb 2025 22:31:25 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545317a7525sm1656130e87.13.2025.02.19.22.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 22:31:25 -0800 (PST)
Message-ID: <cb5dba6e-79cd-4752-a2fb-6cfa1913e2eb@gmail.com>
Date: Thu, 20 Feb 2025 08:31:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 linux-iio@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
 <20250217140135.896574-6-jic23@kernel.org>
 <0e17116e-6160-4920-83d9-086218245299@gmail.com>
 <85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
 <ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
 <df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
 <ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
 <2ad4ca67-5a70-4b7b-b744-d9bd92ce386a@baylibre.com>
 <20250219190500.01457211@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250219190500.01457211@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2025 21:05, Jonathan Cameron wrote:
> On Wed, 19 Feb 2025 09:25:00 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 2/19/25 6:21 AM, Matti Vaittinen wrote:
>>> On 19/02/2025 12:51, Nuno Sá wrote:
>>>> On Wed, 2025-02-19 at 07:36 +0200, Matti Vaittinen wrote:
>>>>> On 18/02/2025 17:42, David Lechner wrote:
>>>>>> On 2/18/25 1:39 AM, Matti Vaittinen wrote:
>>>>>>> On 17/02/2025 16:01, Jonathan Cameron wrote:
>>>>>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>>>
>>>>>>>> These new functions allow sparse to find failures to release
>>>>>>>> direct mode reducing chances of bugs over the claim_direct_mode()
>>>>>>>> functions that are deprecated.
>>>>>>>>
>>>>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>>>> ---
>>>>>>>>      drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
>>>>>>>>      1 file changed, 6 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
>>>>>>>> b/drivers/iio/accel/kionix-kx022a.c
>>>>>>>> index 727e007c5fc1..07dcf5f0599f 100644
>>>>>>>> --- a/drivers/iio/accel/kionix-kx022a.c
>>>>>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
>>>>>>>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *idev,
>>>>>>>>           * issues if users trust the watermark to be reached within known
>>>>>>>>           * time-limit).
>>>>>>>>           */
>>>>>>>> -    ret = iio_device_claim_direct_mode(idev);
>>>>>>>> -    if (ret)
>>>>>>>> -        return ret;
>>>>>>>> +    if (!iio_device_claim_direct(idev))
>>>>>>>> +        return -EBUSY;
>>>>>>>
>>>>>>> Not really in the scope of this review - but in my opinion the logic of
>>>>>>> this check is terribly counter intuitive. I mean,
>>>>>>>   
>>>>>>>> +    if (iio_device_claim_direct(idev))
>>>>>>>> +        return -EBUSY;
>>>>>>
>>>>>> I'm curious how you read this then. I read this as:
>>>>>>
>>>>>> "If claiming direct mode succeeded, then return an error!"
>>>>>
>>>>> I am used to seeing a pattern where function returning zero indicates a
>>>>> success. I have no statistics but I believe this is true for a vast
>>>>> majority of functions in the kernel. I believe this was the case with
>>>>> the old 'iio_device_claim_direct_mode(idev)' too.
>>>>>   
>>>>
>>>> Fair enough... Note though this is returning a boolean where true makes total
>>>> sense for the "good" case. I do agree it's not super clear just by reading the
>>>> code that the API is supposed to return a boolean.
>>>
>>> Exactly. Just seeing the call in code was not obvious to me. It required finding the prototype to understand what happens.
>>>
>>> Anyways, I guess this discussion is out of the scope of this patch and if no one else sees this important enough to go and change the iio_device_claim_direct() - then I am fine with this patch. So, with a bit of teeth grinding:
>>>
>>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> Yours,
>>>    -- Matti
>>>
>>>    
>>
>> Would a name like iio_device_try_claim_direct_mode() make it more
>> obvious that it returned a bool instead of int?
> 
> FWIW I'd consider this a reasonable change if people in general
> find it more intuitive.  Conveys to those not familiar with the
> fun of IIO that failure is something we kind of expect to happen.

As I replied to David's mail - for me renaming is not likely to make a 
big difference - but maybe it would help someone who is more used to the 
mutex_trylock() and alike. I'd still like to see someone else thinking 
that renaming would help before asking for anyone to go through that hassle.

Yours,
	-- Matti

