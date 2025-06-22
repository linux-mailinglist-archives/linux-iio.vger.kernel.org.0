Return-Path: <linux-iio+bounces-20869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD64AE3075
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0686B16FFF7
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E91EC01D;
	Sun, 22 Jun 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWl+obs4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E213219E0;
	Sun, 22 Jun 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750603190; cv=none; b=aEzQ3raOrwTOO+hRIy998UDYHOIoCsnHTs3ygK9Wzugw5hZLiS8L9KyzNUK1UZOtWRxwZ6CB7tBqplZqqOuCV/czDsHLijJUs9eqs2vQ3gXVT9CNNG1VJt788vzVYUgdjkGuRlSUFVop8sWBZY6uDQNHtFl1F63qq8b9bI35EIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750603190; c=relaxed/simple;
	bh=jSRNlT1TyBtLsI8Je5/pVFImoyPMsPB2Go0zqZLjKGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdzW8Jiq61T+CsIV+qMPxs6EWN//7igb2gXPi9WhFxyhMnLWFZw8OtklOY89NucSPsQ/0mwZTrYClC5fprys/nUHy4LmyNU+2IIk5xhBBweRXEel8QYeOpgOqQo2/859VERvZpff31OH1On50vHjtJ5oA1qbSXg6J4Eu+AShowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWl+obs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A07DC4CEE3;
	Sun, 22 Jun 2025 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750603189;
	bh=jSRNlT1TyBtLsI8Je5/pVFImoyPMsPB2Go0zqZLjKGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWl+obs4jnJjCCXlAKMJb/fiYMru8PmDMoxsvUtzkwXvglVh74iN8/WB8LDGGz70H
	 aQWr5J6wcDK6dd/4W8AMGUito5pavZHLvRmF3W/VG6hjI1nVST5uT7zREEU0x0CTYh
	 3I7TsA2G1pUAevyV7S19NWyPLobO51uZhadYtXX+4QSaTmJUBz1kki4izaC953petO
	 eVj8UYYGpu6KF5S05SDpsIi3rENbbj56odM2biSRIz6Bk9XtW5sFGFQPsh0k8ip3N2
	 hegH5eHcwDFwvXaNhrJv14wP5QJ6yTzq/sxrsGu5wD8ilsyMsSTKwYBB1+iG0gRXCi
	 8IcTj2/zPz5HQ==
Date: Sun, 22 Jun 2025 15:39:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/9] iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
Message-ID: <20250622153941.47b9c2a2@jic23-huawei>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-3-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
	<20250620-iio-adc-ad7173-add-spi-offload-support-v1-3-0766f6297430@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 17:20:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use the BITS_TO_BYTES() macro instead of dividing by 8 to convert bits
> to bytes.
> 
> This makes it more obvious what unit conversion is taking place.
> 
> In once instance, we also avoid the temporary assignment to a variable

In one instance

(don't bother fixing that unless doing a v2 for some other reason)

> as it was confusing that reg_size was being used with two different
> units (bits and bytes).
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 1657f64f1c0465b249adcc8a70dda8faf4a90565..fa792c800c80f960aca75b28a60cb2588e69fe7d 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/align.h>
> +#include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> @@ -190,7 +191,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
>  	unsigned int size;
>  	int ret;
>  
> -	size = DIV_ROUND_UP(reset_length, 8);
> +	size = BITS_TO_BYTES(reset_length);
>  	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
> @@ -419,7 +420,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  		data_reg = AD_SD_REG_DATA;
>  
>  	ret = ad_sd_read_reg(sigma_delta, data_reg,
> -		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
> +		BITS_TO_BYTES(chan->scan_type.realbits + chan->scan_type.shift),
>  		&raw_sample);
>  
>  out:
> @@ -552,9 +553,8 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	unsigned int reg_size;
>  	unsigned int data_reg;
>  
> -	reg_size = indio_dev->channels[0].scan_type.realbits +
> -			indio_dev->channels[0].scan_type.shift;
> -	reg_size = DIV_ROUND_UP(reg_size, 8);
> +	reg_size = BITS_TO_BYTES(indio_dev->channels[0].scan_type.realbits +
> +				 indio_dev->channels[0].scan_type.shift);
>  
>  	if (sigma_delta->info->data_reg != 0)
>  		data_reg = sigma_delta->info->data_reg;
> @@ -616,7 +616,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  		}
>  	}
>  
> -	sample_size = indio_dev->channels[0].scan_type.storagebits / 8;
> +	sample_size = BITS_TO_BYTES(indio_dev->channels[0].scan_type.storagebits);
>  	sample_pos = sample_size * sigma_delta->current_slot;
>  	memcpy(&sigma_delta->samples_buf[sample_pos], data, sample_size);
>  	sigma_delta->current_slot++;
> 


