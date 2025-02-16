Return-Path: <linux-iio+bounces-15606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7816A37664
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22DC3B0DD1
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ACA19D89E;
	Sun, 16 Feb 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eiQL0gO8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21A194A6B
	for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728262; cv=none; b=aeqs0L5Fj9q+uGX0iiUiDd4/Tjx5R33d9ZeoNmqim+simdaaJ68cAZlTAnuSdoO+SQ/Q5lBPXvFUvCGxK87XrjLuyzOtMh48fkfl7Ut9Y3f0NFRUsqH3JzC585kU3xfkhHKxOnGroK9HRnAkjHxkcWPtpwRNKul3zbr9zsztwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728262; c=relaxed/simple;
	bh=IgAsblt/Bn0Cgpri1WcWHC4k1eJtIrbx9gXE4Accvps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXtMwnXwAkNlgGf24bgoFIN/279aiz0nRJJjJDMkbQG6cQHg6fSNsMG1Uke8HiB6UGHGcjOpZO06P3P8N3hga3a4d3ct0ESJnbzyykWwwFDoRq+TvHoQTrNDPjxIKAO+Mv5hPtjaMWCf/BPObCa1DOi9KtoyrX5AGoGpgIIhb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eiQL0gO8; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72714016741so749517a34.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 09:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739728258; x=1740333058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfTPgMljUImIHXRGUVUfUqpmP1QnG7IbT1p8ys/xcO4=;
        b=eiQL0gO8OgYjOFGPObb4MZSt24r5A0aic/JCPuEm4SCjQmIpVanVIRC2pkV9woasvB
         SZVjuwvpDpS0+Pyw9B15ryG/d/dHYiKi0/f35pzCAqjHpo/X1DwWRWUIErRTGXFJ59JF
         XUGlF5YzWE/Wr71wfjyZhRLcXpNqq0RJG8FSScgzRKz+T50cUEEO+V64FHS87yFVcKRD
         l8msjaaUvCFS+tqdI7ZFChb+frK/23aABgeWTCnOrDjZ0+LFslff785M3X+yxBQlZ5pX
         +zr4Zc14ijo+za5TMjIuciNJIdddwHJy3A3Uq20q1rlE+dGUPQW4KYudFu9X4vRMwETr
         2CCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739728258; x=1740333058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfTPgMljUImIHXRGUVUfUqpmP1QnG7IbT1p8ys/xcO4=;
        b=sK+3CTqCV7uqs4/fRh3ttsRqyAppzrVV9LV6nHKYPIALiXCCIpyY3vmp63/gXB0Z4p
         QqUK6A6ylK7EMr15cmOsjM0U6wZeQSIldK6sikY3UGIbGt5LV/DaKSm2FGbf8IykQAPD
         g73WtrGn67q2BOqoLI3R0BHFVcAJBQjO1uRTKT3muk7aHzHSZrViXDFQR+Vg2XFa99Vi
         xAw75mntwLfwBr6Nm7DvcgSHhEA/x5ib8GOaJ9pPjygZf5DECLZO9h8mjzSNiwb6e1AN
         w6dUDYFFkoNNiQ/ScpzXmQszCi0yvQ6wPp9tFfE5WMrpWvq6P5dsCWjwar6qi1O2kXp7
         JoGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO5WZygP3kBtBXAEZMbUxI0F9COn/hWSh2jxl/Jq8jY6m6njA5yKNeGLDDiiARIubSSRXqZmZppL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WrTOJ8Bn8vRIKOqG91XUna+p3xyfvg2Rpjm02fNBr62ZEAK8
	+JKOlvG6kjhvrd3z2xKkMdCFll6J0s9eIBxlQ6La+PhOMhozNxtHjvvVlyMUay0=
X-Gm-Gg: ASbGncsIijOXLEwonwywt4z5kt5qsk1XDtXmsrX4vPHeFvKml3dyp9jTYHa08VfwfUv
	2WCCwMXblh5kOC0HVDNPZAGr1yaIWC+lC5HP2auNxURFVbM2fxl4uYktBQrywm2jKOKVcsY3WJP
	yzUlAyf4cgtA2KRAf1SPNoOSPuUCgWcrQDn3TktZwRxXFuBwpZEnlb/aZhsKHMAFam4fkUuSsd3
	Q5biT/zk4VhMeKj+LDf+i2XBAZauGi6FX/L77Bwvu9PhHBNPxX5sJw2hYQnyiN+AE0gXG7ZlUQ3
	Cp5aZmOubf57X49puwU4vOF4ftDJJkOx4toaahKIOtrQ+J/gci5N
X-Google-Smtp-Source: AGHT+IE/jtmfkixzhRL0goeIHC31qapcmAGuVSYnlGvoEQgU/+X3u1i3IhfpFRa28aBeAbng3X5+MA==
X-Received: by 2002:a05:6830:6f01:b0:727:cf:abbb with SMTP id 46e09a7af769-7271203afefmr4508997a34.9.1739728258254;
        Sun, 16 Feb 2025 09:50:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b95a6bf587sm3435240fac.31.2025.02.16.09.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 09:50:56 -0800 (PST)
Message-ID: <dbbeb52c-18f4-415a-b2d4-520dd0184dda@baylibre.com>
Date: Sun, 16 Feb 2025 11:50:55 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
 <20250208164111.28ec9f2d@jic23-huawei>
 <ed0e43d8-9ab4-4614-9079-8a592ca8b185@gmail.com>
 <20250211190714.4db240d2@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250211190714.4db240d2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 1:07 PM, Jonathan Cameron wrote:
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
>>
>> Anyways, my replies and new versions may be slower than usual..
>>
>> On 08/02/2025 18:41, Jonathan Cameron wrote:
>>> On Wed, 5 Feb 2025 15:34:51 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>   
>>>> There are ADC ICs which may have some of the AIN pins usable for other
>>>> functions. These ICs may have some of the AIN pins wired so that they
>>>> should not be used for ADC.
>>>>
>>>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>>>> add corresponding channels@N nodes in the device tree as described in
>>>> the ADC binding yaml.
>>>>
>>>> Add couple of helper functions which can be used to retrieve the channel
>>>> information from the device node.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>
>>>> ---
>>>> Revision history:
>>>> RFC v1 => v2:
>>>>   - New patch
>>>>
>>>> I think it might be nice to have helpers for fetching also the other
>>>> generic (non vendor specific) ADC properties (as listed in the
>>>> Documentation/devicetree/bindings/iio/adc/adc.yaml) - but as I don't
>>>> have use for those in BD79124 driver (at least not for now), I don't
>>>> imnplement them yet. Anyways, this commit creates a place for such
>>>> helpers.  
>>>
>>> There is often a mix of vendor specific and not in channel nodes.
>>> Hence I'm not sure how widely this will be and it is driver
>>> specific which of the standard things make sense.  
>>
>> I definitely agree. Still, in my experience, no written standard 
>> standardizes use as well as written helpers ;) More we support parsing 
>> the generic helpers by the (add subsystem here)-core, more the driver 
>> writes will use the generic properties (instead of brewing vendor 
>> specific ones).
>>
>>> So before I'd consider a helper like this I'd want to see it alongside
>>> a bunch of users including some of the complex ones so that we know
>>> it generalizes well enough.  It doesn't make sense to introduce
>>> it otherwise - just keep the code in the specific drivers instead.
>>>
>>> It's an interesting idea, but not a trivial one :)  
>>
>> I agree it's not trivial. But I believe adding helpers one-by-one to 
>> cover 'normal' use-cases guide the use of the properties. Those who need 
>> something more exotic can always implement their custom handlers - and 
>> then a reviewer of such handler can ask "why" ;)
> I'd be fine with a series taking on the task of converting handling of
> all the documented properties in adc.yaml
> 
> If we do less than that it may never get wide adoption and we end
> up with a bit of generic looking infrastructure that isn't generic.
> 
Having reviewed quite a few patches recently that make use of these
generic channel properties (and writing one driver myself), I don't
really see how we could make generic functions for these that would
be any simpler than calling the fwnode_property functions directly
other than maybe saving a few arguments. The "normal" operation for
these properties usually involves poking some registers on the chip
(could be immediately or deferred) to configure it. So the only thing
we could generalize is reading the property value, but not doing
anything with that information.



