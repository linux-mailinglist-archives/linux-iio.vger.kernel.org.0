Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD0DF35E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 18:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfJUQmt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 12:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUQmt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 12:42:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753A920659;
        Mon, 21 Oct 2019 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571676168;
        bh=8srR2iv2Jx5/DQEobogfVbMkbZT9v5jyBlATknotPU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fNWkeapk6BhvpZXXWBLIrC1UlsorM5zAUYE/tRsn3LKQnWSsn5rYLt9IWw9b4sYrI
         8t4U6jL/6qPpZR/l+pUy5l1TD/RAxUG51X0wwHOFuSXatg82rGRWI0DGH0/2zHV8Yh
         sFfLCpjV2v2APF61+5TjnOvcl8dK1Ilwb4f9XhYw=
Date:   Mon, 21 Oct 2019 17:42:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 17/18] iio: cros_ec: Report hwfifo_watermark_max
Message-ID: <20191021174243.35160ae8@archlinux>
In-Reply-To: <20191021055403.67849-18-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
        <20191021055403.67849-18-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019 22:54:02 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Report the maximum amount of sample the EC can hold.
> This is not tunable, but can be useful for application to find out the
> maximum amount of time it can sleep when hwfifo_timeout is set to a
> large number.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes in v2:
> - Remove double lines, add line before return for visibility.
> 
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 34 +++++++++++++++++--
>  .../linux/iio/common/cros_ec_sensors_core.h   |  3 ++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 92128c67a166e..f50e239f9a1e9 100644
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
> @@ -150,8 +163,22 @@ static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
>  		       cros_ec_sensor_get_report_latency,
>  		       cros_ec_sensor_set_report_latency, 0);
>  
> +static ssize_t hwfifo_watermark_max_show(
> +		struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
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
> @@ -281,12 +308,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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
>  		ret = devm_iio_triggered_buffer_setup(
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 387ca9e61dac8..4df3abd151fbf 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -51,6 +51,7 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
>   *				the timestamp. The timestamp is always last and
>   *				is always 8-byte aligned.
>   * @read_ec_sensors_data:	function used for accessing sensors values
> + * @fifo_max_event_count:	Size of the EC sensor FIFO
>   */
>  struct cros_ec_sensors_core_state {
>  	struct cros_ec_device *ec;
> @@ -73,6 +74,8 @@ struct cros_ec_sensors_core_state {
>  	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
>  				    unsigned long scan_mask, s16 *data);
>  
> +	u32 fifo_max_event_count;
> +
>  	/* Table of known available frequencies : 0, Min and Max in mHz */
>  	int frequencies[3];
>  };

