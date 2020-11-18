Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4162B7DF8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Nov 2020 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKRM7v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Nov 2020 07:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRM7v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2020 07:59:51 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FD0C0613D4;
        Wed, 18 Nov 2020 04:59:51 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id i18so1903479ioa.3;
        Wed, 18 Nov 2020 04:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CMRPLfFrk+6QzoARdviru/AnhuhPI68kRr2iwSEWl3o=;
        b=ZKPYecn2+hl/ldL6LFl+1agl10CWWsYWLsculb4CYCrK0WlssjcD8H7N9foJ9hTvgx
         +RnxnZuXTrfqYHlCAl53Rny7ZFci8EcqKyWd4euEDKU16Bfvju1gQyZUGLwXPxW6yRaN
         paWJU3DrY2u04nzbF+OMMwcvPa/cQpoBf8h4PhOvYazMecMLVrZ5t+s35TjIOvVPiQtc
         PrTxPQ5g8cVDJ8gB7JCF+CHHYc4d0YH9o8Cy+7ESrNcINdKdH9HZlkM5JxU0MGXvEZmZ
         UpP/aRLFaPdBm8r8Dh5ia0155L6PuoC9Lt0+slKw54GetF1CHLBHxXG4ZI5q6DVloQ1x
         Di0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CMRPLfFrk+6QzoARdviru/AnhuhPI68kRr2iwSEWl3o=;
        b=foi4xRzl7ZkZM8tnL9frBE1tDiiKipgvK+lbEfeEcHknZalpdaP79BRIUs12YQR9W6
         WX0aWRD8pFFuq+BJaiRzUvBLkIYTp3gffcXaYmXMnm0Nk9vPvfGjZAqDpAUHjBM0HHas
         ycgXA0Wr6H20ZBhKSalTqx5PcwC8wKXmnIZhgO/RcTZNdIGJmIpDRZpJinCyeWxDePJz
         hDond0Y08k3G1Am33ULyfKgtkb4WBsBGtBHv8d8JE6jzDs8dR66JDlYIgC+UnUBDnRwV
         jV/V1VVjDS38URu3tBNwuki8U7m3/RLDwrvGQGId3imzXPbpjL+ypxPET8LM55iWrdXc
         /qjw==
X-Gm-Message-State: AOAM533bdvc8ZafE+eo3wVy9olpfhL+EvQI8m8qbsQx/WFzgZ9CIWR6B
        3dgu5XEuDHtU+0yYyPykuWfG05eWlbI9a10JOhk=
X-Google-Smtp-Source: ABdhPJylzfUKUawfsXSfwqLN2+U1IX3jW0mGgDRQWQA05GfOJU8+y8e0kvdwhL1iG4XIg0januHXGn+LIWUPPkn5Ix8=
X-Received: by 2002:a05:6602:20c7:: with SMTP id 7mr15009984ioz.170.1605704390579;
 Wed, 18 Nov 2020 04:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20201117075254.4861-1-alexandru.ardelean@analog.com>
 <20201117075254.4861-2-alexandru.ardelean@analog.com> <20201117110111.0000468a@Huawei.com>
 <20201117110447.0000393c@Huawei.com> <CA+U=DsoXG3JderYJL8_7Vu+UYZf9jiW-tW4pRiRY3a0p-y2peg@mail.gmail.com>
 <20201117160218.0000274b@Huawei.com>
In-Reply-To: <20201117160218.0000274b@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 18 Nov 2020 14:59:39 +0200
Message-ID: <CA+U=Dsqev5D_zWuLq+P3qjbYrTRYgEkCc3dEfLKp0z0nfZihVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7887: convert driver to full DT probing
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 17, 2020 at 6:02 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 17 Nov 2020 17:03:06 +0200
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
> > On Tue, Nov 17, 2020 at 1:06 PM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 17 Nov 2020 11:01:11 +0000
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >
> > > > On Tue, 17 Nov 2020 09:52:53 +0200
> > > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > > >
> > > > > This change removes the SPI device table, adds an OF device table=
 instead.
> > > > > This should also be usable for ACPI via PRP0001.
> > > > >
> > > > > This device is usually probed via device-tree, so it makes more s=
ense to
> > > > > use the OF device table.
> > > > >
> > > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > So, we've had a few cases of having to put the device_id table
> > > > back again recently.
> > > > https://lore.kernel.org/linux-iio/20201101152613.2c37581a@archlinux=
/
> > > >
> > > > They tend to be due to greybus doing it's probing in yet another fa=
shion.
> > > > So far they've been all i2c devices, but I kind of assume it does t=
he same for spi.
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/staging/grey=
bus/spilib.c#L437
> > > >
> > > > How device_get_match_data() plays with that I'm not sure. It probab=
ly
> > > > doesn't right now given swnode doesn't have a device_get_match_data=
() callback.
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/base/swnode.=
c#L539
> > > >
> > > > So after all that I think I've argued myself around to thinking wha=
t you have
> > > > here is fine.  If someone wants to support this via a swnode then t=
hey can
> > > > figure out how to make that work.
> > > >
> > > > +CC Vaishnav and Andy for their input.
> > > >
> > > > Otherwise looks fine to me.
> > >
> > > Having said that.... Why are we going through this dance for driver w=
ith
> > > only one compatible?   Are there other parts on their way?
> > > If not, perhaps we should just rip out the matching code entirely in
> > > the interests of simplicity.
> >
> > So, this one has a bit of a funny story.
> > There's an AD7888 which is similar in terms of registers but with more =
channels.
> > Lars did a patch to support it on top of AD7887:
> >     https://github.com/analogdevicesinc/linux/commits/iio-ad7888
> >
> > We tried to order a part for this to test the changes, but we got a
> > reply that it's obsolete.
> > The website says it is still in production.
> > So, I was confused about the answer we got. =C2=AF\_(=E3=83=84)_/=C2=AF
> >
> > In the meantime, I thought I'd take some of the cleanup value of Lars'
> > work and do the cleanup only.
> > We may still find that part somewhere and maybe add it, or maybe
> > another one would come along.
> > I don't know at this point. I'm mostly looking at some of my backlog
> > stuff and trying to cleanup old stuff.
> >
> > I'm fine to simplify the driver now and add the matching bits later.
>
> Sounds good to me.

I'm a bit vague on the message of this reply.
Should I simplify it or leave it as-is?

>
> >
> > >
> > > Jonathan
> > >
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >
> > > >
> > > > > ---
> > > > >  drivers/iio/adc/ad7887.c | 23 +++++++++++++++--------
> > > > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> > > > > index 06f684c053a0..4f68a1b17ec8 100644
> > > > > --- a/drivers/iio/adc/ad7887.c
> > > > > +++ b/drivers/iio/adc/ad7887.c
> > > > > @@ -40,6 +40,7 @@ enum ad7887_channels {
> > > > >
> > > > >  /**
> > > > >   * struct ad7887_chip_info - chip specifc information
> > > > > + * @name:          the name of the part
> > > > >   * @int_vref_mv:   the internal reference voltage
> > > > >   * @channels:              channels specification
> > > > >   * @num_channels:  number of channels
> > > > > @@ -47,6 +48,7 @@ enum ad7887_channels {
> > > > >   * @num_dual_channels:     number of channels in dual mode
> > > > >   */
> > > > >  struct ad7887_chip_info {
> > > > > +   const char                      *name;
> > > > >     u16                             int_vref_mv;
> > > > >     const struct iio_chan_spec      *channels;
> > > > >     unsigned int                    num_channels;
> > > > > @@ -218,6 +220,7 @@ static const struct ad7887_chip_info ad7887_c=
hip_info_tbl[] =3D {
> > > > >      * More devices added in future
> > > > >      */
> > > > >     [ID_AD7887] =3D {
> > > > > +           .name =3D "ad7887",
> > > > >             .channels =3D ad7887_channels,
> > > > >             .num_channels =3D ARRAY_SIZE(ad7887_channels),
> > > > >             .dual_channels =3D ad7887_dual_channels,
> > > > > @@ -239,12 +242,17 @@ static void ad7887_reg_disable(void *data)
> > > > >
> > > > >  static int ad7887_probe(struct spi_device *spi)
> > > > >  {
> > > > > +   const struct ad7887_chip_info *info;
> > > > >     struct ad7887_state *st;
> > > > >     struct iio_dev *indio_dev;
> > > > >     bool dual_mode;
> > > > >     uint8_t mode;
> > > > >     int ret;
> > > > >
> > > > > +   info =3D device_get_match_data(&spi->dev);
> > > > > +   if (!info)
> > > > > +           return -ENODEV;
> > > > > +
> > > > >     indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > > > >     if (indio_dev =3D=3D NULL)
> > > > >             return -ENOMEM;
> > > > > @@ -269,13 +277,12 @@ static int ad7887_probe(struct spi_device *=
spi)
> > > > >                     return ret;
> > > > >     }
> > > > >
> > > > > -   st->chip_info =3D
> > > > > -           &ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_=
data];
> > > > > +   st->chip_info =3D info;
> > > > >
> > > > >     spi_set_drvdata(spi, indio_dev);
> > > > >     st->spi =3D spi;
> > > > >
> > > > > -   indio_dev->name =3D spi_get_device_id(spi)->name;
> > > > > +   indio_dev->name =3D st->chip_info->name;
> > > > >     indio_dev->info =3D &ad7887_info;
> > > > >     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > >
> > > > > @@ -336,18 +343,18 @@ static int ad7887_probe(struct spi_device *=
spi)
> > > > >     return devm_iio_device_register(&spi->dev, indio_dev);
> > > > >  }
> > > > >
> > > > > -static const struct spi_device_id ad7887_id[] =3D {
> > > > > -   {"ad7887", ID_AD7887},
> > > > > -   {}
> > > > > +static const struct of_device_id ad7887_of_match[] =3D {
> > > > > +   { .compatible =3D "adi,ad7887", .data =3D &ad7887_chip_info_t=
bl[ID_AD7887] },
> > > > > +   { }
> > > > >  };
> > > > > -MODULE_DEVICE_TABLE(spi, ad7887_id);
> > > > > +MODULE_DEVICE_TABLE(of, ad7887_of_match);
> > > > >
> > > > >  static struct spi_driver ad7887_driver =3D {
> > > > >     .driver =3D {
> > > > >             .name   =3D "ad7887",
> > > > > +           .of_match_table =3D ad7887_of_match,
> > > > >     },
> > > > >     .probe          =3D ad7887_probe,
> > > > > -   .id_table       =3D ad7887_id,
> > > > >  };
> > > > >  module_spi_driver(ad7887_driver);
> > > > >
> > > >
> > >
>
