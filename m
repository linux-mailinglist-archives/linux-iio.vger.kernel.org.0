Return-Path: <linux-iio+bounces-20312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D276AAD12F5
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F12169BA2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF66424DCFF;
	Sun,  8 Jun 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYw23Ivr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A654769;
	Sun,  8 Jun 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749396145; cv=none; b=LnJjUVRWw/3z0rL92/1RCGexz3CX1tleP5H7sC0/16wicH63ydDtdCm5weMi+AVl8rfDTQJ+EzGn5mFz2mgJg3Yz0eY3auXJ2iLaZCenSRAwOybGDbwONF29mIfEomj/TNX4qvV168CONK9daoXt73Ac4MzPpEL1kuF5wkg6F0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749396145; c=relaxed/simple;
	bh=dAzCR0k3pkiqIdegGgEfm7V1qIivvTRGKFGbxRv7LbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4j0poqTtpoMHCZYde8UKUGqPFTu6+Kyzso3RHyoIUuAvC9O/KfkZpph2YKZLNXvDwvJO630L+Dc7ubumwSNBfpWuL10nqG6YscL5xsEt7zx7HNkSgWHsrLPTC2uKdXD2s9P8hBINwe30mOU403ooqhTslykd885CFz1IeJeiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYw23Ivr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203BC4CEEE;
	Sun,  8 Jun 2025 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749396145;
	bh=dAzCR0k3pkiqIdegGgEfm7V1qIivvTRGKFGbxRv7LbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iYw23IvrfNQ1Zp+0uixwvLoXzawMviYiR/1Q/vLeM2AZN8mOfzbJD9RuiyJmLwUPN
	 lKOyZ0vg43myP2HUfGcVfZB+QubqdSIS6SzEa0bar0aSXbVP7d09oQyiHT2zAhPAFa
	 r/QkXe22TRGKLlqyZAC9HYNcWobaOzESM0IzH9dxAnZcJssTNnKSaDmxjKlqCF+XYz
	 NkQ8WYkfQOjaG8SaUeNESgYGXL5/W4NDgVDG9ldmdHsXjD/hDTS2Uf72Bfj9WvKSbw
	 quElcOfoO0BvfAeE6S7qx2Zluz7EaQLh+l52dooWVxbbFwvlHc4/7HrdFR1mGMGOLT
	 5MFznbf2CGrrA==
Date: Sun, 8 Jun 2025 16:22:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] iio: accel: adxl313: make use of regmap cache
Message-ID: <20250608162215.0d1789d0@jic23-huawei>
In-Reply-To: <20250601172139.59156-4-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Jun 2025 17:21:31 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Setup regmap cache to cache register configuration. This is a preparatory
> step for follow up patches. Using cached settings will help at inerrupt
> handling, to generate activity and inactivity events.

The regmap cache will reduce traffic to the device for things like reading
back sampling frequency, so no need to justify this patch with 'future'
stuff.  Justify it with current.   I've applied with the description of
simply

"Setup regmap cache to cache register configuration, reducing bus traffic
for repeated accesses to non volatile registers."

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


