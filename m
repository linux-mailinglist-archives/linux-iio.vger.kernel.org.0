Return-Path: <linux-iio+bounces-17184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A12A6C400
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 21:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A70189DA47
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818E22FF32;
	Fri, 21 Mar 2025 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yzfYBCdn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556B22DF95
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587925; cv=none; b=Dj5Hbm1rjy2IfQwq7frkAIgxv+k1fQltM0yXmLnBG0wvHembo6BCqHpMxTtsVI4614E7h4BuezLXAdxbElrv4IDj46KFj6kXppUD4W8bsUwTMdg4PUqs/+i63+M8yKO+j4vTUCQROBG/yf5a9FLwwZBUTOUNI76Qsock0iSLxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587925; c=relaxed/simple;
	bh=hgo5F8h+Z5rr3chs5DifIfiWaOyXhg0eK756Iet55RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI5zirHNqNNpZTge4WFu3V7ZBQw/tZE+ZU8tAV+6CSgjvF/txFOi9THwrDAadJ9ZSFwlRG8XFbFn4GkaPvt58G9oQ6OJ9F7+xAOsWOgozIdIsNWpueBaio793qla3t2jKwVcgneib5pVvsMym7SB8/KsOkWwTts0TJbi+bF7kMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yzfYBCdn; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3feaedb6670so1377018b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742587922; x=1743192722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccG9w73MG8ltY7+ND06i6LTf/TTQC5xPKuyTK8RSyKM=;
        b=yzfYBCdnjhTKSeFe7OPQn8MkiJvsEGYsBrqIXNiwrs/0oj8DFd5eVMmEb+KLw0CE/M
         FE65h8/8mqo0nFoM9tdwfZpgEqcgAl4IPzss16QbgQg/gZTFC/5RieZ0Sc9IB0+ne6MD
         WyYQyVzgQEenluGgtVXsZWkXe0yz8PKJLcJDWjcm+UylkMb8VAgoD/IwpKCei5nr2i/S
         Vzl3sY+jSAwcMyXoVh2Pa5V11ne8i9DiqL9q2pPfgVYAU8B8WJp16e0utj2NTleq/r0F
         TsoMcwnKS3wonax50KAIDKqpiT08TylJ9KGKBl/4wPjerGXSXaNlFbyXCpL1Ndk/MUTX
         7Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742587922; x=1743192722;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccG9w73MG8ltY7+ND06i6LTf/TTQC5xPKuyTK8RSyKM=;
        b=v/3852SA+gqpFKuqk84Mn4vmEkb0nSWc4AbKPclR/nRz1DAE2Tptcd4ibqcUrnexXs
         RnH6e1LpW689yfJveEhAin0cIzzPGvKUTN5qzz0fX7X4OFHMUuHy87M/HQK5VQ3k7Vao
         k4XhS3pYQe64+7MM77RkqXX4vVHHZFBYykwlAjVeumzk3/UqlSuHzmdIXSvqE3KU0C3p
         n7DSq92SMsErZjNJlSJRElT+v8YizoCbHli+hCC/TCG+REgOfPMmVmmR5hT4SPjgL1Wp
         rQ7RB+gofVpPh5lrJYpQm6ZGAbyJoc5GPuBhpQSegp6pxJMDrAIhjXpMPh8+uWxz83dO
         Pp9w==
X-Forwarded-Encrypted: i=1; AJvYcCWn0C+w/64HqxEWYDBDD8mpmIVQpj0D5q1rhxeMTJJ2jKgcx4B3WDc/IiLGRTcTa3swODAA3LTx38w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxx5Z/O+KsMRncx0sdF8wi16EcJgcqK3bDADFdy1PgDhGfZYQr
	+/fNJVbS0u3aJp/szOZiZAK/5wRvdReDOre2HIhv6iSO+/ltWzNiarsxivPo864=
X-Gm-Gg: ASbGnctuNsyc8RLCdVXr7dzK0ktJeB/tts21CvMVyV0b4IJs/ZeBT+6nTCWOMoVGuFc
	+c3aSxzf2aLTP05uy+OWEb4ddcvxe6FXMkLKdhG8ea++EP0jdaG8Kcj9wSEainD9BT/3+9+1wFf
	iBDtZIvsfiKKCE2NL7VocAyP9d8lXvNASleM+OfPP0auIGC3CFptwrU5GbH3BnIHZjPYU74q3Ag
	0bMXOFoee9yFAYecc1o9QH3vSVt0bJ9e3s4L5bN/ZrgiP19FSa0Xm6ovqm0sEkSEMkY0VWZuwt0
	6E5ZZrmcn0mKQj3HLO5k3Jfh0qjjKTAvyqYAgtr4wOV2i3BNaIgaOWkzdVEbLZM68X5kQng8/lQ
	LLX6U2q8c5qcddirJ
X-Google-Smtp-Source: AGHT+IFiaVUXe/AFyDJjh4bHXe5rna40Jytm7qgCzXcdV00KZLBzj27++qjiSCFI5MNnva14T16qnw==
X-Received: by 2002:a05:6808:1a23:b0:3f6:aad5:eac8 with SMTP id 5614622812f47-3febf7091damr3077556b6e.6.1742587922167;
        Fri, 21 Mar 2025 13:12:02 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf79283dsm481347b6e.40.2025.03.21.13.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:12:00 -0700 (PDT)
Message-ID: <336f3db7-6f8d-4eab-b28e-c8389a3d05c0@baylibre.com>
Date: Fri, 21 Mar 2025 15:11:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: ad4000: Add support for SPI offload
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, corbet@lwn.net
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <84843837a2acab58f8853152ecaa67c79b9a9666.1742394806.git.marcelo.schmitt@analog.com>
 <c449fff5-ef23-4094-8306-0a6b27a22c1c@baylibre.com>
 <Z93D8CAmgKSO-Ta6@debian-BULLSEYE-live-builder-AMD64>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <Z93D8CAmgKSO-Ta6@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 2:54 PM, Marcelo Schmitt wrote:
> On 03/20, David Lechner wrote:
>> On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
>>> FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
>>> The PWM IP is used to trigger SPI-Engine offload modules that in turn set
>>> SPI-Engine to execute transfers to poll data from the ADC. That allows data
>>> to be read at the maximum sample rates. Also, it is possible to set a
>>> specific sample rate by setting the proper PWM duty cycle and related state
>>> parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
>>> trigger) is used in combination with SPI-Engine.
>>>
>>> Add support for SPI offload.
>>>
>>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>>> ---
>>
>> I'm surprised I'm not on the CC for this series. scripts/get_maintainer.pl should
>> have picked me up due to K: spi_offload which matches this patch.
> 
> get_maintainers doesn't list you if run over ad4000.c.
> If run over the patch file, get_maintainers lists many developers. Some of them
> don't seem to be related to this series, so I cropped the list to avoid churn.
> Will CC you on the next versions.
> 
I use b4 these days, but IIRC, I used to use the --no-git-fallback option of
get_maintainer.pl to prune the list while keeping actual matches from the
MAINTAINERS file that shouldn't be pruned.


