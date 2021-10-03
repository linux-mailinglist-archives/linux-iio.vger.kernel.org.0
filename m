Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE2420250
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhJCPlr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhJCPlr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:41:47 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFCAB61181;
        Sun,  3 Oct 2021 15:39:57 +0000 (UTC)
Date:   Sun, 3 Oct 2021 16:43:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiri Valek - 2N <valek@2n.cz>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexander Koch <mail@alexanderkoch.net>,
        Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH] iio: light: opt3001: Fixed timeout error when 0 lux
Message-ID: <20211003164355.3757c44f@jic23-huawei>
In-Reply-To: <20210926145514.5395fdc6@jic23-huawei>
References: <20210920125351.6569-1-valek@2n.cz>
        <20210926145514.5395fdc6@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Sep 2021 14:55:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 20 Sep 2021 14:53:48 +0200
> Jiri Valek - 2N <valek@2n.cz> wrote:
> 
> > Reading from sensor returned timeout error under
> > zero light conditions.
> > 
> > Signed-off-by: Jiri Valek - 2N <valek@2n.cz>  
> Hi Jiri,
> 
> Thanks for this. Looks good to me though I'll leave a little longer for others
> to take a look.
> 
> Does need a fixes tag though so we know how far to backport it.
> I think it should be
> 
> Fixes: ac663db3678a ("iio: light: opt3001: enable operation w/o IRQ")
> 
> +Cc Alexander and Andreas

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/light/opt3001.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > index 52963da401a7..1880bd5bb258 100644
> > --- a/drivers/iio/light/opt3001.c
> > +++ b/drivers/iio/light/opt3001.c
> > @@ -276,6 +276,8 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
> >  		ret = wait_event_timeout(opt->result_ready_queue,
> >  				opt->result_ready,
> >  				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> > +		if (ret == 0)
> > +			return -ETIMEDOUT;
> >  	} else {
> >  		/* Sleep for result ready time */
> >  		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
> > @@ -312,9 +314,7 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
> >  		/* Disallow IRQ to access the device while lock is active */
> >  		opt->ok_to_ignore_lock = false;
> >  
> > -	if (ret == 0)
> > -		return -ETIMEDOUT;
> > -	else if (ret < 0)
> > +	if (ret < 0)
> >  		return ret;
> >  
> >  	if (opt->use_irq) {  
> 

