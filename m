Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3EEF6918
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 14:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfKJNWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 08:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfKJNWY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 08:22:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98EFA20842;
        Sun, 10 Nov 2019 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573392143;
        bh=8qRGQlNb0NNlvmAAGVGchFPZ4u0P5bCVwRjo69e0/gI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wjlmKiLFpbv2ix3IqJTlQ0zj/tQdI2Jq4icwhd0Sh9wpzm3bfsb8bAd0E1wXbABb6
         tByWUPhhVXViD0lSGQRGRc9IaTRfamMoosizhO5mrTRbxHy4227z8Xhe5N5nBJDEHP
         R5IcBHK5AWCve92+LD/Vumtd1q8Fi1U4x+CEVpMQ=
Date:   Sun, 10 Nov 2019 13:22:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 16/17] iio: cros_ec: Report hwfifo_watermark_max
Message-ID: <20191110132216.0ab3773f@archlinux>
In-Reply-To: <20191105222652.70226-17-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-17-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Nov 2019 14:26:51 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Report the maximum amount of sample the EC can hold.
> This is not tunable, but can be useful for application to find out the
> maximum amount of time it can sleep when hwfifo_timeout is set to a
> large number.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes in v4:
> - Check patch with --strict option
>     Alignement
> No changes in v3.
> Changes in v2:
> - Remove double lines, add line before return for visibility.
> 
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 33 +++++++++++++++++--
>  .../linux/iio/common/cros_ec_sensors_core.h   |  3 ++
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 62dc1e4aa7a8..4169c6c055d8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -23,6 +23,12 @@
>  #include <linux/platform_data/cros_ec_sensorhub.h>
>  #include <linux/platform_device.h>
>  
> +/*
> + * Hard coded to the first device to support sensor fifo.  The EC has a 2048
> + * byte fifo and will trigger an interrupt when fifo is 2/3 full.
> + */
> +#define CROS_EC_FIFO_SIZE (2048 * 2 / 3)
> +
>  static char *cros_ec_loc[] = {
>  	[MOTIONSENSE_LOC_BASE] = "base",
>  	[MOTIONSENSE_LOC_LID] = "lid",
> @@ -56,8 +62,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>  
>  static void get_default_min_max_freq(enum motionsensor_type type,
>  				     u32 *min_freq,
> -				     u32 *max_freq)
> +				     u32 *max_freq,
> +				     u32 *max_fifo_events)
>  {
> +	/*
> +	 * We don't know fifo size, set to size previously used by older
> +	 * hardware.
> +	 */
> +	*max_fifo_events = CROS_EC_FIFO_SIZE;
> +
>  	switch (type) {
>  	case MOTIONSENSE_TYPE_ACCEL:
>  	case MOTIONSENSE_TYPE_GYRO:
> @@ -150,8 +163,21 @@ static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
>  		       cros_ec_sensor_get_report_latency,
>  		       cros_ec_sensor_set_report_latency, 0);
>  
> +static ssize_t hwfifo_watermark_max_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->fifo_max_event_count);
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> +
>  const struct attribute *cros_ec_sensor_fifo_attributes[] = {
>  	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
>  	NULL,
>  };
>  EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
> @@ -287,12 +313,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		if (state->msg->version < 3) {
>  			get_default_min_max_freq(state->resp->info.type,
>  						 &state->frequencies[1],
> -						 &state->frequencies[2]);
> +						 &state->frequencies[2],
> +						 &state->fifo_max_event_count);
>  		} else {
>  			state->frequencies[1] =
>  			    state->resp->info_3.min_frequency;
>  			state->frequencies[2] =
>  			    state->resp->info_3.max_frequency;
> +			state->fifo_max_event_count =
> +			    state->resp->info_3.fifo_max_event_count;
>  		}
>  
>  		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 5b0acc14c891..bc26ae2e3272 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -50,6 +50,7 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
>   *				the timestamp. The timestamp is always last and
>   *				is always 8-byte aligned.
>   * @read_ec_sensors_data:	function used for accessing sensors values
> + * @fifo_max_event_count:	Size of the EC sensor FIFO
>   */
>  struct cros_ec_sensors_core_state {
>  	struct cros_ec_device *ec;
> @@ -72,6 +73,8 @@ struct cros_ec_sensors_core_state {
>  	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
>  				    unsigned long scan_mask, s16 *data);
>  
> +	u32 fifo_max_event_count;
> +
>  	/* Table of known available frequencies : 0, Min and Max in mHz */
>  	int frequencies[3];
>  };

