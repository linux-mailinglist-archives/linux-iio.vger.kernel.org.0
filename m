Return-Path: <linux-iio+bounces-5270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9D8CE854
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25ECB216A5
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A212E1E0;
	Fri, 24 May 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S6kZt8fg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A51126F04
	for <linux-iio@vger.kernel.org>; Fri, 24 May 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566221; cv=none; b=dDNNSji3XTImet1BV9Lm4cPt1/RHzdcXYRGiTLpN8TPgKfy2OmBizsl3Pj2Cq12pkT64vrM0UkgiG8fFsGqs4nvR0maqsUacH0f1UN8OlggcwvX/sViVId8hK8DD7s5Mmj2bi756P2EXCcl61+ZcblXZ0M/CdEjzGIb8y7Z/tOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566221; c=relaxed/simple;
	bh=f/jxpUwz/FQOHV/5vg4nxEyI+NJdfbQEy5Bdkdr5fys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqLZTT10KoAf9txSX83edsYVsB7mMQF6M3Nw28gKLpxcbbVpxBztKcydyQkguknUUURM71uuaTLmJVkRpKAY+ZkHA5JWihRsL+/v7axCPV+butAUE0gKLM0tGdHZLM7BEaugRSideWgNy3c6qDpRxLgwGL5cWqDhMfAu/7zkFA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S6kZt8fg; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b2a66dce8fso5439660eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 24 May 2024 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716566217; x=1717171017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAHpfkkCR92bCHuVeFb4Gd0c4Ft15svLHWynuFWFQ0Y=;
        b=S6kZt8fgs8xTEX5bf8nZrzMLr59wmtxWO0bsiq+JoAjaMZBFU2MLZ9C9yqreLPla0r
         QBG6c1tns8AN4wqjI8Fh+Io8Zx8fphvDAGyyfQ6nByL6LkXCp4x+M80fthzNqDtYsd+5
         1UbMOf9XJAXOR+mgKQeSweJMoQRglxx4X1EPLs1I+y9XqEHleBdOQ+e9OYb6QO+D4hqg
         JBK9vzumjlkjxWiMNjgFcTNXIQSoyKpargtO9uK3m1g/plMopiDqRU/BSlH2DMT23hOA
         RnZSvHml85Se1N8eQRHA2dHw0xCsXCJbDLgwMThP+ndfUOsCwkHSkgmZNqgN/Ys8dQTY
         oMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716566217; x=1717171017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAHpfkkCR92bCHuVeFb4Gd0c4Ft15svLHWynuFWFQ0Y=;
        b=qeNn5ayhmjL6g2arz2A14b0jK7wFCqbaMgDNGcN5ov4T5c0CqF/Xt25RdhmemrjFux
         QaDUOsf6KcO/UZYf3o6sf6M+U/0pRYisdT5Lr2ByHGhNjwZh/EFnHWEYL8dvrzs3D2w2
         jlv/up4XZCwH9/ByEtvCBhPCgH+360mpeg02qrWPsvINNaY70zC/4wIJ9c2cq3BxVE1z
         z/kGKusvl2Ypw21nb6gOTlqXIMFtvQcZSyOqVhxwby0zqAMInzdF6zlhbNVXHtxJxOKq
         KIUf+NkJjkGR/1IGvSIlAGDySlvExvl6PB2ApUXTOyjbaTnlOTNuRm022e8leqsW71DC
         DxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSo6nhaldgYDOZPl2U5qO4Ob25++qOjJ9L32fiRVkWdv3dfJF6ztxnMdCuKjOJtDkCRtz9E+mLxTPgQUOj12E3v5t0rPG1na9m
X-Gm-Message-State: AOJu0YxaeGm27uI2/7k+GGFmuy5PPiAwFRCM0NeqdHMB2diuwrYVlkT+
	aKcn+/B7grjxowW94QDC4TohGru2ua2/5bHK6tQmZQjthP5bJm5m/zzaihsW17s=
X-Google-Smtp-Source: AGHT+IFE4xFCp4W7Db3D88pPozUhIjZLpDcQGWfRPtJqKqzBQzuSuQ51HXr5tiQ4YwalghgOOYGSbQ==
X-Received: by 2002:a05:6820:1606:b0:5b2:72e5:c12d with SMTP id 006d021491bc7-5b961b5dda1mr3688565eaf.5.1716566216830;
        Fri, 24 May 2024 08:56:56 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c699953sm358875eaf.31.2024.05.24.08.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:56:56 -0700 (PDT)
Message-ID: <5cf036d5-1eb3-4f63-82f9-d01b79b7fe47@baylibre.com>
Date: Fri, 24 May 2024 10:56:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] iio: add support for multiple scan types per
 channel
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
 <20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
 <20240519201241.7c60abac@jic23-huawei>
 <ebf18ed1-a82f-4c0a-9a63-2c428b5aee40@baylibre.com>
 <20240520171205.000035b0@Huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240520171205.000035b0@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 11:12 AM, Jonathan Cameron wrote:
> On Mon, 20 May 2024 08:51:52 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 5/19/24 2:12 PM, Jonathan Cameron wrote:
>>> On Tue,  7 May 2024 14:02:07 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>   
>>>> This adds new fields to the iio_channel structure to support multiple
>>>> scan types per channel. This is useful for devices that support multiple
>>>> resolution modes or other modes that require different data formats of
>>>> the raw data.
>>>>
>>>> To make use of this, drivers can still use the old scan_type field for
>>>> the "default" scan type and use the new scan_type_ext field for any
>>>> additional scan types.  
>>>
>>> Comment inline says that you should commit scan_type if scan_type_ext
>>> is provided.  That makes sense to me rather that a default no one reads.
>>>
>>> The example that follows in patch 4 uses both the scan_type and
>>> the scan_type_ext which is even more confusing.
>>>   
>>>> And they must implement the new callback
>>>> get_current_scan_type() to return the current scan type based on the
>>>> current state of the device.
>>>>
>>>> The buffer code is the only code in the IIO core code that is using the
>>>> scan_type field. This patch updates the buffer code to use the new
>>>> iio_channel_validate_scan_type() function to ensure it is returning the
>>>> correct scan type for the current state of the device when reading the
>>>> sysfs attributes. The buffer validation code is also update to validate
>>>> any additional scan types that are set in the scan_type_ext field. Part
>>>> of that code is refactored to a new function to avoid duplication.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> ---  
>>>   
>>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>>> index 19de573a944a..66f0b4c68f53 100644
>>>> --- a/include/linux/iio/iio.h
>>>> +++ b/include/linux/iio/iio.h
>>>> @@ -205,6 +205,9 @@ struct iio_scan_type {
>>>>   * @scan_index:		Monotonic index to give ordering in scans when read
>>>>   *			from a buffer.
>>>>   * @scan_type:		struct describing the scan type
>>>> + * @ext_scan_type:	Used in rare cases where there is more than one scan
>>>> + *			format for a channel. When this is used, omit scan_type.  
>>>
>>> Here is the disagreement with the patch description.
>>>   
>>>> + * @num_ext_scan_type:	Number of elements in ext_scan_type.
>>>>   * @info_mask_separate: What information is to be exported that is specific to
>>>>   *			this channel.
>>>>   * @info_mask_separate_available: What availability information is to be
>>>> @@ -256,6 +259,8 @@ struct iio_chan_spec {
>>>>  	unsigned long		address;
>>>>  	int			scan_index;
>>>>  	struct iio_scan_type scan_type;
>>>> +	const struct iio_scan_type *ext_scan_type;
>>>> +	unsigned int		num_ext_scan_type;  
>>>
>>> Let's make it explicit that you can't do both.
>>>
>>> 	union {
>>> 		struct iio_scan_type scan_type;
>>> 		struct {
>>> 			const struct iio_scan_type *ext_scan_type;
>>> 			unsigned int num_ext_scan_type;
>>> 		};
>>> 	};
>>> should work for that I think.
>>>
>>> However this is I think only used for validation. If that's the case
>>> do we care about values not in use?  Can we move the validation to
>>> be runtime if the get_current_scan_type() callback is used.  
>>
>> I like the suggestion of the union to use one or the other. But I'm not
>> sure I understand the comments about validation.
>>
>> If you are referring to iio_channel_validate_scan_type(), it only checks
>> for programmer error of realbits > storagebits, so it seems better to
>> keep it where it is to fail as early as possible.
> 
> That requires the possible scan masks to be listed here but there is
> nothing enforcing the callback returning one from here.  Maybe make it
> return an index instead?
> 

Sorry, still not understanding what we are trying to catch here. Why
would the scan mask have any effect of checking if realbits > storagebits?


