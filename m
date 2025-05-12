Return-Path: <linux-iio+bounces-19472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE291AB3BC3
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2993B538C
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317719ABD4;
	Mon, 12 May 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NPkMYGdq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2A1CCEC8
	for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062946; cv=none; b=Cebz8IzOmZF8PcLjRm4/y6Gqg7FYBn0INzl+jeWg8erbcNYX1oZYEEoB1DbAhkCrKeDmt1FuXrPrUssdrWu1Ey0U2FZDubf8zSe6Y+OWIqJoKqBt7GDF4ItOI12hruGTUhZHvJELiQYZxNpL54KZrKmOFQ4fZFvsdpMpTYHqn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062946; c=relaxed/simple;
	bh=zF4PQS8RQFM30N3ao4kEuN2RsoQHNBfVK/8QGFaitO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjaHdJKkQvAYUnAW4l61ga9sL4lRDy8l8lnjyScPcqu/JLv6R5Xn2yZGW9znc4XvpaC5oycc6p+OgFXzEmnfkE8xADOxCI3NKL28wpmhsXyk1HKnkPh05tSma1H4fFPKFtKp8FHK0DR6OZdy/FQeDmXZ+bRRPU5vr5/RoFoYZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NPkMYGdq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so5229651a91.3
        for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747062943; x=1747667743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=NPkMYGdqygEadNa9LBxCCsLaDWqp4GRfS8Ph/xx/qGxOGPd6hDtfGyacyAIcTs026J
         XJSoBBNAt5MhW+Ef40nJeLNLyYIq0IPafG8V/XqKhS7RAQUdxaQ7ZDj29uzdzT8esr4Y
         QfdsgqR63ugM64JgjPrM/r0nO3DgiRIhFkE6OcwINl9E10F2f+9iN9bN9dz2axCXfs7t
         Rgd9WAV1o/WeEORfTBRaCAMoC1DOhD+cZUcSGhwXhg5izye20HxjlROwGjLgGYOkAlCy
         C5S2GJWp/HDi0W5vvyT+FAAjmnOPikPwo+VfsbGnWY73IoV43GXQVQqNaNDRWSumS2Ff
         Bxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747062943; x=1747667743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=jmiadNSvgAz9itzjjH1uNl4cLRxqsgOc+HUsiq46tTA2GfAmv8yTgmEmi8q7fS31so
         DF6d0S3R2OzgBc1lGrb3TcqsR699fZ/udg/hCVej6tbS4iJgDD7ulSfcS0QDjT6ZNo/n
         xSuk1vXVdHprzKRhMMuVOARFP7BFqB48bXJijelbKqkFg1HN6Fb2A2UQGbP9ySxVLP7t
         Z7+7/ITaGoRtKgHZ4E6WsPEVTjPO4kC4TYzP6Ek+nxuwIkwweczQjMaLL5fn1iDyZWLD
         Ub9wBk6kSJ+ES4nhW3Iodf/6TESikZl2tWEfZbwgTFQABQjpyG6nKirhsMoDi/tRR3cV
         34Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWFNxg/K2TS8D/iHHk0u+WID/3ix3U+ycSbxVJDzSLfKmFqSsqHKhmGZVeDj0MLk0U9aoP4bvFo1So=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mwIK3xASuZew6uFaW5QqcoXPjL93DBugeWmpiBfOMLgUAQlR
	6Q0zW1hl9k3Lx9JJM/mRIAiQvR5ZRrO4MvEq886k7IhOLLtpsI6MV6ZhnwJ+v3R36eRbRRDTUJq
	+
X-Gm-Gg: ASbGnct/VVXfWIvlDias/cz1LNOG2UMXPtwF9he6JsgYaswvOy5qmXGjnBO7N3cxt6m
	kWRmcmtQpBHmLcU+mbL8j1jzhTwBRGw2BVuEQhnVVeUxGTqEn1yRw49UDuU7u79m8mFcCOlaxnc
	Hp6BRM9GfthOBiaI1achisJ4p65tNykwBaBUxDV0MsD5qUbzFFqoE7tBv4Vda9Nt4GX+0xxN4l5
	AQ3tFuswgZEY2gqQfJ22p662mR4xC9q+iVoDKJx6igPyN71hYguGvjLf7yHKfW2zNBIF+V04WEu
	xbOl4qNF0TTPa6LYJHQoGrjKnmJAFdC9HTjwzhL9dQLSDL+PphbS/rLi4ZofxYp/djiiZH+lmUM
	wMgowJZkmnmUJ+vZwD5LTeliWWJ/m
X-Google-Smtp-Source: AGHT+IHZGDRNs+8vOMkC0p04fQzG/ssmfSh7XZKqv3ixjm0TN3TuT3LuzzKvBaCQb7HZ2b2RSV9r0w==
X-Received: by 2002:a05:6808:1582:b0:400:fa6b:dc93 with SMTP id 5614622812f47-4037fec216emr8370575b6e.39.1747062932740;
        Mon, 12 May 2025 08:15:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-403802d369fsm1565218b6e.17.2025.05.12.08.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:15:31 -0700 (PDT)
Message-ID: <44929bd2-4abf-4c7b-b3c0-382bd030800f@baylibre.com>
Date: Mon, 12 May 2025 10:15:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] include: linux: move adi-axi-common.h out of fpga
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
 <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The adi-axi-common.h header has some common defines used in various ADI
> IPs. However they are not specific for any fpga manager so it's
> questionable for the header to live under include/linux/fpga. Hence
> let's just move one directory up and update all users.
> 
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c              | 2 ++
>  drivers/dma/dma-axi-dmac.c                | 2 +-
>  drivers/hwmon/axi-fan-control.c           | 2 +-
>  drivers/iio/adc/adi-axi-adc.c             | 3 +--
>  drivers/iio/dac/adi-axi-dac.c             | 2 +-
>  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
>  drivers/spi/spi-axi-spi-engine.c          | 2 +-
>  include/linux/{fpga => }/adi-axi-common.h | 0
>  8 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a0c91a648005b3e6 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -16,6 +16,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/err.h>
>  
> +#include <linux/adi-axi-common.h>
> +

This one is adding, not changing. Was it supposed to be in a later patch?

>  #define AXI_CLKGEN_V2_REG_RESET		0x40
>  #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
>  #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70

