Return-Path: <linux-iio+bounces-17171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE0A6BBDC
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A44E1891F10
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCF722B597;
	Fri, 21 Mar 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjmyFo7f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31E216E01;
	Fri, 21 Mar 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564484; cv=none; b=JO1gc0FBYf+JicBU/C7o5TtTNdLj1KgwlaoLaYQxEiwYvvgaSdU5OX85LlytM8b72lSyboqaY2T5OrbIjMTuK/X/UVEcRp0izr8leZY7xcQ97mCHlkLBpE+WqEzMH/ZkhiU7966w6CdHxqORisJ2P7baU6FGRGVWw55r7qJGb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564484; c=relaxed/simple;
	bh=2xS3wRTQdD2RgegN0Z2LOjl27YBF1888/fgKm/NdziU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYr57xZRERoFPHn8/VFAtaxKj6zfx+SDL44Gj5v1csJCn5SFT8yKHFDm+gDrCLs0x/27RbBv2vgz2YLFqEBwVEcofUJnAW4luqVglSuKYYjaVzvSSyd5iDw+4kNdaNa2dCydTk8N50YGIxu0sINfgb/KeEoOb5W949QvzPJp67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjmyFo7f; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307c13298eeso23190541fa.0;
        Fri, 21 Mar 2025 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742564480; x=1743169280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNO1bht0VBaGP3HZq97pp+sCQCedEDvWvT0gO3KJeZ8=;
        b=YjmyFo7f+AXviWu5czJ5+5yPQaXOpIP415F2aFHfJja/aq3qJ2ra0JeIeF/XMcVzHM
         bz4s8tWzURN1fbwHdmP+RSBdZXtPv2MV+n3/w50Z33YNuSjUttDDaAnmBzdGAloKkGUP
         aygUbn1oGotVTiD8j/wXqiywYm7AM2cEVXgkD3eTy7Gdnsu9MpAarD1bJvBxMWlOxIrh
         +9DYutC6PE5GtW/PGwvG5Q861JS8xW5rAJVYoo9AlPmGHdbYQf1wY5D2rMlAV8uinXTF
         lifdrN9DoHTY70L4t+RnzRF7LkAF61IxHRBaRYl20W2b/jQ2Nrs0EJ8kD1l3wm2Ydr+K
         2phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742564480; x=1743169280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNO1bht0VBaGP3HZq97pp+sCQCedEDvWvT0gO3KJeZ8=;
        b=e0agKrSwTgpBm78t9hY24JLIumH15HFsFyvepaJ136AboPxy0Vik87EMqagxscxp/k
         Mz0ZpAprfZRWq/Pico6yP40Vl/9Ngt55LAIYMiwnRTd/7AUmHjxknwD7XxP8BQJWxh2N
         +knU2KGpOBTph4GpJDE7FYpMmbhRs+ZsLA+IMOHzthdBKVgJhep4kuCv9ihj4kZhPyB2
         e4wu4k+13vf4ehGNezAQb5cyFWKJHwh/6qAnB2aKYSBd73HnBndPOCHGYtbfkPRiPby6
         U/lmD77OfLAj+P99sE7/d1EP9sKLIqmucWgjjeWlXkss5GrxGWcnufPZxCj6jldrprUw
         Qbtw==
X-Forwarded-Encrypted: i=1; AJvYcCUeC6af44kdDVDoGzwnN3yqRxHGaT6p+NZ7XrFtCk9e+7G2vBxMweiqn+t2SF1J+OzlZ3aA1bUrtAp+4vt/@vger.kernel.org, AJvYcCV/ZM4QR3FT1pPBBM6MTSovssRj+X9V1sxWJVeTLtotYk9HQrn66pkUyt0+XIyPy8fUSyBgRFBYgsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOhryzN1BQjcStdJk+IP5KtHxYb3gNrGPB8GbvlF+XohpH6zk
	aA4Lvgt2ctMfw1gTPRzplkHXxpT6Is+xm3OFRDYnjtbycNqf333d
X-Gm-Gg: ASbGncs/0MWd4PI35k5GPi/+yJGVS0tYoQb3y+CoJmMswO27k1QnZCTtUdqzSFUPXo4
	ZE0+nAcoGJY6Vpl0VFM62zqDszMiEQXQIlKQKfEHkK64Z8LPdyezU+WNZcyreDWzgY607cJgPDu
	a5UvQcEggzOB59ksHWJBoxfBDIhyemH4lrbd270t1h98apGWnF9Oj384v2C2fYqQ2kTVR6gKw8d
	94AdzDkeGSmQSePF0xxoOJQ79Y/dFW33zUyZ+yU00Kl+BiUl7/OSzn+ecCGVZL9jKH5fvqvHjBd
	ewtpVU4Ic+GbPkfaorO/FFpUj2rwY0n5jLTxttpjzUS5TURyeRQX6Q6R5r14fl6ogZ5XzJ0+/BN
	F4NoWsIYlVf0IU3qAV4QIZbEFzN7K5OAgNbGm
X-Google-Smtp-Source: AGHT+IGjk9L/ZqQcc5M2zBk7K6jnTJs0Fws8MgMQxTFZYt7+9yFMXZrCf1PuajstFh7nzLJrT4Xyeg==
X-Received: by 2002:a2e:8898:0:b0:30b:e5bd:404a with SMTP id 38308e7fff4ca-30d72730463mr29975371fa.6.1742564480125;
        Fri, 21 Mar 2025 06:41:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d910d5csm2399801fa.101.2025.03.21.06.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 06:41:19 -0700 (PDT)
Message-ID: <ed5bc103-1ce2-46ec-9649-03b11ae591a7@gmail.com>
Date: Fri, 21 Mar 2025 15:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
 <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
 <ae33de64-1ba1-4bd2-a139-3f0b5986f41e@gmail.com>
 <Z91WS-DoKoIZhRNs@smile.fi.intel.com>
 <1e236993-47fc-45e9-913a-e0615787581a@gmail.com>
 <Z91mnHP9V0yRZ2js@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z91mnHP9V0yRZ2js@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/03/2025 15:16, Andy Shevchenko wrote:
> On Fri, Mar 21, 2025 at 02:17:16PM +0200, Matti Vaittinen wrote:
>> On 21/03/2025 14:06, Andy Shevchenko wrote:
>>> On Fri, Mar 21, 2025 at 10:01:00AM +0200, Matti Vaittinen wrote:
>>>> On 20/03/2025 15:16, Andy Shevchenko wrote:
>>>>> On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:
>>>
>>> You can get rid of all of these by simply using __le16. I do not understand why
>>> it's not used so far. I thought that bits are mirrored, that may explain the
>>> case, but now I do not see any problem to use __le16 directly.
>>
>> This discussion is going in circles now. That was discussed in the RFC
>> review with Jonathan, which I did also tell to you during the v7 review:
> 
> Yes, because I think we all were confused by the bits representations,
> but now I see it clearly and I do not understand why should we go the way
> you suggested as it makes things a bit tangled in my opinion.
> 
> Jonathan, do you still think the two separate bytes are better than __le16?
> If so, what are the pros of this solution?

I don't think Jonathan thought this is better. I'm not sure if you read 
the RFC conversation.

I told this is easier for me to understand. Jonathan merely told he can 
live with that. For this particular driver it matters because I'm 
expecting to be maintaining it. It's easier to maintain code which one 
can understand, and if subsystem maintainer can live with it, then I 
suppose it's the pro you are looking for.

Yours,
	-- Matti

