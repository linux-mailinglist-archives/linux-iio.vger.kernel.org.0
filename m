Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8314B13F74
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 14:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfEEMwz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 08:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfEEMwz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 08:52:55 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6CC2082F;
        Sun,  5 May 2019 12:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557060773;
        bh=tsH2oEV4r5mYbULqW5f8c1LYGcQyg6mLK5IvSZefYP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CsIjfCDAel0bh7fv5EV64U2p/UNyDpDvcM5S6hDNA9H/XH1bgBiGUbPeM3W/ki94p
         37TYuNluNpac5K3ODBcZbMirkt6kOUzneb9h7i/5bDuwuG+hjqZeOeW02fZid1vBsI
         ZEHqvtO7LRvVGGgQAYW4SmcjqLiY1HdncgIXfHKQ=
Date:   Sun, 5 May 2019 13:52:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Melissa Wen <melissa.srw@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/4] staging: iio: ad7150: organize registers definition
Message-ID: <20190505135247.2a78bd5f@archlinux>
In-Reply-To: <CA+U=DspGcZjru0cqkO3fHJjg04Gxg-3Yu6jnNKZjx1dBZTG+Pg@mail.gmail.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
        <10781f40fa8a403480833e49b7356ade5af57b94.1556919363.git.melissa.srw@gmail.com>
        <CA+U=DspGcZjru0cqkO3fHJjg04Gxg-3Yu6jnNKZjx1dBZTG+Pg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 4 May 2019 13:13:55 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, May 4, 2019 at 1:25 AM Melissa Wen <melissa.srw@gmail.com> wrote:
> >
> > Use the suffix REG to make the register addresses clear
> > and indentation to highlight field names.
> >  
> 
> I'm inclined to say that this change is a bit too much noise versus added value.
> While the REG suffix does make sense (generally), since it hasn't been
> added from the beginning, it doesn't make much sense to add it now.
> 
> It is sufficiently clear (as-is) that these macros refer to registers.
> They should be easy to match with the datasheet as well.
I'd agree for a driver that was outside staging that this is more noise than
it is worth, but one of the aims of moving drivers out is to produce
very clean and nice code. In this particular case there are very few fields
so it's not nearly as much of a mess as some other drivers where it really
hasn't been clear and the _REG suffix added much greater benefits.

Some of the arguments for minimizing noise typically don't apply on
the basis we 'probably' won't backport fixes across the move out of staging.

So I'm a bit on the fence on this one, but probably fall slightly
more in favour of the change.

Hence I would say up to you Melissa on whether you want to keep this
one or not given the arguments in favour and against that Alex
has laid out.

Given there are a few bits needed in later patches, I'll not pick this
one up for now either way!

Jonathan

> 
> > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> > ---
> >  drivers/staging/iio/cdc/ad7150.c | 75 ++++++++++++++++----------------
> >  1 file changed, 37 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> > index dd7fcab8e19e..24601ba7db88 100644
> > --- a/drivers/staging/iio/cdc/ad7150.c
> > +++ b/drivers/staging/iio/cdc/ad7150.c
> > @@ -15,35 +15,34 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/events.h>
> > -/*
> > - * AD7150 registers definition
> > - */
> >
> > -#define AD7150_STATUS              0
> > -#define AD7150_STATUS_OUT1         BIT(3)
> > -#define AD7150_STATUS_OUT2         BIT(5)
> > -#define AD7150_CH1_DATA_HIGH       1
> > -#define AD7150_CH2_DATA_HIGH       3
> > -#define AD7150_CH1_AVG_HIGH        5
> > -#define AD7150_CH2_AVG_HIGH        7
> > -#define AD7150_CH1_SENSITIVITY     9
> > -#define AD7150_CH1_THR_HOLD_H      9
> > -#define AD7150_CH1_TIMEOUT         10
> > -#define AD7150_CH1_SETUP           11
> > -#define AD7150_CH2_SENSITIVITY     12
> > -#define AD7150_CH2_THR_HOLD_H      12
> > -#define AD7150_CH2_TIMEOUT         13
> > -#define AD7150_CH2_SETUP           14
> > -#define AD7150_CFG                 15
> > -#define AD7150_CFG_FIX             BIT(7)
> > -#define AD7150_PD_TIMER            16
> > -#define AD7150_CH1_CAPDAC          17
> > -#define AD7150_CH2_CAPDAC          18
> > -#define AD7150_SN3                 19
> > -#define AD7150_SN2                 20
> > -#define AD7150_SN1                 21
> > -#define AD7150_SN0                 22
> > -#define AD7150_ID                  23
> > +/* AD7150 registers */
> > +
> > +#define AD7150_STATUS_REG                      0x00
> > +#define         AD7150_STATUS_OUT1                     BIT(3)
> > +#define         AD7150_STATUS_OUT2                     BIT(5)
> > +#define AD7150_CH1_DATA_HIGH_REG               0x01
> > +#define AD7150_CH2_DATA_HIGH_REG               0x03
> > +#define AD7150_CH1_AVG_HIGH_REG                        0x05
> > +#define AD7150_CH2_AVG_HIGH_REG                        0x07
> > +#define AD7150_CH1_SENSITIVITY_REG             0x09
> > +#define AD7150_CH1_THR_HOLD_H_REG              0x09
> > +#define AD7150_CH2_SENSITIVITY_REG             0x0C
> > +#define AD7150_CH1_TIMEOUT_REG                 0x0A
> > +#define AD7150_CH1_SETUP_REG                   0x0B
> > +#define AD7150_CH2_THR_HOLD_H_REG              0x0C
> > +#define AD7150_CH2_TIMEOUT_REG                 0x0D
> > +#define AD7150_CH2_SETUP_REG                   0x0E
> > +#define AD7150_CFG_REG                         0x0F
> > +#define         AD7150_CFG_FIX                         BIT(7)
> > +#define AD7150_PD_TIMER_REG                    0x10
> > +#define AD7150_CH1_CAPDAC_REG                  0x11
> > +#define AD7150_CH2_CAPDAC_REG                  0x12
> > +#define AD7150_SN3_REG                         0x13
> > +#define AD7150_SN2_REG                         0x14
> > +#define AD7150_SN1_REG                         0x15
> > +#define AD7150_SN0_REG                         0x16
> > +#define AD7150_ID_REG                          0x17
> >
> >  /**
> >   * struct ad7150_chip_info - instance specific chip data
> > @@ -85,12 +84,12 @@ struct ad7150_chip_info {
> >   */
> >
> >  static const u8 ad7150_addresses[][6] = {
> > -       { AD7150_CH1_DATA_HIGH, AD7150_CH1_AVG_HIGH,
> > -         AD7150_CH1_SETUP, AD7150_CH1_THR_HOLD_H,
> > -         AD7150_CH1_SENSITIVITY, AD7150_CH1_TIMEOUT },
> > -       { AD7150_CH2_DATA_HIGH, AD7150_CH2_AVG_HIGH,
> > -         AD7150_CH2_SETUP, AD7150_CH2_THR_HOLD_H,
> > -         AD7150_CH2_SENSITIVITY, AD7150_CH2_TIMEOUT },
> > +       { AD7150_CH1_DATA_HIGH_REG, AD7150_CH1_AVG_HIGH_REG,
> > +         AD7150_CH1_SETUP_REG, AD7150_CH1_THR_HOLD_H_REG,
> > +         AD7150_CH1_SENSITIVITY_REG, AD7150_CH1_TIMEOUT_REG },
> > +       { AD7150_CH2_DATA_HIGH_REG, AD7150_CH2_AVG_HIGH_REG,
> > +         AD7150_CH2_SETUP_REG, AD7150_CH2_THR_HOLD_H_REG,
> > +         AD7150_CH2_SENSITIVITY_REG, AD7150_CH2_TIMEOUT_REG },
> >  };
> >
> >  static int ad7150_read_raw(struct iio_dev *indio_dev,
> > @@ -133,7 +132,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
> >         bool adaptive;
> >         struct ad7150_chip_info *chip = iio_priv(indio_dev);
> >
> > -       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> > +       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
> >         if (ret < 0)
> >                 return ret;
> >
> > @@ -229,7 +228,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
> >         if (event_code == chip->current_event)
> >                 return 0;
> >         mutex_lock(&chip->state_lock);
> > -       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> > +       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
> >         if (ret < 0)
> >                 goto error_ret;
> >
> > @@ -264,7 +263,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
> >
> >         cfg |= (!adaptive << 7) | (thresh_type << 5);
> >
> > -       ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
> > +       ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG_REG, cfg);
> >         if (ret < 0)
> >                 goto error_ret;
> >
> > @@ -497,7 +496,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
> >         s64 timestamp = iio_get_time_ns(indio_dev);
> >         int ret;
> >
> > -       ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
> > +       ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS_REG);
> >         if (ret < 0)
> >                 return IRQ_HANDLED;
> >
> > --
> > 2.20.1
> >  

