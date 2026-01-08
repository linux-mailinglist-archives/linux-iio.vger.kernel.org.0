Return-Path: <linux-iio+bounces-27559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376FDD04B51
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C282234ABA0B
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3872D9484;
	Thu,  8 Jan 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nB0oP2Gd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819A208961
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887823; cv=none; b=bt14P3BML23LXSI5x7RgYtpVdbQvCWTsya1WyMsJ9Ej6i8d/58qXfNgsycp9orSGhFfQZP7wHsQzuF+rhKFjC7jKYpf/vJQ4a7MW72yp9n5vtE5bcfNjguOV1+fHXFziX7PUEONnrrqRq+TZSNTC+j1PrhNvnf1ZNBEjMGRjQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887823; c=relaxed/simple;
	bh=3WxyY58R5RF4H49rbz20YiptJDUIV6EodvIQ0DXLKdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYaSqtyHdm+55ffb+uHoAQSfLGGTDT++HflEk8hlh1q7ryDLdSEaWOVn9ySFOyLPgfaI/J4tdShfZdzu7l+O1lmtD23pBkI5NzsKlByB1ZxyOZEO+U0qYcWvxVyqGUjkkqVPhz1P/32K+4BipOFfjiL8R2YycHH1mrHpK1JryyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nB0oP2Gd; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4510974a6bbso1332207b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 07:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767887819; x=1768492619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0+ELb9bQZu0kUreFc+yy4vgvyvuKYmmuSxPTDF+G0o=;
        b=nB0oP2GdgPdgFBXH6MQWO3DDLbBE+6EKA3Y5Zo0wrTyl2IUnQbY89xV4AE0uUyZD5z
         4AQcJG5v0+5N6J1BJQnZiEZQ5v5RVkDB6WlFkW0EszMq5ZK48vrRYtg9OLzTzanMWQkx
         FjQwoh6bI9Mxknzh4dEI2MdWQ+4LHY2zCCMN/vQpipiXlSfD51St7DCtJS29SgktG77w
         qG12xfdU0ZKCX0rZVM3poKV7sRwb62jBiJ1utcnP0PTdvaDlt5PFYc+uZgdRhPGXkexL
         QkqxMMjXNXy1ZAKVyReOhkWAXZiu97fI5Lns+XrZZYSVz45n9926kaA40VBIYGDyQ/CQ
         DIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767887819; x=1768492619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0+ELb9bQZu0kUreFc+yy4vgvyvuKYmmuSxPTDF+G0o=;
        b=ax/X/RNpVTKfbooB6CA1NNlcFfoPraxduMWD+0wiV+etjASEHoZyEuayexIQpv8GVN
         ztmIoS5IdOPXqP0WqErQKGzibz9jwE8dVWM4tG8NOps8wpNbTg8sWsz/mZ15NfAtOg5Z
         OV5h7ycWEOon1mDvVJttWZ65exDyqfAhOZz7ZY3YshIkunniZHYIrwqZ3u/QK/JgIXoT
         iLtpwEsz2djUSMolsQvkVfe5h6fevB4gTjjxNcCvDMFNyZGuPgRO2qoxFJlW4gBUkuBF
         SyuEvow5FBz7Rp1E4H4UrOMFvNjV0ITwFbELcTZTFSvioBRtWceiKw3aLVCW2g4CpqF9
         k3JA==
X-Forwarded-Encrypted: i=1; AJvYcCUMgbEyQfseDx1CCZwnJ0Kg8XOHVj628AstCdzHv2ioXRBWDWczOdX3P5j1OgYOXQLG3HWky53hYDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaYc/N7RnhBA0CZhouPitP/z3gWhZx7aNcDln/wwgf6aaGr81
	u2CmHzG3QxGQH1If1jBtt15JmbkuidlxJhUQTDLtIpz6x3rAjqkeKwzV5Q6g9EiZDRg=
X-Gm-Gg: AY/fxX4IPv/tSLxtj+1HA9/s3vVRj5cbSL1TXa1GKs9LfwzeFKHG4VWOQVQUCZw8t+u
	CpgB1AWrthvyvkdHvuVLYxH96fpi1SslNKLL2J0WvAy50tHyc3GeCXcyYKxfI5/a8rDXeawB+SD
	LnFSFHp9kNnDCMuHJYJGSiTwTVGwqYsom20tfM8qRqnndCRqag/rGhiI2h4A6GjUJ7cqMzwDCjg
	2C3kGk+mwPaQefNi7QVRSam8nyqS1l1Ec6Es2CthPZ0yB/KEg1L+gIabY7MV0FLuxR17WLXo3zV
	PrGEc9+whr0Y0OuM/ETE6uARAELKqzOH/T2PHP1aLCoUIGlYiE0+m7T2jgDnz9t8qQHDrYtTXKe
	kNpHofi5SteW5dtzKT3drLR70fs73C3yRv4HMhYgGB3YnrTX39ItocEHundHYbp44O7V1zyoqf9
	Pxk7TVJtTpw0pdYG5+buknyJL5D9ECTibkXHHp3Wo5bCrr57wckY7cF6Mcw2lf
X-Google-Smtp-Source: AGHT+IFwUW2T7bI5xvApxv4384NTKdeNIA2TmBS2bO3HBU4plxZjZ1bXoeq7L5luyn6AbAoj1AAj9g==
X-Received: by 2002:a05:6808:250b:b0:43f:1d72:592 with SMTP id 5614622812f47-45a6bdbe64emr2767749b6e.23.1767887819203;
        Thu, 08 Jan 2026 07:56:59 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c69c:7b5c:ce9b:24be? ([2600:8803:e7e4:500:c69c:7b5c:ce9b:24be])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e1b1285sm3623783b6e.8.2026.01.08.07.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:56:58 -0800 (PST)
Message-ID: <c93a528c-39d6-4e29-b64a-ecf75032b60d@baylibre.com>
Date: Thu, 8 Jan 2026 09:56:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] spi: Documentation: add page on multi-lane support
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-5-145dc5204cd8@baylibre.com>
 <aV-mpFCF_ET3AZ1B@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aV-mpFCF_ET3AZ1B@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/26 6:44 AM, Marcelo Schmitt wrote:
> Actually, one more thing ...
> 
> On 12/19, David Lechner wrote:
>> Add a new page to Documentation/spi/ describing how multi-lane SPI
>> support works. This is uncommon functionality so it deserves its own
>> documentation page.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
> ...
>> +- :c:macro:`SPI_MULTI_BUS_MODE_STRIPE`: Send or receive two different data words
>> +    at the same time, one on each lane. This means that the buffer needs to be
>> +    sized to hold data for all lanes. Data is interleaved in the buffer, with
>> +    the first word corresponding to lane 0, the second to lane 1, and so on.
>> +    Once the last lane is used, the next word in the buffer corresponds to lane
>> +    0 again. Accordingly, the buffer size must be a multiple of the number of
>> +    lanes. This mode works for both reads and writes.
>> +
>> +    Example::
>> +
>> +        struct spi_transfer xfer = {
>> +            .rx_buf = rx_buf,
>> +            .len = 2,
>> +            .multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE,
>> +        };
>> +
>> +        spi_sync_transfer(spi, &xfer, 1);
>> +
>> +    Each tx wire has a different data word sent simultaneously::
> In this example, the controller is reading data so the rx wires have different
> data word received?

Yes, I tried to make that clear below by having a different value
for each.
> 
>> +
>> +        controller    < data bits <     peripheral
>> +        ----------   ----------------   ----------
>> +            SDI 0    0-0-0-1-0-0-0-1    SDO 0
>> +            SDI 1    1-0-0-0-1-0-0-0    SDO 1
>> +
>> +    After the transfer, ``rx_buf[0] == 0x11`` (word from SDO 0) and
>> +    ``rx_buf[1] == 0x88`` (word from SDO 1).


