Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEFA117CA1
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 01:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfLJArZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 19:47:25 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37057 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfLJArY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Dec 2019 19:47:24 -0500
Received: by mail-ua1-f68.google.com with SMTP id f9so6189610ual.4;
        Mon, 09 Dec 2019 16:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khbHSwCwrOHqwBO/YAwlLCEdaLJd1mtH0WmHbgzv+p4=;
        b=keicZ8Cgcx69v/YQkJWe8VneQh4qjr+CSGSqgm6qw0LHg+rhiu95krg2IW5IrVvM5o
         2v54s1bZXa116ljHB7hsA0JxswN5a2HaIy6ZpkWNNScMqbbMYTpJT7UVUx3ZxP7Aa7z6
         /YYjMLuALaRkgRIGZCOx0q+pKifg1XMEcKVFDBGEiV8dD/MH5WJx0AvLjc1qVXu9EEeR
         wNZFoU3LoIJCoT3wCGhDpwe/RI6Mhb0I4K8r+YrxjSIKArbOZQSInP2RdVxr8zY42ctR
         +pQDx9y1x1unH37aDxA+2RxSE+Hzgm2BVyEY7tWUKzTGfNGk1cDDZ15CoGthj6ZX3Fan
         8szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khbHSwCwrOHqwBO/YAwlLCEdaLJd1mtH0WmHbgzv+p4=;
        b=CgEIxrCgDkvu0m30SbfjIHyOb1ksRvdt5Y8cfVOc2p/0hhL5vP4Trod3K+KIQkQ5xS
         YslY25e6f635ovuC7NFzPYWQoXQDO2OZ3kPl2p6nL9xKk/PXY5Z1CPdGzyflJqd/offE
         BeMdRqupGoD/EDDJ3CUkPdiGCOdZCMXhfD2JBJHD25wfWY2seC2E+zUmbcvnCJdxTh9P
         oLU3ZaBpL4Imr236AKALGudsXZw1OQ0MP/9KOeMomdLullh+PExgV8iPME4yPJxgKxyp
         cuZLGR3AcxblGWwA9kLn6VdmTvtNIhPumr+BPXcKWmS6HfX+vKSzw1011TNNLf3rkSbe
         yJcg==
X-Gm-Message-State: APjAAAX1ynqlWjheqkp94DS4HRjr4PeQ72vErn/r3bXNLVGa7HWSHXSW
        rSbcZ99mqiSXch4VkjtuhtxdYBbZEfSAnrHtv1Y=
X-Google-Smtp-Source: APXvYqzmgLriHTh2Mb7xymnJYYcDDzyk/rXqlKbLRRP+YJWBP2PhGTOzh7Aum5lcHuZiluFsS0ipbKp2v7w2ruoItk4=
X-Received: by 2002:ab0:1492:: with SMTP id d18mr26447521uae.0.1575938842930;
 Mon, 09 Dec 2019 16:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20191205155821.7441-1-djunho@gmail.com> <20191207112623.31ac5288@archlinux>
 <CAKxs2cDmycwOD6CE2UiSb18GkLgmRK=m7jkBq2+rBc8UGosStw@mail.gmail.com>
In-Reply-To: <CAKxs2cDmycwOD6CE2UiSb18GkLgmRK=m7jkBq2+rBc8UGosStw@mail.gmail.com>
From:   Daniel Junho <djunho@gmail.com>
Date:   Mon, 9 Dec 2019 21:47:11 -0300
Message-ID: <CAKxs2cA=HYb3OUHMRrXqA=SeN30PwuoO1b1L=LcGk9EcBqbDLw@mail.gmail.com>
Subject: Re: [PATCH] iio:adc:ad7923: Add support for the ad7908/ad7918/ad7928
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

First of all, thank you so much for the feedback and the time spent.

On Sat, Dec 7, 2019 at 8:26 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu,  5 Dec 2019 12:58:21 -0300
> Daniel Junho <djunho@gmail.com> wrote:
>
> > The ad7928 is software compatible with the ad7923. The ad7908 and ad7918 are the
> > 8 and 10 bit version of the ad7928.
> >
> > Signed-off-by: Daniel Junho <djunho@gmail.com>
> Hi Daniel,
>
> Code itself looks good to me, but please be very careful to separate out
> non function cleanup from a patch adding something new.  It makes
> reviewing harder.  We'd much rather see a series with the cleanup all clearly
> marked as such (and getting a most a few seconds review) and the real code
> being just that.

Ok. I understand and I will make these changes in a v2 patch.

>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/Kconfig  |  3 +-
> >  drivers/iio/adc/ad7923.c | 96 +++++++++++++++++++++++++++++++---------
> >  2 files changed, 78 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 976567d4dbef..40aa05fbf85e 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -205,7 +205,8 @@ config AD7923
> >       select IIO_TRIGGERED_BUFFER
> >       help
> >         Say yes here to build support for Analog Devices
> > -       AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
> > +       AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and
> > +       AD7908, AD7918, AD7928 8 Channels ADCs.
> >
> >         To compile this driver as a module, choose M here: the
> >         module will be called ad7923.
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 3212eb4c0f25..f08a5218dad1 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * AD7904/AD7914/AD7923/AD7924 SPI ADC driver
> > + * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 SPI ADC driver
> >   *
> >   * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
> >   * Copyright 2012 CS Systemes d'Information
> > @@ -26,23 +26,32 @@
> >  #define AD7923_WRITE_CR              BIT(11)         /* write control register */
> >  #define AD7923_RANGE         BIT(1)          /* range to REFin */
> >  #define AD7923_CODING                BIT(0)          /* coding is straight binary */
> > +
>
> No white space changes in a patch doing real changes to the driver.

Ok

>
> >  #define AD7923_PM_MODE_AS    (1)             /* auto shutdown */
> >  #define AD7923_PM_MODE_FS    (2)             /* full shutdown */
> >  #define AD7923_PM_MODE_OPS   (3)             /* normal operation */
> > +
> >  #define AD7923_CHANNEL_0     (0)             /* analog input 0 */
> >  #define AD7923_CHANNEL_1     (1)             /* analog input 1 */
> >  #define AD7923_CHANNEL_2     (2)             /* analog input 2 */
> >  #define AD7923_CHANNEL_3     (3)             /* analog input 3 */
> > -#define AD7923_SEQUENCE_OFF  (0)             /* no sequence fonction */
> > -#define AD7923_SEQUENCE_PROTECT      (2)             /* no interrupt write cycle */
> > -#define AD7923_SEQUENCE_ON   (3)             /* continuous sequence */
> > -
> > -#define AD7923_MAX_CHAN              4
> > +#define AD7923_CHANNEL_4     (4)             /* analog input 4 */
> > +#define AD7923_CHANNEL_5     (5)             /* analog input 5 */
> > +#define AD7923_CHANNEL_6     (6)             /* analog input 6 */
> > +#define AD7923_CHANNEL_7     (7)             /* analog input 7 */
> These made me wonder.  Seems they aren't actually used in the driver anyway.
> Ideally add a precursor to your main patch just dropping these particular
> defines entirely.

Ok. I will remove them on a cleanup commit.

>
>
> > +
> > +#define AD7923_SEQUENCE_OFF  (0x00)          /* no sequence function */
> > +#define AD7923_SEQUENCE_SHADOW       (0x01)          /* use the shadow register
> > +                                              * for programming
> > +                                              * (only AD7908/7918/7928)
> > +                                              */
> > +#define AD7923_SEQUENCE_PROTECT      (0x10)          /* no interrupt write cycle */
> > +#define AD7923_SEQUENCE_ON   (0x11)          /* continuous sequence */
> >
> >  #define AD7923_PM_MODE_WRITE(mode)   ((mode) << 4)    /* write mode */
> >  #define AD7923_CHANNEL_WRITE(channel)        ((channel) << 6) /* write channel */
> > -#define AD7923_SEQUENCE_WRITE(sequence)      ((((sequence) & 1) << 3) \
> > -                                     + (((sequence) & 2) << 9))
> > +#define AD7923_SEQUENCE_WRITE(sequence)      ((((sequence) & 0x01) << 3) \
> > +                                     + (((sequence) & 0x10) << 9))
>
> This change is interesting.  Was original code just buggy? we were masking
> against 2nd bit, and now we are masking against the 4th?

Sorry about that. My bad. I will return to 2.
It was just a quick test I did, and commit it unintentionally =(

>
> >                                               /* write sequence fonction */
> >  /* left shift for CR : bit 11 transmit in first */
> >  #define AD7923_SHIFT_REGISTER        4
> > @@ -78,6 +87,9 @@ enum ad7923_id {
> >       AD7904,
> >       AD7914,
> >       AD7924,
> > +     AD7908,
> > +     AD7918,
> > +     AD7928
> >  };
> >
> >  #define AD7923_V_CHAN(index, bits)                                   \
> > @@ -97,7 +109,7 @@ enum ad7923_id {
> >               },                                                      \
> >       }
> >
> > -#define DECLARE_AD7923_CHANNELS(name, bits) \
> > +#define DECLARE_AD7923_4CHANNELS(name, bits) \
> >  const struct iio_chan_spec name ## _channels[] = { \
> >       AD7923_V_CHAN(0, bits), \
> >       AD7923_V_CHAN(1, bits), \
> > @@ -106,9 +118,25 @@ const struct iio_chan_spec name ## _channels[] = { \
> >       IIO_CHAN_SOFT_TIMESTAMP(4), \
> >  }
> >
> > -static DECLARE_AD7923_CHANNELS(ad7904, 8);
> > -static DECLARE_AD7923_CHANNELS(ad7914, 10);
> > -static DECLARE_AD7923_CHANNELS(ad7924, 12);
> > +#define DECLARE_AD7923_8CHANNELS(name, bits) \
> > +const struct iio_chan_spec name ## _channels[] = { \
> > +     AD7923_V_CHAN(0, bits), \
> > +     AD7923_V_CHAN(1, bits), \
> > +     AD7923_V_CHAN(2, bits), \
> > +     AD7923_V_CHAN(3, bits), \
> > +     AD7923_V_CHAN(4, bits), \
> > +     AD7923_V_CHAN(5, bits), \
> > +     AD7923_V_CHAN(6, bits), \
> > +     AD7923_V_CHAN(7, bits), \
> > +     IIO_CHAN_SOFT_TIMESTAMP(8), \
> > +}
> > +
> > +static DECLARE_AD7923_4CHANNELS(ad7904, 8);
> > +static DECLARE_AD7923_4CHANNELS(ad7914, 10);
> > +static DECLARE_AD7923_4CHANNELS(ad7924, 12);
> > +static DECLARE_AD7923_8CHANNELS(ad7908, 8);
> > +static DECLARE_AD7923_8CHANNELS(ad7918, 10);
> > +static DECLARE_AD7923_8CHANNELS(ad7928, 12);
> >
> >  static const struct ad7923_chip_info ad7923_chip_info[] = {
> >       [AD7904] = {
> > @@ -123,6 +151,18 @@ static const struct ad7923_chip_info ad7923_chip_info[] = {
> >               .channels = ad7924_channels,
> >               .num_channels = ARRAY_SIZE(ad7924_channels),
> >       },
> > +     [AD7908] = {
> > +             .channels = ad7908_channels,
> > +             .num_channels = ARRAY_SIZE(ad7908_channels),
> > +     },
> > +     [AD7918] = {
> > +             .channels = ad7918_channels,
> > +             .num_channels = ARRAY_SIZE(ad7918_channels),
> > +     },
> > +     [AD7928] = {
> > +             .channels = ad7928_channels,
> > +             .num_channels = ARRAY_SIZE(ad7928_channels),
> > +     },
> >  };
> >
> >  /**
> > @@ -135,10 +175,10 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
> >       int i, cmd, len;
> >
> >       len = 0;
> > -     for_each_set_bit(i, active_scan_mask, AD7923_MAX_CHAN) {
> > +     for_each_set_bit(i, active_scan_mask, indio_dev->num_channels - 1) {
> >               cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(i) |
> > -                     AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
> > -                     st->settings;
> > +                   AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
> > +                   st->settings;
> >               cmd <<= AD7923_SHIFT_REGISTER;
> >               st->tx_buf[len++] = cpu_to_be16(cmd);
> >       }
> > @@ -188,13 +228,13 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
> >       return IRQ_HANDLED;
> >  }
> >
> > -static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)
> > +static int ad7923_scan_direct(struct ad7923_state *st, unsigned int ch)
>
> Should be in a precursor patch tidying this up.   Never mix new features
> with cleanup as it's harder to review.

Ok.

>
> >  {
> >       int ret, cmd;
> >
> >       cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(ch) |
> > -             AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
> > -             st->settings;
> > +           AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
> > +           st->settings;
>
> Clean out this noise from the patch.  We just want to see
> the new stuff rather than stare at a line to figure if it
> is just whitespace, or if there is a real change ;)

Ok

>
> >       cmd <<= AD7923_SHIFT_REGISTER;
> >       st->tx_buf[0] = cpu_to_be16(cmd);
> >
> > @@ -280,7 +320,7 @@ static int ad7923_probe(struct spi_device *spi)
> >
> >       st->spi = spi;
> >       st->settings = AD7923_CODING | AD7923_RANGE |
> > -                     AD7923_PM_MODE_WRITE(AD7923_PM_MODE_OPS);
> > +                    AD7923_PM_MODE_WRITE(AD7923_PM_MODE_OPS);
>
> Please clean out an noise like this bit of realignment.

Ok

>
> >
> >       info = &ad7923_chip_info[spi_get_device_id(spi)->driver_data];
> >
> > @@ -348,13 +388,29 @@ static const struct spi_device_id ad7923_id[] = {
> >       {"ad7914", AD7914},
> >       {"ad7923", AD7924},
> >       {"ad7924", AD7924},
> > +     {"ad7908", AD7908},
> > +     {"ad7918", AD7918},
> > +     {"ad7928", AD7928},
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad7923_id);
> >
> > +static const struct of_device_id ad7923_of_match[] = {
> > +     { .compatible = "adi,ad7904", },
> > +     { .compatible = "adi,ad7914", },
> > +     { .compatible = "adi,ad7923", },
> > +     { .compatible = "adi,ad7924", },
> > +     { .compatible = "adi,ad7908", },
> > +     { .compatible = "adi,ad7918", },
> > +     { .compatible = "adi,ad7928", },
> > +     { },
> Really minor but I would have preferred a precursor patch
> adding the of_device_id table for existing parts.
>
> Makes a clear separation between new device support and tidying
> up the fact that table should be there to allow the specific
> adi,* matching.

OK.

>
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7923_of_match);
> > +
> >  static struct spi_driver ad7923_driver = {
> >       .driver = {
> >               .name   = "ad7923",
> > +             .of_match_table = ad7923_of_match,
> >       },
> >       .probe          = ad7923_probe,
> >       .remove         = ad7923_remove,
> > @@ -364,5 +420,5 @@ module_spi_driver(ad7923_driver);
> >
> >  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> >  MODULE_AUTHOR("Patrick Vasseur <patrick.vasseur@c-s.fr>");
> > -MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924 ADC");
> > +MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 ADC");
> >  MODULE_LICENSE("GPL v2");
>

I will split this commit into 4.

- Remove the unused defines (AD7923_CHANNEL_x);
- Fix checkpatch warning using 'unsigned int' instead of 'unsigned';
- Add of_device_id table;
- Add support for the ad7908/ad7918/ad7928.

Thanks,
Daniel Junho
