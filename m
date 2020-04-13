Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DABB1A6EDC
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 00:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbgDMWGl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389421AbgDMWGk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 18:06:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB402C0A3BDC;
        Mon, 13 Apr 2020 15:06:39 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so11129650ioj.1;
        Mon, 13 Apr 2020 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0FiT4PHNrauiWTa+TiA0HkrLQXfbRooruY9TfJ2FBA=;
        b=o/NmGIxXhgshMEuR2HpUR4QyraYu5ek6sHEYjx0ps9zKMzo4WA9pnjiSZ5rJdrW1QS
         YiWMPUV7d8tbZqqvTUfsftvGa0t/FAF1lKkcrF7GW/TDCexuTObnrj0VKefFvR/CltQi
         hAE8t1eQnsgIQUvJh31/YNEnCaVHR109Tki/xSS7qwWjcTtGtgtTxJp5+N4j1vB95pFW
         E1m/tjVhEZP1saoYCCxXcYa46NKq/hw5NZ0h40t6kHkPa2W0WHf36zaES/L9K3rHKJ42
         ucbLARpPrhdTbxmoQhK0LcGuLiWbiSXyN49HVPRLc4tcRndId9GSuaNfaEHPSuv5fhls
         lP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0FiT4PHNrauiWTa+TiA0HkrLQXfbRooruY9TfJ2FBA=;
        b=HCii78c0zAD3P7LKXbZf2/dQag2DL02OXpCA0nNsAzJv4bz6CPi7V0e45mRw1U+w5l
         vr951lxxZcFXHD5sSwZa+1X5cohokqL2BKcR2ryPvUB9JpI4kI3d7XEHZT/aihxWv1HQ
         w67b99buNCrxhocVcTGr6hX4vc4mTUn0KM7oTXDJx3kAzH5iUy0yiq4jDeEuUpmSBYdf
         e85v1EcKk1k0x7f+3JPQxKR0+h2wJbCIgHRr7yuJo+Wy5NqWI6rbvs9fkIleZUDoncaQ
         xiwISceq0hhAeQnEuLd9+E2nmwXf4f7jaGB63EX2aq9zNtnpRhkuHikDyWOnkVDsWkOc
         zjSQ==
X-Gm-Message-State: AGi0PuauWD7TbN8vrafmkGFaxVuAHjboZMi8TY7W2INH6E5/4ZDtgFAl
        WWU5c2x6RXd0Cp/l1Pa+UFVL9XzN+lw=
X-Google-Smtp-Source: APiQypJA10hi9vZqtDIsZxFJTW9fIstdbxsUyWlSF9gBdNQ6LapnqZYNirka8JSnwdWKL10XqFOUGg==
X-Received: by 2002:a5d:8152:: with SMTP id f18mr18546181ioo.74.1586815599087;
        Mon, 13 Apr 2020 15:06:39 -0700 (PDT)
Received: from r2700x.localdomain (c-67-190-64-15.hsd1.co.comcast.net. [67.190.64.15])
        by smtp.gmail.com with ESMTPSA id s6sm4320356ilk.67.2020.04.13.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 15:06:38 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:06:31 -0600
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.tachici@analog.com
Subject: Re: [PATCH v3 1/2] iio: adc: ad7192: fix null pointer de-reference
 crash during probe
Message-ID: <20200413220631.GA4884@r2700x.localdomain>
References: <20200413082044.81101-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413082044.81101-1-alexandru.ardelean@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 11:20:43AM +0300, Alexandru Ardelean wrote:
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
> ---
> 
> Changelog v2 -> v3:
> * reworked patch to introduce a chip_info struct for the part-name
> * added 2nd patch to move of-table closer to the end of the file; this
>   patch is more cosmetic; has no fixes tag, but is on top of the previous
> 
> Changelog v1 -> v2:
> * fix colon for Fixes tag
> * updated commit title a bit; to make it longer
> 
>  drivers/iio/adc/ad7192.c | 61 ++++++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 8ec28aa8fa8a..7e8662c5cb0e 100644
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
> @@ -859,11 +871,30 @@ static const struct iio_chan_spec ad7193_channels[] = {
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
> +	switch (st->chip_info->chip_id) {
>  	case ID_AD7193:

Would it be better to change this to CHIPID_AD7193? It looks like it works
the way you have it, but only by coincidence since it happens to be true
that ID_AD7193 == CHIPID_AD7193.

Jeremy

>  		indio_dev->channels = ad7193_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
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
> -- 
> 2.17.1
> 
