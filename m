Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671A81A8800
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgDNRya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 13:54:30 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56986 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgDNRy1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 13:54:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8EDD29E7402;
        Tue, 14 Apr 2020 18:54:19 +0100 (BST)
Date:   Tue, 14 Apr 2020 18:54:16 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.tachici@analog.com
Subject: Re: [PATCH v3 1/2] iio: adc: ad7192: fix null pointer de-reference
 crash during probe
Message-ID: <20200414185416.098062f7@archlinux>
In-Reply-To: <20200413220631.GA4884@r2700x.localdomain>
References: <20200413082044.81101-1-alexandru.ardelean@analog.com>
        <20200413220631.GA4884@r2700x.localdomain>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 16:06:31 -0600
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> On Mon, Apr 13, 2020 at 11:20:43AM +0300, Alexandru Ardelean wrote:
> > When the 'spi_device_id' table was removed, it omitted to cleanup/fix the
> > assignment:
> >    'indio_dev->name = spi_get_device_id(spi)->name;'
> > 
> > After that patch 'spi_get_device_id(spi)' returns NULL, so this crashes
> > during probe with null de-ref.
> > 
> > This change fixes this by introducing an ad7192_chip_info struct, and
> > defines all part-names [that should be assigned to indio_dev->name] in a
> > 'ad7192_chip_info_tbl' table.
> > 
> > With this change, the old 'st->devid' is also moved to be a
> > 'chip_info->chip_id'. And the old 'ID_AD719X' macros have been renamed to
> > 'CHIPID_AD719X'. Tld identifiers have been re-purposed to be enum/index
> > values in the new 'ad7192_chip_info_tbl'.
> > 
> > This should fix the bug, and maintain the ABI for the 'indio_dev->name'
> > field.
> > 
> > Fixes: 66614ab2be38 ("staging: iio: adc: ad7192: removed spi_device_id")
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> > 
> > Changelog v2 -> v3:
> > * reworked patch to introduce a chip_info struct for the part-name
> > * added 2nd patch to move of-table closer to the end of the file; this
> >   patch is more cosmetic; has no fixes tag, but is on top of the previous
> > 
> > Changelog v1 -> v2:
> > * fix colon for Fixes tag
> > * updated commit title a bit; to make it longer
> > 
> >  drivers/iio/adc/ad7192.c | 61 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 46 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 8ec28aa8fa8a..7e8662c5cb0e 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -125,10 +125,10 @@
> >  #define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
> >  
> >  /* ID Register Bit Designations (AD7192_REG_ID) */
> > -#define ID_AD7190		0x4
> > -#define ID_AD7192		0x0
> > -#define ID_AD7193		0x2
> > -#define ID_AD7195		0x6
> > +#define CHIPID_AD7190		0x4
> > +#define CHIPID_AD7192		0x0
> > +#define CHIPID_AD7193		0x2
> > +#define CHIPID_AD7195		0x6
> >  #define AD7192_ID_MASK		0x0F
> >  
> >  /* GPOCON Register Bit Designations (AD7192_REG_GPOCON) */
> > @@ -161,7 +161,20 @@ enum {
> >     AD7192_SYSCALIB_FULL_SCALE,
> >  };
> >  
> > +enum {
> > +	ID_AD7190,
> > +	ID_AD7192,
> > +	ID_AD7193,
> > +	ID_AD7195,
> > +};
> > +
> > +struct ad7192_chip_info {
> > +	unsigned int			chip_id;
> > +	const char			*name;
> > +};
> > +
> >  struct ad7192_state {
> > +	const struct ad7192_chip_info	*chip_info;
> >  	struct regulator		*avdd;
> >  	struct regulator		*dvdd;
> >  	struct clk			*mclk;
> > @@ -172,7 +185,6 @@ struct ad7192_state {
> >  	u32				conf;
> >  	u32				scale_avail[8][2];
> >  	u8				gpocon;
> > -	u8				devid;
> >  	u8				clock_sel;
> >  	struct mutex			lock;	/* protect sensor state */
> >  	u8				syscalib_mode[8];
> > @@ -348,7 +360,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
> >  
> >  	id &= AD7192_ID_MASK;
> >  
> > -	if (id != st->devid)
> > +	if (id != st->chip_info->chip_id)
> >  		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
> >  			 id);
> >  
> > @@ -363,7 +375,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
> >  		st->mode |= AD7192_MODE_REJ60;
> >  
> >  	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
> > -	if (refin2_en && st->devid != ID_AD7195)
> > +	if (refin2_en && st->chip_info->chip_id != CHIPID_AD7195)
> >  		st->conf |= AD7192_CONF_REFSEL;
> >  
> >  	st->conf &= ~AD7192_CONF_CHOP;
> > @@ -859,11 +871,30 @@ static const struct iio_chan_spec ad7193_channels[] = {
> >  	IIO_CHAN_SOFT_TIMESTAMP(14),
> >  };
> >  
> > +static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
> > +	[ID_AD7190] = {
> > +		.chip_id = CHIPID_AD7190,
> > +		.name = "ad7190",
> > +	},
> > +	[ID_AD7192] = {
> > +		.chip_id = CHIPID_AD7192,
> > +		.name = "ad7192",
> > +	},
> > +	[ID_AD7193] = {
> > +		.chip_id = CHIPID_AD7193,
> > +		.name = "ad7193",
> > +	},
> > +	[ID_AD7195] = {
> > +		.chip_id = CHIPID_AD7195,
> > +		.name = "ad7195",
> > +	},
> > +};
> > +
> >  static int ad7192_channels_config(struct iio_dev *indio_dev)
> >  {
> >  	struct ad7192_state *st = iio_priv(indio_dev);
> >  
> > -	switch (st->devid) {
> > +	switch (st->chip_info->chip_id) {
> >  	case ID_AD7193:  
> 
> Would it be better to change this to CHIPID_AD7193? It looks like it works
> the way you have it, but only by coincidence since it happens to be true
> that ID_AD7193 == CHIPID_AD7193.
>
dropped patch from my fixes branch whilst this is resolved!

Thanks,

Jonathan
 
> Jeremy
> 
> >  		indio_dev->channels = ad7193_channels;
> >  		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
> > @@ -878,10 +909,10 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
> >  }
> >  
> >  static const struct of_device_id ad7192_of_match[] = {
> > -	{ .compatible = "adi,ad7190", .data = (void *)ID_AD7190 },
> > -	{ .compatible = "adi,ad7192", .data = (void *)ID_AD7192 },
> > -	{ .compatible = "adi,ad7193", .data = (void *)ID_AD7193 },
> > -	{ .compatible = "adi,ad7195", .data = (void *)ID_AD7195 },
> > +	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
> > +	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
> > +	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
> > +	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, ad7192_of_match);
> > @@ -938,16 +969,16 @@ static int ad7192_probe(struct spi_device *spi)
> >  	}
> >  
> >  	spi_set_drvdata(spi, indio_dev);
> > -	st->devid = (unsigned long)of_device_get_match_data(&spi->dev);
> > +	st->chip_info = of_device_get_match_data(&spi->dev);
> >  	indio_dev->dev.parent = &spi->dev;
> > -	indio_dev->name = spi_get_device_id(spi)->name;
> > +	indio_dev->name = st->chip_info->name;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> >  	ret = ad7192_channels_config(indio_dev);
> >  	if (ret < 0)
> >  		goto error_disable_dvdd;
> >  
> > -	if (st->devid == ID_AD7195)
> > +	if (st->chip_info->chip_id == CHIPID_AD7195)
> >  		indio_dev->info = &ad7195_info;
> >  	else
> >  		indio_dev->info = &ad7192_info;
> > -- 
> > 2.17.1
> >   

