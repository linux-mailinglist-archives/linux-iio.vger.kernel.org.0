Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B819681E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 18:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgC1RXA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 13:23:00 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45522 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RXA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 13:23:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 6C0E09E7A1D;
        Sat, 28 Mar 2020 17:22:58 +0000 (GMT)
Date:   Sat, 28 Mar 2020 17:22:56 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] iio: cros_ec: flush as hwfifo attribute
Message-ID: <20200328172256.583b483e@archlinux>
In-Reply-To: <20200327223443.6006-13-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
        <20200327223443.6006-13-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020 15:34:43 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add buffer/hwfifo_flush. It is not part of the ABI, but it follows ST
> and HID lead: Tells the sensor hub to send to the host all pending
> sensor events.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Unless I'm missing something there aren't any other drivers providing
an explicit flush attribute. The nearest equivalent is the flush
callback which reads out stuff that is in a fifo to be read, but which
hasn't yet reached a watermark to trigger normal readback.

Can we do something similar here?

If not this needs ABI documentation in Documentation/ABI/testing/...
I'm not keen on it in becoming general ABI unless I'm missing a
strong argument in favour of it.

Jonathan


> ---
> No changes in v7.
> New in v6.
> 
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index c831915ca7e56..aaf124a82e0e4 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -113,6 +113,33 @@ static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
>  	return ret;
>  }
>  
> +static ssize_t cros_ec_sensors_flush(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +	bool flush;
> +
> +	ret = strtobool(buf, &flush);
> +	if (ret < 0)
> +		return ret;
> +	if (!flush)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
> +	ret = cros_ec_motion_send_host_cmd(st, 0);
> +	if (ret != 0)
> +		dev_warn(&indio_dev->dev, "Unable to flush sensor\n");
> +	mutex_unlock(&st->cmd_lock);
> +	return ret ? ret : len;
> +}
> +
> +static IIO_DEVICE_ATTR(hwfifo_flush, 0644, NULL,
> +		       cros_ec_sensors_flush, 0);
> +
>  static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
>  						 struct device_attribute *attr,
>  						 const char *buf, size_t len)
> @@ -175,6 +202,7 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
>  static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
>  
>  const struct attribute *cros_ec_sensor_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_flush.dev_attr.attr,
>  	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
>  	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
>  	NULL,

