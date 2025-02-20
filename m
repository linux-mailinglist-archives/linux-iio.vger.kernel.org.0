Return-Path: <linux-iio+bounces-15904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EE8A3E780
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 23:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B975C3B9C43
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0B213E9C;
	Thu, 20 Feb 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KPzLH7iV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FA1EE7A8
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090449; cv=none; b=WXYh5lWD0qFRjaLLExDgh0VSyFWJCFKzISkQEZuQQMZz38ll9TsNIsoZsjCmU9rxf+GnZsq7/hfwv6NiMgdmy9aW8FmLtl77vebL/srcIThh4iVJfLVzOpeIO4xCYrUWEEgpM5f9fP6MDWUbjsBNnW7JmzwuCLo4ReJOpNCS+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090449; c=relaxed/simple;
	bh=Wwlx+PMNjFVQG+p5LgCwO5bEhpwUj2L8Wcxf+n7/TkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZaEzAY6ck2itUtnCLxVIUjCD03MHptjZb0KIElpq6PCrrJ4zV3/syuiPeCU26atosUnOm1K0RUUaBswLHv2m7vhYW8/8sHh/IhZrOPEv7QqWJRNb67Z1rh3Q7c9ZaBEfGpGTguBHBHikn6q8hQl2j/4XJjVy/h5cQC8V45ocXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KPzLH7iV; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2a8690dcb35so395865fac.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 14:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740090446; x=1740695246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCESArWTseHQGpGv7tpeQqcnGXM7p2OA6JgdrilOIUE=;
        b=KPzLH7iVYauwnVWpKAzd8c+gRI8jqXjZVAi9CYURZRm+LzfNpuJXNW3mUISQNVvHOq
         KKfd9kbCYUQN9B/ikEQDVVHzAWI7XV+nyHXbosauAIf1U81o4h4NMdQDvGfaw0NkA/6N
         zCed+5cfix5tupuIhaXHF5xB4CYKiNY/HZlZPr0o/MgrJN/xTr0x8KVCdLaiBKfhwGWB
         iE92+aMeJp7PJruw2cyqy5xyPGQkphC8QDpqcW2Uj6Wk9gV4B6aC8uVT1nzkhaC7OBXV
         eDX1Aah/as5lKXknbKr87J8IYW4w86yHgKBGzXW2gKME+buUA8mhSEOl+XvRRRAzfhXa
         MGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090446; x=1740695246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCESArWTseHQGpGv7tpeQqcnGXM7p2OA6JgdrilOIUE=;
        b=e38LGra3nRcOwqr1W7pBTfLL8BWtfACoMfcqk6saVthpY7Fz15pNqMft24ga/+QDKs
         1BCtFtuGZyB7fUJ7WUfPfSyjxd9VnSP3GU6VLOr5hlvN7Lc2S34xALIxe16ryvCuvohR
         xvYB1VqZoglirolaihM6PgSWoAW11ur8XWgaRKxs6fxBHqGbpYjQyM6giKzpunVGfH7B
         L96HmUoKnhEsco1a8gGyME9aCnjqnN9su0pMdxnu6tQ1P6i4rU9Jt30f3mk4Of6mAvOw
         GfPVfrUfSCu4z2pv7/lrMTPnpeY/Tc92oXMftybTnPV26OBW12us4XVzJ8jvO7ugJ/NR
         mqUg==
X-Gm-Message-State: AOJu0Yy9YrJ0dUIXrAlpmgmrCHUQhUVrsx+diKovsDhNZfQXKYSeTaut
	GzF656NoPX8o5pjFPrEyON4XJgWnp1VuZip/3Msfo9T0d7VsKUML2tNwfFQgXP+0toHpaV4RKp9
	g
X-Gm-Gg: ASbGnctgSZEVAZGFBIAhd39fzLrtCHfgd0XHO9SIpg4HoPdRG6n+ufCb+p+d3rCgTZD
	7Pz13QgkYGUQgB/G+bXz6P639ZnuunPKCJ2jYZKegBhYKAUFlUFMHgQICqePa3fP4dqItiK3hFM
	mjkseyIeDof7YazKUI/VfpihbSdcdutXi3iK5XH8CNlcmCTLZkZjEhjSahBEw5F/dsb8vvVn+JZ
	Mu5CMoIiHaao67sWF3D4QV0W1Z9KSCoyexpEOt5bGFY8Jq+eG+FplFd0a9xfgqiCVTnnpCiOOuT
	64ghIIATE3PKQsvYbH0QKTz/54f8+gk2sIaFyC2fUiNYEry7je6d
X-Google-Smtp-Source: AGHT+IEZpgJbx9x8Shte5+BRZ16avAvT1+wdr0Mi+ErzsXsYe5ooaU2WYdYSImpsg2NCEWK5B0Iz2g==
X-Received: by 2002:a05:6870:6b97:b0:2b8:ec17:66e9 with SMTP id 586e51a60fabf-2bd50cdbd64mr746258fac.11.1740090446165;
        Thu, 20 Feb 2025 14:27:26 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548878adsm6600768fac.17.2025.02.20.14.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 14:27:24 -0800 (PST)
Message-ID: <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>
Date: Thu, 20 Feb 2025 16:27:23 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller
 support
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
 <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/19/25 2:34 PM, Linus Walleij wrote:
> Hi Jonathan/Sergiu,
> 
> thanks for your patch!
> 
> On Wed, Feb 12, 2025 at 7:20 PM Jonathan Santos
> <Jonathan.Santos@analog.com> wrote:
> 
>> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>>
>> The AD7768-1 has the ability to control other local hardware (such as gain
>> stages),to power down other blocks in the signal chain, or read local
>> status signals over the SPI interface.
>>
>> This change exports the AD7768-1's four gpios and makes them accessible
>> at an upper layer.
>>
>> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> 
> Is it not possible to use the gpio regmap library in this driver
> like we do in drivers/iio/addac/stx104.c?
> 
> It cuts down the code size of simple GPIO chips on random
> chips quite a lot.
> 
> Yours,
> Linus Walleij

I think the answer is "no" since we need to hold a conditional lock
while accessing registers. Namely: iio_device_claim_direct_mode()/
iio_device_release_direct_mode().

Unless we add some extra stuff to the gpio regmap implementation to
add optional callbacks to call these. Which could be worth it given
that quite a few ADCs provide GPIOs like this.


