Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766A83542D7
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhDEOdW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 10:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235915AbhDEOdV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 10:33:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7998161284;
        Mon,  5 Apr 2021 14:33:13 +0000 (UTC)
Date:   Mon, 5 Apr 2021 15:33:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: Re: [PATCH 3/7] iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of
 request then disable
Message-ID: <20210405153327.3ff5e1f3@jic23-huawei>
In-Reply-To: <cad32695dac24a109b0004d613cc66db@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
        <20210402184544.488862-4-jic23@kernel.org>
        <cad32695dac24a109b0004d613cc66db@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Apr 2021 20:12:13 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > Sent: Saturday, April 3, 2021 7:46 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; Alexandre Belloni
> > <alexandre.belloni@bootlin.com>
> > Subject: [PATCH 3/7] iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of request
> > then disable
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Whilst a race during interrupt enabling is probably not a problem,
> > it is better to not enable the interrupt at all.  The new
> > IRQF_NO_AUTOEN flag allows us to do that.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---  
> 
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Applied and pushed out as testing to let the autobuilders test it a bit.
Still time for others to respond though as I can rebase for at least the
next few days as I expect I'll do a pull request mid week.

Thanks,

Jonathan

> 
> >  drivers/iio/adc/nau7802.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> > index 07c85434b568..bb70b51d25b1 100644
> > --- a/drivers/iio/adc/nau7802.c
> > +++ b/drivers/iio/adc/nau7802.c
> > @@ -498,7 +498,8 @@ static int nau7802_probe(struct i2c_client *client,
> >  		ret = request_threaded_irq(client->irq,
> >  				NULL,
> >  				nau7802_eoc_trigger,
> > -				IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +				IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
> > +				IRQF_NO_AUTOEN,
> >  				client->dev.driver->name,
> >  				indio_dev);
> >  		if (ret) {
> > @@ -513,8 +514,7 @@ static int nau7802_probe(struct i2c_client *client,
> >  			dev_info(&client->dev,
> >  				"Failed to allocate IRQ, using polling mode\n");
> >  			client->irq = 0;
> > -		} else
> > -			disable_irq(client->irq);
> > +		}
> >  	}
> > 
> >  	if (!client->irq) {
> > --
> > 2.31.1  
> 

