Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28A727CFD
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfEWMjm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 08:39:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45553 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfEWMjl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 08:39:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id t24so5215891otl.12;
        Thu, 23 May 2019 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Shf1bn4QnDbo/EuDScxES/Yn7hUe+srYKFncU2F12Do=;
        b=MBYLftF+j9Jn+eY2K16X33ojsS2jcN0lVV3YPi2/H/+Pjj1P0cQ9tycjj9WMxtrL+f
         FNHRVOEwqK5VmV8VhO4fE4IoxRvzLLo04X4XGSulLDB17XxPfiK5LiKJ1e8R782X0nLn
         ewxygZW3/JYdUqRUQ0KqB+W70NIoemx8+RoE60FNBeQjgcNthcvKuZiyZQWF01E+Leav
         6cFMToUzUSXk6vedmD7E09q4kBZ2s26XmXOIAWTumg21EoZJKXnb8Gi6PnutxP+uUbTp
         iQgw2VmA70n7tcge41h08WcnbMCuGojU4iiDBWhrPgr1+DF9xlA+NaCkvwf5OHJHNJ/b
         xMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Shf1bn4QnDbo/EuDScxES/Yn7hUe+srYKFncU2F12Do=;
        b=rHpceVcBu77u0dMNaEK4EG1SzUCY/YGX6vjVJUwlhbXkxmMqOLNYnZLaAU9W2qqoXz
         xSq8a+pvypAc7rV0TZcBz+Bf9hzwP0k8RsTe11fuC5EhBlxWIzC8dI8jrP0Euq2bn0g/
         C45JZHsL2c8GroioZkh6+1Zcd0FmFVOx1ImxfUBjvFUQI69Us+eMGYbSv8LK3lYf+xAV
         px+Q41z35A5DFA4jF61LrGOSA99SECjEr8OGhZgeYzycAX/TPmWOkSFjnumhHCRdzl5T
         ReKGjV2oEPXLzdzh19v7RyOQ89ZabMKTy7LySXrJ/v5Bk/bkjdcp2d1IYRA3ighiPfTi
         dweA==
X-Gm-Message-State: APjAAAVMetj41yf78KI5OGCY8rBuN6cULUtBJzCdUPjRFO1BRZNQLTnl
        TANnDu7H2EgtnY2U26EyUFrrL39EEdyXkeWrqP4=
X-Google-Smtp-Source: APXvYqwKQzlCRqaeq+qHmMaXuv2vlT3hOSyk1Wu6yPggLRH0qhtO/Y3pTzPEOKMpsihlH0rzCzyNG3F5bqUDQk2vdGU=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr1894231otr.207.1558615180660;
 Thu, 23 May 2019 05:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
 <1557759185-167857-4-git-send-email-adam.michaelis@rockwellcollins.com> <20190518101050.75c5d60e@archlinux>
In-Reply-To: <20190518101050.75c5d60e@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 23 May 2019 15:39:27 +0300
Message-ID: <CA+U=Dsou8wqBgZiS5DuPzJ_jD6AG9d5Q86ptwFm4m-59xy0K0w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] iio: ad7949: Fix SPI interfacing for 14-bit messages
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Adam Michaelis <adam.michaelis@rockwellcollins.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <michael.hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>,
        Clayton Shotwell <clayton.shotwell@rockwellcollins.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 18, 2019 at 12:11 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 13 May 2019 09:53:04 -0500
> Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:
>

CC-ing my work email.

> > The AD7949 (but not the other two models supported by this driver) uses
> > samples 14 bits wide. When attempting to communicate through certain SPI
> > controllers that do not support word widths of 14, this fails. Adding
> > logic to pack the 14-bit messages into the most-significant bits of a
> > 16-bit message or a 2-word 8-bit message for communication using more SPI
> > bus controllers.
> >

General note, there are some changes in this patch that are
unrelated/un-needed to the semantic of the patch.
I'm seeing some comments being re-arranged, and some newlines being added.
Jonathan also mentioned something about them.

It's good practice to not touch whitespace, or style in a patch that
is mostly functional.
For now, this is fine as-is from my side as well.

In any case, sticking to this patch:
I am wondering whether this driver needs to care about SPI packing
logic, or the SPI controller needs to do that, or the SPI framework ?
I would assume, that the way to do things, is to provide the SPI
framework the parameters of the data (shifting, bits-per-word, etc)
and the SPI framework would do the rest.


> > Only able to test with AD7949 part on Cadence SPI, but should support
> > the 16-bit samples of the AD7682 and AD7689, as well.
> >
> > Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> This one looks fine to me as well.  For my reference
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Note a trivial comment inline that can be tidied up whilst applying
> or if you do another spin.
>
> Jonathan
> > ---
> >       V2:
> >       - Add some defines to reduce use of magic numbers.
> >       V3:
> >       - Use union for message buffer to keep messages word-aligned for
> >       various word sizes.
> >       - Calculate SPI bits-per-word once and use for logic throughout.
> >       - Add logic to use SPI controller's bits-per-word field to make
> >       the most use of the hardware's capabilities.
> >       - Try to support SPI word widths of 16, 14, and 8 bits.
> > ---
> >  drivers/iio/adc/ad7949.c | 115 +++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 87 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index b648b1ab9559..d67033a008e5 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -78,10 +78,30 @@ struct ad7949_adc_chip {
> >       enum ad7949_ref_sel ref_sel;
> >       u8 resolution;
> >       u16 cfg;
> > +     u8 bits_per_word;
> >       unsigned int current_channel;
> > -     u32 buffer ____cacheline_aligned;
> > +     union {
> > +             u32 buffer;
> > +             u16 buf16[2];
> > +             u8 buf8[4];
> > +     } ____cacheline_aligned;
> >  };
> >
> > +static void ad7949_set_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
> > +{
> > +     /* Prefer messages that match the ADC's resolution */
> > +     if (ad7949_adc->spi->controller->bits_per_word_mask &
> > +                     SPI_BPW_MASK(ad7949_adc->resolution))

My sentiment is that this mail evaluate to true even when you don't want it to.

I'm guessing the intention here was something like:

     u32 resolution_msk = SPI_BPW_MASK(ad7949_adc->resolution);
     u32 resolution = resolution_msk;

     resolution &= ad7949_adc->spi->controller->bits_per_word_mask;

     if (resolution == resolution_msk)
         ad7949_adc->bits_per_word = ad7949_adc->resolution;
     else if (resolution == SPI_BPW_MASK(16))
             ad7949_adc->bits_per_word = 16;
     else
             ad7949_adc->bits_per_word = 8;


> > +             ad7949_adc->bits_per_word = ad7949_adc->resolution;
> > +     /* Second choice is to pad 14-bit words to 16 */
> > +     else if (ad7949_adc->spi->controller->bits_per_word_mask &
> > +                     SPI_BPW_MASK(16))
> > +             ad7949_adc->bits_per_word = 16;
> > +     /* Last resort, use 8-bit words */
> > +     else
> > +             ad7949_adc->bits_per_word = 8;
> > +}
> > +
> >  static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
> >  {
> >       if (!(ad7949_adc->cfg & AD7949_CFG_READBACK))
> > @@ -90,39 +110,63 @@ static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
> >       return false;
> >  }
> >
> > -static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
> > +static int ad7949_message_len(struct ad7949_adc_chip *ad7949_adc)
> >  {
> > -     int ret = ad7949_adc->resolution;
> > +     int tx_len = 2;
> >
> >       if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> > -             ret += AD7949_CFG_REG_SIZE_BITS;
> > +             tx_len += 2;
> >
> > -     return ret;
> > +     return tx_len;
> >  }
> >
> >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> >                               u16 mask)
> >  {
> > -     int ret;
> > -     int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
> > -     int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> > +     int ret = 0;
> > +     u16 tmp_cfg = 0;
> >       struct spi_message msg;
> >       struct spi_transfer tx[] = {
> >               {
> >                       .tx_buf = &ad7949_adc->buffer,
> > -                     .len = 4,
> > -                     .bits_per_word = bits_per_word,
> > -             },
> > +                     .len = ad7949_message_len(ad7949_adc),
> > +                     .bits_per_word = ad7949_adc->bits_per_word,
> > +             }
> >       };
> >
> > -     ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
> > -     ad7949_adc->buffer = (ad7949_adc->cfg & AD7949_CFG_MASK_TOTAL) << shift;
> > +     ad7949_adc->buffer = 0;
> > +
> > +     tmp_cfg = ((val & mask) | (ad7949_adc->cfg & ~mask)) &
> > +             AD7949_CFG_MASK_TOTAL;
> > +
> > +     /* If no change, return */
> > +     if (tmp_cfg == ad7949_adc->cfg)
> > +             return 0;
> > +
> > +     ad7949_adc->cfg = tmp_cfg;
> > +
> > +     switch (ad7949_adc->bits_per_word) {
> > +     case 16:
> > +             ad7949_adc->buf16[0] = ad7949_adc->cfg << 2;
> > +             break;
> > +     case 14:
> > +             ad7949_adc->buf16[0] = ad7949_adc->cfg;
> > +             break;
> > +     default: /* 8 */
> > +             /* Pack 14-bit value into 2 bytes, MSB first */
> > +             ad7949_adc->buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
> > +             ad7949_adc->buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg);
> > +             ad7949_adc->buf8[1] = ad7949_adc->buf8[1] << 2;
> > +             break;
> > +     }
> > +
> >       spi_message_init_with_transfers(&msg, tx, 1);
> > +
> >       ret = spi_sync(ad7949_adc->spi, &msg);
> >
> >       /*
> > -      * This delay is to avoid a new request before the required time to
> > -      * send a new command to the device
> > +      * This delay is to avoid a new request before the required
> > +      * time to send a new command to the device
> >        */
> >       udelay(2);
> >
> > @@ -149,17 +193,17 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >                                  unsigned int channel)
> >  {
> >       int ret;
> > -     int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
> > -     int mask = GENMASK(ad7949_adc->resolution, 0);
> >       struct spi_message msg;
> >       struct spi_transfer tx[] = {
> >               {
> >                       .rx_buf = &ad7949_adc->buffer,
> > -                     .len = 4,
> > -                     .bits_per_word = bits_per_word,
> > -             },
> > +                     .len = ad7949_message_len(ad7949_adc),
> > +                     .bits_per_word = ad7949_adc->bits_per_word,
> > +             }
> >       };
> >
> > +     ad7949_adc->current_channel = channel;
> > +
> >       ret = ad7949_spi_write_cfg(ad7949_adc,
> >                                  FIELD_PREP(AD7949_CFG_CHAN_SEL, channel),
> >                                  AD7949_CFG_CHAN_SEL);
> > @@ -167,23 +211,37 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >               return ret;
> >
> >       ad7949_adc->buffer = 0;
> > +
> >       spi_message_init_with_transfers(&msg, tx, 1);
> > +
> Unrelated change. Nothing wrong with it, but not in a patch making
> functional changes.
>
> >       ret = spi_sync(ad7949_adc->spi, &msg);
> >       if (ret)
> >               return ret;
> >
> >       /*
> > -      * This delay is to avoid a new request before the required time to
> > -      * send a new command to the device
> > +      * This delay is to avoid a new request before the required time
> > +      * to send a new command to the device.
> >        */
> >       udelay(2);
> >
> > -     ad7949_adc->current_channel = channel;
> > -
> > -     if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> > -             *val = (ad7949_adc->buffer >> AD7949_CFG_REG_SIZE_BITS) & mask;
> > -     else
> > -             *val = ad7949_adc->buffer & mask;
> > +     switch (ad7949_adc->bits_per_word) {
> > +     case 16:
> > +             *val = ad7949_adc->buf16[0];
> > +             /* Shift-out padding bits */
> > +             if (ad7949_adc->resolution == 14)
> > +                     *val = *val >> 2;
> > +             break;
> > +     case 14:
> > +             *val = ad7949_adc->buf16[0] & GENMASK(13, 0);
> > +             break;
> > +     default: /* 8 */
> > +             /* Convert byte array to u16, MSB first */
> > +             *val = (ad7949_adc->buf8[0] << 8) | ad7949_adc->buf8[1];
> > +             /* Shift-out padding bits */
> > +             if (ad7949_adc->resolution == 14)
> > +                     *val = *val >> 2;
> > +             break;
> > +     }
> >
> >       return 0;
> >  }
> > @@ -334,6 +392,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
> >       spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
> >       indio_dev->num_channels = spec->num_channels;
> >       ad7949_adc->resolution = spec->resolution;
> > +     ad7949_set_bits_per_word(ad7949_adc);
> >
> >       ret = of_property_read_u32(ad7949_adc->indio_dev->dev.of_node,
> >                       "adi,reference-select",
>
