Return-Path: <linux-iio+bounces-14520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F3A1832A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 18:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44977A212F
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674251F4E42;
	Tue, 21 Jan 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CymvppVl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF441E9B38
	for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481519; cv=none; b=H7CRBf2Jo84Td0Fe2dZGMWjOPpcYQMGizuMHciMeHS3p4HhAfbDvk6yvNA2m50Zysh2N9+QG6Y9VHgTQv2GIfS19YA4kbUWurYUV7wNEDP1sWAHRMV0DUkSIqo76TVDkhXppzXMTCIl8FS7UG6Ehmdc7QtJjTZJlObA2FvWoh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481519; c=relaxed/simple;
	bh=qW7lgtx1NXRyO4nNtRrfa7jbD7BqM70uxiOODd0SynA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NW+2FSUEjx4iRtUStnMsGXKUCvQwAvyaoUqzTievKtpF/GpW58Tk8X7H8TPxVpWJUYP8ljHjvpa4py/4YgVTwjXiU9d/XUNeEctdIcHW+c0tFMCo+ybruvQXa0IjJZbBoZvkWbMeSLH8WbBHN4qv339TTlv10xhvCX786Ts25gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CymvppVl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29fad34bb62so3350206fac.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737481516; x=1738086316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFPlf0fcfXdm2Ps7qwcaDy5IkXbtJsI7nT9CQInAONs=;
        b=CymvppVl5emQT76QCxCzWetZbKBBAzRbefAySQPf5fJSFniRhXAN4J8C5hmFcdg2Uy
         NyiTepyMpqpxKmzVf8nmhcSlWI+2bFch/yGt8V6RedSnepVGt8Pr4PAmWeCWfZiP97zN
         3LEa6SZLy/qkwCk4DX6iAMm18Mr+YvML7UdLjY2eSXoMgwlrCYWgB4yDWpBAjzPfAqXN
         yDmWQBC8aP3gEh1Ytbma1U49nsf7o9fef4pN9UaNqA52HtLwnUP0SsAncxUpuexNeOpZ
         0jEvpvWE1obqQEIChMwxR1uYV+vPuUj7LDa+8in28RGmrUaaZqSw3VmQpSi3aJILDPWA
         3ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737481516; x=1738086316;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFPlf0fcfXdm2Ps7qwcaDy5IkXbtJsI7nT9CQInAONs=;
        b=MMueMuZo4fyqjl9PoQXGdl0qXGu3+cYUvqA1bxEq1pB816DQIkxxk/K93eZcPajWYx
         uEjgD5yNebHZMBH8nJ8iQfnN9QRAopLP8Svb5Z20+UK3DNBAdTEK51cl41s6CbRd7z6j
         olXXtqwmChDAjI/qOZSwJ0DaOPWAENwhodsXo/WIVXWO3N1CWH/p69RKvXl2YQ5h79BC
         IB9PmzIpyvIQoZZVesa23UJ4lZuzqkPnGt7RMvJ9zLRCqxc4yYAFKJsSlTCdN+Ti9IuC
         etaoyBll56lKH3TBPsm3IslhiUccuifxQs68nFNnrkXqjMTqRu4H08oGsFOPbuEGqrcO
         R5gA==
X-Forwarded-Encrypted: i=1; AJvYcCXLrIfxvXFPyXY6SFYspypWwxzL4Bc5YBYfKKVUL2lD6SvX0ZKHFd7B1YKf9abF99jEab0s2NIPQwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSC4/QUXPiPT5QhzaXAv0LYOPWJw6IPGjNnSgKI+l0/j+jDq0
	WNf3uMiDMIVY64dKGQFu1jI3Sv9WIb4AXi+Scf1f8xicbbPKMFpm5bl/q7y7wOE=
X-Gm-Gg: ASbGncusNGQwwzccbDdbzpB2Glmr+AfAYuIUEmZjiCdqDhmnVvnY0/htCrGhV9d+vGP
	AehfCAhivLzDf76w4mlrdW/+0/yJBPaRNytw+jgjJt1ZY6wSH3OlTEJLlkQp6RX3JDayeBYEQPd
	LnPAVLHPr23u3cT4sQ5z33dQ1NLkmwe5TLROoceOVMwfgK7o7UEkPO2/IiphEjEh7cySR0qMA2d
	AVM41wvUtNYfZwKmalbuN9zWvfC/x8ibtDjW4U0BZozVZx7qHfsqkuS7mucZi9HRUBgcyLd1v/2
	UKa4wAQZ6W1xTnsdZ5GmBrZjkWOkte4=
X-Google-Smtp-Source: AGHT+IEgfdprwgucyNPXv304ky4DmwpyYonBJIkMSm1CRqaY5wyRbrLL3xmGRG3yr6mliYkwxF1ugg==
X-Received: by 2002:a05:6871:a4c7:b0:29e:6814:19d with SMTP id 586e51a60fabf-2b1c0a0b434mr10780536fac.9.1737481516103;
        Tue, 21 Jan 2025 09:45:16 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8c8ac66sm3806278fac.8.2025.01.21.09.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 09:45:15 -0800 (PST)
Message-ID: <ed41d313-b918-4c55-966e-10cc8a2e6b18@baylibre.com>
Date: Tue, 21 Jan 2025 11:45:14 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Q] Frequency & duty cycle measurement?
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 linux-iio@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, timestamp@lists.linux.dev
Cc: William Breathitt Gray <wbg@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Dipen Patel <dipenp@nvidia.com>
References: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/21/25 9:19 AM, Csókás Bence wrote:
> Hi all,
> 
> we want to measure the frequency and duty cycle of a signal (relating to power consumption) using a hardware timer in our SoC (Microchip SAMA5D2). The hardware is capable of taking a snapshot of the timer value into another dedicated register pair (RA, RB) on the rising/falling edges, and a small `devmem`-based userspace utility was created as a working PoC. Now we want to move to a "proper" kernelspace solution.
> 
> However, none of the existing drivers seem to be able to do this; the closest was `drivers/counter/microchip-tcb-capture.c`, but that only seems to count one type of edge (rising/falling), and cannot give us the time between them, which would be needed for duty cycle calculation. The only other driver I could find was `drivers/clocksource/timer-atmel-tcb.c`, which again seems incapable of such measurements. Therefore, a new module will probably be needed; the question then becomes: which API to implement.
> 
> As `microchip-tcb-capture.c` uses the Generic Counter Interface, that was obviously a first stop. However, from what I could see, you can only represent (1) the number of times an edge has been encountered, and (2) rotary encodings (quadrature and direction-step decoders); and not the time between edges.

You might find some interesting reading at [1]. A few years ago, I started
adding support for an "edge capture unit" and timer on the TI EQEP quadrature
encoder driver in the counter subsystem. I never found time to keep working on
that to get it merged, but I've actually been looking at it again just last
week. It sounds quite similar, but I didn't consider the possibility of looking
at the duty cycle, only the rate.

[1]: https://lore.kernel.org/linux-iio/20211017013343.3385923-1-david@lechnology.com/

> 
> IIO_ALTVOLTAGE and IIO_CHAN_INFO_FREQUENCY/_PHASE also seemed promising (although the lack of IIO_CHAN_INFO_DUTY_CYCLE already posed a problem), until I saw that all current drivers are frequency *generators*, and not measurers, the latter seems to be completely unimplemented.

A similar case came up somewhat recently [2] where it was suggested to add
IIO_FREQUENCY to be able to measure a clock frequency [3].

[2]: https://lore.kernel.org/linux-iio/20240624173105.909554-1-jbrunet@baylibre.com/
[3]: https://lore.kernel.org/linux-iio/20240629204025.683b1b69@jic23-huawei/
> 
> The only other contender I could find was the Hardware Timestamping Engine (HTE), but again, it's not clear whether (1) the API is even capable of relaying duty cycle information to userspace and (2) if it is, how would one go about implementing it.
> 
> It is also entirely possible I missed a driver or API that could handle this better, if so, please don't keep it to yourselves.

In the PWM subsystem, there is pwm_capture() which allows measuring period and
duty cycle, so could be exactly what you are looking for.

> 
> So, how could one go about implementing such a driver?
> 
> Bence
> 
> 



