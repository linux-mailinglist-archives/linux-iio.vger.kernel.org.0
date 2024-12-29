Return-Path: <linux-iio+bounces-13853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408D9FDDAC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Dec 2024 07:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C5D7A1284
	for <lists+linux-iio@lfdr.de>; Sun, 29 Dec 2024 06:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2A36AF5;
	Sun, 29 Dec 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwimilKs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67518E29;
	Sun, 29 Dec 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735455246; cv=none; b=C4GfBYFOGOy3k7BJDiXqMlW1C2hma4GVC4Y9PtNAzTxODUHZCPDExswV1IEcPxllE3Wg/EzMNQj+1TH14U8ylSvfE4qM0gmt5RqH2o0OBXpf8U9wM+HAnoFUS72kyBkfsAl2Jnp51bZqswj/pv+1MoZJNkZQ1sRyXO0A59fYnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735455246; c=relaxed/simple;
	bh=kcNPwHHWIXtLnH3tzTB0/L+ajSzraWQ7CRbaYbGGWU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QM0YaQh9wz2A8PLQhZfiBRg8w+LpGmDkZi7MzoOAuiDrQ14VwHjmJwPTomNLNHci/P296ljZnlyn5H5+LqoouvF+Fap7dMSubJ6BPWIOdsoYZYOhK/xPV1iGlubMUVxStK8/n+8z2x3C0G4vXZXCtLLi/UYJivmcnDh5GPtJdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwimilKs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3022598e213so15765171fa.0;
        Sat, 28 Dec 2024 22:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735455242; x=1736060042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpOfhWB1jjAdvcwOG+doGT0y2OHAh1pRliwEc8USFEU=;
        b=BwimilKsZUiTNUbsW9xPwjKSM5rt7oN2jjJaEwDQEFyQkeVZALAw9xlUgoT4LNb6L/
         kSQge09MBEWv89fcHK/NjlDPf0A/93d5659tejFH884IDSkFTU+yF9LPfWExtW3piJoh
         5a48olggZ7h5hiEhbCl47Mxb6uCAALg5cIcXLNB7VquMFqln9hC70PQZEIUqgtI//tZ4
         KAajB0VyA1gLiCq5PMNQprVsBeTklLJovFAnokFgPVf1iU0otgBBDhM1bqZ0Zh90sWLr
         ChvGcCirgUiVeaHCjeJPMmNXgM6dQeg9fyCBYUmN9OIMsFGGbKsR4PaCWOFoxuuGNDuf
         qq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735455242; x=1736060042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpOfhWB1jjAdvcwOG+doGT0y2OHAh1pRliwEc8USFEU=;
        b=Dabgu7bSmS7wcPJGaOVt0kV9fzMzFXFSHyfq74N727a/ueN8OCOVuhL40PHuB4VpYA
         DJqbCY8BVqYgg7/gNPT9715XAuKslg7ncfS7Il+2LSRQ+YwZvyhWEaAQe1jgtGuEtwM6
         FKN+bV5aY3O+H0BeOzibIWEXUJTIrRXuanF4h2nezKMykU8NCzf4Tr7l1XCBwb7cRvyk
         aBa2p5lt4onexUwSKKdITIqhYC4zqNLpwJVZ9HUiyK1zyoxL6lSlV7kW6Tr5IbaiypPN
         55QvcY4Y6/wQNCVKZh/oXT6pJQKZA/sPM+yIPMfNxYk1m5IYFV9J5LakVRSeFBf+rDNc
         kXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSSOHuFIQvjpF5rpNKIaDzdixbGxHS5JIhiygYGioPGnBF0GLlyFkSRJe8ivtdtbhRee+XdlRm8fOb/tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+cZqHWCSNdokGpXu2eGdjNkfCDR5om27DbrYztoQuWN1fLw4
	yoZBL7nj1MuXJrGKnG4f0W4t39MvfYU/NLowSUxCF4/7Dq0O/5QcuL2Bxw==
X-Gm-Gg: ASbGncvTItUyO3/MFzBuJLtiILLD6UeRkolHuGJzuIbuS4EnHdciedGDdtkHllzifY1
	iZk5KQ8JfrA/iewUXX3q+eF+LuHgYe4cPEviPpA5h1p8TjIafHMofQuIQKJ7RuEMNEkiRc6EgjO
	hSsaCw1+DgJgfJkIxBtB2nhAR5yebSdBv1DfUYD690czQHkJj26aGATNDT45TOjBdpAaASFh6GP
	5WIhRGXykJHEh+Pxpip7cHHyWUzwXaukiqP0ZYsOq/jiXxHQyM4vN9wuVvojsrXafs+xsciO8sq
	gN78XSC0R3VtqFtmfesViMvMaI8PVzQhQ6E=
X-Google-Smtp-Source: AGHT+IGcToXcAK2c8NVPg6VvFkq2Tf3YBsy/jA+Y86ZzsLZi1m4hxS23DdviieKet1WeYjXBfP1Utg==
X-Received: by 2002:a05:6512:3e2a:b0:540:2311:28c5 with SMTP id 2adb3069b0e04-5422956c4c7mr8907725e87.57.1735455242164;
        Sat, 28 Dec 2024 22:54:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:419:b800::7? (2001-14ba-419-b800--7.rev.dnainternet.fi. [2001:14ba:419:b800::7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223832a5bsm2790062e87.270.2024.12.28.22.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2024 22:54:00 -0800 (PST)
Message-ID: <b5aa553d-fed4-459e-bbe8-70b9b9b39cbd@gmail.com>
Date: Sun, 29 Dec 2024 08:53:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: veml3235: fix scale to conform to ABI
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-4-2e1286846c77@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241224-veml3235_scale-v2-4-2e1286846c77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/12/2024 12:59, Javier Carrasco wrote:
> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
> 
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet. When at it, use 'scale' instead of 'gain' consistently for
> the get/set functions to avoid misunderstandings.
> 
> Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

This looks good to me, although I now think we made a mistake with the 
naming of the iio_gts_find_gain_sel_in_times().

The intended use is finding the gain and time (selector) for the new 
scale (while preferring keeping the time unchanged if possible), right?

So, in this regard it'd be better to use name which reflects the fact 
that the function finds gain and time for given scale.

I would now (after having to look the doc of this new function while 
reviewing the code 2 weeks after reviewing this new function :rolleyes:)
name it something like:

iio_gts_find_gain_time_sel_for_scale()

Well, it's not really in the scope of the review anymore, but I'd love 
to see a renaming patch while we have only one user... :)

Anyways:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

