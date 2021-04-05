Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5098F3542E5
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 16:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhDEOgZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 10:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235915AbhDEOgZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 10:36:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FD46128D;
        Mon,  5 Apr 2021 14:36:17 +0000 (UTC)
Date:   Mon, 5 Apr 2021 15:36:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: Re: [PATCH 5/7] iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq
 request then disable
Message-ID: <20210405153633.2098774d@jic23-huawei>
In-Reply-To: <6bc3945795144f739f55a7cb817b89c9@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
        <20210402184544.488862-6-jic23@kernel.org>
        <6bc3945795144f739f55a7cb817b89c9@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Apr 2021 20:14:04 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > Sent: Saturday, April 3, 2021 7:46 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; Tomasz Duszynski
> > <tomasz.duszynski@octakon.com>
> > Subject: [PATCH 5/7] iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq request
> > then disable
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This new flag cleanly avoids the need for a dance where we request the
> > interrupt only to immediately disabling it by ensuring it is not
> > auto-enabled in the first place.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > ---  
> 
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.  Whilst they are doing that, any
additional feedback welcomed.

Thanks,

Jonathan

> 
> >  drivers/iio/chemical/scd30_core.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/scd30_core.c
> > b/drivers/iio/chemical/scd30_core.c
> > index 261c277ac4a5..d89f117dd0ef 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -655,19 +655,19 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
> > 
> >  	indio_dev->trig = iio_trigger_get(trig);
> > 
> > +	/*
> > +	 * Interrupt is enabled just before taking a fresh measurement
> > +	 * and disabled afterwards. This means we need to ensure it is not
> > +	 * enabled here to keep calls to enable/disable balanced.
> > +	 */
> >  	ret = devm_request_threaded_irq(dev, state->irq, scd30_irq_handler,
> > -					scd30_irq_thread_handler, IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +					scd30_irq_thread_handler,
> > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
> > +					IRQF_NO_AUTOEN,
> >  					indio_dev->name, indio_dev);
> >  	if (ret)
> >  		dev_err(dev, "failed to request irq\n");
> > 
> > -	/*
> > -	 * Interrupt is enabled just before taking a fresh measurement
> > -	 * and disabled afterwards. This means we need to disable it here
> > -	 * to keep calls to enable/disable balanced.
> > -	 */
> > -	disable_irq(state->irq);
> > -
> >  	return ret;
> >  }
> > 
> > --
> > 2.31.1  
> 

