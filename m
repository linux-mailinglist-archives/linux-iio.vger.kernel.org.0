Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5486B381F94
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhEPQIW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhEPQIW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:08:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3EAC6102A;
        Sun, 16 May 2021 16:07:03 +0000 (UTC)
Date:   Sun, 16 May 2021 17:08:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 26/28] iio: prox: pulsed-light-v2: Switch
 pm_runtime_resume_and_get()
Message-ID: <20210516170816.1b4c748a@jic23-huawei>
In-Reply-To: <20210512165657.1dd3f6e2@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-27-jic23@kernel.org>
        <20210512165657.1dd3f6e2@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:56:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:52 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Using this new call makes it easy to handle any errors as a result
> > of runtime resume as it exits without leaving the reference count
> > elevated.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > index c685f10b5ae4..ca8dc5cc209a 100644
> > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > @@ -154,7 +154,9 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
> >  	int tries = 10;
> >  	int ret;
> >  
> > -	pm_runtime_get_sync(&client->dev);
> > +	ret = pm_runtime_resume_and_get(&client->dev);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	/* start sample */
> >  	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);  
> 
> There's a return just after this that it is missing a call to
> pm_runtime_put_autosuspend():
> 
> 	if (ret < 0) {
>                 dev_err(&client->dev, "cannot send start measurement command");
>                 return ret;
>         }
> 
> Perhaps the best here would be to add a goto and a label before
> the return logic.
Agreed.  I've added a precursor fix patch that does exactly that.

> 
> 
> Thanks,
> Mauro

