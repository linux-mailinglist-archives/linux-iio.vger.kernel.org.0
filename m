Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997F8474D2
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFPNmJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 09:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfFPNmJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 09:42:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B723D2133D;
        Sun, 16 Jun 2019 13:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560692528;
        bh=tSbRzbrtt/zEflDQDg9uIaA4GWFGCnT9f9zwbV/BW+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y3C8R9giyk6um4wcjEAnRPvSqf2+Xu6/5HdK8EUrkQiRtdYxXTv4kpHpzTGjtQLVA
         vmsdwyql6gWlxM8jYiMMdtbXSEGH+mUeQyE/5keh68451j60ibs8dRAj+5JuPYlIf6
         OwvBBGhbplZqVY6GTXBLIeGJ0CtU0bO3vyksA05g=
Date:   Sun, 16 Jun 2019 14:42:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        martin@geanix.com
Subject: Re: [RFC PATCH 3/3] iio: imu: st_lsm6dsx: add wake on accelerometer
 threshold hook in sysfs
Message-ID: <20190616144202.6ba14dbb@archlinux>
In-Reply-To: <20190615083557.GA5778@localhost.localdomain>
References: <20190614122604.52935-1-sean@geanix.com>
        <20190614122604.52935-4-sean@geanix.com>
        <20190615083557.GA5778@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 Jun 2019 10:35:58 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > This adds a wakeup threshold hook in sysfs, it enables us to
> > change the threshold value on the run.
> > For now this is the raw register value...
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 34 ++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >   
> 
> What about using write_event_config routine pointer for it instead od adding a sysfs
> entries?
> @Jonathan: what do you think?
I must admit this support has me a little confused.

Is what is actually going on here that we are implementing generic
threshold events, but instead of reporting them as interrupts and through the
usual userspace pipeline we are using a wakeup aware gpio to bring the
system out of suspend?

If that's the case then I'd like to see these supported as normal IIO events
first, and then look at adding the general ability to use these as wakeup
events if the particular interrupt line happens to support it.  This isn't
really a thing specific to this device, but rather something that we should
be enable on any threshold event.   Clearly for a driver to support it, there
must be a means of preventing it going too deeply to sleep so each
driver is likely to need some specific handling.

To get a remotely predictable interface we might need to have
enables more directly tied to the actual events than they would be
using the power/wakeup interface. That discussion would need to
involve the power management people as well. In particular I can see
you might want different events enabled when going to sleep than
at other times, so we might to have additional wakeup specific
enable attributes, and perhaps thresholds?

I can see something like:
/sys/bus/iio/devices/iio\:device0/events/in_accel_x_thresh_rising_[wakeup]value
/sys/bus/iio/devices/iio\:device0/events/in_accel_x_thresh_rising_wakeup

Making some sense.

Jonathan

> 
> Regards,
> Lorenzo
> 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 2c8ad7d65d2f..cbcd7920f05d 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -657,12 +657,45 @@ static ssize_t st_lsm6dsx_sysfs_set_wakeup_enabled(struct device *dev,
> >  	return len;
> >  }
> >  
> > +static ssize_t st_lsm6dsx_sysfs_get_wakeup_threshold(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    char *buf)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > +
> > +	return sprintf(buf, "%d\n", hw->wake_threshold);
> > +}
> > +
> > +static ssize_t st_lsm6dsx_sysfs_set_wakeup_threshold(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    const char *buf, size_t len)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > +	int threshold;
> > +
> > +	if (kstrtoint(buf, 0, &threshold))
> > +		return -EINVAL;
> > +
> > +	if ((threshold < 0) || (threshold > 31))
> > +		return -EINVAL;
> > +
> > +	if (!st_lsm6dsx_set_wake_threshold(hw, threshold))
> > +		return len;
> > +
> > +	return -EINVAL;
> > +}
> > +
> >  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_avail);
> >  static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
> >  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
> >  static IIO_DEVICE_ATTR(wakeup_enabled, 0644,
> >  		       st_lsm6dsx_sysfs_get_wakeup_enabled,
> >  		       st_lsm6dsx_sysfs_set_wakeup_enabled, 0);
> > +static IIO_DEVICE_ATTR(wakeup_threshold, 0644,
> > +		       st_lsm6dsx_sysfs_get_wakeup_threshold,
> > +		       st_lsm6dsx_sysfs_set_wakeup_threshold, 0);
> >  static IIO_DEVICE_ATTR(in_anglvel_scale_available, 0444,
> >  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
> >  
> > @@ -670,6 +703,7 @@ static struct attribute *st_lsm6dsx_acc_attributes[] = {
> >  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> >  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> >  	&iio_dev_attr_wakeup_enabled.dev_attr.attr,
> > +	&iio_dev_attr_wakeup_threshold.dev_attr.attr,
> >  	NULL,
> >  };
> >  
> > -- 
> > 2.22.0
> >   

