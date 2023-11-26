Return-Path: <linux-iio+bounces-397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B707F93FE
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC702810F8
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF4D2F8;
	Sun, 26 Nov 2023 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM1EWzEg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4279E3
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 16:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC23C433C8;
	Sun, 26 Nov 2023 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701016902;
	bh=adzPVFqPGr8eyU7WbBKtY3ncoE5B84TV9+DjXMJ74vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UM1EWzEgY3vBcSmW7zTMfU+Ym9pGhPm523x/rinr9ZyXdA/caozo/Pcb8C/nhxlyG
	 1jh7RYRfntTlZDOlKE8smFZdQU0tUF6NO+pT9iLuAzdv7gk6ulY7q1J1C4/fdT2KB3
	 1vvXp1llhJAI9yqvXBy5TYPxFMSBC5K0l3LVl+LKCLz8ibzaQPtydcl2QawqWWiSnO
	 ZdiWyD95UQVoOY1bb+nQtheSxTAqi5duneYHmMg6RrwayTOt4CWtQelr1mTMDQGlrU
	 8zArPq0R4XExm8/tsfwPGMiRZP67lWe5FONayKWx42+VYoacC4u7VN/EwHcIEE6qE/
	 K9yP82LDhRbwg==
Date: Sun, 26 Nov 2023 16:41:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: imu: adis16475: add spi_device_id table
Message-ID: <20231126164136.0ee113fc@jic23-huawei>
In-Reply-To: <20231102125258.3284830-1-nuno.sa@analog.com>
References: <20231102125258.3284830-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Nov 2023 13:52:58 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> This prevents the warning message "SPI driver has no spi_device_id for..."
> when registering the driver. More importantly, it makes sure that
> module autoloading works as spi relies on spi: modaliases and not of.
> 
> While at it, move the of_device_id table to it's natural place.
> 
> Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
> 
> I'm adding the fixes tag as module autoloading might be a nice thing to
> backport... Jonathan, if you don't see a real need for it, feel free to
> drop the tag.

Fine to have the fixes tag.  I've marked it for stable as well.

Applied
> 
>  drivers/iio/imu/adis16475.c | 117 ++++++++++++++++++++++--------------
>  1 file changed, 72 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index b7cbe1565aee..04153a2725d5 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1406,50 +1406,6 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
>  	return 0;
>  }
>  
> -static const struct of_device_id adis16475_of_match[] = {
> -	{ .compatible = "adi,adis16470",
> -		.data = &adis16475_chip_info[ADIS16470] },
> -	{ .compatible = "adi,adis16475-1",
> -		.data = &adis16475_chip_info[ADIS16475_1] },
> -	{ .compatible = "adi,adis16475-2",
> -		.data = &adis16475_chip_info[ADIS16475_2] },
> -	{ .compatible = "adi,adis16475-3",
> -		.data = &adis16475_chip_info[ADIS16475_3] },
> -	{ .compatible = "adi,adis16477-1",
> -		.data = &adis16475_chip_info[ADIS16477_1] },
> -	{ .compatible = "adi,adis16477-2",
> -		.data = &adis16475_chip_info[ADIS16477_2] },
> -	{ .compatible = "adi,adis16477-3",
> -		.data = &adis16475_chip_info[ADIS16477_3] },
> -	{ .compatible = "adi,adis16465-1",
> -		.data = &adis16475_chip_info[ADIS16465_1] },
> -	{ .compatible = "adi,adis16465-2",
> -		.data = &adis16475_chip_info[ADIS16465_2] },
> -	{ .compatible = "adi,adis16465-3",
> -		.data = &adis16475_chip_info[ADIS16465_3] },
> -	{ .compatible = "adi,adis16467-1",
> -		.data = &adis16475_chip_info[ADIS16467_1] },
> -	{ .compatible = "adi,adis16467-2",
> -		.data = &adis16475_chip_info[ADIS16467_2] },
> -	{ .compatible = "adi,adis16467-3",
> -		.data = &adis16475_chip_info[ADIS16467_3] },
> -	{ .compatible = "adi,adis16500",
> -		.data = &adis16475_chip_info[ADIS16500] },
> -	{ .compatible = "adi,adis16505-1",
> -		.data = &adis16475_chip_info[ADIS16505_1] },
> -	{ .compatible = "adi,adis16505-2",
> -		.data = &adis16475_chip_info[ADIS16505_2] },
> -	{ .compatible = "adi,adis16505-3",
> -		.data = &adis16475_chip_info[ADIS16505_3] },
> -	{ .compatible = "adi,adis16507-1",
> -		.data = &adis16475_chip_info[ADIS16507_1] },
> -	{ .compatible = "adi,adis16507-2",
> -		.data = &adis16475_chip_info[ADIS16507_2] },
> -	{ .compatible = "adi,adis16507-3",
> -		.data = &adis16475_chip_info[ADIS16507_3] },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, adis16475_of_match);
>  
>  static int adis16475_probe(struct spi_device *spi)
>  {
> @@ -1463,7 +1419,7 @@ static int adis16475_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->info = device_get_match_data(&spi->dev);
> +	st->info = spi_get_device_match_data(spi);
>  	if (!st->info)
>  		return -EINVAL;
>  
> @@ -1503,12 +1459,83 @@ static int adis16475_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id adis16475_of_match[] = {
> +	{ .compatible = "adi,adis16470",
> +		.data = &adis16475_chip_info[ADIS16470] },
> +	{ .compatible = "adi,adis16475-1",
> +		.data = &adis16475_chip_info[ADIS16475_1] },
> +	{ .compatible = "adi,adis16475-2",
> +		.data = &adis16475_chip_info[ADIS16475_2] },
> +	{ .compatible = "adi,adis16475-3",
> +		.data = &adis16475_chip_info[ADIS16475_3] },
> +	{ .compatible = "adi,adis16477-1",
> +		.data = &adis16475_chip_info[ADIS16477_1] },
> +	{ .compatible = "adi,adis16477-2",
> +		.data = &adis16475_chip_info[ADIS16477_2] },
> +	{ .compatible = "adi,adis16477-3",
> +		.data = &adis16475_chip_info[ADIS16477_3] },
> +	{ .compatible = "adi,adis16465-1",
> +		.data = &adis16475_chip_info[ADIS16465_1] },
> +	{ .compatible = "adi,adis16465-2",
> +		.data = &adis16475_chip_info[ADIS16465_2] },
> +	{ .compatible = "adi,adis16465-3",
> +		.data = &adis16475_chip_info[ADIS16465_3] },
> +	{ .compatible = "adi,adis16467-1",
> +		.data = &adis16475_chip_info[ADIS16467_1] },
> +	{ .compatible = "adi,adis16467-2",
> +		.data = &adis16475_chip_info[ADIS16467_2] },
> +	{ .compatible = "adi,adis16467-3",
> +		.data = &adis16475_chip_info[ADIS16467_3] },
> +	{ .compatible = "adi,adis16500",
> +		.data = &adis16475_chip_info[ADIS16500] },
> +	{ .compatible = "adi,adis16505-1",
> +		.data = &adis16475_chip_info[ADIS16505_1] },
> +	{ .compatible = "adi,adis16505-2",
> +		.data = &adis16475_chip_info[ADIS16505_2] },
> +	{ .compatible = "adi,adis16505-3",
> +		.data = &adis16475_chip_info[ADIS16505_3] },
> +	{ .compatible = "adi,adis16507-1",
> +		.data = &adis16475_chip_info[ADIS16507_1] },
> +	{ .compatible = "adi,adis16507-2",
> +		.data = &adis16475_chip_info[ADIS16507_2] },
> +	{ .compatible = "adi,adis16507-3",
> +		.data = &adis16475_chip_info[ADIS16507_3] },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adis16475_of_match);
> +
> +static const struct spi_device_id adis16475_ids[] = {
> +	{ "adis16470", (kernel_ulong_t)&adis16475_chip_info[ADIS16470] },
> +	{ "adis16475-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_1] },
> +	{ "adis16475-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_2] },
> +	{ "adis16475-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_3] },
> +	{ "adis16477-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_1] },
> +	{ "adis16477-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_2] },
> +	{ "adis16477-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_3] },
> +	{ "adis16465-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_1] },
> +	{ "adis16465-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_2] },
> +	{ "adis16465-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_3] },
> +	{ "adis16467-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_1] },
> +	{ "adis16467-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_2] },
> +	{ "adis16467-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_3] },
> +	{ "adis16500", (kernel_ulong_t)&adis16475_chip_info[ADIS16500] },
> +	{ "adis16505-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_1] },
> +	{ "adis16505-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_2] },
> +	{ "adis16505-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_3] },
> +	{ "adis16507-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_1] },
> +	{ "adis16507-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_2] },
> +	{ "adis16507-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_3] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adis16475_ids);
> +
>  static struct spi_driver adis16475_driver = {
>  	.driver = {
>  		.name = "adis16475",
>  		.of_match_table = adis16475_of_match,
>  	},
>  	.probe = adis16475_probe,
> +	.id_table = adis16475_ids,
>  };
>  module_spi_driver(adis16475_driver);
>  


