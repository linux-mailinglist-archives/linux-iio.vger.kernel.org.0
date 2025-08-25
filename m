Return-Path: <linux-iio+bounces-23260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB4B34838
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 19:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E8B2A1CBA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238B13009F4;
	Mon, 25 Aug 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NMypCay8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7F2FCBFD
	for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141647; cv=none; b=HGPVsjEqpybm90IOuzUfWToAhFaDlda1cWFU67rXZv/tF5B3+vZUFZfRPEr46I9v/gKLREof0rhTMTMiDHDlWlmS9cLDEo15WF95T4vOV7dMb1J4eo+CE+bZad8fh3wIcjUW4gGFhatou39k/SGKaJAdu1/6yg7zqVZY7wFD1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141647; c=relaxed/simple;
	bh=tihT6GbomvvQs+EKZeESfFJSOKHlKrS+UHpmIToBb+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4CFlAqJGtgkZ51+s4PYzCQ8e04Q4aqaRc433P7vNxlAFHUgbupbgAdKLyfTgcKNbXU0sqyoBdeCmS56nFJkCPZWSXmJdWUHwnG6dLsCljutx81S5ldp6l+d8DdMPR6HFQRLVF5YN7o7AAObEyotVDXSpQ9YOwZdFhhqRsPlvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NMypCay8; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61da7b78978so1752421eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756141645; x=1756746445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRbFgz7SRiEMK41EVqnjk1B2OcCfI8JeYtjMKIx5KnA=;
        b=NMypCay84crHX5YcMfEb57OmYitBhiHPFh2+goOCfFSww9USlAbvHAF93hxGEjLMZA
         norO5GksEO9GW6E8zDPoJ9tgtTKFzXRVPdVxucIIYKL29A1dRww999cJsnhXRvkPzj9g
         7dLlkGxE7Sr4UV8DnjgifqmOkkhTvtlmadxPtX5R/OOZ939IA8vanlq1/SBn3M68F1ZN
         6IjFxfEZa819UFNj9y/LW5XC6X0pSAuZJGp5/OnrAH9oTMa+7S6gGEujTtKUIZwlVC72
         KsL3BmwSSP31XtMaky5bvihOV72/8iWzm5sD4T34IJfSNsTG+5y0IOVm1N0gDcry7iHG
         zNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141645; x=1756746445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRbFgz7SRiEMK41EVqnjk1B2OcCfI8JeYtjMKIx5KnA=;
        b=uyw9hOPlhnoyAD6zNzlWVnH9X6/ezADnY2kSGdhUQOwfQnau/ZR+7RJhIeD/1F7uQb
         cBfK6+7Bv4yMPTXvsyJlX5ysItl1A6PvgPIStoZDio1V1M14MBNS+m/tNcGQgwyJZWUU
         z8tIAZtC6RnQ2iwMsQQ2ya0Y0OrxJ/nDiYalR2924b9APJk/m+ckaF/wed2g3tCRyj86
         IZELjyHojY6Uye3UW1IQ2EdOrr/v3UdTNK+y7HsMYjjHMLGiXRKhufEtoQ5X3s+O+Ew5
         Wqr0v3svFP6vvUMbWtt7dKQxMbwcqVJlnssxRbkI2cvhnfKftw+fZrBC5tJz1M98aJ4/
         O4nw==
X-Forwarded-Encrypted: i=1; AJvYcCUdSOFRfFoI/s5lKqqGlrF6VUUcpWscM8rLnU+exIVbdAd8++kh1guL1WOLjJrFrFsVdYSnmIU7TgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDkri1y7QXMbWq9Trqbzq2s48n7a+xrfQEamIrTlQaTMpYpzt2
	eBtwB4+SnPjZGksCwO+R9T5f+zm/3FbJx2jMKdwQXxfZHOZz8swgb2T4mdN3KypUBFA=
X-Gm-Gg: ASbGncsh7JS9a8gqJU9BZwuIalxFMvw+2JSAENo7nmtw3ozfI1qhTd2vKPItozQ4cv4
	TRlv8tgMY3j0vGl88jBdLriQ7Klht+CR2WWMLjJtAz/XnNvHuAaW7HJGVRHAWWqCmVhAAtgV45F
	HCLQY0355Ey272lngJKhbAFgBQpQYwyZVrJe+MnpeWbZZ6WXltu2oxNF1ad2F2Pph8YzJupKyF7
	nmzXv8Z5DaM8mSBgAomqc+PBQ0pd0QKHqLZCJWubMUbh1IR8FP3hyutJBRaYBMIZjUJ0fLh4DzJ
	wgTqBS/7ljGvdDm+mRaeiNcqaxgchkux7748LcD/HcVK0UOQs4+blTmHoGnAuFQy6krp18tm4dn
	GvG1vRzuFf1g+HOpcSuFajLyCJaROKgZR+UbOHqem95qAhvDhC562Lit9dWc/869OJZR2LgTHn2
	67qtJGnm2FJg==
X-Google-Smtp-Source: AGHT+IGY54ol1V3rSvNLdykRyCpLBdcAFmUnk88/gdXvtcBJwtaoIthE1jhurmxQ3KMLjUHeffscYw==
X-Received: by 2002:a05:6808:a5c7:10b0:437:ae34:16b7 with SMTP id 5614622812f47-437ae341c86mr1362511b6e.31.1756141644622;
        Mon, 25 Aug 2025 10:07:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5075:40f3:ff25:c24c? ([2600:8803:e7e4:1d00:5075:40f3:ff25:c24c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437967bf1bbsm1163111b6e.7.2025.08.25.10.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 10:07:23 -0700 (PDT)
Message-ID: <e05f7e9b-f3c1-4b66-993a-31d16e5147c2@baylibre.com>
Date: Mon, 25 Aug 2025 12:07:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Yasin Lee <yasin.lee.x@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
 <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
 <aIDuEcHhaGtz2klP@smile.fi.intel.com>
 <795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
 <aIDzvNYIaJnSuzOa@smile.fi.intel.com>
 <7ca7e0b9-a77d-4de8-92b1-fea3250e8155@baylibre.com>
 <aID6jfjULn2kvvQJ@smile.fi.intel.com>
 <f74d6542-cc4e-40dd-8ef9-2a766d0b51ef@baylibre.com>
 <20250723165615.67969881@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250723165615.67969881@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 10:56 AM, Jonathan Cameron wrote:
> On Wed, 23 Jul 2025 10:11:50 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/23/25 10:06 AM, Andy Shevchenko wrote:
>>> On Wed, Jul 23, 2025 at 09:57:58AM -0500, David Lechner wrote:  
>>>> On 7/23/25 9:37 AM, Andy Shevchenko wrote:  
>>>>> On Wed, Jul 23, 2025 at 09:29:37AM -0500, David Lechner wrote:  
>>>>>> On 7/23/25 9:13 AM, Andy Shevchenko wrote:  
>>>>>>> On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:  
>>>>>>>> On 7/22/25 6:07 PM, David Lechner wrote:  
>>>>>>>>> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
>>>>>>>>> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
>>>>>>>>> the data before pushing it to the IIO buffer.  
>>>>>>>  
>>>>>>>> It is odd to have data already in CPU-endian and convert it to LE
>>>>>>>> before pushing to buffers. So I'm a bit tempted to do this instead
>>>>>>>> since it probably isn't likely anyone is using this on a big-endian
>>>>>>>> system:  
>>>>>>>
>>>>>>> I can say that first of all, we need to consult with the datasheet for the
>>>>>>> actual HW endianess. And second, I do not believe that CPU endianess may be
>>>>>>> used,   
>>>>>>
>>>>>> Why not? Lot's of IIO drivers use IIO_CPU in their scan buffers.
>>>>>>  
>>>>>>> I can't imagine when this (discrete?) component can be integrated in such
>>>>>>> a way. That said, I think your second approach even worse.  
>>>>>>
>>>>>> hx9023s_sample() is calling get_unaligned_le16() on all of the data
>>>>>> read over the bus, so in the driver, all data is stored CPU-endian
>>>>>> already rather than passing actual raw bus data to the buffer.  
>>>>>
>>>>> I see, now it makes a lot of sense. Thanks for clarifying this to me.
>>>>>  
>>>>>> So it seems a waste of CPU cycles to convert it back to little-endian
>>>>>> to push to the buffer only for consumers to have to convert it back
>>>>>> to CPU-endian again. But since most systems are little-endian already
>>>>>> this doesn't really matter since no actual conversion is done in this
>>>>>> case.  
>>>>>
>>>>> Right, but it's buggy on BE, isn't it?
>>>>>  
>>>>
>>>> Right now, the driver is buggy everywhere. The scan info says that the
>>>> scan data is BE, but in reality, it is LE (no matter the CPU-endianness).
>>>>
>>>> With the simple patch, it fixes the scan info to reflect reality that
>>>> the data is LE in the buffer. This works on BE systems. They just have
>>>> an extra conversion from BE to LE in the kernel when pushing to the
>>>> buffer and userspace would have to convert back to BE to do math on it.
>>>>
>>>> With the alternate patch you didn't like, the forced conversion to LE
>>>> when pushing to buffers is dropped, so nothing would change on LE
>>>> systems but BE systems wouldn't have the extra order swapping.  
>>>
>>> But do they need that? If you supply CPU order (and it is already in a such
>>> after get_unaligned_*() calls) then everything would be good, no?
>>>   
>>
>> It doesn't make sense to my why, but the existing code is changing
>> back to LE before pushing to buffers for some reason.
>>
>>
>> 	iio_for_each_active_channel(indio_dev, bit) {
>> 		index = indio_dev->channels[bit].channel;
>> 		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
>> 	}
>>
>> 	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
>> 				    sizeof(data->buffer), pf->timestamp);
>>
>> I agree that it seems unnecessary which is why I suggested the
>> alternate patch to drop the cpu_to_le16() and just leave it
>> CPU-endian when pushing to the buffers.
>>
> 
> This one was seriously odd and went though a lot of discussions around
> endian conversions during review.  Definitely wait for Yasin to reply.
> 
> That's not to say I can recall how we ended up with the dance that
> you are seeing now (and I'm too far behind on reviews to get to digging
> through threads to refresh my memory).
> 
> Jonathan
> 
> 

I found the message you are likely referring to [1]. It explains why we
can't use the raw data directly. There is some processing of the values
that is required. However, it doesn't explain the choice to convert things
to little-endian after the processing. Given the patch snippet in the
linked message, I think the intention (albeit misguided - we should have
suggested to just leave things CPU-endian) was to change from big-endian
to little-endian everywhere, but changing the scan_type to match was
overlooked in later revisions.

Applying this patch seems like the simplest thing to do. Or, if we don't want
others copying this questionable code, we could consider the heavier-handed
alternative to keep things CPU-endian.

[1]: https://lore.kernel.org/linux-iio/SN7PR12MB810159A22C9814AA7FC1AB96A4CE2@SN7PR12MB8101.namprd12.prod.outlook.com/

