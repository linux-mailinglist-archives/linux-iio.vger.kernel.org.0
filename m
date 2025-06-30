Return-Path: <linux-iio+bounces-21152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F054FAEDF42
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963413AD714
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3B28B501;
	Mon, 30 Jun 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v8diNR3H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64EB28A73C
	for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290444; cv=none; b=J9Pek1Qv0oQLvUUTqkSHNdZw4Yd+41NBFEuvbG/OLnPnyZD9x/c9cZqBWJNpQLpvaUQ6A16NcAec7QHCI3i4CLLHprEXl6QzAgWvZ6oWh82aUd4lE18TRqqeHv8ir2hWkPvNarOO5M5Wu/8Ldwi8FUAOHDk1DMhu1Pung+vvEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290444; c=relaxed/simple;
	bh=+OYEUNuuqfT76DUEXC9cb8th/BNnZVNtFEhDcL9FgBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpM/zy0cI7qLPBDSVAR6mJr2804YRFcuNgYwXOnbu/03lArw6HPIFsYtuG2vhd3M3txyYLYssufcXijPpDvTZGG9zUuuZhqQ0DBuM1HB3YV+ryaVrK1gvkAeRji2aqGpUmCOszgqWViGQG+P3FUQ9rUoyHQ0jOLlfENjLlns8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v8diNR3H; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-407a3913049so2506224b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751290442; x=1751895242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BiiBnavNW6W4WxDDv13yLMK/TA99VJbY73iccUOu8o=;
        b=v8diNR3HsU3PDvWM/sNs4zmM8sIO1GHPl+Ku3+XOFYDi8aWK/kcRyCACuKux2Splt/
         bm0uq4yaKt5qeSApXvNk/KJgsZxS+pfLZ7lE1TGp6tE9h54VYaM9x1tbPfi++3X5u5Xk
         kml4V/8LJG1vWB01KONJQkbluOkF7X7IlwI/w9Z5zey+QgdDnxNwLxeesGecs32FVOZ1
         WAzI0BZPJlSQStnAbYoSduibF1GWOQhUh7qPOKfdydr2Y3unto86xIXRvas7P+y0aOKu
         zvAQmlNwNKBYEuXHtmR5b5NdVTldXG+Fl7T9/5B1s/GYvulieNz+IGpR6BDbHi4M05WC
         y8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290442; x=1751895242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BiiBnavNW6W4WxDDv13yLMK/TA99VJbY73iccUOu8o=;
        b=Sv8xDevjGuRpgzTeiTdUfloI7Fs4Yx2FkQBx+JKiAfEdIgG2PqSDCgofU5A8daXP4n
         LifCk+pNHf9oVS1sRor+x0Sryha3pAUz9WlL+N94LZtme7DkErJ4s9e9bmG8vPouOOP0
         J6UbaFHz0V6zOWzx4ht14cfVYbtGdd6qd+tRUJY8vmu7vLhYUFGUYZ4eJQPn/EP9w3lx
         3mhJRtv8mGiAhkF3CzjTsmwF45eAh4m7YFFw3WHtNS5BOGaeck++zp9BjWXeYN6/Zser
         URIlz0yTNLRUWNn9o9wUafBaMiQFmzwHapz27d7Srso+xCUhmLvknGllDkyMp+mi5HZL
         Cguw==
X-Forwarded-Encrypted: i=1; AJvYcCWKbJ3INKlwSUGFu9FOBR38pVcJJnoaiwHtUjvWVQ3r6sTHrmgayxZ2yuuE2huXL352ynAlsNmjbEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC4Dc3QNLElkBsQffF+YAaPSElkYf3/cGCMkZApapInEb0anbR
	A/JD+LyZH0876F7nNrSy8TjuPqnpgk74SIoE51PukiIYmDs5Nxg8+qX1Iw1/06Z/F9I=
X-Gm-Gg: ASbGncsCymUqd/esMJSmSo1Jhx1HICjvWJopQF+GOcF3nevgO6Di2uqTxUoCI9qV1dA
	Q/XM42katgp+L4sjHjWv+LSBrUOaF/jLJOJfLU9LtDm8FDhtO+Pasi46BMuITVkQ3pW8aJ/sbCe
	hPq7x71Kimrsj7pp/mUVWn0sVC4JI0Zzeir25B8py/GbWH4Ub0XpE/Ek4lpoiTSw3hQJIGJLnVv
	xFVJHNN3Bb8owrDRj4fXVcYikEl06zUMMVBdoVu4bWBs/xt0LP/Px/2XYL0xzReOStXu9ig/CkG
	MRCkmY5cfCzgDHLd7GnmidHalR5goJqTLMsYg421jMUTotUjnup1vC0ENaBEkI+PWZNuGfj1g6w
	zrpZpGhxtQRg7Iuk1c8bPfQ1/K9oRF5bXGsDkXH0=
X-Google-Smtp-Source: AGHT+IHwwHp/hPBSXiWOFPICfvksDPCGUtg2Iq6Zl8mO+cjrCNlALoXBQc3229XEU/HYM2O/8w7obg==
X-Received: by 2002:a05:6808:80c9:b0:3fe:af08:65b5 with SMTP id 5614622812f47-40b33ea62f0mr11211317b6e.37.1751290441614;
        Mon, 30 Jun 2025 06:34:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4876:5a0d:2fea:6208? ([2600:8803:e7e4:1d00:4876:5a0d:2fea:6208])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8474dadsm1077151eaf.5.2025.06.30.06.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:34:01 -0700 (PDT)
Message-ID: <e4c7296d-6afe-4edb-b26f-44218e660a80@baylibre.com>
Date: Mon, 30 Jun 2025 08:33:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] iio: adc: ad_sigma_delta: use BITS_TO_BYTES()
 macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
 <20250627-iio-adc-ad7173-add-spi-offload-support-v2-4-f49c55599113@baylibre.com>
 <20250628155643.7c18e023@jic23-huawei> <aGJR_YyW5tCMjxUD@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aGJR_YyW5tCMjxUD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 3:59 AM, Andy Shevchenko wrote:
> On Sat, Jun 28, 2025 at 03:56:43PM +0100, Jonathan Cameron wrote:
>> On Fri, 27 Jun 2025 18:40:00 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
> 
> ...
> 
>>> -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
>>> +	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);
>>
>> Ah. You do it here. Fair enough and no problem wrt to patch 1 then.
> 
> Hmm... Should the second 8 be something like sizeof(unsigned long lone) for
> semantic distinguishing with 8-bit bytes?
> 

Yeah, I considered to use sizeof(s64) to match the next line, but it
it seems like a separate change, so in the end I decided against doing
it in this patch and it seems too small of a thing for a separate patch.

