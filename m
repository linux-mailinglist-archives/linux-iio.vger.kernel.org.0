Return-Path: <linux-iio+bounces-14352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41BA10937
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EDA1626CC
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E01442F6;
	Tue, 14 Jan 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TknPiuDV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4523762F7;
	Tue, 14 Jan 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864783; cv=none; b=AJV72Yk6N1Q3z4CH0FwvdO8k+J9nLbJD8K3RTV6EDDNYTtjMyTiHI9RFmq0q7RzvehuOB6q1OzszenMYJ90L+eA/5Ul/Szfl/qTPfsChvREkSXCpfsl8uhD/mtwPC9f/GE+gCBPG9RehStSoLAJNn13kk7InPs6etqZaYUs3+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864783; c=relaxed/simple;
	bh=2UGyCYYmQymxux6i+EeAXPe40y3ROA3OKM52XefiW68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q63eUdiYCo8biiLdhL5QJOF+0DDSlL77XoCfYUKxXPpOc93EYE2MC7nPirZqE9PYYDptdg23Z5VTRcqClrqun11lmVNU81VfYMe/0KQpaosu9EiyLoX3wDinK1/v8WMZzMjwzPUR+5BgakCmBNLjjRmYfGMk97nceFdX+++DvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TknPiuDV; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so50823481fa.1;
        Tue, 14 Jan 2025 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736864779; x=1737469579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYBoarB7ZUcNlGD9p/S2F9O2o5SGWnWNZMJFg9btNTE=;
        b=TknPiuDV7CfVmU8fvyIlMXabAXHsm+deTm5lJQoOlvoIDy+SHC4yZzere1Si9NmT6H
         B1iZudl3hBN4z4FINFy17KVzfEn2Yk5LkY4gHwp6gGmd+BVwoKYVFIpmuhgZfWtwJ4eT
         0wTbGjMCcZXFEWRTzhd1LuKJ9vAkB9Wn6x34iWc4YGFs4Y+vi4PQWQjfbwkWAKBfY7Jy
         swfEYpDw3eUKcPxe+lo6/pQaKmbKXHzHdNbt7ZQtU0gut2DOODNNEAwIajON/h3KGqZN
         Go4xBek7VB7VTTB3LrfuW/W+NoshUpT6P10e4gVsEKF4ZEcK1/z8L6gB3Yf7oeRB/t8L
         1QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864779; x=1737469579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYBoarB7ZUcNlGD9p/S2F9O2o5SGWnWNZMJFg9btNTE=;
        b=BkUqVTOk6J4oUuyI+YvEol5MUJf9Xll68BS+KmGLo852cBcxA5HoIDOnxT2ICHfcsG
         HyHp0xL5yWFnD9AYD3ItXxrottdxHvNQkE9/B5wvy8z0FyTrdHQEWPd3RrXa8SsycINa
         AYLTGbsbzT+63WwHgs4lijJhso29m1T1sdSknAqY8KEwSq4FZIPZygAn4UiyNEyZeJqR
         8unqVk3wBoekmzqSnqAwYtZkWje38qyhJI5WJV19frp3SYOkYGYTjCvtptKc0TRYxeV3
         cX6w28xJv6LJ1ZDoZwFYkazvJpLrqiMj6fa+zu/oMipMjFbg8SyIXnBBmvFFQ9zXEy/I
         qcGw==
X-Forwarded-Encrypted: i=1; AJvYcCU1umVlYE+0c1oXzkzuqanCKyYgAgaqYYgIjKtWm24D+aCQFrJRrYUcdm51SmyzodByyCwM9af0OUIZiBG7@vger.kernel.org, AJvYcCXpPQVUaBRJoyuhqCNKBYWTIKDLrWNB8jmZnngTA4FHuf6GosfUYASCG6KozV/ZRrYp+P9iLPAa1xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RGCo0+NXrsOSvmxtFl/rdWNVG1bgFSExPy1qzt/WvWhtF3Yz
	oVvyYXCoANpdjAjmcTYBIiqj94IoTZ9MLk+0FiO0izWL8kiIIKsK
X-Gm-Gg: ASbGnct87uonGWMRgPlBUTNU7pV3uloaP7s4WdvauL9MvyL7RkGhKpEF/B7UnC6FaTz
	/ZDhFLg9G7VQEb+o48wx0sFrGlepT3f9wrdwgISVL8VZ4pKkJQdWpJ9WgOROdNZ0rP4x0LBVrpI
	ZbwGxytl69h6YjA1gdmCczAgVwuNQ1xvkMcihX/h/TTldAbtMwPqq0T56u28+uPuCPAUsHyswM+
	LD2qGUCAsqA85KuGrki6omvPLmI+CuJY/4cjMHGmTUI8i0RznYOoJiQYmwplUi7v1HGEA==
X-Google-Smtp-Source: AGHT+IFFQZtuRqnCQL5p7VCNUHaD9zFzu1RNHdEHD9tBn/7GvOvqv/SFlmb02NWhWuR0z47QLia0AQ==
X-Received: by 2002:a05:651c:220c:b0:306:10b5:6b3 with SMTP id 38308e7fff4ca-30610b5079amr33319751fa.5.1736864778356;
        Tue, 14 Jan 2025 06:26:18 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff1c75c2sm18086511fa.69.2025.01.14.06.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 06:26:17 -0800 (PST)
Message-ID: <bdda37a2-5151-409e-9df1-c0cbfc8a5093@gmail.com>
Date: Tue, 14 Jan 2025 16:26:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
 <129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>
 <D711DZJWGQX5.2D4PLVQN7NB8Z@gmail.com>
 <CANhJrGNT9H07MokRbVXRmDprZ+aV0XoDi=LhvrOkeSLzHnqsYw@mail.gmail.com>
 <D71AW9R10XCO.D7ONB8ZU3M56@gmail.com>
 <CANhJrGOya1tmYcovYJZWkWmVE9NdLFHiDw7izmKtfYTXm57GVQ@mail.gmail.com>
 <D71TEJCQD9XK.5FNF9SJLFJ94@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <D71TEJCQD9XK.5FNF9SJLFJ94@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/01/2025 15:02, Javier Carrasco wrote:
> On Tue Jan 14, 2025 at 7:43 AM CET, Matti Vaittinen wrote:
> ...
>>> I will give you a simple example, so you can tell me where my reasoning
>>> fails:
>>>
>>> raw = 100 counts
>>> scale = 2.1504 lux/count (when IT=25ms and GAIN=1/8)
>>> processed = 215.04 lux (raw * scale, ABI compliant for IIO_LIGHT)
>>
>> Your reasoning does not fail. But, the scale = 1 / (N * total_gain),
>> right? (N here depends on how we choose the scale/gain values) Here,
>> the total_gain means the effect of both the hardware_gain and the
>> integration time.
>>
>> Hence,
>> processed =  X * (raw * scale)
>>
>> => processed = X * (raw * (1 / (N * total_gain))
>> => processed = X * raw / (N * total_gain);
>>
>> Hence I thought you might be able to get rid of this 64bit division by
>> using the total_gain from the iio_gts_get_total_gain() instead of
>> using the scale. Or, am I missing something?
>>
> 
> I am not sure by X you mean the maximum resolution, but if that is the
> case, the following would work (pseudo-code):

Yes. X denoted the value by which the count needs to be multiplied to 
get the lux (when total gain "in the terms of gts" is x1. I think in 
this particular case the "gain is x1" is a bit confusing as it appears 
this really means the hardware gain is 1/8, right?). Anyways, lux/count 
it is, so in short - yes. :)

> 
> /* Maximum resolution (2.1504 lux/count) * 10000 */
> #define VEML6030_MAX_RES 21504
> 
> total_gain = iio_gts_get_total_gain();
> processed_int = raw * VEML6030_MAX_RES / total_gain / 10000;

Yes. This is what I was thinking of.

> processed_micro = ((raw * VEML6030_MAX_RES / total_gain) % 10000) * 100;

gah. I didn't consider representing the micro portion. Staring this 
makes me feel dizzy :) Well, it looks correct, and I guess the precision 
is not lost by the division(?) But yes, you did perfectly get what I was 
after!

Jonathan, do you think I am just guiding Javier to make a mess? :)

If not, then this might be the way to go.

Yours,
	-- Matti

