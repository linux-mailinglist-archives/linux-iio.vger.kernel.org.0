Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680F035B57B
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 15:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhDKNwp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 09:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235558AbhDKNwo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 09:52:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02EF4610A6;
        Sun, 11 Apr 2021 13:52:24 +0000 (UTC)
Date:   Sun, 11 Apr 2021 14:52:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] staging: iio: cdc: ad7746: use dt bindings to set
 the EXCx pins output
Message-ID: <20210411145245.18698d61@jic23-huawei>
In-Reply-To: <CA+U=DsqGG=NA9yHimRYuoSuBxupiqZ8JH-7FKThXj9J7D__U=A@mail.gmail.com>
References: <cover.1617993776.git.lucas.p.stankus@gmail.com>
        <39486895e4e985d0220342f3accfd98a1e149ea7.1617993776.git.lucas.p.stankus@gmail.com>
        <CA+U=Dsot+p76kaCAecN+ORdhZ_u+Bw1J8oVKZYAjoexHgiazVg@mail.gmail.com>
        <CA+U=DsqGG=NA9yHimRYuoSuBxupiqZ8JH-7FKThXj9J7D__U=A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 10 Apr 2021 19:15:39 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, Apr 10, 2021 at 7:12 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> >
> > On Fri, Apr 9, 2021 at 9:51 PM Lucas Stankus <lucas.p.stankus@gmail.com> wrote:  
> > >
> > > Ditch platform_data fields in favor of device tree properties for
> > > configuring EXCA and EXCB output.
> > > This also removes the fields from the platform_data struct, since they're
> > > not used anymore.
> > >
> > > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> > > ---
> > >  drivers/staging/iio/cdc/ad7746.c | 33 +++++++++++++++++---------------
> > >  drivers/staging/iio/cdc/ad7746.h |  4 ----
> > >  2 files changed, 18 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > > index dfd71e99e872..63041b164dbe 100644
> > > --- a/drivers/staging/iio/cdc/ad7746.c
> > > +++ b/drivers/staging/iio/cdc/ad7746.c
> > > @@ -677,8 +677,10 @@ static int ad7746_probe(struct i2c_client *client,
> > >                         const struct i2c_device_id *id)
> > >  {
> > >         struct ad7746_platform_data *pdata = client->dev.platform_data;
> > > +       struct device_node *np = client->dev.of_node;
> > >         struct ad7746_chip_info *chip;
> > >         struct iio_dev *indio_dev;
> > > +       unsigned int exca_en, excb_en;
> > >         unsigned char regval = 0;
> > >         int ret = 0;
> > >
> > > @@ -703,26 +705,27 @@ static int ad7746_probe(struct i2c_client *client,
> > >         indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
> > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > >  
> >
> > [1]
> >  
> > > -       if (pdata) {
> > > -               if (pdata->exca_en) {
> > > -                       if (pdata->exca_inv_en)
> > > -                               regval |= AD7746_EXCSETUP_NEXCA;
> > > -                       else
> > > -                               regval |= AD7746_EXCSETUP_EXCA;
> > > -               }
> > > +       ret = of_property_read_u32(np, "adi,exca-output", &exca_en);  
> >
> > maybe a better idea would be to use:
> >
> > device_property_read_u32(dev, .... )
> > where:
> > dev = client->dev.;
> >
> > this would make the driver a bit more friendly with both OF and ACPI
> >  
> > > +       if (!ret && exca_en) {
> > > +               if (exca_en == 1)
> > > +                       regval |= AD7746_EXCSETUP_EXCA;
> > > +               else
> > > +                       regval |= AD7746_EXCSETUP_NEXCA;
> > > +       }
> > >
> > > -               if (pdata->excb_en) {
> > > -                       if (pdata->excb_inv_en)
> > > -                               regval |= AD7746_EXCSETUP_NEXCB;
> > > -                       else
> > > -                               regval |= AD7746_EXCSETUP_EXCB;
> > > -               }
> > > +       ret = of_property_read_u32(np, "adi,excb-output", &excb_en);
> > > +       if (!ret && excb_en) {
> > > +               if (excb_en == 1)
> > > +                       regval |= AD7746_EXCSETUP_EXCB;
> > > +               else
> > > +                       regval |= AD7746_EXCSETUP_NEXCB;
> > > +       }
> > >
> > > +       if (pdata) {
> > >                 regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
> > >         } else {
> > >                 dev_warn(&client->dev, "No platform data? using default\n");
> > > -               regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
> > > -                       AD7746_EXCSETUP_EXCLVL(3);  
> >
> > This logic is problematic now.
> > Because no matter what you're setting in the DT, it always gets
> > overridden here because there is no platform data.
> >
> > Maybe a better idea is to do something like:
> > if (!pdata)
> >      regval = AD7746_EXCSETUP_EXCLVL(3);
> >
> > but this should be placed somewhere around [1]  
> 
> [ i can see that this logic will get corrected in the next patch]
> to add here a bit: the idea of a patch is that it should try to not
> introduce any [even temporary] breakage, even when it's in a series;
> if a driver was already broken, then it should get fixed via it's own patch;
> but no patch should introduce any breakages [if possible]

The two patches are small enough I'd be fine with them being merged into one
that avoiding any special handling.  Just add a note to the patch description
to say that it was done in one patch for this reason.

Jonathan

> 
> >
> >  
> > > +               regval = AD7746_EXCSETUP_EXCLVL(3);
> > >         }
> > >
> > >         ret = i2c_smbus_write_byte_data(chip->client,
> > > diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
> > > index 8bdbd732dbbd..6cae4ecf779e 100644
> > > --- a/drivers/staging/iio/cdc/ad7746.h
> > > +++ b/drivers/staging/iio/cdc/ad7746.h
> > > @@ -19,10 +19,6 @@
> > >
> > >  struct ad7746_platform_data {
> > >         unsigned char exclvl;   /*Excitation Voltage Level */
> > > -       bool exca_en;           /* enables EXCA pin as the excitation output */
> > > -       bool exca_inv_en;       /* enables /EXCA pin as the excitation output */
> > > -       bool excb_en;           /* enables EXCB pin as the excitation output */
> > > -       bool excb_inv_en;       /* enables /EXCB pin as the excitation output */
> > >  };
> > >
> > >  #endif /* IIO_CDC_AD7746_H_ */
> > > --
> > > 2.31.1
> > >  

