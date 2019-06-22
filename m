Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579C04F53A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFVKZS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKZS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:25:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C1CA2075E;
        Sat, 22 Jun 2019 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561199116;
        bh=KAGG74HFs0qnbDhzuy88Dh54pxhgZXlhCGOiJW1r0I4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DgMcbIv2mrOV2mCx2w4t4PlAMEQl8dWkYtuT0sRZq51/8BOugHv3i9hf+4Q44sBlf
         C/vQWu78KQZa3g7rP+6V40hic+amEMT+9p9zFVXps+WYeIFvE0r/RVMMY4EKIkhjB4
         MGf7kOEIJPNQUkOyNaY9KEbNqUinp7Tmn5CqEYKU=
Date:   Sat, 22 Jun 2019 11:07:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iio: common: cros_ec_sensors: move channels to
 core structure
Message-ID: <20190622110715.4d614f29@archlinux>
In-Reply-To: <c17b3dc3e268b3eff08bc524175b84ca7feb8ed6.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
        <c17b3dc3e268b3eff08bc524175b84ca7feb8ed6.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jun 2019 11:06:33 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> To avoid code duplication, we move channels initialization in
> cros_ec_sensors_core.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Hi Fabien,

In of itself a fairly minor gain in code sharing and at some slight
cost in readability. Still on balance worthwhile I think.
Minor stuff inline.

Thanks,

Jonathan

> ---
>  .../common/cros_ec_sensors/cros_ec_sensors.c  | 49 ++++++-------------
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 25 +++++++++-
>  drivers/iio/light/cros_ec_light_prox.c        | 42 ++++------------
>  drivers/iio/pressure/cros_ec_baro.c           | 38 +++-----------
>  .../linux/iio/common/cros_ec_sensors_core.h   | 24 ++++++++-
>  5 files changed, 78 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index c59b0ab8fe7d..897dc83a3355 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -28,8 +28,6 @@
>  struct cros_ec_sensors_state {
>  	/* Shared by all sensors */
>  	struct cros_ec_sensors_core_state core;
> -
> -	struct iio_chan_spec channels[CROS_EC_SENSORS_MAX_CHANNELS];
>  };
>  
>  static int cros_ec_sensors_read(struct iio_dev *indio_dev,
> @@ -178,7 +176,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_sensors_state *state;
> -	struct iio_chan_spec *channel;
>  	int ret, i;
>  
>  	if (!ec_dev || !ec_dev->ec_dev) {
> @@ -186,63 +183,49 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	ret = cros_ec_sensors_core_init(pdev, sizeof(*state),
> +					CROS_EC_SENSORS_MAX_CHANNELS, true);
>  	if (ret)
>  		return ret;
>  
> +	indio_dev = platform_get_drvdata(pdev);
>  	state = iio_priv(indio_dev);
> -	for (channel = state->channels, i = CROS_EC_SENSOR_X;
> -	     i < CROS_EC_SENSOR_MAX_AXIS; i++, channel++) {
> +	for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++) {
>  		/* Common part */
> -		channel->info_mask_separate =
> +		cros_ec_core_channel_init(state->core.channels, i + 1);
Given this is kind of 'partially' initializing the channel, perhaps
we can name it as something that hints at that.

cros_ec_core_channel_common_init() or something like that?

> +		state->core.channels[i + 1].info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_CALIBBIAS);
> -		channel->info_mask_shared_by_all =
> +		state->core.channels[i + 1].info_mask_shared_by_all =
>  			BIT(IIO_CHAN_INFO_SCALE) |
>  			BIT(IIO_CHAN_INFO_FREQUENCY) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ);
> -		channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> -		channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
> -		channel->scan_index = i;
> -		channel->ext_info = cros_ec_sensors_ext_info;
> -		channel->modified = 1;
> -		channel->channel2 = IIO_MOD_X + i;
> -		channel->scan_type.sign = 's';
> +		state->core.channels[i + 1].scan_index = i;
> +		state->core.channels[i + 1].modified = 1;
> +		state->core.channels[i + 1].channel2 = IIO_MOD_X + i;
> +		state->core.channels[i + 1].scan_type.sign = 's';
>  
>  		/* Sensor specific */
>  		switch (state->core.type) {
>  		case MOTIONSENSE_TYPE_ACCEL:
> -			channel->type = IIO_ACCEL;
> +			state->core.channels[i + 1].type = IIO_ACCEL;
>  			break;
>  		case MOTIONSENSE_TYPE_GYRO:
> -			channel->type = IIO_ANGL_VEL;
> +			state->core.channels[i + 1].type = IIO_ANGL_VEL;
>  			break;
>  		case MOTIONSENSE_TYPE_MAG:
> -			channel->type = IIO_MAGN;
> +			state->core.channels[i + 1].type = IIO_MAGN;
>  			break;
>  		default:
>  			dev_err(&pdev->dev, "Unknown motion sensor\n");
>  			return -EINVAL;
>  		}
>  	}
> +	state->core.channels[0].scan_index = CROS_EC_SENSOR_MAX_AXIS;
> +
>  	state->core.info.read_raw = &cros_ec_sensors_read;
>  	state->core.info.write_raw = &cros_ec_sensors_write;
>  
> -	/* Timestamp */
> -	channel->type = IIO_TIMESTAMP;
> -	channel->channel = -1;
> -	channel->scan_index = CROS_EC_SENSOR_MAX_AXIS;
> -	channel->scan_type.sign = 's';
> -	channel->scan_type.realbits = 64;
> -	channel->scan_type.storagebits = 64;
> -
> -	indio_dev->channels = state->channels;
> -	indio_dev->num_channels = CROS_EC_SENSORS_MAX_CHANNELS;
> -
>  	/* There is only enough room for accel and gyro in the io space */
>  	if ((state->core.ec->cmd_readmem != NULL) &&
>  	    (state->core.type != MOTIONSENSE_TYPE_MAG))
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index a1b324e1a5d8..e5181e007dd7 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -26,15 +26,25 @@ static char *cros_ec_loc[] = {
>  };
>  
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
> -			      struct iio_dev *indio_dev,
> +			      int sizeof_priv,
> +			      int num_channels,
>  			      bool physical_device)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> +	struct cros_ec_sensors_core_state *state;
>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> +	struct iio_dev *indio_dev;
> +
> +	if (num_channels > CROS_EC_SENSORS_CORE_MAX_CHANNELS)
> +		return -EINVAL;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof_priv);
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, indio_dev);
> +	state = iio_priv(indio_dev);
>  
>  	state->ec = ec->ec_dev;
>  	state->msg = devm_kzalloc(&pdev->dev,
> @@ -70,6 +80,17 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  
>  	indio_dev->info = &state->info;
>  
> +	/* Timestamp channel */
> +	state->channels[0].type = IIO_TIMESTAMP;
> +	state->channels[0].channel = -1;
> +	state->channels[0].scan_index = 0;
> +	state->channels[0].scan_type.sign = 's';
> +	state->channels[0].scan_type.realbits = 64;
> +	state->channels[0].scan_type.storagebits = 64;
> +
> +	indio_dev->channels = state->channels;
> +	indio_dev->num_channels = num_channels;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index b319d95fb70f..32ea5afd495f 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -31,8 +31,6 @@
>  struct cros_ec_light_prox_state {
>  	/* Shared by all sensors */
>  	struct cros_ec_sensors_core_state core;
> -
> -	struct iio_chan_spec channels[CROS_EC_LIGHT_PROX_MAX_CHANNELS];
>  };
>  
>  static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
> @@ -167,7 +165,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_light_prox_state *state;
> -	struct iio_chan_spec *channel;
>  	int ret;
>  
>  	if (!ec_dev || !ec_dev->ec_dev) {
> @@ -175,46 +172,38 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	ret = cros_ec_sensors_core_init(pdev, sizeof(*state),
> +					CROS_EC_LIGHT_PROX_MAX_CHANNELS, true);
>  	if (ret)
>  		return ret;
>  
> +	indio_dev = platform_get_drvdata(pdev);
>  	state = iio_priv(indio_dev);
>  	state->core.type = state->core.resp->info.type;
>  	state->core.loc = state->core.resp->info.location;
>  	state->core.info.read_raw = &cros_ec_light_prox_read;
>  	state->core.info.write_raw = &cros_ec_light_prox_write;
> -	channel = state->channels;
>  
>  	/* Common part */
> -	channel->info_mask_shared_by_all =
> +	cros_ec_core_channel_init(state->core.channels, 1);
> +	state->core.channels[1].info_mask_shared_by_all =
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_FREQUENCY);
> -	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> -	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
> -	channel->scan_type.shift = 0;
> -	channel->scan_index = 0;
> -	channel->ext_info = cros_ec_sensors_ext_info;
> -	channel->scan_type.sign = 'u';
>  
>  	state->core.calib[0] = 0;
>  
>  	/* Sensor specific */
>  	switch (state->core.type) {
>  	case MOTIONSENSE_TYPE_LIGHT:
> -		channel->type = IIO_LIGHT;
> -		channel->info_mask_separate =
> +		state->core.channels[1].type = IIO_LIGHT;
> +		state->core.channels[1].info_mask_separate =
>  			BIT(IIO_CHAN_INFO_PROCESSED) |
>  			BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  			BIT(IIO_CHAN_INFO_CALIBSCALE);
>  		break;
>  	case MOTIONSENSE_TYPE_PROX:
> -		channel->type = IIO_PROXIMITY;
> -		channel->info_mask_separate =
> +		state->core.channels[1].type = IIO_PROXIMITY;
> +		state->core.channels[1].info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  			BIT(IIO_CHAN_INFO_CALIBSCALE);
> @@ -224,19 +213,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	/* Timestamp */
> -	channel++;
> -	channel->type = IIO_TIMESTAMP;
> -	channel->channel = -1;
> -	channel->scan_index = 1;
> -	channel->scan_type.sign = 's';
> -	channel->scan_type.realbits = 64;
> -	channel->scan_type.storagebits = 64;
> -
> -	indio_dev->channels = state->channels;
> -
> -	indio_dev->num_channels = CROS_EC_LIGHT_PROX_MAX_CHANNELS;
> -
>  	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 85a4864e3a4e..8718036d74d2 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -29,8 +29,6 @@
>  struct cros_ec_baro_state {
>  	/* Shared by all sensors */
>  	struct cros_ec_sensors_core_state core;
> -
> -	struct iio_chan_spec channels[CROS_EC_BARO_MAX_CHANNELS];
>  };
>  
>  static int cros_ec_baro_read(struct iio_dev *indio_dev,
> @@ -113,7 +111,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_baro_state *state;
> -	struct iio_chan_spec *channel;
>  	int ret;
>  
>  	if (!ec_dev || !ec_dev->ec_dev) {
> @@ -121,57 +118,38 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	ret = cros_ec_sensors_core_init(pdev, sizeof(*state),
> +					CROS_EC_BARO_MAX_CHANNELS, true);
>  	if (ret)
>  		return ret;
>  
> +	indio_dev = platform_get_drvdata(pdev);
>  	state = iio_priv(indio_dev);
>  	state->core.type = state->core.resp->info.type;
>  	state->core.loc = state->core.resp->info.location;
>  	state->core.info.read_raw = &cros_ec_baro_read;
>  	state->core.info.write_raw = &cros_ec_baro_write;
> -	channel = state->channels;
> +
>  	/* Common part */
> -	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> -	channel->info_mask_shared_by_all =
> +	cros_ec_core_channel_init(state->core.channels, 1);
> +	state->core.channels[1].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	state->core.channels[1].info_mask_shared_by_all =
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_FREQUENCY);
> -	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> -	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
> -	channel->scan_type.shift = 0;
> -	channel->scan_index = 0;
> -	channel->ext_info = cros_ec_sensors_ext_info;
> -	channel->scan_type.sign = 'u';
>  
>  	state->core.calib[0] = 0;
>  
>  	/* Sensor specific */
>  	switch (state->core.type) {
>  	case MOTIONSENSE_TYPE_BARO:
> -		channel->type = IIO_PRESSURE;
> +		state->core.channels[1].type = IIO_PRESSURE;
>  		break;
>  	default:
>  		dev_warn(dev, "Unknown motion sensor\n");
>  		return -EINVAL;
>  	}
>  
> -	/* Timestamp */
> -	channel++;
> -	channel->type = IIO_TIMESTAMP;
> -	channel->channel = -1;
> -	channel->scan_index = 1;
> -	channel->scan_type.sign = 's';
> -	channel->scan_type.realbits = 64;
> -	channel->scan_type.storagebits = 64;
> -
> -	indio_dev->channels = state->channels;
> -	indio_dev->num_channels = CROS_EC_BARO_MAX_CHANNELS;
> -
>  	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index a729e667f760..485c649b421f 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -31,6 +31,8 @@ enum {
>  /* Minimum sampling period to use when device is suspending */
>  #define CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY 1000  /* 1 second */
>  
> +#define CROS_EC_SENSORS_CORE_MAX_CHANNELS 8
> +
>  /**
>   * struct cros_ec_sensors_core_state - state data for EC sensors IIO driver
>   * @ec:				cros EC device structure
> @@ -71,6 +73,7 @@ struct cros_ec_sensors_core_state {
>  
>  	int curr_sampl_freq;
>  	struct iio_info info;
> +	struct iio_chan_spec channels[CROS_EC_SENSORS_CORE_MAX_CHANNELS];
>  };
>  
>  /**
> @@ -102,13 +105,15 @@ struct platform_device;
>  /**
>   * cros_ec_sensors_core_init() - basic initialization of the core structure
>   * @pdev:		platform device created for the sensors
> - * @indio_dev:		iio device structure of the device
> + * @sizeof_priv:	size of the private structure
> + * @num_channels:	Number of channel
>   * @physical_device:	true if the device refers to a physical device
>   *
>   * Return: 0 on success, -errno on failure.
>   */
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
> -			      struct iio_dev *indio_dev, bool physical_device);
> +			      int sizeof_priv, int num_channels,
> +			      bool physical_device);
>  
>  /**
>   * cros_ec_sensors_capture() - the trigger handler function
> @@ -124,6 +129,21 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>   */
>  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
>  
> +/**
> + * cros_ec_core_channel_init() - initialize channel
> + * @channel:		channels table
> + * @idx:		channel index to initialize
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +#define cros_ec_core_channel_init(channel, idx) \
> +	channel[idx].scan_type.realbits = CROS_EC_SENSOR_BITS;\
> +	channel[idx].scan_type.storagebits = CROS_EC_SENSOR_BITS;\
> +	channel[idx].scan_type.shift = 0;\

No need to define the 'obvious' 0 shift case. 
These must already be initialized to zero or all sorts of things are
going to potentially break.

> +	channel[idx].scan_index = idx;\
> +	channel[idx].ext_info = cros_ec_sensors_ext_info;\
> +	channel[idx].scan_type.sign = 'u';
> +
>  /**
>   * cros_ec_motion_send_host_cmd() - send motion sense host command
>   * @st:		pointer to state information for device

