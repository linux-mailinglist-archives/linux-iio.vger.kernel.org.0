Return-Path: <linux-iio+bounces-8427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6DD94F58D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF20728308B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D1A18785F;
	Mon, 12 Aug 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i+yFibpp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0266CDBA
	for <linux-iio@vger.kernel.org>; Mon, 12 Aug 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482197; cv=none; b=HnhvM0Gkfa2NvDV2cth4C0gTvUJvlN7nPV3OBPze4XijCN0suXHumJqAU3zwaVvCA0jmwf/mAVGh40Spd74BcVZVzCaHUznEX7uQyyxGLTlY6QkKAylXk9d5xdD/gEPajbQ7yOSj3ERn9vFcE+gj9bq7t2fSgMaMdqtqzPZHt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482197; c=relaxed/simple;
	bh=IGwPcOdKLneQrDz3TxBBsgsLiAnDxtF3rxB3ridlEaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLiP2hVnotksCw/Tg8rj4a7cv/Le6rWVd/uHiOrATMVqv4Pq2Fb24W/YMqsDnGc1UJwlg+1H5nROV/Z9JjcKHqm8M9cLZw80HdKhf0Cmc45ouj0r1booaDxTjO82BOFWiCGSmfqz9B9yVZzhOCUvTglIfefXfW1jCxoSqBZQi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i+yFibpp; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5c7f23f22so2650411eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Aug 2024 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723482193; x=1724086993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bExiDSnFO33yD2L8BFcmTWpVw+fpt4LMBVVZpDIXrdw=;
        b=i+yFibppxIwoiUoZWODocUR1eUXFcM3AVJCovt+ax0M4iq4pmm+3aigJXzGemOEh/y
         DVOW+aPvtAFDJsQqu4aHxbZffQ0Osi9GS/NTUiI0v076g3sXmAHYvsHUCZukUTgBLA+L
         vEhCLLy92LbqZWucIK31H4Mpy16GHlGAP1Nc7azbqn9YUZ2888NqMzorsU4SBkNMk6Yo
         MM1XalKU5GqWgLMmE2Rp7wjer/avmVmtPrvCoXGUIbBXkL0g52NHu/jusT7mmzm7xKrS
         Yy8NmIml3JOcioRraZUBV8LxUzNHwCu3q4A4k8UxmjkG4dcBU3DuJ7rQ7NLbzmnMUEau
         92ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482193; x=1724086993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bExiDSnFO33yD2L8BFcmTWpVw+fpt4LMBVVZpDIXrdw=;
        b=bOkIfgm9U/XbSA0BuMGZ+wTwdC9MsRP+Nz/B+BnWWr0K1Tq0XxBogkNzT+r80roYla
         nimHZZtJZyokPjeav+5C/WmIMmJdRqTIaoLIm0OitUqef8IgTqdC6HJCpjCSExkEi/OE
         8oe3spGpEKEkzuiS7jrrXlc02AE+pABGiLsiZyxdsiHPNS6WhW2znaL8EHacylYyzEUC
         0mKq4vlsJMy2oJMwEikg6PwX9ZDtFketXu1LSXYLnUUGz2+z6ASEL21XD6GndF7qlaa2
         9WK9tXifDiaMlcO/pmlplp5NFQPVESWW6UpOAGMRjDWOiSMEozBqu0UlwUX7t4fl75pa
         qXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZrEBlKs9eR35DA43C+Bx1WaFpvsxOCn6Vgxu/sVEfOud1mZA9ijxk5JpQfIvD8lfnoeP0xRBO7D8ePwdka0xCPQWtiI2GH0l
X-Gm-Message-State: AOJu0Yzf6Ut7KMKMyoBKZ6ZiaaiCV4EV6zOo93HNRUwxsr7H2ROOFka1
	FbeT8T9wYFzRTpStG87O7V/TLS8ar3wWJHm8F0ZV/9NjvlOFpetWfLX7um2UwOHV1/RCMJaG67p
	W
X-Google-Smtp-Source: AGHT+IG/8cvwJl1su2L5alxvVPwGc2ZZozy1KozsXjsObxlu0fil/+H5vX6dIr/MUHIJ+7YaXv9Bpg==
X-Received: by 2002:a05:6820:169e:b0:5c4:68b8:e27f with SMTP id 006d021491bc7-5da68a0e743mr1122735eaf.6.1723482193390;
        Mon, 12 Aug 2024 10:03:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da3e286b09sm1319918eaf.0.2024.08.12.10.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 10:03:12 -0700 (PDT)
Message-ID: <4bdb10c2-057f-4254-864b-99bb7ac1509d@baylibre.com>
Date: Mon, 12 Aug 2024 12:03:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
 <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
 <20240810103540.03e758a5@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240810103540.03e758a5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/24 4:35 AM, Jonathan Cameron wrote:
> On Wed,  7 Aug 2024 15:02:10 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> This implements buffered reads for the ad4695 driver using the typical
>> triggered buffer implementation, including adding a soft timestamp
>> channel.
>>
>> The chip has 4 different modes for doing conversions. The driver is
>> using the advanced sequencer mode since that is the only mode that
>> allows individual configuration of all aspects each channel (e.g.
>> bipolar config currently and oversampling to be added in the future).
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Main thing in here is I think you can use available_scan_masks
> to avoid the need for the error path on just the temperature channel
> being enabled.
> 
I had not thought about doing it that way, but now that I am
thinking about it, it seems like we would need to have a scan
mask in the list for every possible combination of channels.
This would be 10s of thousands of possible scan masks for 16
channel chips so that doesn't seem like the best way to go.

But adding some special handling to make the temperature
channel just work should be easy enough to add.


