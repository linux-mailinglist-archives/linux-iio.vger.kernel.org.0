Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB881DD62F
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEUSoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 14:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUSoJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 14:44:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58F120738;
        Thu, 21 May 2020 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590086648;
        bh=979vgpPRBYFX46F78Qqnzd3BnUa8Zbqj5zdptnCS0I8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JVcz+iqQ8FUbDHsK1eg3wJO+tukBPOsDZp+PCebDLlNRpkzDR10JXRVE+9znEmzNV
         jGM3/nK2hXEYPZmKKHqc07ekSrg6NVaJXAVz1wDZiPvOKTmvNm4LuRzjeNH5AKzzjK
         y5N6aC+jALY9MSylFE+9fRtRBDIpCllkaANU47Hc=
Date:   Thu, 21 May 2020 19:44:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 11/11] iio:chemical:pms7003: Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200521194404.2102a3ff@archlinux>
In-Reply-To: <20200517190655.GA18033@arch>
References: <20200517173000.220819-1-jic23@kernel.org>
        <20200517173000.220819-12-jic23@kernel.org>
        <20200517190655.GA18033@arch>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 21:06:55 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> On Sun, May 17, 2020 at 06:30:00PM +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable structure in the iio_priv() data with alignment
> > explicitly requested.  This data is allocated with kzalloc so no
> > data can leak appart from previous readings.
> >
> > Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  drivers/iio/chemical/pms7003.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
> > index 23c9ab252470..07bb90d72434 100644
> > --- a/drivers/iio/chemical/pms7003.c
> > +++ b/drivers/iio/chemical/pms7003.c
> > @@ -73,6 +73,11 @@ struct pms7003_state {
> >  	struct pms7003_frame frame;
> >  	struct completion frame_ready;
> >  	struct mutex lock; /* must be held whenever state gets touched */
> > +	/* Used to construct scan to push to the IIO buffer */
> > +	struct {
> > +		u16 data[3]; /* PM1, PM2P5, PM10 */
> > +		s64 ts;
> > +	} scan;
> >  };
> >
> >  static int pms7003_do_cmd(struct pms7003_state *state, enum pms7003_cmd cmd)
> > @@ -104,7 +109,6 @@ static irqreturn_t pms7003_trigger_handler(int irq, void *p)
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct pms7003_state *state = iio_priv(indio_dev);
> >  	struct pms7003_frame *frame = &state->frame;
> > -	u16 data[3 + 1 + 4]; /* PM1, PM2P5, PM10, padding, timestamp */
> >  	int ret;
> >
> >  	mutex_lock(&state->lock);
> > @@ -114,12 +118,15 @@ static irqreturn_t pms7003_trigger_handler(int irq, void *p)
> >  		goto err;
> >  	}
> >
> > -	data[PM1] = pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
> > -	data[PM2P5] = pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
> > -	data[PM10] = pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
> > +	state->scan.data[PM1] =
> > +		pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
> > +	state->scan.data[PM2P5] =
> > +		pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
> > +	state->scan.data[PM10] =
> > +		pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
> >  	mutex_unlock(&state->lock);
> >
> > -	iio_push_to_buffers_with_timestamp(indio_dev, data,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &state->scan,
> >  					   iio_get_time_ns(indio_dev));
> >  err:
> >  	iio_trigger_notify_done(indio_dev->trig);
> > --
> > 2.26.2
> >  
> 
> Thanks for the fix.
> Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> 
Applied. Thanks,

