Return-Path: <linux-iio+bounces-21255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A47AF5DA6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 17:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA964E524B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5A2E718B;
	Wed,  2 Jul 2025 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W0KQKoGq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C562E0413
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471615; cv=none; b=d3hB7wWBnLlRE7rRudc7CNUeIBsTMyU7Co1Qr3+J7cL7uPFxnbAkCzcUjpT4lAq+8PMqmPcVY0YLUK2hDuloz/LKq9rq26heUdlNHxSYMovULNiUCJWUJ39hxSLE9wKcYegS6gtyj2Yc9WCAsyq4iJeaUCtqh8hSasw/B5ma7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471615; c=relaxed/simple;
	bh=SnlgmvXX9oBJ2pQVKACQLITc0HfSCd9SV1QSCI/mbkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/HUeuqZi8Qk1KyuHUclszik/xlRffNpL+pKEAg8z3Xf9jbm+rcZXjH3LZXVItDCYS9SoB1mvEm8FCCZjiJ6RKgH7wGim8YqCSU49Vy7gM0JubBozhAFEZM2S4jgo3e4dU2xzZ7nz6NeYhQVpkE5zmHTZgAAI+dJ9vxNhrt0Wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W0KQKoGq; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2eff5d1c7efso2925016fac.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2025 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751471613; x=1752076413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Kino+XqZYEqgWvIyTiqrJSAa+M+qswg1+WCL0GmDq8=;
        b=W0KQKoGqIUOcxiksiji1jTpJYnhg68zabcFq5EA+TFgLq0oWijZKfcg8SrJMDbVj5/
         4DEDaacT3x4OMNDe3IFKzkhHUQaHS9WBOXFjkHYHSC9Q15hDxmURDuLFGSKjxRooZBYL
         AYv+sH512FTt8l7yE78pwDS/4bvPlIEc3a4cPoyWTgPV20Zua+bgZIZp5mVpCJtnxpk8
         RjEqYi01wUJE3unzjytv9c6bvQVvHEGz9VJw06H99wyEAOcP/D7cBzfudl/d0eewSDAJ
         TL0uE7VXeRbJdBF+CarTyBpGR1+Zo7ADj8FUa2Rssf8EK/Hd/2vOfopsr0VOrGsPBd3s
         0ASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471613; x=1752076413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Kino+XqZYEqgWvIyTiqrJSAa+M+qswg1+WCL0GmDq8=;
        b=cwAcOwB0DlddRWuqYJF6Yhg4uUQjNRlrkkMNqhCbhtfOcrgU94iUOdYi0LS2TJ+gke
         IhPhfL3crhmIj6od/eUQ5jSPEhOBQgOHsIAtepnbCxRIEF6jDOY/nt4piW6ihVN2hoAo
         /D6OugYl9HPV76CdEO4rf1cccfV6HnGTw62lftOJJBY+PCfKEldJjY1s0RAFynX4H7kl
         pwxVq7hajdYw+ncHNCLu51tdOVdfOROnmLJCsFfU4uDZJcX/BZOuxjJT16dpVy5J6foj
         oUSAq1ITssgR3oPc6aNlNlrqn+CzhrcMoNEAyF3ZoEzmsxOo3PLbP/FpCi6WxCAiZ59t
         n0cw==
X-Forwarded-Encrypted: i=1; AJvYcCUc1zX4pZBQbeiRqZjkByRqgsiSKodB28GNozj4R+fswAyf0t1qLjFatfab0yAY4bd6h6LBtobSDCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySlYh78/InxzkzcqqqKb2JfT4IkJQdc6a1PPbpfexZm7ewEc8/
	e/2aVyaztW/PVAte12IF+gXNuHjvhKUTrAVOzr6K/osp6urYDpGHAp5byi715WxXfNY=
X-Gm-Gg: ASbGnctPA43+PZQqJ09K4U9ajBIWP9TnCN22AOQh8aP5f2+mUQ7eI55kw9qudKIh5GS
	OdhvY//otuCXYhg9ah+SrsK6SQllH8AurUUI/zrHQUkEf7zpJwMxLaLt0ow9nXzwap9eBjex/59
	XZ1Wj8IfUFF6LcKmUeRl2xciw3GqTxCHGSsRgAj9PmNQuXGirXIkvVELLYPsonJZgWzHXKvDfas
	pnQEVzZcnskiGaBsAhKSC8GKKbMFhH5GvfpMQ+8igyx760lGMwx9FKb4ROsJ6A113frMIsvN/6w
	qLvmwnzv/ybB5Lf9QZezlQEUkYNtFfx6R75nL2eGd6AYrX+I+tuaAD5zB4AZxY/Yh1NcQn+2g+6
	x7xJ0orsMoa8Zg/L9j0nVKNNtfyIyL644R12yKzbRTC9SzGqNBQ==
X-Google-Smtp-Source: AGHT+IHqyqv4bHA7mWxBx95w1LJXjzoruqsxFeBP7aW/iw0Ov87EOi4MTilwG8uSt/H50TBf7IQPGg==
X-Received: by 2002:a05:6870:944c:b0:2d6:667c:511f with SMTP id 586e51a60fabf-2f5a89fd32dmr2992756fac.9.1751471612809;
        Wed, 02 Jul 2025 08:53:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5c00:24f0:997b:5458? ([2600:8803:e7e4:1d00:5c00:24f0:997b:5458])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4eab4e3sm3980916fac.4.2025.07.02.08.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 08:53:32 -0700 (PDT)
Message-ID: <3361875b-712e-423f-88ed-baf41af5ad22@baylibre.com>
Date: Wed, 2 Jul 2025 10:53:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Akshay Bansod <akbansd@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702135855.59955-1-akbansd@gmail.com>
 <f96b68a5-d750-45f0-8cdd-9761b5daca1d@baylibre.com>
 <aGVIcBLgXZj_YR7B@smile.fi.intel.com>
 <e474db53-1b52-48b0-9253-2f62a3861bb4@baylibre.com>
 <20250702163342.00003c66@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250702163342.00003c66@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 10:33 AM, Jonathan Cameron wrote:
> On Wed, 2 Jul 2025 10:04:23 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/2/25 9:55 AM, Andy Shevchenko wrote:
>>> On Wed, Jul 02, 2025 at 09:16:51AM -0500, David Lechner wrote:  
>>>> On 7/2/25 8:58 AM, Akshay Bansod wrote:  
>>>>> Update the sysfs interface for sampling frequency and scale attributes.
>>>>> Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
>>>>> and recommended for use in sysfs.  
>>>
>>> ...
>>>   
>>>>> +		len += sysfs_emit_at(buf, len, "%d.%03d ",
>>>>>  				 odr_table->odr_avl[i].milli_hz / 1000,
>>>>>  				 odr_table->odr_avl[i].milli_hz % 1000);  
>>>>
>>>> Let's keep checkpatch happy and change the indent of the wrapped lines to
>>>> line up with ( since the ( moved.  
>>>
>>> While I see the point, wouldn't be better to have 1000 replaced with MILLI
>>> at the same time?
>>>   
>>
>> For anything with 3 zeros, I don't consider MILLI better (or worse).
>> Science shows that the average human can easily see 3 or 4 things
>> without having to count them [1]. So it is only when we start getting
>> more 0s than that is when I think we should be picky about using macros
>> instead.
>>
>> And in this particular case, we are converting milli to micro so `1000`
>> should be replaced by `(MICRO / MILLI)` if we are going to do that.
> No we aren't.
> 
> This one is converting from milli_hz to hz + sticking to milli for the decimal
> part.
> 
> Lots of other IIO cases where you would have been right, but I think not here.

Oops. The %03d instead of %06d should have given it away!

>>
>> [1]: https://www.scientificamerican.com/article/your-brain-finds-it-easy-to-size-up-four-objects-but-not-five-heres-why/
>>
>>
> 


