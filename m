Return-Path: <linux-iio+bounces-14036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF3A06643
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D143A71D1
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60510202C4A;
	Wed,  8 Jan 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xKeaFKIh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76B1DFE06
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368777; cv=none; b=umyDTttF1YhEdOcFBqVcHeol2UxzHkFI2t55KhFh+DI9oM82OJ3MH88nx7C9ZzVqY/MUbTZyIkKc8IfuhSVHcX7QI7GBVanubIqX5t66lx3BmfmcD0pGxoVJJjnUcBy9CmV+1R/6hjiBrHW8+f2HRqeUK6DdAOdPvVWceNuG1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368777; c=relaxed/simple;
	bh=JgAq3JixBWG48k/aLvCZHXsMCRGsbDoFPi2orYtAJnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBDRO0J32D09JSoJDexthP0omOyDhehsiRI3BUAX/PUxhxQ5dglwjRzCQbzSYymow2/w1Ljtai8YJdp8y/elOdscNlAk+M+ZV0s8wqYGBrvNedVbm2Rf2SB5bMlrNJ0afmagcNifkjwzpgTeVNQkzgv42oim1G/V0vOOcMY61rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xKeaFKIh; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29ff5c75c21so671061fac.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 12:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736368774; x=1736973574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5kJCuL2LiIWeYp6c4bKXZWNKmnx7bK73d0vYdjPIDE=;
        b=xKeaFKIhR3rMtacL4Fjr5nniT4QRA73uYNVt2OmZcH52BQ17MmUbdLBDviQQW45RlC
         LZXz/oPSfhA8CFl+ihr1RQ+vgNer59RLVmV9zQUwfxtn1zoZIYXm3Jfmj4j8raVP4fT2
         RcbF7Z3jneB97rKauiErua08iW00Gw9CgD8bvTLBHUowXUwaWY8Q+CrUcRGtyeDD2+PK
         dSqNVo9g/GPzUO8Wq2IbbqeF88GniTl5FjYfdDaJh+fz30XYmC477aAuXt7jfJMIWTSY
         bqVauwvE526s1WHpQCEkB3yO9D8tzKi6jJRD9CsWHh0nWmiY68HBo5qK11HgpkyZxRgL
         //2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368774; x=1736973574;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5kJCuL2LiIWeYp6c4bKXZWNKmnx7bK73d0vYdjPIDE=;
        b=ZVdVnBeZUz3nG0+5nqNazg6ss38MaP3ex00C4DmlyCz2HBzxBUuE13ZUTcbYIeQI8M
         QsuOuKvqJTwmY77JX6dKsYFs/LRLnHVM83jPXhXH37XkwbTgi37EiW/tnc7N7vXSC2SB
         8aK4+JJQSsXuftvi/W6ssdjKALDIO07N7BWB0De05V52CHOlsQT+Ol172cDIRwyOxkUU
         7DLiAjtdXYUVatuof29JEDERVRofSPgineIvyjIW7MKTeSxXr/iezG75GWP1Pmu9g31n
         6BaTd6rus3CtLnsGHygmI5F8oVJXx+PxcVsADwMiMDtI8qFQvu9TEWJT/yMZ/3Izgr0V
         s2Og==
X-Forwarded-Encrypted: i=1; AJvYcCUZaGj2CeohNPHaoKfh9aRtk3DtWB59qcnQAfIxR19Edu8JFZ1Kmi9W981E6a85O0Eo3/46psZ6zmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeP9x6D9m4wdrwSHX3mo9QNFnXNsATWqgVRU/omtaQbARsECf
	IMlPP5oHzUF/NT3UMcmq9pdBYBBb+bklGVb5xtoFb+aULEQS5oL4FUI00z8R1go=
X-Gm-Gg: ASbGncurjBNHvBHW0gq2++q4FyBECXLBUs0h6jimXHRvRR9uP/NuWeAx3p3af6PWMZB
	vBJyw2vc4GYykg3wRX5VzJ9HHFg8i8my/j4CurfqHm6kwGgqx7IG032nFIYb7QpFGLtFDvWLl6N
	JR3KIjAPwemOCl4RXa+wolCp305hKRpDDzDw/cETLkblCL8v0DuThSUmf3cLK+0fTmFWx253uPX
	5td3NozhUbzcMIhLGByDvVjx0eKgEkNt0S8eefEIAM7rPXm586XZ34ZPaAwVlEF/Y5xm2PGsg6I
	YG1f6oYZMWgNeJwLnA==
X-Google-Smtp-Source: AGHT+IGU2x5/SgPKl5h0HBPhA+Fy/zJ++bE/ivbJHbel3cNgbAnZwZWJz8chvZlCN+Y+nVtbfHIoPQ==
X-Received: by 2002:a05:6870:9c8d:b0:29e:7629:1466 with SMTP id 586e51a60fabf-2aacdbc936amr440794fac.7.1736368773860;
        Wed, 08 Jan 2025 12:39:33 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77b4157sm13700377fac.40.2025.01.08.12.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 12:39:32 -0800 (PST)
Message-ID: <ec8bf32b-2414-4538-9fe4-2b32d890bc66@baylibre.com>
Date: Wed, 8 Jan 2025 14:39:30 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad4695: add offload-based oversampling
 support
To: Trevor Gamblin <tgamblin@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
 <20241217-ad4695-oversampling-v1-1-0b045d835dac@baylibre.com>
 <20241219161301.3f708302@jic23-huawei>
 <1c641b37-475a-4153-bcfc-e0e72d79fa76@baylibre.com>
 <20250104123029.12a4e19e@jic23-huawei>
 <9128ecae-73e9-4a66-8cd0-4d98c14ff05f@baylibre.com>
 <f801aecd-be1c-45f5-9ea0-081162dd74e2@baylibre.com>
 <dbf6dc15-ec2e-4779-9a0a-4038aaa59624@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <dbf6dc15-ec2e-4779-9a0a-4038aaa59624@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/8/25 1:54 PM, Trevor Gamblin wrote:
> 
> On 2025-01-07 16:02, David Lechner wrote:
>> On 1/7/25 2:21 PM, Trevor Gamblin wrote:
>>> On 2025-01-04 07:30, Jonathan Cameron wrote:
>>>> On Thu, 2 Jan 2025 13:19:19 -0500
>>>> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>>>>
>>>>> On 2024-12-19 11:13, Jonathan Cameron wrote:
>>>>>> On Tue, 17 Dec 2024 16:47:28 -0500
>>>>>> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>>>>>>  
...

>>>          else
>>>                  val_calc = val * scale + val2 * scale / MICRO;
>>>
>>>          val_calc /= 2;
>>>
>>>          return clamp_t(int, val_calc, S16_MIN, S16_MAX);
>>> }
>>>
>>> This seems to match all of the expected outputs for the pre-simplification version in this patch series when I test it. If there are no issues with it, I'll send a v2.
>> Probably not a big deal, but there is unhanded overflow when val is near S32_MAX
>> or S32_MIN.
> Should I handle that with an extra call to clamp_t()?

It wouldn't hurt. val = clamp_t(int, val, S32_MIN / 8, S32_MAX / 8); before
the rest of the math should do the trick since the max scale is 8.

