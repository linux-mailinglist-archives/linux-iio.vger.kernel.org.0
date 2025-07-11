Return-Path: <linux-iio+bounces-21590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194AEB02490
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 21:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257F41CA1600
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8D1E0DE8;
	Fri, 11 Jul 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ax1F4sYH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405E1DDA14
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262013; cv=none; b=l4+wWy3kNy4ynhIXsIoKKo3ZlcipVxKyJNrBAoW5JaEZd8K5TfAq1RQ0S5ZfKZCRjIn+ukNCw9GR4SrxCkwxozWPVPD7mLbvGLLXkAjAaiNldfSE+J2vKOZlvYiP6zPhe01bIGPd6pywUr/9R8n5aZI1pGlAwCaqpuV7EIdMQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262013; c=relaxed/simple;
	bh=or75oSC7xMtdvT+P19GwpFtw4cqH7zKdN1CT/MZeazE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwdxD7EFZhgEQJq4QhG2smvc6UBVJVv08YmmdOzW8+8o8vSf+UXAAuLHV6GaQOfOE+jHqHlPqhwfHOYwZCYHEGP9nUMMmu8zirG2ALTti5/vpoRFaA6/pmbQsOGHjsZQFqm6c0Huig4QzNXJ7VXPhvOrBZV6BpZORktOLy2d6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ax1F4sYH; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-73cdce0ee0eso635117a34.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752262011; x=1752866811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg5KK/+q76TeFP1WmDWWnvUUhRJ3sjg6NUPg6wHBI4M=;
        b=ax1F4sYHemk1QFgUuQ+iOolOkucOpAGJTMNMJG4Z6EJlhKOvBpDzasFBatMZFXACOO
         YsoEzlb+K+gmezfXc2twBYs4vzepY+FDW22RqaZYM0Cx9ZLP6KsUjCVGZMR7as7OOnWe
         +8EFWnX825EdQxDt9XrASEeibLjBu0YaM17UuGy6E7gAyqMYXEzUOZBn7jckgILRtUMK
         2gDJE6EwZ/M18iBgy0ALSjJI181pKpbqvDhcacQAa31HGH3n5JSvl6pjj7uAVESMvKSf
         JxsG4oegzOog0uhMRkCOz7HD2NCTm2TEOFP0JDqCCNVd94/SrS5q1WMtPAXuximJW9Cs
         DICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262011; x=1752866811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg5KK/+q76TeFP1WmDWWnvUUhRJ3sjg6NUPg6wHBI4M=;
        b=eRCV1Eyn8bUzBonJNUjF35HU4mnCo1V3CL4cgN1Ykdxykmy8dDMm9yxF4kEja3Q64g
         ot8cVDQ0cs8WvxJoEqpSUqr/TS3NwxS4XuBQoUM6u0hiwu+F++ANRFJIIkyPR7DAMGXg
         pYdaoQu5PoJppL7h4OjRkY4DW+fffB6qM9WJmu1QwUPO96MSQeDbXzlsjqTF4BjPEcFb
         wHdNgqXYtASf8Esga/zcuj2+LBFznn+//4zPA2RgpjvUOwTlkzTHSJ7YrgdvWLEMG8Xb
         b364C+4DmRIoGHxy3YLxrHR5Cq5zVOYhPkH9o5Mgnnq5FnLVoG64lJlg5l4TeYvaHGEQ
         vZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXotxM4iv12ijMZl2xE0M8FQJ3oOsoT0vDA7HWU/QWvFGpr03w0HET4qUktIh7OHodOusU1ldv2PrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpPRNLFwN7OnEwoggTl04XVDY8q2g5xdi0aLBJpzWi9GRuq0e
	p0xXxBftUDHvZmbrJk4Bysd3OM1jk1JCq2ijm4B/N87oF+tJLcv/3h7eVTu0Thq0YZR1lq6G+vH
	sDf7m1Xk=
X-Gm-Gg: ASbGnctD773KcLMXxe/9ULgTAhsCrL3rmek1bnUAzkbUPkDV0k4D99md/KxOwJzFTpS
	m/vjBVLY81KAbYauMSMdAQJBM35RGXyoQAOEwfW8E3ptpDrvfVSKgAvH/1Dvw8dF1Up44bVvceW
	J0ma6gv1MaMeQShBw3bLRdXJ0rukmylOCUpd2HUL/ArejHcihDSxcRcINtAxYT6UD2ZY9whYaMU
	Nca5A9V11qQgqN2OpGdEvnR8WEuprsmPzDyZukwgirls3LOv0Vopf29o9flFgTOkQmw40ofruTG
	ffBs7FDKyGMYa/6fdg7pV6AINIcNOww6oxX2Karsq1zsbS5xympXb3GLgGVEnFOy+zGA2RT5mql
	RVZLPSrAtfxxF2vpDU8XLB54DKfAdzGfd+LCAx1Zk/bQSjXm6prvHXacWjR3LIXSbvLEi3iGmj3
	OYL3+fKRD0Yw==
X-Google-Smtp-Source: AGHT+IF63+9rtWdtijRYzjxleW6K+ny1FT/Z8DWiyhU6MepE9QNVk1o1SpTs+aOdhgDvwKb6SLEKTg==
X-Received: by 2002:a05:6830:2588:b0:73c:c4a7:3852 with SMTP id 46e09a7af769-73cf9dd76dcmr3479598a34.3.1752262011367;
        Fri, 11 Jul 2025 12:26:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12a6961sm663016a34.56.2025.07.11.12.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:26:50 -0700 (PDT)
Message-ID: <27d969af-c856-4ea2-8666-fd5333c70420@baylibre.com>
Date: Fri, 11 Jul 2025 14:26:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
 <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
 <aHFO7LhWXOuglaoz@smile.fi.intel.com>
 <4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
 <aHFdCBGWDs-IRMTC@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aHFdCBGWDs-IRMTC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 1:50 PM, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 01:38:17PM -0500, David Lechner wrote:
>> On 7/11/25 12:50 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 11, 2025 at 12:04:03PM -0500, David Lechner wrote:
>>>> On 7/11/25 11:41 AM, Andy Shevchenko wrote:
>>>>> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:
> 
> ...
> 
>>>>>> +#include <asm/byteorder.h>
>>>>>
>>>>> Hmm... I see nothing about this change in the commit message.
>>>>
>>>> It is for __be16. I kind of assumed that would be obvious, but sure,
>>>> better to be explicit about it.
>>>
>>> Isn't it in types.h?
>>
>> No, only CPU-endian types are in types.h. The actual #define for
>>  __be16 is in include/uapi/linux/byteorder/big_endian.h.
> 
> Huh?!
> 
>> This is
>> included in one driver in staging, otherwise it is only included
>> in arch/*/include/uapi/asm/byteorder.h. And asm/byteorder.h is what
>> Jonathan used for similar in some of his recent IWYU patches as well,
>> so I assume that is the preferred way to do it.
> 
> include/uapi/linux/types.h:37:typedef __u16 __bitwise __be16;
> 

I see. I looked for #define first and found it so didn't go
looking for typedef. types.h it is.

