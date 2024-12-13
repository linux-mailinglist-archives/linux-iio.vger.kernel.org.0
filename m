Return-Path: <linux-iio+bounces-13441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DC19F19B1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 00:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446031660A9
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12601B6D10;
	Fri, 13 Dec 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YVTlMtk8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE461B3931
	for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131463; cv=none; b=VQXic2raMBzQCx7zX7CRxIfXOlQlF6OYMiw3lUy4usm8WOzQYk4xvt/pm6VKUksr7pzs8JvFejDx43lSyaN9RKGuol45RW4MrTG2VZEMAumSefpEQ85ZV9hzjaV9rfCwBpv3P1PS3hbP201ShhOtBG1hVS/NLnNmbsiFJl/zVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131463; c=relaxed/simple;
	bh=rmUX76AAhJtcbKbS/MKBhumEX3FZeF756LBDXcfM/+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RVfOBmId096uB2mDg70nPI7pwm0AsLaMJm11Qg/kCznx4XcfLBO+mlKE6/25pXYV0X664BbwksoZ6TMHj8ZbmQYievDQG32sC+eAUJCzVYBKDnX//CDgzsokySy8EAkQCeSLxH5l9WPB6WV902Xx3G2MJyZpod+m/F2EK0SqggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YVTlMtk8; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb6210742aso1166731b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734131460; x=1734736260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wCKCByuAlAaTXDYVy4N76cFvOrIazxQnE0CZ0HL/Is=;
        b=YVTlMtk8/qddeqAYeD/4WSY4D5wB8+Vtzhp87Pwg2DeyD87QvTWYwv1uTZxAT73p+S
         CZCXI+B9QI7p3BlrqnbjejS5APvutEbap1uB2Ql/KAmIGwCDQLAn0pBnUjXjPyl2JzOX
         xDr/a3HJCGMe2nXvdf7+0h/OsCmZDoaUTspY73fiSE1MFWPiGcD1EjxjQ6I22094tq/P
         fO023AOZO7JJfbe30SHUK72hNcakDBFmReObO7M2NFLMJ1/Diw/Jc3w7b47Qzu/rOghL
         FDXFQgvBFqUyX3BkOblgZDTHMftzS5fe48sdyoYXvUPUxKIgUVN2UAD9MimTDpKkCFvz
         pziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131460; x=1734736260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wCKCByuAlAaTXDYVy4N76cFvOrIazxQnE0CZ0HL/Is=;
        b=pLur1W0sJ+mBcs4Vgmp1CoqTbVWZjibPVjUbbL3QssbYXtVZtVkpCn4C/RqWqVnExd
         uKcLh8o2iWEB5ZLCoi55TOzKernl3T5Y6elzupDql7TZVOxR1dSp4q65pPzSkHXUBKRp
         IC2hEzanRXkOoNSbfe+DHR8W6X3ZOBQBCcAoH3bTv+k5YmFiDd2Gc05Rxnvy4jTDmJRb
         NFXwDDqG/yG6hWz/ekTrTExtNjdmh4JQqnp+2CzwkDptjP0aJV3CVSoibTz55rpXGtIH
         C1rf/w9Bbru68iiuMebnt/C3eoiXVGX24ggrCenM14LSGWmHBfzNb76PYYpX1+lfEaYe
         DHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1qyExjOidjyqNpcjBnaA9l8KtOjkUnByTUO7JHDT5/8YwqLkja8XAOF+f2s2NJpO/DZTEyWQp+mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WugM1MaqcRHAlvQAkmH9DDqxE0FkaR7vWvRDZ1vQ7IGgz5NE
	eX4qEvkjlK7X/e2WWl40f2GgP7vBnRUHv7Ic1ADHgCGq6qZseuQP3F4Qw8VKyvM=
X-Gm-Gg: ASbGnctceoS6jg4W16HMQdk2MMBI1FwY8G31oNSaOGIxbY3KvpU1mzUyiHro0YB8EmI
	YKY+1l/GWBQDHZYommjEAl1AiiIAQsWsj9Vf/rWxDCKfEKLHkQGrFB3DxsftUAhnZJgHbtjp+xj
	eS8vcdZdGDeCB47vqzGriXU6vG/kCs+KnKbS/MgHjRiZeY3oFjAUZsJ8lCDdAZ+zQjmMG5KOZDs
	jKHfGCND1+6FQJxdzea4BYceOVuZbQEKcR73XsmlMB8ThwnZu+MwG+der5ycvpWAN4F1+GfjlAB
	9pE1lHFko7niXVcb9w==
X-Google-Smtp-Source: AGHT+IF/HrkFYofu0XYPQ8FOsQdBFSwRshag+zqD1aQtDkwS7D9uEJpxpNj5EPvXNNnZAMQKCg6HNQ==
X-Received: by 2002:a05:6808:190a:b0:3eb:3d21:9cf1 with SMTP id 5614622812f47-3eba6bc2f20mr1744768b6e.13.1734131460011;
        Fri, 13 Dec 2024 15:11:00 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ebb48ce912sm119808b6e.40.2024.12.13.15.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:10:58 -0800 (PST)
Message-ID: <ac529e7c-8655-4ef1-9bc8-9081d3c365c3@baylibre.com>
Date: Fri, 13 Dec 2024 17:10:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] iio: backend: add API for oversampling
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
 <20241213164445.23195-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241213164445.23195-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> Add backend support for setting oversampling ratio.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v8:
>  - pass oversampling ratio
>  drivers/iio/industrialio-backend.c | 15 +++++++++++++++
>  include/linux/iio/backend.h        |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index ea184fc2c838..e56b1e96652d 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -681,6 +681,21 @@ int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
>  
> +/**
> + * iio_backend_oversampling_ratio_set - set the oversampling ratio
> + * @back: Backend device
> + * @ratio: The oversampling ratio
> + *
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> +				       unsigned int ratio)
> +{
> +	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, IIO_BACKEND);
> +
Needs quotes on "IIO_BACKEND" here.

With that...

Reviewed-by: David Lechner <dlechner@baylibre.com>


