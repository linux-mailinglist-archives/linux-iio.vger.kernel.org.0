Return-Path: <linux-iio+bounces-21546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC7B00C1B
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 21:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EA25C4EF2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B302F0C64;
	Thu, 10 Jul 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wUucJpP9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350742741C6
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175722; cv=none; b=f+0P2Otz/uKZloQ89dGw89qfhcnLS8tngrljcHrt497ibY2++l3d2YGhp2EkTUlKFf5w5i1yTHOOnqWq5U/oD26F8JQxupSggINAC0M+tSNdWSkMebsXHm1Njbj0JkvUsjG54fveVyEWt/3HjMtOcL1EMDdUMd3XxNkocY2n/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175722; c=relaxed/simple;
	bh=MT7ARmMygMbdpWskLAwrOjSVM4v0Zx7PKH/zOfxM8i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPEm34yRYDxG/AOytADExpmNTrec8uXnYgVkABjoESYFNsDtpJ5FhadUiC/JoF+oOIHBJHwoj9pPXogV7mb59bElI6Ox6kdTWYRi8eQfJUpXSez7CFQ4vyw1Vi/8sOlphtB/l1+86zei61yJPZvolUei/zoTQbsn7GApgc8DFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wUucJpP9; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40ba3c10b3bso490043b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752175716; x=1752780516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IFO8LE4ZMmLZJQRob9IaL309a+Oj/RCVEFAUClUxUE=;
        b=wUucJpP9NWLf2Lminikskhf8/h1shq3ZfbBzOouxzoGwzr6IdU4+nru51HWPEY+iBP
         uOd84wbvthPSlew/ZnUtR704lQkJa1d1Lzup2QHztdHOsRntR2h12MtzQCFIE9VxAJRJ
         AKsUwQoZA0rdGXO9QM+t/yDrmxzCThoZKEqCdjvC/oeeg8948e/NGhox1TIdn4Zk1uoB
         YNcgoSsKmk8bjW9LipDpYE8mk+Rf0K9wCTKtvF37VJg8/a4MvaaBYoVDxSHRc7QTzY5W
         obA6dBhdKURVz83pkg9eN6sjSlF7XKjGJ9M7VAcID/jbAuyA9Gl7fTgR4ND7sQTI1YOk
         WAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752175716; x=1752780516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IFO8LE4ZMmLZJQRob9IaL309a+Oj/RCVEFAUClUxUE=;
        b=T6VEn1aiu58BepxYk+xsLCPFzIE5Epk6sezJPQ5x+H0K3s4Rgcs1FE9o5uDXKQCQG3
         UjVd9cmyCcC/ndCAo0yzp/dzeGX1u+wRB5IErFqGTlzxgi21gzRl/YPE5Y8MxYdUL61K
         Fi5yt6L8A4nXE2jculqW5nCqv5jBEO4SQTRYpTwMq/9N9u7yKcnQ6eXGXNnUkTPOdmtt
         srevGIkH/1ofe7sLVOESvutSE95zZIp0SKhZHdpIjiQIUas4rI23q2HtCOrczoio1TS+
         mwjVXCcro6wmnnm1hSTE4K5xmfN1Pj05PwQalBcSQQky7AoELNn/rbc97bSqRKn4QNc1
         eGUQ==
X-Gm-Message-State: AOJu0Yw9IupJYV+3/l17hdoPqOAZY9zOjfibJy4xSmXmomBBqY0D9+LM
	IzOikxX6jDL7lum4TI7HwKD18HBTw0upIWutYvAZUtDK9OG+VUMg2uqS1Uraj8mQVv8=
X-Gm-Gg: ASbGncsT5e9TpxnHFYBaJ7rq8rF1mNUvm01jkztLyC6R0KFSe3fQctMVy2WPTtBqzyo
	urOtpkR4lmO+Ho8noB02U/8UIZNa9kPyFcMNVchPZwnREs5QQcOXOZslvxsu5qCMqCfyuR4+zFs
	SWSm4/w9dpxWbf4rSXgnN7IatXyyDb8wVT3YyyLblRbKqV8sQgwjnkhVn6NH6Fi1iDFj20WsEMH
	KdYmTkBJV7c6fLVCH922paJuLoph3Xn/g0Al/rgJ/PwOPrPu0JK/g5dozFgWgI2wr+At3NJzdxN
	8nW1ngHIm2CnlUPQhfSXV/zc8VJb4oZFE7CLcIwEYQtbonfo8EOkIkxOZknC9MkdamSx7dZ+FMY
	EWIKTwJhNxdx0YhW5DP0vE8sZwb39v43M8JcLCB+/jwLMBpPA8UU18m1l/LPx551222yvnglnIF
	DbhPPzOfpp4g==
X-Google-Smtp-Source: AGHT+IGmb8m8dMOuKESRSXGrD9qmNAJUqNNdJvNj7+xgQgnUYplcgJ9j68WeViPxvM+0dj8Y1hveRw==
X-Received: by 2002:a05:6808:4fc9:b0:40b:4230:3881 with SMTP id 5614622812f47-4150d645bd4mr609516b6e.7.1752175716029;
        Thu, 10 Jul 2025 12:28:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7? ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12a4bb8sm304952a34.45.2025.07.10.12.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 12:28:34 -0700 (PDT)
Message-ID: <d6e000ac-2967-4784-b3c2-2be7939321b7@baylibre.com>
Date: Thu, 10 Jul 2025 14:28:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] IIO: More application of IWYU principles to includes.
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Denis Ciocca <denis.ciocca@st.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250710171107.443790-1-jic23@kernel.org>
 <aHAP0rr1VQX8hWC9@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aHAP0rr1VQX8hWC9@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 2:09 PM, Andy Shevchenko wrote:
> On Thu, Jul 10, 2025 at 06:11:00PM +0100, Jonathan Cameron wrote:
>>
>> I decided to look at a slightly larger set to continue trying to come
>> up with consistent rules (for IIO anyway) on what we want to include
>> direclty and what assumptions we can make about a header always including
>> another.
>>
>> As the series goes on reduce the amount of info on particular choices made
>> just because the commit descriptions were getting very long.
>>
>> A few open questions.
>> - linux/stddef.h - do we want to included this directly?
> 
> Only if not types.h included.
> 
>> - linux/types.h - do we want to include this directly?
> 
> Yes.

Agree. It's rare, but I've had compile failures in some cases if this
was missing.

> 
>> - linux/dev_printk.h - include even if device.h is needed for other reasons
>>   or rely on that as a grouping header if present and only use dev_printk
>>   where we don't need device.h.
> 
> I slightly tend to include both as strictly speaking the dev_printk.h should be
> device/printk.h, but that boat already sailed long time ago...

+1 for not having conditional rules. Just include both.

So I would do the same for linux/stddef.h. Either always include it or
always use linux/types.h instead. It just makes things simpler to not have
special cases.

> 
>> I'll share a refreshed IWYU config once we come to firmer conclusions
>> on the various choices.  I haven't yet figured out now to not include
>> anything at all for things like CONFIG*
> 
> PAGE_SIZE is in asm/page.h.
> 


