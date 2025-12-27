Return-Path: <linux-iio+bounces-27394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47BCE010E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A3F301F8C1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387E32573C;
	Sat, 27 Dec 2025 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yDc1r99R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2A1FBEA8
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766859878; cv=none; b=CbWsdBdxps3w0R8R/bKjD8W4g9BD0r+a9T5k5EcRO0JbFHdJa5DA1DCIICnQUfnqUJ1G6W7rTa78en6I6NWlW+e9mKXyewz2C6XwaDF49BGeVDdL6lnfPWrITkXX+bB1Jxx/Qhg4lD6Th/ii2avqXHFeQZmz/XRo5DHvFggS6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766859878; c=relaxed/simple;
	bh=qn1/KjlraYXzELC53+o2Hfshv5d2CDgEpi4rQ/uNbT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMYiVURtQ1UUh3ZJrYdxnsSDwU+fB7LsFgH9kyJvsrlwe90/Cwk4fG8x7Ke211Pi/3cS8GyDearx+sG9ppiDXZTLXP6a2F5hP8Pw92evDJYRwaJjF5VlOCK2ad5BdkdqFYvfr6Vjmd1WACPUQo7CfL+bqmCjSY7HItXDrW0/rqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yDc1r99R; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e80c483a13so5498175fac.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766859875; x=1767464675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NyLfdTTGOfZ46h4QKpaWWdzrCy0NX0nm8plxK7Gnto=;
        b=yDc1r99R8RF6IjEZodevrZrXJphyPp9CL+8XIUi7ECVMoAsEYta1RmoBdb7v8ZSaGf
         dxWD8A1lZNQQ3LZyF9hJWoZWemFyppA6Sirn+jG4V17zN8Uo/TJ4xTJ3SjVcc657IDCG
         QzpI/mQjOXVmAnE6jsT4XRl1WdVk/hKa+4nm2qlsCyatefIKLEEQStQ81359dTdA6yvE
         ZzXQRNMmTAs7rOc6zPQcNJVqQmGvlL2tXuUwLHQW3G4erK2jF8GcPFT/Z/b87I594Cjr
         UmBhyNw1refdQdc3IQpAGu9fJR6n76a1OKxrmEQ9uqjuuqFbmtbzbg7NWfXOAQcVj2H/
         OD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766859875; x=1767464675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NyLfdTTGOfZ46h4QKpaWWdzrCy0NX0nm8plxK7Gnto=;
        b=VX1wlV5mnOLxULW8l+gO8UvD+nc7cSjO2wiCZnMGrHvUqapFOD2NMEFE/pFLHfuI/S
         l/lFwJH4lkduS2hwoB597qt+IRaihC4Vnbz2hiPc9srGfgD5QT3LslHwfwj4VDRIAcEB
         l0gCAPGvAjDYKCbpanrA1xM7t1fVnGTTLB9K9BA2+ZJC/+GvtdBZ7+ewTvzqtvYdpd6D
         vyIB/5APIZH1H4kcEhqtoglZYixjcgZFRE4rFQalVS2ilu4AH0VdPlhOM+DVzFRbyf+t
         MrxEOcJqa1F+UIYFFocQ90NkonjsAJlgBGwkGPFNWN0wU1PnrhKfBuxlrgeoCryK8J3R
         YZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwJL5rohPMSsQYj+7RMLHVzBGf5U4p5NFuPvXx1d3PzYq3BgvCPY9MnyzIKXPFiEe9LjuZjhrsCFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMS0KZ7EK/nVHlkamqqe5bqMFwVGkGPzl9yY5TLfWxR9tG8cE
	SopyR0CAQ+HT/jiT4YOtmF7xwcxrJ4M4fNRJ9LSpgxt9chOpvder19q+f5yQSSAEvbs=
X-Gm-Gg: AY/fxX4uYF/RCrV3Wc4PGrD84g8w+Sex7thjZVGOOoblOBSQg01mNmr/HZ0tAT/losS
	l15LemriQoDCF4JeieEQqtwULAgDhKVGZLEXd2PMB42sDjGK8G/Tw5LiNr2GeodmEZi+Wce0r8V
	x1yJVjutu2ShK4Efn446BkWMJ7tGa0UX95mNm9BqQE7tXlpLbb89Dr8+uyQDF5tJlsrS20CRCG+
	3tXqU6AgAm48AU2fGE4qjKJ0OOUj1TylNKoI4QBuIecAdJFknffc6XK1xVUV/umaDDY8bV+a8dY
	JwPe/znS0SV4ui6eeLk1JitcFSfWEN4eS3OIj7BYMTI0Gytkxz6D8PWP18W7EePLUTptETJBSir
	CPluB2y7b6bmIKdgMckMlQ/v/akhquZ44HlD4qlu7oYeo7Bpfps9V8SY0szDKPtF/zFc2piNN8g
	4B8w416/Jg73K4H1usGlWOnIfltgVoydW30bpnIOAsZXPUE3obmoS40xbgyrih
X-Google-Smtp-Source: AGHT+IHW9W4FACWrecgndjl/f5nrAVrhz5eZoyqi7rwqFTdJ2qVjM+zFhAuRS2JHdnCzQs5l8E/oMA==
X-Received: by 2002:a05:6820:4301:b0:657:5da2:5f5d with SMTP id 006d021491bc7-65ea0345562mr7382265eaf.3.1766859875605;
        Sat, 27 Dec 2025 10:24:35 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:81b7:1177:37cc:3153? ([2600:8803:e7e4:500:81b7:1177:37cc:3153])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f3f8807sm15949141eaf.3.2025.12.27.10.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 10:24:34 -0800 (PST)
Message-ID: <f1c1ca8d-7896-4ccd-b59b-8c6c1bf4fa66@baylibre.com>
Date: Sat, 27 Dec 2025 12:24:32 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] iio: core: Match iio_device_claim_*() semantics
 and implementation
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
 <20251227144707.1bebcf27@jic23-huawei> <DF97CCMNGWVP.2JBZR7CQF1FID@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DF97CCMNGWVP.2JBZR7CQF1FID@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/25 12:14 PM, Kurt Borja wrote:
> On Sat Dec 27, 2025 at 9:47 AM -05, Jonathan Cameron wrote:
>> On Thu, 11 Dec 2025 21:45:21 -0500
>> Kurt Borja <kuurtb@gmail.com> wrote:
>>

...

>> Given earlier discussion about this one being rather more tricky
>> to name than the claim_direct because claim_buffer sounds like
>> we are grabbing the buffer, I'm not sure on the best naming to have
>> here. iio_device_claim_buffer_m maybe?  Ugly though and
>> these are super rare so maybe this isn't a particularly major
>> concern.
> 
> Yes, it's a bit ugly, but as I proposed in the cover letter, if we go
> for a full API rename, it shouldn't matter for now?
> 
> What do you think about that?
> 
> I'll go for iio_device_claim_buffer_m() if I can't think of something
> better.

iio_device_try_claim_buffer_mode()?

> 
>>
>> Given I think the people maintaining most out of tree drivers
>> are Analog Devices maybe this is a question Nuno can answer
>> for us?
> 


