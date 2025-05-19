Return-Path: <linux-iio+bounces-19698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B724ABC2C5
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115C43B2AB0
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD597FD;
	Mon, 19 May 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw3h4Bop"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7943147;
	Mon, 19 May 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669463; cv=none; b=DiPZ5OOu59u/SQFD/rUcdSOgLwxrVEtnrpUFhNmbboxV4EbIQ/vWr2G2VCeetJYWxBY8dKkaCmfW+XNyrWhCgdTPW/6JMIecELpYuZeUtoBOBxFQ6y+3HuA7UYjKtB9CwCWnqx1gGVO2aF72HOR1GvdJNJ+rtThu7WLGyYOe1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669463; c=relaxed/simple;
	bh=hY99rM+U5c4gdcr0+jk8oBnWuVZotBnsA/AsRikFbH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkwBymlTyEDHJfh8ue/+T2tZjAknjcAXAX22wrAiIJZe6RGc+0fTEuwa2LOm1GnGzP8Hyf6t2mzDlmzmXp4pecqCwGaSPL9q2wpA+fkZmhv2RjrgFsn0iBbsRO2kHZ+0C8GyLg9SDjXCWsqhc18lbCvpJxbTqzaawPUFoWrDo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw3h4Bop; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso2203473b3a.3;
        Mon, 19 May 2025 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747669461; x=1748274261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JX321/FgAZwCnEsb+MKi2IskEDXwguYpyi7rU85gglw=;
        b=hw3h4BopHK7GRCnJxlzWzMwOVzOaML4v/mkvq79iHcWzwPIi+ddIXaNf+4KcIyLxJU
         rmtL9Jd31zPpACuMxwhxjLsEUBg1csGCDG/zqGf42G8HSEfH5ylw8pM5EQn/q/l0stod
         py2B/iQ6WIkXReDF6caa45ezSDc4PNrGUg+zQMKJRrO6lplxv4nOyxzTHdq0TNl1uMay
         Y1oRYLBcN+/2PnoGUuv6T88nhGFQ5LjNWVwlBXpELbnhbawWJm7wy4hhdrQgnqo0XupY
         uGss93eRB512SkkTcKI1VHwhO+9L2N2Hu+HZtKHmxjO3qKuv72yOBP7892yPU77alsOa
         kaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747669461; x=1748274261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX321/FgAZwCnEsb+MKi2IskEDXwguYpyi7rU85gglw=;
        b=BFA1bnnHrEw2pvRDST3MhwGNGJtmPwzGuW5koQnkHLf1f8R0HShQfhkKp/5mRCbpJT
         dOw7aZAlPbmDesM+p/YkGrdcNjaEsysmSjahLgaLSWCQ/PheO3N2jFTqqPp5mrPBqpnu
         FNTX/bq6OQNrsLN2XAI71MfDPKAs6j3otBZPh26U+8v8VlYs37TqgKRQtfOhL0S9qhdd
         cpCG8p0D3ItfZeWaVQq1Dv4ZQL+mnoqgq88Ssmue2XNxYLX8EYc8cLr6CTJOisczZRWU
         q6PddJqZiDqQInLSmwnopbgY6ZuliPiKlmyoyN9l9TVeG1FU6pGieoGkITNjQ9GfaG17
         OXtA==
X-Forwarded-Encrypted: i=1; AJvYcCUO5/tciMFm3JXz35IelpXOQldFr0ep1aNqZsFfiQ+RrU0GdteiUna/hTRppSxHG/4yKly8u8/20DKutQJz@vger.kernel.org, AJvYcCUmHuPcJnKtrIB2jZvo5gX8HRHeu/lAM/VUVnrpsegPieXmQoE3EqMvO8bVNLsPFK98mWnEOwFGQSF+gw==@vger.kernel.org, AJvYcCWClwGHfpSWlFZIYBu7b4d0bMS5eYTvNdCEvtMUsVENZXOau4xRUInagkKVGtNvNtNWRRbCOSVe24otlVnJYZA=@vger.kernel.org, AJvYcCWed+do1fmuizfXEOHBdBpLjw5GCE89mgf/7R2Ufw/anLfrcooncrAMiYpg+9wfA1vcoAI/al5kzthcqw==@vger.kernel.org, AJvYcCWlu+zVmeG2UpHIw1vWWn49xeV9Iudq88NcLKkkh7eVomzpWYobRloQUEYVWnGQ1p7P1vLJbZ9HUbpd@vger.kernel.org
X-Gm-Message-State: AOJu0YyBCm8/kMPMR2V11xxSXawFVEk4jpdz4Yw1FDM1fQk3BqurwdEy
	I/85E0IMtOK/ZHMUWil3vNDQyBcKD8Ow7mrgdFXIspp+8LqjF4WxkGGz
X-Gm-Gg: ASbGncvtadyFXqiqQpGM5JVwyuRi6sjaFrWxQuFcTFdVUmAObyWy2K51arhZK/Zty9n
	5h9fvOBHkZDrvThC5g5KssGTyBJdkYhOWv9E+urChWVYxdcrvti4KFBZ5b780O/0yoryathKmfp
	+qTdgQhr+VvAXXlflVO25jqXf07kfx7vFXsuKdJ1WhlJO1qfoyFepQqnvRNO6jkrxWF7kELTWFF
	tWo1pMbeY74uJDe8aqZqB4Zvj1X7gVx2kJJSnPScDGrUlWzZQLaF8CwFK8cv8BQnUshB5SMhZfa
	WEFWWgByTq5fmbJrieBzkn1EQdMylicfVDc8YXSp9v5sFrE86jqs+Cn2vf9XTmImEapntMQ9LD2
	0U9+E7vYreE4HhX61s67HhXJj
X-Google-Smtp-Source: AGHT+IFGTjhoYQ0jqt6HsU1gJsXsNLQ2KFfcUPFCoQJNYtVIdg6DXmJeUIlJ21qhJEK6rgHvlVoCJA==
X-Received: by 2002:a05:6a00:3a14:b0:740:67ce:1d8b with SMTP id d2e1a72fcca58-742a97b7a1bmr19741278b3a.7.1747669461358;
        Mon, 19 May 2025 08:44:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a985fad5sm6323370b3a.128.2025.05.19.08.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:44:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d5f5ac0d-830d-47e7-bb2c-55ecea7eddd2@roeck-us.net>
Date: Mon, 19 May 2025 08:44:19 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/16] lib: Refactor find_closest() and
 find_closest_descending() from macros to lib functions
To: Alexandru Soponar <asoponar@taladin.ro>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: jdelvare@suse.com, jic23@kernel.org, pavel@ucw.cz, lee@kernel.org,
 baocheng.su@siemens.com, wim@linux-watchdog.org,
 tobias.schaffner@siemens.com, angelogioacchino.delregno@collabora.com,
 benedikt.niedermayr@siemens.com, matthias.bgg@gmail.com,
 aardelean@baylibre.com, contact@sopy.one
References: <20250515081332.151250-1-asoponar@taladin.ro>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250515081332.151250-1-asoponar@taladin.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 01:13, Alexandru Soponar wrote:
> This patch series converts the find_closest() and find_closest_descending() macros
> into proper library functions. The conversion moves these utilities from macro
> implementations in util_macros.h to standard C functions in lib/find_closest.c.
> 
> The first 15 patches modify individual callers across hwmon, iio, leds, regulator,
> and watchdog subsystems to ensure they work correctly with the new function-based
> implementation. This maintains compatibility while allowing the final conversion.
> 
> The final patch implements the actual refactoring by moving the code to
> lib/find_closest.c. This approach was chosen based on discussions between
> Andrew Morton and Alexandru Ardelean[1], who suggested that a non-inline
> implementation would be appropriate given the size of the functions.
> 
> The refactoring avoids of macro expansion-related issues and proper function
> prototypes with well-defined parameter types.
> 
> Links:
> [1] https://lore.kernel.org/lkml/20241105145406.554365-1-aardelean@baylibre.com/
> 
> Alexandru Soponar (16):
>    hwmon: w83795: Fix type incompatibility with non-macro find_closest
>    hwmon: emc1403: Fix type incompatibility with non-macro find_closest
>    hwmon: ina3221: Fix type incompatibility with non-macro find_closest
>    hwmon: lm95234: Fix type incompatibility with non-macro find_closest
>    hwmon: max1619: Fix type incompatibility with non-macro find_closest
>    hwmon: lm75: Fix type incompatibility with non-macro find_closest
>    hwmon: ltc4282: Fix type incompatibility with non-macro find_closest
>    hwmon: max6639: Fix type incompatibility with non-macro find_closest
>    hwmon: max20740: Fix type incompatibility with non-macro find_closest
>    iio: ad7606: Fix type incompatibility with non-macro find_closest
>    iio: mcp3564: Fix type incompatibility with non-macro find_closest
>    iio: max44009: Fix type incompatibility with non-macro find_closest
>    leds: eds-mt6370-rgb: Fix type incompatibility with find_closest()
>    regulator: max77857: Fix type incompatibility with find_closest()
>    watchdog: simatic-ipc-wdt: Fix type incompatibility with
>      find_closest()

For the hwmon and watchdog patches:

Acked-by: Guenter Roeck <linux@roeck-us.net>


