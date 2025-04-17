Return-Path: <linux-iio+bounces-18218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03DA923CE
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E1C177C76
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8857255E39;
	Thu, 17 Apr 2025 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0HbllX6i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952D254847
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910218; cv=none; b=oavOfjozQA8wKTzTbfE12j2W/zu3qjr2ZWxpD/jtqZZJggkjWdjqO8vVApOlycVTkAUlwCiBER2NFBUBF35ZosIx5rTesD+ER7WGYsDLoBEI+jDzWwLnBC5UB7QDzkiaNPnyfepw5RSTjulV4EqOoZ+++65V6z/rnyJPSNeIdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910218; c=relaxed/simple;
	bh=kI3m2dSSi5DaU0S+gonJqqPl8NDyXRdj0RJkeMs3+PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Up8pGxZogooct3bDRJVm0Rh2M9hstLHYFPU4V/IKbhImYR3WuR4ZeXugJaB4yLMuiIQQ5SRCGo+680EE5GXrbuB53AF95tHEmA7p6vX38/iK8Srmt12MQHU2zJn/Q5ZG6fAA2apoIzrqQHRiDwtsWpQdRP1MzXYbZS4CrXM0GDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0HbllX6i; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c27166ab3so649314a34.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744910214; x=1745515014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgF74Y1x7cdnEZ6zTA2j/Rn/3r7hmq1Fkr3Xk5+i6o0=;
        b=0HbllX6iUzAdRdqZCV6gtZ2JdH8crC5tTngpdeoDqEvpVQycfNBz6BZGXs81jVprKI
         9Bx4W3NqqKc2Ock8KZbhej6GWJVxBFtGrEl9woD18ORXWVA+ied5tPHQwZ4J0W1TmhG0
         uMLyk792ISllZf0wlrbqXYoysD1tTuUvMBzVrA/TybikFBso2ZgrlJquLMpY+Wgfg7H5
         7wdvRSDIzxGIZ+/hey5/OooVAuHQ785EtDJtlfKWB8sz+X1iOdTuddkAG4a2JuuzQzoP
         BVVjXz3ixlxg7zPgPSoJoob7YqxDKVK614NbIyDuIwHCWg+Oi3DpEtzXziL7cV4t9DaL
         FTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910214; x=1745515014;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgF74Y1x7cdnEZ6zTA2j/Rn/3r7hmq1Fkr3Xk5+i6o0=;
        b=nvy8Uxc2E9wXoJcnhBsGukuU8JeKscVizUopzPPYy6Jo+FCfs4nauy2s9uYoCMJ8au
         wXO+a9QIxLJfwyCHxLvSMDEC2dFootsbc4h9oDaZDTIiBlPAvszBKp7rUuYGFs49sWOX
         VZB1zzCU8rj5s0d4tFQ03N0bQw7ownykl7y7nP3dpcDWqxruTuaRsOvnvOypMeEFZLDs
         NEqxlfrLR9nB/A5HzeUMUZNvlyZfhKRs5FTMazICp/T9jdSCR0b/LNr3TMveUkwfBWn6
         cvUm9qR6NCiwhYMRcLfPjgSirYdTXwFwmamFKhJuw2AaDLpey+hacEx6kfs4hi12PFxR
         sdEw==
X-Forwarded-Encrypted: i=1; AJvYcCX4WfTdeurHQH2NFXnkYaxHf1wp8X5LAFKAiDVI9BTpqZB5SKabj6PzEQ0ztFP0HMVHA5QDiZgCZDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsd2xFHxY8kyqvTSgadOL3UOQSQFSH7BnihnajdG9Hh3RIpe31
	rSE9RM3sqwMUHLriF6i2nsxzFDqsI1YAMmGfQQ+R3lXvb8RDpLDp03NzPCBoljI=
X-Gm-Gg: ASbGncvnYMC1GMjidGxCL48VIPAuZihDgeO65mjaaN5qFMSbpzUY4pMuEUGGfKDHUcR
	YrhF4sOlbw780srUK5e3mijVyu4dKovLENmfm5ThUjk6mPJXmo4nofSf+XYTA7gpFZcPTpxOAfL
	hgYrw1uTGzKJbAfVuDcDktPULkH+crXTLOHbtjyie3g1LcFD8jv0Fdmo7EkKgTCX68SGIEv7zXZ
	ZTr5SIRdQMG15cK6V7s/Z6k0mimM+NNcyUZeIPwV4eDRgV4Wd1n75RoNiV7TtYDQBOYgaTnFC9S
	VJYvlitAhsbWmtBgm2oqezVs9J+wkGL3RpD/K1RzNZVed8SnTwZDoBRVIxztYfCuWRt/kpVqHEf
	jjiwZEUW2TtI9ekk89g==
X-Google-Smtp-Source: AGHT+IG2ya+SWKqWkEWn8r9JpbAOf9gOHMhtRFWZIjuKx4wF7uh2Oa75D8nMaKP4BJF4mMuOP+61ew==
X-Received: by 2002:a05:6830:61cc:b0:727:3f3e:53bb with SMTP id 46e09a7af769-72ec6d200d9mr4250103a34.24.1744910214661;
        Thu, 17 Apr 2025 10:16:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee? ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730047caf24sm22509a34.38.2025.04.17.10.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 10:16:54 -0700 (PDT)
Message-ID: <6ff6e3be-6193-4977-977b-24de89c09153@baylibre.com>
Date: Thu, 17 Apr 2025 12:16:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] iio: more timestamp alignment
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Andreas Klinger <ak@it-klinger.de>, Petre Rodan
 <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
 <aAEz2ZD0Ipd1Xuy6@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aAEz2ZD0Ipd1Xuy6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 12:01 PM, Andy Shevchenko wrote:
> On Thu, Apr 17, 2025 at 11:52:32AM -0500, David Lechner wrote:
>> Wile reviewing [1], I noticed a few more cases where we can use
>> aligned_s64 or need __aligned(8) on data structures used with
>> iio_push_to_buffers_with_timestamp().
>>
>> [1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/
> 
> 
> Link: URL [1] :-)
> 
> This will help to maintainer with b4 as it manages tags.

In this case, I don't want b4 to add this Link: to all patches, it is just
context for the cover letter and not so useful long-term.

> 
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> for non-commented patches.
> 


