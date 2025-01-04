Return-Path: <linux-iio+bounces-13892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF8FA0150B
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0EC3A3B08
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A30145346;
	Sat,  4 Jan 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlGHfP9x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388C28F5;
	Sat,  4 Jan 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735997894; cv=none; b=JYQONyYMuu6s6DGJstEygG6EtdgTVqJVEPQfpEteq3wbDaBkP9vIVdAT5jm29eIv7q3pHpLDdCjuIo+7jlfrU5u4mt3tCZF3XdVIV9Baoy2tIJZhEOkGooX/dAe3fnT8QA+RQ5A1sqYyO00h1J54nerJK/1pnZ5qelPAWOMqzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735997894; c=relaxed/simple;
	bh=DZ641ToUHGGIED25myr3uOrPZ32fWg2JpL6WpgLolKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2a8bUOrBaMYt6QAlcleJehySHPt4NQDxvbA8jecDSFTosn0I/1XOMJBpalTOQiGhQdZNa9u1Ccaq4Ru9zovwceud8pQ8ICYE+qRi+2FzcG6QWRC6MQ16fQSj+3c1QtmhtScM0dZ2qn0BLawumbHfo0nvCcbzhOAEv6YxxfsRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlGHfP9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C233C4CED1;
	Sat,  4 Jan 2025 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735997894;
	bh=DZ641ToUHGGIED25myr3uOrPZ32fWg2JpL6WpgLolKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlGHfP9xizgNnOE+02G0SLHGaEHmxCwRd40Vo+pgpo7Am7HmR/cub6RSRG8zP+zgA
	 icLL/MgUHmBnMW6rJG1KHmWZa7ajA8Z1OWe8Gjt6WkM6D06VrFcQZS1akOwVZQeWyL
	 4SHAMcpcKLaEA2tQJ1knx2WF8jl5h1wr9KiUPkzHElDVqmt1Opxa4UQSudob/4CNDK
	 BY7UlxHu4+ICOp1iQ+sht5F7pj1GqVoi96QplUShifUGySwpg7866hb3wpcVMLmI6b
	 TkrdkdnNc2SDowJ8EDwCs6aFAnueTNXovIaI2NJB+0iY2DpDSK9bgub53Tv4euY0De
	 2szrPU6AR2jDQ==
Date: Sat, 4 Jan 2025 13:38:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nayab Sayed via B4 Relay
 <devnull+nayabbasha.sayed.microchip.com@kernel.org>
Cc: nayabbasha.sayed@microchip.com, Eugen Hristev
 <eugen.hristev@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value
Message-ID: <20250104133804.2a3c2ba3@jic23-huawei>
In-Reply-To: <20250103-fix-sama7g5-adc-realbits-v1-1-1732d265c36a@microchip.com>
References: <20250103-fix-sama7g5-adc-realbits-v1-1-1732d265c36a@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Jan 2025 16:50:40 +0530
Nayab Sayed via B4 Relay <devnull+nayabbasha.sayed.microchip.com@kernel.org> wrote:

> From: Nayab Sayed <nayabbasha.sayed@microchip.com>
> 
> The number of valid bits in SAMA7G5 ADC channel data register are 16.
> Hence changing the realbits value to 16
> 
> Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
Please send an appropriate fixes tag so we know how far to backport.
In reply to this mail is fine (no need to send a v2 for that)

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 68 ++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 8e5aaf15a921..c3a1dea2aa82 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -329,7 +329,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  #define AT91_HWFIFO_MAX_SIZE_STR	"128"
>  #define AT91_HWFIFO_MAX_SIZE		128
>  
> -#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
> +#define AT91_SAMA_CHAN_SINGLE(index, num, addr, rbits)			\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.channel = num,						\
> @@ -337,7 +337,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  		.scan_index = index,					\
>  		.scan_type = {						\
>  			.sign = 'u',					\
> -			.realbits = 14,					\
> +			.realbits = rbits,				\
>  			.storagebits = 16,				\
>  		},							\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> @@ -350,7 +350,13 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  		.indexed = 1,						\
>  	}
>  
> -#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
> +#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
> +	AT91_SAMA_CHAN_SINGLE(index, num, addr, 14)
> +
> +#define AT91_SAMA7G5_CHAN_SINGLE(index, num, addr)			\
> +	AT91_SAMA_CHAN_SINGLE(index, num, addr, 16)
> +
> +#define AT91_SAMA_CHAN_DIFF(index, num, num2, addr, rbits)		\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.differential = 1,					\
> @@ -360,7 +366,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  		.scan_index = index,					\
>  		.scan_type = {						\
>  			.sign = 's',					\
> -			.realbits = 14,					\
> +			.realbits = rbits,				\
>  			.storagebits = 16,				\
>  		},							\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> @@ -373,6 +379,12 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  		.indexed = 1,						\
>  	}
>  
> +#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
> +	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 14)
> +
> +#define AT91_SAMA7G5_CHAN_DIFF(index, num, num2, addr)			\
> +	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 16)
> +
>  #define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
>  	{								\
>  		.type = IIO_POSITIONRELATIVE,				\
> @@ -666,30 +678,30 @@ static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
>  };
>  
>  static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
> -	AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x60),
> -	AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x64),
> -	AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x68),
> -	AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x6c),
> -	AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x70),
> -	AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x74),
> -	AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x78),
> -	AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x7c),
> -	AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x80),
> -	AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x84),
> -	AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x88),
> -	AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x8c),
> -	AT91_SAMA5D2_CHAN_SINGLE(12, 12, 0x90),
> -	AT91_SAMA5D2_CHAN_SINGLE(13, 13, 0x94),
> -	AT91_SAMA5D2_CHAN_SINGLE(14, 14, 0x98),
> -	AT91_SAMA5D2_CHAN_SINGLE(15, 15, 0x9c),
> -	AT91_SAMA5D2_CHAN_DIFF(16, 0, 1, 0x60),
> -	AT91_SAMA5D2_CHAN_DIFF(17, 2, 3, 0x68),
> -	AT91_SAMA5D2_CHAN_DIFF(18, 4, 5, 0x70),
> -	AT91_SAMA5D2_CHAN_DIFF(19, 6, 7, 0x78),
> -	AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x80),
> -	AT91_SAMA5D2_CHAN_DIFF(21, 10, 11, 0x88),
> -	AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
> -	AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
> +	AT91_SAMA7G5_CHAN_SINGLE(0, 0, 0x60),
> +	AT91_SAMA7G5_CHAN_SINGLE(1, 1, 0x64),
> +	AT91_SAMA7G5_CHAN_SINGLE(2, 2, 0x68),
> +	AT91_SAMA7G5_CHAN_SINGLE(3, 3, 0x6c),
> +	AT91_SAMA7G5_CHAN_SINGLE(4, 4, 0x70),
> +	AT91_SAMA7G5_CHAN_SINGLE(5, 5, 0x74),
> +	AT91_SAMA7G5_CHAN_SINGLE(6, 6, 0x78),
> +	AT91_SAMA7G5_CHAN_SINGLE(7, 7, 0x7c),
> +	AT91_SAMA7G5_CHAN_SINGLE(8, 8, 0x80),
> +	AT91_SAMA7G5_CHAN_SINGLE(9, 9, 0x84),
> +	AT91_SAMA7G5_CHAN_SINGLE(10, 10, 0x88),
> +	AT91_SAMA7G5_CHAN_SINGLE(11, 11, 0x8c),
> +	AT91_SAMA7G5_CHAN_SINGLE(12, 12, 0x90),
> +	AT91_SAMA7G5_CHAN_SINGLE(13, 13, 0x94),
> +	AT91_SAMA7G5_CHAN_SINGLE(14, 14, 0x98),
> +	AT91_SAMA7G5_CHAN_SINGLE(15, 15, 0x9c),
> +	AT91_SAMA7G5_CHAN_DIFF(16, 0, 1, 0x60),
> +	AT91_SAMA7G5_CHAN_DIFF(17, 2, 3, 0x68),
> +	AT91_SAMA7G5_CHAN_DIFF(18, 4, 5, 0x70),
> +	AT91_SAMA7G5_CHAN_DIFF(19, 6, 7, 0x78),
> +	AT91_SAMA7G5_CHAN_DIFF(20, 8, 9, 0x80),
> +	AT91_SAMA7G5_CHAN_DIFF(21, 10, 11, 0x88),
> +	AT91_SAMA7G5_CHAN_DIFF(22, 12, 13, 0x90),
> +	AT91_SAMA7G5_CHAN_DIFF(23, 14, 15, 0x98),
>  	IIO_CHAN_SOFT_TIMESTAMP(24),
>  	AT91_SAMA5D2_CHAN_TEMP(AT91_SAMA7G5_ADC_TEMP_CHANNEL, "temp", 0xdc),
>  };
> 
> ---
> base-commit: 0bc21e701a6ffacfdde7f04f87d664d82e8a13bf
> change-id: 20250103-fix-sama7g5-adc-realbits-37f62f8925d7
> 
> Best regards,


