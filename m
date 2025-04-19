Return-Path: <linux-iio+bounces-18342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137EBA944EE
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 19:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDF2178FC2
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A4E1DF75D;
	Sat, 19 Apr 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OpNwLcRN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7F1A2658
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745085439; cv=none; b=EvlUN+RubhwrOPI43p/4K+N4fyVP0hwrHgkEtak5heuvfw8Msuigirb4b13NCXsc1VRMe/RxWDzBuKUITHYr2lJotBbkmCqq6CpphJewhCjbbJVebGN2RtOPRacNm50ncSS7JXaO665bB2UFg6qMBxJCJ/2n4dShriddxuxQGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745085439; c=relaxed/simple;
	bh=mmlxa8Rk/7RKZ2bVqNvnj28XwEsEz6g/FUP9UUVflxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6UAa2xwjpv7TwZjiUSBUJ7fCbYF9o5jMpSQBF5/ZPyofgTMVt4wfA2fl4UEtu+8oel+rtBaj65xPSYFWMiCthQwAqVL+5LFGybusGjS/bp1VT1gg3ymAGgIbcQamBDlon25FU8heUoWP5pR7QyrRXI/OXgPbF82FfmFVGE0Bk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OpNwLcRN; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f94b7bd964so1769297b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745085434; x=1745690234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jwv9dp5ITGuQ5J1GUX4sJX0dj0mGjzAgFo3XEGjECnw=;
        b=OpNwLcRNJFsRBkdqDyZM9QvjFqVeWy2SHMSkUFT2oFDvCBi01TcU9vS19EiFnfkMg3
         3LHugh1xsOBzmUUl8tLUSykGc/V+aZkaOWK8rk76i3Tmr8CAOTsiYUgQ3Wnh6Bf7V+UK
         cII2CfUsTqwQ3G78DFAyIgEe//NGu4X6trCTg4KcPct2u8QwpDm2Dt2tcgK/zTvPz8su
         I0kq837dF4qKRzkgMij9BnQcMlZQQ9WB9aY17qDnS1KqLIAsaGIkyIU0RyDPGNNW5sb1
         tN30GjccbHFPAVJmFMQmoKE87xcNVx+8msKjkSykT2hI0l39Y0DvZymm0YdVFl2WA2xg
         1Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745085434; x=1745690234;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwv9dp5ITGuQ5J1GUX4sJX0dj0mGjzAgFo3XEGjECnw=;
        b=diY7Xfg3lcOa1jYOBN1j9RdhtSIjsN4Vg8TBIitK8WKNrAZV0AHtnqtUgG8Ldr8nwz
         Y1MA1xjhz6AhT9T6MAb2nhPZTFDunOMveCzCX/SWF0y/77nfXEXaQiN7fZITYgwWVIXw
         MQcmWmrJLBEzTmwzdXeL2lVGgt3BIIJTG1sqxanJ1yE2MiM7LxQ7EO63KJ1XX8E27mmR
         hAMNR8WVwcg4YeL8RQ0NLv6faamSmXGKH3PxT5WvoiY5mTihIrjFgofYPpcLzhFF0IZm
         UtVgXmtnI8ND7Kw6dP+arbJcGt9DuEJu6OyUUKkoA1x4Kqzl8NTVgaabjF2Ls1gIkPVN
         OppA==
X-Forwarded-Encrypted: i=1; AJvYcCWGkZ49fRfUw6+HMrXDhzJR3upfgzTpigZsVNbHVjpQRnRogWCVLQHcEFhyahFUuatrPo/4Je0dhxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEsGKfZLpz0uKi8DxX/ykgqDfmi234bs+8gd+L68uvck5pq73
	md/KqjSbX8zyE4As8Endwp+p9vBubkLOpvSVJpo3p/3LpgVWhsAMFdzFuPgGyKkE+RGRusn9jqV
	MrUk=
X-Gm-Gg: ASbGnct7XP1e2274RhBA8kCuXz21gBgL2QEH9JvfTmZL8xP56OZjsYDrld9L0t52vJt
	B6le0V0UrjvHXCCAAuY/zlgOe0eGYts7CIkkWN9YIG0lF5Qm9sjyifRlCfJNosdAxzWFo9umzdi
	JLjqMPgG9+qZy5uxQ/thRT2NX74+cn/AfgTxeE6oqHOLfI7EPdJZ7oR4awYGy6n6I/OPD4jfXvl
	znxtLTbnVvtdAo6KrDRe7dnW2J6VXEklXnQrUqoBIdaaKmgOJecyZYrtihm//Rm2Cc7IXlLUM8h
	7MCA8q7W69+p61ifJ2wmM5Ad0SO9txVKs4E5qasFQsNWav1143RhMIigQjuQBGOsTJ6oewLOkc0
	V8zOEnXIba/3H
X-Google-Smtp-Source: AGHT+IFzVhDW/P9qqVJQTA9B6IABAVJUcp+fnfDJo98mF1L/yBiLAzFMirsdskXPwrDNOMkJjIWNrw==
X-Received: by 2002:a05:6808:8214:b0:3f7:28ac:8068 with SMTP id 5614622812f47-401c09534a2mr3337213b6e.13.1745085434363;
        Sat, 19 Apr 2025 10:57:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:79a:b8ae:edee:ec5? ([2600:8803:e7e4:1d00:79a:b8ae:edee:ec5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeee213sm789037b6e.27.2025.04.19.10.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 10:57:13 -0700 (PDT)
Message-ID: <a834e345-6d44-4fe6-a3ed-cc856e9dc4d3@baylibre.com>
Date: Sat, 19 Apr 2025 12:57:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: adc: ad4695: use IIO_DECLARE_BUFFER_WITH_TS
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-2-ee0c62a33a0f@baylibre.com>
 <aAPRbb93lJrnEE5l@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aAPRbb93lJrnEE5l@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/25 11:38 AM, Andy Shevchenko wrote:
> On Fri, Apr 18, 2025 at 05:58:33PM -0500, David Lechner wrote:
>> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
>> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
>> and understand.
>>
>> AD4695_MAX_CHANNEL_SIZE macro is dropped since it was making the line
>> too long and didn't add that much value.
>>
>> AD4695_MAX_CHANNELS + 2 is changed to AD4695_MAX_CHANNELS + 1 because
>> previously we were overallocating. AD4695_MAX_CHANNELS is the number of
>> of voltage channels and + 1 is for the temperature channel.
> 
> ...
> 
>> -/* Max size of 1 raw sample in bytes. */
>> -#define AD4695_MAX_CHANNEL_SIZE		2
> 
>>  	/* Raw conversion data received. */
>> -	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
>> -		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
>> +	IIO_DECLARE_BUFFER_WITH_TS(u8, buf, (AD4695_MAX_CHANNELS + 1) * 2)
>> +		__aligned(IIO_DMA_MINALIGN);
> 
> I would rather expect this to be properly written as u16 / __le16 / __be16
> instead of playing tricks with u8.
> 
> With all comments given so far I would expect here something like:
> 
> 	IIO_DECLARE_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);
> 
> 

We would have to make significant changes to the driver to allow u16 instead
of u8. I don't remember why I did it that way in the first place, but I consider
changing it out of scope for this patch.

