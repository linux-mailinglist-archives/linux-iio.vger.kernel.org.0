Return-Path: <linux-iio+bounces-20840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBEAE2F7A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 13:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCE4171E6A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B71D54FE;
	Sun, 22 Jun 2025 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRj3IvF1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF344CE08;
	Sun, 22 Jun 2025 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750590782; cv=none; b=VAfWYAu39g1uZFGC1jfPuUiZEzP0aLnRpSFXtEq6OHXUuYOTz5liq/owvUdnmZ8PSlNJF8ioYtBieinj/1MG827ZwflWlc1JH8iR5S9dBhe1Q2sAIP732D7BMFBpPrytDJPWgrzt65CvNw6hi9kGDpbXmnXqIP8TdknwfIPGwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750590782; c=relaxed/simple;
	bh=oCDcnN/hefMHFnZyBuF0bfWG/SYOOScbET2P5zMrTo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li52jvKvbFUkf5W+WjATPNj0uybZLEJyBSBRTtTxQZTe186jHyh65sjiAXcbzvhnSL7Rt55lpPdH3lDNQi1fdQzDWAnN9DsTd2gP/vcruOd+GN67Mnh/0VE42m6GJFIHVgvw6JujWwiNLskBn65sRIG46T7bis6GXCxYIS+fSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRj3IvF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308F1C4CEED;
	Sun, 22 Jun 2025 11:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750590782;
	bh=oCDcnN/hefMHFnZyBuF0bfWG/SYOOScbET2P5zMrTo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GRj3IvF1TNNT5tBiE4yQQQ7UuL3/QAvTfROxY7tPzGGsMlQEuOlelgXzLdqK9SfPc
	 17M9EJyM2egPZdOT/OdL+YFwfNMh16jt2RCVlPXjqTWsl3vR2G7dOQjkSOOTavLt1X
	 hf7HWyuwC3fI3JtsZV2mpv5KiPiA8I6/9UZec6Yfp6zyQGjjWEGHx5m3mcu+/YIJ2H
	 PpQZgGXIzzJhM5p3Pty65wEXTRI2Qd3d0KFulCpFs4tsu75s9q7oaOA4cMtZOuHI/H
	 W8ZXnWgG0Nq0InP5bhEJO/8QS59aLnk5mbCJcnH1qqMlNdoH3EGxp7GOJ6qnKDoGUf
	 K9QfHxV02t1bw==
Date: Sun, 22 Jun 2025 12:12:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/8] iio: accel: adxl313: make use of regmap cache
Message-ID: <20250622121252.56c80b35@jic23-huawei>
In-Reply-To: <20250615222258.117771-2-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
	<20250615222258.117771-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Jun 2025 22:22:51 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Setup regmap cache to cache register configuration, reducing bus traffic
> for repeated accesses to non volatile registers.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied but there was some fuzz. That makes me wonder what
is different between our trees.

Maybe it will become clear later in the patch set.

Thanks

Jonathan

> ---
>  drivers/iio/accel/adxl313.h      |  3 +++
>  drivers/iio/accel/adxl313_core.c | 18 ++++++++++++++++++
>  drivers/iio/accel/adxl313_i2c.c  |  6 ++++++
>  drivers/iio/accel/adxl313_spi.c  |  6 ++++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> index 72f624af4686..2bc86ac8ffd4 100644
> --- a/drivers/iio/accel/adxl313.h
> +++ b/drivers/iio/accel/adxl313.h
> @@ -22,6 +22,7 @@
>  #define ADXL313_REG_BW_RATE		0x2C
>  #define ADXL313_REG_POWER_CTL		0x2D
>  #define ADXL313_REG_INT_MAP		0x2F
> +#define ADXL313_REG_INT_SOURCE		0x30
>  #define ADXL313_REG_DATA_FORMAT		0x31
>  #define ADXL313_REG_DATA_AXIS(index)	(0x32 + ((index) * 2))
>  #define ADXL313_REG_FIFO_CTL		0x38
> @@ -54,6 +55,8 @@ extern const struct regmap_access_table adxl312_writable_regs_table;
>  extern const struct regmap_access_table adxl313_writable_regs_table;
>  extern const struct regmap_access_table adxl314_writable_regs_table;
>  
> +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg);
> +
>  enum adxl313_device_type {
>  	ADXL312,
>  	ADXL313,
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 2f26da5857d4..39f16f97bb4a 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -46,6 +46,24 @@ const struct regmap_access_table adxl314_readable_regs_table = {
>  };
>  EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL313);
>  
> +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ADXL313_REG_DATA_AXIS(0):
> +	case ADXL313_REG_DATA_AXIS(1):
> +	case ADXL313_REG_DATA_AXIS(2):
> +	case ADXL313_REG_DATA_AXIS(3):
> +	case ADXL313_REG_DATA_AXIS(4):
> +	case ADXL313_REG_DATA_AXIS(5):
> +	case ADXL313_REG_FIFO_STATUS:
> +	case ADXL313_REG_INT_SOURCE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
> +
>  static int adxl312_check_id(struct device *dev,
>  			    struct adxl313_data *data)
>  {
> diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
> index a4cf0cf2c5aa..e8636e8ab14f 100644
> --- a/drivers/iio/accel/adxl313_i2c.c
> +++ b/drivers/iio/accel/adxl313_i2c.c
> @@ -21,6 +21,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
>  		.rd_table	= &adxl312_readable_regs_table,
>  		.wr_table	= &adxl312_writable_regs_table,
>  		.max_register	= 0x39,
> +		.volatile_reg	= adxl313_is_volatile_reg,
> +		.cache_type	= REGCACHE_MAPLE,
>  	},
>  	[ADXL313] = {
>  		.reg_bits	= 8,
> @@ -28,6 +30,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
>  		.rd_table	= &adxl313_readable_regs_table,
>  		.wr_table	= &adxl313_writable_regs_table,
>  		.max_register	= 0x39,
> +		.volatile_reg	= adxl313_is_volatile_reg,
> +		.cache_type	= REGCACHE_MAPLE,
>  	},
>  	[ADXL314] = {
>  		.reg_bits	= 8,
> @@ -35,6 +39,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
>  		.rd_table	= &adxl314_readable_regs_table,
>  		.wr_table	= &adxl314_writable_regs_table,
>  		.max_register	= 0x39,
> +		.volatile_reg	= adxl313_is_volatile_reg,
> +		.cache_type	= REGCACHE_MAPLE,
>  	},
>  };
>  
> diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
> index 9a16b40bff34..68e323e81aeb 100644
> --- a/drivers/iio/accel/adxl313_spi.c
> +++ b/drivers/iio/accel/adxl313_spi.c
> @@ -24,6 +24,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
>  		.max_register	= 0x39,
>  		/* Setting bits 7 and 6 enables multiple-byte read */
>  		.read_flag_mask	= BIT(7) | BIT(6),
> +		.volatile_reg	= adxl313_is_volatile_reg,
> +		.cache_type	= REGCACHE_MAPLE,
>  	},
>  	[ADXL313] = {
>  		.reg_bits	= 8,
> @@ -33,6 +35,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
>  		.max_register	= 0x39,
>  		/* Setting bits 7 and 6 enables multiple-byte read */
>  		.read_flag_mask	= BIT(7) | BIT(6),
> +		.volatile_reg	= adxl313_is_volatile_reg,
> +		.cache_type	= REGCACHE_MAPLE,
>  	},
>  	[ADXL314] = {
>  		.reg_bits	= 8,
> @@ -42,6 +46,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
>  		.max_register	= 0x39,
>  		/* Setting bits 7 and 6 enables multiple-byte read */
>  		.read_flag_mask	= BIT(7) | BIT(6),
> +		.volatile_reg	= adxl313_is_volatile_reg,
> +		.cache_type	= REGCACHE_MAPLE,
>  	},
>  };
>  


