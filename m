Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E51E0207
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfJVK0S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 06:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfJVK0S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 06:26:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33372207FC;
        Tue, 22 Oct 2019 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571739976;
        bh=R3whxNOQMkAakpvysXSpP00HzyZ6LNM/fohXNc0m1CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jXWqncx9cPzrBa9cB1elcKwCQ16RgBm8KdXVjtqTOZqiajf1QfbJObWqnuFUbvfdV
         2WBEiTxIBgzJz/kssmW7Nm/2WzCia1Px4e+Ga6ubdzB9bXEtL+UgK33WK3H2Go/8ay
         aIxW3AlrNhbkpM22udgK4AJydZ75m5VxQogjGMUQ=
Date:   Tue, 22 Oct 2019 11:26:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: tsl4030: Use false / true instead of 0 / 1
 with booleans
Message-ID: <20191022112613.4d90f2a0@archlinux>
In-Reply-To: <20191020130644.jyd3zdnmxcgksdbs@earth.universe>
References: <20191013163754.2044672-1-jic23@kernel.org>
        <20191020130644.jyd3zdnmxcgksdbs@earth.universe>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019 15:06:44 +0200
Sebastian Reichel <sre@kernel.org> wrote:

> Hi,
> 
> On Sun, Oct 13, 2019 at 05:37:54PM +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Suggestion from coccinelle / coccicheck
> > 
> > CHECK   drivers/iio/adc/twl4030-madc.c
> > drivers/iio/adc/twl4030-madc.c:524:6-15: WARNING: Comparison of 0/1 to bool variable
> > drivers/iio/adc/twl4030-madc.c:655:1-43: WARNING: Assignment of 0/1 to bool variable
> > drivers/iio/adc/twl4030-madc.c:659:2-44: WARNING: Assignment of 0/1 to bool variable
> > drivers/iio/adc/twl4030-madc.c:664:1-43: WARNING: Assignment of 0/1 to bool variable
> > drivers/iio/adc/twl4030-madc.c:498:2-34: WARNING: Assignment of 0/1 to bool variable
> > drivers/iio/adc/twl4030-madc.c:510:2-19: WARNING: Assignment of 0/1 to bool variable
> > drivers/iio/adc/twl4030-madc.c:511:2-11: WARNING: Assignment of 0/1 to bool variable
> > drivers/iio/adc/twl4030-madc.c:531:2-19: WARNING: Assignment of 0/1 to bool variable
> > drivers/iio/adc/twl4030-madc.c:532:2-11: WARNING: Assignment of 0/1 to bool variable
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > ---  
> 
> Apart from the typo in the patch subject (tsl4030 vs twl4030):
> 
Fixed :)
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan

> 
> -- Sebastian
> 
> >  drivers/iio/adc/twl4030-madc.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> > index 55c5119fe575..472b08f37fea 100644
> > --- a/drivers/iio/adc/twl4030-madc.c
> > +++ b/drivers/iio/adc/twl4030-madc.c
> > @@ -495,7 +495,7 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
> >  		ret = twl4030_madc_disable_irq(madc, i);
> >  		if (ret < 0)
> >  			dev_dbg(madc->dev, "Disable interrupt failed %d\n", i);
> > -		madc->requests[i].result_pending = 1;
> > +		madc->requests[i].result_pending = true;
> >  	}
> >  	for (i = 0; i < TWL4030_MADC_NUM_METHODS; i++) {
> >  		r = &madc->requests[i];
> > @@ -507,8 +507,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
> >  		len = twl4030_madc_read_channels(madc, method->rbase,
> >  						 r->channels, r->rbuf, r->raw);
> >  		/* Free request */
> > -		r->result_pending = 0;
> > -		r->active = 0;
> > +		r->result_pending = false;
> > +		r->active = false;
> >  	}
> >  	mutex_unlock(&madc->lock);
> >  
> > @@ -521,15 +521,15 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
> >  	 */
> >  	for (i = 0; i < TWL4030_MADC_NUM_METHODS; i++) {
> >  		r = &madc->requests[i];
> > -		if (r->active == 0)
> > +		if (!r->active)
> >  			continue;
> >  		method = &twl4030_conversion_methods[r->method];
> >  		/* Read results */
> >  		len = twl4030_madc_read_channels(madc, method->rbase,
> >  						 r->channels, r->rbuf, r->raw);
> >  		/* Free request */
> > -		r->result_pending = 0;
> > -		r->active = 0;
> > +		r->result_pending = false;
> > +		r->active = false;
> >  	}
> >  	mutex_unlock(&madc->lock);
> >  
> > @@ -652,16 +652,16 @@ static int twl4030_madc_conversion(struct twl4030_madc_request *req)
> >  	ret = twl4030_madc_start_conversion(twl4030_madc, req->method);
> >  	if (ret < 0)
> >  		goto out;
> > -	twl4030_madc->requests[req->method].active = 1;
> > +	twl4030_madc->requests[req->method].active = true;
> >  	/* Wait until conversion is ready (ctrl register returns EOC) */
> >  	ret = twl4030_madc_wait_conversion_ready(twl4030_madc, 5, method->ctrl);
> >  	if (ret) {
> > -		twl4030_madc->requests[req->method].active = 0;
> > +		twl4030_madc->requests[req->method].active = false;
> >  		goto out;
> >  	}
> >  	ret = twl4030_madc_read_channels(twl4030_madc, method->rbase,
> >  					 req->channels, req->rbuf, req->raw);
> > -	twl4030_madc->requests[req->method].active = 0;
> > +	twl4030_madc->requests[req->method].active = false;
> >  
> >  out:
> >  	mutex_unlock(&twl4030_madc->lock);
> > -- 
> > 2.23.0
> >   

