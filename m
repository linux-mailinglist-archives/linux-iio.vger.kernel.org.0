Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD52A2B682D
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 16:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgKQPDU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 10:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgKQPDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 10:03:19 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED631C0613CF;
        Tue, 17 Nov 2020 07:03:19 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r12so21442657iot.4;
        Tue, 17 Nov 2020 07:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XafKqgWOlqV0B4UFtBBC/BN1qaFCNv2WWmGeQ8KThYY=;
        b=oJsHTJ+R9YAPP9dXLGee0Lptfm4kvyzFtLHxk/drb2L6jbGaTW097adw7koMmM4yTm
         okKggpdmzNqPPM8NZdTTznMgQAPyAEVx2um1AuqjAJBiVewP0S22N+vYM512fQE5zA9X
         yLqZCtT7s6aGCMDYim7iBoNfnXx2F0q6sSvLRMyupyX/bupuvbHYo7bWQ4sZbXXUDniR
         jr8U1eRdg6pXsx5JR6PDt3nkPKlhjj7DWQbXEzWI7N0sX19VD0myGV2AZDAbnUOQiqOJ
         WlLjP4Ig1Ie6DjBQWd+KsNV5ZK7pYBOSAMXFqxlH982KORONIqw64g1YWUKVqFy0K6tT
         O7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XafKqgWOlqV0B4UFtBBC/BN1qaFCNv2WWmGeQ8KThYY=;
        b=m21RreFkb8guUvz7LJok9NtSTU0UWX8wmYb+LCJ8ctpJhtfNuNpRJrmg+fGN6PSUYs
         hGFrEJbXicRU+wXhMUAvopeyylTkfxSDMOT+qWnBVXY5wciEc4D2lxANqxPlJKt0gcdt
         ux9JzWpsdL5hzcwHaREBzG3HNlkb1RfRrUcuTLN1eHMTJHCAWQUJHnXsdY7EXi6AuU4L
         Fzg33J3bdkt9KVZibNpUuFBYK+wKwnkNQyAfrONx2oJdj7jcSSLdDvP4+UVAOzROuL9t
         BTVtzUA+yvlu0R79+hQoCPhN7HVz403sWazWlpm2V1UxhHHwzDe07A5LtiKb1r0C7ZRv
         NubA==
X-Gm-Message-State: AOAM532qDrtBk8eih5tn+YG5m6xtLPVyEEWTTfuO54BnGZSQfgW+jfDK
        ulsOqnJojyqy3eay0Z6ZDVUXW3hGU+tf1aAcgNs=
X-Google-Smtp-Source: ABdhPJzFPoCzdY6jhqL1GT/IzI+254UhNFEm2qTiXxOCMawqHX0kKAlIQfmPvhR8kvqfgsYT7Jq6tY6+OyABTQS3dtU=
X-Received: by 2002:a02:cbde:: with SMTP id u30mr4128549jaq.69.1605625398650;
 Tue, 17 Nov 2020 07:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20201117075254.4861-1-alexandru.ardelean@analog.com>
 <20201117075254.4861-2-alexandru.ardelean@analog.com> <20201117110111.0000468a@Huawei.com>
 <20201117110447.0000393c@Huawei.com>
In-Reply-To: <20201117110447.0000393c@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 17 Nov 2020 17:03:06 +0200
Message-ID: <CA+U=DsoXG3JderYJL8_7Vu+UYZf9jiW-tW4pRiRY3a0p-y2peg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7887: convert driver to full DT probing
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 17, 2020 at 1:06 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 17 Nov 2020 11:01:11 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Tue, 17 Nov 2020 09:52:53 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >
> > > This change removes the SPI device table, adds an OF device table ins=
tead.
> > > This should also be usable for ACPI via PRP0001.
> > >
> > > This device is usually probed via device-tree, so it makes more sense=
 to
> > > use the OF device table.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > So, we've had a few cases of having to put the device_id table
> > back again recently.
> > https://lore.kernel.org/linux-iio/20201101152613.2c37581a@archlinux/
> >
> > They tend to be due to greybus doing it's probing in yet another fashio=
n.
> > So far they've been all i2c devices, but I kind of assume it does the s=
ame for spi.
> > https://elixir.bootlin.com/linux/latest/source/drivers/staging/greybus/=
spilib.c#L437
> >
> > How device_get_match_data() plays with that I'm not sure. It probably
> > doesn't right now given swnode doesn't have a device_get_match_data() c=
allback.
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/base/swnode.c#L5=
39
> >
> > So after all that I think I've argued myself around to thinking what yo=
u have
> > here is fine.  If someone wants to support this via a swnode then they =
can
> > figure out how to make that work.
> >
> > +CC Vaishnav and Andy for their input.
> >
> > Otherwise looks fine to me.
>
> Having said that.... Why are we going through this dance for driver with
> only one compatible?   Are there other parts on their way?
> If not, perhaps we should just rip out the matching code entirely in
> the interests of simplicity.

So, this one has a bit of a funny story.
There's an AD7888 which is similar in terms of registers but with more chan=
nels.
Lars did a patch to support it on top of AD7887:
    https://github.com/analogdevicesinc/linux/commits/iio-ad7888

We tried to order a part for this to test the changes, but we got a
reply that it's obsolete.
The website says it is still in production.
So, I was confused about the answer we got. =C2=AF\_(=E3=83=84)_/=C2=AF

In the meantime, I thought I'd take some of the cleanup value of Lars'
work and do the cleanup only.
We may still find that part somewhere and maybe add it, or maybe
another one would come along.
I don't know at this point. I'm mostly looking at some of my backlog
stuff and trying to cleanup old stuff.

I'm fine to simplify the driver now and add the matching bits later.

>
> Jonathan
>
> >
> > Thanks,
> >
> > Jonathan
> >
> >
> > > ---
> > >  drivers/iio/adc/ad7887.c | 23 +++++++++++++++--------
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> > > index 06f684c053a0..4f68a1b17ec8 100644
> > > --- a/drivers/iio/adc/ad7887.c
> > > +++ b/drivers/iio/adc/ad7887.c
> > > @@ -40,6 +40,7 @@ enum ad7887_channels {
> > >
> > >  /**
> > >   * struct ad7887_chip_info - chip specifc information
> > > + * @name:          the name of the part
> > >   * @int_vref_mv:   the internal reference voltage
> > >   * @channels:              channels specification
> > >   * @num_channels:  number of channels
> > > @@ -47,6 +48,7 @@ enum ad7887_channels {
> > >   * @num_dual_channels:     number of channels in dual mode
> > >   */
> > >  struct ad7887_chip_info {
> > > +   const char                      *name;
> > >     u16                             int_vref_mv;
> > >     const struct iio_chan_spec      *channels;
> > >     unsigned int                    num_channels;
> > > @@ -218,6 +220,7 @@ static const struct ad7887_chip_info ad7887_chip_=
info_tbl[] =3D {
> > >      * More devices added in future
> > >      */
> > >     [ID_AD7887] =3D {
> > > +           .name =3D "ad7887",
> > >             .channels =3D ad7887_channels,
> > >             .num_channels =3D ARRAY_SIZE(ad7887_channels),
> > >             .dual_channels =3D ad7887_dual_channels,
> > > @@ -239,12 +242,17 @@ static void ad7887_reg_disable(void *data)
> > >
> > >  static int ad7887_probe(struct spi_device *spi)
> > >  {
> > > +   const struct ad7887_chip_info *info;
> > >     struct ad7887_state *st;
> > >     struct iio_dev *indio_dev;
> > >     bool dual_mode;
> > >     uint8_t mode;
> > >     int ret;
> > >
> > > +   info =3D device_get_match_data(&spi->dev);
> > > +   if (!info)
> > > +           return -ENODEV;
> > > +
> > >     indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > >     if (indio_dev =3D=3D NULL)
> > >             return -ENOMEM;
> > > @@ -269,13 +277,12 @@ static int ad7887_probe(struct spi_device *spi)
> > >                     return ret;
> > >     }
> > >
> > > -   st->chip_info =3D
> > > -           &ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_data=
];
> > > +   st->chip_info =3D info;
> > >
> > >     spi_set_drvdata(spi, indio_dev);
> > >     st->spi =3D spi;
> > >
> > > -   indio_dev->name =3D spi_get_device_id(spi)->name;
> > > +   indio_dev->name =3D st->chip_info->name;
> > >     indio_dev->info =3D &ad7887_info;
> > >     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > >
> > > @@ -336,18 +343,18 @@ static int ad7887_probe(struct spi_device *spi)
> > >     return devm_iio_device_register(&spi->dev, indio_dev);
> > >  }
> > >
> > > -static const struct spi_device_id ad7887_id[] =3D {
> > > -   {"ad7887", ID_AD7887},
> > > -   {}
> > > +static const struct of_device_id ad7887_of_match[] =3D {
> > > +   { .compatible =3D "adi,ad7887", .data =3D &ad7887_chip_info_tbl[I=
D_AD7887] },
> > > +   { }
> > >  };
> > > -MODULE_DEVICE_TABLE(spi, ad7887_id);
> > > +MODULE_DEVICE_TABLE(of, ad7887_of_match);
> > >
> > >  static struct spi_driver ad7887_driver =3D {
> > >     .driver =3D {
> > >             .name   =3D "ad7887",
> > > +           .of_match_table =3D ad7887_of_match,
> > >     },
> > >     .probe          =3D ad7887_probe,
> > > -   .id_table       =3D ad7887_id,
> > >  };
> > >  module_spi_driver(ad7887_driver);
> > >
> >
>
