Return-Path: <linux-iio+bounces-17561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7EA796DA
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D073B2119
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 20:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D111F2B8E;
	Wed,  2 Apr 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kDJBJbiY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427851F09B5
	for <linux-iio@vger.kernel.org>; Wed,  2 Apr 2025 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626948; cv=none; b=UFayYF5B+/sAi9thBDo9ZJTbAwAyJSwEJymfBPCTMnMWXDrUsxu6pWRau00Nk4gTLz4Ejo08KTu9EohZ1J2gWH0c00miFAbA2/A2x8pdHgrVtUmz3eA/fNQClTy5g3xI6kO2aa8A4l7Dx1jr3t9G/kd1+vIH4zksQ1LX5qxhj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626948; c=relaxed/simple;
	bh=H0i2KMBMFcDec5UVW9Y/Y/PbNB6zqGI1enytd6buQDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9eupsVu9szAhFhl7MoX6DtMa3l6RObDlmQLcL+jAbJTt2ZNTpnwVUOe8WPO+PS0gLT5p+gLBB6IsM6BJBez36PdJV+ObwtKV0zA68LQlsX6RRKRPQ50ql0c0uhJXAD0gvy0u+FWuDZtq33HEiqsYz0W5og/2yOo2/6u+e124oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kDJBJbiY; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72bd78e695dso86417a34.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Apr 2025 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743626945; x=1744231745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PneA/KGio5qHN0s6LVOkmY0X5eDLJLZ6gsMfj989kss=;
        b=kDJBJbiYfteFc81juiYoMVAJDG5SJd6MpyoqKKF+RRVHg9erbwvDIg5R+bQwjKOL3U
         gkhMj+KOAPp1ZJBNJhjbl3aSdvZB4xIIShUEkY8qoyevxsxhxgIQIzeD1Y3G3eWikIJq
         MH8ibxnDHq+ihiODi+4cZV2KGTN8p0eBsdUS+orw2+bP713fPBqfqGKht/1b7aYg9KER
         EdgMYGuLanXJTDMi53p8ENCExOQ18fGOTH7+MBuiuKihQH9N0np3gpU1rXfvxoU8xpWg
         X9/bEOBjCadeT2M7K6NezmKamu+d9zdd6ryN5SxUZDA8KbRf8TcyKdWXwzxaFnNvlkvB
         NPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743626945; x=1744231745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PneA/KGio5qHN0s6LVOkmY0X5eDLJLZ6gsMfj989kss=;
        b=PtyNKdMLLtW38Xet1ibxHefC4V/IsxEgekUbIcd6De81eRuyEXo2pHblZ1y7Z7U+hX
         D03xe/SBBGrw5/rJxDraxnZyesF1RE+NbqMf19GyeEjHzOnSF2EwJpF2w1eKibXbQYtg
         lQJ2v7xtUjG4fIJUVc8HqMDSLP2cGY4mN6BWPOOtKZOddQOSXvTUJuPqjsX8E0YFfZSz
         i7Gn2ZEXgOZmU70pm+4lUEWdrStDCjIuWxOB/Yv7uhMXoo/HPjqZtaJL8btBiJadHloX
         bls6feLsnCZ5IbrVkFor+idkcE14SedDccgvAWhpBY922QtxsBRuyOFnoImdRWNeSqNE
         Q//Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjfHi7sqq8QMV/SvL8gxpKN8pNIVYEdm4XjO8gW9Vkd/SGdwOz7qmp7sBJSPQCFynLyExgD4zk+IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Q4ZkL6gjNGP5GCGp0VQ9UtdjbDtg4EeMi6XhoMJPsNDbpuLj
	bnCSDL5tpPvLtn1oszDSzUbgQgiXH3ttv+QevMFxHD6tqMHnx93tA3nSbyy4ZGA=
X-Gm-Gg: ASbGnctfvLelnSqVrFhIg9JdJvS8BMY2rXxXUK1ad4MsPcgj2JPhAwjDcTTTFa2q6s9
	LnDsiZfNRz0X6oSNJhQJrmx9uoMrGKKS8Q/eyPJIwHL6P1pclVbWmLJ6MO+YIKqPyO38M5hmipd
	v/lOexxVUwB8teMu5gr/GDafvCY2R8BpACSa1qNO41booOgp3Wv9CVcfwP3D5WnBmZsCM5nXdva
	8d+VV7EwPogh9ifesY0LNVJKwDiI8/4MckFjfGjKYYLpvNb6arSSyWf5WbbuKtDhHepCxy2x2wu
	9i8MhxMRfwrI7UD8Xl3fB12US9B6diN5Q87SVVf5JhaoQnkbcWYXmTtAw+u5P+Q9W2UJYjh0mDC
	ZppZVVA==
X-Google-Smtp-Source: AGHT+IFWoCgfUq1vdjqIVUCLEyrdA1VjfKcnGwC3l4aghGm2e9OquWNUwBhki4cUzlNFqajANw0wEg==
X-Received: by 2002:a05:6830:6887:b0:72b:a465:d93c with SMTP id 46e09a7af769-72e258ac106mr2530485a34.20.1743626945226;
        Wed, 02 Apr 2025 13:49:05 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c580d30e0sm2390283a34.37.2025.04.02.13.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 13:49:03 -0700 (PDT)
Message-ID: <c42b1dc3-34d9-4419-ae2e-5bacffa070b6@baylibre.com>
Date: Wed, 2 Apr 2025 15:49:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 7/7] iio: ti-adc128s052: Drop variable vref
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1743573284.git.mazziesaccount@gmail.com>
 <dda9e0710a9293a9f52e64c092f79afd4b719536.1743573284.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <dda9e0710a9293a9f52e64c092f79afd4b719536.1743573284.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 1:10 AM, Matti Vaittinen wrote:
> According to Jonathan, variable reference voltages are very rare. It is
> unlikely it is needed, and supporting it makes the code a bit more
> complex.

There is also around 60 other drivers where we could do something like this
in case anyone is bored. :-p

> 
> Simplify the driver and drop the variable vref support.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision History:
>  v2:
>   - New patch
> ---
>  drivers/iio/adc/ti-adc128s052.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 0f93c6266527..0bfe4e558c69 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -29,13 +29,12 @@ struct adc128_configuration {
>  struct adc128 {
>  	struct spi_device *spi;
>  
> -	struct regulator *reg;
>  	/*
>  	 * Serialize the SPI 'write-channel + read data' accesses and protect
>  	 * the shared buffer.
>  	 */
>  	struct mutex lock;
> -
> +	int vref;

Units in the name are helpful: vref_uv.

Could also consider doing division in probe and storing vref_mv instead
since we never use the microvolts part.

>  	union {
>  		__be16 rx_buffer;
>  		u8 tx_buffer[2];


