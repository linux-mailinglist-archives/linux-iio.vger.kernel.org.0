Return-Path: <linux-iio+bounces-18405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE99A94FB3
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837ED189435E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26B2620D1;
	Mon, 21 Apr 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WERIL926"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE2C261389;
	Mon, 21 Apr 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233172; cv=none; b=RYdF4XzgQfqluT8q307DRUvOQL8wUbw9pNPlMGhlxEXV+LeshghoF8r7o8mX5pt9ElPh4KXSZ/Ro7tBFYfgG/sGTm6BpHm6Wses6vftFkoz1ympS6GTLOaxBWEOuf43o+F8Fbu93AGYKhRzwfoQDLwAYJ23AcPS5opdt6THwIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233172; c=relaxed/simple;
	bh=5VYyE8htA/BLTg5BgAgCDolmZjgydBdkcBes5QpLvqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O76k2s9ztnrG639EwVi4FNQSRK7FrCL+bs7dDz3P211r/y59ZFUEXjyuW711kwQcUuBuKcY8NRu/6nkBixMAzMaSwsXBxM/Xv+A8njmN08U3LNkiduMt10MkAG5h2C4D2okF5gBewLjPBW+VWYxX+TBjSubAdYmG3aEUgXrKt5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WERIL926; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21167C4CEE4;
	Mon, 21 Apr 2025 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745233172;
	bh=5VYyE8htA/BLTg5BgAgCDolmZjgydBdkcBes5QpLvqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WERIL926LETINzWfOWypCJpPgYSkuRcZjERTy4Ygo5cBGWwLTxzNt9X/owj+FsDaE
	 fuHZOjNZf3dgn7zU4BikABM7/57xzBJfEfNcqgN/JMK2OqS547hAbTJC8mQ2tMPg41
	 XqeZ9YMexYz7oMrjQx4aRa751ICv3vVw+AZItQmKXUBbHThpM3iNJTuGnI2ubbPrOm
	 Z0DiHErkUNcZTUjlYwMP0u3JYr9Et0ij5J3p+Skp5ivK+SoYlNgaVf36sMF2XFviW5
	 yfGv9PVxBF3P5Xc+jx9GENlMQvJvLoJOypybHUlOnm5BcziQ8bnyvfPOBssYRjvT+X
	 LnKrcOYg6qAxg==
Date: Mon, 21 Apr 2025 11:59:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: amplifiers: ada4250: use DMA-safe memory for
 regmap_bulk_read()
Message-ID: <20250421115924.682f52ee@jic23-huawei>
In-Reply-To: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
References: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 13:16:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use DMA-safe memory instead of stack-allocated memory for the call to
> regmap_bulk_read() in the ada4250_init() function as this could be used
> directly by a SPI controller.
> 
> Also remove unnecessary use of get_unaligned_le16() and explicitly
> include linux/types.h e.g. for __le16 while we are fixing this up.
> 
> Fixes: 28b4c30bfa5f ("iio: amplifiers: ada4250: add support for ADA4250")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Let's wait and see if Mark has a view on this.  The switch to an __le16 is
good either way.

Jonathan

> ---
>  drivers/iio/amplifiers/ada4250.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
> index 74f8429d652b17b4d1f38366e23ce6a2b3e9b218..f81438460aa51ce30f8f605c60ee5be5c8c251d3 100644
> --- a/drivers/iio/amplifiers/ada4250.c
> +++ b/drivers/iio/amplifiers/ada4250.c
> @@ -13,8 +13,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> -
> -#include <linux/unaligned.h>
> +#include <linux/types.h>
>  
>  /* ADA4250 Register Map */
>  #define ADA4250_REG_GAIN_MUX        0x00
> @@ -63,6 +62,7 @@ struct ada4250_state {
>  	u8			gain;
>  	int			offset_uv;
>  	bool			refbuf_en;
> +	__le16			reg_val_16 __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  /* ADA4250 Current Bias Source Settings: Disabled, Bandgap Reference, AVDD */
> @@ -301,7 +301,6 @@ static int ada4250_init(struct ada4250_state *st)
>  {
>  	int ret;
>  	u16 chip_id;
> -	u8 data[2] __aligned(8) = {};
>  	struct spi_device *spi = st->spi;
>  
>  	st->refbuf_en = device_property_read_bool(&spi->dev, "adi,refbuf-enable");
> @@ -326,11 +325,12 @@ static int ada4250_init(struct ada4250_state *st)
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, data, 2);
> +	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, &st->reg_val_16,
> +			       sizeof(st->reg_val_16));
>  	if (ret)
>  		return ret;
>  
> -	chip_id = get_unaligned_le16(data);
> +	chip_id = le16_to_cpu(st->reg_val_16);
>  
>  	if (chip_id != ADA4250_CHIP_ID) {
>  		dev_err(&spi->dev, "Invalid chip ID.\n");
> 
> ---
> base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
> change-id: 20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-93ebb1344295
> 
> Best regards,


