Return-Path: <linux-iio+bounces-24369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FACB9648C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E27B7DD2
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60B320CBD;
	Tue, 23 Sep 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v8yfZsTW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6F248869
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637669; cv=none; b=Jl56Ffxx2EVShRGbBHytqePdhUvHK4dPpJbTkq9IGO46to/BJj+ojndqMz/9eHVxKTpeofaVRUKXArNCiznVZ3e9hgi8mVY0rvnDRiHPSjcfROpAedTMrSpVShUgNRwaV+fuXtK2h8Zya+U3vfdNyhtiSpAer+ntJl+0cd5erJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637669; c=relaxed/simple;
	bh=QSlVRuHGqVrvAwqdZx7uUPyniECMwQzZvqtjdXpsCkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xb4xUnYxToQ0G5bfF7KFvfc+gxVjxijeUEewM+oxqof7qCV759K5ZJwr+OCvu2AlRR2uS0tHI3IhfvlpXYhFmUyJtMXmy8dWa8GiIgPidvzwfMXBeVM7RGkSGZRQZAyq1qSnJoSLFmUcSxX8wefaOxtS+OfI3RD7fsFnJXnBPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v8yfZsTW; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-621b965a114so2619031eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758637666; x=1759242466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLJ7BScAjhL/3pW5EapzhVxN4E7gDwKlVKKb8Tfi10Y=;
        b=v8yfZsTWM3ixJCEtFRsLd6y5101nnPnIQSYTqKzCVPn0Ypd14SYsLsjLzDk4vdAGj4
         nnFevP86dH85veFbD8CxV1I3VGiDSr4Q0Z42XE7e4VjXiGVARJhszzxztsBs+brWIeC/
         eyLgGM48uLvsVAQyYvt1BuRKEeIWxPC8h/4Dv4oxbpkFECeq0A8z1kwLeoeoINg2u/03
         MH84mUyV0iLmsnkfFbi93w768KiKbazFmgJ7H6MydMznNEl8DupDG2WqZFXMe4G4My7m
         tBJ+rMmx3yodRoIzGEnlmOlMaMDd4TaT50ybMtauUE3oxA55iL8tYkn1hoXQnTRSlZhY
         xVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637666; x=1759242466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLJ7BScAjhL/3pW5EapzhVxN4E7gDwKlVKKb8Tfi10Y=;
        b=kO70pRhAwTN3hwukKWB0cC4yTiEY1NPIQrmTZO1JN5hgLaV41OaXLUqdAwd7rN/26L
         ksEkRrx3TO6EyuHKv/G6dFbRZD7a5GK0Fs0mguhYM6Y8CHEU38JYjgT5AqO48Yn9Pe9C
         w51Jr4AElFMrItnED+1cYzcslk/bafreQwoZAXMZUh2umJcyrbAKFyrBI11cm1E/T6Yo
         lmc7hb3bNa8Hb94nmluY93wj9kZtiqVeeDsDVhLZAKvE3Etg5a53RnCofF5juoi5d7fj
         aTe8TrGop0zUXRs46jJntrtV7+wNSBahR3MX3ZCWL6zV8+kHigm0a1c4+Sl1sRpVpKb+
         LzpA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Hz7GxsbTwUDIHxSko+IKHjtMGPxwubr6NRIv1imuZLPK8ZN3Hzd43jQARB6J5l7u27MQ5chbLpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYA31nN7JR95ffSKrkGKIvqagGnrjM/gfR975ECMAh178ZFkA
	ZjgYNNOxiFGh0j6D9ntPLCjqzoyVU7pDU9pb9c5de5L9UeMVb1n2fOXGPpyyYiLc4YA=
X-Gm-Gg: ASbGncuG8qdA+Qb8XVG3sk2kQsL3a7uPCgv18QlKUSOlNU4rzZHfmlzF/lkMAg3dGjW
	xejK9A1a4/Ljw+eeR0d/YdtBMyG9iDpAP5xZMZ6Nssl86PE3gkHIJAZFki/1cXuReWgWSQO8eg/
	hXhmgOxnCSswxtBO+AlAY2Vf0HZ9hj28aXlPP8XDapSzcjUEddSa/NEa2LoxssLgljmVxegEeFH
	TxooSdFQXDOGHnxORGydRqdviXiIb76zDB0zKtxmzZyjw1tut0+xPpGPetDCLwhJxtovlTxNyA/
	XfFFGh6n93XYLdzP5ENSEQXaGkSANjhoNF75UFYZ7Zz4YVZ6SUdMUH4gwiehCNlfxhPvy9A1pva
	i0UXgcPtNpRL2Vg+hvepF8+V6Y/8KYvu539CDYPC9rjJxwhF6znTNiJZuqCcu5NaLvswvhlaYhv
	0=
X-Google-Smtp-Source: AGHT+IFL94lBmdZJriTx+SZHET/cqfmupNJowuzMcchFfQ0ZWLkK9i/EadeGAMHUq7kmPPWbmJIiag==
X-Received: by 2002:a05:6808:f0b:b0:43f:17eb:3134 with SMTP id 5614622812f47-43f2d2e3709mr1548523b6e.13.1758637666225;
        Tue, 23 Sep 2025 07:27:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c6c935fsm5987496b6e.14.2025.09.23.07.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 07:27:45 -0700 (PDT)
Message-ID: <c19fdb3a-e537-4f32-9b69-db819c04f447@baylibre.com>
Date: Tue, 23 Sep 2025 09:27:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] iio: adc: max14001: New driver
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
 <2d5ef36b-ae37-453d-a19b-76fc97b7f14f@baylibre.com>
 <83018b80-b939-4e2f-a9ee-7fbf07648181@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <83018b80-b939-4e2f-a9ee-7fbf07648181@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/25 7:56 PM, Marilene Andrade Garcia wrote:
> On 16/09/2025 15:04, David Lechner wrote:
>> On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:

...


In general, please trim out extra stuff like I've done here when you
reply. It makes it easier to find the important parts. I hope I didn't
miss any of your questions.

>>> +    /*
>>> +     * The following buffers will be bit-reversed during device
>>> +     * communication, because the device transmits and receives data
>>> +     * LSB-first.
>>> +     * DMA (thus cache coherency maintenance) requires the transfer
>>> +     * buffers to live in their own cache lines.
>>> +     */
>>> +    __be16 spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
>>> +    __be16 spi_rx_buffer;
>>
>> These would no longer be strictly big-endian, so we could
>> just make them u16 with a note in the comments.
> 
> Hello David, I have some doubts that I would like to clarify before sending v12. Since I am not able to test the case using SPI_LSB_FIRST, I noticed that you suggest saving the data as __le in this case. Just out of curiosity, if I use SPI_LSB_FIRST, would saving the data as __be lead to errors?

My thinking is that since we are sending things out 1 byte at a time, in order
for the least significant bit of 16 bits to be sent first, the least significant
byte has to be sent first. So will little-endian, the byte containing the least
significant bit of the 16 bits will be first in memory.

__be is just a naming convention and doesn't actually cause any bytes to
be swapped in memory. It just lets readers of the code know that the
value stored there has to be handled carefully because it may not be
cpu-endian. It would be confusing to readers to store a little-endian
value in a __be16 variable, but technically, no, it would not cause any
errors.

This is why I suggested to make it u16. It is still wrong but it is
equally wrong in both cases. If you still want to use __be16 though,
you could make a union instead.

union {
	__be16 be;
	__le16 le;
} spi_tx_buffer;
union {
	__be16 be;
	__le16 le;
} spi_rx_buffer;

>>
>> The scoped_guard() looks a bit odd with the extra indent. I would write
>> it like this instead:
>>
>>
>>
>>     case IIO_CHAN_INFO_RAW: {
>>         guard(mutex)(&st->lock);
>>
>>         ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
>>         if (ret)
>>             return ret;
>>
>>         return IIO_VAL_INT;
>>     }
>>
> 
> Ok, thank you. But since I removed the mutex, as it was mentioned in the first comments, I should not use the guard, right? At least not for now.
> 

Correct. The regmap_read() has something similar internally already.


