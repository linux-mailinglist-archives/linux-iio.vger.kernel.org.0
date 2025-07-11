Return-Path: <linux-iio+bounces-21580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A470B02249
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63F11896054
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71672EF667;
	Fri, 11 Jul 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P7lIZ+Pl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5DA6ADD
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253447; cv=none; b=Q5rAnhNv6eVnos/nDWuX9BFzHAO2Hm5vhA+N4oiCbAyno+rrPciAjLbxMPJo9lvLyqqvDe7eCvhKM7ahCs01LQPl8hzrgPm/S+4NX5FFG9W1eCJy6iGK6YzLpR9NiJKCMPfEeFAwxrztRsVKwPYyqLTfbQEtACUfQOwPXzemrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253447; c=relaxed/simple;
	bh=PnT4dFphw7u3i20NU19rEzTxVmci2gy89ixQ4Wn7OdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/qTATiFnEkuAMhUTKLHFjh+uW0qI6W0dmx5XAhfGFP4xRHXQ1/Jax1B/92cXPFr7Q/sRXLIEjzkRTNpRoDwHrvdixN0Jc7KD9FibKM2kU3brsGWDFXKu3rENOe/YeKbTy/lNr3aBSbpa/5YY5Lo1A8IQgjpaaKe9Ms1oFZtrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P7lIZ+Pl; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40ad1f7c23bso1338813b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752253445; x=1752858245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25weoVSEgDYzfjwlVT7VVDCe9SsshCl2MvcsP7470sk=;
        b=P7lIZ+PlS75cLi4tCKYz323SXIasRnQhvQ+d27LZ93Zn4MKjF6cs1HhQxeLwW4jvrV
         A9iH0QbwDWbwbNBYb3vnCBITUSAGWnwV3KyGW1dpQYlznjNK5hY96PDgKDG0L0jcAGZt
         aZ2FV3cBqcJLYk56uJAUL1CuUYqLFY/TssCKixOGgO7uhtd+MgVDoFd/qL25t3TqKbaq
         LMnsBbEK2wurNGx5IZIwG/puW5P/4GpYzU8F7evyD6Omg6kSNNTIwxTeogFsDxVRthVt
         pGGBEpXOjo6fypY7QlcXFk1SB7cDqNXNHzwvUUdfhWsKXavVeTg73611QLmIVtXcwP8W
         pM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253445; x=1752858245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25weoVSEgDYzfjwlVT7VVDCe9SsshCl2MvcsP7470sk=;
        b=n3PftrGs155gxR/O6EWF+MmUIW2TgPNJ9ygmUUxLwQb4ahzXlLsUvpSFiAbMzQXYAR
         s0+OUDEXzKoAUlbX56viETHvXWP3Jk9h0bnhl5FLVvpq/fWUj881Z/9vqryYV89CnM3w
         WYxGMChxmE7vqKUYXLu6oI/1FfpXbIrd9ftTX4jkSQAejpf5tpJhHfXzq/Z8EIHeadwf
         EmieZEv8TDKEU1KkPoSLsU8MQ3flc3sgk3EKfEeciAqPlIZt4azn9KUBPGq3kP0qkaam
         R0hEwdofCY5y+UVMW44REfE5z8aDp7df3uIVrEBLD+GThNn2Juq4FhZfO3fMHp8z1ekc
         UHlg==
X-Forwarded-Encrypted: i=1; AJvYcCWL5vqMPuV3eRhBrnCkcp9E5EK7eXS/4wDcBXs1wQlLOAopzfCysU40Ej5APRS1RsGqBcFHIsdWdCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvh+GdZ/wvof7GIGe2sEaspfZGZi9VydRjdwIqZdRFXLMm5U0E
	4o1iNS56Q4i+VrF98K5msKF4WE+C5VGq24y1RDhPSqfhKmwjTJu15nuuMM3A7wHtPVw=
X-Gm-Gg: ASbGncs+o5C2snR+tUpkECVYBCJx1KX7LojsLiRSmCdr31CTa5DTSHmOPl1kDP4BiHx
	TKJf8zNRHAd7ABcwQ4l1S6/xjedMrlOH3WerEzrLkA5XjwCOeU0rdjE/3EhjVGTW55hZQi+zusj
	QLWokzjwFM87SrIuwhKzblSpMNYPTQf1GKTZBl/pmEgfqTbCYzr/UsWCjEBMWjZfjV+bXi1g7x9
	ftHXp7hE0aC4U2oUVg0N1/ajS+pdYICTjVjorfm9YGkiwl2EYbJO+r8ATHV1dcienVI/Fsm3VR1
	vBb0UJN9rNH44bn+W2a4OdyzAVkIRwSxn6Cqbl5whnKmcfpbj2ZbS40g3q/4CfNp8Mgxyf8NR1l
	Q6XYMVogqUQ61lx7BVmQkJDFtXD/cHL3FdzxgC6nq/xqKlra0+tzO5Xn7bnOfxjFXwk3+2jUhye
	26qDwgBvQeHA==
X-Google-Smtp-Source: AGHT+IGIW9JMEqzi1KelxvvTFcVWg5V5Ue+7oAq7Plm6PnSkbrM8lciOD0X3y2OrpFVIYBz4h/HDhg==
X-Received: by 2002:a05:6808:514b:b0:40a:5356:6569 with SMTP id 5614622812f47-415393d5c38mr2567599b6e.25.1752253444571;
        Fri, 11 Jul 2025 10:04:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141bdc823bsm607742b6e.24.2025.07.11.10.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:04:04 -0700 (PDT)
Message-ID: <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
Date: Fri, 11 Jul 2025 12:04:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 11:41 AM, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:
>> Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer used for
>> scan data. There was not any documentation explaining the buffer layout
>> previously, and this makes it self-documenting. The element type is
>> also changed to __be16 to match the format of the data read from the
>> device. This way, the count argument to IIO_DECLARE_DMA_BUFFER_WITH_TS()
>> is just the number of channels rather than needing to calculate the
>> number of bytes required.
> 
> ...
> 
>> +#include <asm/byteorder.h>
> 
> Hmm... I see nothing about this change in the commit message.
> 

It is for __be16. I kind of assumed that would be obvious, but sure,
better to be explicit about it.

