Return-Path: <linux-iio+bounces-9244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1596F571
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25251F2500D
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708D1CEAD0;
	Fri,  6 Sep 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qdVl+k5W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDC149DFA
	for <linux-iio@vger.kernel.org>; Fri,  6 Sep 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629607; cv=none; b=snx6zuRI0zOx+E9ZQ72Mg2KwQoFu1dWAHN4VB2A/rQ1nZYO53VyVYsjt1+Xp0nSsLXExqOtRsWqeKxyxnpowFLrFqlWKMB4CD7WrwZTjO+Vl0jF71cNrACHyoYJ0aNCXjc6OSXwydqvyt//QexzbNHYSqbUsGRo3n4VvxGjlxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629607; c=relaxed/simple;
	bh=eJO0Wf/yWgnqoyhzRb3WOWUvELNt5GGNX829R/Im9tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBqx4NGjvSBw/aXSHFYRiohC4HMQ+W4EAbio1BG7VDZ/c/illsdCUVfZifQzsoXoYhvlMGyYWQ1jlVnmegvRAv4p+Cb19IBwUGIWTtw9Hv1tv9lEy4LkXg0mvqsEIDixKN9XPvzkcV/6u5SFmLfwXYKswlW7VGIPCxOtPYR55AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qdVl+k5W; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e0059dc06bso1297103b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2024 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629603; x=1726234403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsEgGZlpuH9wh0lupJqRkJ9X0JwfAqQ3O1SdcnbcGz4=;
        b=qdVl+k5WxB6qh0PrasoDnYD0C5C65j3z6x/AN34ryDv2/dfwQuSawXYowoeoXM0ZcE
         AD9QZ5g1I5fCFwApK9KECGYKowfC/mXYRM7SqjwYfzh2Y58dF2fK+ePERVBOITxblivm
         E+4C/bdirOBV1pr/edQLr26GzTRFIZBcCppexRmDYdF7q4ttLy4KW7j+KgJYZCFC78m6
         6AKT7DvHiZ+g4DU4Z8XWgGLoyFSaYdl5yr3JE6tSeiw9zaHamvx9iBhr4s3uwA0WXjxM
         9e74qgaV8gSk+KrjxVao0d9wJxYUOlgix5NoxZ9aRndIKucWGfJqNvorSmTJ/yq6hjfF
         qnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629603; x=1726234403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsEgGZlpuH9wh0lupJqRkJ9X0JwfAqQ3O1SdcnbcGz4=;
        b=HFLEIyfFNpXgtiqsZ6ayfScGSNym6Sf0nHzbvz1pqWF+K1RMlU5+a3IRcCjGp+SzqS
         wRBmzdfalF75WUiARQRVpzr0Pj9VcxzQVt69EoCXdT4PByZUbDs7p8rAntXuIko96vUM
         n4iw6X5duVkJk6eaN+Zc+Ipu9RZngEYhxSBicVbkrtvnsf9eCNiv7/jqhkBDcw7Gsq1I
         EN9g2LlFIVpjUHLKiq6nl+A022My0zUg69JwWo6ToDLLeMJ8PjS4YUtQ3T7Kl5n6epNz
         4ekr4WWz4uK6mskFJ/v964IPHaVfwm6K+mumhZmLPoekJRx2wQdCnGRNePOvBCraHvkR
         WC3A==
X-Gm-Message-State: AOJu0Yz02Don6jH0+ewKUwzcM+QSfUmyIpyvmKvmYgKr4VSUcScn+H+T
	Ziu59ZNOsZnQWXvH24o4NUFfAemSMoOKFqsexCRlAMAGZ3LE62GSONstgBBf2ps=
X-Google-Smtp-Source: AGHT+IGYUB83Z9nHWlTPrQM9wcE8xiaAiLCAyx0JD2GWznWKm4BOK3fAJlbiEp6O7QTWgUkQXfmnGw==
X-Received: by 2002:a05:6808:22a0:b0:3db:334c:9768 with SMTP id 5614622812f47-3e029ce74c9mr3327075b6e.1.1725629602961;
        Fri, 06 Sep 2024 06:33:22 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11865a3dsm3722385b6e.45.2024.09.06.06.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 06:33:22 -0700 (PDT)
Message-ID: <52eb0187-056b-413a-a64a-6fd001c27132@baylibre.com>
Date: Fri, 6 Sep 2024 08:33:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] iio: adc: ad7606: add support for AD7606C-{16,18}
 parts
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
 gstols@baylibre.com
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-9-aardelean@baylibre.com>
 <2bf78e47-909a-45c0-bebb-6a8d38cdef7c@baylibre.com>
 <CA+GgBR9=unTe5WVq0G2zowbL9FnLfCwoAuZp=7VD=xZOt9Gn5w@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CA+GgBR9=unTe5WVq0G2zowbL9FnLfCwoAuZp=7VD=xZOt9Gn5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 12:34 AM, Alexandru Ardelean wrote:
> On Fri, Sep 6, 2024 at 2:30 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 9/5/24 3:24 AM, Alexandru Ardelean wrote:


>>> -static int ad7606_read_samples(struct ad7606_state *st)
>>> +static int ad7606_read_samples(struct ad7606_state *st, bool sign_extend_samples)
>>>  {
>>> +     unsigned int storagebits = st->chip_info->channels[1].scan_type.storagebits;
>>
>> Why [1]? Sure, they are all the same, but [0] would seem less arbitrary.
> 
> [0] is the timestamp channel.

Oh, that's weird. First channel but last scan index!?


>>
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (storagebits == 16 || !sign_extend_samples)
>>> +             return 0;
>>> +
>>> +     /* For 18 bit samples, we need to sign-extend samples to 32 bits */
>>> +     for (i = 0; i < num; i++)
>>> +             data32[i] = sign_extend32(data32[i], 17);> +
>>> +     return 0;
>>>  }
>>>
>>>  static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>>> @@ -124,11 +176,11 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>>>
>>>       guard(mutex)(&st->lock);
>>>
>>> -     ret = ad7606_read_samples(st);
>>> +     ret = ad7606_read_samples(st, true);
>>
>> Shouldn't the sign_extend parameter depend on if the data is unipolar or bipolar?
> 
> [c1]
> Sign-extension is only needed for 18-bit samples.
> 16-bit samples are already properly sign(ed), but to 16-bits.
> 
> It's a slight performance improvement, that may look quirky here.
> The idea here, is that for ad7606_scan_direct() we only need to
> sign-extend 1 sample of the 8 samples we get.
> And we need to sign-extend it to 32 bits regardless of it being 16-bit
> or 18-bit.
> 
> In ad7606_trigger_handler(), the 16-bit samples were pushed as-is.
> Which means that we need to sign-extend the samples at least for
> 18-bits (as it is a new part)
> The question now becomes if we should sign-extend to 32-bits, 16-bit
> samples in ad7606_trigger_handler(), as that may break some ABI.
> 

Sign extension should not be needed at all for buffered reads (that is
what scan_type is for). So sign extension should only be needed for
the direct read when returning a raw value via sysfs (raw read).

