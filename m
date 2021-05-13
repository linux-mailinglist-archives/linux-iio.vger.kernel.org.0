Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9131037FBE1
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhEMQ7B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhEMQ7B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:59:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EBD6121E;
        Thu, 13 May 2021 16:57:48 +0000 (UTC)
Date:   Thu, 13 May 2021 17:58:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH 22/28] iio: light: vcnl4035: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210513175857.602b2d66@jic23-huawei>
In-Reply-To: <20210512163954.5c5b8fc0@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-23-jic23@kernel.org>
        <20210512163954.5c5b8fc0@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:39:54 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:48 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Found using coccicheck script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Parthiban Nallathambi <pn@denx.de>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if they can find anything we missed.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/light/vcnl4035.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> > index 691a54b763e1..fd2f181b16db 100644
> > --- a/drivers/iio/light/vcnl4035.c
> > +++ b/drivers/iio/light/vcnl4035.c
> > @@ -144,9 +144,7 @@ static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
> >  	struct device *dev = &data->client->dev;
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(dev);
> > -		if (ret < 0)
> > -			pm_runtime_put_noidle(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(dev);
> >  		ret = pm_runtime_put_autosuspend(dev);  
> 
> 
> 
> Thanks,
> Mauro

