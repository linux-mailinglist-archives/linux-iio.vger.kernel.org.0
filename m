Return-Path: <linux-iio+bounces-21914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0594B0F6C7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F91F18896A8
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF362951D5;
	Wed, 23 Jul 2025 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2jKYJlak"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE323F26B
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283515; cv=none; b=NmLDk1SNLEIEBxnYw4U1lO6KwMYeCwlYczqnwyt3u+xPcL0+x0hV+wpJxbGE261JlLsprhGoTVH+EV7p4ULvsclZgmZd34Coe3O4NVPV0RFw6FkFDvH5H+x/t4Od6gXBKsbz9eF4PXce7eYBVoTWVR9FPYAK48K6N7XWprXPeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283515; c=relaxed/simple;
	bh=42dmNoNeHaeyAh/9x6yJx9tx/4hkKLwnJU2fijUtJZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACXnkzW7B/Fc2JBg6C9+w1Ybk9Az5nsrSCpcajNMqfnH5xwJtbYwn2kwsLZdokG5rrFueiYKZoqd6Hy+zFscavLbOjoVZVGFaJmgA5RkmvPP6LDdG1vkSIPx4qL4p6Jivags1XG+DskPgK9E90tNSDhLb0yCCsCdoQpbPvJ0iHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2jKYJlak; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73e810dc03bso1080300a34.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753283513; x=1753888313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S85WnsPVgtp4eLDg2p0Y3squYOTYT4wbTPP6Q+Mdo1U=;
        b=2jKYJlakQr0jo0lzRd2XBwObUDVMyNEfsY3EhUesNzQMrsnxR0ai1FyFYvx8ncrOL1
         M5lk4eeM/r715vPBzKorxuQRQrMvnVn2nDLx3olHli0OGjOZ+jtkeeXL7/uEVG9TKCER
         sp3NRe8L8lFHg8ZV5PumQZECSMHdNJfXWrJaZQnX/Bce4aSkwf+daakpDDsrM3byRFK4
         duEIiMSFGVX7RQsEYwlWwXFxM3L2nw/HX9LegnXP/yvYJTfNprA5SLm7Uv2n1gdtqEtn
         NnjEYSL7XEfJIT0eayks6YzkrYf299JJp5JfkEauhIK/uP0nIowL73AwZh97E0QW9Nrl
         qa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283513; x=1753888313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S85WnsPVgtp4eLDg2p0Y3squYOTYT4wbTPP6Q+Mdo1U=;
        b=gza8k3a69vcsxLIXztrtwKN54LUGW/ljdPtMi0Dx4nTHJhgC1T48WdRRSct6LFxYys
         4u0lMdZl4D8F8vp3/bsHiR3aV4gXGq0QsXyMJxX921Hvonzmlhkt/oyVQUymqjjMxqix
         9WpjbOihpohY/xmwZEUVucOwiQj+cj00uvCtw2sP1L0Au1ykhJbpLJpePsT7ASRByGYd
         atqGkc9CgieH4/bBnDagydJcCB7fvQBJImveV/XZH09lLvnYIAdFDQqhIOpByD1sIjcV
         T8imij/C1EkCzk01jVXmaWbBhYcoYh7IzHwgvp6m05uI7MVktmRjnezZgwkce5HeyhmK
         PoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVtAksSy06eC2TGAIXnoV6kMrqF2u2w3XB5NkiYmQ7HNuOD6ltZ2k4ri22kKN3TITIBRtUM4pu9FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9nQ2M2TisLhFW5aXFbSYUI7/E/LoIUmi/sxDV3fHPiVa/OleQ
	1ed3X8za2nEIaLenq3p0V0t3bs4xlcLEJ8gTnQXm9BK5rDLUQ/os72CDkEI1e/KiyJ8=
X-Gm-Gg: ASbGncs183EOiz4NK8+BFt4r2zO1S0YA066Dx8MkjfXNHlJkwSCy3ce21Ga2Dx8u9aQ
	qdn1VEzhnpb/TiK2EgHz2BqQqKTQeL7zQCzFRPD6wIZDw6a14ny2qHQT2FvZTu9iEnLImbKpyfb
	hlYqv7EWmgDjwMeSzlzIsPXTgsq5WZI6gQw1I0TB5GRKjt5kXDS3oQjwHOw0cM3KVHI9vJG1PmJ
	AkPYXPAY2cT0gyGmzsWXGJGthzDUBednxnj3m4QakA5Mc0rGJwKc4Ek0yw4bBXefIVx7F7bLiWy
	GT3ygbEvi4k2QVaZSUHyX/xgbraqgqUYk2uHAxdMguKy4lKWfxjMjTXRlWs7FbhPICECXNqqJBx
	2loZeKuwmqgU9dEvtIGlITS2wgIYieSLEW6oyPuwldNE8Z7XIebOUavHxle6BKMrlIoqygGb5YH
	l6ls7WLmA=
X-Google-Smtp-Source: AGHT+IESe/ClormQSj9MCq6UVWklH/eH8uzfHevbgKe0nfufdJcx8Ixa6/aSjLL+D07Yt1hJfEbavA==
X-Received: by 2002:a05:6808:4f69:b0:403:529d:fd81 with SMTP id 5614622812f47-426c4bdf54dmr2556577b6e.17.1753283512546;
        Wed, 23 Jul 2025 08:11:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd10c1f4asm3184197b6e.7.2025.07.23.08.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:11:51 -0700 (PDT)
Message-ID: <f74d6542-cc4e-40dd-8ef9-2a766d0b51ef@baylibre.com>
Date: Wed, 23 Jul 2025 10:11:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
 <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
 <aIDuEcHhaGtz2klP@smile.fi.intel.com>
 <795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
 <aIDzvNYIaJnSuzOa@smile.fi.intel.com>
 <7ca7e0b9-a77d-4de8-92b1-fea3250e8155@baylibre.com>
 <aID6jfjULn2kvvQJ@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aID6jfjULn2kvvQJ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 10:06 AM, Andy Shevchenko wrote:
> On Wed, Jul 23, 2025 at 09:57:58AM -0500, David Lechner wrote:
>> On 7/23/25 9:37 AM, Andy Shevchenko wrote:
>>> On Wed, Jul 23, 2025 at 09:29:37AM -0500, David Lechner wrote:
>>>> On 7/23/25 9:13 AM, Andy Shevchenko wrote:
>>>>> On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:
>>>>>> On 7/22/25 6:07 PM, David Lechner wrote:
>>>>>>> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
>>>>>>> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
>>>>>>> the data before pushing it to the IIO buffer.
>>>>>
>>>>>> It is odd to have data already in CPU-endian and convert it to LE
>>>>>> before pushing to buffers. So I'm a bit tempted to do this instead
>>>>>> since it probably isn't likely anyone is using this on a big-endian
>>>>>> system:
>>>>>
>>>>> I can say that first of all, we need to consult with the datasheet for the
>>>>> actual HW endianess. And second, I do not believe that CPU endianess may be
>>>>> used, 
>>>>
>>>> Why not? Lot's of IIO drivers use IIO_CPU in their scan buffers.
>>>>
>>>>> I can't imagine when this (discrete?) component can be integrated in such
>>>>> a way. That said, I think your second approach even worse.
>>>>
>>>> hx9023s_sample() is calling get_unaligned_le16() on all of the data
>>>> read over the bus, so in the driver, all data is stored CPU-endian
>>>> already rather than passing actual raw bus data to the buffer.
>>>
>>> I see, now it makes a lot of sense. Thanks for clarifying this to me.
>>>
>>>> So it seems a waste of CPU cycles to convert it back to little-endian
>>>> to push to the buffer only for consumers to have to convert it back
>>>> to CPU-endian again. But since most systems are little-endian already
>>>> this doesn't really matter since no actual conversion is done in this
>>>> case.
>>>
>>> Right, but it's buggy on BE, isn't it?
>>>
>>
>> Right now, the driver is buggy everywhere. The scan info says that the
>> scan data is BE, but in reality, it is LE (no matter the CPU-endianness).
>>
>> With the simple patch, it fixes the scan info to reflect reality that
>> the data is LE in the buffer. This works on BE systems. They just have
>> an extra conversion from BE to LE in the kernel when pushing to the
>> buffer and userspace would have to convert back to BE to do math on it.
>>
>> With the alternate patch you didn't like, the forced conversion to LE
>> when pushing to buffers is dropped, so nothing would change on LE
>> systems but BE systems wouldn't have the extra order swapping.
> 
> But do they need that? If you supply CPU order (and it is already in a such
> after get_unaligned_*() calls) then everything would be good, no?
> 

It doesn't make sense to my why, but the existing code is changing
back to LE before pushing to buffers for some reason.


	iio_for_each_active_channel(indio_dev, bit) {
		index = indio_dev->channels[bit].channel;
		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
	}

	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
				    sizeof(data->buffer), pf->timestamp);

I agree that it seems unnecessary which is why I suggested the
alternate patch to drop the cpu_to_le16() and just leave it
CPU-endian when pushing to the buffers.

