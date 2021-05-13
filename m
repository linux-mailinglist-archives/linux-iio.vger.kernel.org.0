Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33F037FC09
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhEMRCR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhEMRCI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:02:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D0E46143D;
        Thu, 13 May 2021 17:00:56 +0000 (UTC)
Date:   Thu, 13 May 2021 18:02:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/28] iio: magn: bmc150: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210513180204.2919c4b7@jic23-huawei>
In-Reply-To: <20210512154857.26cf12db@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-12-jic23@kernel.org>
        <20210512154857.26cf12db@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:48:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:37 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > probe() error paths after runtime pm is enabled, should disable it.
> > remove() should not call pm_runtime_put_noidle() as there is no
> > matching get() to have raised the reference count.  This case
> > has no affect a the runtime pm core protects against going negative.
> > 
> > Whilst here use pm_runtime_resume_and_get() to tidy things up a little.
> > coccicheck script didn't get this one due to complex code structure so
> > found by inspection.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to take a poke at it.

Still time for additional reviews as this won't go out in a non rebasing
tree for a few days yet.

Thanks,

Jonathan
> 
> > ---
> >  drivers/iio/magnetometer/bmc150_magn.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> > index d75b437a43f2..39920cb764bf 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn.c
> > @@ -262,7 +262,7 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
> >  	int ret;
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(data->dev);
> > +		ret = pm_runtime_resume_and_get(data->dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(data->dev);
> >  		ret = pm_runtime_put_autosuspend(data->dev);
> > @@ -271,9 +271,6 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
> >  	if (ret < 0) {
> >  		dev_err(data->dev,
> >  			"failed to change power state to %d\n", on);
> > -		if (on)
> > -			pm_runtime_put_noidle(data->dev);
> > -
> >  		return ret;
> >  	}
> >  #endif
> > @@ -963,12 +960,14 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(dev, "unable to register iio device\n");
> > -		goto err_buffer_cleanup;
> > +		goto err_disable_runtime_pm;
> >  	}
> >  
> >  	dev_dbg(dev, "Registered device %s\n", name);
> >  	return 0;
> >  
> > +err_disable_runtime_pm:
> > +	pm_runtime_disable(dev);
> >  err_buffer_cleanup:
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >  err_free_irq:
> > @@ -992,7 +991,6 @@ int bmc150_magn_remove(struct device *dev)
> >  
> >  	pm_runtime_disable(dev);
> >  	pm_runtime_set_suspended(dev);
> > -	pm_runtime_put_noidle(dev);
> >  
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >    
> 
> 
> 
> Thanks,
> Mauro

