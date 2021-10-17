Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD21643087C
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhJQLtg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234082AbhJQLtg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:49:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F8960F57;
        Sun, 17 Oct 2021 11:47:24 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:51:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
Subject: Re: [PATCH v5 1/1] iio/scmi: Add reading "raw" attribute.
Message-ID: <20211017125138.4f5bbc4d@jic23-huawei>
In-Reply-To: <20211008182826.24412-2-andriy.tryshnivskyy@opensynergy.com>
References: <20211008182826.24412-1-andriy.tryshnivskyy@opensynergy.com>
        <20211008182826.24412-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 Oct 2021 21:28:26 +0300
Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:

> Add scmi_iio_get_raw() to read "raw" attribute.
> 
> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
> ---
For a single patch series, it is better to put a change log in the patch (here)
Whilst I can see why you would use this approach rather than the read_raw callback
there are significant disadvantages in doing so.  The channel can't be used
by in kernel users such as iio-hwmon.   That may cause you more trouble than
it is worth in the long run.

Note that you could also define a new IIO_VAL type to still use the two
(possibly) 32 bit values and return a 64 bit value. That way, with appropriate
additions in the consumer drivers the channel could still be used.

IIO_VAL_INT_64 perhaps with val as the lower 32 bits and val2 as the upper
with appropriate care around the sign.


>  drivers/iio/common/scmi_sensors/scmi_iio.c | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index 7cf2bf282cef..691cbbd61e3a 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -311,6 +311,62 @@ static const struct iio_info scmi_iio_info = {
>  	.write_raw = scmi_iio_write_raw,
>  };
>  
> +static ssize_t scmi_iio_get_raw(struct iio_dev *iio_dev, uintptr_t private,
> +				const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int err;
> +	u32 sensor_config;
> +	struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
> +	int len = 0;
> +
> +	err = iio_device_claim_direct_mode(iio_dev);
> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in claiming direct mode for sensor %s err %d",
> +			sensor->sensor_info->name, err);

It's not an error, it just means the device is busy, so at most dev_info()
or just rely on userspace correctly interpreting EBUSY.

> +		goto err_release;
> +	}
> +
> +	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +				   SCMI_SENS_CFG_SENSOR_ENABLE);
> +	err = sensor->sensor_ops->config_set(
> +		sensor->ph, sensor->sensor_info->id, sensor_config);
> +	if (err) {
> +		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		goto err_release;
> +	}
> +
> +	err = sensor->sensor_ops->reading_get_timestamped(
> +		sensor->ph, sensor->sensor_info->id,
> +		sensor->sensor_info->num_axis, readings);
> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in reading raw attribute for sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		goto err_release;
> +	}
> +
> +	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +				   SCMI_SENS_CFG_SENSOR_DISABLE);
> +	err = sensor->sensor_ops->config_set(
> +		sensor->ph, sensor->sensor_info->id, sensor_config);
> +	if (err) {
> +		dev_err(&iio_dev->dev, "Error in disabling sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		goto err_release;
> +	}
> +
> +	len = scnprintf(buf, PAGE_SIZE, "%lld\n",
> +			readings[chan->scan_index].value);
> +
> +err_release:
> +	iio_device_release_direct_mode(iio_dev);
> +
> +	return len;
> +}
> +
>  static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
>  					  uintptr_t private,
>  					  const struct iio_chan_spec *chan,
> @@ -355,6 +411,11 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
>  }
>  
>  static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
> +	{
> +		.name = "raw",
> +		.read = scmi_iio_get_raw,
> +		.shared = IIO_SEPARATE,
> +	},
>  	{
>  		.name = "raw_available",
>  		.read = scmi_iio_get_raw_available,

