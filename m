Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62CF37FBB3
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhEMQmR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232650AbhEMQmQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:42:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 369B1611CE;
        Thu, 13 May 2021 16:41:03 +0000 (UTC)
Date:   Thu, 13 May 2021 17:42:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/28] iio: accel: mma9551/3: Balance untime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210513174212.3a98f45a@jic23-huawei>
In-Reply-To: <20210512153757.22938ffb@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-7-jic23@kernel.org>
        <20210512153757.22938ffb@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:37:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:32 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Both these drivers call pm_runtime_put_no_idle() when the reference
> > count should already be zero as there is no matching get()
> > 
> > Whilst here use pm_runtime_resume_and_get() rather than open coding.  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied. Thanks,
> > ---
> >  drivers/iio/accel/mma9551.c      | 1 -
> >  drivers/iio/accel/mma9551_core.c | 4 +---
> >  drivers/iio/accel/mma9553.c      | 1 -
> >  3 files changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> > index 08a2303cc9df..4c359fb05480 100644
> > --- a/drivers/iio/accel/mma9551.c
> > +++ b/drivers/iio/accel/mma9551.c
> > @@ -515,7 +515,6 @@ static int mma9551_remove(struct i2c_client *client)
> >  
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  
> >  	mutex_lock(&data->mutex);
> >  	mma9551_set_device_state(data->client, false);
> > diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> > index 666e7a04a7d7..fbf2e2c45678 100644
> > --- a/drivers/iio/accel/mma9551_core.c
> > +++ b/drivers/iio/accel/mma9551_core.c
> > @@ -664,7 +664,7 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
> >  	int ret;
> >  
> >  	if (on)
> > -		ret = pm_runtime_get_sync(&client->dev);
> > +		ret = pm_runtime_resume_and_get(&client->dev);
> >  	else {
> >  		pm_runtime_mark_last_busy(&client->dev);
> >  		ret = pm_runtime_put_autosuspend(&client->dev);
> > @@ -673,8 +673,6 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
> >  	if (ret < 0) {
> >  		dev_err(&client->dev,
> >  			"failed to change power state to %d\n", on);
> > -		if (on)
> > -			pm_runtime_put_noidle(&client->dev);
> >  
> >  		return ret;
> >  	}
> > diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> > index c15908faa381..ba3ecb3b57dc 100644
> > --- a/drivers/iio/accel/mma9553.c
> > +++ b/drivers/iio/accel/mma9553.c
> > @@ -1154,7 +1154,6 @@ static int mma9553_remove(struct i2c_client *client)
> >  
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  
> >  	mutex_lock(&data->mutex);
> >  	mma9551_set_device_state(data->client, false);  
> 
> 
> 
> Thanks,
> Mauro

