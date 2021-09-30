Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F418B41DF07
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350472AbhI3QbG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 12:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350390AbhI3QbG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 12:31:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDBD761250;
        Thu, 30 Sep 2021 16:29:21 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:33:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
Subject: Re: [PATCH v2 1/1] iio/scmi: Add reading "raw" attribute.
Message-ID: <20210930173316.3a111130@jic23-huawei>
In-Reply-To: <20210927132202.17335-2-andriy.tryshnivskyy@opensynergy.com>
References: <20210927132202.17335-1-andriy.tryshnivskyy@opensynergy.com>
        <20210927132202.17335-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Sep 2021 16:22:02 +0300
Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:

> Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
> reading "raw" attribute in scmi_iio_read_raw.
> 
> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Hi Andriy,

Looks good to me, but I'll leave it on list to get feedback form the
driver maintainer for this one.

Feel free to poke if no reply in next 2 weeks.

Thanks,

Jonathan

> ---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index 7cf2bf282cef..c6a9dc6ad140 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -286,6 +286,9 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>  	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
>  	s8 scale;
>  	int ret;
> +	int err;
> +	u32 sensor_config;
> +	struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -300,6 +303,45 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = scmi_iio_get_odr_val(iio_dev, val, val2);
>  		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_RAW:
> +		sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +					   SCMI_SENS_CFG_SENSOR_ENABLE);
> +		err = sensor->handle->sensor_ops->config_set(
> +			sensor->handle, sensor->sensor_info->id, sensor_config);
> +		if (err) {
> +			dev_err(&iio_dev->dev,
> +				"Error in enabling sensor %s err %d",
> +				sensor->sensor_info->name, err);
> +			return err;
> +		}
> +
> +		err = sensor->handle->sensor_ops->reading_get_timestamped(
> +			sensor->handle, sensor->sensor_info->id,
> +			sensor->sensor_info->num_axis, readings);
> +		if (err) {
> +			dev_err(&iio_dev->dev,
> +				"Error in reading raw attribute for sensor %s err %d",
> +				sensor->sensor_info->name, err);
> +			return err;
> +		}
> +
> +		sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +					   SCMI_SENS_CFG_SENSOR_DISABLE);
> +		err = sensor->handle->sensor_ops->config_set(
> +			sensor->handle, sensor->sensor_info->id, sensor_config);
> +		if (err) {
> +			dev_err(&iio_dev->dev,
> +				"Error in enabling sensor %s err %d",
> +				sensor->sensor_info->name, err);
> +			return err;
> +		}
> +		/* Check if raw value fits 32 bits */
> +		if (readings[ch->scan_index].value < INT_MIN ||
> +		    readings[ch->scan_index].value > INT_MAX)
> +			return -ERANGE;
> +		/* Use 32-bit value, since practically there is no need in 64 bits */
> +		*val = (int)readings[ch->scan_index].value;
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -381,7 +423,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
>  	iio_chan->type = type;
>  	iio_chan->modified = 1;
>  	iio_chan->channel2 = mod;
> -	iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
> +	iio_chan->info_mask_separate =
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
>  	iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  	iio_chan->info_mask_shared_by_type_available =
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ);

