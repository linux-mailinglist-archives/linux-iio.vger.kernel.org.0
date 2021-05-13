Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB737FC12
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhEMRGb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhEMRGa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:06:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BEC6143D;
        Thu, 13 May 2021 17:05:18 +0000 (UTC)
Date:   Thu, 13 May 2021 18:06:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 05/28] iio: accel: mma8452: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210513180627.4370d489@jic23-huawei>
In-Reply-To: <20210512153710.6d8957a2@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-6-jic23@kernel.org>
        <20210512153710.6d8957a2@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:37:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:31 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Remove() callback calls pm_runtime_put_noidle() but there it is not
> > balancing a get.  No actual affect because the runtime pm core prevents
> > the reference count going negative.
> > 
> > Whilst here use pm_runtime_resume_and_get() rather than open coded version.
> > Again, coccinelle script missed this one due to more complex code
> > structure.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sean Nyekjaer <sean@geanix.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Note additional reviews / tags are find for now as I'm happy to rebase this
tree as needed until it goes out as togreg (when I try not to!)

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/accel/mma8452.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index 464a6bfe6746..715b8138fb71 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -221,7 +221,7 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
> >  	int ret;
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(&client->dev);
> > +		ret = pm_runtime_resume_and_get(&client->dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(&client->dev);
> >  		ret = pm_runtime_put_autosuspend(&client->dev);
> > @@ -230,8 +230,6 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
> >  	if (ret < 0) {
> >  		dev_err(&client->dev,
> >  			"failed to change power state to %d\n", on);
> > -		if (on)
> > -			pm_runtime_put_noidle(&client->dev);
> >  
> >  		return ret;
> >  	}
> > @@ -1711,7 +1709,6 @@ static int mma8452_remove(struct i2c_client *client)
> >  
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >  	mma8452_trigger_cleanup(indio_dev);  
> 
> 
> 
> Thanks,
> Mauro

