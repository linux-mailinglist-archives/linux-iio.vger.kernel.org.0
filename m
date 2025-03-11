Return-Path: <linux-iio+bounces-16740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94CA5CF0A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 20:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8017AD99
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9125DD07;
	Tue, 11 Mar 2025 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PpOkU9wp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6F139E
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720283; cv=none; b=hSPD149AT3AokTV3g55x2rOg+Y9nmWwQIy7GtiRD2XoOVg+QsMPPPlSXwwcQ+HFosA3wPHb6bbsZdHBBg215/3Sk14fMt2ehJYzGnFZE/aWpCYyJOyhuSe+yXB/BTx3NvZZW4+i8Mfg4pFTs5gPA0IicB6QsBfCjEmYb7GvTSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720283; c=relaxed/simple;
	bh=eMWAif36SDXdKvbeeRErxd6kwLV/chWEGwBaa/THzI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaHZmbnP9KuI/3E4YKGYNtJb8npIjWyDxeQdv3ARRGWDwhLzKHzp2geO/t6YIRYfKtiFU6j8AJGJ2EPZC6UEK/9DuhMWPtqKpqxGxOPMkTORlhbaFBmETWcgYSiFE5kznl7vNKBUipgShmljbThoearBVOCW3L0bnWM9zfSCd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PpOkU9wp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f89aa7a101so1908976eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741720280; x=1742325080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZF4QxEGRIEKGvT3VCs2VDbeXCp7Ult9VgLDtTsXdT5k=;
        b=PpOkU9wpGRMm3r9SfgZKOpUlrjVRbXl13YbbJIZDl6zcZ1/KWSxv+i39WOTTCALyEK
         7ETwTlDC1xbTGQwKW/PQJfLn+bgD6GPBeNWLhJqRkLZcIKLlkmzmP0Y0OxZXfeqTmApo
         roJZKco+pNPEK6gNeHghmAlExf7Z8Cw6XcacXGQY554kLuF0B/d9uyOaiJc9t0brygXS
         b5mGoPk1FYHN8lOvOTpY/WyGlupFp5DgyFLRCS+hjLqMada2S0ILY9kXFP/KUjgASpcH
         AXmd2ppOmd3s+pH7xQox8lo+IR37PL5D5UhskbO6+1ukdoSC5Y34Cj3NHrLomidj+Bt/
         0HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741720280; x=1742325080;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF4QxEGRIEKGvT3VCs2VDbeXCp7Ult9VgLDtTsXdT5k=;
        b=n/AhtHrki6uNhb2XdwNnPofXng7dFPZrI3+3r98vikm8VqGmPAtgJfx9U76BvwWbko
         VHuVyxlCTwcLLsKMjSFPwz/0/rLoq0xRJYPxtM+ICIAbR8QlRnpxcRC9p+4gzIBybgfz
         ISpGP6329dqqKWVil3egC9VJQJ+oANVk+qqCguGJSqCv32jpEALf7vM19bLb7aGichpB
         8Ozp/JTtSgyR68lA3VrjuwMsEqhjI5PMzn9omodgjXjQMqEvWrnDDjC1QXgWS4sUcjbu
         vXjjidJ/lNHTjk05t63PnVYpOrqEgnEZttM0IpHP11NmkukA0pK+uXxvUv8LhU1vF9cp
         X4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWcgrXPjIH6+RioDm/NLTZC9X5B7xWWMyThtzrLnTmE/dPZ/gIRqYSsIDJREC9Sdlsf+zWG+iZlGIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5WZTCz0pr1QgH5IjG1eSzlIbOeBSZTh6sSEECCIYzI1o4xLo
	riMnDXKGbtUP3knyBfNXdOoiQ0eAyHoNoLKS4Cmux22oqenH1MvGkCHE15neYDY=
X-Gm-Gg: ASbGncsBJXRRX0znpy/bxjAjBM0Z85iWfUWITzRRQsCUz72llxIYEdbD/X5++NQduVu
	WOQOnGUpXQfiUC4c6y/blYmqyzrpe6hmCiHE2IR2j5ZXZkkjzLxKlSwWeaBmIYpRk+mYCSR0ECb
	nbvsrMeP7FpegM4BD5zQoUPBp22t/WJzVTV+rWcpZGQdJPtLKK3AZnQWUPZ49xbW6YLYMwSSR1K
	aI+andDQmrz2PgnuoAIqEKCm4qhtisB/s5jCzFk7hY4SyRo0oNMiufDRfJpSGVg63ZobnkMm7TV
	EyevvsNHyu7NxLft925OhCBK/25RVk1cADS0Baix6JweexVed/s9aDKvxgN0rkFcess5r27biSE
	tQYcAOA==
X-Google-Smtp-Source: AGHT+IHX3Vu+RuA3At3lwScTCef/yZid756L+teOLzxiYfRANjt94UlY7ZM2FFUF7jxDIcuGRHqtPg==
X-Received: by 2002:a05:6820:994:b0:600:2260:315a with SMTP id 006d021491bc7-6004ab3c077mr8773045eaf.6.1741720279779;
        Tue, 11 Mar 2025 12:11:19 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60040d1fff3sm2225564eaf.0.2025.03.11.12.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:11:18 -0700 (PDT)
Message-ID: <4d1666ef-8683-4d54-bb4b-7d858569c5a3@baylibre.com>
Date: Tue, 11 Mar 2025 14:11:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] iio: light: vcnl4000: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-18-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309170633.1347476-18-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 12:06 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
> 
> Also split the enabling and disabling of thresholds into separate
> functions given overlap is small.

Should be 2 patches since doing 2 different things?

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Astrid Rost <astrid.rost@axis.com>
> ---

