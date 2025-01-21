Return-Path: <linux-iio+bounces-14522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B4BA187C2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 23:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D417A2076
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAB51F76D9;
	Tue, 21 Jan 2025 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bbkspk9v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667C1B2188
	for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737498782; cv=none; b=QWO4Sot5kJ86oB+BOo2KHggvrEuMOuZiOfAL6H1ZY+j4uKnQKQFD2g5xgZ/m/b+5omKxTbG0VRCGABIAs67n/by5i+9Y1wRKKuoElbXplFhR5UXlT4JKNlnkSGXUR6nEbd8qPWbPA6Miv1TkozFDYCXfVwOptYK0GvtPY/WXfKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737498782; c=relaxed/simple;
	bh=lKxghfTz/YPh4EPK64WgQmiUjxXi2fqZG57xnjL1o0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUWRVvouryO5kZDm7FvHCAaLCJDodW70AIGNnmgfivCg2xeqC30LYz8BRLOa+HdO12HDQmA21HTbpzwKj2UEzOjs+hkkxlbXbJeGrbtTkZHgk7NbLhRukpDVEAtr1ofj92kRKSy4Mp6OZmkFqG1ZcAUMwK4PLBSnsvr080X12uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bbkspk9v; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb790888c6so1619351b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737498779; x=1738103579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69ilqU5SYOEcpJzCx+ZI0LKQxRNsBfyKsxd3wREPYAM=;
        b=Bbkspk9v6KW0WCBnvCKGpLK/KVmNuSzUhxddMkYKK9bhQIlEgfvfkNJaG4jb9jsEgQ
         Hg1463tVxOCsA9To2H1US8p3sKFn2py5RZik65USa7nSCyz/LCVV7pVEv/kXqjrfep0R
         RzfCQGJMAlWcUkJ64OZiXiGUVUtSYGY5Gu2jLKVkoRXP2mjD0UpbjsF6vn2ZLXaCGlOi
         vYYVvYkT1lD8aiv4fKKz/vuIB2p3Tbmo1T5UoCd8Pw5Z2DMHy6Pbg5vwMjbC4p7Q+qg8
         SiGdZiXYK+TqDcMzJk0zRa+2Is4wVzdtQh65jkOYn/BzDLqRICNIV0PW60Qo93sZWHQZ
         uU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737498779; x=1738103579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69ilqU5SYOEcpJzCx+ZI0LKQxRNsBfyKsxd3wREPYAM=;
        b=X6bVm43b0EbSGqL5o5maWTlcFIvDrVEmo+mGvkpZsxSe4eMX7P9GJiP9amZW3bC/iM
         anZKTfmKqjKuXP+8n1zJOM+dbSkXIExmZPOSRmmJcYB0bI0OqJKla5IYB+qxF1x/f1f1
         OsT3cQJW9z6wzrsZXb0uuRelaj8armlwbadbGeunSSzHUnKP957U45KRxwOKkdxsUMZX
         SBJIHxKAIeBJPT5Unj/etXrCcXPod3IEt+Ps/Zg3goMJVL14T55bNVlaNz9vFIeCiu67
         Xk2QX/ouYSYzL3H6l5wQ4gvFrSJOBaK8AhuDfjQe3WhGwPRj8cXfVdfK8+Zntnd/qNaW
         l94w==
X-Forwarded-Encrypted: i=1; AJvYcCXX+pUKuayx+hppl+5tvZnkSUn6WReRV2EtLKXUUhcLNvjWj5l0LoM79zRKfq49Qn4I1V5YOMab/B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mrVX74RL6914W/9S2dtPXyjz1uP57Bw/DOsgH0Hz5HHd83ZL
	gGQBf9CGroovnzXu5g+Nc+CHM7+S+5ELr0KgJU9nOOFIZNoTJdHSHpyZsDXWHAA=
X-Gm-Gg: ASbGncspGfKfnjBRwXKxnzxKKRgGDGA21gtjkkTPRTBUE44KklvspALdmi/SBXJ8NZJ
	RMAStxYAVyHO0N7KlWY0zvyrGvZxDFpUVMKMvEsWwFce2K2uJA/K6hQj+V7OQ2iJfBtXYCOszqP
	X33YfvDzDrIydlHpZJ9/kVWqC64qCv4JbLQqpPSBNH8etagEgtQwxRcYex+OTF6Ew7JoN894R7E
	/Sa11rtQyRrN8xfKuz/SGJyyECJa93s1JkTSvca0oahN/FsNTYY8I2gpzNY6W7ss0fwhLYQ+0wh
	/3JSiaRlBqOt8yxruq3Ks/mXZQXKsI8=
X-Google-Smtp-Source: AGHT+IFoow9TxlSsxOuMbPztuGLd5sJk699UhXP5MDEwZ+jS0Rj2BXHTczQCzf+U/O+It/Rj3hS+bQ==
X-Received: by 2002:a05:6808:4d08:b0:3eb:66a1:9d8f with SMTP id 5614622812f47-3f19fd4c7a0mr8840441b6e.25.1737498779414;
        Tue, 21 Jan 2025 14:32:59 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19db7828esm3308482b6e.34.2025.01.21.14.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 14:32:57 -0800 (PST)
Message-ID: <d9828b7b-facb-4b42-aec2-427e68352a94@baylibre.com>
Date: Tue, 21 Jan 2025 16:32:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] iio: adc: ad_sigma_delta: Add CS assert function
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20241221155926.81954-1-alisa.roman@analog.com>
 <20241221155926.81954-2-alisa.roman@analog.com>
 <20241222180713.64f27040@jic23-huawei> <Z49qgvy0ZVKJ0h0W@spiri>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Z49qgvy0ZVKJ0h0W@spiri>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 3:36 AM, Alisa-Dariana Roman wrote:
> On Sun, Dec 22, 2024 at 06:07:13PM +0000, Jonathan Cameron wrote:
>> On Sat, 21 Dec 2024 17:56:00 +0200
>> Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
>>
>>> Some sigma-delta ADCs, such as AD7191 and AD7780, have no registers and
>>> start conversion when CS is asserted. Add helper function to support
>>> this use case by allowing devices to assert CS without performing
>>> register operations.
>> Hi Alisa-Dariana,
>>
>> I had a look at the ad7191 datasheet. Given this description,
>> I was expecting to see it do a pre pulse of the chip select to trigger
>> the acquisition.  However, what I see is a power down line (which is more
>> or less a chip select) but it just has a specified t1 delay before the
>> DOUT will change to the state for the first bit and the host
>> can start driving the clock.
>>
>> That can be done by setting spi_device->cs_setup to whatever delay is
>> needed.  The text is spi_device docs are a little vague,
>> but I'd take it as t1 + t2 (maybe t3 to be safe).
>>
>> That is going to be more reliable than trying to hold the cs across
>> messages / spi_sync() calls, particularly if the bus might not be
>> locked (which the code below suggests).
>>
>> Jonathan
>>
>>
> 
> Hello Jonathan! I am grateful for your and everyone's feedback, as
> always!
> 
> I got a bit stuck on this part. The motivation for adding this function
> is as following:
> 
> int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
> 	const struct iio_chan_spec *chan, int *val)
> {
> 
> ...
> 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
> 
> 	ad_sd_enable_irq(sigma_delta);
> 	ret = wait_for_completion_interruptible_timeout(
> 			&sigma_delta->completion, HZ);
> ...
> }
> 
> I noticed that adc drivers need to call the ad_sd_write_reg function in
> their callback set_mode function, in order to keep the cs line pulled
> down before waiting for the interrupt (if I understand correctly). But
> since this component and AD7780 have no register I just copied the
> functionality of ad_sd_write_reg without actually writing anything.
> 
> Should I change the description/name to more accurately present the
> functionality? Or would it be a better idea to not use the single
> conversion function and write something from scratch leveraging the
> cs_setup?

If the RDY interrupt handling wasn't so tricky, I would suggest to just
make a separate function. But to avoid duplicating that tricky code I
think using the existing function would be best. I think you have mostly
the right idea here. Here is how I would try to do it...

1)

	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);

In the implementation of this callback, call spi_bus_lock(), then do
the SPI xfer with no data that has cs_change set so that CS does not
deassert (using spi_sync_locked() since we manually control the lock).

2)

This is the main part of your question, I think. In this part of the
function...

	if (sigma_delta->info->data_reg != 0)
		data_reg = sigma_delta->info->data_reg;
	else
		data_reg = AD_SD_REG_DATA;

	ret = ad_sd_read_reg(sigma_delta, data_reg,
		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
		&raw_sample);

I would add a new flag or create a sentinel value for sigma_delta->info->data_reg
(e.g. #define AD_SD_NO_REG ~0U) that indicates that this chip doesn't have registers.

Then modify the if statement a bit so that if the chip has registers, call the
existing ad_sd_read_reg() function or if the chip doesn't have registers, call
a new function that reads one sample and has cs_change set on the last SPI xfer
so that CS still does not deassert.

This way, we don't have to mess with modifying ad_sd_read_reg() to not read
a register and avoid the naming issue. :-)

3)

	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);

In the callback for this function, do an empty SPI xfer so that CS finally
deasserts. Then call spi_bus_unlock() to release the lock that was taken
earlier.


---

Also, thinking outside the box, could we use a GPIO instead of connecting
SPI CS to the powerdown pin? The DT bindings already have a powerdown-gpios
binding for that. The could simplify things a bit.

With this, the set_mode callback would just be poking the GPIO instead of
dealing with the SPI CS line. But otherwise would be the same as above.


