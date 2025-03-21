Return-Path: <linux-iio+bounces-17165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A03A6B5A6
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 09:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7335482A56
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8BA1EFF94;
	Fri, 21 Mar 2025 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOAOCwTg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6991EFF8F;
	Fri, 21 Mar 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544068; cv=none; b=hOx6/ywTTUUla68Sb7xYOtiQea22EPs2LvqP1kYNJJ2g4f7NdelsDSvzjb3cv9+z+yk+MWHnD5ibQNoC+oOoMiGnkj3Tq7v8EoJ11LPvHkPSuOIg43R3WRyHM//JcWlCx3/K00itsB5xGB0x3Rsm/foAHiGoID27BVcm07+2GVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544068; c=relaxed/simple;
	bh=YEBKqxb5NnXK1B/MWvaok2UKCzrFV38+PsdgI5ax28g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ai2jTcpZm/ZKx1iFDxtNLjNCkPoB0FIb7WQ25MOuRpXTdbijEzhYToQIDIfleO5+WhKCgmfBPvNM8UQam4lM5dPV+GYfOtmdksZBM/1NruD81nR2w8JIpfBwj++nLnDimIAvpT1IwWu2rjgcidRfF3nvQUaXpGoQfZvGGQ4/KFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOAOCwTg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54996d30bfbso1586041e87.2;
        Fri, 21 Mar 2025 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742544064; x=1743148864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROAy7hkDciZFMoM0hAPRWBq/5MH/tytpN9Ow/SDYmvE=;
        b=OOAOCwTgTKf5c/VSdfdc34SlaFdqJCV9yX4Tpb5s6Sf7vsYupgVv4JBlctVyUp43E4
         MmRZMsiZZvW3o+2qqTQhh3DKB16bQd+jM0wbcDrtDp/lHtE3H0cQqGvqo8whndXkZR5w
         jy6wkCbw8+Fdb2pQyYQNhKGHFLURmhUj/JM9zvboM0cbx0eimqcvFD3mmDSDTr3QEktU
         qv4kyti4LDHpwbW52JMZl+CGUnfPoXsaTI344zRYS4Fq5m/GdX+ni2xnk6nPPlPBkNgH
         WnrXH8aeGxIO5Q/goZBSGGPKWCnJ2Jt5qr7Nxye4XHm0GhnLmRAGEoAa+DWjJ/zKdL7P
         TLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742544064; x=1743148864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROAy7hkDciZFMoM0hAPRWBq/5MH/tytpN9Ow/SDYmvE=;
        b=cyzZMZekIYRs1eDumIivFiiyfmbN9Cg0ArkVPPrkl0SUSrDOhGWIlAa5I6Fv6EFpAl
         2ZzaRHg2FCLy8bYeKyjjKryUXLqv0YNoQQM30kiC2ii2dvdOJo8m2KuvqWtzYqztX3aN
         7WbvsN2naBfZYmWWvTFTGl5+k9b8uXSkud1wzqW3XVAJEiRMNoQKe+pCxaSt0eSAEil5
         jmPtb76D3QJJNhQ5L0vYPoL1Q0qH5jv5+3Gzqb88E6lt66olumeZDexX7Vl//fq3M4st
         hw+qhvgzXKr132rB9ztiXkNk6eMmj3FMuSjxIjykON7oAhxWH7IlA6RGQ+GAplaqapdg
         Lbyg==
X-Forwarded-Encrypted: i=1; AJvYcCWdI08R8U+et385ZIzS0NDDC3WKI3c+g46v/DCdCmGegf7VSR4WVNaprK+3jo3NYk9JTOCtFj///XU17ROw@vger.kernel.org, AJvYcCWvhzZzN/3iBHU+ZlaN3sRqDKVOp+icnOXZkNJfmZgi0iczI0BttrTjNX1MYVIDD9d/3rmNo1EX3rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxo4v8F/G9BeFQ08R5wlFbgDpR+OtIIcI29pzw6rDj49H6lJI+
	rbF5DLYIe3pb53dgpqF5wR1NeeyGyKBsdTzrfrkeXlmIcGtWwDdd
X-Gm-Gg: ASbGncvJIYjyZj+Q7GYqTGXSH5/G5/3Ai40C8BwsBRzs5gX+8i42UwQZTg1gIEJEztC
	hwR22E7LkjjQ1zfy9o32WyyjapAiocFSVnE6stEMZfPpK7kmTxdp/CGg5vX7bUcRBPXsG0T75zz
	J2in/6IUogc+yNb3HYzEIEaVgdgQ7E+xSuCpO3FETUhgwyf8IFEtrPBbu3SuqqPOGt0AfTjMe7u
	c0uCCNds52erGkWjm7qdnGjJCM4GC9YcLlTRiBCOGXhlVm36OYQ3vFNmX4jL4oZhmAMLkCqzexN
	Z+EN6NT9ExRfyVhhR79NbeB4lA2Q7t6udsIcCmiKZPE4aQxoIXy9fA61vXay9bMQP9te5XVYBJo
	WUJ81iEjs7Vf08J1J00hf5ppKkg==
X-Google-Smtp-Source: AGHT+IG8fY7X0v+tdVefuJtzGWEzjXldFnY/WLDbVUoYb6TIjWsI4MlIACYTfj7dSZl8wkyUANlLfw==
X-Received: by 2002:a05:6512:3401:b0:545:a2f:22ba with SMTP id 2adb3069b0e04-54ad64f58f3mr863335e87.37.1742544063818;
        Fri, 21 Mar 2025 01:01:03 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647c9b9sm122400e87.83.2025.03.21.01.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:01:03 -0700 (PDT)
Message-ID: <ae33de64-1ba1-4bd2-a139-3f0b5986f41e@gmail.com>
Date: Fri, 21 Mar 2025 10:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
 <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 15:16, Andy Shevchenko wrote:
> On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
>>
>> Thus do not support the BD79124's manual measurement mode but implement
>> the measurements using automatic measurement mode, relying on the
>> BD79124's ability of storing latest measurements into register.
>>
>> Support also configuring the threshold events for detecting the
>> out-of-window events.
>>
>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>> out of the configured window. Thus, prevent the user-space from choking
>> on the events and mask the received event for a fixed duration (1 second)
>> when an event is handled.
>>
>> The ADC input pins can be also configured as general purpose outputs.
>> Make those pins which don't have corresponding ADC channel node in the
>> device-tree controllable as GPO.
> 
> ...
> 
>> +struct bd79124_raw {
>> +	u8 val_bit0_3; /* Is set in high bits of the byte */
>> +	u8 val_bit4_11;
>> +};
> 
> Again, this is confusing.
> 
> Just put a bit order map in the comment as I suggested previously.
> When I see variable name containing bit range like above I think
> about the same bit order, i.e. with your comment it makes like this
> 
> bit number	7 6 5 4 3 2 1 0
> data bit	0 1 2 3 x x x x

Gah. I think I now understand what you're after. And, I agree, I haven't 
been as clear as I could've been.

The pit numbers in the struct members:
	u8 val_bit0_3; and u8 val_bit4_11;

are _not_ intended to represent the bit ordering - only the bit 
positions. Like, bits from bit 0 to bit 3 are stored in high bits of 
this u8 - where the "0 to 3" was just picked as order based on it being 
from the smaller to greater (which I believe is grammatically typical) - 
not based on how the bits are ordered in the register. If the order of 
the bits was indeed reverted, then we should see much more complex 
conversions than what is presented in these macros.

I will update the variable names to:

val_bit3_0; and val_bit11_4; I think it should sort out the confusion. I 
won't go to bit level representation of the full registers:

 > bit number	7 6 5 4 3 2 1 0
 > data bit	3 2 1 0 x x x x

and

 > bit number	7 6 5 4 3 2 1 0
 > data bit	b a 9 8 7 6 5 4

because it suggests there is something very strange in the registers 
(which is not the case) - and it is hard to spot if some bits have 
indeed changed the place.

Yours,
	-- Matti


