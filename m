Return-Path: <linux-iio+bounces-13983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934A2A045A0
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10393A5441
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F71D1E3789;
	Tue,  7 Jan 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ro7ZFj01"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3971EE003
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266162; cv=none; b=Mp6qR3/khZRAHew8OBY/IVfAMHC/kHZBBL26/yL3B9bZZ1jmJRHwx6ciwvcbPkJfmlpCWhss+fK3NRvWhKCOLdWnqLaubj+HCFTdBbkH8BLqUujZ2sHH1Qhpecu0QKkqGPHxtQiT5023jFJevYmXGm3LyFY3dgZj5cRZ9ReoMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266162; c=relaxed/simple;
	bh=oNYJNnRD7TzIcOLVZeLJP82M/GKbZ2jn+GAfevknsjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLl+pwvJMrbWl4s5wMrsQzG8Ed2YBJEYO0XBCUCBa2keDRfGGTqTEPL6825wvMryEIMC3WhdrtqlUWnxJ9crcbJbTxJeftVpS9mBBzeRyfvCciKOFPHTDQP7WP0dYjVcnsI+SrTNQk8253aOUwCB/i42iK+xtfjZl6t9JkS0Qjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ro7ZFj01; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f6ab7e0bd6so3006300eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736266158; x=1736870958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElSEaPObdBXsktJMs0LBMfJ7+xJfhpZx3BH1gihhcRw=;
        b=Ro7ZFj011Y/2ECYvLmH9ppmsfjarQSBqhlKj3tT3TMoKrIZeJR990Ai6frvf1/Eb2c
         SFAR7a/tGzqp1uwB0eioFrC/neEez6uHAQhNYKLfcdoEv7YsWJ9Wiu3wmhF9JR4NXDX4
         HpvyKoXnmXtTsueq75XDLyW6RcJs9gEADsf/NNKQqW4LCKRwpUT+oTrzTapC3mtxCpmM
         6Gq+/Kks9Zj8m/3eTa8kk5rr2oEilpJafZvxUToxMevorCE5nXUN8PupBoWh0/acqQkj
         UmTG1IZExVEC/m7/lQyOXEZ/17vtrikTHiMrbwwQGTuiXVc+Wr8/cPnJ7QBwhKdnRboW
         nd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736266158; x=1736870958;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElSEaPObdBXsktJMs0LBMfJ7+xJfhpZx3BH1gihhcRw=;
        b=XQAQGRdACQzXrFXJGuhpOoPtxoXd2R/8eGSLeFf65psk5DeROpI1WIvUZTVnTiibGS
         XRmAHwThZyZLAtkK34994I88naKxO7QfABc+Hyq2Pj6ZJL/UMeFC7tAP546haJ8E0nhO
         86YipmUWxTZ5+2J5G7TTvZspvUtJ3ivLiYUXhLW622GicDRV1vWH2lanJyNTNYTBXitP
         mt1mEJrLK3wi1ofqi4R0g0Er2AxD7jTPQIl4TJZq5NDy6k6xX4nvnkZADQDmeQkJXYeb
         3R76NlfqEMeCV4epXy5AS3h6XqzLMKWov32UlG6ou16AbCYcZd+HNFGbIP5o02FbFbLT
         a9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4QI8bb/APJDIa2X276+Ry318kzygtIu+L8oax8nkbfEkvSmWSQbld1Fx1+kprzcvuqvs2ncW++sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKF27hA5/cYD9R1BNu4lFXKsPTOitdzXQ2DGYqOheExy729RG
	apwsMDDTQiw/AGyYpU6zn6WTvmVHcX08WuOlC15t58VU4I39VDOvP1sx+gyqGv/NaqIK/1wt56P
	G
X-Gm-Gg: ASbGncu4M4rTSusVtOsPMrSsfcqNIvxV0iAHWMqp5Pz1VybfsDpORLvD96abKChV4YZ
	V75D/CgsTdIw7Ldk0N9fgBtrXQ+RDDNi7z08MJpCvajt/8bXTK20tIHn2eCqPcgbI+SKA9uiuYt
	vDtrJ0uuJTkpvupEwHotriTdEyi2YiX9aDaTo2Nubu+E83g7DZ9qSCJ8qaaoc3BCKx9E1HzHUkW
	GwYzaYocZX2WM0IbHL9TUM+n12uvJNSSV4tnsrLCF4uUGrr0csoagdD3eqbDa8FFralmQLwsoj1
	c99LNJQD3qUxOkx3tA==
X-Google-Smtp-Source: AGHT+IFLoiiURy+bODFeR5O56c1DjtzBvpbhWHHq35w5BHjURwD6A2FxbpgHo9pjbnoKlL7PHwlPpA==
X-Received: by 2002:a05:6820:2010:b0:5f4:cd65:7627 with SMTP id 006d021491bc7-5f62e6ff0bbmr39241849eaf.1.1736266158341;
        Tue, 07 Jan 2025 08:09:18 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f4db58b550sm9857243eaf.13.2025.01.07.08.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 08:09:16 -0800 (PST)
Message-ID: <c298f1bb-d0a1-42af-b237-9aa8e422ec1b@baylibre.com>
Date: Tue, 7 Jan 2025 10:09:15 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
 <20250105172613.1204781-2-jic23@kernel.org>
 <88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
 <20250107142451.000021db@huawei.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250107142451.000021db@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 8:24 AM, Jonathan Cameron wrote:
> On Mon, 6 Jan 2025 17:14:12 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 1/5/25 11:25 AM, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> Initial thought was to do something similar to __cond_lock()
>>>
>>> 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })
>>> + Appropriate static inline iio_device_release_direct_mode()
>>>
>>> However with that, sparse generates false positives. E.g.
>>>
>>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock  
>>
>> Even if false positives aren't technically wrong, if sparse is having a hard
>> time reasoning about the code, then it is probably harder for humans to reason
>> about the code as well. So rewriting these false positives anyway could be
>> justified beyond just making the static analyzer happy.
>>
>>>
>>> So instead, this patch rethinks the return type and makes it more
>>> 'conditional lock like' (which is part of what is going on under the hood
>>> anyway) and return a boolean - true for successfully acquired, false for
>>> did not acquire.  
>>
>> I think changing this function to return bool instead of int is nice change
>> anyway since it makes writing the code less prone authors to trying to do
>> something "clever" with the ret variable. And it also saves one one line of
>> code.
>>
>>>
>>> To allow a migration path given the rework is now no trivial, take a leaf
>>> out of the naming of the conditional guard we currently have for IIO
>>> device direct mode and drop the _mode postfix from the new functions giving
>>> iio_device_claim_direct() and iio_device_release_direct()
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>  include/linux/iio/iio.h | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index 56161e02f002..4ef2f9893421 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -662,6 +662,28 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>>>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
>>>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
>>>  
>>> +/*
>>> + * Helper functions that allow claim and release of direct mode
>>> + * in a fashion that doesn't generate false positives from sparse.
>>> + */
>>> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)  
>>
>> Doesn't __cond_acquires depend on this patch [1] that doesn't look like it was
>> ever picked up in sparse?
>>
>> [1]: https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/
> 
> I wondered about that. It 'seems' to do the job anyway. I didn't fully
> understand that thread so I just blindly tried it instead :)
> 
> This case is simpler that that thread, so maybe those acrobatics aren't
> needed?

I was not able to get a sparse warning without applying that patch to sparse
first. My test method was to apply this series to my Linux tree and then
comment out a iio_device_release_direct() line in a random driver.

And looking at the way the check works, this is exactly what I would expect.
The negative output argument in __attribute__((context,x,0,-1)) means something
different (check = 0) without the spare patch applied.

