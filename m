Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C621DD62D
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 20:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEUSnL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 14:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUSnK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 14:43:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22EE420738;
        Thu, 21 May 2020 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590086590;
        bh=Q6F90WsqooF9WLNW/pdvZfFVzJhXixN8Qhqoa890kP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rb9z/Pi/6VG5rTW02C+hmKhzHp41CzKHiPCVDKXm0QDntAMcZDOShoL3D4O/ov+UK
         dLmP/PmULArY6AH0W9/MRRA6ZAxJX824xRerNK5TmmUohExVv3D+WTTJKWQVSYYJ5L
         B20BDkdBHJwdI1VdYIXigezZs52UIjxaYdHQf99M=
Date:   Thu, 21 May 2020 19:43:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 10/11] iio:chemical:sps30: Fix timestamp alignment
Message-ID: <20200521194306.208ea27b@archlinux>
In-Reply-To: <20200517190728.GB18033@arch>
References: <20200517173000.220819-1-jic23@kernel.org>
        <20200517173000.220819-11-jic23@kernel.org>
        <20200517190728.GB18033@arch>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 21:07:28 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> On Sun, May 17, 2020 at 06:29:59PM +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> >
> > Fixes: 232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sensor")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  drivers/iio/chemical/sps30.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> > index acb9f8ecbb3d..a88c1fb875a0 100644
> > --- a/drivers/iio/chemical/sps30.c
> > +++ b/drivers/iio/chemical/sps30.c
> > @@ -230,15 +230,18 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct sps30_state *state = iio_priv(indio_dev);
> >  	int ret;
> > -	s32 data[4 + 2]; /* PM1, PM2P5, PM4, PM10, timestamp */
> > +	struct {
> > +		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
> > +		s64 ts;
> > +	} scan;
> >
> >  	mutex_lock(&state->lock);
> > -	ret = sps30_do_meas(state, data, 4);
> > +	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> >  	mutex_unlock(&state->lock);
> >  	if (ret)
> >  		goto err;
> >
> > -	iio_push_to_buffers_with_timestamp(indio_dev, data,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> >  					   iio_get_time_ns(indio_dev));
> >  err:
> >  	iio_trigger_notify_done(indio_dev->trig);
> > --
> > 2.26.2
> >  
> 
> Thanks for the fix.
> Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Applied to the fixes-togreg branch of iio.git.

I'm going to pick these up as and when I get reviews for them rather than
waiting for the whole series to have suitable reviews.

They are a small part of all the instances we have of this issue
so no point in waiting.

Thanks,

Jonathan
