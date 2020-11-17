Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0142B6947
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKQQCf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 17 Nov 2020 11:02:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2123 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgKQQCe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:02:34 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb9dy45Ndz67FMm;
        Wed, 18 Nov 2020 00:00:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 17:02:27 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 16:02:27 +0000
Date:   Tue, 17 Nov 2020 16:02:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Vaishnav M A <vaishnav@beagleboard.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7887: convert driver to full DT probing
Message-ID: <20201117160218.0000274b@Huawei.com>
In-Reply-To: <CA+U=DsoXG3JderYJL8_7Vu+UYZf9jiW-tW4pRiRY3a0p-y2peg@mail.gmail.com>
References: <20201117075254.4861-1-alexandru.ardelean@analog.com>
        <20201117075254.4861-2-alexandru.ardelean@analog.com>
        <20201117110111.0000468a@Huawei.com>
        <20201117110447.0000393c@Huawei.com>
        <CA+U=DsoXG3JderYJL8_7Vu+UYZf9jiW-tW4pRiRY3a0p-y2peg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 17:03:06 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Tue, Nov 17, 2020 at 1:06 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 17 Nov 2020 11:01:11 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  
> > > On Tue, 17 Nov 2020 09:52:53 +0200
> > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > >  
> > > > This change removes the SPI device table, adds an OF device table instead.
> > > > This should also be usable for ACPI via PRP0001.
> > > >
> > > > This device is usually probed via device-tree, so it makes more sense to
> > > > use the OF device table.
> > > >
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > > So, we've had a few cases of having to put the device_id table
> > > back again recently.
> > > https://lore.kernel.org/linux-iio/20201101152613.2c37581a@archlinux/
> > >
> > > They tend to be due to greybus doing it's probing in yet another fashion.
> > > So far they've been all i2c devices, but I kind of assume it does the same for spi.
> > > https://elixir.bootlin.com/linux/latest/source/drivers/staging/greybus/spilib.c#L437
> > >
> > > How device_get_match_data() plays with that I'm not sure. It probably
> > > doesn't right now given swnode doesn't have a device_get_match_data() callback.
> > >
> > > https://elixir.bootlin.com/linux/latest/source/drivers/base/swnode.c#L539
> > >
> > > So after all that I think I've argued myself around to thinking what you have
> > > here is fine.  If someone wants to support this via a swnode then they can
> > > figure out how to make that work.
> > >
> > > +CC Vaishnav and Andy for their input.
> > >
> > > Otherwise looks fine to me.  
> >
> > Having said that.... Why are we going through this dance for driver with
> > only one compatible?   Are there other parts on their way?
> > If not, perhaps we should just rip out the matching code entirely in
> > the interests of simplicity.  
> 
> So, this one has a bit of a funny story.
> There's an AD7888 which is similar in terms of registers but with more channels.
> Lars did a patch to support it on top of AD7887:
>     https://github.com/analogdevicesinc/linux/commits/iio-ad7888
> 
> We tried to order a part for this to test the changes, but we got a
> reply that it's obsolete.
> The website says it is still in production.
> So, I was confused about the answer we got. ¯\_(ツ)_/¯
> 
> In the meantime, I thought I'd take some of the cleanup value of Lars'
> work and do the cleanup only.
> We may still find that part somewhere and maybe add it, or maybe
> another one would come along.
> I don't know at this point. I'm mostly looking at some of my backlog
> stuff and trying to cleanup old stuff.
> 
> I'm fine to simplify the driver now and add the matching bits later.

Sounds good to me.

> 
> >
> > Jonathan
> >  
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > >  
> > > > ---
> > > >  drivers/iio/adc/ad7887.c | 23 +++++++++++++++--------
> > > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> > > > index 06f684c053a0..4f68a1b17ec8 100644
> > > > --- a/drivers/iio/adc/ad7887.c
> > > > +++ b/drivers/iio/adc/ad7887.c
> > > > @@ -40,6 +40,7 @@ enum ad7887_channels {
> > > >
> > > >  /**
> > > >   * struct ad7887_chip_info - chip specifc information
> > > > + * @name:          the name of the part
> > > >   * @int_vref_mv:   the internal reference voltage
> > > >   * @channels:              channels specification
> > > >   * @num_channels:  number of channels
> > > > @@ -47,6 +48,7 @@ enum ad7887_channels {
> > > >   * @num_dual_channels:     number of channels in dual mode
> > > >   */
> > > >  struct ad7887_chip_info {
> > > > +   const char                      *name;
> > > >     u16                             int_vref_mv;
> > > >     const struct iio_chan_spec      *channels;
> > > >     unsigned int                    num_channels;
> > > > @@ -218,6 +220,7 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
> > > >      * More devices added in future
> > > >      */
> > > >     [ID_AD7887] = {
> > > > +           .name = "ad7887",
> > > >             .channels = ad7887_channels,
> > > >             .num_channels = ARRAY_SIZE(ad7887_channels),
> > > >             .dual_channels = ad7887_dual_channels,
> > > > @@ -239,12 +242,17 @@ static void ad7887_reg_disable(void *data)
> > > >
> > > >  static int ad7887_probe(struct spi_device *spi)
> > > >  {
> > > > +   const struct ad7887_chip_info *info;
> > > >     struct ad7887_state *st;
> > > >     struct iio_dev *indio_dev;
> > > >     bool dual_mode;
> > > >     uint8_t mode;
> > > >     int ret;
> > > >
> > > > +   info = device_get_match_data(&spi->dev);
> > > > +   if (!info)
> > > > +           return -ENODEV;
> > > > +
> > > >     indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > > >     if (indio_dev == NULL)
> > > >             return -ENOMEM;
> > > > @@ -269,13 +277,12 @@ static int ad7887_probe(struct spi_device *spi)
> > > >                     return ret;
> > > >     }
> > > >
> > > > -   st->chip_info =
> > > > -           &ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> > > > +   st->chip_info = info;
> > > >
> > > >     spi_set_drvdata(spi, indio_dev);
> > > >     st->spi = spi;
> > > >
> > > > -   indio_dev->name = spi_get_device_id(spi)->name;
> > > > +   indio_dev->name = st->chip_info->name;
> > > >     indio_dev->info = &ad7887_info;
> > > >     indio_dev->modes = INDIO_DIRECT_MODE;
> > > >
> > > > @@ -336,18 +343,18 @@ static int ad7887_probe(struct spi_device *spi)
> > > >     return devm_iio_device_register(&spi->dev, indio_dev);
> > > >  }
> > > >
> > > > -static const struct spi_device_id ad7887_id[] = {
> > > > -   {"ad7887", ID_AD7887},
> > > > -   {}
> > > > +static const struct of_device_id ad7887_of_match[] = {
> > > > +   { .compatible = "adi,ad7887", .data = &ad7887_chip_info_tbl[ID_AD7887] },
> > > > +   { }
> > > >  };
> > > > -MODULE_DEVICE_TABLE(spi, ad7887_id);
> > > > +MODULE_DEVICE_TABLE(of, ad7887_of_match);
> > > >
> > > >  static struct spi_driver ad7887_driver = {
> > > >     .driver = {
> > > >             .name   = "ad7887",
> > > > +           .of_match_table = ad7887_of_match,
> > > >     },
> > > >     .probe          = ad7887_probe,
> > > > -   .id_table       = ad7887_id,
> > > >  };
> > > >  module_spi_driver(ad7887_driver);
> > > >  
> > >  
> >  

