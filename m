Return-Path: <linux-iio+bounces-13935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974EA02A32
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 16:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C357A3A5856
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE313775E;
	Mon,  6 Jan 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3XsdwzlW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E160B86328
	for <linux-iio@vger.kernel.org>; Mon,  6 Jan 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177381; cv=none; b=FndhLUDPaRosJu9RbpsAYBIJTUAuftO1GeY+m6fScTTU5gHvut4FHoQ71PdM3GohnZ0KZSXrlNrcMq/9V6yj4Fv2+IECOmjkZxAP0DM6DhXnmotn3ts1b2aMWAIs+zYbLLNLHGUW1EPupq6hR3jpPQO+qHXurrQqBs/PlT7YkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177381; c=relaxed/simple;
	bh=x1w5/nJ9YfXQS4K6kMmdZYANpOa0hZaPXucXYRkx+jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxZrykgCdmb8icr9MvvD1KHszFO96bCSn/1DuvNyY9j7JvP1o9GHWepHenP76gVmQVd4nDUDUIHkeFFLnHMkRmTjA8F2HMJZLKMiJkijtuxqoBeaNjQeJi1dmZQODUs91QIU8iJnwZzwvkRdoCwfbeWQL50TleQOOhT4wabwoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3XsdwzlW; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f340d6db09so6213307eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Jan 2025 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736177378; x=1736782178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAND/sZPrYBsHz6UX5BJ7O5mUoHwQEQe92spT2hfYWQ=;
        b=3XsdwzlW67qlKfSbS9ZkTcMF8RrtwyUJ6IK0kyB8pJbBu1wqb0xUdgVOLWZVURpqJ5
         CTQxzSoDRA+QWnSka7mEyV1BrJulXra3leHyMv6+QWvqSN34GYn5/n7dA6VUW9YuhsiX
         pH0uj7MaeRkH0k8Pc73WBeY4rW23vFnbBpv25nYbCA2BbCMNpORMp466KjiDOnEzuUA/
         49k9y9TyLheNDNI9HGidvuazXE9t8IbQprCjlJsABiLkN0SGE00Q0CkhX+YAmkN1aAhu
         M1azkf/iAWdJziG/X4+QG73AmTW/ADPuqeoOeeA27t7mjat3mJUcGegNnbPa6TblVZgo
         aWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177378; x=1736782178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAND/sZPrYBsHz6UX5BJ7O5mUoHwQEQe92spT2hfYWQ=;
        b=BXaCJ3v3ZzR4Aj2e3CB9HfkA5HJgoB1kliyRe5FR5u+7M5DhujFrKqNoVs4Cj/3OSW
         t94T3OQWW6R0Azakbgze6pGYITGdQhSMT3sqcP60P11MW6CVFHEE5LctsWJjVvBiCCxg
         QWTZWHsmhEwfbXf7Uc7dxb33jagzCdVt3+XBd73FjbWSxMtP69oK67lagqqX+0pivpTa
         j2qWbrH2SXtVplM8Yjp1HIEhNFgoFivb30sz/YE4rMJtHtlP9XtANjTvm3LzkHHxohwP
         /o2c/t/FEZ/JEEhlwqcnTz5qp0pJF0PcDqHDVddSe2TncRv/Jb9GD21Qr+nVIovp1igc
         P7fg==
X-Forwarded-Encrypted: i=1; AJvYcCV8DNWLyk8VbobS3EHdkFPwlH6MBaeq3ZY5cXMFYSX6KF0mBMM4STN81rf9qwdaWexW2RWXtI4ojn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJi9MXNlP88v0G+5ThBUgyI0bXJD1Z1KK5iPdSbY0Nh9tNzSYL
	e+6uVJB4eFwhYt/EkrHWkbovKtbpWxP87BcfhKFqKtXn1nVkkRsxShyOoFL1AVE=
X-Gm-Gg: ASbGnctXdsAAwZ3y3bhO7mNq0NO+JSv3OL6QJn0cRXziJt2qbzD4Si659WK8ys08cFN
	odlpM15QTqRCc+skAzJ7u+XdgFDc77DGozi9OSkKZ3bl9vPy3S0dXsxu4V+iBf5sPQ/tVRHyxMV
	D6Gdh6jxkSA+DILgB2gJ/XGYMWxNVg0viUs0YGk+L/9trsb+QYV9/heS8HY/bYi8cEZKLZI88IN
	uZUF3v9jlSpQYrZ34kWgNtxbKQU3Jv+h4jY5pwKEll5400O/s0SCErRxEVLNyPa6Jn5z6tY6U+2
	H2xVlQASyWc1oclODw==
X-Google-Smtp-Source: AGHT+IGGFarXm8fuCrEMspCklEhyCFWSCb/tiAYFLqgh+VAs0QvDQ24qvEJxWJrzbVRKGM+gODxgxQ==
X-Received: by 2002:a05:6870:8928:b0:29e:6814:19d with SMTP id 586e51a60fabf-2a7fb18a63emr33851967fac.9.1736177378016;
        Mon, 06 Jan 2025 07:29:38 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74c6959sm11593122fac.19.2025.01.06.07.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:29:36 -0800 (PST)
Message-ID: <4be16272-5197-4fa1-918c-c4cdfcaee02e@baylibre.com>
Date: Mon, 6 Jan 2025 09:29:35 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/4] iio: adc: ad7380: add alert support
To: Jonathan Cameron <jic23@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
 <20241224-ad7380-add-alert-support-v2-3-7c89b2bf7cb3@baylibre.com>
 <20241228142457.576f47d4@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241228142457.576f47d4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/28/24 8:24 AM, Jonathan Cameron wrote:
> On Tue, 24 Dec 2024 10:34:32 +0100
> Julien Stephan <jstephan@baylibre.com> wrote:
> 
>> The alert functionality is an out of range indicator and can be used as an
>> early indicator of an out of bounds conversion result.
>>
>> ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common to all
>> channels.
>>
>> When using 1 SDO line (only mode supported by the driver right now), i.e
>> data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) is
>> used as an alert pin. The alert pin is updated at the end of the
>> conversion (set to low if an alert occurs) and is cleared on a falling
>> edge of CS.
>>
>> The ALERT register contains information about the exact alert status:
>> channel and direction. Unfortunately we can't read this register because
>> in buffered read we cannot claim for direct mode.
>>
>> User can set high/low thresholds and enable event detection using the
>> regular iio events:
>>
>>   events/in_thresh_falling_value
>>   events/in_thresh_rising_value
>>   events/thresh_either_en
>>
>> If the interrupt properties is present in the device tree, an IIO event
>> will be generated for each interrupt received.
>> Because we cannot read ALERT register, we can't determine the exact
>> channel that triggers the alert, neither the direction (hight/low
>> threshold violation), so we send and IIO_EV_DIR_EITHER event for all
>> channels.
>>
>> In buffered reads, if input stays out of thresholds limit, an interrupt
>> will be generated for each sample read, because the alert pin is cleared
>> on a falling edge of CS (i.e when starting a new conversion). To avoid
>> generating to much interrupt, we introduce a reset_timeout that can be
>> used to disable interrupt for a given time (in ms)
>>
>>   events/thresh_either_reset_timeout
>>
>> When an interrupt is received, interrupts are disabled and re-enabled
>> after thresh_either_reset_timeout ms. If the reset timeout is set to 0,
>> interrupt are re-enabled directly.
>> Note: interrupts are always disabled at least during the handling of the
>> previous interrupt, because each read triggers 2 transactions, that can
>> lead to 2 interrupts for a single user read. IRQF_ONESHOT is not enough,
>> because, it postpones the 2nd irq after the handling of the first one,
>> which can still trigger 2 interrupts for a single user read.
> 
> After some of our recent discussions around interrupt handling and
> the guarantees (that aren't) made, even disabling the interrupt doesn't
> prevent some irq chips queuing up future interrupts.
> 
> https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc/
> 
> I'm not sure this alert can actually work as a result :(
> I am struggling to come up with a scheme that will work.
> 
Would it work if we change it to a level-triggered interrupt instead of edge
triggered?

Since the main purpose of this is to trigger a hardware shutdown, perhaps we
could just omit the interrupt/emitting the event and keep the threshold and
enable attributes if we can't come up with a reasonable way to handle the
interrupts?


