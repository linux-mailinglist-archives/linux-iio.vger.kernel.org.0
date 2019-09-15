Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD43B300B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfIONBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfIONBC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:01:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727C62077C;
        Sun, 15 Sep 2019 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568552462;
        bh=gadK2e/WNmG7AwcW9rBfIm6AcKfSkqCWtnzM1+NmI9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qu9hy67mlQepl0BaBBpnrubSvtUI56P7SDYZ1sHTADp65yc/5qxoZ78AncFlRkZLI
         ocFjbt8n1Vpc1PHi1LHXWfJNZAZLgml46JOmbCGaOcqzz4GbEQA4F+cdRJUWLTGJg3
         Am9MXDGZgQVHW3dR3RF6mQHDERuSAWDCwQn6PmwY=
Date:   Sun, 15 Sep 2019 14:00:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v8 4/5] iio: imu: st_lsm6dsx: always enter interrupt
 thread
Message-ID: <20190915140056.296f1e23@archlinux>
In-Reply-To: <20190915124840.GA15634@lore-desk-wlan.lan>
References: <20190913090708.1442057-1-sean@geanix.com>
        <20190913090708.1442057-5-sean@geanix.com>
        <20190915133332.3762e860@archlinux>
        <20190915124840.GA15634@lore-desk-wlan.lan>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Sep 2019 14:48:40 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Fri, 13 Sep 2019 11:07:07 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:
> >   
> > > The interrupt source can come from multiple sources,
> > > fifo and wake interrupts.
> > > Enter interrupt thread to check which interrupt that has fired.
> > > 
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 810807c52d5f..80a94335175f 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -1717,9 +1717,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
> > >  
> > >  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > >  {
> > > -	struct st_lsm6dsx_hw *hw = private;
> > > -
> > > -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> > > +	return IRQ_WAKE_THREAD;  
> > 
> > I missed this before.  Isn't this the same as just not providing a top half at all?
> > 
> > I.e. Pass null to request_threaded_irq where this function was.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Right, for the moment we do not need it. It will be probably useful adding
> buffering support for sensors that do not support hw timestamping in FIFO
> (e.g. LSM9DS1). I am fine both ways, so up to you.
Scrap it for now. I suspect someone will have a script out there that will
fire on this and generate a patch removing it.  Better to not waste people's
time!

Thanks,

Jonathan

> 
> Regards,
> Lorenzo
> 
> > 
> >   
> > >  }
> > >  
> > >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)  
> >   

