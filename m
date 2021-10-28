Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539E043E21D
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1N3a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 09:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhJ1N31 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 09:29:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C307610FF;
        Thu, 28 Oct 2021 13:26:57 +0000 (UTC)
Date:   Thu, 28 Oct 2021 14:31:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 07/10] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20211028143123.6dcd30e7@jic23-huawei>
In-Reply-To: <20211028101840.24632-8-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-8-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 12:18:37 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> can be connected via both serial and I2C busses; separate patches will
> add support for them.
> 
> The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> that provides raw data from the said internal sensors, and a couple of
> "fusion" modes (i.e. the IMU also do calculations in order to provide
> euler angles, quaternions, linear acceleration and gravity measurements).
> 
> In fusion modes the AMG data is still available (with some calibration
> refinements done by the IMU), but certain settings such as low pass
> filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> they can be customized; this is why AMG mode can still be interesting.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  drivers/iio/imu/Kconfig         |    1 +
>  drivers/iio/imu/Makefile        |    1 +
>  drivers/iio/imu/bno055/Kconfig  |    4 +
>  drivers/iio/imu/bno055/Makefile |    3 +
>  drivers/iio/imu/bno055/bno055.c | 1480 +++++++++++++++++++++++++++++++
>  drivers/iio/imu/bno055/bno055.h |   12 +
>  6 files changed, 1501 insertions(+)
>  create mode 100644 drivers/iio/imu/bno055/Kconfig
>  create mode 100644 drivers/iio/imu/bno055/Makefile
>  create mode 100644 drivers/iio/imu/bno055/bno055.c
>  create mode 100644 drivers/iio/imu/bno055/bno055.h
> 
...

> diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
> new file mode 100644
> index 000000000000..c85cb985f0f1
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/bno055.c
> @@ -0,0 +1,1480 @@

...

> +
> +static int bno055_reg_update_bits(struct bno055_priv *priv, unsigned int reg,
> +				  unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(priv->regmap, reg, mask, val);
> +	if (ret && ret != -ERESTARTSYS) {
> +		dev_err(priv->dev, "Regmap update_bits  error. adr: 0x%x, ret: %d",
> +			reg,  ret);

This feels like a wrapper that made sense when developing but probably doesn't
want to still be here now things are 'working'.

> +	}
> +
> +	return ret;
> +}
> +

...

> +
> +static void bno055_clk_disable(void *arg)

Easy to make arg == priv->clk and turn this into a one line function.
I'd expect these cleanup functions to be just above where probe() is defined rather
than all the way up here.

> +{
> +	struct bno055_priv *priv = arg;
> +
> +	clk_disable_unprepare(priv->clk);
> +}
> +

...

> +
> +static int bno055_get_acc_lpf(struct bno055_priv *priv, int *val, int *val2)
> +{
> +	const int shift = __ffs(BNO055_ACC_CONFIG_LPF_MASK);
> +	int hwval, idx;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_ACC_CONFIG_REG, &hwval);
> +	if (ret)
> +		return ret;
> +
> +	idx = (hwval & BNO055_ACC_CONFIG_LPF_MASK) >> shift;

Use FIELD_GET() and FIELD_PREP where possible rather than reinventing them.

> +	*val = bno055_acc_lpf_vals[idx * 2];
> +	*val2 = bno055_acc_lpf_vals[idx * 2 + 1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int bno055_set_acc_lpf(struct bno055_priv *priv, int val, int val2)
> +{
> +	const int shift = __ffs(BNO055_ACC_CONFIG_LPF_MASK);
> +	int req_val = val * 1000 + val2 / 1000;
> +	bool first = true;
> +	int best_delta;
> +	int best_idx;
> +	int tbl_val;
> +	int delta;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(bno055_acc_lpf_vals) / 2; i++) {
> +		tbl_val = bno055_acc_lpf_vals[i * 2] * 1000 +
> +			bno055_acc_lpf_vals[i * 2 + 1] / 1000;
> +		delta = abs(tbl_val - req_val);
> +		if (first || delta < best_delta) {
> +			best_delta = delta;
> +			best_idx = i;
> +			first = false;
> +		}
> +	}
> +
> +	/*
> +	 * The closest value the HW supports is only one in fusion mode,
> +	 * and it is autoselected, so don't do anything, just return OK,
> +	 * as the closest possible value has been (virtually) selected
> +	 */
> +	if (priv->operation_mode != BNO055_OPR_MODE_AMG)
> +		return 0;

Can we do this before the big loop above?


> +
> +	ret = regmap_write(priv->regmap, BNO055_OPR_MODE_REG,
> +			   BNO055_OPR_MODE_CONFIG);
> +	if (ret)
> +		return ret;
> +
> +	ret = bno055_reg_update_bits(priv, BNO055_ACC_CONFIG_REG,
> +				     BNO055_ACC_CONFIG_LPF_MASK,
> +				     best_idx << shift);
> +
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(priv->regmap, BNO055_OPR_MODE_REG,
> +			    BNO055_OPR_MODE_AMG);
> +}
> +

...

> +
> +#define bno055_get_mag_odr(p, v) \
> +	bno055_get_regmask(p, v, \
> +			   BNO055_MAG_CONFIG_REG, BNO055_MAG_CONFIG_ODR_MASK, \
> +			   bno055_mag_odr_vals)

I'm not really convinced this is a worthwhile abstraction as these are typically
only used once.

> +
...

> +static int bno055_read_simple_chan(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +	__le16 raw_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_bulk_read(priv->regmap, chan->address,
> +				       &raw_val, sizeof(raw_val));
> +		if (ret < 0)
> +			return ret;
> +		*val = (s16)le16_to_cpu(raw_val);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (priv->operation_mode != BNO055_OPR_MODE_AMG) {
> +			*val = 0;
> +		} else {
> +			ret = regmap_bulk_read(priv->regmap,
> +					       chan->address +
> +					       BNO055_REG_OFFSET_ADDR,
> +					       &raw_val, sizeof(raw_val));
> +			if (ret < 0)
> +				return ret;
> +			/*
> +			 * IMU reports sensor offests; IIO wants correction
> +			 * offset, thus we need the 'minus' here.
> +			 */
> +			*val = -(s16)le16_to_cpu(raw_val);
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +		switch (chan->type) {
> +		case IIO_GRAVITY:
> +			/* Table 3-35: 1 m/s^2 = 100 LSB */
> +		case IIO_ACCEL:
> +			/* Table 3-17: 1 m/s^2 = 100 LSB */
> +			*val2 = 100;
> +			break;
> +		case IIO_MAGN:
> +			/*
> +			 * Table 3-19: 1 uT = 16 LSB.  But we need
> +			 * Gauss: 1G = 0.1 uT.
> +			 */
> +			*val2 = 160;
> +			break;
> +		case IIO_ANGL_VEL:
> +			/* Table 3-22: 1 Rps = 900 LSB */
> +			*val2 = 900;
> +			break;
> +		case IIO_ROT:
> +			/* Table 3-28: 1 degree = 16 LSB */
> +			*val2 = 16;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;

default in the middle is a bit unusual. move it to the end.

> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (chan->type != IIO_MAGN)
> +			return -EINVAL;
> +		else
> +			return bno055_get_mag_odr(priv, val);
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			return bno055_get_gyr_lpf(priv, val);
> +		case IIO_ACCEL:
> +			return bno055_get_acc_lpf(priv, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +}
> +


> +
> +static int bno055_read_quaternion(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int size, int *vals, int *val_len,
> +				  long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +	__le16 raw_vals[4];
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (size < 4)
> +			return -EINVAL;
> +		ret = regmap_bulk_read(priv->regmap,
> +				       BNO055_QUAT_DATA_W_LSB_REG,
> +				       raw_vals, sizeof(raw_vals));
> +		if (ret < 0)
> +			return ret;
> +		for (i = 0; i < 4; i++)
> +			vals[i] = (s16)le16_to_cpu(raw_vals[i]);
> +		*val_len = 4;
> +		return IIO_VAL_INT_MULTIPLE;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Table 3-31: 1 quaternion = 2^14 LSB */
> +		if (size < 2)
> +			return -EINVAL;
> +		vals[0] = 1;
> +		vals[1] = 1 << 14;

IIO_VAL_FRACTIONAL_LOG2?

> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +
> +static ssize_t bno055_fusion_enable_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t len)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret = 0;
> +
> +	if (sysfs_streq(buf, "0")) {
> +		ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_AMG);
> +	} else {
> +		/*
> +		 * Coming from AMG means the FMC was off, just switch to fusion
> +		 * but don't change anything that doesn't belong to us (i.e let.
> +		 * FMC stay off.
> +		 * Coming from any other fusion mode means we don't need to do
> +		 * anything.
> +		 */
> +		if (priv->operation_mode == BNO055_OPR_MODE_AMG)
> +			ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_FUSION_FMC_OFF);
> +	}
> +
> +	return len ?: len;

return ret?: len; might make sense, though my inclination would be to use an explicit
if (ret) at the various possible error locations.

> +}

...

> +static ssize_t bno055_fmc_enable_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret = 0;
> +
> +	if (sysfs_streq(buf, "0")) {
> +		if (priv->operation_mode == BNO055_OPR_MODE_FUSION)
> +			ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_FUSION_FMC_OFF);
> +	} else {
> +		if (priv->operation_mode == BNO055_OPR_MODE_AMG)
> +			return -EINVAL;
> +	}
> +
> +	return len ?: ret;

Don't think that will return ret which is what we want if it's set.

> +}
> +

...

> +static ssize_t in_calibration_data_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	u8 data[BNO055_CALDATA_LEN];
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	ret = regmap_write(priv->regmap, BNO055_OPR_MODE_REG,
> +			   BNO055_OPR_MODE_CONFIG);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = regmap_bulk_read(priv->regmap, BNO055_CALDATA_START, data,
> +			       BNO055_CALDATA_LEN);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = regmap_write(priv->regmap, BNO055_OPR_MODE_REG, priv->operation_mode);
> +	mutex_unlock(&priv->lock);
> +	if (ret)
> +		return ret;

This is a case where I'd move the mutex_unlock after the check so that we have
a nice shared error path via the unlock lable.

> +
> +	memcpy(buf, data, BNO055_CALDATA_LEN);
> +
> +	return BNO055_CALDATA_LEN;
> +unlock:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
...

> +static ssize_t bno055_show_fw_version(struct file *file, char __user *userbuf,
> +				      size_t count, loff_t *ppos)
> +{
> +	struct bno055_priv *priv = file->private_data;
> +	int rev, ver;
> +	char *buf;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_SW_REV_LSB_REG, &rev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_SW_REV_MSB_REG, &ver);
> +	if (ret)
> +		return ret;
> +
> +	buf = devm_kasprintf(priv->dev, GFP_KERNEL, "ver: 0x%x, rev: 0x%x\n",
> +			     ver, rev);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
> +	devm_kfree(priv->dev, buf);

Why use devm managed allocations if you are just going to free it immediately?

> +
> +	return ret;
> +}
> +

...

> +/*
> + * Reads len samples from the HW, stores them in buf starting from buf_idx,
> + * and applies mask to cull (skip) unneeded samples.
> + * Updates buf_idx incrementing with the number of stored samples.
> + * Samples from HW are transferred into buf, then in-place copy on buf is
> + * performed in order to cull samples that need to be skipped.
> + * This avoids copies of the first samples until we hit the 1st sample to skip,
> + * and also avoids having an extra bounce buffer.
> + * buf must be able to contain len elements in spite of how many samples we are
> + * going to cull.

This is rather complex - I take we can't just fall back to letting the IIO core
demux do all the hard work for us?

> + */
> +static int bno055_scan_xfer(struct bno055_priv *priv,
> +			    int start_ch, int len, unsigned long mask,
> +			    __le16 *buf, int *buf_idx)
> +{
> +	const int base = BNO055_ACC_DATA_X_LSB_REG;
> +	bool quat_in_read = false;
> +	int buf_base = *buf_idx;
> +	__le16 *dst, *src;
> +	int offs_fixup = 0;
> +	int xfer_len = len;
> +	int ret;
> +	int i, n;
> +
> +	/*
> +	 * All chans are made up 1 16-bit sample, except for quaternion that is
> +	 * made up 4 16-bit values.
> +	 * For us the quaternion CH is just like 4 regular CHs.
> +	 * If our read starts past the quaternion make sure to adjust the
> +	 * starting offset; if the quaternion is contained in our scan then make
> +	 * sure to adjust the read len.
> +	 */
> +	if (start_ch > BNO055_SCAN_QUATERNION) {
> +		start_ch += 3;
> +	} else if ((start_ch <= BNO055_SCAN_QUATERNION) &&
> +		 ((start_ch + len) > BNO055_SCAN_QUATERNION)) {
> +		quat_in_read = true;
> +		xfer_len += 3;
> +	}
> +
> +	ret = regmap_bulk_read(priv->regmap,
> +			       base + start_ch * sizeof(__le16),
> +			       buf + buf_base,
> +			       xfer_len * sizeof(__le16));
> +	if (ret)
> +		return ret;
> +
> +	for_each_set_bit(i, &mask, len) {
> +		if (quat_in_read && ((start_ch + i) > BNO055_SCAN_QUATERNION))
> +			offs_fixup = 3;
> +
> +		dst = buf + *buf_idx;
> +		src = buf + buf_base + offs_fixup + i;
> +
> +		n = (start_ch + i == BNO055_SCAN_QUATERNION) ? 4 : 1;
> +
> +		if (dst != src)
> +			memcpy(dst, src, n * sizeof(__le16));
> +
> +		*buf_idx += n;
> +	}
> +	return 0;
> +}
> +
> +static irqreturn_t bno055_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio_dev = pf->indio_dev;
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +	int xfer_start, start, end, prev_end;
> +	bool xfer_pending = false;
> +	bool first = true;
> +	unsigned long mask;
> +	int buf_idx = 0;
> +	bool thr_hit;
> +	int quat;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	for_each_set_bitrange(start, end, iio_dev->active_scan_mask,
> +			      iio_dev->masklength) {

I'm not seeing this function in mainline...  I guess this series has a dependency
I missed?

> +		if (!xfer_pending)
> +			xfer_start = start;
> +		xfer_pending = true;
> +
> +		if (!first) {

first == true and we never get in here to set it to false.

Perhaps we would benefit from a state machine diagram for this function?
In general this function is complex enough to need documentation of what
each major part is doing.

> +			quat = ((start > BNO055_SCAN_QUATERNION) &&
> +				(prev_end <= BNO055_SCAN_QUATERNION)) ? 3 : 0;

Having quat == 3 for a variable named quat doesn't seem intuitive. 

> +			thr_hit = (start - prev_end + quat) >
> +				priv->xfer_burst_break_thr;
> +
> +			if (thr_hit) {
> +				mask = *iio_dev->active_scan_mask >> xfer_start;
> +				ret = bno055_scan_xfer(priv, xfer_start,
> +						       prev_end - xfer_start + 1,
> +						       mask, priv->buf.chans, &buf_idx);
> +				if (ret)
> +					goto done;
> +				xfer_pending = false;
> +			}
> +			first = false;
> +		}
> +		prev_end = end;
> +	}
> +
> +	if (xfer_pending) {
> +		mask = *iio_dev->active_scan_mask >> xfer_start;
> +		ret = bno055_scan_xfer(priv, xfer_start,
> +				       end - xfer_start + 1,
> +				       mask, priv->buf.chans, &buf_idx);
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(iio_dev, &priv->buf, pf->timestamp);
> +done:
> +	mutex_unlock(&priv->lock);
> +	iio_trigger_notify_done(iio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +int bno055_probe(struct device *dev, struct regmap *regmap,
> +		 int xfer_burst_break_thr)
> +{
> +	const struct firmware *caldata;
> +	struct bno055_priv *priv;
> +	struct iio_dev *iio_dev;
> +	struct gpio_desc *rst;
> +	char *fw_name_buf;
> +	unsigned int val;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	iio_dev->name = "bno055";
> +	priv = iio_priv(iio_dev);
> +	mutex_init(&priv->lock);
> +	priv->regmap = regmap;
> +	priv->dev = dev;
> +	priv->xfer_burst_break_thr = xfer_burst_break_thr;

blank line here would hep readability a little I think.

> +	rst = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset GPIO");
> +
> +	priv->clk = devm_clk_get_optional(dev, "clk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get CLK");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, bno055_clk_disable, priv);

As mentioned above, pass priv->clk into this as we don't need to see anything
else in the callback.

> +	if (ret)
> +		return ret;
> +
> +	if (rst) {
> +		usleep_range(5000, 10000);
> +		gpiod_set_value_cansleep(rst, 0);
> +		usleep_range(650000, 750000);
> +	}
> +
> +	ret = regmap_read(priv->regmap, BNO055_CHIP_ID_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != BNO055_CHIP_ID_MAGIC) {
> +		dev_err(dev, "Unrecognized chip ID 0x%x", val);
> +		return -ENODEV;
> +	}
> +
> +	ret = regmap_bulk_read(priv->regmap, BNO055_UID_LOWER_REG,
> +			       priv->uid, BNO055_UID_LEN);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * This has nothing to do with the IMU firmware, this is for sensor
> +	 * calibration data.
> +	 */
> +	fw_name_buf = devm_kasprintf(dev, GFP_KERNEL,
> +				     BNO055_FW_UID_NAME,
> +				     BNO055_UID_LEN, priv->uid);
> +	if (!fw_name_buf)
> +		return -ENOMEM;
> +
> +	ret = request_firmware(&caldata, fw_name_buf, dev);
> +	devm_kfree(dev, fw_name_buf);
> +	if (ret)
> +		ret = request_firmware(&caldata, BNO055_FW_GENERIC_NAME, dev);
> +
> +	if (ret) {
> +		dev_notice(dev, "Failed to load calibration data firmware file; this has nothing to do with IMU main firmware.\nYou can calibrate your IMU (look for 'in_autocalibration_status*' files in sysfs) and then copy 'in_calibration_data' to your firmware file");

As the notice has multiple lines, you can break at the \n points without any loss of greppability.
It would be good to make this shorter though if we can - I wouldn't way what it isn't for example.

		Calibration file load failed.
		Follow instructions in Documentation/ *

+ write some docs on the calibration procedure.  I don't think it is a
good plan to give a guide in a kernel log.

> +		caldata = NULL;

I'd hope that is already the case and it definitely looks like it is from a quick look
at request_firmware(). I'd consider request_firmware buggy if it did anything else
as that would imply it had side effects that weren't cleaned up on error.

> +	}
> +
> +	ret = bno055_init(priv, caldata);
> +	if (caldata)
> +		release_firmware(caldata);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, bno055_uninit, priv);
> +	if (ret)
> +		return ret;
> +
> +	iio_dev->channels = bno055_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(bno055_channels);
> +	iio_dev->info = &bno055_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, iio_dev,
> +					      iio_pollfunc_store_time,
> +					      bno055_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, iio_dev);
> +	if (ret)
> +		return ret;
> +
> +	bno055_debugfs_init(iio_dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bno055_probe);
> +
...

Thanks,

Jonathan
