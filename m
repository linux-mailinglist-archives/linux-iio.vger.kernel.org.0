Return-Path: <linux-iio+bounces-27393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE1CE0108
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A437F301B2DB
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747C632471F;
	Sat, 27 Dec 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CjeBsTnh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43E3FFD
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766859657; cv=none; b=qqRANPFR0MluXbjrOs3TcN4KP6iSCZiwpAX2IT/wmBJPj0CK1u/L6np03TSNi1ojlwZxkmTElcs1CzGboFP1EOus1Kml5Vf3mCbub3i3GZwsvVSTuboara3c6Fp/sPJ6zinNQRz19b8A2IPjUvxuawqeh+4yobvOPiMM7U651X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766859657; c=relaxed/simple;
	bh=+CbJpq+tdkgrbaPm9dRNavpRXrube0jjJxJrm5A9Mnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFn6UfTqhNaJQlwNvaY5V7QZvPjcqOUtDUpiMjVQ3pmc36g2F9wIgrvCEqFtJyWPGgPL8f4L9YewMvfR9I+sK5lnvvZ7aWIrWuhlv14hvosobTbe3m8MbQi9BvXTgwSmvdlnWHqD23jVbC5tUQwgACS+l4I+3DeEnWiZkx6zXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CjeBsTnh; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4557e6303a5so2207824b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 10:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766859654; x=1767464454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2j9oSp9OzmTh5S36B2mxVYf+/+BpGtxTc6qLR8BJ9M=;
        b=CjeBsTnhbYSeS+DGE1mvhLwaO4nUbr8J+YRjXDqGOsyVPHw4SbVmALgVu5DvRjw2h1
         582ZzK1dSfOLKE1GJOmJGiUi2ZbylESQQ7yjgzh7cae8hbclZM4Ry+LqJ2QKh7hahv0s
         OQ2S8PDOaxbtR6h++BnSNVLKkYrHl1MZLoGUTNpZr27lX2TS8hq8YbrfS+NkXXyzR15x
         KZSCYEsKgr0gnsky8sEaJ2ht1yVli6BlpqXsI4YwJo14DIQMnMRYzTJXvGUyW3Jxf9wD
         YdfKUqf5l6JX77YJQKe1XAdgBGbrDOjqiBDEJ8wyj6kU2c4994vPPdJYC9aDSM42De+G
         B2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766859654; x=1767464454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2j9oSp9OzmTh5S36B2mxVYf+/+BpGtxTc6qLR8BJ9M=;
        b=pwDjBIoHndWW2suryl6yKNdcA1mbyNKiverGHtKGvbgzyI4Nq2RR7y8ysqByeWTMf6
         3a+hhGlONg3DypVRahwahgLl+al4uL3qyfTyJ7hTqI3voVnX39n7NTDAveCCAtG7SBbE
         +d6x5e60tYUlTxiaa3lrfNAVe4rWRFEddYjWFytSSJ0XV8Od6mcuRXW+/9mnfKk1x9qE
         13wFWoALDpLCKecL2ATM8dzCI8RrmJ9fyq1U1cf66AZ+mo31L6OYYE4BM39Y7TzPvyEL
         VCEGyxHlCZg3ePV+dYoVfABS3jKYMmF2iTgWSP4a7e93zaqX+wMssnUg5WRGhQrL4NCA
         fInQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgeO+8N1Tu6LycHzuyb6g7LmN5WpICTZwL9pG1VXWJzp56HLj+VwcjE/ODFgk0F131wfR5tdWrd1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOrHQJOThoBTzl4aUsvBALLMeGCsYaG68h3xOV6ZxsSX5Mm6d
	6e/opABSc2eXNngsftBxtW61MWKOaiO/5gPZyuxG04hn2HRy2+ISZBBL6qpo6l76eO8=
X-Gm-Gg: AY/fxX5ksWxtGDrXFEK3yuzghds/ZRcbWqTNXOB7CxDyAYuHomQK/vA5QoIv3fDNnO3
	Rz2T5ZZXtp7tCVVBjjK7ud91d9oOfYe6IOMgGUn9zmGVIWYs1bC6vkmgFkAva3C69TSkpztEDG2
	B2vEg/96A2zCYhZImMW1qHAZagbsE4TT4HkCiiXeyk1otUwa9QlbRwbCawZZBatkzGj0qC/AELf
	dYK4z9WL42y0f2tpa5XweOxXO0izsxMzm/RdrultBjrXv1vnkaVp34BLeWsxcFUQIEagF1P/WFZ
	z5ZkS8ojWwyzluETewgU0kIIm06ufxeLepC5Nb4sqQcf3F4JJpbcN5SwAiL0jvDd7esOyYojCSo
	WsZjfHqCnQvfZlu3B9IQIxM4zuupkBFEooM8WviQsoLqC+Z/nD/GdlzpkgbEXe4zhp2IRoIde98
	/VldzMBkotYWCi9xGppP2/NWA2YACtnsNeWmR6qVaRcqxsF7Y8bMDclQncFzeb
X-Google-Smtp-Source: AGHT+IFPqw8otBicikTMcpttXB+4UlYnr6IaZlBoYe9K5ZRzq3nsV03RecZLJ0LeOfBCKUElLGSUqA==
X-Received: by 2002:a05:6808:1b25:b0:450:c0c4:3728 with SMTP id 5614622812f47-457b2175c27mr11920065b6e.30.1766859654263;
        Sat, 27 Dec 2025 10:20:54 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:81b7:1177:37cc:3153? ([2600:8803:e7e4:500:81b7:1177:37cc:3153])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667284fdsm17601022a34.2.2025.12.27.10.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 10:20:53 -0800 (PST)
Message-ID: <6d40a735-ad73-4a21-bd66-3af1edd0d1e7@baylibre.com>
Date: Sat, 27 Dec 2025 12:20:51 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-4-6fb47bdaaf24@gmail.com>
 <f5ef483b-12d8-4ed2-9637-af993c3f8b7d@baylibre.com>
 <DF974CHWQ5BL.MW4NYZU499S7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DF974CHWQ5BL.MW4NYZU499S7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/25 12:04 PM, Kurt Borja wrote:
> On Tue Dec 23, 2025 at 12:23 PM -05, David Lechner wrote:
>> On 12/11/25 8:45 PM, Kurt Borja wrote:
>>> Add guard classes for iio_device_claim_*() conditional locks. This will
>>> aid drivers write safer and cleaner code when dealing with some common
>>> patterns.
>>>
>>

...

>>> + */
>>> +#define IIO_DEV_ACQUIRE_ERR(_var_ptr) \
>>> +	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_buffer, _var_ptr)
>>
>> There is no error code here, so calling it "ERR" seems wrong.
>> Maybe IIO_DEV_ACQUIRE_FAILED()?
> 
> Here I'd prefer to keep it as _ERR so users can make the immediate
> association. But I don't feel strongly about it.

I'm afraid I fail to make any association with _ERR() and something that
doesn't have an error code.

Is this about following the established pattern with ACQUIRE() and
ACQUIRE_ERR()? Usually, I am strongly in favor of following patterns
like this. But in this case, I just doesn't make logical sense.



