Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD444B2F94
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfIOKgH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 06:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfIOKgG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 06:36:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8226D2077C;
        Sun, 15 Sep 2019 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568543765;
        bh=wRqwVW/tQVs8o1eNZY0iKjjIj0B2lViyoBscCJEldaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GUZERug7E6xuxn8wPOMUh/X9nnxHl78pfa7vzx4exfI4eD8bptZ9AtHTfJhmrXq5V
         CfYITAIv5RC52inWOqTKN5ZLO952CXZhwIZnkG1qUCCFbBHCeks9LBGf6f9TkJoZIH
         KzTkXOWE5U7q/PHCD2aUV6vRDLWwmo8Mdi0GEKXc=
Date:   Sun, 15 Sep 2019 11:36:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        antoine.couret@essensium.com,
        Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Subject: Re: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Message-ID: <20190915113600.26fe4987@archlinux>
In-Reply-To: <CAN8YU5MpLDVEfVBUBe9XsuYT6yohruiHAMQgOVjZs-2JyO=NNQ@mail.gmail.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
        <20190912144310.7458-3-andrea.merello@gmail.com>
        <3fe869be01ce7c81fd463158c05e0a4a115bdd6a.camel@analog.com>
        <CAN8YU5MpLDVEfVBUBe9XsuYT6yohruiHAMQgOVjZs-2JyO=NNQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 09:56:56 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno ven 13 set 2019 alle ore 08:46 Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> ha scritto:
> >
> > On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote:  
> > > [External]
> > >
> > > This driver supports 14-bits and 16-bits devices. All of them have a 14-bit
> > > configuration registers. All SPI trasfers, for reading AD conversion
> > > results and for writing the configuration register, fit in two bytes.
> > >
> > > The driver always uses 4-bytes xfers which seems at least pointless (maybe
> > > even harmful). This patch trims the SPI xfer len and the buffer size to
> > > two bytes.
> > >  
> >
> > The length reduction proposal is fine.
> >
> > But, this patch raises a question about endianess.
> > I'm actually wondering here if we need to see about maybe using a __be16 vs u16.
> >
> > I'm not that kernel-savy yet about some of these low-level things to be completely sure here.
> > So, I'd let someone else maybe handle it.  
> 
> Good point.. It seems that indeed not much care has been taken about
> endianess here.. Probably we need also some le16_to_cpu() and
> firends..

More complexity here :)  So a lot of earlier SPI drivers didn't set bits_per_word,
the result of this is that a read had no way to know how to unwind the endian
nature of the data.  If you do a 4 byte read, is that 4x 1 byte, 2x 2 bytes or
1x 4 bytes.  Thus the SPI subsystem had no way of knowing how to convert from
wire order of big endian to cpu endianness.  This is particularly fun as it
is common to have variable length registers on SPI devices (be it described
on the datasheet as some registers have high and low byte addresses).

In drivers where this can be set to one consistent value, then the SPI subsystem
should do the work for us. Hence this one should be fine. ( I think :)

> 
> Maybe another separate patch can be made to take care about endianess later on?
> 
> BTW Also, the  ____cacheline_aligned is a bit scaring :) I don't know
> what is that for...
> 
> >
> > Thanks
> > Alex
> >  
> > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > > ---
> > >  drivers/iio/adc/ad7949.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > > index 518044c31a73..5c2b3446fa4a 100644
> > > --- a/drivers/iio/adc/ad7949.c
> > > +++ b/drivers/iio/adc/ad7949.c
> > > @@ -54,7 +54,7 @@ struct ad7949_adc_chip {
> > >       u8 resolution;
> > >       u16 cfg;
> > >       unsigned int current_channel;
> > > -     u32 buffer ____cacheline_aligned;
> > > +     u16 buffer ____cacheline_aligned;
> > >  };
> > >
> > >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> > > @@ -67,7 +67,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> > >       struct spi_transfer tx[] = {
> > >               {
> > >                       .tx_buf = &ad7949_adc->buffer,
> > > -                     .len = 4,
> > > +                     .len = 2,
> > >                       .bits_per_word = bits_per_word,
> > >               },
> > >       };
> > > @@ -95,7 +95,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> > >       struct spi_transfer tx[] = {
> > >               {
> > >                       .rx_buf = &ad7949_adc->buffer,
> > > -                     .len = 4,
> > > +                     .len = 2,
> > >                       .bits_per_word = bits_per_word,
> > >               },
> > >       };  

