Return-Path: <linux-iio+bounces-15617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC420A37BE2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 08:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C093ABC85
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 07:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DE19995E;
	Mon, 17 Feb 2025 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huhWcwDq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC518C33B;
	Mon, 17 Feb 2025 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776140; cv=none; b=FfasQOZUzE69lIFH/u8ZZsas8R5LRWod61Hr7P7WFYim67GTHg23gu5Hiha9FoAqmjwSKtj0VofNwF+MpDocoxHtdCY2qAcKLX6tEU5zISdBiZgVXXJwZqKf04NMN3CSSsMpRh7wuewBcgdRZKxK43zJwNp1Zdi5sJqRQhBZfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776140; c=relaxed/simple;
	bh=TIaLHfraef5v7lrUC7vTH4c6nnspd2dBgVOKfBQ9ud8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Thw226FHZR3ewcxeHrCXB4MgEnf+m7oZ/jQfJMEY4+zxkRI5iaqL9URcJiAnAYCZACvK+b4J8U4HmOb1z1pYT5WzrM1sL7YsDB+auoRassQ7qieqYnKNY2PdSkQe+KRZCX90OfEDBRmTxVdsIgyi3nARTxqhvLjPUcseNdYHHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huhWcwDq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-309311e7b39so14477371fa.2;
        Sun, 16 Feb 2025 23:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739776136; x=1740380936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4alR9jTjsGdGSAcz4k2e3lKB3D23SrVBvx805wKurZo=;
        b=huhWcwDqzN9JQpPfSH3HKFfJj8D2722bcGmIUoAFbdYpMVvRJ7mj931V01uPu1Gerd
         Lc3RuglewXfUUqFBT9UURdExVwLIEwzV3fBoaQfebcA+nY1MdwOOM8tMh76vyxrZup9K
         yN3SMW+GsmMwsNwpJ0l5JIlPyYNv7QRDWaa0Mgv8nZS/b7ZqAuTqgGTNd6XyQw56A7/d
         hidTY59tiPnPlhhdT3OgDTDrQ2UM1JNHJ0E94Emg7wQ09YswBM7MucYvqGjqEDVCR8q8
         HMIx48Zvt1P9W5TDjuOvfLEkeYB0/65Sh7YZl3ODnIXDbVRhLDwQGFC/GT0OPQQ2PhkU
         ZqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776136; x=1740380936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4alR9jTjsGdGSAcz4k2e3lKB3D23SrVBvx805wKurZo=;
        b=VSRuPh2AlQRj55fu5oB8kNcvtaCZJcVhNHVKF0R/keUzNoSiFoWh8G97SX8TQABJEI
         u7S/44NiUbg58wizAhu5EhbwgZ7NJlJGK7aWR/IswrUIOJ7GVpTKArxMDZf10hG0brKl
         fQj+t0fwxLBSre+uzwgpfp0EU3nIryDIxAA/ePm0uTEDFR7VX8A/Al0RHoPHLTRZu04R
         KaRV+QlH+Q1fULTmQdwGg1IkmjyUZlc0cjQi4jXEpWGJzIsUHD4E+1ig9OMe5pA5DRhf
         J3MUxa90rj4MyOlqKqZsFMRoMOGV/4UBW0ZtTBAyxcvv55P7GkkOY0VF5OlcrwhzQbYo
         I0gg==
X-Forwarded-Encrypted: i=1; AJvYcCU3CXhTsWohgkcRWB7C2k5Vys1S7yoSkBXShxcp+ruhvU2xDhpaQadqzYBjE8/CL54bu9+LC5eon8jdr1J7@vger.kernel.org, AJvYcCUn/YfSkr8KV1nhwyv1/RhpRh8e1nVZmz3tHKdov/uBHm0pz2j8Xm623aq4HxWs/EVZ7qpdPlJHESOG@vger.kernel.org, AJvYcCXM/3YWUB4SR/uTGMp8J8DfmtdlOljMx756YW/wuviPZRZf/XrpqSC07cJUjnlK3puoDP5QY3WlN/nj@vger.kernel.org
X-Gm-Message-State: AOJu0YxpzP9qOktiQ2KtYrmOEyGq+UmxKOLK2mPCrin3JHTWn/hn5oVP
	OOlLWyKYY8ssBoPgib0/xFSpbz4ya15pZ5GaHxdzecXHYUIY6c+L9iWOmA==
X-Gm-Gg: ASbGncuRdlBht9aJLmXNLs7InnEI5+7jcTFqxyH15PiH1s2XoR5HZDIdoHjEPR2jNvC
	A6I0Z7Pr1GKiujhE2DnLPJj9q5xOiDBSlrJLskzhuQBlW+d+rlheHE8NtOGf9cMjMJ6L+t+3XLl
	xeJ2u6/JuKwCxQqveVh0yAY78A5pSIAMVFds5AfMFI7GyzTPKHDp9QD4HJLxiTHKLpECcPbB1Xp
	uYC54P9w4uTqxAWEZ6EtCOwvTJ2g1jhDToMKqHAT5jecfZ9pxvun6RXHcserZPPijWMDu9h20va
	MUWbhAbGcj2NrsT+9N9ssjuhZtQfE+U2gdqhRS47M5sSuUODo9ePADeK4ijNKLR/2+MmDibG
X-Google-Smtp-Source: AGHT+IFgezEO09iFpVK/dt0sEVIkF8nUioSGzkMyj5imKGMIO75UpW1jej2OEUPMhzHh6rCLIfJIjQ==
X-Received: by 2002:a19:8c4e:0:b0:545:5be:a6b5 with SMTP id 2adb3069b0e04-5452fea6145mr2388706e87.49.1739776136039;
        Sun, 16 Feb 2025 23:08:56 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545315629c8sm786592e87.223.2025.02.16.23.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:08:54 -0800 (PST)
Message-ID: <28b9dda3-6fb6-49b5-90bd-716eb35a3104@gmail.com>
Date: Mon, 17 Feb 2025 09:08:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
 <20250208164111.28ec9f2d@jic23-huawei>
 <ed0e43d8-9ab4-4614-9079-8a592ca8b185@gmail.com>
 <20250211190714.4db240d2@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250211190714.4db240d2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/2025 21:07, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:52:51 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Jonathan,
>>
>> Thanks for the review and all the comments!
>>
>> Just a note that I am currently spending some quality time with
>> rebuilding the floor of my house. Leaking floor drain can cause a bit of
>> a work... :rolleyes: So, my time with upstream work is a bit limited -
>> although writing an occasional bug or two can help one to keep the
>> balance ;)

The good thing when doing manual labour is that one can run thinking 
processes at the background - and has no time to reply instantly. XD So, 
I've been thinking about this quite a bit while installing new floor...

...

>>
>> Right, thanks.
>>
>>>> +			u32 ch;
>>>> +
>>>> +			ret = fwnode_property_read_u32(child, "reg", &ch);
>>>> +			if (ret)
>>>> +				return ret;
>>>
>>> In general the association between reg and channel is more complex.
>>> We need to deal with a reasonable subset of cases (single-channel, diff-channels
>>> etc) where it isn't the case that chan == chan->channel.
>>
>> I guess this is right. I, however, lacked of knowledge on how the
>> differential channels etc. are handled :) Hence I just implemented what
>> I believe is "the most common" approach, while leaving the rest to be
>> implemented by those who need it.
>>
>> Still, I agree that a generic looking API which silently produces bad
>> results for a few of the use-cases is not nice. By the very minimum we
>> should check if single-channel, diff-channels properties are present,
>> and then error out with a warning print. That should give a good hint
>> for those driver writers who are trying to use API for something
>> unsupported.
>>
>> Also, restrictions should be mentioned in the documentation.
>>
>> Do you think we should use some more specific function naming, like
>> "_simple" - suffix?
> 
> No to _simple. I think this needs to handle those cases before we
> take it at all  They should all have enough docs in adc.yaml to
> work out what happens.
> 

I am thinking it would be conceptually better to provide small helper 
(like the *_simpe() ) - which handled only specific properties. We can 
additionally provide '*_differential()' helper and potentially some 
'*_full()' helper which covers both cases.

Rationale is that:
  - writing _simple() helper is simpler. So is understanding it.
  - Devices may not support differential inputs. Drivers for those
   devices would want to call helper which does not accept the
   'differential' channel config. Parsing the differential channel
   information successfully and filling it in iio_chan_spec would be an
   error for those drivers.

> The most complex cases are all Analog Devices parts and those
> folk are very active on linux-iio so it should be easy to get
> them to review a series using it.
> 
> I don't think it is going to be particularly hard to generalise
> this.
> 
> We may end up with a variant that takes a 'per channel' callback
> to fill in more data + a private pointer of some type as often
> those are putting data in a parallel array of extra info about
> the channels.  Let's see what it looks like.

I was playing with this thought for a bit. I do love the regulator 
framework's '.of_parse_cp' which the driver can fill in the regulator 
desc. It's a pointer to function which is called by a regulator core 
after it locates the regulator node so the driver can handle regulator 
specific properties and do relevant configs in the registers.

I some sense the use case is similar - PMICs usually contain multiple 
regulators, each having own node. Being able to 'offload' locating the 
node to the regulator-core is often very handy for drivers.

I thought we could maybe add .fwnode_parse_chan_cp field in the iio_info 
structure. Idea being that it'd be a function which would be called for 
each channel - and it would probably be useful on other areas in IIO 
besides the ADCs.

Problem is that the number of channels may not be known prior parsing 
the device-tree. So, here is kind of a chicken-egg problem with 
populating the iio_chan_spec. Furthermore, locating the channel node in 
device-tree may not be 'standard enough' throughout all the different 
IIO areas.

What comes to a devicetree parsing helper which takes a pointer to a 
device specific configuration function as argument - my initial feeling 
is that it might get a bit overly complex to be user-friendly.

Hence, I'd keep this simple and provided small-but-usefull _simple() ;)

Well, if others aren't convinced by the usefulness of these helpers - 
then I'll probably just squash it into bd79124 driver and be done with 
this :) Later if I work for another ADC variant I might export it as 
'rohm_adc_helper' with an internal to IIO header :)

Thanks for the opinions / discussion!

Yours,
  -- Matti


