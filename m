Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE0225D92
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 13:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgGTLkq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 07:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgGTLkp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 07:40:45 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F3C061794;
        Mon, 20 Jul 2020 04:40:45 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so11883013otv.6;
        Mon, 20 Jul 2020 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAUX8js4HRTNIEB/e+TDgl4jAut/dSAHvoJrfuW4RUk=;
        b=fpARwnel7o+8D9zi/yqJwccr8VdQHwVuuWEfgMtFBzchyLBu1R1R4ewBLhzey2S5Yo
         U6n08gPnYVl1FGcSwONy/mASFE957/YQlgDiD0NKWSlEN1YCrP/p1zih6hrPzDOC6HkC
         XG0OdBI3y/n8JY+o7lG9jxz+Tw94JekscESYCoRrjhSHgcJPZEguyU8FOYr++WcePZT6
         N3lqcJX6v5DKsGP1DdBfwl+v1sQ+etP7rm6x2gMV7UkQN82g3rdT6+cPsn9Nwj5o6HQ+
         iJhvPwqxzz/qhEhrIZTtk4W1XHaLos4z37cFGqtUHcmwdCXLtBrwrYe5I/wmBD7qX/7h
         XE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAUX8js4HRTNIEB/e+TDgl4jAut/dSAHvoJrfuW4RUk=;
        b=eyiEKAshJPzHKg1Nz16dYDN2sm4Df6lTlKbP4QVYi042icIITwqaqeFMgc9XPBs+tW
         FOCU8voQQ3wJMTKKbDh/LbyuLx/2W2LyqXNgV6sHA5fYpoZZsbvwM9TnnoDwuehRrQPO
         mHLoBJ/dSeHG3fW9aE2CwKeWnzKI6Yix73nnG8TOnA6xXDBzvjOLGwyIepnGN4rkYhYs
         COMxD50gYkzLHn/MRiQShWn6ZsM8/J73Iwh6FkvqIAcvAOuyIsuMtqF9NDHnufHX3nUM
         iHgtIRqqXZRreyAuhzaCO0b8M8vDsWMy8BCQvXrsNp59P2wrAXshHSl5N4UWAm3ERBY2
         CJyg==
X-Gm-Message-State: AOAM532n/7pLQSP3emybExNyBOitUmrxJv9HDGYJSOD6FshZRk2MZt3W
        hkbI3I2PBSxDFAvi0PNbIz5DE99mXkz3O/oTTzc=
X-Google-Smtp-Source: ABdhPJxViFlAHBGoX3IHKpT8S1+2gECbLDMmGWvvpuRb1tbGtN7COvBruE1BhiXvI6dUDLtiuFdjW9TnDbzjh1oJXYE=
X-Received: by 2002:a9d:480d:: with SMTP id c13mr20072257otf.224.1595245244703;
 Mon, 20 Jul 2020 04:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200714051111.17892-1-alexandru.ardelean@analog.com> <20200720122947.7c3cfc6e@archlinux>
In-Reply-To: <20200720122947.7c3cfc6e@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 Jul 2020 14:40:33 +0300
Message-ID: <CA+U=DsoLh94p6XhMZDjDWcUEG7MiD4suPeXySkKpUVJCSamdhg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: move chip ID & name on the chip_info table
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 20, 2020 at 2:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 14 Jul 2020 08:11:11 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This change does the following:
> > * removes the SPI device table in favor of the OF device table
> > * adds 'name' && 'chip_id' fields to chip_info
> > * implements chip ID & silicon revision checking; the device ID for
> >   AD7124-4 is 0x0, so just checking that value can be useless;
> >   but at least the silicon revision isn't 0, so a non-zero value can be
> >   used to check that "a" device is on the SPI bus; it's probably the best
> >   way to narrow it down to one of the 2 AD7124 chip IDs
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Nice patch.
>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the auto builders to play with it.
>
> At somepoint we could think about moving this driver over to generic
> fw interfaces, but that is a bigger job and no particular reason to
> do that now (if it's even possible!)

That's also on my list [for the ADI drivers].
Need to find someone to delegate to, since it will take a while before
I can get to it.

>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/ad7124.c | 73 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 59 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index bb53ab265b64..8dce06e9e69c 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/of_device.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> >
> > @@ -47,6 +48,15 @@
> >  #define AD7124_ADC_CTRL_MODE_MSK     GENMASK(5, 2)
> >  #define AD7124_ADC_CTRL_MODE(x)      FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
> >
> > +/* AD7124 ID */
> > +#define AD7124_DEVICE_ID_MSK         GENMASK(7, 4)
> > +#define AD7124_DEVICE_ID_GET(x)              FIELD_GET(AD7124_DEVICE_ID_MSK, x)
> > +#define AD7124_SILICON_REV_MSK               GENMASK(3, 0)
> > +#define AD7124_SILICON_REV_GET(x)    FIELD_GET(AD7124_SILICON_REV_MSK, x)
> > +
> > +#define CHIPID_AD7124_4                      0x0
> > +#define CHIPID_AD7124_8                      0x1
> > +
> >  /* AD7124_CHANNEL_X */
> >  #define AD7124_CHANNEL_EN_MSK                BIT(15)
> >  #define AD7124_CHANNEL_EN(x)         FIELD_PREP(AD7124_CHANNEL_EN_MSK, x)
> > @@ -120,6 +130,8 @@ static const char * const ad7124_ref_names[] = {
> >  };
> >
> >  struct ad7124_chip_info {
> > +     const char *name;
> > +     unsigned int chip_id;
> >       unsigned int num_inputs;
> >  };
> >
> > @@ -165,9 +177,13 @@ static const struct iio_chan_spec ad7124_channel_template = {
> >
> >  static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
> >       [ID_AD7124_4] = {
> > +             .name = "ad7127-4",
> > +             .chip_id = CHIPID_AD7124_4,
> >               .num_inputs = 8,
> >       },
> >       [ID_AD7124_8] = {
> > +             .name = "ad7127-8",
> > +             .chip_id = CHIPID_AD7124_8,
> >               .num_inputs = 16,
> >       },
> >  };
> > @@ -503,6 +519,34 @@ static int ad7124_soft_reset(struct ad7124_state *st)
> >       return -EIO;
> >  }
> >
> > +static int ad7124_check_chip_id(struct ad7124_state *st)
> > +{
> > +     unsigned int readval, chip_id, silicon_rev;
> > +     int ret;
> > +
> > +     ret = ad_sd_read_reg(&st->sd, AD7124_ID, 1, &readval);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     chip_id = AD7124_DEVICE_ID_GET(readval);
> > +     silicon_rev = AD7124_SILICON_REV_GET(readval);
> > +
> > +     if (chip_id != st->chip_info->chip_id) {
> > +             dev_err(&st->sd.spi->dev,
> > +                     "Chip ID mismatch: expected %u, got %u\n",
> > +                     st->chip_info->chip_id, chip_id);
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (silicon_rev == 0) {
> > +             dev_err(&st->sd.spi->dev,
> > +                     "Silicon revision empty. Chip may not be present\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int ad7124_init_channel_vref(struct ad7124_state *st,
> >                                   unsigned int channel_number)
> >  {
> > @@ -665,25 +709,28 @@ static int ad7124_setup(struct ad7124_state *st)
> >
> >  static int ad7124_probe(struct spi_device *spi)
> >  {
> > -     const struct spi_device_id *id;
> > +     const struct ad7124_chip_info *info;
> >       struct ad7124_state *st;
> >       struct iio_dev *indio_dev;
> >       int i, ret;
> >
> > +     info = of_device_get_match_data(&spi->dev);
> > +     if (!info)
> > +             return -ENODEV;
> > +
> >       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >       if (!indio_dev)
> >               return -ENOMEM;
> >
> >       st = iio_priv(indio_dev);
> >
> > -     id = spi_get_device_id(spi);
> > -     st->chip_info = &ad7124_chip_info_tbl[id->driver_data];
> > +     st->chip_info = info;
> >
> >       ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
> >
> >       spi_set_drvdata(spi, indio_dev);
> >
> > -     indio_dev->name = spi_get_device_id(spi)->name;
> > +     indio_dev->name = st->chip_info->name;
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >       indio_dev->info = &ad7124_info;
> >
> > @@ -721,6 +768,10 @@ static int ad7124_probe(struct spi_device *spi)
> >       if (ret < 0)
> >               goto error_clk_disable_unprepare;
> >
> > +     ret = ad7124_check_chip_id(st);
> > +     if (ret)
> > +             goto error_clk_disable_unprepare;
> > +
> >       ret = ad7124_setup(st);
> >       if (ret < 0)
> >               goto error_clk_disable_unprepare;
> > @@ -768,16 +819,11 @@ static int ad7124_remove(struct spi_device *spi)
> >       return 0;
> >  }
> >
> > -static const struct spi_device_id ad7124_id_table[] = {
> > -     { "ad7124-4", ID_AD7124_4 },
> > -     { "ad7124-8", ID_AD7124_8 },
> > -     {}
> > -};
> > -MODULE_DEVICE_TABLE(spi, ad7124_id_table);
> > -
> >  static const struct of_device_id ad7124_of_match[] = {
> > -     { .compatible = "adi,ad7124-4" },
> > -     { .compatible = "adi,ad7124-8" },
> > +     { .compatible = "adi,ad7124-4",
> > +             .data = &ad7124_chip_info_tbl[ID_AD7124_4], },
> > +     { .compatible = "adi,ad7124-8",
> > +             .data = &ad7124_chip_info_tbl[ID_AD7124_8], },
> >       { },
> >  };
> >  MODULE_DEVICE_TABLE(of, ad7124_of_match);
> > @@ -789,7 +835,6 @@ static struct spi_driver ad71124_driver = {
> >       },
> >       .probe = ad7124_probe,
> >       .remove = ad7124_remove,
> > -     .id_table = ad7124_id_table,
> >  };
> >  module_spi_driver(ad71124_driver);
> >
>
