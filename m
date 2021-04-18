Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1E363496
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhDRKU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 06:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhDRKU5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 06:20:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F99B61090;
        Sun, 18 Apr 2021 10:20:26 +0000 (UTC)
Date:   Sun, 18 Apr 2021 11:20:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Message-ID: <20210418112058.7bb04fa6@jic23-huawei>
In-Reply-To: <CY4PR03MB3112BFAA334A280B0E04CB88994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
        <20210413112105.69458-5-nuno.sa@analog.com>
        <CA+U=DsqeiRRGp+Q+yZ7OVOE719aBiyMoBLsFTZL3amGfWHtgkg@mail.gmail.com>
        <CY4PR03MB3112C342E901F4E308D0AFF0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
        <CY4PR03MB3112BFAA334A280B0E04CB88994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Apr 2021 08:16:30 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Sa, Nuno <Nuno.Sa@analog.com>
> > Sent: Thursday, April 15, 2021 9:54 AM
> > To: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > <jic23@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: RE: [PATCH 4/7] iio: adis16475: re-set max spi transfer
> > 
> > [External]
> > 
> > 
> >   
> > > -----Original Message-----
> > > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > Sent: Wednesday, April 14, 2021 9:29 AM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > <jic23@kernel.org>; Hennerich, Michael
> > > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > > <lars@metafoo.de>
> > > Subject: Re: [PATCH 4/7] iio: adis16475: re-set max spi transfer
> > >
> > > [External]
> > >
> > > On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com>
> > > wrote:  
> > > >
> > > > In case 'spi_sync()' fails, we would be left with a max spi transfer
> > > > which is not the one the user expects it to be. Hence, we need to  
> > re-  
> > > set  
> > > > it also in this error path.
> > > >
> > > > Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/iio/imu/adis16475.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/imu/adis16475.c  
> > b/drivers/iio/imu/adis16475.c  
> > > > index 51b76444db0b..9dca7e506200 100644
> > > > --- a/drivers/iio/imu/adis16475.c
> > > > +++ b/drivers/iio/imu/adis16475.c
> > > > @@ -1067,8 +1067,10 @@ static irqreturn_t  
> > > adis16475_trigger_handler(int irq, void *p)  
> > > >         adis->spi->max_speed_hz = ADIS16475_BURST_MAX_SPEED;
> > > >
> > > >         ret = spi_sync(adis->spi, &adis->msg);  
> > >
> > > Purely stylistic here.
> > > But, the restore from the cached variable could be done here in a
> > > single line.
> > > So. just moving [1] here.  
> > 
> > You mean also doing it in the label? I thought about that and the
> > reason
> > why I didn't is that on a normal run, I want to reset the max freq as
> > soon
> > as possible so that if someone concurrently tries to read 'direct mode'
> > attrs
> > gets the max freq. This was my reasoning but I admit that it's not that
> > important so I will leave this to Jonathan's preference...
> > 
> > Hmm now that I spoke about the concurrently access to IIO attr and
> > being paranoid about
> > the compiler, I wonder if we should not use
> > WRITE_ONCE(adis->spi->max_speed_hz,
> > ADIS16475_BURST_MAX_SPEED)...  
> 
> Hmmm, actually WRITE_ONCE would not be any help since the spi core
> does not use READ_ONCE. So, if we are going to be paranoid about the
> compiler and load/store tearing, I guess the only safe way here is to
> acquire the adis lock [btw, I'm a bit paranoid with this stuff :)]...
> 
> Anyways, arguably the likelihood for this to happen is really, really small... 

Really small, but needs fixing.  We shouldn't have a window in which this
can happen.  So either we need to stop those attributes from reading whilst
we are in buffered mode (via claim_direct_mode pattern) or we need to put
a lock around this.  As an alternative, could we use the speed_hz field
in appropriate spi_transfer structures to tweak in this path without
affecting others?  That should make this concurrency problem an issue
for the spi core (which I'd assume handles this).

I'm going to hold this series for now on basis we should resolve this whilst
here.

Jonathan


