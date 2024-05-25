Return-Path: <linux-iio+bounces-5298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1D8CF053
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0996281C00
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161C86269;
	Sat, 25 May 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xsafZFh9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F3B644
	for <linux-iio@vger.kernel.org>; Sat, 25 May 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716656692; cv=none; b=Nob/F3ykB0IuAoBnit8CDThvQMgRjxGHy79gq1hR1AcAwAEyS22e1Blu0IW8C9kf8+OzhGPmlJrlhBZfRXgi+qdFjcrUuVzm3VqDHBnq32PccipxK7ua2GAdm7jX4YBNBg4oxE3FgGhFTQI1dfzJ1KbbQJqyMwnEG1V2QdgdW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716656692; c=relaxed/simple;
	bh=kg3n7xMJxgxvYtJSCGb0K5gEFqEb7zvSdCxoJRdsEwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IN5QQTWZX3pBtdm75CaE0O9MHTGlt94Uec0AQxtM8SLcq4HcreLGwmGxG5KEWVOj++gSiO5bqlsMRIEbah6z2upD7YpoGCd5S6B5mF6VcBeQHz5CaKwqtwCsGzchR1UQs/NebGXjUhwN/mk9gkv8sivLtSK0UxBHhupPiM/eX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xsafZFh9; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f8d688ba3cso822532a34.3
        for <linux-iio@vger.kernel.org>; Sat, 25 May 2024 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716656688; x=1717261488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyhNgeziGoBnrD6npiJ1mM54NiOKwg7bVcw/Tyz/QiY=;
        b=xsafZFh9u/sQTU5pony71C7iIIFzGUFr2rZun4Mh05aOB/mJ61b8geZgoLSJg3d4to
         yhmolZ4pzqWSsx7tFNfq4fOg4eYlUZpl8jFBARPWYNAVfZn/oX4t7QjaHvzDwq8urpM1
         i6LzzWUpHg/5h/+BEysgyLZfiMu5I3iBPqcubANbxPbM3Xj4I4enMAPr+R6M3Py+tdBT
         /uYNjgywh/f7N2eX6C8oU8DqfmNd1Oim1cgEZ0PR0lhNyKHhpGCWJd/1N6JbPEdsiGE1
         INIQNQ6yV77EhpcXR7W+yN5ZPryYVgnhiimpuYpynvNstDEvDZKIwumpCWXPbEgg3oyf
         qiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716656688; x=1717261488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyhNgeziGoBnrD6npiJ1mM54NiOKwg7bVcw/Tyz/QiY=;
        b=hUmYIxKzZ4v1kmcWB7qtmgZeMKsCIQSi5+HWvFAWmY/7srohNLyw0aYc5K4iCaOUQD
         aM37vzviZqBRd8kgLa6IRwFYxRYqm5j59xvoz3d06meb7E9PfWkQ+0aYq46BZjD3Gx7B
         10MmrVGdUpJhdi8E3IV4iBRSd9AxFAXrkqv4fX3Gjr4zm4KLiTkNWOeNY7fhtbo0t6Gx
         pA1b1Y5/93xRIkWlsvTAsq0kpflsxQmRCuGzYIN3dBiScoHkJu6Z8kI4eQ35g+WyP+7M
         2m7DIMGEGPBhk/Q9vrBl2xGGiBbp6bcwryxSoB/34xgM2rwuZSMNw/SPBuCDO27EQ778
         ZwRw==
X-Forwarded-Encrypted: i=1; AJvYcCVPNKc0vQX046GxewfTGFEiI9DZM1152gX/aOm/6f8OsAvMriaJjT6Qu18PGbM+m5ZPFENkuLAJJpai+a5ghBmsUXYTh/PEYcd3
X-Gm-Message-State: AOJu0Yx6A76NvQkeP2FTnhiXKhNa+gvaqX76OgQ0T7RzHIUydOp9UH4C
	oBWPrfsmxsC5/XSQoyxtTgVY9saWH5w7l5WHirwz7CwktXH304BHskjmvY4/syQ=
X-Google-Smtp-Source: AGHT+IH03CFOyTRgxDXI7xXSMlN6LRQhjT0TKB34+s9C3xTAF/VcwZ5wjkToXbHwppbFvG524AiW0w==
X-Received: by 2002:a9d:654d:0:b0:6f0:e6c4:7cb with SMTP id 46e09a7af769-6f8d0957024mr5501259a34.0.1716656688086;
        Sat, 25 May 2024 10:04:48 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de7198sm828864a34.43.2024.05.25.10.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 10:04:47 -0700 (PDT)
Message-ID: <003d0998-dd25-45ab-9bb1-feda2d0f91a3@baylibre.com>
Date: Sat, 25 May 2024 12:04:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] iio: add support for multiple scan types per
 channel
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
 <20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
 <20240519201241.7c60abac@jic23-huawei>
 <ebf18ed1-a82f-4c0a-9a63-2c428b5aee40@baylibre.com>
 <20240520171205.000035b0@Huawei.com>
 <5cf036d5-1eb3-4f63-82f9-d01b79b7fe47@baylibre.com>
 <20240525171408.36bda583@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240525171408.36bda583@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/24 11:14 AM, Jonathan Cameron wrote:
> On Fri, 24 May 2024 10:56:55 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 5/20/24 11:12 AM, Jonathan Cameron wrote:
>>> On Mon, 20 May 2024 08:51:52 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>   
>>>> On 5/19/24 2:12 PM, Jonathan Cameron wrote:  
>>>>> On Tue,  7 May 2024 14:02:07 -0500
>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>     
>>>>>> This adds new fields to the iio_channel structure to support multiple
>>>>>> scan types per channel. This is useful for devices that support multiple
>>>>>> resolution modes or other modes that require different data formats of
>>>>>> the raw data.
>>>>>>
>>>>>> To make use of this, drivers can still use the old scan_type field for
>>>>>> the "default" scan type and use the new scan_type_ext field for any
>>>>>> additional scan types.    
>>>>>
>>>>> Comment inline says that you should commit scan_type if scan_type_ext
>>>>> is provided.  That makes sense to me rather that a default no one reads.
>>>>>
>>>>> The example that follows in patch 4 uses both the scan_type and
>>>>> the scan_type_ext which is even more confusing.
>>>>>     
>>>>>> And they must implement the new callback
>>>>>> get_current_scan_type() to return the current scan type based on the
>>>>>> current state of the device.
>>>>>>
>>>>>> The buffer code is the only code in the IIO core code that is using the
>>>>>> scan_type field. This patch updates the buffer code to use the new
>>>>>> iio_channel_validate_scan_type() function to ensure it is returning the
>>>>>> correct scan type for the current state of the device when reading the
>>>>>> sysfs attributes. The buffer validation code is also update to validate
>>>>>> any additional scan types that are set in the scan_type_ext field. Part
>>>>>> of that code is refactored to a new function to avoid duplication.
>>>>>>
>>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>>> ---    
>>>>>     
>>>>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>>>>> index 19de573a944a..66f0b4c68f53 100644
>>>>>> --- a/include/linux/iio/iio.h
>>>>>> +++ b/include/linux/iio/iio.h
>>>>>> @@ -205,6 +205,9 @@ struct iio_scan_type {
>>>>>>   * @scan_index:		Monotonic index to give ordering in scans when read
>>>>>>   *			from a buffer.
>>>>>>   * @scan_type:		struct describing the scan type
>>>>>> + * @ext_scan_type:	Used in rare cases where there is more than one scan
>>>>>> + *			format for a channel. When this is used, omit scan_type.    
>>>>>
>>>>> Here is the disagreement with the patch description.
>>>>>     
>>>>>> + * @num_ext_scan_type:	Number of elements in ext_scan_type.
>>>>>>   * @info_mask_separate: What information is to be exported that is specific to
>>>>>>   *			this channel.
>>>>>>   * @info_mask_separate_available: What availability information is to be
>>>>>> @@ -256,6 +259,8 @@ struct iio_chan_spec {
>>>>>>  	unsigned long		address;
>>>>>>  	int			scan_index;
>>>>>>  	struct iio_scan_type scan_type;
>>>>>> +	const struct iio_scan_type *ext_scan_type;
>>>>>> +	unsigned int		num_ext_scan_type;    
>>>>>
>>>>> Let's make it explicit that you can't do both.
>>>>>
>>>>> 	union {
>>>>> 		struct iio_scan_type scan_type;
>>>>> 		struct {
>>>>> 			const struct iio_scan_type *ext_scan_type;
>>>>> 			unsigned int num_ext_scan_type;
>>>>> 		};
>>>>> 	};
>>>>> should work for that I think.
>>>>>
>>>>> However this is I think only used for validation. If that's the case
>>>>> do we care about values not in use?  Can we move the validation to
>>>>> be runtime if the get_current_scan_type() callback is used.    
>>>>
>>>> I like the suggestion of the union to use one or the other. But I'm not
>>>> sure I understand the comments about validation.
>>>>
>>>> If you are referring to iio_channel_validate_scan_type(), it only checks
>>>> for programmer error of realbits > storagebits, so it seems better to
>>>> keep it where it is to fail as early as possible.  
>>>
>>> That requires the possible scan masks to be listed here but there is
>>> nothing enforcing the callback returning one from here.  Maybe make it
>>> return an index instead?
>>>   
>>
>> Sorry, still not understanding what we are trying to catch here. Why
>> would the scan mask have any effect of checking if realbits > storagebits?
> Hmm. I seem to be failing to explain this!  

Maybe we are talking about two different things but calling them the same thing?

> Key is the complete lack of
> association between what is returned by the get_current_scan_type() callback
> and this ext_scan_type array.

Why would the caller of get_current_scan_type() need to know that the
returned value is associated with ext_scan_type?

> 
> So either:
> 1) Make it do so - easiest being to return an index into the array rather than
>    a possibly unrelated scan_type -

Unrelated to what?

> that would guarantee the scan_type returned
>    by the callback was one that has been validated.

Since all scan types are const data and not changed after the iio device
is registered, the validation done at registration seems sufficient to
me (validation happens in __iio_buffer_alloc_sysfs_and_mask()). All scan
types are validated at this time, including all ext_scan_types. So all
are guaranteed to be validated already when the get_current_scan_type
callback is called.

What other validation would need to be done later?

> or
> 2) Drop validation at initial probe because you are validating something
>    that is irrelevant to what actually gets returned later. Validate>    when the scan type is read back via get_current_scan_type()

The validation is just checking for programmer error, so it seems better
to catch that at probe where we are guaranteed to catch it for all scan
types. If the driver fails to probe, the programmer should notice this and
fix their mistake, but if we don't validate until later, the programmer
might not check every single configuration every time a change is made.

> 
> I prefer option 1.
>>
> 


