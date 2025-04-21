Return-Path: <linux-iio+bounces-18481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C5A9597D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F38716A9AA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E422A7EF;
	Mon, 21 Apr 2025 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tL3kY0/M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19022A4FA
	for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745275246; cv=none; b=DEOzddutkFR4ThYR3M9CIykqxgbX/EdIYvANUB0sKGrZsSTL4oF1OqUOfLyoSNhFTsPgzSm8pvaAlUgEzWRS1I2omPHXI4wKe4yIXQw/Q72Q9RteOfkiWCxLeRfhGH9qjqrLY/uZeBt8CG9j2L9CruE/fm7QZ4/Pfk54bP0GVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745275246; c=relaxed/simple;
	bh=PLiO3MKV4lzQzYAiBtG1vrvS9rWQyJ8D/HS9gjDnR+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5x2rX+PWHhVA7DQwu/+ueWvCdaqWaLUInmvciMOAn7WNn7cUEmVPzmJXVBuEE1eRP5h9UCQsNZvtxlau0Bwghh3NA0LRZ4+ZYbP5/RjGaaB6somKnciD7kmXDra+E8CjX+u09dSjznNQYockvSnuOjKxD1m3iaEFeg/PsdLlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tL3kY0/M; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6044db3b45bso2615001eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 15:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745275243; x=1745880043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fmYGYYsZqn1kIj1/3EBJlD/oRzETbREprNZiIc+9EM=;
        b=tL3kY0/MgTf6wA8v58XHNWTDJLw1u8kPuqW/VuDN4GJty6Yokie0I6palFX+W156qJ
         vip2YSe8tBjIGLuowsWAKBDPEgNapw9iUEMFiWT1VPUv7h/uCPLvPzAPcLyC/o0m1RQB
         hsjpxw4Se43Ms9ZTB7+OXEE8H5JkKBMTF+SZDPYvQ89HFbWIAIjqNx6cbVpQoOyCq2ZT
         SU3O8KZvmfOCyK/NgsN4OT6/FxMLMvuVIe5z5z9X+oBeJ/krW4zv7C+H9WJWU4/2XWTi
         QBb1nMZP1dNXHpk3ti0EMZjMTDGYTRQnPdTYU4o8MmR45jj5VHQyQpC7ZCBytA6ZiJHB
         HtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745275243; x=1745880043;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fmYGYYsZqn1kIj1/3EBJlD/oRzETbREprNZiIc+9EM=;
        b=o/Ny8LgOSHkqUSm9JQ94A2OQAAg7wjkRwijMJZHrlnm6dXNmLX1BnyTZlFCvxIrGMP
         RyX9sFBPDxRo7MMDxdBnP7G1LsFUorODr7k7w5yWYkUV0+QJLFfFJfqA85krITk6YhR+
         RTDIW1Z7gE9895ld5xl+sw+fQg8Qwoj4m+qxiC1tPOaDIDvW2+Mu03NiwOigV4H+T8VL
         Bf25NXWjVTaDhKpBBy0o1xl16Zz8ZVcQUPxnqqvtkBtP3XCcVHrbdAwHBJyPwtRceoHu
         jMwpgGOE+tn3pV7ElQTsRbJjfAd5jnpB0RJlTvU6eweBZ/vtpE4XX8kO/haTpqBlUXHq
         cZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtdEx9I10iNT2nUuISPEXqUFzPVsjnMtEvztfQQacglvFXuZAiWgZA8pVRwtrcZhzWJ+fAYdD4q9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolRINv9ZKJymY4fV1E7tzJwmXr7uiESyAGDgz5SG0a9mx8VWc
	UoGCHdqv16MBBZYmcCwn9Ff+HWaKYh3/0k77LAqODmwTO0hl5h7iJ8zDOSxlt1o=
X-Gm-Gg: ASbGncsHDmPk2OOZcMqPWQPsGXaVIWsDvxyPOKeJDOLRvfqQnEUPVIRaC4AUx1wd341
	1RPIZf4olIK26bSxomEo+m6XoFMCsIF+iGaui22cufu4TZ9vCht/GQCI83mVpTxBSlzdvfVRZQW
	0yDuqaFIoeMaFuRdy8UtRcEPXWT9wYc4AnVMBfW0rzrY0XG5Z5+8R76+HNJ4jQFTUMokTxUby7d
	53tMn9lHd9CfESIkH64XDiGl594POygzCYC0AKas3jgeNAuRdrJn3qUuFIk7ObEsLWBM86HTV5P
	UKiRwHaNusS8gUve3eB/l64wJsLp3IlY+M0HPWskb1nTPPAB3k170sS2MIYgAYeH4gj6Cdroe/7
	4NsUws1xKt/m4XSGadQ==
X-Google-Smtp-Source: AGHT+IGizo+tqJwJhClL90usLp1rZV29bmxxNkH+s7w4dj/hTiz0yagi/PZp66qSoS8r5EdlDf+zZA==
X-Received: by 2002:a05:6820:1513:b0:606:26bd:409f with SMTP id 006d021491bc7-60626bd4161mr1467712eaf.6.1745275242780;
        Mon, 21 Apr 2025 15:40:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:61f2:6de4:740e:804d? ([2600:8803:e7e4:1d00:61f2:6de4:740e:804d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60600c7bf84sm1662222eaf.31.2025.04.21.15.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 15:40:42 -0700 (PDT)
Message-ID: <5df8aff0-2bb4-48e3-b1cf-9c09628ab467@baylibre.com>
Date: Mon, 21 Apr 2025 17:40:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-1-ee0c62a33a0f@baylibre.com>
 <aAPQS9xY4603PJmU@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aAPQS9xY4603PJmU@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/25 11:33 AM, Andy Shevchenko wrote:
> On Fri, Apr 18, 2025 at 05:58:32PM -0500, David Lechner wrote:
>> Add a new macro to help with the common case of declaring a buffer that
>> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
>> to do correctly because of the alignment requirements of the timestamp.
>> This will make it easier for both authors and reviewers.
> 
> ...
> 
>> +/**
>> + * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
>> + * @type: element type of the buffer
>> + * @name: identifier name of the buffer
>> + * @count: number of elements in the buffer
>> + *
>> + * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
>> + * addition to allocating enough space for @count elements of @type, it also
>> + * allocates space for a s64 timestamp at the end of the buffer and ensures
>> + * proper alignment of the timestamp.
>> + */
>> +#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
>> +	type name[ALIGN((count), sizeof(s64) / sizeof(type)) \
>> +		  + sizeof(s64)/ sizeof(type)] __aligned(sizeof(s64))
> 
> Missing space

Sorry, but my eyes can't find any missing space. Can you be more specific?

> and I would rather to see [...] on the same line independently on> the size as it will give better impression on what's going on here.
> 

As long as Jonathan doesn't mind the long line. :-)



