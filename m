Return-Path: <linux-iio+bounces-12575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C909D754A
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 16:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F26287DF2
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A612199935;
	Sun, 24 Nov 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGk+loWL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE2186294;
	Sun, 24 Nov 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732459651; cv=none; b=sfe/DVWjPDiv4rPo1pRYfG6uWdAcmKLL8GuIqJ20kLv9ejE0MBtbPjDhFuYIIhiEAY4azcFIDOlDK/RPwNV+G5Q97VUMUJ6XMiGlcDJC1Z5Gl8VcE8qNT4sX8exoCuHHZlH3cuD0ODdxXyazV4588po5jymeyzz4KOLuHkPa6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732459651; c=relaxed/simple;
	bh=V1AvI9on0FzgsUYbOrwaAgbiZs3KJlIYiknDJ7ns9ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gz6tcEvEaT8Ol55l5ReXCe34A5cJn+7jbwEXzxJYzxZAjGONDFVomVTNDur05Ay+fsxG9pdQ0yO/Re4BYhj/8ModSIvwiZX2eLR9EDopzshe4x9oETvfQR25pdRj7M4ba/XoDi6e1VMytYtH1CvKD+ZPpVFax4z3y5kP1yM6d9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGk+loWL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so32518385e9.2;
        Sun, 24 Nov 2024 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732459646; x=1733064446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9XViuJchf6uzl31NN9iMaATFPypoFeyDQizVNco48s=;
        b=NGk+loWLEL9NjFhUYLVeiFfKsU0NBcdq7U3T/BEMN1i3J6wAlt0BkFnmeMQyeevuZZ
         vM61AAh57Zy6UTDdEsM4OBrE6pjGUcaQ4q8ShaULcrC2ke2ZiSS6SZMlDbSLXQCZ4RDG
         b8GFgSVDZ5XnOUtY3N8kNOqjUkiunTg3zU5FjalT0T4vZSMMS4THYcd6RiJAXtI3QDhT
         bnBzOudkSZMZBy5jX+u9+eW8oeLvYmtlc7A9D0eXzdH1NF2sc0UaaiGOF3yx5Pe1sa6h
         wMtmI9YHk49AVR0aqpv+vUgkY2S+athplnSXiLhWOiKmv0JwfEU2JphuNqaoXFiH3xXZ
         +sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732459646; x=1733064446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9XViuJchf6uzl31NN9iMaATFPypoFeyDQizVNco48s=;
        b=ISgr8I3DJL6Jx8B7gSOJZc7jlAGq6bdp3hMUVivDwD+Mr7iKQd9SrZBXM69AuxAZhw
         kjsZ8msMcpDw9T1F+Q2NXAnXKpNHiS8SXSntzfiBuvE+/TrDBvlICEp+lwKBdQboQEpH
         YRS3UvoPFpiuvcWDIHZ7vg8TbkFsCRhHKSMvl6pitVYj3fcZy+K86EDNTPSXfzxuUslg
         cFxLPgJVKSapgIJEsHDqroWCXgRL/DTUIM6FkjU1K1FjnumcsRhvy0C1sTqT7HruvDBt
         G4kEbwFPskscy5STsz6T0ZQeSb6OnHngRwFVvuaL+y6+Uhk8eO6dnXA8bg/OGZtgiFJ9
         CL1A==
X-Forwarded-Encrypted: i=1; AJvYcCUFRa8fKljbh4zjMtDuHfyzGPKZQo9YnDUR4L2GeEKXdxrbEKvWzQX4iVG/CZ1xejCF0lZ1tzdzg58=@vger.kernel.org, AJvYcCXSuGz0daTpnn4b5juqw5G9cjr8iiyKffM7i6sMQgu9rHuFBEMH0a10cvwCKT27wR0kIA+gKI48kc4HsEkM@vger.kernel.org
X-Gm-Message-State: AOJu0YzHf47OPYMrBPavJdhbJis+B75B2YvuBev6+Gy1h3srtU86V6Bj
	HdmQFeuGdh18YGaBKmM4n8/KOt/DT7AtIgKlVwTvZzXWUb7MdPdAtILx8A==
X-Gm-Gg: ASbGnct+h2JGeJM9rn+U/rvfwZ4u8R8Pml+FbOrCr0lm9xVO/lqjkU4iJVYjY6Xli6j
	Rq3qZ49sKzWtu+vRM9gmSTHGrT0LM/C5JpLa2hx+z64voXcR77Yt9OW8clapfe+XZWyygmkJJm4
	9yLgpK6NA+RGxNoPuP7VLY4SAAUGBKLN+GZo0E1bKe32b2MxMAR0R2tu9f25niXWYlaHt8yUDs8
	OFNzYSfCyCOb/gOxgzCbCBpeUThL0ecWfPxYy5l6re/rvWW2XmAuAtLXc641NxxffgUgdhEc9Im
	Yso7qM/heHSn/KQJ1B0W7K/vUkKM6vmE0LuI7bxsBbEb6A3m7s6c5sGmkO0njflEP9w/v+pBrcq
	tinkHt75Vv3kheZlwtYtcZiVjxPB8g0Ou5RxNKUXMhj0=
X-Google-Smtp-Source: AGHT+IH72hm1E6mopJjt73QBkJ6WCD9Enm2i90jKVXDFdnXB5kGY7AtPox8ycWGxhhLfhqv8joHBOA==
X-Received: by 2002:a05:600c:4712:b0:432:7c08:d0ff with SMTP id 5b1f17b1804b1-433ce48ee2amr71927635e9.23.1732459646245;
        Sun, 24 Nov 2024 06:47:26 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:e4a6:c330:529f:3c71? (2a02-8389-41cf-e200-e4a6-c330-529f-3c71.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e4a6:c330:529f:3c71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349f78410esm5961945e9.8.2024.11.24.06.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 06:47:24 -0800 (PST)
Message-ID: <101820df-d6c6-4032-8e1e-d3d8b85720c4@gmail.com>
Date: Sun, 24 Nov 2024 15:47:23 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: light: veml6030: add support for triggered buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241110-veml6030_triggered_buffer-v2-1-ecda3b6ed77f@gmail.com>
 <20241123151634.303aa860@jic23-huawei>
 <1f5d62d0-42af-4eda-846d-cd0d57b5c6d5@gmail.com>
 <20241124124320.4237c67e@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241124124320.4237c67e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2024 13:43, Jonathan Cameron wrote:
>>>> +static irqreturn_t veml6030_trigger_handler(int irq, void *p)
>>>> +{
>>>> +	struct iio_poll_func *pf = p;
>>>> +	struct iio_dev *iio = pf->indio_dev;
>>>> +	struct veml6030_data *data = iio_priv(iio);
>>>> +	unsigned int reg;
>>>> +	int ch, ret, i = 0;
>>>> +	struct {
>>>> +		u16 chans[2];  
>>> There is a hole here...   
>>>> +		aligned_s64 timestamp;
>>>> +	} scan;
>>>> +
>>>> +	iio_for_each_active_channel(iio, ch) {
>>>> +		ret = regmap_read(data->regmap, VEML6030_REG_DATA(ch),
>>>> +				  &reg);
>>>> +		if (ret)
>>>> +			goto done;
>>>> +
>>>> +		scan.chans[i++] = reg;  
>>> This fills in at least 1 channel, but maybe not the second.  
>>>> +	}
>>>> +  
>>> So this leaks random stack data I think.
>>>
>>> Upshot, when holes are involved or not all the channels are set, need
>>> memset(&scan, 0, sizeof(scan));
>>> for the structure on the stack which will zero the holes as well as
>>> both channels.
>>>
>>> Ancient article on this: https://lwn.net/Articles/417989/
>>>
>>> We get away with it when they are in the iio_priv space because they are
>>> kzalloc + if we do leak data due to changes in configured channels it's
>>> just old sensor data which is (I think) never a security problem!
>>>   
>>>> +	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
>>>> +
>>>> +done:
>>>> +	iio_trigger_notify_done(iio->trig);
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>>  static int veml6030_set_info(struct iio_dev *indio_dev)
>>>>  {
>>>>  	struct veml6030_data *data = iio_priv(indio_dev);
>>>> @@ -1077,6 +1145,12 @@ static int veml6030_probe(struct i2c_client *client)
>>>>  	if (ret < 0)
>>>>  		return ret;
>>>>  
>>>> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
>>>> +					      veml6030_trigger_handler, NULL);
>>>> +	if (ret)
>>>> +		return dev_err_probe(&client->dev, ret,
>>>> +				     "Failed to register triggered buffer");
>>>> +
>>>>  	return devm_iio_device_register(&client->dev, indio_dev);
>>>>  }
>>>>  
>>>>
>>>> ---
>>>> base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
>>>> change-id: 20241106-veml6030_triggered_buffer-a38886ca4cce
>>>>
>>>> Best regards,  
>>>   
>>
>>
>> Hi Jonathan,
>>
>> thanks a lot for your explanation and the link, it makes perfect sense.
>> By the way, when I moved this struct from the iio_priv to the function,
>> I took a look at some existing code, and a couple of them might have the
>> same issue:
>>
>> - temperature/tmp006.c: it also has a hole between the two 16-bit
>> channels and the timestamp (aligned(8)), but it is not set to zero.
>>
>> - adc/ti-ads1119.c: the scan consists of an unsigned int and the
>> timestamp (aligned(8)). I believe there is a hole there as well.
>>
>> I did not go over all drivers (most of them store the scan struct in the
>> iio_priv space anyway), but at least those two look suspicious.
>>
>> Should I fix (e.g. memset) those two I mentioned?
> 
> Please do.  Thanks!
> 
> Jonathan
> 

Ok, I will take a closer look to check if there are more drivers leaking
uninitialized data. By the way, would you tag the fixes for stable? This
becoming an attack vector might be a bit theoretical, and I don't know
the consensus about the danger of passing uninitialized data to userspace.

Thanks again,
Javier Carrasco

