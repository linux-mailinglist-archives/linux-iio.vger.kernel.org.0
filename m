Return-Path: <linux-iio+bounces-22986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD48B2C6BB
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 16:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7463C18979AD
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7723909F;
	Tue, 19 Aug 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FnHNivYE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C420DD52
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612927; cv=none; b=LCFri1/0cS+tphhm4pTNOXe61URjNa2eNi8xvljcjApwPt3Y6n5wrjoxOgXsnXe8tChijoqUHJD4wV+bsxMrVFUY57hfx7Gx1OofYy+OPj8x+rGFohRJOzRN1QLKM3P8SYmhiwV3ZsECGHnbDG2YGqqDO4cRsx8eKz+vR6mBR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612927; c=relaxed/simple;
	bh=E91A0EvBQGwTzDoV07eJuCoxJjwmCa8uGCWrOxeGhdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pDFmvqAr2SZiZfHaQL/6dtWI2Ij9ye8X8YntQwPalkCKmwgRCK90+dBZYQjL5T4xRX/sUvrMxIAl0CJndI5g76g/LomSL0wrjy/8jN10kO7ivYEb2OK/aQ6aaOtaD1eUazQgdzgmMf4tLUtxHw5Elz095d4SbGnRoL6meA3gDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FnHNivYE; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce534a91so2014892fac.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755612925; x=1756217725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6iJgXIyjoxyQaOeBIKWzkn4AAW3hsDkELpNRI4OWlq8=;
        b=FnHNivYE1FDnpTbo8xLF9Off5ZfZUFb294LvL/yvxW/WwTdQRDRhiiJ9+8OfqE8OpT
         Kw38xzrMVZDjUh3uq12WtgOt2BGIOMGFrY5YDFmewjnTY3eaLwPkU5AxO94aZRJifUmo
         UtDL9b2qyGqnrrsrD/BdwmKW/ar92p6xCmuoGa/cNrcEl+OVJRA/hitCW553mptKseVV
         oUymiKFyMIU97+gzeZ7WI5V7L5V+AA++QkwGfzWqYiZqcvVBcTKPlj5qT73iC7218nvt
         fetzBkMJRIcF7qSe58rvJgSwIkxVDxSUs+Y65H3AozZ/B4rCRKXqicJuOVjttyLg5+6I
         GS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612925; x=1756217725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iJgXIyjoxyQaOeBIKWzkn4AAW3hsDkELpNRI4OWlq8=;
        b=XqGPgCc2nS8gxGR0WFUWEjpJAgiykC4NApLT8ATHTEgSZndNXtehntB486l4vQiHWA
         cGNRl7f80tvC8ByyAE82wTrnMmOmmAaEqDEN/ttJJws1hKFfDM8kcVUUAZMMtYvOykMW
         dD7YDyumoSivnlw090UHDXj6NsuSnfYMj89+34Jz9JJWo6TDZficw7jrV2HZDqpa41Es
         0IH/7GxjgBCXwEbQ7mxEf3n6iK6FFX3x/h3OlomT92oc+J9uR2qNHDpgdtUY3UN3bndZ
         yTY8wbaf+ebvk0azGi7uJf9V2TgF3m5Gwma8jOCcaE4zRJw9KCRRKN+IorqsKHuuBXVb
         D3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXdGxshbC7bwfwy64+DTKll0OlbSp2kb6JxsEMhOIBqo5DhcPr31xm1pCf0PaQ18S+bKJShRGsmTWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwuWf20i4nY1M6+8lwCSCSbGvmfd2hTFC2MEEwpqKSOy3QY6i
	2klFKnqd0/us6+XSW9jiAQSo++YWkKGtiMESHDj9ohr7hwdyFN/Xya0QZnsp7kHhYko=
X-Gm-Gg: ASbGnctC6t8U/CMRMRNUbgY4y/cVJym3O49E8uUB4YP+L/Uu4n4CbdTvggQNtKQM+TL
	a8RtVpMeA9J0IMnH1GQZxHApkC598ip+HFpcalr4kA4+I7FTLZsag7n2k4cvvB79/YQHinXbPnL
	OK4sHf6dhfXIPOY1F27LmFvxgNDsrt81tkY0wSb2xuvT/QSoHrQ+zIomCyhZ8WNP8im9/hplRAg
	P6hFS5jQIzjqzCelzOOiagJ0Yir8Ao2peFObAtbpVvkDl1cZYybnK74FPZJfUvWKdDQk4zalhTI
	wvKnQxcw9o6VmfHlPlAegjkP9OcBdQ3QlAPy3yFc5mt4Lz0RrMaFK/V07CkBGka+Qz/TlUDqGPY
	YNViBSe2oJCunlWe6hGOZ/CEkfhkxwmlrZPMtfNea7/MvwlERlGfpjOQTLAGgSAkeUDSpT/6T1/
	KztcihsVg6xg==
X-Google-Smtp-Source: AGHT+IEt6dwsX4DtUvqC7sEljEdquQSqUldMPbdUrFmoYm8as/bmWB3i+egN0ftcqMAL3gZVqjC+cQ==
X-Received: by 2002:a05:6871:a1d1:b0:307:bfe5:481e with SMTP id 586e51a60fabf-3110c4bc7a6mr2132053fac.27.1755612925043;
        Tue, 19 Aug 2025 07:15:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbb4463sm3480511fac.29.2025.08.19.07.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:15:24 -0700 (PDT)
Message-ID: <f7292e8d-ac7f-43af-b77a-7a1ad8403962@baylibre.com>
Date: Tue, 19 Aug 2025 09:15:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-7-bcollins@kernel.org>
 <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
 <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 9:11 AM, Ben Collins wrote:
> On Tue, Aug 19, 2025 at 09:05:39AM -0500, David Lechner wrote:
>> On 8/18/25 1:32 PM, Ben Collins wrote:
>>> From: Ben Collins <bcollins@watter.com>
>>>
>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>> to allow get/set of this value.
>>>
>>> Use a filter_type[none, ema] for enabling the IIR filter.
>>>
>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>> ---
>>> +		if (data->filter_level == 0)
>>> +			return -EINVAL;
>>
>> To implement Jonathan's request from v5, drop this error return.
>> We'll also need a separate bool data->is_filter_enabled field so
>> that we can keep the last set filter_level even when the filter
>> is disabled. (i.e. data->filter_level is never == 0).
>>
>> This way, if you set the filter level, you can enable and disable
>> the filter via filter_type and still have the same filter level.
>>
> 
> Thanks, David. This is exactly what I've implemented, plus the
> filter_enable attribute.
> 
> Adding the ABI doc updates as well.
> 


Don't add the filter_enable attribute. The filter_type attribute
already does the job.


