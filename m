Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA711B87E9
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDYRCu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:02:50 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56982 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDYRCu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 13:02:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 142339E762F;
        Sat, 25 Apr 2020 18:02:44 +0100 (BST)
Date:   Sat, 25 Apr 2020 18:02:43 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: adc: ad7476: remove redundant null check on
 an array
Message-ID: <20200425180243.18ff7f13@archlinux>
In-Reply-To: <20200425180110.3ffa5696@archlinux>
References: <20200424130419.22940-1-colin.king@canonical.com>
        <f2c6d3f3f8f884e87f1c9895fe99b77e8f4c1e3e.camel@analog.com>
        <20200425180110.3ffa5696@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 18:01:10 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 24 Apr 2020 15:01:26 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Fri, 2020-04-24 at 14:04 +0100, Colin King wrote:  
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > The null check on st->chip_info->convst_channel is redundant because
> > > convst_channel is a 2 element array of struct iio_chan_spec objects
> > > and this can never be null. Fix this by removing the null check.
> > >     
> > 
> > Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> Applied to the togreg branch of iio.git and pushed out as testing.
> I didn't take this as a fix as it's not doing any harm in the meantime
> whilst this patch goes the slow route.
Just noticed this is in next only currently!  Hence can definitely
got he slow route as doesn't apply to mainline :)

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> >   
> > > Addresses-Coverity: ("Array compared against 0")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/iio/adc/ad7476.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > > index e9984a38fc4c..4e816d714ad2 100644
> > > --- a/drivers/iio/adc/ad7476.c
> > > +++ b/drivers/iio/adc/ad7476.c
> > > @@ -309,7 +309,7 @@ static int ad7476_probe(struct spi_device *spi)
> > >  	indio_dev->num_channels = 2;
> > >  	indio_dev->info = &ad7476_info;
> > >  
> > > -	if (st->convst_gpio && st->chip_info->convst_channel)
> > > +	if (st->convst_gpio)
> > >  		indio_dev->channels = st->chip_info->convst_channel;
> > >  	/* Setup default message */
> > >      
> 

