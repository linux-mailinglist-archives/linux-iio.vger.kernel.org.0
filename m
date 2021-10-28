Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0E43E302
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJ1OGq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhJ1OGp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:06:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F395C61056;
        Thu, 28 Oct 2021 14:04:16 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:08:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v7 2/2] iio/scmi: Add reading "raw" attribute.
Message-ID: <20211028150842.2e309268@jic23-huawei>
In-Reply-To: <20211024091627.28031-3-andriy.tryshnivskyy@opensynergy.com>
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
        <20211024091627.28031-3-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Oct 2021 12:16:27 +0300
Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:

> Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
> reading "raw" attribute in scmi_iio_read_raw.
> 
> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>

@Jyoti,

looking for your Ack / or Reviewed-by tag for this one.

Thanks,

Jonathan

> ---
> Changes comparing v6 -> v7:
> * split into two patches: one for changes in core functionality,
>   another - for changes in the driver
> 
> Changes comparing v5 -> v6:
> * revert v5 changes since with scmi_iio_read_raw() the channel
>   can't be used by in kernel users (iio-hwmon)
> * returned to v3 with direct mode
> * introduce new type IIO_VAL_INT_64 to read 64-bit value
> 
> Changes comparing v4 -> v5:
> * call iio_device_release_direct_mode() on error
> * code cleanup, fix typo
> 
> Changes comparing v3 -> v4:
> * do not use scmi_iio_get_raw() for reading raw attribute due to 32-bit
>   return value limitation (actually I reverted the previous v3)
> * introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return
>   64-bit value
> * enabling/disabling and reading raw attribute is done in direct mode
> 
> Changes comparing v2 -> v3:
> * adaptation for changes in structure scmi_iio_priv (no member
>   named 'handle')
> 
> Changes comparing v0 -> v2:
> * added an error return when the error happened during config_set
> * removed redundant cast for "readings"
> * added check if raw value fits 32 bits
> 
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index 7cf2bf282cef..d538bf3ab1ef 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -279,6 +279,52 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
>  	return 0;
>  }
>  
> +static int scmi_iio_read_channel_data(struct iio_dev *iio_dev,
> +			     struct iio_chan_spec const *ch, int *val, int *val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	u32 sensor_config;
> +	struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
> +	int err;
> +
> +	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +					SCMI_SENS_CFG_SENSOR_ENABLE);
> +	err = sensor->sensor_ops->config_set(
> +		sensor->ph, sensor->sensor_info->id, sensor_config);
> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in enabling sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	err = sensor->sensor_ops->reading_get_timestamped(
> +		sensor->ph, sensor->sensor_info->id,
> +		sensor->sensor_info->num_axis, readings);
> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in reading raw attribute for sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +					SCMI_SENS_CFG_SENSOR_DISABLE);
> +	err = sensor->sensor_ops->config_set(
> +		sensor->ph, sensor->sensor_info->id, sensor_config);
> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in disabling sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	*val = lower_32_bits(readings[ch->scan_index].value);
> +	*val2 = upper_32_bits(readings[ch->scan_index].value);
> +
> +	return IIO_VAL_INT_64;
> +}
> +
>  static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>  			     struct iio_chan_spec const *ch, int *val,
>  			     int *val2, long mask)
> @@ -300,6 +346,14 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = scmi_iio_get_odr_val(iio_dev, val, val2);
>  		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(iio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = scmi_iio_read_channel_data(iio_dev, ch, val, val2);
> +		iio_device_release_direct_mode(iio_dev);
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -381,7 +435,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
>  	iio_chan->type = type;
>  	iio_chan->modified = 1;
>  	iio_chan->channel2 = mod;
> -	iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
> +	iio_chan->info_mask_separate =
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
>  	iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  	iio_chan->info_mask_shared_by_type_available =
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ);

