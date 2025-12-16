Return-Path: <linux-iio+bounces-27110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 976E8CC0591
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 01:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E043011A6D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 00:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0492309B9;
	Tue, 16 Dec 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bUXJy7U/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C3227B95
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844811; cv=none; b=tlaulyC2hExNV6bcWstanH8XO4JjLJStd4f0laEcgXaMb17E+eqsBVT8TPaEhg3L0b/4t/Tckvu4OpJBopfqbx7aCRxkhgeEhQwi7M8j2EE8ZUpRG0fbHaU8ss3oYON+6QC4Y5bZelLgenG71Nik4rJT7sVKP213AN0pAv30I2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844811; c=relaxed/simple;
	bh=Rf2vh/bQ95xAd4D7d7UP3aqU1zMCM9f46oH/0MNUnyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rjf+5w97uEd2EK08OTRBdGwK8iAiANYMNwA+DNa8W63c5h2qqDpJ3hsg/CSVIAXd/ETcZeCyqk7SPkYJLRduR4MhoocNszRiLDFtfWf9Xpd/lclgxXS7Szj3sSwtwSuj0d3OwT3ggqpa3SFR8Ewnzr+S1yTb6vDlePa49ROO18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bUXJy7U/; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so2417912fac.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 16:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765844807; x=1766449607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1WdkoezGW051cvtWm8NknZdX+IzOtpg2baHzjgkxPc=;
        b=bUXJy7U/kaJYn4x7RmZgcX/PCWOV+JwsHik7gHOMtqbznJMdY7o1iIciC2gNNcicJ3
         kOMPlW6Gqp9fEg9qCJX7iA3pQejCntpGnQLN5m5mouukToKH03OPgAHXDzGVLSeJJMcH
         QKDzzYSDQFQnCqsTd3Z4xaTRG7BZq/qYLLrRFHpDQMM+pvscXC5wyaNOyA1AalD83m6t
         oq60HV5Ps4bbmfw7BMSjTdN0edizFaEWNYVGsUUcSYf+xgTozFtSPqC9YvwyTbHpgB+W
         wy1VGsdUzrtdL3g7AiFf3C1fRtvYD03pI1sluLN4d/T7o4cOgnk4JxzlS6ilCssawxPw
         elJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844807; x=1766449607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1WdkoezGW051cvtWm8NknZdX+IzOtpg2baHzjgkxPc=;
        b=AbpUWK1WC0jPMHPhUFB927v3YLsklOYkslHkOTLDpgsI7b2RFrO9aM+5sRfZYWiyql
         F4JxGexyNXmuMbr75leDdsyZgjY82xJVAJr38/J2kTCYdJZnh2WtYC0ornfqFQSF8NLJ
         UEMlRMeNTUwnBFpXJ4tNEwybxm5Uo6PlBrmIa3TW3lcjrguSmanv8qI29cf18YlBQOMX
         ZRtVA5AE9B1DMGvHG0Opy/X+ZmYUvmVGqT5QZ6AKyYlYIk4tlLZztZvF/X55bxkpdTiJ
         8XaWYmYt3ZPgZmb3kHLnIaSLO26t4RksFbMakrl/s+tqK9MtOyY7Dj13vGMIbCp3oh6W
         gBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZxgdQ/3pP/w4iVjRpX7DSYHEAoLoUIsFDoYiJ4leIjx+sTwaU7KoPl/WIogrgyOZCx7DY++I3zpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSwu1IZ5dlt+jHPLrzKeClhDU3ML+tNGMYGZA0BsP2XpZLDb8
	kQFf0/OCCdY5GxHtV8d1uAYiA4CcAqXPsh1UXEf7SjYVRh6T0scko6cvyoJTBjLO5Hk=
X-Gm-Gg: AY/fxX4WQzClhKoAGKblA8iEFGCLw2WoferrRVHunEP7OoC5VNWRHepqIYXjQEEjVPq
	FGTXs3tu7QBW2LNwFTmvXF50a+jfo/cw3MAu5c9/VR+4bHbvCQi2a/nGNyU+PbOi0fvMi4QrHND
	KvrtlGD82EjTDERII2DcgVxx2A5N76P7osm2A51YtV6DruVh7OBu2ERhzY81Tmuad6cQ1JPlG9y
	zjzCXEus5xU13pe7UU1uZ4LWcDyQfBn32fHhBSPw5EHZk8eZLuZCEdgPA3A2RFB+XeMlASAFiug
	oRo/vnxDec05Q+esM6EoaceNHCD3SKn1xx1ndEZm83D0gnIomhdXsyFlwHMEd5ha/7OJAjyhhwG
	J3Mbo2ZmVhERrrNv8OWvFr63kxf7KExP7hSDgWbnOZbd2QTHOrAw0TgOlc/Fq6YdkFr34ryUUXE
	KvL5IwZzyS/su2RsTKA5Z2CpUOE6tdGDiYK9yDw8a9I/DcrFjDQ6eVkiMXZ9ZG
X-Google-Smtp-Source: AGHT+IEUYjNzC2/6Rbw2SBCUU9VyGKxu+9RT3GlnEhvSg6PohNVSqgaFiVuE7oEWFe4FbXUx8jlVPQ==
X-Received: by 2002:a05:6870:168e:b0:3f5:5af:c9d3 with SMTP id 586e51a60fabf-3f5f8e40575mr6106302fac.52.1765844807482;
        Mon, 15 Dec 2025 16:26:47 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:b28e:2ce1:6967:e2b5? ([2600:8803:e7e4:500:b28e:2ce1:6967:e2b5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614be6be3sm5529641fac.7.2025.12.15.16.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 16:26:47 -0800 (PST)
Message-ID: <e1284b0c-3ad5-4c54-aa58-30f416aa98f8@baylibre.com>
Date: Mon, 15 Dec 2025 18:26:46 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7606_spi: use bitmap_full() in
 ad7606_spi_update_scan_mode()
To: Yury Norov <yury.norov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216001808.333053-1-yury.norov@gmail.com>
 <aUCmZk0S_tq3SOOY@yury>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aUCmZk0S_tq3SOOY@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 6:23 PM, Yury Norov wrote:
> On Mon, Dec 15, 2025 at 07:18:06PM -0500, Yury Norov (NVIDIA) wrote:
>> bitmap_empty() is more verbose and efficient, as it stops traversing
>> scan_mask as soon as the 1st set bit found.
>  
> Ah, please read this as:
> 
> bitmap_full() is more verbose and efficient, as it stops traversing
> scan_mask as soon as the 1st unset bit found.
> 

I think you mean "bitmap_full() is less verbose"?

This isn't a hot path, so efficiency isn't important.

This makes the code easier to understand anyway, so a worthy change.


> Sorry for miswording the commit message.
> 
>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>> ---
>>  drivers/iio/adc/ad7606_spi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
>> index f28e4ca37707..7e17ccbcedd0 100644
>> --- a/drivers/iio/adc/ad7606_spi.c
>> +++ b/drivers/iio/adc/ad7606_spi.c
>> @@ -345,7 +345,7 @@ static int ad7606_spi_update_scan_mode(struct iio_dev *indio_dev,
>>  		 * has no way of demuxing the data to filter out unwanted
>>  		 * channels.
>>  		 */
>> -		if (bitmap_weight(scan_mask, num_adc_ch) != num_adc_ch)
>> +		if (!bitmap_full(scan_mask, num_adc_ch))
>>  			return -EINVAL;
>>  	}
>>  
>> -- 
>> 2.43.0

With the commit message fixed:

Reviewed-by: David Lechner <dlechner@baylibre.com>


