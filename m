Return-Path: <linux-iio+bounces-18795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC177A9FAA6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022C217A05B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F71519CC02;
	Mon, 28 Apr 2025 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oy4Afu17"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F2199924
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872407; cv=none; b=YZUuI8DMe4PhNHQ+PFvw0MLisdCxA25hWbi6KcXNGuTzVVKlJlv5hoaolw2lbbJ8dGMZJX1cvogoT7v6JCiD75cXe6Dphejt7q4drH3T8QiO35pvO0FP/z42MAGXJ1bXMA6AHWJdR71fLQOl57LZYhLxeB5MH5vPZcBNhhQnqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872407; c=relaxed/simple;
	bh=2T3VF8TKumT31EAlYnVg0XZyvOUmlXXWwqSzFvkYk3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCD6e3nZX5cqwgxSwKz9sXOQxNhubpXA+d17inFPoYGUmSZiUxLp9LuC3Pdrt7aq0jIelG/Ra2SfLSX66lmu6Ji7Wg/oWQcxpshYZRhiFEQkX9nooyCEqx/xepj/88d4QSS2wdlpJE4ru305rjFr481UW8CQSDLgx9EfDQveU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oy4Afu17; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47692b9d059so96863031cf.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745872404; x=1746477204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQ2EdDdM+YfgqqW81eKr0qghK9M0AxANGJ6vLIOVl1Y=;
        b=oy4Afu17AawGcmza/sa6nrdJlY2yfIEtuAdeuPIV3WRMXsJeLMUEw4UgIGqmKHHM5c
         rkyX4wH5tBlZP53ot6H5p4YRb5/atKKSqdfYn2JS+HCvkcWow9VcoLSD5v+EIUCJOYzB
         99f5td2C/cxTF+ZHP40sxw7Wd9PfflGU26mjCvMgelvnNPdlO53TijYIC1g3m68E96LU
         nB/cpNQ0uInE2yTNHa9rfrcocHthr3N9EvE5TbwdO4BhV0ZzV/1R/J0PGqDYwFoJWrND
         mBDCYQeBz6SuUMNS+riQpbyCKGWjcgvtvqajaVwZJI+XP2dOGcirxHox+sSS+ntKk1ow
         lpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745872404; x=1746477204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ2EdDdM+YfgqqW81eKr0qghK9M0AxANGJ6vLIOVl1Y=;
        b=IpuMGB4R2DMmpePwdPxp5Pzl4EfZOGtnbwXVNbblRERPnjFEMffx1HUM9+SRLLzq6w
         aeRkl+MiKfrlOQXi6pv1j926RHaJYkzfO6iORWemsEm/k6fV6/uPOLk9q5+kaRknkHX1
         8RXRzgvotk+9q7mZQ6pHQ7nIHpddCu8DeNK93lt255oZdoWBL+bSu1/sEKXHcdKwiYf0
         Ev8/NC+HM8p34SvGmsaiB6vLmlanAmqcl83aWmoRFgnZnff90J50ksjTBEBH2X7nI/rg
         s3OtdxIz85dAnekpyXnly5pU5CjlhXo1NDM79koF8k6E9zkmY+g7trMKNZHW7x2MYoGd
         Pe1Q==
X-Gm-Message-State: AOJu0YySFdck88i89G9wfyo12DMPTdoQNZ7DZQs8e2iRnSWRtER9MEsJ
	XGKi4nVWk1acJ7NNF4dWbk9KTQy0xT/O6nnGrex6rJpKZHGmnRmWwMbQeoLYTjyttVtbtOurkZH
	bIks=
X-Gm-Gg: ASbGncs5ZsobUgGvEiRu8gsab/vcYvw7DzInNopWHtS7UcUG9C7MZcF9i3keG92agpA
	IAbF+TpLZT1SDF8QOBXsh+EyrBVf2l3FbbSCkSpxtJnf1HECjuB0hbxfyDx0I/2+pJB/2Ctmyzc
	nxMjbCRMbZMHIE2seO0CzA3qmN5E2AT9ez8HEeXxIh7az+GpH5dqh9mEfaWYGKnAVccjWIf9CvH
	3KhOHwdMgMLvI+zWW7EH2QqPkyvWdLKI3S+ErpkGZaNigT+xgL0wHgSrdhaEAOfOKS6n4tnBJ+Y
	wZc4vPU6TV8ZTcmovaS1Ae+wPmYwMR9DuYDMD7Uf66GEgL3xzXbZxUQmEL/Obgc+sLFiTc4yRsu
	Y7IKuCubS
X-Google-Smtp-Source: AGHT+IH03W54Ogp2vik7UhE//X7NOGZSRD4J6CwkMZ0uRqLYuTjNtUJodqVeNFIafp53TQeAosBzoQ==
X-Received: by 2002:a05:6214:1d2d:b0:6ed:19d1:212f with SMTP id 6a1803df08f44-6f4d1eee16fmr182717706d6.5.1745872403837;
        Mon, 28 Apr 2025 13:33:23 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aaf904sm64935576d6.101.2025.04.28.13.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 13:33:23 -0700 (PDT)
Message-ID: <48336225-0e43-46b5-bfc0-34ca8e6a4399@baylibre.com>
Date: Mon, 28 Apr 2025 16:33:21 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] iio: adc: ad4695: use u16 for buffer elements
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
 <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-2-6f7f6126f1cb@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-2-6f7f6126f1cb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-04-28 16:23, David Lechner wrote:
> Change the type of the buffer elements to u16 since we currently only
> support 16-bit word size. The code was originally written to also allow
> for 32-bit word size when oversampling is enabled, but so far,
> oversampling is only implemented when using SPI offload and therefore
> doesn't use this buffer.
>
> AD4695_MAX_CHANNEL_SIZE macro is dropped since it no longer adds any
> value.
>
> AD4695_MAX_CHANNELS + 2 is changed to AD4695_MAX_CHANNELS + 1 because
> previously we were overallocating. AD4695_MAX_CHANNELS is the number of
> of voltage channels and + 1 is for the temperature channel.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/iio/adc/ad4695.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index 68c6625db0d75f4cade7cb029e94191118dbcaa0..0c633d43e480d5404074e9fa35f1d330b448f0a2 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -106,8 +106,6 @@
>   
>   /* Max number of voltage input channels. */
>   #define AD4695_MAX_CHANNELS		16
> -/* Max size of 1 raw sample in bytes. */
> -#define AD4695_MAX_CHANNEL_SIZE		2
>   
>   enum ad4695_in_pair {
>   	AD4695_IN_PAIR_REFGND,
> @@ -162,8 +160,8 @@ struct ad4695_state {
>   	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
>   	struct spi_message buf_read_msg;
>   	/* Raw conversion data received. */
> -	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
> -		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
> +	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
> +		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
>   	u16 raw_data;
>   	/* Commands to send for single conversion. */
>   	u16 cnv_cmd;
> @@ -660,9 +658,8 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
>   	iio_for_each_active_channel(indio_dev, bit) {
>   		xfer = &st->buf_read_xfer[num_xfer];
>   		xfer->bits_per_word = 16;
> -		xfer->rx_buf = &st->buf[rx_buf_offset];
> +		xfer->rx_buf = &st->buf[rx_buf_offset++];
>   		xfer->len = 2;
> -		rx_buf_offset += xfer->len;
>   
>   		if (bit == temp_chan_bit) {
>   			temp_en = 1;
>

