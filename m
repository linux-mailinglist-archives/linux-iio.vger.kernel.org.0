Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12141886E
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 13:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhIZLy7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 26 Sep 2021 07:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhIZLy6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 07:54:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6037661038;
        Sun, 26 Sep 2021 11:53:21 +0000 (UTC)
Date:   Sun, 26 Sep 2021 12:57:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baptiste Mansuy <bmansuy@invensense.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: mpu6050: add watermark support for
 icm20602/20690
Message-ID: <20210926125710.3e7c9e8e@jic23-huawei>
In-Reply-To: <20210924123124.25831-1-bmansuy@invensense.com>
References: <20210924123124.25831-1-bmansuy@invensense.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Sep 2021 14:31:24 +0200
Baptiste Mansuy <bmansuy@invensense.com> wrote:

> Add watermark support using FIFO interrupt for chips having this
> feature. This allows the use of the watermark interrupt with the
> posibility to change it's size. Change the timestamp computation
> to be used with the watermark.
> 
> Add the set_watermark and flush callbacks according to the iio
> description.
> 
> Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>

Hi Baptiste,

From discussion on v1 and the changes made here I think we've ended up
inconsistent and we should avoid that even if it means that in some corner
cases perhaps we aren't operating in the best possible mode.
Probably my fault that I wasn't clear in v1 discussion.

So I think you need to just pretend the hwfifo limit is always 7/8 of the true
value  and clamp to that.

I don't really like the 'hack' nature of clamping the value but without
some rather more sophisticated code taking into account 99.9999% latency
or similar perhaps it's the best we can do :(

Thanks,

Jonathan
> ---
>  V1 -> V2: Changed watermark computation following the latest ABI
>  
...


> +int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsigned int val)
> +{
> +	unsigned int nb_byte, new_size_byte;
> +	int ret;
> +
> +	nb_byte = inv_mpu6050_get_sample_size(st);
> +
> +	/*
> +	 * Compute watermark size.
> +	 *
> +	 * Use a threshold when watermark size is not supported by the chip
> +	 * to prevent overwriting the first samples of the fifo.
> +	 * The threshold creates latency for the computing of the interrupt.
> +	 * When using a sampling frequency of 500Hz, the max latency is 12ms.
> +	 */
> +	new_size_byte = val * nb_byte;
> +	if (new_size_byte > st->hw->fifo_size) {

This is a little odd. You report a max size of st->hw->fifo_size/nb_byte, and indeed
allow the value to go up to that.  However if the value set is larger than that value
you reduce the hw fifo down to 7/8 of that value.

I'm not against enforcing this lower maximum fifo size but I think you should
report it as the max possible for consistency and clamp to that.


> +		val = ((st->hw->fifo_size * 7) / 8) / nb_byte;
> +		new_size_byte = val * nb_byte;
> +	}
> +
> +	ret = inv_mpu6050_set_hw_watermark(st, new_size_byte);
> +	if (ret)
> +		return ret;
> +
> +	st->chip_config.wm_val = val;
> +
> +	return 0;
> +}
> +
>  static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
>  					int clock, int temp_dis)
>  {
> @@ -1018,6 +1096,70 @@ static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
>  	}
>  }
>  
> +/*
> + * inv_mpu6050_get_fifo_watermark_max() - Get the max watermark size of current chip.
> + */
> +
> +static ssize_t
> +inv_mpu6050_get_fifo_watermark_max(struct device *dev, struct device_attribute *attr,
> +		   char *buf)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int nb_byte;
> +	size_t watermark_max_size;
> +
> +	mutex_lock(&st->lock);
> +	nb_byte = inv_mpu6050_get_sample_size(st);
> +
> +	/* Use default value of accel + gyro + temp sample */
> +	if (nb_byte == 0)
> +		nb_byte = 2 * INV_MPU6050_BYTES_PER_3AXIS_SENSOR
> +				+ INV_MPU6050_BYTES_PER_TEMP_SENSOR;
> +	watermark_max_size = st->hw->fifo_size / nb_byte;

As above - I think you should have a consistent max rather than one that is dependent
on whether the kfifo size is larger than the hw fifo can handle or not.

> +	mutex_unlock(&st->lock);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%zu\n", watermark_max_size);
> +}
> +
> +/*
> + * inv_mpu6050_get_fifo_state() - Get the state of the hwfifo.
> + *
> + * Watermark is disabled when the watermark size is set to 0
> + */
> +
> +static ssize_t
> +inv_mpu6050_get_fifo_state(struct device *dev, struct device_attribute *attr,
> +		   char *buf)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int fifo_state = 0;
> +
> +	mutex_lock(&st->lock);
> +	if (st->chip_config.wm_size > 0)
> +		fifo_state = 1;
> +	mutex_unlock(&st->lock);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_state);
> +}
> +
> +/*
> + * inv_mpu6050_get_fifo_watermark() - Get the current watermark size.
> + */
> +
> +static ssize_t
> +inv_mpu6050_get_fifo_watermark(struct device *dev, struct device_attribute *attr,
> +		   char *buf)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int watermark;
> +
> +	mutex_lock(&st->lock);
> +	watermark = st->chip_config.wm_size;
> +	mutex_unlock(&st->lock);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", watermark);
> +}
> +
>  /**
>   * inv_mpu6050_validate_trigger() - validate_trigger callback for invensense
>   *                                  MPU6050 device.
> @@ -1258,6 +1400,14 @@ static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
>  static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show, NULL,
>  	ATTR_ACCL_MATRIX);
>  
> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> +static IIO_DEVICE_ATTR(hwfifo_watermark_max, S_IRUGO,
> +	inv_mpu6050_get_fifo_watermark_max, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
> +	inv_mpu6050_get_fifo_state, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
> +	inv_mpu6050_get_fifo_watermark, NULL, 0);
> +
>  static struct attribute *inv_attributes[] = {
>  	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,  /* deprecated */
>  	&iio_dev_attr_in_accel_matrix.dev_attr.attr, /* deprecated */
> @@ -1265,6 +1415,10 @@ static struct attribute *inv_attributes[] = {
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
>  	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
>  	NULL,
>  };
