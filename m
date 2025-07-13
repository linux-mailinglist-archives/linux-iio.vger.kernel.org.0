Return-Path: <linux-iio+bounces-21628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F1DB03212
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 18:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E19189D1F2
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280DD27FD5A;
	Sun, 13 Jul 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m5YtDS05"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B75413B5A9
	for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752423988; cv=none; b=IzTa40X4Emm+QyOLoVGGeVNBfj0pUla+tm1grolH+dj2cISWKVjh0PrpYBftp5BON1VcJo1FvHTRNXnkE6J9xbsCBj9Hlpn+4tEQat85hNcEDlzTWu70O+07S18q24MCBKwX7gBNbdAJslfcVwBGnlqsbvHXKnSEejuRAx4fV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752423988; c=relaxed/simple;
	bh=gdH1NhlVyJQoDiHovHxKfjkCYcSWgtGDQu0pEOmHv2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgT3Wx1YxcZHqSdGX4GvbHvGkomzhglzGTtIjIIckr5gJ+zcFDj+x7bbEa+ELukYJTpDZ7fBJLvUxFHVebRv1xqfgc1yGT5EOlveA/YCG8gd7AuIBFh+J63D9XBYs0in6RJno+xytN3qR5P4ppjocPiRrJZctLIYD+wEmZTl8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=m5YtDS05; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40aef72f252so987872b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752423985; x=1753028785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzI8Vhw9vqqPgkEKPS/5cuWPR+iAIEM+7JG/QhQCQAM=;
        b=m5YtDS05IDKIhkipG1O827AISb40k6BEGhM2zUok2vf56fmFiIJeLhAoP1o8isrhzf
         AOFqtx+1JbLf31Wgd4bp+esdGOzzw042ekK0lfw/X/bF+cq0DoyoXGdeBqlOqzJ3bEJq
         8uA8TAfTha1+j6CCQd+rSWfzwuUsd92XvibMhKaoHhItInUiJMf8iOHbbVtddP2u1JbL
         PkflIGFGAcJczQCXLzaUtmQLQLdDi075s2Gg5lx51Rr4rDCS93HBJoZu2eAQ6s5cOL/T
         n+/GCWWVwGkhlCiZSoDxi7XbjfsFfS270TNatQAXxwUrAyLTg5Ie3Mz+VEFjkOoQb6Ze
         JGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752423985; x=1753028785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzI8Vhw9vqqPgkEKPS/5cuWPR+iAIEM+7JG/QhQCQAM=;
        b=Ts4xilWuDZVyQnMkyLrJfW6+gmmYUGeCCBEUOf29olOHCrCKPF+2WOCgTLmimnUfJy
         uIH1zSmncmTLjw+nJEG0WXSnaB2Z7wgJbsUkJOruszEZSPTByBamvHfkR9+rawqOkoeW
         03oT33/UbQ/KGTUcrXAeAViXxIOoIAPMTO9oy9g/56QoY2PH4kzNiaMrUcK2GgNtOs4o
         nL8dXHlCx8t1V7pTxuCHCUeBflCRHqHp2xBxMLXeY64pLNOiqdwFkEBJuedaOMrUWgzj
         oOrahmu7yTBGxFgAdRiJjFOJG1M0uYaGx8nrkYFJBJI9JdDnBeOUyEKzgZDXEvTVT9fG
         b6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVksaZswCEXE1wGBa0FK3PETw+v5mWRIpFp9oZeGDLzTBODunOWpzacW/XK0ituDEG53BNPrVlcEq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwNyI3g4P2zngTC7pI7OY2EcCzo36XNITNN+QO7x8g1npvY2Q
	o+thzfNLPoIozGvwt9vSyVh14UPBGDpVCyIZL3B/2lzlxD0vA7oYXvEmP9GXqP98VPo=
X-Gm-Gg: ASbGncujzA0CixgfcfbZ25p83DWWPyXPz66b6TqURg1DqLFH0RX2HAuKvSoxdz0DrXd
	Mp2eXZbfNYtmvyhZ8BNtw5XLXBsppENE2IEDs27KLDad38XqjTS2Fl1L8o5H4N1gnYrj8Al1rYc
	mgNJA/VHABpciT5H6W5tCaNd5Op2wZYa8Ql5qSI9alt9N5xWF5Bh6q2Ymg/j1L8+dlU3vXkoLss
	rRd90PBMhwsI0yyUbZBJgI3StUBtCGxz80YCePz6wBBxJykfT5eBgqWh2JddLlmDbv9S8v1wJ2b
	jDSrVAYPNoKHNg1YNnc0RIesT51+ZcWfeHsGcsAPmDaBeQPtB4/lIE6ODQSDRjqAmik85LPsL07
	2ojvOjiSPsyFPcN780xvBtghhSH0EkEJ09RCOrL7Y+fJYBxKwqFdiVWYgLX4jMqNntJEWqVHh5r
	Hev6Ut+gzi2w==
X-Google-Smtp-Source: AGHT+IGlbvM1Jo3S8RFj5ooqLLSylsq/8snbmxIY+6ky8Rp3oSbQLcuv4W3bSjHwG0JMyNf40vQ0Yw==
X-Received: by 2002:a05:6808:518f:b0:40b:315b:3775 with SMTP id 5614622812f47-4150ff89898mr7685880b6e.34.1752423985483;
        Sun, 13 Jul 2025 09:26:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3743:cf82:e4e8:b2b9? ([2600:8803:e7e4:1d00:3743:cf82:e4e8:b2b9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f00d46sm915665eaf.22.2025.07.13.09.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 09:26:24 -0700 (PDT)
Message-ID: <8b822cda-6bf8-41b1-bb08-f52e2f0b88f1@baylibre.com>
Date: Sun, 13 Jul 2025 11:26:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
 <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
 <aHFO7LhWXOuglaoz@smile.fi.intel.com>
 <4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
 <20250713151017.28b9d162@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250713151017.28b9d162@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/25 9:10 AM, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 13:38:17 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/11/25 12:50 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 11, 2025 at 12:04:03PM -0500, David Lechner wrote:  
>>>> On 7/11/25 11:41 AM, Andy Shevchenko wrote:  
>>>>> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:  
>>>
>>> ...
>>>   
>>>>>> +#include <asm/byteorder.h>  
>>>>>
>>>>> Hmm... I see nothing about this change in the commit message.  
>>>>
>>>> It is for __be16. I kind of assumed that would be obvious, but sure,
>>>> better to be explicit about it.  
>>>
>>> Isn't it in types.h?
>>>   
>>
>> No, only CPU-endian types are in types.h. The actual #define for
>>  __be16 is in include/uapi/linux/byteorder/big_endian.h. This is
>> included in one driver in staging, otherwise it is only included
>> in arch/*/include/uapi/asm/byteorder.h. And asm/byteorder.h is what
>> Jonathan used for similar in some of his recent IWYU patches as well,
>> so I assume that is the preferred way to do it.
>>
> Never trust me :)  I may have been after be16_to_cpu() or similar
> though rather than the type. Can't remember. When I get back to those
> I'll take a look at the logs.
> 
> 

Yes, you used asm/byteorder for le16_to_cpup() then I (incorrectly)
made the leap that e.g. __le16 would come from there as well.


