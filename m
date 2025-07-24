Return-Path: <linux-iio+bounces-21998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B17EB11124
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 20:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42FF173A53
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 18:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6BC214811;
	Thu, 24 Jul 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Csu6nQln"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C24214204
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383005; cv=none; b=fXOHUgvQkxaViMNIwn0d1ofdJoh1AlktAHv56xIsJB6Hnyb0GmxW4Qbdd6eTO4DJ+rLHDha9ZYHRdkT896aVR/aMYm+WNZxDs2JwwEbHrngY5aa89jW7aOqQAByA+3lUhRNw40uqAxU+v2azJWbZn2qriN17NV9asW5T2rcPy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383005; c=relaxed/simple;
	bh=G5C4mzPGDXF5x9ODvBwjqri/9D9M0K4qppMDG0Q1Ugs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaJjTz49KQ3f1wkjJeLitg4NOeMbUjD3bvvAiA+YqQllenB538J1S/ysC9Gcrsxw7fQXfdb7yDSPympK1C7brwbOaSjeRJXGqn4W7w7n4/45jhBap6k7CKF4mgGvMRz3WHjB+rqP6gafohW1YUpwJW1ZBt1mbjokU1Nrk9EoEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Csu6nQln; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73e82d2ec21so684325a34.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753383003; x=1753987803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDGAiR/MF/7h8+9i+INY+MYAQGP+1TEqMmWynuyvVC0=;
        b=Csu6nQln9l1nGR7ViAakCsVgxB8DHSLIKww2OQ3jr0hG5MBVqA0bAOm9ao28uC2X6h
         ptj2fg57PsueR5BrvWC6nb3xPEE8RfkRJ5zZi3k+ZalgXLEsKGRzF2+7LDDTkGqz8+UO
         HumFPjVIYlkgZ8ZcS5nuO1aWuGpV3WPyxUT1O9uzc/V90fuvGy552auneJ1GoqyhxNpo
         EAw4I2QZNW/6PAJCpV3Dc/VayfzdutX6uy9t8uJMFQWTFrV0rShAjdCk2495shFAxz4B
         E2F65p1E+It6GdwgztAz1SlJw3ER4b/+31WAc3RiBoasoyS4CdwZWXKjxFcubN4y6u/8
         k0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383003; x=1753987803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDGAiR/MF/7h8+9i+INY+MYAQGP+1TEqMmWynuyvVC0=;
        b=rhweP7Kyb37BL73Ti4ioz86FFiO0XVvmUiInGJerQ2AqNWewlZ8nzWOzoqrRAhgJ1J
         3NcqbSWtCt4I+90K9sTButW8+JSvk6T80etcWaLXb1bd1ED/Ds4QXOhSBILwwavENRqa
         Vc2WBOEvt0O5bqRvg1GdlfsmFNw2LAoxvA9/4ObJhzX00fjyob2vivRqLIgz2A6zPo8c
         rr9M4z8lOeSB/nA0cxV4SliZ6P56tYKx0MeJROVHg05Z1RQq31frQeXnuL4xwPpNLaaF
         JCHHtDLBXLGcf9T0b3gm2HCTGZGE7ucT82W3itZ9ljYYcwNLMOirWHF3t89Y41PMDkqQ
         LAAA==
X-Forwarded-Encrypted: i=1; AJvYcCViARwGUt5b3x3yeqQ8BckyuWHLdIH6QLOCdO57f6TIfnfKbraBb/S20fdMFJWd0RU4HI42uBom4Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFM2o34jlAQl93Skwx6ThIp/qZEe9RNMJxdVdLnVhJlXO4IKsS
	McrIahkIwzzYy51fwDLArNLwfSCzLTtn8/aBQljPH0H1FpY814v8O2HaOi+huFTcu1M=
X-Gm-Gg: ASbGnctp1mILFQ3G++puPKB9U1x8+WMcBAZN59slXPRinTzohbkjOvBHlvPiHer5Zrl
	PybfbcjOrM7jpmHoBWzRunfWWVg8KRcDyeraj0nelrHVxaQICSUQbmuCrCO6B988UCP0FZlTHtV
	FPTJlZnORgZT+tp39H/PQoS2U7qZLfz+72TwatfFNj/xdd4KiwosnWtsIO95PiZ4d9fvZczkoa/
	e1Rz4GRgX9WBSeTSZs57J2mKhT1LZFcnetyNz8c9E5zugnlJ7RqV1ncMnbW0f+uz01obfSSggYY
	Oqek1v9txqrmt30bG2ocw3oGYdNiHIz7u5AHwzaA/nu+BG7iA/4MJyNm+YuAGB/If/5V2ryVojo
	7YdWIcBJVTnG40eTQcd2dZXIR3RNOGmm1B9zpsZ1m7od+WCjihXi1HkGXx5dMrRBSZDPci4XOKn
	Q=
X-Google-Smtp-Source: AGHT+IF2VA3qRZNatjMoZ+7jjHwZ+ikWklknaE6t8u9/hB8gztHVQ2WFyh7bE/ctVaAXwSWngvbs3w==
X-Received: by 2002:a05:6830:4d95:b0:741:21b8:b247 with SMTP id 46e09a7af769-74121b8b848mr3838706a34.12.1753383002846;
        Thu, 24 Jul 2025 11:50:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9829:e9f9:e475:a206? ([2600:8803:e7e4:1d00:9829:e9f9:e475:a206])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7412d31acf6sm348944a34.52.2025.07.24.11.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:50:02 -0700 (PDT)
Message-ID: <fe3f5832-469b-4d8b-9d02-ea716c07c5d9@baylibre.com>
Date: Thu, 24 Jul 2025 13:50:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] iio: adc: ad7137: add filter support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
 <29786806-6495-4423-9172-e924c60b93d6@baylibre.com>
 <20250724142001.72181c21@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250724142001.72181c21@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 8:20 AM, Jonathan Cameron wrote:
> On Thu, 10 Jul 2025 17:47:14 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/10/25 5:39 PM, David Lechner wrote:
>>> Adding yet another feature to the ad7173 driver, this time,
>>> filter support.
>>>
>>> There are a couple of leading patches to rename some stuff to minimize
>>> the diff in the main patch where filter support is actually added. And
>>> there is a bonus patch to clean up the ABI docs for filter_type first
>>> before adding the new filter types introduced in this series.
>>>
>>> This was tested on the EVAL-AD7173-8ARDZ evaluation board.
>>>
>>> This series depends on a bunch of fixes, so we'll have to wait for
>>> those to make it back into iio/testing before we can merge this
>>> series. There is also an outstanding patch to add SPI offload support
>>> to this driver, but that doesn't actually have any merge conflicts
>>> with this series, so they can be applied in any order.
>>>
>>> ---
>>> David Lechner (5):
>>>       iio: adc: ad7173: rename ad7173_chan_spec_ext_info
>>>       iio: adc: ad7173: rename odr field
>>>       iio: adc: ad7173: support changing filter type
>>>       iio: ABI: alphabetize filter types
>>>       iio: ABI: add filter types for ad7173
>>>   
>> I don't know why, but I really struggle to write this part number
>> correctly. The subject of this cover letter is wrong, but at least
>> I got it right in all of the patch subject lines.
>>
> 
> Series look good to me. Give me a poke if it looks like I've forgotten
> to pick this up after the precursor fix is in my tree.
> 
> Jonathan

Sure, no problem. Can we pick up PATCH 4/5 ("iio: ABI: alphabetize
filter types") sooner though? I know there is at least one other
series under review that is adding more filter types and I am
getting ready to start on another one that will likely introduce
some more variants.

