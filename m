Return-Path: <linux-iio+bounces-16062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3185A44451
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 16:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E81172A02
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E426BD9F;
	Tue, 25 Feb 2025 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RUYgTBkL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D49268C7D
	for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497220; cv=none; b=aLpfPshuqD+PS1heqg1M1i2AyB4CLI9V5IiBmeBHH6rPyoaVEi5FxSN25L4q/dSAtCFfGIU+kMiXps7vG9AsinLY+Kp0Cuq70LwSOvvUYYeCSNPDgNsb7iNaAaOIKWoiTAtyN1GsDrLp3M9y59Pv/9D21wNVvRc+NOQSS7fnLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497220; c=relaxed/simple;
	bh=R3eOfvTKD8GbF+X93jYcj93Ugx4SD0tD0JNmsutwA+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z3gdaWxIgZ+2x9kF6Olq6o9fcJ0TtfQsM5d2OhLcADEcAw7AiE9Kl5PJtuRwEujblvC9WQ0UgsZT2EueFL3AcQaim3u3XHzSDNKPb5d5tygdps7OQ7WraX8DaiOOgkSazv87gdqi7xyfGt1v7tjCxCz3CE398rCzs5ybiS8UYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RUYgTBkL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7272f9d216dso3159612a34.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2025 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740497218; x=1741102018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEFMtqXWJ11nWI2h5TBKW+yhwiEH+1Jx79XU7n+Tvio=;
        b=RUYgTBkLJc5LcVmJKtlOa7wXn18qyGd8nUJcH6hAelS/mZOyWGLFKCBwC0ZAlJ+JyD
         VsOAwCt80OOkaQYpJ5D+avEDU8rjUh0IOg1wzOZo8plr7Bf+48ebEknTTBIsOoE7bPic
         glQLOOVc9bgAn7Kb2oXJj+WGuMAptlZ4dy8lj1rQx8K6dw18WLiTDTQHnVX0WrZCY58u
         QXuNEcKwKLW286CwJPV47//X3nbWmpwM96clBnDNBWeTIIw35HsHT1dFrMv/5aD9tdSF
         2cH1x0u0TgMd1BsWb2Gsld6GTKXn3s8v2Jz8PpdrezpDlL02hUXe5dQS5vRWZW9eZhtD
         RqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497218; x=1741102018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEFMtqXWJ11nWI2h5TBKW+yhwiEH+1Jx79XU7n+Tvio=;
        b=cA+2zchj/FS209/S385WVbvIwIG4/nBHVb4XmR3kGpjzpmQz3FRuP0rNKV52NwJ6Gs
         86N7LW6JHpxxQthFXwHx/mKaAII/oeDlqAvDQaEuKwT7Q0V91SnKzp/z0jcSqDF9SNjN
         j9VpQyZbo3DnSKvWKMqLxZLfHakSoDjOClhcEBP199eiTiZGGIcqHMmel5fJD46RjmB3
         jEztqyxGxUnP+ZTYlz4Dg3ckjUX7Gt2WcVyQphQLdg/FOkB73PVlRMXLrzkjYDLvs3Mj
         wSCg+1w0VMoHeSJB/iWkiyy75nE1ISwIL5/XJpJ/qcaE/dX+45/E+4o3X2t0jNbdVMFS
         LpyA==
X-Forwarded-Encrypted: i=1; AJvYcCV5P/DuQXzTfdDuArhxASDzno1Tc5ZauDLijLuKWcX+Tvky3UZtREH7EqHxdeX/Cu+Wd9y0qgLElrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmLmGPJEbtZuVN0tacJGHiBJX5wNMMexJuCrJJ7i7q9QPZ4k1
	+iVSwYdy+B1NRtFTwGuM8ZMRi73CDOIZBafK+u+EXtH06c7b9ZC36xCrK0fKqmgFiJmpnKz9n14
	I
X-Gm-Gg: ASbGncs+pYpiASms5x1bQVlwBSc24cFNHqKPr4P2JmIL4jaWBNFRqpJlfB9BSyiiMIn
	eFBE6YDpzHZ35wKFIFoX4TvHzhLrOAQWqlAhAaIk6aPq1cBzwFX3+XIkW5nDxvN1k2TitMkGvMs
	Z4Hazyqo0xMS4hag3ZmeRIY3xSC0cvst/q6nPArH9aEtlQXFP9WbZUZFYba+4rRV5Vrl8gTJzmp
	JH7V7N8DYX62gpBxVpYr5tglhZy2pkErgNglqXYMlVaOFWPTVuT9M+ZCbGbCiIruaSW8kT98oTC
	WGwMPGYzP5wLsERWzxkpyRzhDR0SKEapySJQNhk9yE4OveL4P3uYuQiYX+gal+s=
X-Google-Smtp-Source: AGHT+IFGCyY/0apfFgHzqIrY9A63Ru1cUYpVgHHxAiTBgOOrsAuBzOUsIBrLonLqsT9Pl1DiMc3++w==
X-Received: by 2002:a05:6830:2b07:b0:727:2e61:c831 with SMTP id 46e09a7af769-7274c235252mr14195332a34.25.1740497218150;
        Tue, 25 Feb 2025 07:26:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-728a42cdcd9sm25002a34.11.2025.02.25.07.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 07:26:57 -0800 (PST)
Message-ID: <d1af7490-5d91-4b30-a86f-8df3a8d17af7@baylibre.com>
Date: Tue, 25 Feb 2025 09:26:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] Documentation: ABI: testing: ad4080 docs
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
 <20250220135429.8615-15-antoniu.miclaus@analog.com>
 <8f588f4b88d122815df694660d19672e8ccd3d70.camel@gmail.com>
 <fd3ba169-c5e0-4405-961f-d7c11c68dffb@baylibre.com>
 <3f4bb345c1d76e7521d8bdbf4b4552e727c7dc1c.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3f4bb345c1d76e7521d8bdbf4b4552e727c7dc1c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/25 3:16 AM, Nuno Sá wrote:
> On Thu, 2025-02-20 at 12:27 -0600, David Lechner wrote:
>> On 2/20/25 8:53 AM, Nuno Sá wrote:
>>> On Thu, 2025-02-20 at 15:54 +0200, Antoniu Miclaus wrote:

...

>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate
>>>> +Date:		February 2025
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Set the filter’s decimation rate.
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate_available
>>>> +Date:		February 2025
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Return the available filter's decimation rates.
>>>> +
>>>> +
>>>
>>> I'm not yet convinced we need the dec_rate custom attr. I'll add more
>>> comments
>>> in the driver.
>>
>> If we do need it, in another driver recently we concluded that
>> decimation rate is the same as oversampling ratio and there is
>> already a standard attribute for oversampling ratio, so we used
>> that.
>>
> 
> Yeah, in theory decimation is about averaging samples. Makes sense to me even
> though I never thought about using the oversampling ratio attr. I was biased by
> the IMUs drivers where we configure the dec_rate as part of the sampling
> frequency attr since these filters directly affect the chip ODR. 
> 
> Out of curiosity, how did you handled this in the other driver? I would be
> tempted to only allow reading the sampling frequency attribute which means that
> the oversampling ratio attr is the one we can write (which then directly affects
> sampling frequency).
> 
> - Nuno Sá

The other driver is still under review:

https://lore.kernel.org/linux-iio/2c3ce1701545e435238605342397e45657a0fb2a.1739368121.git.Jonathan.Santos@analog.com/

It is modifying an existing driver, so in that case, we still have to preserve
writing to sampling_frequency even if that isn't the ideal way to set it up.

