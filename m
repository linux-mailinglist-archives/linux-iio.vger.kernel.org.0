Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9A1964B5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 10:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgC1JO3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 05:14:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41424 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1JO2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 05:14:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F15282967C4
Subject: Re: [PATCH v7 12/12] iio: cros_ec: flush as hwfifo attribute
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200327223443.6006-1-gwendal@chromium.org>
 <20200327223443.6006-13-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c3609af9-42a7-8d59-f0a4-9da3badc3668@collabora.com>
Date:   Sat, 28 Mar 2020 10:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327223443.6006-13-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan and Gwendal,

On 27/3/20 23:34, Gwendal Grignou wrote:
> Add buffer/hwfifo_flush. It is not part of the ABI, but it follows ST
> and HID lead: Tells the sensor hub to send to the host all pending
> sensor events.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

I need an Ack from Jonathan to pick this.

Jonathan, once you are fine with it, do you mind if I take the full series
through the platform chrome tree?

Thanks,
 Enric


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
> 
