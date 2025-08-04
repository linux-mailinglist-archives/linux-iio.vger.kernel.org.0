Return-Path: <linux-iio+bounces-22258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6763B19BE9
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AD717788D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4918622AE5D;
	Mon,  4 Aug 2025 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtKyR+bb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F81A08A6
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291311; cv=none; b=Fd7xXz4BmGaDVFNecgW6DMUxpZnNQeeqUu9+ig0WbEj+ONTjoK4icYm5c8imM3gpauxoOmoCmW7wlDUAOSiQuKqiZ1Kaqzi+NzlS4NBsZ9TwKDGFNM/SDj7s4QPE8aS6kUVPyxWOdMp7rwOOV9LwtJNCXKNtwbkXoHj28eIuf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291311; c=relaxed/simple;
	bh=665nsvjeJnN/NeJ/EP5xoZlGmmoqDMlkQULP+NVr8y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzZiTJYwnbgkryx+2O2eh9B/qHtdJ4o2f5TKs3Ho6fM+rHFry6+QzZhygV0UUsBagtdxMYdFJj0AaJm+p/M8wE1xZzlJR1NidSShdEb/nmPVnSylQgh3xpf6olM1EQTpNLrzDB/m6Mg718wcEa4qUPAXHS59DPMBssRBUSdFaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtKyR+bb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32f1aaf0d60so40448291fa.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2025 00:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754291307; x=1754896107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXpCj9VsTidyIVygxaVxGxXd880qQ9DGdl41lZlUumM=;
        b=KtKyR+bbRD93F5B+67L4JrizIc4Db5h2QnH6HX6owC0bOBYLqBLpyvstkUlLAh7k6g
         1OjeERCpUVH2wRsOj2TcKXEivw6bscowwpnopuHgbFnm/B50E41+R23XajSfQi4XvMdp
         2/II7nJN5E2N2fLXJXwiWqtzONiZFzuDACFAaLUvyFmdHN9Yit3h8q8+T69TEaDUvykM
         IiGdVGeNVocwBKBP29NxM4FtFZ7PFNwkmfuAWOe1LLTxSM8zEJP3ANCvWu8YyrrnwqIc
         vTteO2PmGEEhOxh35WsZ04UkYawcJRSRBX4RQhJiTREUPQ4d7RFcgG1p2vn23JADyYR5
         uflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291307; x=1754896107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXpCj9VsTidyIVygxaVxGxXd880qQ9DGdl41lZlUumM=;
        b=SRRwkrTk82E/vO0qiL5ndJOGyxH2GGBYeSv5FkHU1yH7rAfJBnUCr8SyUczgPrdjMi
         ewFr5xJs8ZVxm2nUoTolBA4/GVUgG4133wy1BWmFHMGHXrzgtHe5CRxVGRLzQ+ENyc/L
         B+LKkGQfdr1jfQwJGuek0Far5V7HJG+v6CwF4nnT7mRmh2CI+jb8N0H9jUvW4S3GtYi5
         3fWheYKujMBAnZ5RruAfHzOftrzVboXhMau5MfX9WWAyRut6FLFRS6bmAsyYfCNWHnpG
         BH71HjHHaHjl6AtMeUdtDnUFcqkGXoljFlo9fuVZbNT8Pf0cHSy5/NGI2tTX0N9Q08Gn
         neDA==
X-Forwarded-Encrypted: i=1; AJvYcCWPpQYs8zWMw+uWMzPNyN8tzUhiM7JeX5qGorzsDgwigeWZsluuMHGMS3zKqrPuIvZveUT/uOSYxoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10mrFgVud/61xHAqMlFrQAMBczuwOBWBbr/+7w7jN2QTRXnlQ
	i0CysnO4/JbqT6kcYGlSkjrSYPKKUYVs7faVi9GnwtKJ8hVyM4iQck8IuqTgD7XE
X-Gm-Gg: ASbGncv/YDnyzQinVP98R3cpa9E1SJL6T6snNmzxSDjZelysBnBAZN1j8M31jSc6ZaQ
	0I4awVJw8lsDbuH4pOsSIlAyi5tLMFa+GHVfgd1WzNT6/rNOLwtH209R1TpiMH6+WuBI04vDo0n
	NFMEU2RCmrG7LPlZ8HahpUSQlpUV6MehzOtKW5GUkJMhzYQEysfi6fClSAKWcPhooEn2Mvu8bop
	icmrJhyYko8E7adZcwH1cmApfCn1IsgkNNsODisJrSHamOO+NKeXLBJSp5AnrmSY1MQVlULR04q
	4ksGStt6+sqeUCwm6JNk8VNzEkreexXVO2sxQ6yo9c46XilF5TF4DaTx5gZV0R3fLAKlNRqtL1b
	yvEuzRABAi8gb3+CrA2TvqFWqxYz3Hzx6FtyoNk2PC8c4VemqyeQjbt0szf1flnXTVAwlh71/HB
	BQiE4=
X-Google-Smtp-Source: AGHT+IFHUZvPfPdgl6dnW5QrYcN62+5dPi6Leuk0nHqtj6PtTLKtgOh92F2PzdThKq1gy66D3clq1w==
X-Received: by 2002:a05:651c:1503:b0:32f:1f1b:1e68 with SMTP id 38308e7fff4ca-3325672b134mr18018931fa.18.1754291307239;
        Mon, 04 Aug 2025 00:08:27 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33274f93c75sm600681fa.77.2025.08.04.00.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:08:25 -0700 (PDT)
Message-ID: <c47c3f9e-6b66-4118-b7d6-96ee4d255288@gmail.com>
Date: Mon, 4 Aug 2025 10:08:23 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] iio: light: max44000: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost
 <astrid.rost@axis.com>, =?UTF-8?Q?M=C3=A5rten_Lindahl?=
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250802164436.515988-1-jic23@kernel.org>
 <20250802164436.515988-11-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-11-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Also move the structure used as the source to the stack as it is only 16
> bytes and not the target of an DMA or similar.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/light/max44000.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index e8b767680133..039d45af3a7f 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -75,11 +75,6 @@
>   struct max44000_data {
>   	struct mutex lock;
>   	struct regmap *regmap;
> -	/* Ensure naturally aligned timestamp */
> -	struct {
> -		u16 channels[2];
> -		aligned_s64 ts;
> -	} scan;
>   };
>   
>   /* Default scale is set to the minimum of 0.03125 or 1 / (1 << 5) lux */
> @@ -496,24 +491,29 @@ static irqreturn_t max44000_trigger_handler(int irq, void *p)
>   	int index = 0;
>   	unsigned int regval;
>   	int ret;
> +	struct {
> +		u16 channels[2];
> +		aligned_s64 ts;
> +	} scan = { };
> +
>   
>   	mutex_lock(&data->lock);
>   	if (test_bit(MAX44000_SCAN_INDEX_ALS, indio_dev->active_scan_mask)) {
>   		ret = max44000_read_alsval(data);
>   		if (ret < 0)
>   			goto out_unlock;
> -		data->scan.channels[index++] = ret;
> +		scan.channels[index++] = ret;
>   	}
>   	if (test_bit(MAX44000_SCAN_INDEX_PRX, indio_dev->active_scan_mask)) {
>   		ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
>   		if (ret < 0)
>   			goto out_unlock;
> -		data->scan.channels[index] = regval;
> +		scan.channels[index] = regval;
>   	}
>   	mutex_unlock(&data->lock);
>   
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				    iio_get_time_ns(indio_dev));
>   	iio_trigger_notify_done(indio_dev->trig);
>   	return IRQ_HANDLED;
>   
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

