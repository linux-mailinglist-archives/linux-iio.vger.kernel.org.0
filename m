Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4358937BE38
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhELNbV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELNbT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 256C7613BC;
        Wed, 12 May 2021 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620826211;
        bh=fqLakbuyspav5gtoDnqJ7fkT+K5PXrana25B9WPncuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KcNf9NZKWEA0oIzjI9v/xwEsg5OyQOXw1Yl/oacfeOmzSJWz7wxAGkLmL02GSRx1C
         BQewNOPzd61253ZcQGCrZok+cOrD+FjV1TiFmQK6dE3F5idomhl3YLd6Anw8K2M798
         t8Q2tgoEmapCo2SmWfqTtTtvIsLhNj6UMznRHqajTvglMJpleDQ4QnHdmQdaV7Vq6a
         KRgXiFXiMlvEtWMpWOtl3Khz/X/7ADwbSIBhNBwZiiSnjseSnKj6dDouHeQX6O/ZTC
         k1yAnD+NjqG44UkO3EGYTAzoTWqZwC+GZfNw/BJDdF89hJ/SwzQKIudunp2RaY5FTz
         YOpuYHkXbe1fA==
Date:   Wed, 12 May 2021 15:30:05 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH 01/28] iio: gyro: fxa210002c: Balance runtime pm + use
 pm_runtime_resume_and_get().
Message-ID: <20210512153005.0a9b1fb8@coco.lan>
In-Reply-To: <20210512152243.48c2fc74@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-2-jic23@kernel.org>
        <20210512152243.48c2fc74@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Wed, 12 May 2021 15:22:43 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Sun,  9 May 2021 12:33:27 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > In both the probe() error path and remove() pm_runtime_put_noidle()
> > is called which will decrement the runtime pm reference count.
> > However, there is no matching function to have raised the reference count.
> > Not this isn't a fix as the runtime pm core will stop the reference count
> > going negative anyway.
> > 
> > An alternative would have been to raise the count in these paths, but
> > it is not clear why that would be necessary.
> > 
> > Whilst we are here replace some boilerplate with pm_runtime_resume_and_get()
> > Found using coccicheck script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Rui Miguel Silva <rui.silva@linaro.org>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hmm...not quite...

> > diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> > index 5af7b48ff01a..539585b0d300 100644
> > --- a/drivers/iio/gyro/fxas21002c_core.c
> > +++ b/drivers/iio/gyro/fxas21002c_core.c
> > @@ -366,14 +366,7 @@ static int fxas21002c_write(struct fxas21002c_data *data,
> >  
> >  static int  fxas21002c_pm_get(struct fxas21002c_data *data)
> >  {
> > -	struct device *dev = regmap_get_device(data->regmap);
> > -	int ret;
> > -
> > -	ret = pm_runtime_get_sync(dev);
> > -	if (ret < 0)
> > -		pm_runtime_put_noidle(dev);
> > -
> > -	return ret;
> > +	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
> >  }

fxas21002c_temp_get() and fxas21002c_axis_get() seem to be
missing a pm_runtime_put*() if something gets wrong at
regmap_field_read(), e. g.:

static int fxas21002c_axis_get(struct fxas21002c_data *data,
                               int index, int *val)
{
        struct device *dev = regmap_get_device(data->regmap);
        __be16 axis_be;
        int ret;

        mutex_lock(&data->lock);
        ret = fxas21002c_pm_get(data);
        if (ret < 0)
                goto data_unlock;

        ret = regmap_bulk_read(data->regmap, FXAS21002C_AXIS_TO_REG(index),
                               &axis_be, sizeof(axis_be));
        if (ret < 0) {
                dev_err(dev, "failed to read axis: %d: %d\n", index, ret);
+		fxas21002c_pm_put(data);
                goto data_unlock;
        }

	*val = sign_extend32(be16_to_cpu(axis_be), 15);

        ret = fxas21002c_pm_put(data);
        if (ret < 0)
                goto data_unlock;

        ret = IIO_VAL_INT;

data_unlock:
	mutex_unlock(&data->lock);

        return ret;
}

Thanks,
Mauro
