Return-Path: <linux-iio+bounces-15497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA3A34BD3
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 18:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF481882BBD
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E820766B;
	Thu, 13 Feb 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qpw5VAZi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DE2036FA
	for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467527; cv=none; b=SSHrfPwrjTTzU2PbtBip/JQCCa6kl0qJTDMEaGvkAw7tCeJYv0QaXaMoiVASmJ+KtsW6n1Bsa36txASF1NtNtRBCGJA4MjDp1k408D7GrhoPan/TB1nPlR5ZvZDML3mGwZBcDn8OO0zXUsSK6+O95C7Riwuja7StkKH5We8wc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467527; c=relaxed/simple;
	bh=h60vbM9Jm6zaTd85iyob/nz/7LZiBLiFuNTQdv/csWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iG50EZ6xa+xXmDRP+ulQFvsmzgkjx6o0DZozvlwI2dcvOKEYZBwJaK1AVruSwjngXQTROOwn2AFMCgxPr1gQfFkYYM0uVEpvsxia0EG4quZq4ikloY598OuSydYRirD9gp0ptMZ/aZW08KuGB9jx+cAwnO+89NZ4sQ1cAluXX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qpw5VAZi; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-726819aa3fcso722007a34.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2025 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739467524; x=1740072324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mp8WnurnIDwQ4N7+32kRAbs4w5dFYFrQQIq32Y3ZWhU=;
        b=Qpw5VAZiW0z1sw+g0eMb4K0BC7svOU1K4X5Tb33HGYlkaxm+tE6pgGP/ma6CQePrL5
         SoKGuP5cBKtw40VCu0D7PR/TpvSGBjJXZYwnUvqTfllqoEcxTn5gG7DysyOMo9Xgz4q7
         oyNI2Zc+07H/aUU9HLZaTdRINRovyxZdycQ2TE+ld82H2RC6tfAfXZYTHqdgIY6pIL5J
         2yZ+UNlSPsYgWsbSRqJ4qzG+GnNnylbKyMQDgDtEgyeEYzX4FiTWp9xyIsodKTGXWiZv
         FxKRtV2uYYF1PLVdW0/UedqZJ2uM7g+qNGOns8PI15O5SHczUo7Rgve6nXuTvmbZfz5x
         Flsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467524; x=1740072324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mp8WnurnIDwQ4N7+32kRAbs4w5dFYFrQQIq32Y3ZWhU=;
        b=HCc9t5A0XvZiiJfXFo644eSENh3CnbXJniDU86rtXCdPWfQQFRiR3w69bAjSRhiIPW
         MgE7LlENlRl+jY5wOFJBIAJ908iTNlr8DfXoCt3ulg3880axWzhi2xLV5j+8w0m7D3pu
         C3JLkEc/rxpumCojMM9dBVFpwOuHNfUlf+c3fYV6J95tZ3nV2ooPW9OnojQn6vshxWGu
         7FTFNQwQ/eUKZy5FoozcpNZPHValjWtTLFxSYs9OSFVZBhCtmZfwjAOfx5V/z2fYWzNv
         Ymr9Z49qzRmTElCFtwuicSgIoWCcq8QNH3uEFl7LgqPOoNqaoW/ECGo1e0gvmz4ODBb2
         Q98w==
X-Forwarded-Encrypted: i=1; AJvYcCVjB0OP8vaxmIOCXdRm5gOQVVOotYBAc9EN4aamFIaRJb7a03hbl20CzmhIxOf6peeIlY0m9TsJNR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJUbWpb4JpNS86GxauF515bDnXaVuD/27YsI8d+S6ihhTIB6s
	wYOdOBVPUgY/8GL76wxleXr8WNDXCO/4oC/iwO+gR+nnsUQ9u6AEueuKrnLIB+A=
X-Gm-Gg: ASbGncupz4fkbV7Uj17EHdeq6+3P1IkvnT3pt7Tti3hrQKqJsvrJOOk1MTMFr4rjx26
	jXNHo45HIw/rCnMravGXns9gVOG03P9W6coeXkMPcuEZmySvLQ+yGU+uNkBNOnD9F+SWC1Q5WQI
	l2LLUOn1FWno06dswD7dc7UBbUviiouj6DmSgrsKy709kKqXylaWA/YYbA3iASG+P2PP6OJILYA
	TdYPPHlBoYgLOAognarfOWZZTC5JQjH0dvpjzEHWAUNND4vqcd+iD5yR4tlv6i1Mmisrc+yg1EM
	m2z0olDgYI+5Tw422fUbbcil0gfFYAyttShzzFkOBQMo3GLfO7Pe
X-Google-Smtp-Source: AGHT+IFRLkc52JKi83ncUWwAgxo2TvaFCE/dbkTZNE6D15ISJ0Y8Jn4hp2Y0d5PwcxAk7Qj4zAr0dQ==
X-Received: by 2002:a05:6830:6b03:b0:718:41b8:5d6d with SMTP id 46e09a7af769-726f1d8aaa8mr6076689a34.24.1739467523802;
        Thu, 13 Feb 2025 09:25:23 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7270025806bsm743771a34.53.2025.02.13.09.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 09:25:22 -0800 (PST)
Message-ID: <801b5364-129f-42e9-bf9a-a90d9eeb4629@baylibre.com>
Date: Thu, 13 Feb 2025 11:25:21 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add
 gpiod_multi_set_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173935301204.11039.10193374588878813157.b4-ty@linaro.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <173935301204.11039.10193374588878813157.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 3:36 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> 
> On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
>> This series was inspired by some minor annoyance I have experienced a
>> few times in recent reviews.
>>
>> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
>> having so many parameters. In most cases, we already have a struct
>> gpio_descs that contains the first 3 parameters so we end up with 3 (or
>> often even 6) pointer indirections at each call site. Also, people have
>> a tendency to want to hard-code the first argument instead of using
>> struct gpio_descs.ndescs, often without checking that ndescs >= the
>> hard-coded value.
>>
>> [...]
> 
> Applied, thanks!
> 
> [06/15] gpio: max3191x: use gpiod_multi_set_value_cansleep
>         commit: eb2e9c308d2882d9d364af048eb3d8336d41c4bb
> 
> Best regards,

Hi Bartosz,

Do you plan to pick up the other patches that have been acked
as well? It seems like most folks were OK with everything going
though the gpio tree since the changes are small.


