Return-Path: <linux-iio+bounces-20568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F0AD79DF
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 20:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4B43B5809
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C132D1F59;
	Thu, 12 Jun 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="up0cQ/s/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0FF2D1914
	for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749753921; cv=none; b=u7BjlHvaa8bJb9W3cEDS9rSTJO1dSeayEj29dTzS1OHe6plmkUYhm0o0fFH8AzNNlUl8P7FoplzccqD9/K/D5w68/ppUYAuvO0ugdGLyQ5Y4jhYAKS5EaGanfB6jJFb0Uf5P48Xqd1G9uIyufWX+m81xi941jVfyHs1nxRqOqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749753921; c=relaxed/simple;
	bh=ghVin/6Ib0ofa4efnFqrKYdd0d+RZ2+V2ryhajaUhlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+m83mhrkjJiPBMWLaZDaOcF56Owbil8Jw+T4+mKULQecE+3P5+FWLU9oO6bEVHnFh4nJGvOPE8QPczSy76X5uWdAyiX5EXAxhaazOJe5IgZtnUL6Kh/Z3Y3F1sapgkgrkHFmGNRGJKDGyvOxNpeJcqFBFe1tX1+VIkBZQgxp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=up0cQ/s/; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-735a8be4ea9so341558a34.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749753918; x=1750358718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7sQVX/y9VgLzZU99FAxTuH0wCIRxWwgfapnssnH/pQ=;
        b=up0cQ/s/k4VMxNLMyNqaJ6eI447v9Q278RDtFDKN1GrKQy0v4ZPkhpJa2hTK3R0WUD
         6CGeLSfvOoVxGUJjKj63IFsWOqizQx0twD2RMTjDC98cjmEWtZxLytuZHAHjCJaPQasV
         tmaLE4fxu7Q7LysV2sEG77r2dkLaKAA7B702FOzZIsf8DxLjJVtlhE6EiSNMxovnLhd7
         VAv33BbKsG6DcAaFB+PlS+bYs+tzNajREYVdQRMfOPoEZzSJI/Ufnbj6tacay/aeDk1g
         zmNto41WGUS7QAMRQ/pl5Q/GlEbg1tOrPDplytoZFcbIop9SjhwuIqNoPKAZqVuwFhZS
         q0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749753918; x=1750358718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7sQVX/y9VgLzZU99FAxTuH0wCIRxWwgfapnssnH/pQ=;
        b=U+xc4qNTQwn9oAyPEhARQYsOud3pMxW1/QmWOKkei5furqaflDcbTNoS8HrIo8TMc7
         cDDbSWX1t7PtrpOoIku0k62rNsSBeakLhdPFgnIUPsIAplj9NMWMVGdbtp3q64j/I+G2
         8siuo5wJwTW6s9IXYq7Tuwd8pldAIGtZop6SihXSoPvLLUQ/ztneyCciGwZ0U8zzuObd
         ZBfBKqpwOt7CvlpZ8qI2TpxoFqewBsq9EWezPLaqBACWhejyfB04PzDHHlOLGVZus+9a
         EHRjySakfby2gdAOUYNWi/ysT2mB2YYbuAhQn2v0pAvMWcRAprRs6ZsZgYa6hq1PyRLY
         85Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVmS3wvN7+Ud17/7dHTzocRfD+pnUGKkSVhc0jF6peXfXFLLnf3Gyi8lJyICKyqmRitRPf08rbgzGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwvGj1hMszvOPWCgIiOXnlf5i8MzlXoE6fXTk6WTDm02mnKKr
	dmIXADG5koXV+xiNGMdKzP1UU9MkptOcLfERKhyw+roAwUC1LZHyiQ6ULiHfxVhAvyE=
X-Gm-Gg: ASbGncsIyFe87sjEd9rn10pbzTRVBJuJPOfFCWFqfx+9ZHw6WHuKtlKiAbzmqmSm4tU
	kyHN1oaqE/ONbGKstChNGCF9VhSGxt1eWhSmAHN37cqz1P4m7NMFNkPNRB03XBWju/ac2g0XxTc
	8GoenukFigle852G+eGG2B0BR5TN7lZ1RvOtb5coPn8ow8xlgI2vPk73wlpXXmcx30dA2Kslo0e
	JC2e8sq7Rz2WHps0CvbRDO4oVX8VeURLF3bEQduJm6XYUpQsZgnT3GNDdbHSVPpqX0paM9ZqSX3
	+hCjuv2vy8rq/RNOCflvHVNZ3avxzQKWXsQr0V8LNaZOXtiDtXas/NiKBQ41qPqF9x/eHM6Hdu3
	IwktVDwHo7otT03SZguPDwKwf7n+ypR+ecixy
X-Google-Smtp-Source: AGHT+IGz47jHNxt4zvlUkgydTLbpaFIj+soSmjpN2OE7Gp76WmFhuGKdZYM9K/JqfmQtchA9LQrAiw==
X-Received: by 2002:a05:6808:21a7:b0:406:59f3:73a5 with SMTP id 5614622812f47-40a71e80deamr342590b6e.19.1749753917833;
        Thu, 12 Jun 2025 11:45:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f808:847:b3ae:ff1a? ([2600:8803:e7e4:1d00:f808:847:b3ae:ff1a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a6822f829sm403435b6e.15.2025.06.12.11.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 11:45:17 -0700 (PDT)
Message-ID: <846f5979-778a-41f0-b5d2-52d639607315@baylibre.com>
Date: Thu, 12 Jun 2025 13:45:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] iio: amplifiers: ada4250: move offset_uv in struct
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-4-bf85ddea79f2@baylibre.com>
 <aErQVKul7Gnxvu3F@smile.fi.intel.com>
 <275cf035-f0ca-4aa6-a41f-b0c21d7c9374@baylibre.com>
 <CAHp75VeewKdOQk9qoO-2Ann90hwAGE0goOtiOG9BRjJ4cn6h=g@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VeewKdOQk9qoO-2Ann90hwAGE0goOtiOG9BRjJ4cn6h=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 1:34 PM, Andy Shevchenko wrote:
> On Thu, Jun 12, 2025 at 6:31 PM David Lechner <dlechner@baylibre.com> wrote:
>> On 6/12/25 8:04 AM, Andy Shevchenko wrote:
>>> On Wed, Jun 11, 2025 at 04:33:04PM -0500, David Lechner wrote:
>>>> Move offset_uv in struct ada4250_state. This keeps things logically
>>>> grouped and reduces holes in the struct.
>>>
>>> Can the (smallest part of) the diff for `pahole` runs be added here?
>>
>> Well, I didn't use pahole. I could just tell by looking at it. There
>> was int followed by two u8 followed by int, so we know there was a 2
>> byte hole before the last int.
> 
> Yes, but since we have a tool for such cases, why not use it?
> 

In cases like this, I don't think the we are getting much value
from it compared to the amount of time it would take me to do it.

