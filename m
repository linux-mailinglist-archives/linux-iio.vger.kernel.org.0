Return-Path: <linux-iio+bounces-26908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624FCAB833
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 18:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2266C30052F9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA462BEFEF;
	Sun,  7 Dec 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AEcpZAJg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE332877F4
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765127576; cv=none; b=Nq+RtM09KhpMcICtICjJYL7G8ixRxjCmh7zHpONa7343QfiTBEbKxkUaprjvk7CGtR0Hn6vMBUPHU7HGk5OziSyZrGTMtDY4N3bJVguVpX0CJzgqEZcxc1dbo2+Y69qiGGIkUvmIyYBsyZ524Ffof5RxEG5A01Yk9+rBybJWPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765127576; c=relaxed/simple;
	bh=6fIJmy+yjwjMHNsDI+pH7pWh9h6/tAFr/2fxK7jhgjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRTKmweU3+9p5a83RqF2dhntiYuO9mxt7C9AIDTUc65ZFABaegmoLkzdYOCQmWaL3YVl4hLd5L5muc00QLdoAkGBfSk5aeNy6W6apQcx59npX4l7uY1RCSjCYKGNOGpkKmZo8WOYHmZmp9gST7VGIGNXlYOT5F+SHm/ZHIrXhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AEcpZAJg; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c95936e43cso1288579a34.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765127573; x=1765732373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rz+hbdFu/Zj5TShBfYbaQ4glba7CKEYXsGsVmzlXQwE=;
        b=AEcpZAJgSzgEEmmCM9uh0mnFUULHzUbijjqHptOIWQpIK6eAqO6pYXJllnYzGBax2O
         126COpenZQIpCKdNIPr/XjQqw3WjSlNkoKkOsvwghey8gLInNsz+RHGBvNWrYmrYXLGW
         UKekfCWImvGn3IOcm/zoCf3y9u+/9K2t56NA8n/s9DwZ3SPv8fQ6lbcAz8CwuA4ycbSm
         fQZ3zxDhu/uLR3xrrfuW2MQu4D3U27lbqCHYEeQSfKwtGSwro8Geda4Rsohha19+P84p
         XRjlmOwTrOZsKQeLUe42P20a7gL0w4qdKsD+xmPJBMBSEmkLD9e7KcdZRtox4eALjs0p
         R7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765127573; x=1765732373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rz+hbdFu/Zj5TShBfYbaQ4glba7CKEYXsGsVmzlXQwE=;
        b=M3Z0OJYzXNp1kVoi65WhefPZc6ySWCAJ7voUlA4Y3uvOyRsjb6W805+F8PWFrppPPW
         w4k4DSkycQ5DrjQzAf+PNVCHtJwJOjRLKLPgkgyNyI4w6zr6mvDraIAqAIh8dfVlW+CK
         tf8uH/k0YQfpMkotZ3juC8GCqWRC71svvbWvLtoYtVd5lASrpbLmfrZHRHRDIwNLECQ1
         fLr+nwdG6XpjO/S2GJbUYT2jd39jzYrN+imDVQQlx5sfH2NWeV6FCNLjRKGuj2vRlAFD
         8UC16m9lM6u+0V1G7RzM2VJY17iwImtWjas6sceEN/7gvrIMZDNQwTG5pVnDuMIRsYNi
         fs2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWt20WH4bM1RaNDtmHl++DdIgKndmXq7kyXy83Y9kK6C0mVrOHaPscAQBl3oXQchG1V3lJCMQNKR5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzteKWZIci4LnLKmlSgHzABByPwP3feCKhi9CRzqG8I7TEiL0
	CkoDIvaYHB7DQT1y2QufAAnLzoSd5CJOfrpdDkKwKgfXIflsXjgPn5peHD+EpIeUcSk=
X-Gm-Gg: ASbGncuE/z+1wR1kY4RPr/GBPApfxhp6pbAJGmkBFv3f6KdO3z7v/ur71lrTvseyOAy
	uPwr+PSITThF3jQmfDaImB39MKzws58qaX4/hx+4zRUJmGBjBR41lNcw1UZWeGkzBMDSRYCYfVh
	SZWVn/VCvgolSiwXOC8adeoVF5WyuU79NP3QYzTsxQdJ5wpR1DRWpTCUTj8c6XZDUL27wgTSJ//
	1jKKbwJYSG+/aP5perAhVhYiZWNZmlPmhc3h2vE4iNfWUbS3CXAXywbK3rty/MsblLqmqyeZEi5
	++/U3hcGxDSmh3TrxC/ZI+vWfmfESCxnEe3FTFDUdQxQ/53s9dblDumojyQfZY0fHtuxGvNVEcz
	iTr03jFg1ZD6zjUoyr49OeB6xuYd+jj5bZN49pH++gsxHBoLHak1xO6sEhb6dJjMyHfQfjBzD+0
	+D8gInk7kr+kTZIWA+sb1MJHysoQNq3VVLn29IYb+Kv9a5PUWDr5GXsA9bp/fa
X-Google-Smtp-Source: AGHT+IEM+RUk6l87X+4+Tlmn1OItINTU/R0vum7LolDYV7SnuylndTDMKzytRw/7CMc51VrD1vkNbA==
X-Received: by 2002:a05:6830:6b96:b0:7c7:e3b:488a with SMTP id 46e09a7af769-7c97083b2c4mr2190057a34.30.1765127573303;
        Sun, 07 Dec 2025 09:12:53 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:be99:7ce8:d200:2438? ([2600:8803:e7e4:500:be99:7ce8:d200:2438])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95acadb16sm8248687a34.21.2025.12.07.09.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 09:12:52 -0800 (PST)
Message-ID: <5b843df0-138e-4e2e-a70d-beb8a39ed85f@baylibre.com>
Date: Sun, 7 Dec 2025 11:12:51 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: adc: Add ti-ads1018 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tobias Sperling <tobias.sperling@softing.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
 <20251204-ads1x18-v6-2-2ae4a2f8e90c@gmail.com>
 <20251206200721.5e683a83@jic23-huawei> <DES3ZWAKXXEB.2LQPMDZN4JFCB@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DES3ZWAKXXEB.2LQPMDZN4JFCB@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/25 10:02 AM, Kurt Borja wrote:
> On Sat Dec 6, 2025 at 3:07 PM -05, Jonathan Cameron wrote:
>> On Thu, 04 Dec 2025 13:01:28 -0500
>> Kurt Borja <kuurtb@gmail.com> wrote:
>>
>>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
>>> analog-to-digital converters.
>>>
>>> These chips' MOSI pin is shared with a data-ready interrupt. Defining
>>> this interrupt in devicetree is optional, therefore we only create an
>>> IIO trigger if one is found.
>>>
>>> Handling this interrupt requires some considerations. When enabling the
>>> trigger the CS line is tied low (active), thus we need to hold
>>> spi_bus_lock() too, to avoid state corruption. This is done inside the
>>> set_trigger_state() callback, to let users use other triggers without
>>> wasting a bus lock.
>>>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> 
> ...
> 
>>> +#define ADS1018_VOLT_CHAN(_index, _chan, _realbits) {				\
>>> +	.type = IIO_VOLTAGE,							\
>>> +	.channel = _chan,							\
>>> +	.scan_index = _index,							\
>>> +	.scan_type = {								\
>>> +		.sign = 's',							\
>>> +		.realbits = _realbits,						\
>>> +		.storagebits = 16,						\
>>> +		.shift = 16 - _realbits,					\
>>> +		.endianness = IIO_BE,						\
>>> +	},									\
>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
>>> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
>>> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>>
>> What motivates per channel sampling frequency?
>>
>> Given you have to write it each time you configure I guess it doesn't matter much
>> either way.
> 
> I guess making it shared by all is simpler too, so I'll go with that.
> 
Just keep in mind that if there is ever some use case we don't know
about that would require a different rate per channel, we can't change
it without breaking usespace. Once the decision is made, we are
locked in. Keeping it per-channel seems more future-proof to me.


