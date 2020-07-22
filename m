Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F562291B0
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgGVHHb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 03:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGVHHb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 03:07:31 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AAAC061794;
        Wed, 22 Jul 2020 00:07:31 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 72so1066098otc.3;
        Wed, 22 Jul 2020 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dh6dVjsRMRYNgNmQWpE0spVjcT9KgLjg+zq3EGZMSmc=;
        b=XqcMsKq6xDHcqAfYS18glD5uFjSENlzN4cfLHlxyaNoX19sdAVlDUopb+rlDwFRCru
         JFoEI/LnjPu2LFnF0YtKT/1h7CNRyfArMUmZet4DGN5j5HCKrSf2LS9kGHhw2b1KlyCw
         5x5h5HlLZA4umsVAFmi8MXpZ6gpf5O7N5RwyCkAUq8XnDruR4UxHcHc4KsxLrP/IsMbo
         Rwq42IAsWdMdUMSYz5lb3ikbYqseAjwJn0LOkS13+mFkifj5GbQEiVPwfQ/tIe3XjwRz
         UXsTCqTjxAaP4I5NmEMRCH3EaKCkv0HajnKZYz1qFt/qLXihjk4lpG/pRJSwcEHVOH5o
         v3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dh6dVjsRMRYNgNmQWpE0spVjcT9KgLjg+zq3EGZMSmc=;
        b=th5rDsC14rfRpzHINY/9lqAl7uF6b/cvs5Dg5KW5tpPXmaSi6k3HBp0phdVFNdcdan
         q9bRhVxTlpXMDr2BQgiNK51QVD6c4bHGQbjVI1spVWjortFILcyn+nuYz6f+SRXLvp2t
         koM25AuPjyWf+pzUkua1TAqB4am/IxnDMRHtI3cxXV+DYIsL8g/Z+X/QfV7OKvtn/KF5
         BJ07ROAxcjSydNxpb8wkiPvMfbUmYJ3GGk8CpIY/T/1JXtahD7yn1iygNBNdgcWg/8jT
         L4tuWBhTpZuSY7kk6o4ohMN3r2blCWGb8oIvVUFL85sj4IOWMoTr6WPSig3cTgF492CD
         lASw==
X-Gm-Message-State: AOAM531SVhBNkvkj3jxq+ePHG362yjnWKUYrkfdIi+EzzEw7w4gf228+
        YhPTLLvaEe4lwExziQQmisSNzi0dquO5cLaDb80=
X-Google-Smtp-Source: ABdhPJxOx5CB7kACn3jmTlDLOQx5+wH96jW6FTzijnBaQk2R1nBPG4QASYA92QNA0iwrBJ6IVm/bLp7UZ+F/bH5Jo+M=
X-Received: by 2002:a05:6830:19eb:: with SMTP id t11mr26933323ott.207.1595401650292;
 Wed, 22 Jul 2020 00:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200714051111.17892-1-alexandru.ardelean@analog.com>
 <20200720122947.7c3cfc6e@archlinux> <CAHp75VcRKQWuQrNw6CBENH6Cdu+TdAzZqir_RQZcCQFxQ0Qd2g@mail.gmail.com>
In-Reply-To: <CAHp75VcRKQWuQrNw6CBENH6Cdu+TdAzZqir_RQZcCQFxQ0Qd2g@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 22 Jul 2020 10:07:19 +0300
Message-ID: <CA+U=DspLgzdsCXXWM+6dHz0+A+zE=uzdQMWq9OXzcAFVWwrXCg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: move chip ID & name on the chip_info table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 9:41 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jul 20, 2020 at 2:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 14 Jul 2020 08:11:11 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >
> > > This change does the following:
> > > * removes the SPI device table in favor of the OF device table
> > > * adds 'name' && 'chip_id' fields to chip_info
> > > * implements chip ID & silicon revision checking; the device ID for
> > >   AD7124-4 is 0x0, so just checking that value can be useless;
> > >   but at least the silicon revision isn't 0, so a non-zero value can be
> > >   used to check that "a" device is on the SPI bus; it's probably the best
> > >   way to narrow it down to one of the 2 AD7124 chip IDs
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Nice patch.
>
> Doesn't this patch bring an opposite to what you are trying to clean up, i.e.
> of_get_match_data(), of_device.h?

A bit.
I usually want to try to make things both OF & ACPI friendly, but I
mostly have OF devices to test with and that creates a bit of habit to
go for OF-first.
I'll hopefully get to do more of these [OF & ACPI friendly] cleanups
at some point.
But until then, I have a list of IIO framework changes to do with
regards to output-buffer support.
And I noticed that if I look at trying to do too many things at once I
end up fixing bugs like this:
https://patchwork.kernel.org/patch/11675339/

>
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > the auto builders to play with it.
> >
> > At somepoint we could think about moving this driver over to generic
> > fw interfaces, but that is a bigger job and no particular reason to
> > do that now (if it's even possible!)
> >
> > Thanks,
> >
> > Jonathan
> >
> > > ---
> > >  drivers/iio/adc/ad7124.c | 73 ++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 59 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > > index bb53ab265b64..8dce06e9e69c 100644
> > > --- a/drivers/iio/adc/ad7124.c
> > > +++ b/drivers/iio/adc/ad7124.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/interrupt.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/spi/spi.h>
> > >
> > > @@ -47,6 +48,15 @@
> > >  #define AD7124_ADC_CTRL_MODE_MSK     GENMASK(5, 2)
> > >  #define AD7124_ADC_CTRL_MODE(x)      FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
> > >
> > > +/* AD7124 ID */
> > > +#define AD7124_DEVICE_ID_MSK         GENMASK(7, 4)
> > > +#define AD7124_DEVICE_ID_GET(x)              FIELD_GET(AD7124_DEVICE_ID_MSK, x)
> > > +#define AD7124_SILICON_REV_MSK               GENMASK(3, 0)
> > > +#define AD7124_SILICON_REV_GET(x)    FIELD_GET(AD7124_SILICON_REV_MSK, x)
> > > +
> > > +#define CHIPID_AD7124_4                      0x0
> > > +#define CHIPID_AD7124_8                      0x1
> > > +
> > >  /* AD7124_CHANNEL_X */
> > >  #define AD7124_CHANNEL_EN_MSK                BIT(15)
> > >  #define AD7124_CHANNEL_EN(x)         FIELD_PREP(AD7124_CHANNEL_EN_MSK, x)
> > > @@ -120,6 +130,8 @@ static const char * const ad7124_ref_names[] = {
> > >  };
> > >
> > >  struct ad7124_chip_info {
> > > +     const char *name;
> > > +     unsigned int chip_id;
> > >       unsigned int num_inputs;
> > >  };
> > >
> > > @@ -165,9 +177,13 @@ static const struct iio_chan_spec ad7124_channel_template = {
> > >
> > >  static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
> > >       [ID_AD7124_4] = {
> > > +             .name = "ad7127-4",
> > > +             .chip_id = CHIPID_AD7124_4,
> > >               .num_inputs = 8,
> > >       },
> > >       [ID_AD7124_8] = {
> > > +             .name = "ad7127-8",
> > > +             .chip_id = CHIPID_AD7124_8,
> > >               .num_inputs = 16,
> > >       },
> > >  };
> > > @@ -503,6 +519,34 @@ static int ad7124_soft_reset(struct ad7124_state *st)
> > >       return -EIO;
> > >  }
> > >
> > > +static int ad7124_check_chip_id(struct ad7124_state *st)
> > > +{
> > > +     unsigned int readval, chip_id, silicon_rev;
> > > +     int ret;
> > > +
> > > +     ret = ad_sd_read_reg(&st->sd, AD7124_ID, 1, &readval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     chip_id = AD7124_DEVICE_ID_GET(readval);
> > > +     silicon_rev = AD7124_SILICON_REV_GET(readval);
> > > +
> > > +     if (chip_id != st->chip_info->chip_id) {
> > > +             dev_err(&st->sd.spi->dev,
> > > +                     "Chip ID mismatch: expected %u, got %u\n",
> > > +                     st->chip_info->chip_id, chip_id);
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     if (silicon_rev == 0) {
> > > +             dev_err(&st->sd.spi->dev,
> > > +                     "Silicon revision empty. Chip may not be present\n");
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int ad7124_init_channel_vref(struct ad7124_state *st,
> > >                                   unsigned int channel_number)
> > >  {
> > > @@ -665,25 +709,28 @@ static int ad7124_setup(struct ad7124_state *st)
> > >
> > >  static int ad7124_probe(struct spi_device *spi)
> > >  {
> > > -     const struct spi_device_id *id;
> > > +     const struct ad7124_chip_info *info;
> > >       struct ad7124_state *st;
> > >       struct iio_dev *indio_dev;
> > >       int i, ret;
> > >
> > > +     info = of_device_get_match_data(&spi->dev);
> > > +     if (!info)
> > > +             return -ENODEV;
> > > +
> > >       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > >       if (!indio_dev)
> > >               return -ENOMEM;
> > >
> > >       st = iio_priv(indio_dev);
> > >
> > > -     id = spi_get_device_id(spi);
> > > -     st->chip_info = &ad7124_chip_info_tbl[id->driver_data];
> > > +     st->chip_info = info;
> > >
> > >       ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
> > >
> > >       spi_set_drvdata(spi, indio_dev);
> > >
> > > -     indio_dev->name = spi_get_device_id(spi)->name;
> > > +     indio_dev->name = st->chip_info->name;
> > >       indio_dev->modes = INDIO_DIRECT_MODE;
> > >       indio_dev->info = &ad7124_info;
> > >
> > > @@ -721,6 +768,10 @@ static int ad7124_probe(struct spi_device *spi)
> > >       if (ret < 0)
> > >               goto error_clk_disable_unprepare;
> > >
> > > +     ret = ad7124_check_chip_id(st);
> > > +     if (ret)
> > > +             goto error_clk_disable_unprepare;
> > > +
> > >       ret = ad7124_setup(st);
> > >       if (ret < 0)
> > >               goto error_clk_disable_unprepare;
> > > @@ -768,16 +819,11 @@ static int ad7124_remove(struct spi_device *spi)
> > >       return 0;
> > >  }
> > >
> > > -static const struct spi_device_id ad7124_id_table[] = {
> > > -     { "ad7124-4", ID_AD7124_4 },
> > > -     { "ad7124-8", ID_AD7124_8 },
> > > -     {}
> > > -};
> > > -MODULE_DEVICE_TABLE(spi, ad7124_id_table);
> > > -
> > >  static const struct of_device_id ad7124_of_match[] = {
> > > -     { .compatible = "adi,ad7124-4" },
> > > -     { .compatible = "adi,ad7124-8" },
> > > +     { .compatible = "adi,ad7124-4",
> > > +             .data = &ad7124_chip_info_tbl[ID_AD7124_4], },
> > > +     { .compatible = "adi,ad7124-8",
> > > +             .data = &ad7124_chip_info_tbl[ID_AD7124_8], },
> > >       { },
> > >  };
> > >  MODULE_DEVICE_TABLE(of, ad7124_of_match);
> > > @@ -789,7 +835,6 @@ static struct spi_driver ad71124_driver = {
> > >       },
> > >       .probe = ad7124_probe,
> > >       .remove = ad7124_remove,
> > > -     .id_table = ad7124_id_table,
> > >  };
> > >  module_spi_driver(ad71124_driver);
> > >
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
