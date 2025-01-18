Return-Path: <linux-iio+bounces-14457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B23A15DDF
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240011886CED
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D5198851;
	Sat, 18 Jan 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYAV0GBd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97918873F;
	Sat, 18 Jan 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737216030; cv=none; b=IymIQH008N43jqV22VSEIC/pXyhUGXgKxkS7hHuvdTctVqJsICiSf7ADEUhU+ABuB2mQJMdwCGVUXsgUN2TjXoAL3KITl9lyBi/yG4AFrWV9SZ9et5kfmx00TqBRQpIn/91N4fv3Py71F0NXugqQuKtUaV1obgFNzGlYjg/PVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737216030; c=relaxed/simple;
	bh=aoL64gAwJYIQk+frzXHPyXnLHLTZu1YygjJp4IyW1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHKY7cik7UBunOvhQUIXzmXjauldFUf7Ozfs7NGBqmp9yBVABhYMXjuqRObQqVcR+QF8MEPXqUGDl4MOxh28w1uQyURtX99KyWpeQF7wwzl7hgo4NCbHxEFWJVdTtTur7cFvAe+AO6pPF8dBPARNhagcFMfTxKkyfVeQca4zK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYAV0GBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B844C4CED1;
	Sat, 18 Jan 2025 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737216029;
	bh=aoL64gAwJYIQk+frzXHPyXnLHLTZu1YygjJp4IyW1PE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HYAV0GBd7taKQQx9yxmurM4I2tT10lJncshdGK4rBARte0lKq2fmY1/G9oH6J85H5
	 cv/rNSYdjQztMWszuUUbrNCyUkiySXr2uiz/UGYJjQbK/RLRjLIkCx/0CJo4f30Rqe
	 G3iZlIzg2m4QkxuNHFcTybeeKQSohuOL+VhxArrztiuHj2cE6Su8TK5r1FtwE34RML
	 rUS1Hn96oQu7fBVQeectR+YegZND3UT+o9Z2sQgu8bK9893xBdfN82zVZjby+s3qBn
	 sjjO7vOz3JO49m0tMe+foLcVKeBQdMbzJvWSCxoRPzMEeWXZTw1KR0/hDdQOeF8QRb
	 dg7GuefQSYh5A==
Date: Sat, 18 Jan 2025 16:00:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nayab Sayed via B4 Relay
 <devnull+nayabbasha.sayed.microchip.com@kernel.org>
Cc: nayabbasha.sayed@microchip.com, Eugen Hristev
 <eugen.hristev@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] iio: adc: at91-sama5d2_adc: fix sama7g5 realbits
 value
Message-ID: <20250118160020.5b32eb61@jic23-huawei>
In-Reply-To: <20250115-fix-sama7g5-adc-realbits-v2-1-58a6e4087584@microchip.com>
References: <20250115-fix-sama7g5-adc-realbits-v2-1-58a6e4087584@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 11:37:04 +0530
Nayab Sayed via B4 Relay <devnull+nayabbasha.sayed.microchip.com@kernel.org> wrote:

> From: Nayab Sayed <nayabbasha.sayed@microchip.com>
> 
> The number of valid bits in SAMA7G5 ADC channel data register are 16.
> Hence changing the realbits value to 16
> 
> Fixes: 840bf6cb983f ("iio: adc: at91-sama5d2_adc: add support for sama7g5 device")
> Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Note though I'll be rebasing that on rc1 once available and haven't pushed
out in the meantime a will make a mess of linux-next.

Jonathan

> ---
> Changes in v2:
> - Add `Fixes:` tag in commit message.
> - Link to v1: https://lore.kernel.org/r/20250103-fix-sama7g5-adc-realbits-v1-1-1732d265c36a@microchip.com
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
> base-commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
> change-id: 20250103-fix-sama7g5-adc-realbits-37f62f8925d7
> 
> Best regards,


