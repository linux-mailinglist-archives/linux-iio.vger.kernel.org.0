Return-Path: <linux-iio+bounces-24271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0158B86A2C
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C1B1C87407
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3142D8776;
	Thu, 18 Sep 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uO6yzOKv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23B2D480E
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222748; cv=none; b=Z+tunLuWmdAdUDDdFw05/GmSw105ftubT9gypiKaus6oxgn7RNfJn7uyjjtAq2EvWzZoSd8gCuyROrrF3jYwy9DA9IZ8SEsYAchWtk3kOQHGNGXXw9j0kYYQp3TbbzKCWXXUfCSBrWFlLrCGVu5sIS34Db9beGZ/X9nA6fjyZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222748; c=relaxed/simple;
	bh=E3LZSLXMdPL95SK+eNzUYQ+vwbzIS9yTVFJp5UGnXkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBwQTnUkVnc1vZwEM3H3YLb9mF9CArMD1CFpO5maDzzAmBMfJsxTdETl6zxGhH/reqFAPGpEv9SPpYIb68xYR4cWT8C/2iSUJYK1dgx3mDPz9xx4/KHmeXelsJMp2iKOyXy8dqmD+jjEZaMP9wAMoW1X7Lq2ROmIJ2sSvoK5rko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uO6yzOKv; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-62355a687e6so959118eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758222744; x=1758827544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=um+v4dONIJk0v05u5ixJ2EK0PctWSqMZX1xGPJUVQyk=;
        b=uO6yzOKvHUrj5vWlRb7yExzuBt4XiR9P5NmhnwiJ5bDrhv3Z7Hecd53lI8VrcTd3II
         zrJRfzsTwktoU7s0CI1ssCCylnu+AgbFR2rgrGckzPm1s7kWUdkQ4l/Wnxbh1XBK1Sqg
         txFm5A42/uv01tv4x0ttQMt02T5j46PApO1ppJqN46vyFrfx2959VxxCvWgPl8Xk9Hn5
         jxswfcqlP9f8LrIm+FI9jCco3LHKSOKqLDcx5cxGXcv1MjW4agW+wZY3WA+5YJxJm5AP
         BkHi1dlGWCpBTpVo0tH1DUP6tfPQARud50O/JiatwTiFwN9t/wwdToBLf8HoVDAYvLmO
         Wd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758222744; x=1758827544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=um+v4dONIJk0v05u5ixJ2EK0PctWSqMZX1xGPJUVQyk=;
        b=iuqqHYjd+JCmtHkceWtJqC+ughnZnMBE8l2ojTgDCkqUYPCB/NKjb4usGoEzDZJy7R
         iDs6NywRg4rxlwtkyiQpyGboX/GeBcQs8473i8ZhcVpA8qJZxgj//cByOSTkVuiDl0DO
         dB9MaHrVKyUyPTBF7eshtC32vq5dY7d09a1A6G0UxjMQuBh5B6L4n8Cie3lN6A/uDZvA
         f8JmfZ/sVTBmazWBF9xFC8caAWCC66IJHdZ3MXri/Fv+urSkd+f04Iqf+3nH2BqYUyax
         xl2SSLg/6SScTca9B+tE4vKX9AqCWvE+FUfkBt8QmykBQt0WWxsszylBxQ21T/BrEnAF
         wfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkDjwWunK95GxqG8ahKz9KUEOLcSw47TmCBTsynqnSq7x19lga2JXC/meyBotDqf3iRz5QDs8J2VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBW5fOuH53f1tXQBFT9XX3japk7mLLZ5SfzqgdKZtbvnO6JpC6
	7QHQ4WGBIORcjH8mtJMnRYAdEw/nr0yW2GPsECwLc/DrMfNP8JjUwJO5KwVqzfrlJV9pszEnKms
	fEF50FUA=
X-Gm-Gg: ASbGncsO7JTHf73Pp9cPb1X3Eeyqx/YSLpY1o6rbc5ZgPQYmyEmhg7OBtYdmRbwvzGp
	LLeSsKWS3oiifea389Y+owzEf0PhCmmyUf0cBAWZA3rAyOZnrqSODiah/9qSnk41vOf4L+pFSXz
	lwFquCVlLairzD2GkTbYdmJjyvpICfnOHhb8TUhStLNUx0k3v+OOChiTsf3eHFWuVx9ICFovmVq
	xSJnMB7aqV5SsmziWXpYwzGqIo/24miLOQO9GkcKIiFzC8Hwz0pOnrVwvt+tvDx107X55B5Kjbw
	VbyXS8kcXcyhoquhfi9ligzO0ykMEF5/p5TdRFVViAHtUMbjBHXyAo9yOrV4Al138G8UehYoKje
	02xrsITjwouWQwi60XsK3rMc4iYeNrkKRE2cInitmyf9W1DpgZjNo/IJ2Nyc8TKAQXvuwdwgt2s
	8uC4gc3I/vUVKB+VFD8g==
X-Google-Smtp-Source: AGHT+IEjWUgvc4lTOFTwV5s3qOByTrBRgcgcc0xXFcx8Jx0Wu7qnzn0uZbvp8NWcWQQ5wdeD4/BMIA==
X-Received: by 2002:a05:6820:2218:b0:61f:f591:8a2c with SMTP id 006d021491bc7-627256b01b1mr242474eaf.0.1758222744202;
        Thu, 18 Sep 2025 12:12:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625db105811sm995869eaf.15.2025.09.18.12.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:12:23 -0700 (PDT)
Message-ID: <5607a969-2e42-4530-94b2-caca21de11aa@baylibre.com>
Date: Thu, 18 Sep 2025 14:12:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: offload: types: add offset parameter
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758206554.git.marcelo.schmitt@analog.com>
 <cc049e25c9633f41eeaacc94bed5db2a1aa299d8.1758206554.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cc049e25c9633f41eeaacc94bed5db2a1aa299d8.1758206554.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:34 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  include/linux/spi/offload/types.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
> index 6f7892347871..0170fd1f42e5 100644
> --- a/include/linux/spi/offload/types.h
> +++ b/include/linux/spi/offload/types.h
> @@ -59,6 +59,7 @@ enum spi_offload_trigger_type {
>  


I think this would be a good time to add some documentation comments:

/**
 * spi_offload_trigger_periodic - configuration parameters for periodic triggers
 * @frequency_hz: The rate that the trigger should fire in Hz.
 * @offset_ns: A delay in nanoseconds between when this trigger fires
 *	compared to another trigger. This requires specialized hardware
 *	that supports such synchronization with a delay between two or
 *	more triggers. Set to 0 when not needed.
 */

>  struct spi_offload_trigger_periodic {
>  	u64 frequency_hz;
> +	u64 offset_ns;
>  };
>  
>  struct spi_offload_trigger_config {


