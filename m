Return-Path: <linux-iio+bounces-12731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06249DA969
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B0BB23629
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71931FCFC6;
	Wed, 27 Nov 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eph4DbzS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE321FC0E1;
	Wed, 27 Nov 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715685; cv=none; b=PyTjzjiS3NEFpe6zLMgm175NgHOI9o21vJTiG6td436cVTCcMZEBGMN/J5kj83u0tc5z8CJjWqPj0LRjDYdtQEB4RYivJZTFrY1hnRxO7rOnl/115/E3uU2yavR1edZFlTk1Bh/Q3NVzRG+uY20Vgsdw1c20ks5lDZUCi9tS4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715685; c=relaxed/simple;
	bh=iw8gabaoRF/22JC1JMTYn3xxXeoqYQL5zt+vcU+BPfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2Nz4VD0npRywRals2uV7i5Rz1oNR3RPp11vewneHwLbGcKlSbTlniUwVaESwRW1hs2Up0RlRc3sXGu0WN8OAQi1YcdQoaczAH1srlJMZOtIDIK6OusambzmhQE8uqiXmb5ffDv7LTlaEjf08g8X+ps//poZ8wwiutlju+BpKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eph4DbzS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de79c2be4so3384020e87.2;
        Wed, 27 Nov 2024 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732715682; x=1733320482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jE918UVntXiKlUlugiQLI9YVR9y1Y/Gzcfmth7M2h1U=;
        b=eph4DbzSxD0wM1FHv1nD4SnneARIMFOf+0SgirttFACTqmsKL8qRUxiFZ/sLhhUOLd
         d9ImqHdbTPBR2UBc5jmR3pQ7p5pGPyxoduoHqxA+dhuDFN+gHrgwyEl62GOLrqCfZgfZ
         S03T/t3pkZiqIDt6BVbacYwvE8M3swRoYxud1LQ6n/RGCQqKxB1J2JgYhxQZvzcr16c/
         14tNCu0zeLuVnvUSSyGbrdE734PC2nh0Uj3lhG1vWsm51RSVAPBuwAEXBPKYibVriJ3K
         FLhAL78YvMZdSnzvZeDiDnWgLL9XVgr1Y66KwOCyvBXL8eX7k5+EFktN5yHy0OPmIQT3
         7czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715682; x=1733320482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jE918UVntXiKlUlugiQLI9YVR9y1Y/Gzcfmth7M2h1U=;
        b=PkeI4a3LOcsPJ4YIydwZB+jDe4WgUBVnIfYdpQv7ffsKK8vEBMrNfWBxJuxEBWEvX8
         oqjGSKshYO+QFeb47GM9SAuzoW/A19SGsNPSar9jBQjZEGESSWdNeY8DM5KrMqtpjgVQ
         BIJcjvSwiWOvTOT2XpdHbFlIUtmpZY3b2srrdCUXZr1CzTizADNGGivp/5LnijZCsLX1
         aRIhyXa8+ecGjhZDjjkm/uBjNndfvoEU9rCBUNf+3U4PB9MFrVgR78Omfk9rFZEyecyJ
         VhIpLcucCmd4GysdlIxET/auGuUZHvytY1yUGtNiLpLazyGJbGjrTq4rf5BCjdthLl31
         dwlw==
X-Forwarded-Encrypted: i=1; AJvYcCUbgBLdKPHAsPkAyLptjvxhURoxixWHJAxR/Nf6iW9dijFdORCP5lcjxR7CZY7xvQ6mNG1tiFuelOfhDw6y@vger.kernel.org, AJvYcCVFuWNnu+1wILyHtoD9iIDmS4Z1Ekyd3H1h2DBoP0guE1jD+jbMmtAk8/k0dx3VEnviuC6aPY8t0s6N@vger.kernel.org, AJvYcCXSlxQMGfN1hCahg6Ts8BUxR7sqniUCAaeBUQZIJkXcu6GPsONLx3YF1B2f9EwPGgG+w9nfmuDKjK4H@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuYKhrzSQoZzQn58KuBdXcd6dzD0nNxOV4/G22XcUHifZmgQl
	GILSw11RKwInLbu2UmX9l+XqjiALyA9vN32cHwVc29ekkTNOlesu
X-Gm-Gg: ASbGnctwgdWetvHgPICjgJWWOkECrkv6ikKfdfQPJYc0Zn9KkbPl3+Gw0vUZPoxkvPv
	zm7HaK6mMfhBW2H2IoV2bbAjh8LVo/Ie2UJjwMNur94bs2dYuQpa414wYUtAJE3Exnd/euss+wd
	iKvz2Sy95I5T00CCSj9W/FWHA5lLpSfkFKeYTfsp/LAqzu4jbUVLQPbUxco1ouSd7Ol4BKKRPHC
	uCkUeiSWJwLxztlFPK9KAI42cW9EpBZuuNy5/vSKCLQ+1Bt9doZQAu0GcFePcrFh5tkb7ALtjLj
	tfu6PXwd/EvtyjUgetvHhbl2qOPYPa4=
X-Google-Smtp-Source: AGHT+IGwB9pBQDCSAMYJojjIylrice2O1TfCWj6CKANg5JBYuKTDbzRGcoYLLBO0lQbZbDaRDbKzbA==
X-Received: by 2002:a05:6512:2350:b0:53d:d41e:b1a8 with SMTP id 2adb3069b0e04-53df00d10f1mr1760628e87.20.1732715681565;
        Wed, 27 Nov 2024 05:54:41 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451207sm2301944e87.83.2024.11.27.05.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 05:54:40 -0800 (PST)
Message-ID: <9ea2d6b8-c2e3-4b9b-a495-96b87355776a@gmail.com>
Date: Wed, 27 Nov 2024 15:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] iio: accel: kx022a: Use cleanup.h helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732105157.git.mazziesaccount@gmail.com>
 <037985fe50fe79c79b9df95fa7b4e577378f9a60.1732105157.git.mazziesaccount@gmail.com>
 <20241123164223.25656985@jic23-huawei>
 <bda7eaff-1315-46d0-83b4-a14060c2af1c@gmail.com>
 <20241126175550.4a8bedf3@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241126175550.4a8bedf3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2024 19:55, Jonathan Cameron wrote:
> On Mon, 25 Nov 2024 11:34:36 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hello Jonathan,
>>
>> Thanks again!
>>
>> On 23/11/2024 18:42, Jonathan Cameron wrote:
>>> On Thu, 21 Nov 2024 10:20:23 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> A few functions in KX022A need to use mutex for protecting the
>>>> enabling/disabling of the measurement while configurations are being
>>>> made. Some of the functions can be slightly simplified by using the
>>>> __cleanup based scoped mutexes, which allows dropping the goto based
>>>> unlocking at error path.
>>>>
>>>> Simplify error paths using guard(mutex).
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> Now we have guard(), the main reason (I think) for the
>>> combined on + lock and off + unlock paths is gone. So can
>>> we just flatten those and do the locking at caller.
>>
>> I did consider this too :)
>>
>> Why I decided to keep it as it is, (even though we need the extra
>> mutex_unlock() at certain error path) is because I kind of like the
>> lock+off and unlock+on functions. This locking does not protect data,
>> but really a sequence of operations that needs to be done while sensor
>> is OFF state. It's almost like a doc saying that "please, ensure the
>> sensor is OFF for the following operations" :)
> 
> hmm.  I really don't like them because they are 'unusual'  :)

I could argue these aren't totally unusual, perhaps unusual in IIO. I 
fell in love with this type of functions when Guenter suggested this 
approach for me in the wdg. Well, IIO is your territory so I'll mutilate 
this file accordingly.

> I'd argue they just ensure a sequence of writes go in as an atomic thing.
> Two of those writes happen to be turn it off and turn it on.

Well, the data-sheet is very clear what comes to clearing the PC1 bit 
when the various CNTL register are touched:
https://fscdn.rohm.com/kionix/en/datasheet/kx022acr-z-e.pdf
(at the beginning of various CNTL register descriptions). So, the on/off 
thing is not something that just happens - and this is what these 
functions did try to underline :)

> So the data the are protecting is the device internal state data.
> 
>>
>> (Another thing is that we do claim the direct mode in write_raw, and
>> goto is still handy for releasing it. Scoped guards won't play nicely
>> with goto. Yes, we could probably use the __cleanup for direct mode, but
>> I still like the lock+off, unlock+on for the reason above)
> There is a nice new cleanup that David did to make the direct mode
> handling much cleaner.
> 
> 	if_not_cond_guard(iio_claim_direct_try, indio_dev)
> 		return -EBUSY;

Ah. Nice. This is not yet in the iio_testing though. I'll add this 'drop 
the off+lock, on+unlock -functions change as an individual patch. It'll 
depend on the if_not_cond_guard() while the rest of the patches should 
have no dependencies to any "not yet in iio_testing" stuff.

I do have the patches ready for sending but I don't have sensors to test 
this at home. I'll give this a try at the office tomorrow and send it 
out then.

Yours,
     -- Matti


