Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5234E662
	for <lists+linux-iio@lfdr.de>; Tue, 30 Mar 2021 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhC3Lew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Mar 2021 07:34:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2746 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhC3Ler (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Mar 2021 07:34:47 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F8nF045nZz6827G;
        Tue, 30 Mar 2021 19:25:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 30 Mar 2021 13:34:45 +0200
Received: from localhost (10.47.27.39) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 30 Mar
 2021 12:34:44 +0100
Date:   Tue, 30 Mar 2021 12:33:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sudeep.holla@arm.com>,
        <lukasz.luba@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <etienne.carriere@linaro.org>,
        <thara.gopinath@linaro.org>, <vincent.guittot@linaro.org>,
        <souvik.chakravarty@arm.com>, Jyoti Bhayana <jbhayana@google.com>,
        "Jonathan Cameron" <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 25/38] iio/scmi: port driver to the new
 scmi_sensor_proto_ops interface
Message-ID: <20210330123325.00000456@Huawei.com>
In-Reply-To: <20210316124903.35011-26-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
        <20210316124903.35011-26-cristian.marussi@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.39]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Mar 2021 12:48:50 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Port driver to the new SCMI Sensor interface based on protocol handles
> and common devm_get_ops().
> 
> Cc: Jyoti Bhayana <jbhayana@google.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

+CC linux-iio@vger.kernel.org

Rule of thumb if it doesn't go there it ends up in randomly location based
on other lists and I might not see it for a few weeks :(

> ---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 91 ++++++++++------------
>  1 file changed, 41 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index 872d87ca6256..b4bdc3f3a946 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -21,8 +21,10 @@
>  
>  #define SCMI_IIO_NUM_OF_AXIS 3
>  
> +static const struct scmi_sensor_proto_ops *sensor_ops;

Hmm.   I'm not keen on globals when they really should not be necessary.
They just result in lifetimes being out of sync.  Here you are fine because
you set it to an appropriate value as the first thing you do in probe, and
I assume the function only ever returns on answer on repeated calls.

Why not put a copy of that pointer inside the struct scmi_iio_priv structures?

Otherwise this all looks like straight forward refactoring so given the
above is more a 'bad smell' than a bug and I'm rather late to the game.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +
>  struct scmi_iio_priv {
> -	struct scmi_handle *handle;
> +	struct scmi_protocol_handle *ph;
>  	const struct scmi_sensor_info *sensor_info;
>  	struct iio_dev *indio_dev;
>  	/* adding one additional channel for timestamp */
> @@ -82,7 +84,6 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
>  static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
>  {
>  	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> -	u32 sensor_id = sensor->sensor_info->id;
>  	u32 sensor_config = 0;
>  	int err;
>  
> @@ -92,27 +93,11 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
>  
>  	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>  				    SCMI_SENS_CFG_SENSOR_ENABLE);
> -
> -	err = sensor->handle->notify_ops->register_event_notifier(sensor->handle,
> -			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> -			&sensor_id, &sensor->sensor_update_nb);
> -	if (err) {
> -		dev_err(&iio_dev->dev,
> -			"Error in registering sensor update notifier for sensor %s err %d",
> -			sensor->sensor_info->name, err);
> -		return err;
> -	}
> -
> -	err = sensor->handle->sensor_ops->config_set(sensor->handle,
> -			sensor->sensor_info->id, sensor_config);
> -	if (err) {
> -		sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> -				SCMI_PROTOCOL_SENSOR,
> -				SCMI_EVENT_SENSOR_UPDATE, &sensor_id,
> -				&sensor->sensor_update_nb);
> +	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> +				     sensor_config);
> +	if (err)
>  		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
>  			sensor->sensor_info->name, err);
> -	}
>  
>  	return err;
>  }
> @@ -120,25 +105,13 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
>  static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
>  {
>  	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> -	u32 sensor_id = sensor->sensor_info->id;
>  	u32 sensor_config = 0;
>  	int err;
>  
>  	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>  				    SCMI_SENS_CFG_SENSOR_DISABLE);
> -
> -	err = sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> -			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> -			&sensor_id, &sensor->sensor_update_nb);
> -	if (err) {
> -		dev_err(&iio_dev->dev,
> -			"Error in unregistering sensor update notifier for sensor %s err %d",
> -			sensor->sensor_info->name, err);
> -		return err;
> -	}
> -
> -	err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
> -						     sensor_config);
> +	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> +				     sensor_config);
>  	if (err) {
>  		dev_err(&iio_dev->dev,
>  			"Error in disabling sensor %s with err %d",
> @@ -161,8 +134,8 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
>  	u32 sensor_config;
>  	char buf[32];
>  
> -	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> -			sensor->sensor_info->id, &sensor_config);
> +	int err = sensor_ops->config_get(sensor->ph, sensor->sensor_info->id,
> +					 &sensor_config);
>  	if (err) {
>  		dev_err(&iio_dev->dev,
>  			"Error in getting sensor config for sensor %s err %d",
> @@ -208,8 +181,8 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
>  	sensor_config |=
>  		FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
>  
> -	err = sensor->handle->sensor_ops->config_set(sensor->handle,
> -			sensor->sensor_info->id, sensor_config);
> +	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> +				     sensor_config);
>  	if (err)
>  		dev_err(&iio_dev->dev,
>  			"Error in setting sensor update interval for sensor %s value %u err %d",
> @@ -274,8 +247,8 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
>  	u32 sensor_config;
>  	int mult;
>  
> -	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> -			sensor->sensor_info->id, &sensor_config);
> +	int err = sensor_ops->config_get(sensor->ph, sensor->sensor_info->id,
> +					 &sensor_config);
>  	if (err) {
>  		dev_err(&iio_dev->dev,
>  			"Error in getting sensor config for sensor %s err %d",
> @@ -542,15 +515,17 @@ static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
>  	return 0;
>  }
>  
> -static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> -					 struct scmi_handle *handle,
> -					 const struct scmi_sensor_info *sensor_info)
> +static struct iio_dev *
> +scmi_alloc_iiodev(struct scmi_device *sdev, struct scmi_protocol_handle *ph,
> +		  const struct scmi_sensor_info *sensor_info)
>  {
>  	struct iio_chan_spec *iio_channels;
>  	struct scmi_iio_priv *sensor;
>  	enum iio_modifier modifier;
>  	enum iio_chan_type type;
>  	struct iio_dev *iiodev;
> +	struct device *dev = &sdev->dev;
> +	const struct scmi_handle *handle = sdev->handle;
>  	int i, ret;
>  
>  	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> @@ -560,7 +535,7 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
>  	iiodev->modes = INDIO_DIRECT_MODE;
>  	iiodev->dev.parent = dev;
>  	sensor = iio_priv(iiodev);
> -	sensor->handle = handle;
> +	sensor->ph = ph;
>  	sensor->sensor_info = sensor_info;
>  	sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
>  	sensor->indio_dev = iiodev;
> @@ -595,6 +570,17 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
>  					  sensor_info->axis[i].id);
>  	}
>  
> +	ret = handle->notify_ops->devm_event_notifier_register(sdev,
> +				SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> +				&sensor->sensor_info->id,
> +				&sensor->sensor_update_nb);
> +	if (ret) {
> +		dev_err(&iiodev->dev,
> +			"Error in registering sensor update notifier for sensor %s err %d",
> +			sensor->sensor_info->name, ret);
> +		return ERR_PTR(ret);
> +	}
> +
>  	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
>  	iiodev->channels = iio_channels;
>  	return iiodev;
> @@ -604,24 +590,29 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
>  {
>  	const struct scmi_sensor_info *sensor_info;
>  	struct scmi_handle *handle = sdev->handle;
> +	struct scmi_protocol_handle *ph;
>  	struct device *dev = &sdev->dev;
>  	struct iio_dev *scmi_iio_dev;
>  	u16 nr_sensors;
>  	int err = -ENODEV, i;
>  
> -	if (!handle || !handle->sensor_ops) {
> +	if (!handle)
> +		return -ENODEV;
> +
> +	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
> +	if (IS_ERR(sensor_ops)) {
>  		dev_err(dev, "SCMI device has no sensor interface\n");
> -		return -EINVAL;
> +		return PTR_ERR(sensor_ops);
>  	}
>  
> -	nr_sensors = handle->sensor_ops->count_get(handle);
> +	nr_sensors = sensor_ops->count_get(ph);
>  	if (!nr_sensors) {
>  		dev_dbg(dev, "0 sensors found via SCMI bus\n");
>  		return -ENODEV;
>  	}
>  
>  	for (i = 0; i < nr_sensors; i++) {
> -		sensor_info = handle->sensor_ops->info_get(handle, i);
> +		sensor_info = sensor_ops->info_get(ph, i);
>  		if (!sensor_info) {
>  			dev_err(dev, "SCMI sensor %d has missing info\n", i);
>  			return -EINVAL;
> @@ -636,7 +627,7 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
>  		    sensor_info->axis[0].type != RADIANS_SEC)
>  			continue;
>  
> -		scmi_iio_dev = scmi_alloc_iiodev(dev, handle, sensor_info);
> +		scmi_iio_dev = scmi_alloc_iiodev(sdev, ph, sensor_info);
>  		if (IS_ERR(scmi_iio_dev)) {
>  			dev_err(dev,
>  				"failed to allocate IIO device for sensor %s: %ld\n",

