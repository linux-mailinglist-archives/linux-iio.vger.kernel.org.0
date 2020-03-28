Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D24196820
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgC1RYz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 13:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1RYz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 13:24:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28FB206F6;
        Sat, 28 Mar 2020 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585416293;
        bh=cfzFYS/oG1CrThIAkWAcRMT2ZQr5LIDVXad2fZshHtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0/Q8eIelCZltuUoVh78VwZKzuHiGLaN31hDNO4IlSEUzHTkIQOlODwGInWw3v9f01
         w4sLdEtl1J9nomFV/j5hkc+nqUQlFIQ/unQerzO9zkEqaG2CyDIQH/kXFGKc/A3GI8
         8DY3ppYYV5jVN6N83mJHxvnJlD4lLiMlKkFLVEAE=
Date:   Sat, 28 Mar 2020 17:24:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] iio: cros_ec: flush as hwfifo attribute
Message-ID: <20200328172449.530b1fd8@archlinux>
In-Reply-To: <c3609af9-42a7-8d59-f0a4-9da3badc3668@collabora.com>
References: <20200327223443.6006-1-gwendal@chromium.org>
        <20200327223443.6006-13-gwendal@chromium.org>
        <c3609af9-42a7-8d59-f0a4-9da3badc3668@collabora.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Mar 2020 10:14:23 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Jonathan and Gwendal,
> 
> On 27/3/20 23:34, Gwendal Grignou wrote:
> > Add buffer/hwfifo_flush. It is not part of the ABI, but it follows ST
> > and HID lead: Tells the sensor hub to send to the host all pending
> > sensor events.
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> 
> I need an Ack from Jonathan to pick this.
> 
> Jonathan, once you are fine with it, do you mind if I take the full series
> through the platform chrome tree?

Once 12 is sorted (or if you want to take up to 11 thats fine) then
sure happy for you to take them.

Thanks,

Jonathan

> 
> Thanks,
>  Enric
> 
> 
> > ---
> > No changes in v7.
> > New in v6.
> > 
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index c831915ca7e56..aaf124a82e0e4 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -113,6 +113,33 @@ static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
> >  	return ret;
> >  }
> >  
> > +static ssize_t cros_ec_sensors_flush(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> > +	int ret = 0;
> > +	bool flush;
> > +
> > +	ret = strtobool(buf, &flush);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (!flush)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&st->cmd_lock);
> > +	st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
> > +	ret = cros_ec_motion_send_host_cmd(st, 0);
> > +	if (ret != 0)
> > +		dev_warn(&indio_dev->dev, "Unable to flush sensor\n");
> > +	mutex_unlock(&st->cmd_lock);
> > +	return ret ? ret : len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR(hwfifo_flush, 0644, NULL,
> > +		       cros_ec_sensors_flush, 0);
> > +
> >  static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
> >  						 struct device_attribute *attr,
> >  						 const char *buf, size_t len)
> > @@ -175,6 +202,7 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
> >  static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> >  
> >  const struct attribute *cros_ec_sensor_fifo_attributes[] = {
> > +	&iio_dev_attr_hwfifo_flush.dev_attr.attr,
> >  	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> >  	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> >  	NULL,
> >   

