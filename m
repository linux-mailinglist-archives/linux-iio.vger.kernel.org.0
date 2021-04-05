Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF283542DD
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbhDEOe5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 10:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235915AbhDEOe4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 10:34:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F026139E;
        Mon,  5 Apr 2021 14:34:48 +0000 (UTC)
Date:   Mon, 5 Apr 2021 15:35:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: Re: [PATCH 4/7] iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag
 instead of request then disable
Message-ID: <20210405153502.772d13ac@jic23-huawei>
In-Reply-To: <7df210b8251c4c118e6c0b9fe6505b61@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
        <20210402184544.488862-5-jic23@kernel.org>
        <7df210b8251c4c118e6c0b9fe6505b61@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Apr 2021 20:13:00 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > Sent: Saturday, April 3, 2021 7:46 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; Maxime Ripard <maxime.ripard@bootlin.com>
> > Subject: [PATCH 4/7] iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag instead
> > of request then disable
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This new flag ensures a requested irq is not autoenabled, thus removing
> > the need for the disable_irq() that follows and closing off any chance
> > of spurious interrupts.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---  
> 
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

Applied to the togreg branch of iio.git and pushed out as testing
to let 0-day poke at it.   Other feedback whilst it's doing that
most welcome.

Thanks,

Jonathan

> 
> >  drivers/iio/adc/sun4i-gpadc-iio.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c
> > b/drivers/iio/adc/sun4i-gpadc-iio.c
> > index 99b43f28e879..2d393a4dfff6 100644
> > --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> > +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> > @@ -470,7 +470,8 @@ static int sun4i_irq_init(struct platform_device *pdev,
> > const char *name,
> >  	}
> > 
> >  	*irq = ret;
> > -	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler, 0,
> > +	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler,
> > +					   IRQF_NO_AUTOEN,
> >  					   devname, info);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "could not request %s interrupt: %d\n",
> > @@ -478,7 +479,6 @@ static int sun4i_irq_init(struct platform_device *pdev,
> > const char *name,
> >  		return ret;
> >  	}
> > 
> > -	disable_irq(*irq);
> >  	atomic_set(atomic, 0);
> > 
> >  	return 0;
> > --
> > 2.31.1  
> 

