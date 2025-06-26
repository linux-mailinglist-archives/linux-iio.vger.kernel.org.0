Return-Path: <linux-iio+bounces-20967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D644AE950D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 07:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974D44A4AB3
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 05:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A758202990;
	Thu, 26 Jun 2025 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmQdOPgv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BB1CAA79;
	Thu, 26 Jun 2025 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914446; cv=none; b=Zsunos+5oD8bjmnAEA9UZdS66DB1guk7I4YrnTECtNoSSobcnuTsj9TP660RWC7e5erAXn18hDtO1csGm5ys5hZgjBza0nokkLBovaUIiaBu/y5fw8hQrHKp/urhs5sXDIii3+h2JPkldIroeqfqxWTPktEWKGmZhYFn0gESBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914446; c=relaxed/simple;
	bh=0CV28ZMxCqWrFNwMSnXsVg+W9CcpMnVsE4Pz/y/owk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEukC4JHaIwNoofdB7wcQpCfBwdbBRHBzD1QirF78WOt+h+zJWhru/CteGXZJ4J5DzNS58o+kJEM71dhYwgY9Ev+kFnjmLVqRB0qJH4lB//OiJkGyb2zBFF1Nd5asKxmax/AKwvaPENli64V6lH96DCS0GHiF8Vl2x/dM0ulSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmQdOPgv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b553e33e6so4761331fa.2;
        Wed, 25 Jun 2025 22:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750914443; x=1751519243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucuge3haHIUEqqktbb0yFSyoz0sNgFSmLZz0cdZIMeY=;
        b=TmQdOPgvOJWhiYjeKwXuJ3g372zXnC7S+HTBMCHCdvXJE2X3en5QyTVUONqucSQ5ew
         h++HuneYNCjQUmOHmrHkG0ZGvuqwIZPKvBrnwBXhXDv0iU2b4/6bKXMQ1L+71n9HBqgS
         0DfO8WLdmSm/WqjUdYFUnGRN+YFJPGgvN1tPkNdlpkWGS75Udyq6ZjPBsfGs0z1uak8G
         SFXhhBNtgJ+iHAu6FL1Gb8kfW8EPYb6QPIeKEsVutsB6qrS+9TVgB/qRU8/fdbh/UI11
         tGP6WHKCavyTuUDJNr/bXC8apgboZP6ui6GjuYKootuuQrhOwiz9IQWQslTkxawei85/
         qsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750914443; x=1751519243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucuge3haHIUEqqktbb0yFSyoz0sNgFSmLZz0cdZIMeY=;
        b=oovOgywCsiTwg7m0C41y086owh3TY9sAUk9fk9JSBhpec/UMTDSotCVhJ6J/Lv6Bt7
         6E+r2y1EXrrPS40qTvK4n2Cbt9VLHFf0mc3ZRUGv4ITqpVWFnHLugmvfS7l96jZTvbC1
         iinzdMyNUxr/b+lb5fBT7N6vHP+GUdFu13w4Nu3pm4SWrC+dPwJNQXcsrFMJ0L9rntsf
         RSKglqdWCspMMIC1KVDTPv9qityXS7MC07mZRp9WWC98znQdYuSTdhjVQLjl9KBJ1ZiF
         q+++WL9j/iMBZ1Fms0McNWwlj9s2xIBKemP+AxEYTojNJaH36MB8SnWubCGkfNbyGGc4
         5+hg==
X-Forwarded-Encrypted: i=1; AJvYcCVi6qAEMsUhuah63yRNd21Wwy+WQLwdwlykmS4ThUCiFW3iOzMk8xT2GSZecnLJL6YZnHHnRIcHiZQefBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Fabr5nKnNPEqIgVS223Ws9DIShw4huJJv08oKfLKORWGbQi2
	An/CcKvrl3SUrxCeU7Tv9vEtjPA2iPIH+cn3h03QLIDvxHatsqpAP6Uzqrtz8Lq9
X-Gm-Gg: ASbGncv5JRxs26gwxclEc2OKwud3pdzoM1QwcbrO1yLmXL6M4rnKNauQgB6JYtZLjLv
	ulw6B0zrjb71Hla8Pp+z7cUrH2AD2v49NGlHRtjtK83K7g2CIG9INPbTFpoE37JEf5cheZof/fd
	1tMKqv1e0EFUEUQfpRAvTJNAYG6YJpCEhxErTEVQHaFQskZl06CPITkoDF7cyqatbBzpUXaakX4
	h5SUaeQZ+jkp/mCkvk5XKQGfYM8+M8bfcEB50VlKFVXcAYCWQhxFLfy4F2tl11WYVy8j+g6Ynu1
	o9oCAgxXaoJfH8065ByTykC7Qa9+ZXk4qtibnxOA2g2EF850GBZdwhgV2tgQxb08xefVJfm5wbn
	Vmr8nxu3EbN6wOTPjZvjDvH+uuxGHRBPHt3qYijDZ8nU=
X-Google-Smtp-Source: AGHT+IFi6kv6BxFmh3WNqUo+5CW2mT0uKzXUz80kdXBfAnLTfpXObCinsf9ESupWnoDuQxZ6ayJAxg==
X-Received: by 2002:a2e:a01b:0:b0:32b:9652:2c13 with SMTP id 38308e7fff4ca-32cc6547c26mr14480021fa.26.1750914442414;
        Wed, 25 Jun 2025 22:07:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2eff571sm1041011fa.92.2025.06.25.22.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 22:07:20 -0700 (PDT)
Message-ID: <c97e840e-fe8e-40e9-baef-0a18103848fd@gmail.com>
Date: Thu, 26 Jun 2025 08:07:19 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: ti-adc128s052: replace literal by unit
 expression
To: Lothar Rubusch <l.rubusch@gmail.com>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625170218.545654-1-l.rubusch@gmail.com>
 <20250625170218.545654-3-l.rubusch@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250625170218.545654-3-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2025 20:02, Lothar Rubusch wrote:
> Replace the literal number 1000 by MILLI from linux/units.h
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>   drivers/iio/adc/ti-adc128s052.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index cf271c39e663..67bc7fbd52bc 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -18,6 +18,7 @@
>   #include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/spi/spi.h>
> +#include <linux/units.h>
>   
>   struct adc128_configuration {
>   	const struct iio_chan_spec	*channels;
> @@ -189,7 +190,7 @@ static int adc128_probe(struct spi_device *spi)
>   				     "failed to read '%s' voltage",
>   				     config->refname);
>   
> -	adc->vref_mv = ret / 1000;
> +	adc->vref_mv = ret / MILLI;

This makes no sense to me. What does it mean we divide the micro volts 
by 'milli'? It is clear when we divide micro volts by 1000 that we get 
milli volts. Also, the mv suffix in variable makes units clear already, 
division by MILLI just obfuscates things. I'd keep it as 1000.

I would just drop this unless Jonathan disagrees.

Yours,
	-- Matti

