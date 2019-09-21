Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC60B9F22
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfIURQw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Sep 2019 13:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfIURQw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Sep 2019 13:16:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66188217F5;
        Sat, 21 Sep 2019 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569086211;
        bh=6uwuyY3BECt4RFZlstdISFftAuM+OMyuwPgnzeUukGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AvQfokTX7JJHiH2gjWrAyaxFlK/KiGWrkBSs/hoIOZ+E20QOn3T9Ewud7dNayqXsV
         45JlCx+iLR9k4p9GLSMXAaL9g4RZDOCxAABrKfAZCgdqu4JEDdoalVk21bW1pk3/Zl
         n0WgqEQlh7ZeHd6OyExuZZoedor679bTQEwnd00w=
Date:   Sat, 21 Sep 2019 18:16:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "antoine.couret@essensium.com" <antoine.couret@essensium.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Message-ID: <20190921181646.668008be@archlinux>
In-Reply-To: <961ddc8a028cb683ba6706e2f8a23fbd7bf68651.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
        <20190912144310.7458-3-andrea.merello@gmail.com>
        <3fe869be01ce7c81fd463158c05e0a4a115bdd6a.camel@analog.com>
        <CAN8YU5MpLDVEfVBUBe9XsuYT6yohruiHAMQgOVjZs-2JyO=NNQ@mail.gmail.com>
        <20190915113600.26fe4987@archlinux>
        <961ddc8a028cb683ba6706e2f8a23fbd7bf68651.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 07:51:30 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-09-15 at 11:36 +0100, Jonathan Cameron wrote:
> > On Fri, 13 Sep 2019 09:56:56 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >   
> > > Il giorno ven 13 set 2019 alle ore 08:46 Ardelean, Alexandru
> > > <alexandru.Ardelean@analog.com> ha scritto:  
> > > > On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote:    
> > > > > [External]
> > > > > 
> > > > > This driver supports 14-bits and 16-bits devices. All of them have a 14-bit
> > > > > configuration registers. All SPI trasfers, for reading AD conversion
> > > > > results and for writing the configuration register, fit in two bytes.
> > > > > 
> > > > > The driver always uses 4-bytes xfers which seems at least pointless (maybe
> > > > > even harmful). This patch trims the SPI xfer len and the buffer size to
> > > > > two bytes.
> > > > >    
> > > > 
> > > > The length reduction proposal is fine.
> > > > 
> > > > But, this patch raises a question about endianess.
> > > > I'm actually wondering here if we need to see about maybe using a __be16 vs u16.
> > > > 
> > > > I'm not that kernel-savy yet about some of these low-level things to be completely sure here.
> > > > So, I'd let someone else maybe handle it.    
> > > 
> > > Good point.. It seems that indeed not much care has been taken about
> > > endianess here.. Probably we need also some le16_to_cpu() and
> > > firends..  
> > 
> > More complexity here :)  So a lot of earlier SPI drivers didn't set bits_per_word,
> > the result of this is that a read had no way to know how to unwind the endian
> > nature of the data.  If you do a 4 byte read, is that 4x 1 byte, 2x 2 bytes or
> > 1x 4 bytes.  Thus the SPI subsystem had no way of knowing how to convert from
> > wire order of big endian to cpu endianness.  This is particularly fun as it
> > is common to have variable length registers on SPI devices (be it described
> > on the datasheet as some registers have high and low byte addresses).
> > 
> > In drivers where this can be set to one consistent value, then the SPI subsystem
> > should do the work for us. Hence this one should be fine. ( I think :)
> >   
> 
> Based on other input:
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

I've applied this to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Note, as we don't have a proven case in which it causes actual harm, I haven't
marked it for stable.

Thanks,

Jonathan

> 
> > > Maybe another separate patch can be made to take care about endianess later on?
> > > 
> > > BTW Also, the  ____cacheline_aligned is a bit scaring :) I don't know
> > > what is that for...
> > >   
> > > > Thanks
> > > > Alex
> > > >    
> > > > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > > > > ---
> > > > >  drivers/iio/adc/ad7949.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > > > > index 518044c31a73..5c2b3446fa4a 100644
> > > > > --- a/drivers/iio/adc/ad7949.c
> > > > > +++ b/drivers/iio/adc/ad7949.c
> > > > > @@ -54,7 +54,7 @@ struct ad7949_adc_chip {
> > > > >       u8 resolution;
> > > > >       u16 cfg;
> > > > >       unsigned int current_channel;
> > > > > -     u32 buffer ____cacheline_aligned;
> > > > > +     u16 buffer ____cacheline_aligned;
> > > > >  };
> > > > > 
> > > > >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> > > > > @@ -67,7 +67,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> > > > >       struct spi_transfer tx[] = {
> > > > >               {
> > > > >                       .tx_buf = &ad7949_adc->buffer,
> > > > > -                     .len = 4,
> > > > > +                     .len = 2,
> > > > >                       .bits_per_word = bits_per_word,
> > > > >               },
> > > > >       };
> > > > > @@ -95,7 +95,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> > > > >       struct spi_transfer tx[] = {
> > > > >               {
> > > > >                       .rx_buf = &ad7949_adc->buffer,
> > > > > -                     .len = 4,
> > > > > +                     .len = 2,
> > > > >                       .bits_per_word = bits_per_word,
> > > > >               },
> > > > >       };    

