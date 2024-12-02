Return-Path: <linux-iio+bounces-12966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558E49E0BCE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028F4161999
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A91DE3BD;
	Mon,  2 Dec 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo8SSM4y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AB1DA103;
	Mon,  2 Dec 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166899; cv=none; b=ryuRSPMglLcb4+VdtQURuxSdS+l28zz2+UjsVXUAJ86wS+Mu6Gurf4lOP/LFfSCY1eiFAGgAYV+Gz0MI4uzvlUxxB7JGNwygb3Eft5AYIAPj93eB382hGpCwbkHR/zllMPlzVO7/uQwRk1QNyR06upnoPCcLbT7c05gyrv1er3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166899; c=relaxed/simple;
	bh=2sxtv/y68ixCC2yd467bpPVnji8VQd77K8S22YQRQcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffHqqUSQhrnYM+lwNNsoJOiU/nAAlJBFDJBjtoL2HsePvpe1ofcawssv/4Kp12fIZBcNA3GRhDW68qhS2/JD4KJi07jTneAOb7kq3FAytg1XlbUY7R1NseYZT6fST8/Nid2BnDiRHzc1tXvFb4hiUsYsIveY+g2Iw6MYfomxIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo8SSM4y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a95095efso33380045e9.0;
        Mon, 02 Dec 2024 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733166895; x=1733771695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7ZTXIXvVL7lx+KtLs1uQHgMBRSbrXmXN+OqvaN4WK0=;
        b=jo8SSM4yZ5zLGNI4GpgbYdHAQQnHZ1yhTSOwYh6EmsXRslRLhEbEzV9pBtBgmjPwt2
         mIr8O88PZMvLu91IehTBx8yHPwna8khmZp9HrF24rS+uEMaHlvowKDXpfIu/yX2MasJv
         JqWBwX3MZm48kF11dVB6bXSWUwNtij4ny/YXN57Ioz7a9XpYlQXPe4fmAHyOexmBQo/C
         KSSCPn92EH8agsV7rmlxNgp2cl5fGB4v9DGj+WtGb0N1V3Z9HUw/VEm6+c55/+hWSmlo
         Zr5kMDvOkjEKP4CKCFuykO8tguhT65Xivk2loaGCQYoKG5rI52W9SWSbOAhZqylje4ST
         UtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733166895; x=1733771695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7ZTXIXvVL7lx+KtLs1uQHgMBRSbrXmXN+OqvaN4WK0=;
        b=CxlSrZKUlXDiXKpL76k8B7jOFlYanpA8K4CMKSerfPqaS/IdHpLAspXU+mIpu9VuhT
         anRIZ56wnrx2xwHDI+8pm8NrCgy4jwJqM5NmiKD31CMaJeqXJwrPIYi+vbwEheow/evS
         WiYgpaVrxEfrdgdy1lzkHAFIfEforRrXjgXfeZ1Rn5CEtainwk1UNJulUhZv8LaqK/09
         Hq5dcdr6zDKKZs1N/tz6+Jf4+/GBAn9n67cvhQWZA9dbQcvFoFE4bgDBt5pmQ5XPFVyk
         +hvpXLTu/ic4kR2CFfcwLDH7NDAhVcVSydpXUWwJuNhx5PSI/1WMKdZ5RSflAecPiXS2
         dhBw==
X-Forwarded-Encrypted: i=1; AJvYcCUi9G495H0Us4eXtGkoTkqXNGx8dR+/oAw/6Hdqm/jG9RY+ZNu8lnFmJUeyH43yFIi0KcgUJQytK+pWVOU6@vger.kernel.org, AJvYcCUwrHxcuTzsmpgUUv03VP4KLjFJyr8ILR/V3qSXKOnqSxryydHWkyc6szgW1A+RmWsFbnG43K5p@vger.kernel.org, AJvYcCWpJMpmpXyiSX+bgYvBczVh9lqoUDxQMVfgcEQdGFgPp7qPbQQFQSPEjBMOxwG6fv6JBAtMqF2P1nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJHZxRgNKben0dfBRO8UVUiyPohWVvIrCZ84GWg8JNH6iZFDk
	bqwMK8ev56KvpFf58+RAqRRgeSBnVw6BcFHukwcm66LocS+OjXsN
X-Gm-Gg: ASbGncuK1zGRSkTX+ZyRD/t6hhLWSGZpydfLewh8vU4iA/UX+QFo41/fAb1tfNd5N/b
	PAXzhazcQ1Z5LnZdmv7D9xrNrYRfSOfdVYO74107+1F/rAtyZBRWwSxj+5cuqPRaYftZRKF/oj4
	aazpMmIlSjd3vVswD9WlioPFTcJFx8Id5QMU7L1nwzW30C7lho2SRTY4LnPe0utYOFrkZeLGP3W
	XTVwlDTmRLA7oXUYed/b38cZe+iIpGYUj0gPTWYE/UXKNu598/o5uPXous0YvLLgPHqOEHjmkSW
	9W9CAU3bfNfuG8276Q7s9JZM9mnocdkoDhJIS24ogrJKRKL6NP7dvGAO/psA4v19xgYhBQXf3Sw
	huPm4OH73lGY//hsDdHt9u/Kv1DejfTuQI8033BWsaE4=
X-Google-Smtp-Source: AGHT+IF/PTp+oicDfX4BGvsTJRQTihlQjk/D7b6q437NfHoVa3y7GK1LeAWAHScaawXCknIYt1C5Bg==
X-Received: by 2002:a5d:59a8:0:b0:382:4b69:9ca4 with SMTP id ffacd0b85a97d-385cbd89accmr16498545f8f.26.1733166895267;
        Mon, 02 Dec 2024 11:14:55 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:d553:b993:925a:609c? (2a02-8389-41cf-e200-d553-b993-925a-609c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d553:b993:925a:609c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36557sm13249601f8f.24.2024.12.02.11.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 11:14:54 -0800 (PST)
Message-ID: <cce23b3b-aff6-4d3b-a55e-d0ce67a6a650@gmail.com>
Date: Mon, 2 Dec 2024 20:14:53 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] iio: light: as73211: fix information leak in
 triggered buffer
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
 <20241130204923.45d71fa4@jic23-huawei>
 <9e1310d8-bcd9-40f9-8d44-abddc595ae9b@gmail.com>
 <7089293.9J7NaK4W3v@n9w6sw14>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <7089293.9J7NaK4W3v@n9w6sw14>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 19:00, Christian Eggers wrote:
> Hi Jonathan, hi Javier,
> 
> On Monday, 2 December 2024, 16:38:50 CET, Javier Carrasco wrote:
>> On 30/11/2024 21:49, Jonathan Cameron wrote:
>>> On Mon, 25 Nov 2024 22:16:18 +0100
>>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>>>
>>>> The 'scan' local struct is used to push data to userspace from a
>>>> triggered buffer, but it leaves the first channel uninitialized if
>>>> AS73211_SCAN_MASK_ALL is not set. That is used to optimize color channel
>>>> readings.
>>>>
>>>> Set the temperature channel to zero if only color channels are
>>>> relevant to avoid pushing uninitialized information to userspace.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 403e5586b52e ("iio: light: as73211: New driver")
>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> Huh.
>>>
>>> If the temperature channel is turned off the data should shift. So should be read
>>> into scan.chan[0] and [1] and [2], but not [3].
>>>
>>> Not skipping [0] as here.
>>>
>>> So this code path currently doesn't work as far as I can tell.
> 
> I've just tested and you are right! In our application we never had the case that
> we didn't read the temperature channel. If I don't enable scan_elements/in_temp_en,
> I need to put the data into scan.chan[0..2] in order to get correct values in my
> application. This also means that the "Optimization for reading only color channel"
> (and the following saturation block) isn't correct at all, especially if reading only
> one or two of the available channels.
> 
>>>
>>> Jonathan
>>>
>>>> ---
>>>>  drivers/iio/light/as73211.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
>>>> index be0068081ebb..99679b686146 100644
>>>> --- a/drivers/iio/light/as73211.c
>>>> +++ b/drivers/iio/light/as73211.c
>>>> @@ -675,6 +675,9 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>>>>  				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
>>>>  		if (ret < 0)
>>>>  			goto done;
>>>> +
>>>> +		/* Avoid leaking uninitialized data */
>>>> +		scan.chan[0] = 0;
>>>>  	}
>>>>  
>>>>  	if (data_result) {
>>>>
>>>
>>
>> Adding the driver maintainer (should have been added from the beginning)
>> to the conversation.
>>
>> @Christian, could you please confirm this?
>>
>> Apparently, the optimization to read the color channels without
>> temperature is not right. I don't have access to the AS7331 at the
>> moment, but I remember that you could test my patches on your hardware
>> with an AS73211, so maybe you can confirm whether wrong data is
>> delivered or not in that case.
> 
> Yes, the delivered data is wrong (as already stated above).
> 
> @Javier: If you like to rework this, I can test your patches (I have still
> access to the hardware).  Otherwise I can also try to fix this on my own.
> 
>>
>> Thanks and best regards,
>> Javier Carrasco
> 
> Thanks for reporting this!
> Christian
>>
>>
>

Thanks for your prompt reply. I will rework it for v2, as the current
patch does not apply. For this path, scan.chan[0]..scan.chan[2] will be
read from the sensor, and scan.chan[3] will be set to zero.

Best regards,
Javier Carrasco


