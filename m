Return-Path: <linux-iio+bounces-24917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD564BCDF82
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B73034E5F9D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF392FC022;
	Fri, 10 Oct 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K9/UGIm5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76F2F7ADC
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114094; cv=none; b=uJ6LTC+y/zHK2mDPJB0E9qR4/xG23VX+ql0KG0K1a3lIaJhJ0xpYcnJCa1/257W79lF/VkboyPKi4idQstlsYzzj9N5xQo7AT0ISU2vHzdagU4eBsfEZb7GXMAZlHeUndt1qrsePaMGrq5zFBk1Budp5L4uU+lzTCbdqLA+GCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114094; c=relaxed/simple;
	bh=3O2slgopZs0r86JaYoeRil/K7lBwFmbcBIiyfk8jC8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4FiDMHo5fR7PoAjHhh3VnNvqb7yPooBd+0gWZtsNed9XZVeP/ec53RewqysDapFTLI3TwHsVDjdlIFmj2R+Tm1KyH8clM7dZHsrWAZ+TCxqLOA9a+9L6IXuuC13spatdB0+enS1e7onCarjPCKaN9YlhBlPmEIFRy0AqiqVv0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K9/UGIm5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7827025e548so922322a34.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760114091; x=1760718891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFQBxoNurmZy12ZR9zqI+fCdGcn7hfBSxuCEMNcYPPA=;
        b=K9/UGIm5p6HiPGGO9yM4dqW0TI9c32Anr4phUlS86bYL/yFeSftbuyTkz/DDrMdUMw
         R3NbuMX9ScU8iH7OhahUQKXyA5eCu5rR/qUfv12erBmEyZzZEY7EiogSkUB6iiYEOdfj
         3vuh3Q4ykKUF4xRpBgJmRi4GFjWzLYn7/CGVbNis4PtcDYnC9el2KrRILIJ3q5qYUvZX
         myEW/cgM6032wMBR6scUUSFbLzI0mlz7hdnDzvTHmytrOOpoGbMsDi6iF9ioU/R91xTN
         D3fDdpndHyy+IRB06iQOp8327RH1JH61bs5FRgsTgYXNn4wCbJZ/UvHDXQIpwDy2S9ld
         lSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760114091; x=1760718891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFQBxoNurmZy12ZR9zqI+fCdGcn7hfBSxuCEMNcYPPA=;
        b=mHQ86ZsWxn2d5l/3PNf2z8gCed3rdqBVcULWBqY4VfnxlKHqeMT/jzjyR9wVq+SFVY
         rCXZpzfSf5sMMPzBRg+u/At2GkhH3YLvUp5aTyG9O3oWtg4oS1HSskFGpldlCHjo1PeJ
         Q2q0HxRtjwrQ/xe6EQ7xvrCp18RtvF56PlWZtEApnDx9hAAljUbUqTIJQ38ciIeTkXM5
         AcLYv0x24aHCWOTtj9psc5QOTAmGCoRoJTKQ6+nBELY0WI67RGdm3VyDu1Et5wPZ+mpp
         mY9py85OtUEVfekoXU8R9IumrynYwuB0usJxDKs5DRhEvMLUzYmY9PGd6j57EMi0mj6B
         Bysw==
X-Gm-Message-State: AOJu0Yw2FlPznsBuEYg3jUFSoqRymYote16ZlIUQ3dNq1Cj8ET7SaGCm
	pWzfKpPCUHCZiZ1GY4SFOn+fp2ZNJxCph3QgboUOmDBJuNYdenemW+JPGbN0ew8EKTk=
X-Gm-Gg: ASbGncvnQc7n/xFHjqET4hZlR7l2Gkg8qK/G/HQ/00VX6+sfguCm3w1jtfqTB1jhKhw
	RJNq2b4ZHDmcBg72qPqF9s2mcBnvhbxx2DcPT0LfC/WxH60O8UQ27ktKc1AFed0SGvwG22xvZ75
	3NJSMX6lvUn1XRQ+OSCcJxGJ3tR42JnVeyDhdYeKOpKudvBvIanAJPChhZB7x+1ttDW/f5MzRne
	BLeWBEAMnZe9+BbThNK4+5b7a8w9q3koDbp0Ap2KtpjZRAfJ3A+ui7bMbt4S3HKw0Ox5VvoHjt7
	EmPZCbVw2x6unPP6AHVKZFuvB5tQL49NdaaVt56WMdvWvcWxkYkXsprn6nFeqANyIfab0Exkakk
	UWGLCV9UlesgEe7aUNPpA3WxutB5tjwaNLgEwmtOh6dkfFjMJN02KXIQic8mwTzctMr5i8UmUpw
	nsGzXyzoSjv+fZaKMHHFNeiSgcyA==
X-Google-Smtp-Source: AGHT+IG9/7/OoQHlAG8tADy7YoqbVxyfvZROVmXiXdf1/YG7+lyaIrfsoJ0HIGLIpNwQAaE8j853Tw==
X-Received: by 2002:a05:6830:61c7:b0:759:55bd:9597 with SMTP id 46e09a7af769-7c0df7ff940mr6338073a34.26.1760114091519;
        Fri, 10 Oct 2025 09:34:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915fd4esm968209a34.35.2025.10.10.09.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:34:51 -0700 (PDT)
Message-ID: <3cb110ab-05e5-42c3-859d-34df721d98f2@baylibre.com>
Date: Fri, 10 Oct 2025 11:34:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] pwm: Declare waveform stubs for when PWM is not
 reachable
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, marcelo.schmitt1@gmail.com, kernel test robot <lkp@intel.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <129ff5c5b7f7be4f4f3f9cf8aa3e1957d713acb7.1759929814.git.marcelo.schmitt@analog.com>
 <cuq6eh3vcrkgr7tj3xpo7ax4ruiy4ra6fjxgu45a3eqs2jbtah@ualgnhdwxnih>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cuq6eh3vcrkgr7tj3xpo7ax4ruiy4ra6fjxgu45a3eqs2jbtah@ualgnhdwxnih>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/9/25 11:58 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Oct 08, 2025 at 10:49:44AM -0300, Marcelo Schmitt wrote:
>> Previously, the PWM waveform consumer API would not be declared if
>> CONFIG_PWM was not reachable. That caused kernel builds to fail if a
>> consumer driver was enabled but PWM disabled. Add stubs for PWM waveform
>> functions so client drivers that use, but don't depend on PWM, can build if
>> PWM is disabled.
>>
>> Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for waveforms")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202509272028.0zLNiR5w-lkp@intel.com/
>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>> ---
>> I've included this patch in this series because it should save us from being
>> notified by 0-day about the build failure this patch fixes. From contributor's
>> perspective, it's easier to have this patch together with the rest of ad4030
>> series. Though, no objection if kernel maintainers decide to pick it [1] through
>> the PWM tree.
>>
>> [1]: https://lore.kernel.org/linux-pwm/1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com/
> 
> TL;DR: nack
> 
> I replied to the original submission about why this patch is wrong. See
> there for the details.
> 
> Best regards
> Uwe

If we want to avoid this patch, then it sounds like we should use:

#if IS_REACHABLE(CONFIG_PWM)

in the ADC driver around any PWM waveform code.


