Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1793D35B575
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhDKNvF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 11 Apr 2021 09:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236084AbhDKNuw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 09:50:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3845610CB;
        Sun, 11 Apr 2021 13:50:33 +0000 (UTC)
Date:   Sun, 11 Apr 2021 14:50:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] staging: iio: cdc: ad7746: use dt bindings to set
 the EXCx pins output
Message-ID: <20210411145055.1a713319@jic23-huawei>
In-Reply-To: <CAHp75VcMsMvSrbP3tkcivvd+s=8drqiCt-xmk+HxhLS87w6zYw@mail.gmail.com>
References: <cover.1617993776.git.lucas.p.stankus@gmail.com>
        <39486895e4e985d0220342f3accfd98a1e149ea7.1617993776.git.lucas.p.stankus@gmail.com>
        <CAHp75Ve2NBMyQf7jw63a=4r135ShGEoRjZ+CUr36DC+gH39d7A@mail.gmail.com>
        <CAHp75VcMsMvSrbP3tkcivvd+s=8drqiCt-xmk+HxhLS87w6zYw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 10 Apr 2021 13:05:14 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Saturday, April 10, 2021, Andy Shevchenko <andy.shevchenko@gmail.com>
> wrote:
> 
> >
> >
> > On Friday, April 9, 2021, Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
> >  
> >> Ditch platform_data fields in favor of device tree properties for
> >> configuring EXCA and EXCB output.
> >> This also removes the fields from the platform_data struct, since they're
> >> not used anymore.  
> >
> >
> > As far as I read the old code it’s possible to leave pins untouched, not
> > anymore the case after this patch. What datasheet tells about it? Please
> > elaborate in the commit message and add a Datasheet: tag as a reference.
> >
> >
> >  

Default is to have them disabled, so if you switch to separate -en
vs -invert lack of either will correspond to the power on default
and simplify things somewhat.

> 
> Okay, I see now. But can you simple use switch case or so, because
> currently code is not so understandable from the first glance?
> 
> 
> 
> >  
> >> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> >> ---
> >>  drivers/staging/iio/cdc/ad7746.c | 33 +++++++++++++++++---------------
> >>  drivers/staging/iio/cdc/ad7746.h |  4 ----
> >>  2 files changed, 18 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/staging/iio/cdc/ad7746.c
> >> b/drivers/staging/iio/cdc/ad7746.c
> >> index dfd71e99e872..63041b164dbe 100644
> >> --- a/drivers/staging/iio/cdc/ad7746.c
> >> +++ b/drivers/staging/iio/cdc/ad7746.c
> >> @@ -677,8 +677,10 @@ static int ad7746_probe(struct i2c_client *client,
> >>                         const struct i2c_device_id *id)
> >>  {
> >>         struct ad7746_platform_data *pdata = client->dev.platform_data;
> >> +       struct device_node *np = client->dev.of_node;
> >>         struct ad7746_chip_info *chip;
> >>         struct iio_dev *indio_dev;
> >> +       unsigned int exca_en, excb_en;
> >>         unsigned char regval = 0;
> >>         int ret = 0;
> >>
> >> @@ -703,26 +705,27 @@ static int ad7746_probe(struct i2c_client *client,
> >>         indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
> >>         indio_dev->modes = INDIO_DIRECT_MODE;
> >>
> >> -       if (pdata) {
> >> -               if (pdata->exca_en) {
> >> -                       if (pdata->exca_inv_en)
> >> -                               regval |= AD7746_EXCSETUP_NEXCA;
> >> -                       else
> >> -                               regval |= AD7746_EXCSETUP_EXCA;
> >> -               }
> >> +       ret = of_property_read_u32(np, "adi,exca-output", &exca_en);
> >> +       if (!ret && exca_en) {
> >> +               if (exca_en == 1)
> >> +                       regval |= AD7746_EXCSETUP_EXCA;
> >> +               else
> >> +                       regval |= AD7746_EXCSETUP_NEXCA;
> >> +       }
> >>
> >> -               if (pdata->excb_en) {
> >> -                       if (pdata->excb_inv_en)
> >> -                               regval |= AD7746_EXCSETUP_NEXCB;
> >> -                       else
> >> -                               regval |= AD7746_EXCSETUP_EXCB;
> >> -               }
> >> +       ret = of_property_read_u32(np, "adi,excb-output", &excb_en);
> >> +       if (!ret && excb_en) {
> >> +               if (excb_en == 1)
> >> +                       regval |= AD7746_EXCSETUP_EXCB;
> >> +               else
> >> +                       regval |= AD7746_EXCSETUP_NEXCB;
> >> +       }
> >>
> >> +       if (pdata) {
> >>                 regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
> >>         } else {
> >>                 dev_warn(&client->dev, "No platform data? using
> >> default\n");
> >> -               regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
> >> -                       AD7746_EXCSETUP_EXCLVL(3);
> >> +               regval = AD7746_EXCSETUP_EXCLVL(3);
> >>         }
> >>
> >>         ret = i2c_smbus_write_byte_data(chip->client,
> >> diff --git a/drivers/staging/iio/cdc/ad7746.h
> >> b/drivers/staging/iio/cdc/ad7746.h
> >> index 8bdbd732dbbd..6cae4ecf779e 100644
> >> --- a/drivers/staging/iio/cdc/ad7746.h
> >> +++ b/drivers/staging/iio/cdc/ad7746.h
> >> @@ -19,10 +19,6 @@
> >>
> >>  struct ad7746_platform_data {
> >>         unsigned char exclvl;   /*Excitation Voltage Level */
> >> -       bool exca_en;           /* enables EXCA pin as the excitation
> >> output */
> >> -       bool exca_inv_en;       /* enables /EXCA pin as the excitation
> >> output */
> >> -       bool excb_en;           /* enables EXCB pin as the excitation
> >> output */
> >> -       bool excb_inv_en;       /* enables /EXCB pin as the excitation
> >> output */
> >>  };
> >>
> >>  #endif /* IIO_CDC_AD7746_H_ */
> >> --
> >> 2.31.1
> >>
> >>  
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
> >  
> 

