Return-Path: <linux-iio+bounces-22247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78031B19B30
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 07:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C903B1638
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ADB218ACA;
	Mon,  4 Aug 2025 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcB57cyb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002917555;
	Mon,  4 Aug 2025 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754286986; cv=none; b=aRcU2ro4daKIxi+zpNSJK5Mg4O/quBPNhnfw1/mVG5x9Dh3QjioRhwCkUL3OJQta+wL5OXMEJx+9o2RbG+1/u35rt1yrjNeNtMJHJ2JLUUZbQ3WgQKGZ9HwFSQor5KbaUinV8pKEtKm4TkNVTA85zAjT6V0Vj5th5ntgsa3uc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754286986; c=relaxed/simple;
	bh=l2LKSIc+Y2ts0wor7Dn5/CMdqUCF+F+HSfgxIYKSOLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzkTEn1+FWZ4ShtS5BDa8Z6w7gF0t0E+AMG1pU7jGPbPNlyVBD/5I3jK25XrdlSJeNi2TcWZ/6LWniLX9qiEgE3Slii+yaWWk9Gu2VB0E6r4iavRFGoPzXRyNn/hcf0CruFWoxAABIK+QtzBzhBp1kJnOd0VYDKVMpO/S+nSnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcB57cyb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b85d01b79so4112668e87.3;
        Sun, 03 Aug 2025 22:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754286983; x=1754891783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2kYeiWAiln2b2xzXgbJxR3H30rgDfpUEAwD832j0AA=;
        b=hcB57cybZr0UFQR4Y3rcSaGdDECw4DgGANKErRvk82+SMReLLZUxOq+2+wSIvDty1X
         SCeTnzMSNF3d70c/t1sOF5vrZz5LS7qq6e592DIudINb+nHxSUHHYVvsI1vZsucRIqBn
         yKwnxkAxpEPNhuGY8PvZNuPr8UgZv1cITEcWpeiNEK9YHaSQcMPCA8NRqYyqMspqgs32
         gNTQ297W/Zv40doba3ioYF9VkLElB97RivJoc5miTQzkzjlTJxxyeydEooYhCc8tEwUY
         Xajj85/mUZOJOnGQOWN8+QiwYwAo+K4oLDgeeHeE397NAJmOHnl7aSkuNijpq33Oangf
         5dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754286983; x=1754891783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2kYeiWAiln2b2xzXgbJxR3H30rgDfpUEAwD832j0AA=;
        b=sMsvvg97LsGFbx0JwXq6qVUN355CH7CLKUMqsflqCCknX/o/CZhsPevVFVO4ADELAN
         sOaJa9gD+wwB3M9Yz/GzyorGjhMfDAwlCULddSh9CaO5v1ChB5Mrg7oUBZ37ZNDoLuSS
         ztNYHXkBkFJCfyJsgVvyDhB4E5jiXExElJUSvZWmDsbTRKw7EAxcJfD4b3/wXO/OQsyG
         zOTcNBFuHMkqEpVdGhurtUSXIZleln5iv4Zd+iNX/ZPq8ydHgiBwfgPfsqbed0egDulV
         NQ5g1EW0bYqQFSIpMEnU+CucjVY6SdF0eetXVvCkzOQJ0Uvj1f8FRCnqoFC1myYZDz5j
         gw5g==
X-Forwarded-Encrypted: i=1; AJvYcCVBsidvCGCmLQpC0WZQpH375V03/WYU2TQn3DHnyPJxePfYPBpk0ZkiSiLPesaz8NSPlVuVKyy98ZM=@vger.kernel.org, AJvYcCXUn/QHX784RKA3jN5Ng7M9zGMTEgw7RxMNhcFVXW2YYYPPUGK6HEW1mJ5m+bv2lxYwcjYIcetN2CU1jLO6@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9QBU5AJDoGnuCBggp6/MFzdYxveR4WDjBtoKZ+007o01geNW
	ntNE4YxcK4jJW2WtxbRA+EdU7z0jNvpEqK21DNhYtn9yIpocwbhr5vU8
X-Gm-Gg: ASbGncutxiN20nHOxGoq80REPhymlIrfuo87D1PkqfSnwxNZzDzTERpbCsAlmWQYKjg
	GP3ZhAo67whPhnyf9Tn25IFDzrBtQH4d0+7g8kdLNsgYWvTpdjGnhBxvYOHIvvX32at5Ak2y845
	7gjAT3VaS5/aW516RkNXpHfAFXgg9oVahg+oyk81A5vwGZAKyCK1kF8+1AqDbgh9Mg1ix8S/M2C
	jkI1TaHMHXsUAA4i2oHhSGzlf3ecYQ6BvRQPiyktxrSunE784o/WRaRIHT2Q9+I7XwRN4eegvC1
	6pGbUaSxW2LYRLvCQ1LAkk4nsgssH5VaLhewsYJ7WAGePIBNQBlJW6T5xYe5NZDP6zNBZnRU6C7
	iKbeibY/HyliSn4qvOatWNHXQ04TQSf4NgHXpa78pbKjIv7p3VhGiMvjGj0uHr1ZZp4SUzwlSfA
	S0qxE=
X-Google-Smtp-Source: AGHT+IFEBJh4jWDFEc7KSbEyOWPL+6wb5CF+lINXMmg4n23UsRzSERItQOTE6jvEWRJegZDoCsFqPQ==
X-Received: by 2002:a05:6512:b02:b0:55b:880f:38b6 with SMTP id 2adb3069b0e04-55b97abd337mr2051210e87.4.1754286982969;
        Sun, 03 Aug 2025 22:56:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca298fsm1529234e87.115.2025.08.03.22.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 22:56:22 -0700 (PDT)
Message-ID: <6aa66380-8109-472e-8869-bcdc4b0114aa@gmail.com>
Date: Mon, 4 Aug 2025 08:56:20 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] iio: adc: ad7476: Simplify chip type detection
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1754041258.git.mazziesaccount@gmail.com>
 <0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
 <CAHp75VerC+m1XMpZFO6dLp+0HdB1+Xn47on38Mg5AXfDYwWd4A@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VerC+m1XMpZFO6dLp+0HdB1+Xn47on38Mg5AXfDYwWd4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/08/2025 01:01, Andy Shevchenko wrote:
> On Fri, Aug 1, 2025 at 12:07 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> The ad7476 driver uses a table of structures for defining the IC variant
>> specific data. Table is indexed using enum values, which are picked by
>> SPI ID.
>>
>> Having the table and an enum adds extra complexity. It is potentially
>> unsafe if someone alters the enumeration values, or size of the IC data
>> table.
> 
> I don't see the problem here. I like the part about converting ID
> tables to use chip_info instead of plain integers, but other than that
> I do not see how enum is worse than the split version.

The potential culprit with using the enum for array indexing is, that it 
requires the array size and enum values (used for indexing) to stay in 
sync. Eg, used enum values must be smaller than the size of the array. 
Also, the chip-info items in the array must be kept in locations which 
match the enum values.

Yes, we have ways to do this, often using the last enum value as the 
size of the array, and/or using designated array initializers. It still 
requires programmer to do this correctly. Changing enum at the top of 
the file may break the array indexing (in seemingly unrelated place, at 
the bottom of the file). I agree this is pretty trivial issue, but it's 
still a thing to keep in mind.

Splitting the chip-info in own structs and using direct pointer to the 
struct makes it harder to get it wrong.

Finally, dropping the enum makes adding code which does decisions based 
on the chip-ID less appealing. It hopefully encourages adding _all_ IC 
specific quirks in the chip-info instead, which will keep the code path 
(IMHO) cleaner when all chip-specifics are in the chip-info.

Anyways, Thanks for the feedback!

Yours,
	-- Matti

