Return-Path: <linux-iio+bounces-19875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B9AC3488
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963993B8075
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FB11F03D9;
	Sun, 25 May 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldsHByJo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F74A1D;
	Sun, 25 May 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748175746; cv=none; b=KuQ2D5qUaE7C6hw4vztr82wE+dVXtXnrUO6Q9hIIbw+SFIFG6cuytXeP3UVaspEoFxk4kYSiPOgtH1yL+kNRUW2n1tB5jbFPGR/aU0drfjo9bB4vZNZsaEqjf35kzMvQNwb0bDebhNo+nn/ZKetrGFjlcq6eeoFkV+LMWd+c1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748175746; c=relaxed/simple;
	bh=qgQsPdhkT3wCg4PoDdhv9AP0Evfsapc5J7ZrEPF3ouQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmFl0eV8lsi2BxMvXIfABtjNoT4g/QSfNUoW7fSpF52nEoimXwcUlMfvNx5CPlTR2j7rI9gO1ekM+vtqHB15M6VOC+2VpGXojuiZpM7JALcFV53H3menzqB+wsXbWGHq7Fedi0eefMQheD5R/belCWAvYbHTKyw1JgCS28T3nWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldsHByJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCE9C4CEEA;
	Sun, 25 May 2025 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748175745;
	bh=qgQsPdhkT3wCg4PoDdhv9AP0Evfsapc5J7ZrEPF3ouQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ldsHByJonKrw3ea58rYI83Ho3qp1ccDew3g91Iz4/4Zy1QnYrzaRps9PXXwSidNBH
	 Q9ND1WOqIcvkLfuPEXSxAzqtGm7Kubpp/PzgREdDhkgCQDVICXJjMqODVDh8Dc5fYs
	 2Gc9PAIVBMeL6ehCLJ12UhEW01CvzALc/4/bJtrfl9zdXbupouToh9kXbfJZzV7sTQ
	 Exvk2JGt7oc0Ct3FjlUyRUkPZMX6RXF6vNL8lUk7WmvhLedu1/I1ij/y6VVdvaPvMF
	 L5JcE0QSVMYswqKWAPS6tQjKcYtfyOS8Lkkac4dMFU2RaueSEtbpy9fub07S8ASXVH
	 NHHLJSwYMqdtA==
Date: Sun, 25 May 2025 13:22:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/12] iio: accel: adxl313: make use of regmap cache
Message-ID: <20250525132216.0bbc7067@jic23-huawei>
In-Reply-To: <20250523223523.35218-5-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:15 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Setup regmap cache to cache register configuration. This is a preparatory
> step for follow up patches, to allow easy acces to the cached
> configuration.

I think this stands on it's own given registers like the calibbias
are already both written and read from.  So I'd generalize the justification
to simply reducing unnecessary bus traffic.

Jonathan

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl313.h      |  2 ++
>  drivers/iio/accel/adxl313_core.c | 17 +++++++++++++++++
>  drivers/iio/accel/adxl313_i2c.c  |  6 ++++++
>  drivers/iio/accel/adxl313_spi.c  |  6 ++++++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> index 72f624af4686..fc937bdf83b6 100644
> --- a/drivers/iio/accel/adxl313.h
> +++ b/drivers/iio/accel/adxl313.h
> @@ -54,6 +54,8 @@ extern const struct regmap_access_table adxl312_writable_regs_table;
>  extern const struct regmap_access_table adxl313_writable_regs_table;
>  extern const struct regmap_access_table adxl314_writable_regs_table;
>  
> +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg);
> +
>  enum adxl313_device_type {
>  	ADXL312,
>  	ADXL313,
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 06a771bb4726..0c893c286017 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -46,6 +46,23 @@ const struct regmap_access_table adxl314_readable_regs_table = {
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


