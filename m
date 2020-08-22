Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF75424E6E2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Aug 2020 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgHVKbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Aug 2020 06:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHVKbY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Aug 2020 06:31:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94925206BE;
        Sat, 22 Aug 2020 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598092283;
        bh=G4d1AxGKI6RgOaaY8/R9+o86gZntS45T+KnKLQ326qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UCh92EUc9zHxR0ZBUXGjsI4U0VHy5Z+abYmzNbW+pQR1OLH6JM59r2SfInO6EFqAR
         VZGO4BGkrbEESR7Vkk+MOcfAfraT0jYuLZhOv/3B4QFjzM50O1sJ87jjftCHVL3yBi
         JbPFR4OZhks62VVWQIhtF6nC2zBfnAIW5g6BfAU0=
Date:   Sat, 22 Aug 2020 11:31:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: dac: ad5686: Constify static struct
 iio_chan_spec
Message-ID: <20200822113113.01876cfc@archlinux>
In-Reply-To: <20200818193017.GA1610@rikard>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
        <20200526210223.1672-5-rikard.falkeborn@gmail.com>
        <d822bd34435902f096cdeb27ae0dc029d29bfb2c.camel@analog.com>
        <20200531144715.089886ce@archlinux>
        <20200818193017.GA1610@rikard>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Aug 2020 21:30:17 +0200
Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> On Sun, May 31, 2020 at 02:47:15PM +0100, Jonathan Cameron wrote:
> > On Wed, 27 May 2020 04:50:46 +0000
> > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >   
> > > On Tue, 2020-05-26 at 23:02 +0200, Rikard Falkeborn wrote:  
> > > > [External]
> > > > 
> > > > These are never modified and can be made const to allow the compiler to
> > > > put it in read-only memory.
> > > > 
> > > > Before:
> > > >    text    data     bss     dec     hex filename
> > > >    6642   12608      64   19314    4b72 drivers/iio/dac/ad5686.o
> > > > 
> > > > After:
> > > >    text    data     bss     dec     hex filename
> > > >   16946    2304      64   19314    4b72 drivers/iio/dac/ad5686.o
> > > >     
> > > 
> > > Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > >   
> > Applied.
> > 
> > thanks,  
> 
> Was this one really applied? I can't see it anywhere? The rest of the
> patches in the series are in Linus' tree.
> 
No idea what happened here.  Now applied to the togreg branch of iio.git
and pushed out as testing.  Sorry about that!

Jonathan

> Rikard
> 
> >   
> > > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > > ---
> > > >  drivers/iio/dac/ad5686.c | 8 ++++----
> > > >  drivers/iio/dac/ad5686.h | 2 +-
> > > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > > > index 8dd67da0a7da..6de48f618c95 100644
> > > > --- a/drivers/iio/dac/ad5686.c
> > > > +++ b/drivers/iio/dac/ad5686.c
> > > > @@ -206,12 +206,12 @@ static const struct iio_chan_spec_ext_info
> > > > ad5686_ext_info[] = {
> > > >  }
> > > >  
> > > >  #define DECLARE_AD5693_CHANNELS(name, bits, _shift)		\
> > > > -static struct iio_chan_spec name[] = {				\
> > > > +static const struct iio_chan_spec name[] = {			\
> > > >  		AD5868_CHANNEL(0, 0, bits, _shift),		\
> > > >  }
> > > >  
> > > >  #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
> > > > -static struct iio_chan_spec name[] = {				\
> > > > +static const struct iio_chan_spec name[] = {			\
> > > >  		AD5868_CHANNEL(0, 1, bits, _shift),		\
> > > >  		AD5868_CHANNEL(1, 2, bits, _shift),		\
> > > >  		AD5868_CHANNEL(2, 4, bits, _shift),		\
> > > > @@ -219,7 +219,7 @@ static struct iio_chan_spec name[] = {			
> > > > 	\
> > > >  }
> > > >  
> > > >  #define DECLARE_AD5676_CHANNELS(name, bits, _shift)		\
> > > > -static struct iio_chan_spec name[] = {				\
> > > > +static const struct iio_chan_spec name[] = {			\
> > > >  		AD5868_CHANNEL(0, 0, bits, _shift),		\
> > > >  		AD5868_CHANNEL(1, 1, bits, _shift),		\
> > > >  		AD5868_CHANNEL(2, 2, bits, _shift),		\
> > > > @@ -231,7 +231,7 @@ static struct iio_chan_spec name[] = {			
> > > > 	\
> > > >  }
> > > >  
> > > >  #define DECLARE_AD5679_CHANNELS(name, bits, _shift)		\
> > > > -static struct iio_chan_spec name[] = {				\
> > > > +static const struct iio_chan_spec name[] = {			\
> > > >  		AD5868_CHANNEL(0, 0, bits, _shift),		\
> > > >  		AD5868_CHANNEL(1, 1, bits, _shift),		\
> > > >  		AD5868_CHANNEL(2, 2, bits, _shift),		\
> > > > diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> > > > index 52009b5eef88..a15f2970577e 100644
> > > > --- a/drivers/iio/dac/ad5686.h
> > > > +++ b/drivers/iio/dac/ad5686.h
> > > > @@ -104,7 +104,7 @@ typedef int (*ad5686_read_func)(struct ad5686_state
> > > > *st, u8 addr);
> > > >  struct ad5686_chip_info {
> > > >  	u16				int_vref_mv;
> > > >  	unsigned int			num_channels;
> > > > -	struct iio_chan_spec		*channels;
> > > > +	const struct iio_chan_spec	*channels;
> > > >  	enum ad5686_regmap_type		regmap_type;
> > > >  };
> > > >      
> >   

