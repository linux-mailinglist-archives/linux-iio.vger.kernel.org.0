Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A2E037A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 13:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbfJVLy4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 07:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbfJVLy4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 07:54:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7308521783;
        Tue, 22 Oct 2019 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571745295;
        bh=tXU8Vkg6ihJuxdFUihT8VGsq1CiZVWpb9qmWWLwa9Ic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o/4bYOjRgJ6/qv+8jnD00fIXPoCCfyT2sihYspsJFsrD+/h+hcTUCi1aaeJQ5eg1B
         JeFpum8I+mk2toKcuHNBPFoW7M/jebXM8pmqOGNqdvZOiMjmKLQY2EWvdb4OfhSgOo
         FB8+FEN5z3O3K2lmWW/SGv7I6wyjB3SfEFxxJyKM=
Date:   Tue, 22 Oct 2019 12:54:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <gregor.boirie@parrot.com>
Subject: Re: [PATCH] iio: pressure: zpa2326: fix
 iio_triggered_buffer_postenable position
Message-ID: <20191022125451.79feacdd@archlinux>
In-Reply-To: <20191005161420.34c17eea@archlinux>
References: <20190920080348.29995-1-alexandru.ardelean@analog.com>
        <20191005161420.34c17eea@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 5 Oct 2019 16:14:20 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 20 Sep 2019 11:03:48 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> > the poll functions.
> > 
> > The iio_triggered_buffer_postenable() should be called before (to attach
> > the poll func) and then the
> > 
> > The iio_triggered_buffer_predisable() function is hooked directly without
> > anything, which is probably fine, as the postenable() version seems to also
> > do some reset/wake-up of the device.
> > This will mean it will be easier when removing it; i.e. it just gets
> > removed.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> Seems straight forward but I've often been wrong before.
> Not heard from Gregor for a while, but we should give him a little more
> time to spot this one.  If nothing for another week I'll just take a
> gamble and apply it.  If I seem to have forgotten any of these give
> me a bump.
Long enough. Time to gamble :) 

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/pressure/zpa2326.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> > index 9d0d07930236..99dfe33ee402 100644
> > --- a/drivers/iio/pressure/zpa2326.c
> > +++ b/drivers/iio/pressure/zpa2326.c
> > @@ -1243,6 +1243,11 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
> >  	const struct zpa2326_private *priv = iio_priv(indio_dev);
> >  	int                           err;
> >  
> > +	/* Plug our own trigger event handler. */
> > +	err = iio_triggered_buffer_postenable(indio_dev);
> > +	if (err)
> > +		goto err;
> > +
> >  	if (!priv->waken) {
> >  		/*
> >  		 * We were already power supplied. Just clear hardware FIFO to
> > @@ -1250,7 +1255,7 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
> >  		 */
> >  		err = zpa2326_clear_fifo(indio_dev, 0);
> >  		if (err)
> > -			goto err;
> > +			goto err_buffer_predisable;
> >  	}
> >  
> >  	if (!iio_trigger_using_own(indio_dev) && priv->waken) {
> > @@ -1260,16 +1265,13 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
> >  		 */
> >  		err = zpa2326_config_oneshot(indio_dev, priv->irq);
> >  		if (err)
> > -			goto err;
> > +			goto err_buffer_predisable;
> >  	}
> >  
> > -	/* Plug our own trigger event handler. */
> > -	err = iio_triggered_buffer_postenable(indio_dev);
> > -	if (err)
> > -		goto err;
> > -
> >  	return 0;
> >  
> > +err_buffer_predisable:
> > +	iio_triggered_buffer_predisable(indio_dev);
> >  err:
> >  	zpa2326_err(indio_dev, "failed to enable buffering (%d)", err);
> >    
> 

