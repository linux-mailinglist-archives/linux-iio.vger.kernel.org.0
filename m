Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91B71AF330
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgDRSbz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSbz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:31:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A28FF221E9;
        Sat, 18 Apr 2020 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587234714;
        bh=IEWcrH/CIzYGczVXCaYhLD77YsuTXvp2rvlPfx0hHCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AzxnKtxft+ArNCKn5B8pgjU8OFiW/E6u0AEJYN3Hy4+cID6yqdOlfT7Y5+6yro+bs
         XTZIndqZwZoPiPrUnqLJZKi9tMq5pojagkK3tRNDvdKxqzuI32a60UgC/Id8AfZZ4h
         nsOmu+xRmh2ufE5vV1/bkV9/+lCPNKAi8X7cYWXg=
Date:   Sat, 18 Apr 2020 19:31:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexandru.tachici@analog.com>
Subject: Re: [PATCH v4 1/2] iio: adc: ad7192: fix null pointer de-reference
 crash during probe
Message-ID: <20200418193150.05dc83bb@archlinux>
In-Reply-To: <20200415055804.17971-1-alexandru.ardelean@analog.com>
References: <20200415055804.17971-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020 08:58:03 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> When the 'spi_device_id' table was removed, it omitted to cleanup/fix the
> assignment:
>    'indio_dev->name = spi_get_device_id(spi)->name;'
> 
> After that patch 'spi_get_device_id(spi)' returns NULL, so this crashes
> during probe with null de-ref.
> 
> This change fixes this by introducing an ad7192_chip_info struct, and
> defines all part-names [that should be assigned to indio_dev->name] in a
> 'ad7192_chip_info_tbl' table.
> 
> With this change, the old 'st->devid' is also moved to be a
> 'chip_info->chip_id'. And the old 'ID_AD719X' macros have been renamed to
> 'CHIPID_AD719X'. Tld identifiers have been re-purposed to be enum/index
> values in the new 'ad7192_chip_info_tbl'.
> 
> This should fix the bug, and maintain the ABI for the 'indio_dev->name'
> field.
> 
> Fixes: 66614ab2be38 ("staging: iio: adc: ad7192: removed spi_device_id")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the fixes-togreg branch of iio.git.

thanks,

Jonathan

> ---
> 
> Changelog v3 -> v4:
>  * renamed ID_AD7193 -> CHIPIP_AD7193 in ad7192_channels_config();
>    noticed by Jeremy Fertic <jeremyfertic@gmail.com>
>  * did another sweep of the ID_AD719X -> CHIPID_AD719X rename to make
>    sure nothing else slipped
> 
> Changelog v2 -> v3:
>  * reworked patch to introduce a chip_info struct for the part-name
>  * added 2nd patch to move of-table closer to the end of the file; this
>    patch is more cosmetic; has no fixes tag, but is on top of the previous
>  
> Changelog v1 -> v2:
>  * fix colon for Fixes tag
>  * updated commit title a bit; to make it longer
> 
>  drivers/iio/adc/ad7192.c | 63 ++++++++++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 8ec28aa8fa8a..1431f555daa6 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -125,10 +125,10 @@
>  #define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
>  
>  /* ID Register Bit Designations (AD7192_REG_ID) */
> -#define ID_AD7190		0x4
> -#define ID_AD7192		0x0
> -#define ID_AD7193		0x2
> -#define ID_AD7195		0x6
> +#define CHIPID_AD7190		0x4
> +#define CHIPID_AD7192		0x0
> +#define CHIPID_AD7193		0x2
> +#define CHIPID_AD7195		0x6
>  #define AD7192_ID_MASK		0x0F
>  
>  /* GPOCON Register Bit Designations (AD7192_REG_GPOCON) */
> @@ -161,7 +161,20 @@ enum {
>     AD7192_SYSCALIB_FULL_SCALE,
>  };
>  
> +enum {
> +	ID_AD7190,
> +	ID_AD7192,
> +	ID_AD7193,
> +	ID_AD7195,
> +};
> +
> +struct ad7192_chip_info {
> +	unsigned int			chip_id;
> +	const char			*name;
> +};
> +
>  struct ad7192_state {
> +	const struct ad7192_chip_info	*chip_info;
>  	struct regulator		*avdd;
>  	struct regulator		*dvdd;
>  	struct clk			*mclk;
> @@ -172,7 +185,6 @@ struct ad7192_state {
>  	u32				conf;
>  	u32				scale_avail[8][2];
>  	u8				gpocon;
> -	u8				devid;
>  	u8				clock_sel;
>  	struct mutex			lock;	/* protect sensor state */
>  	u8				syscalib_mode[8];
> @@ -348,7 +360,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
>  
>  	id &= AD7192_ID_MASK;
>  
> -	if (id != st->devid)
> +	if (id != st->chip_info->chip_id)
>  		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
>  			 id);
>  
> @@ -363,7 +375,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
>  		st->mode |= AD7192_MODE_REJ60;
>  
>  	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
> -	if (refin2_en && st->devid != ID_AD7195)
> +	if (refin2_en && st->chip_info->chip_id != CHIPID_AD7195)
>  		st->conf |= AD7192_CONF_REFSEL;
>  
>  	st->conf &= ~AD7192_CONF_CHOP;
> @@ -859,12 +871,31 @@ static const struct iio_chan_spec ad7193_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(14),
>  };
>  
> +static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
> +	[ID_AD7190] = {
> +		.chip_id = CHIPID_AD7190,
> +		.name = "ad7190",
> +	},
> +	[ID_AD7192] = {
> +		.chip_id = CHIPID_AD7192,
> +		.name = "ad7192",
> +	},
> +	[ID_AD7193] = {
> +		.chip_id = CHIPID_AD7193,
> +		.name = "ad7193",
> +	},
> +	[ID_AD7195] = {
> +		.chip_id = CHIPID_AD7195,
> +		.name = "ad7195",
> +	},
> +};
> +
>  static int ad7192_channels_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
> -	switch (st->devid) {
> -	case ID_AD7193:
> +	switch (st->chip_info->chip_id) {
> +	case CHIPID_AD7193:
>  		indio_dev->channels = ad7193_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
>  		break;
> @@ -878,10 +909,10 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  }
>  
>  static const struct of_device_id ad7192_of_match[] = {
> -	{ .compatible = "adi,ad7190", .data = (void *)ID_AD7190 },
> -	{ .compatible = "adi,ad7192", .data = (void *)ID_AD7192 },
> -	{ .compatible = "adi,ad7193", .data = (void *)ID_AD7193 },
> -	{ .compatible = "adi,ad7195", .data = (void *)ID_AD7195 },
> +	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
> +	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
> +	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
> +	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ad7192_of_match);
> @@ -938,16 +969,16 @@ static int ad7192_probe(struct spi_device *spi)
>  	}
>  
>  	spi_set_drvdata(spi, indio_dev);
> -	st->devid = (unsigned long)of_device_get_match_data(&spi->dev);
> +	st->chip_info = of_device_get_match_data(&spi->dev);
>  	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->name = st->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = ad7192_channels_config(indio_dev);
>  	if (ret < 0)
>  		goto error_disable_dvdd;
>  
> -	if (st->devid == ID_AD7195)
> +	if (st->chip_info->chip_id == CHIPID_AD7195)
>  		indio_dev->info = &ad7195_info;
>  	else
>  		indio_dev->info = &ad7192_info;

