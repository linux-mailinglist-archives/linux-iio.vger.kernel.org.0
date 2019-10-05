Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB94CCAB8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 17:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfJEPKB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 11:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJEPKA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:10:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CB1222CC;
        Sat,  5 Oct 2019 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570288200;
        bh=05cXZcOQfviqrT6u4Q3W8u46CwhUF/1aaa02yZbGWRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K9s1lEdXDjBYwQ7p+PVkkqP/9XiTDQmJMrDKoSMAeWjQ8vxPLt0Hm+f5hYymGTCVw
         N0dHeVAZDFAaTkCbPeCNLfPRdNo3NQQOCCiem/ej7BcB/1Py2Xbikr8g6T/wZM2LPq
         gVGZduny9CTx9bJ6xAZbxkyCIjdZ72QjvaMWYDo4=
Date:   Sat, 5 Oct 2019 16:09:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Dannenberg <dannenberg@ti.com>
Cc:     David Frey <dpfrey@gmail.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: opt3001: fix mutex unlock race
Message-ID: <20191005160948.2abb5bcf@archlinux>
In-Reply-To: <20190920174037.6zfjcx36bejhoa5v@jiji>
References: <20190919225418.20512-1-dpfrey@gmail.com>
        <20190920174037.6zfjcx36bejhoa5v@jiji>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Sep 2019 12:40:37 -0500
Andreas Dannenberg <dannenberg@ti.com> wrote:

> David,
> 
> On Thu, Sep 19, 2019 at 03:54:18PM -0700, David Frey wrote:
> > When an end-of-conversion interrupt is received after performing a
> > single-shot reading of the light sensor, the driver was waking up the
> > result ready queue before checking opt->ok_to_ignore_lock to determine
> > if it should unlock the mutex. The problem occurred in the case where
> > the other thread woke up and changed the value of opt->ok_to_ignore_lock
> > to false prior to the interrupt thread performing its read of the
> > variable. In this case, the mutex would be unlocked twice.
> > 
> > Signed-off-by: David Frey <dpfrey@gmail.com>
> > ---  
> 
> Good find, thanks for the submission.
> 
> Reviewed-by: Andreas Dannenberg <dannenberg@ti.com>

I think this goes all the way back to the initial driver so I've added
a fixes tag for that and marked it for stable.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> 
> --
> Andreas Dannenberg
> Texas Instruments Inc
> 
> >  drivers/iio/light/opt3001.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > index e666879007d2..92004a2563ea 100644
> > --- a/drivers/iio/light/opt3001.c
> > +++ b/drivers/iio/light/opt3001.c
> > @@ -686,6 +686,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
> >  	struct iio_dev *iio = _iio;
> >  	struct opt3001 *opt = iio_priv(iio);
> >  	int ret;
> > +	bool wake_result_ready_queue = false;
> >  
> >  	if (!opt->ok_to_ignore_lock)
> >  		mutex_lock(&opt->lock);
> > @@ -720,13 +721,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
> >  		}
> >  		opt->result = ret;
> >  		opt->result_ready = true;
> > -		wake_up(&opt->result_ready_queue);
> > +		wake_result_ready_queue = true;
> >  	}
> >  
> >  out:
> >  	if (!opt->ok_to_ignore_lock)
> >  		mutex_unlock(&opt->lock);
> >  
> > +	if (wake_result_ready_queue)
> > +		wake_up(&opt->result_ready_queue);
> > +
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -- 
> > 2.23.0
> >   

