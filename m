Return-Path: <linux-iio+bounces-24325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716FDB8CAC8
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1218E17BDA8
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4A25CC7A;
	Sat, 20 Sep 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FBgPD5BL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72553A7
	for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380015; cv=none; b=SSQKNDEXM7FSxUtu/a6fzYGOQW6+osXguZEOHMENbWIsk+xlCBBGTEQtP1QhtwnKXTl5/ODg+obTYau0FS1fHWPvkFJrpJcmNiaTgSDiHKWmD0LAAMOlSmaZyyS3vj1w4u19ePpU8D6YK6J1pqCP9DUxjOqBCZ2NhaKLiiG1Jd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380015; c=relaxed/simple;
	bh=76xbBUxliUkmRauXzdFAYfn7G+UtF3ZVcwCnZS6jb94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUkwyiJ2n0MVI/1+rm8K3sEAtpZdcPbpyYmb6zg0Go/tsXa7YBh8XKXEYKDuLNN5sFxTpUfptqKUnKq7iU5R1DJ/4Re2jkdqwc6/77XubSEUouYLUuzxPKCfFiqjz6ybNmaVLTQYxx9u/2cpJRG0SOotLbSfWE+/e6aF4bEFr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FBgPD5BL; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30ccea8a199so2035593fac.2
        for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758380012; x=1758984812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbMd89b/nMwvZQdvsgC9Qh67PYEiiWYT76aG8fJcCXQ=;
        b=FBgPD5BLBAoCjYAAGJZdI2UmkoUmdwIAqs5SEWEio0BI+YkD4S1VZE1kP/rmuVGECH
         3jHs/6eU3kHRvuQykX/EhOrjwJRtzKzeSMgMkmrRWq1+Vl0MaXjfut3w8G1lsdtZtrh+
         MkZCBT8y1jVF91bCo5sYkzNjDtuWc5r7DHwioZ8cQuyRY+uLU0oxnp3LVB7BPmRxV581
         BQ9iGXG/9Z5t6xpTXHUIbS6JyOridUK332nBkQpklHm79IUxEi4zD1El1esfPcTerzHN
         vRLt01CybB3/kqy4D6gT5l2BR9N8Ub7kBm5ielxWKIES3GEsAV/kNWX6ECPSNHJweR4f
         OtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758380012; x=1758984812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbMd89b/nMwvZQdvsgC9Qh67PYEiiWYT76aG8fJcCXQ=;
        b=um/HQzsnlbroOXAXQLsEhGRZdfjRP077wVvzB1pMoXcR3Vd/srBSC4k5fL1ifOXz1C
         yh+WwLqF4ctBQoBba6Mg4K8Hv9nwWBdUAKlz6yFO+x8EHWoZK1YnEHmHFZLcbCGcvvV+
         OOv0ogE9fgq1Puf/OlVnHGDXL0xMPALn23fu4iqQXyqA9HxWT0np9fLyuqImDSNOz2cv
         dY67E3jFlV6Cd8U03KcH7uIDxNBBnynC+7JAPgZhs2zRlCQLUhKTua668rj5yFDe9C6v
         V9cGEu2B5vG3B1UG/tVmzhw6yrBsZ2Xc3pGL/6mRbNoPsCgBsLaQSTHHwHkMP+SHclZm
         FVNg==
X-Forwarded-Encrypted: i=1; AJvYcCV6uVAkpVO4FKwlPAtW0vXkfGnnRaNlQ/v/qEL76Z1YGEfg2Bk7+RpRxbLWRW6FPBh+wPhOeqHvkMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHY1XmynzECWJAcBYLZXluvZdNiIs9DqrHsC8LDVt7butGDSt
	COzguY/MOMVpISNnPkPOmTzK3XyGwi8eUR7ChqNqx6mjrEPuWMEruC620qZrSZ+tzvI=
X-Gm-Gg: ASbGncvMcy8z7pFVFVsjS/X6B30cthYq8dDKLFTPpq0I3xYaTgjQqTDI4GoLuv4S3we
	dHIeyHFmmdaeDZxR/qCYVw09VuwY080WC1sUChREytcDVMJ6/NSSaGTAZ3H78mFClnN5eTZwxHa
	K8JlRGbK6yZq+M3ZJalA+hb5ogN+/BY8on/j2ZvBTe+AyqhN2XyB2RkVMHWqMZxgni6XoU2Ez/M
	xC1h5smSTUsKK9VjCCCp6HMLwWQCdiY9ujIP5Wm09zdPVMqtOcbjJa1FBGcoHzIi9OamD8gwAYL
	VHOXhtXn3yqJf6ZUb9qZiYVKIHP5vcVTjH5O/RSZA02KqPAuhd3O4CEMT1XwiOy42oHhU2vG2jQ
	5yygYgx53IEgVvM/BzAj6JPRQpOVbexu8MvIuWTZXdsYfiEpaqUpjg6hNmGKqwiirSsys+Jd2t2
	7IWrrc1Soshg==
X-Google-Smtp-Source: AGHT+IFtxS6pm8P+qBM7VQ/5xkujMyKbTLba8CfRjV6NkOCTUCAv+clFuIj/SxQDcTROVCvuV1IquA==
X-Received: by 2002:a05:6871:651:b0:333:7d78:7045 with SMTP id 586e51a60fabf-33bb5a705b7mr3448072fac.32.1758380011967;
        Sat, 20 Sep 2025 07:53:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4? ([2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e3af740csm4980635fac.5.2025.09.20.07.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 07:53:30 -0700 (PDT)
Message-ID: <3bcca945-b74e-42a0-bf42-24d01068d246@baylibre.com>
Date: Sat, 20 Sep 2025 09:53:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: change setup reg allocation strategy
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
 <20250920122404.76277a27@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250920122404.76277a27@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 6:24 AM, Jonathan Cameron wrote:
> On Wed, 17 Sep 2025 17:05:01 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Change the allocation strategy of the 8 SETUP registers from a least-
>> recently-used (LRU) to a first-come-first-served basis.
>>
>> The AD7124 chips can have up to 16 channels enabled at a time in the
>> sequencer for buffered reads, but only have 8 SETUP configurations
>> (namely the OFFSET, GAIN, CONFIG and FILTER registers) that must be
>> shared among the 16 channels.  This means some of the channels must use
>> the exact same configuration parameters so that they can share a single
>> SETUP group of registers.  The previous LRU strategy did not keep track
>> of how many different configurations were requested at the same time,
>> so if there were more than 8 different configurations requested, some
>> channels would end up using the incorrect configuration because the slot
>> assigned to them would also be assigned to a different configuration
>> that wrote over it later.
>>
>> Adding such tracking to solve this would make an already complex
>> algorithm even more complex.  Instead we can replace it with a simpler
>> first-come-first-serve strategy.  This makes it easy to track how many
>> different configurations are being requested at the same time.  This
>> comes at the expense of slightly longer setup times for buffered reads
>> since all setup registers must be written each time when a buffered read
>> is enabled.  But this is generally not considered a hot path where
>> performance is critical, so should be acceptable.
> 
> If I read this correctly, ever time we call postenable()
> this parses the channels enabled and first checks if an existing cfg
> is usable, if not assigns the first unused slot.
> 
> If so, the algorithm is a little more complex than it needs to be because
> it is allowing for holes in the used cfg registers that I don't think
> can occur.

Yes, Nuno noticed this too and had a suggestion on how to simplify it.

> 
> So if we add simple cfg_slots_used variable we can for example jump directly
> to the next unused slot if we don't find a match and we can use this
> as the loop limit to save on checking a bunch of zeros after that aren't
> in use.

There are only 8 available config slots, so I didn't consider such
optimization. But we could perhaps do this even without adding an
extra variable.

> 
> Maybe I'm missing something?
> 
> In general the approach you have here feels sensible.
> 
> Jonathan
> 

