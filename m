Return-Path: <linux-iio+bounces-7991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6BF93E52A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 14:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40130281E25
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560BB3D0C5;
	Sun, 28 Jul 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQbHGsWY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683E23776;
	Sun, 28 Jul 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722171196; cv=none; b=QWoDvVYbTsp+PiL5KB5NHRTqsa5+2yLKUuyfdBIzMWX3W3MeSuBD0MfIBwR8ISuek4mNBFXbyIOA+m+5dOLq/O0Qv2Gfn06Afhu7KAjPkT7FAFgQKjZv11wj8btZ7n0hjiRnv9ch6teZqvLhe+vQiAQkf+xzstdDWiTGX8WUMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722171196; c=relaxed/simple;
	bh=TmboGPuQj9mN/bGXKeA5r/MC8uaREvD4H0BSkumTuY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVi7R7EWhcSX1WhRfDeOy8UKaA6qwQB0KvBVjTXPd68OQKx8CHn8jMu3XF21QeP5sdyZ5GzngmbaEbTLlbkkTVJi9kJf4UXffr6gCmG4ACDhMmW19wBwRoaDxTF1zk7pALfwvsHuSM94QFMMHZ7PXg6L5lOBWkTfsI0wNq41rHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQbHGsWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA361C116B1;
	Sun, 28 Jul 2024 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722171195;
	bh=TmboGPuQj9mN/bGXKeA5r/MC8uaREvD4H0BSkumTuY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vQbHGsWYFvbDxJB3eVWUQoAgaopFQLRJJEc/FuTjvn1Jrz5zQoGdWzaSc7om23yOa
	 K3eKY8Ju2fbAVsj6VbeolnBN9XAAPf09ZYfjit0P+BAzFoGC7PEfv/GzCR002dM9t4
	 CcBl2T4plIuSnw/IQ5yphFVUhEt8vLlM1vjq/EqE/AM3c+DnoI5YIIaBQwqqBjDyFM
	 jjfaiJJrDPjNt3mSHbG8VfuLW1QS0duxw29br/7YTwKkb1eEYgTRwQRgyyxRxRtVYU
	 m6XxbaQJKZRe1Rjg/37tMygBUYzltdbV0JiMYZoS6ueKa8eBx2ccn9ZcFMHKselIBf
	 dQ5GTrYVofnkg==
Date: Sun, 28 Jul 2024 13:53:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marius Cristea <marius.cristea@microchip.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: add support for pac1921
Message-ID: <20240728135306.422713ea@jic23-huawei>
In-Reply-To: <20240724-iio-pac1921-v4-3-723698e903a3@gmail.com>
References: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
	<20240724-iio-pac1921-v4-3-723698e903a3@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 11:08:33 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Add support for Microchip PAC1921 Power/Current monitor.
> 
> Implemented features:
> * capture of bus voltage, sense voltage, current and power measurements
>   in free-run integration mode
> * support for both raw and triggered buffer reading
> * support for overflow events
> * scale attributes to control voltage and current gains
> * oversampling ratio attribute to control the number of integration
>   samples
> * sampling rate attribute that reflects the integration period
> * userspace attribute and DT parameter to control shunt resistor
> * simple power management support
> 
> Limitations:
> * operation mode fixed to free-run integration
> * READ/INT pin and OUT pin not supported
> * no controls for measurement resolutions and filters
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
I had a few more bits of feedback + one change was necessary because of
this crossing with Nuno's series making iio_dev->masklength private.
Rather than go around again for such trivial things, 
I've applied it to the testing branch of iio.git with the following diff.
Note I'll rebase that tree on rc1 once available at which point it'll become
the togreg branch and get picked up by linux-next etc.

There are a few things inline that I commented on but didn't touch, so
please also take a look at those and shout if I messed anything up!
I've been known to make trivial changes that break a driver completely :(

Thanks,

Jonathan


diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index a21dd772467e..d04c6685d780 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -75,12 +75,12 @@ enum pac1921_mxsl {
  * Vbus scale (mV) = max_vbus (mV) / dv_gain / resolution
  */
 static const int pac1921_vbus_scales[][2] = {
-       {31, 280547409},        /* dv_gain x1 */
-       {15, 640273704},        /* dv_gain x2 */
-       {7, 820136852},         /* dv_gain x4 */
-       {3, 910068426},         /* dv_gain x8 */
-       {1, 955034213},         /* dv_gain x16 */
-       {0, 977517106}          /* dv_gain x32 */
+       { 31, 280547409 },      /* dv_gain x1 */
+       { 15, 640273704 },      /* dv_gain x2 */
+       { 7, 820136852 },       /* dv_gain x4 */
+       { 3, 910068426 },       /* dv_gain x8 */
+       { 1, 955034213 },       /* dv_gain x16 */
+       { 0, 977517106 },       /* dv_gain x32 */
 };
 
 /*
@@ -91,14 +91,14 @@ static const int pac1921_vbus_scales[][2] = {
  * Vsense scale (mV) = max_vsense (mV) / di_gain / resolution
  */
 static const int pac1921_vsense_scales[][2] = {
-       {0, 97751710},          /* di_gain x1 */
-       {0, 48875855},          /* di_gain x2 */
-       {0, 24437927},          /* di_gain x4 */
-       {0, 12218963},          /* di_gain x8 */
-       {0, 6109481},           /* di_gain x16 */
-       {0, 3054740},           /* di_gain x32 */
-       {0, 1527370},           /* di_gain x64 */
-       {0, 763685}             /* di_gain x128 */
+       { 0, 97751710 },        /* di_gain x1 */
+       { 0, 48875855 },        /* di_gain x2 */
+       { 0, 24437927 },        /* di_gain x4 */
+       { 0, 12218963 },        /* di_gain x8 */
+       { 0, 6109481 },         /* di_gain x16 */
+       { 0, 3054740 },         /* di_gain x32 */
+       { 0, 1527370 },         /* di_gain x64 */
+       { 0, 763685 },          /* di_gain x128 */
 };
 
 /*
@@ -334,7 +334,7 @@ static int pac1921_read_res(struct pac1921_priv *priv, unsigned long reg,
        if (ret)
                return ret;
 
-       *val = (u16)FIELD_GET(PAC1921_RES_MASK, get_unaligned_be16(val));
+       *val = FIELD_GET(PAC1921_RES_MASK, get_unaligned_be16(val));
 
        return 0;
 }
@@ -612,7 +612,7 @@ static int pac1921_update_int_num_samples(struct pac1921_priv *priv,
        if (priv->n_samples == n_samples)
                return 0;
 
-       reg_val = (u8)FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, n_samples);
+       reg_val = FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, n_samples);
 
        ret = pac1921_update_cfg_reg(priv, PAC1921_REG_INT_CFG,
                                     PAC1921_INT_CFG_SMPL_MASK, reg_val);
@@ -1017,7 +1017,7 @@ static irqreturn_t pac1921_trigger_handler(int irq, void *p)
        if (ret)
                goto done;
 
-       for_each_set_bit(bit, idev->active_scan_mask, idev->masklength) {
+       iio_for_each_active_channel(idev, bit) {
                u16 val;
 
                ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
@@ -1054,8 +1054,8 @@ static int pac1921_init(struct pac1921_priv *priv)
                return ret;
 
        /* Configure gains, use 14-bits measurement resolution (HW default) */
-       val = (u8)FIELD_PREP(PAC1921_GAIN_DI_GAIN_MASK, priv->di_gain) |
-             (u8)FIELD_PREP(PAC1921_GAIN_DV_GAIN_MASK, priv->dv_gain);
+       val = FIELD_PREP(PAC1921_GAIN_DI_GAIN_MASK, priv->di_gain) |
+             FIELD_PREP(PAC1921_GAIN_DV_GAIN_MASK, priv->dv_gain);
        ret = regmap_write(priv->regmap, PAC1921_REG_GAIN_CFG, val);
        if (ret)
                return ret;
@@ -1067,7 +1067,7 @@ static int pac1921_init(struct pac1921_priv *priv)
         * - set READ/INT pin override (RIOV) to control operation mode via
         *   register instead of pin
         */
-       val = (u8)FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, priv->n_samples) |
+       val = FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, priv->n_samples) |
              PAC1921_INT_CFG_VSFEN | PAC1921_INT_CFG_VBFEN |
              PAC1921_INT_CFG_RIOV;
        ret = regmap_write(priv->regmap, PAC1921_REG_INT_CFG, val);
@@ -1080,8 +1080,8 @@ static int pac1921_init(struct pac1921_priv *priv)
         * - OUT pin full scale range: 3V (HW detault)
         * - no timeout, no sleep, no sleep override, no recalc (HW defaults)
         */
-       val = (u8)FIELD_PREP(PAC1921_CONTROL_MXSL_MASK,
-                            PAC1921_MXSL_VPOWER_FREE_RUN);
+       val = FIELD_PREP(PAC1921_CONTROL_MXSL_MASK,
+                        PAC1921_MXSL_VPOWER_FREE_RUN);
        ret = regmap_write(priv->regmap, PAC1921_REG_CONTROL, val);
        if (ret)
                return ret;
@@ -1153,7 +1153,6 @@ static void pac1921_regulator_disable(void *data)
 
 static int pac1921_probe(struct i2c_client *client)
 {
-       const struct i2c_device_id *id = i2c_client_get_device_id(client);
        struct device *dev = &client->dev;
        struct pac1921_priv *priv;
        struct iio_dev *indio_dev;
@@ -1202,8 +1201,7 @@ static int pac1921_probe(struct i2c_client *client)
        ret = devm_add_action_or_reset(dev, pac1921_regulator_disable,
                                       priv->vdd);
        if (ret)
-               return dev_err_probe(
-                       dev, ret,
+               return dev_err_probe(dev, ret,
                        "Cannot add action for vdd regulator disposal\n");
 
        msleep(PAC1921_POWERUP_TIME_MS);
@@ -1214,7 +1212,7 @@ static int pac1921_probe(struct i2c_client *client)
 
        priv->iio_info = pac1921_iio;
 
-       indio_dev->name = id->name;
+       indio_dev->name = "pac1921";
        indio_dev->info = &priv->iio_info;
        indio_dev->modes = INDIO_DIRECT_MODE;
        indio_dev->channels = pac1921_channels;


> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> new file mode 100644
> index 000000000000..a21dd772467e
> --- /dev/null
> +++ b/drivers/iio/adc/pac1921.c
> @@ -0,0 +1,1263 @@


> +/*
> + * Pre-computed scales for SENSE voltage
> + * format: IIO_VAL_INT_PLUS_NANO
> + * unit: mV
> + *
> + * Vsense scale (mV) = max_vsense (mV) / di_gain / resolution
> + */
> +static const int pac1921_vsense_scales[][2] = {
> +	{0, 97751710},		/* di_gain x1 */
> +	{0, 48875855},		/* di_gain x2 */
> +	{0, 24437927},		/* di_gain x4 */
> +	{0, 12218963},		/* di_gain x8 */
> +	{0, 6109481},		/* di_gain x16 */
> +	{0, 3054740},		/* di_gain x32 */
> +	{0, 1527370},		/* di_gain x64 */
> +	{0, 763685}		/* di_gain x128 */
> +};
trivial but generally prefer { 0, 763685 }, 
etc



> +
> +/*
> + * Emit on sysfs the list of available scales contained in scales_tbl
> + *
> + * TODO:: this function can be replaced with iio_format_avail_list() if the
> + * latter will ever be exported.

You could just have added a precursor patch doing that.
If you have time I'd certainly consider a patch that does export that function
and uses it here.

> + *
> + * Must be called with lock held if the scales_tbl can change runtime (e.g. for
> + * the current scales table)
> + */
> +static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
> +					  size_t size, char *buf)
> +{
> +	ssize_t len = 0;
> +
> +	for (unsigned int i = 0; i < size; i++) {
> +		if (i != 0) {
> +			len += sysfs_emit_at(buf, len, " ");
> +			if (len >= PAGE_SIZE)
> +				return -EFBIG;
> +		}
> +		len += sysfs_emit_at(buf, len, "%d.%09d", scales_tbl[i][0],
> +				     scales_tbl[i][1]);
> +		if (len >= PAGE_SIZE)
> +			return -EFBIG;
> +	}
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +	return len;
> +}
> +
> +/*
> + * Read available scales for a specific channel
> + *
> + * NOTE: using extended info insted of iio.read_avail() because access to
> + * current scales must be locked as they depend on shunt resistor which may
> + * change runtime. Caller of iio.read_avail() would access the table unlocked
> + * instead.

That's a corner case we should think about closing. Would require an indicator
to read_avail that the buffer it has been passed is a snapshot that it should
free on completion of the string building.  I don't like passing ownership
of data around like that, but it is fiddly to do anything else given
any simple double buffering is subject to race conditions.
An alternative would use a key of sometype to associate individual read_avail
calls with new ones to read_avail_release_resource. That might be cleaner.

oh well, a cleanup job for another day.   I suspect we have drivers today
that are subject to tearing of their available lists.



> + */
> +static ssize_t pac1921_read_scale_avail(struct iio_dev *indio_dev,
> +					uintptr_t private,
> +					const struct iio_chan_spec *chan,
> +					char *buf)
> +{
> +	struct pac1921_priv *priv = iio_priv(indio_dev);
> +	const int (*scales_tbl)[2];
> +	size_t size;
> +
> +	switch (chan->channel) {
> +	case PAC1921_CHAN_VBUS:
> +		scales_tbl = pac1921_vbus_scales;
> +		size = ARRAY_SIZE(pac1921_vbus_scales);
> +		return pac1921_format_scale_avail(scales_tbl, size, buf);
> +
> +	case PAC1921_CHAN_VSENSE:
> +		scales_tbl = pac1921_vsense_scales;
> +		size = ARRAY_SIZE(pac1921_vsense_scales);
> +		return pac1921_format_scale_avail(scales_tbl, size, buf);
> +
> +	case PAC1921_CHAN_CURRENT: {
> +		guard(mutex)(&priv->lock);
> +		scales_tbl = priv->current_scales;
> +		size = ARRAY_SIZE(priv->current_scales);
> +		return pac1921_format_scale_avail(scales_tbl, size, buf);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define PAC1921_EXT_INFO_SCALE_AVAIL {					\
> +	.name = "scale_available",					\
> +	.read = pac1921_read_scale_avail,				\
> +	.shared = IIO_SEPARATE,						\
> +}
> +
> +static const struct iio_chan_spec_ext_info pac1921_ext_info_voltage[] = {
> +	PAC1921_EXT_INFO_SCALE_AVAIL,
> +	{}
> +};


> +
> +static irqreturn_t pac1921_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct pac1921_priv *priv = iio_priv(idev);
> +	int ret;
> +	int bit;
> +	int ch = 0;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	if (!pac1921_data_ready(priv))

Interesting corner case that maybe could have done with a comment.
Seems could be triggered by a spurious interrupt, or sampling too early.

I think only the second one is likely to happen, so shouldn't be a
problem to acknowledge that trigger.

> +		goto done;
> +
> +	ret = pac1921_check_push_overflow(idev, pf->timestamp);
> +	if (ret)
> +		goto done;
> +
> +	for_each_set_bit(bit, idev->active_scan_mask, idev->masklength) {

This needs an update as we crossed with Nuno's series that removes access
to masklength. I can fix whilst applying by using
iio_for_each_active_channel()


> +		u16 val;
> +
> +		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> +		if (ret)
> +			goto done;
> +
> +		priv->scan.chan[ch++] = val;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(idev, &priv->scan, pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Initialize device by writing initial configuration and putting it into
> + * integration state.
> + *
> + * Must be called with lock held when called after first initialization
> + * (e.g. from pm resume)
> + */
> +static int pac1921_init(struct pac1921_priv *priv)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* Enter READ state before configuration */
> +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> +				 PAC1921_INT_CFG_INTEN, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Configure gains, use 14-bits measurement resolution (HW default) */
> +	val = (u8)FIELD_PREP(PAC1921_GAIN_DI_GAIN_MASK, priv->di_gain) |
> +	      (u8)FIELD_PREP(PAC1921_GAIN_DV_GAIN_MASK, priv->dv_gain);

Why are these cases needed?
Each of those values is going to fit in a u8 just fine and it's getting
written to a much larger variable.




> +	ret = regmap_write(priv->regmap, PAC1921_REG_GAIN_CFG, val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure integration:
> +	 * - num of integration samples
> +	 * - filters enabled (HW default)
> +	 * - set READ/INT pin override (RIOV) to control operation mode via
> +	 *   register instead of pin
> +	 */
> +	val = (u8)FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, priv->n_samples) |
> +	      PAC1921_INT_CFG_VSFEN | PAC1921_INT_CFG_VBFEN |
> +	      PAC1921_INT_CFG_RIOV;
> +	ret = regmap_write(priv->regmap, PAC1921_REG_INT_CFG, val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Init control register:
> +	 * - VPower free run integration mode
> +	 * - OUT pin full scale range: 3V (HW detault)
> +	 * - no timeout, no sleep, no sleep override, no recalc (HW defaults)
> +	 */
> +	val = (u8)FIELD_PREP(PAC1921_CONTROL_MXSL_MASK,
> +			     PAC1921_MXSL_VPOWER_FREE_RUN);
> +	ret = regmap_write(priv->regmap, PAC1921_REG_CONTROL, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable integration */
> +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> +				 PAC1921_INT_CFG_INTEN, PAC1921_INT_CFG_INTEN);
> +	if (ret)
> +		return ret;
> +
> +	priv->first_integr_started = true;
> +	priv->integr_started_time_jiffies = jiffies;
> +	priv->integr_period_usecs = pac1921_int_periods_usecs[priv->n_samples];
> +
> +	return 0;
> +}

...

> +static int pac1921_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
With the change suggested below this wouldn't be needed.
> +	struct device *dev = &client->dev;
> +	struct pac1921_priv *priv;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> +			      "Cannot initialize register map\n");
> +
> +	devm_mutex_init(dev, &priv->lock);
> +
> +	priv->dv_gain = PAC1921_DEFAULT_DV_GAIN;
> +	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
> +	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
> +
> +	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				       &priv->rshunt_uohm);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Cannot read shunt resistor property\n");
> +	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid shunt resistor: %u\n",
> +				     priv->rshunt_uohm);
> +
> +	pac1921_calc_current_scales(priv);
> +
> +	priv->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(priv->vdd))
> +		return dev_err_probe(dev, (int)PTR_ERR(priv->vdd),
> +				     "Cannot get vdd regulator\n");
> +
> +	ret = regulator_enable(priv->vdd);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot enable vdd regulator\n");
> +
> +	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable,
> +				       priv->vdd);
> +	if (ret)
> +		return dev_err_probe(
> +			dev, ret,
Trivial: I'd move the dev, ret to previous line.

> +			"Cannot add action for vdd regulator disposal\n");
> +
> +	msleep(PAC1921_POWERUP_TIME_MS);
> +
> +	ret = pac1921_init(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot initialize device\n");
> +
> +	priv->iio_info = pac1921_iio;
> +
> +	indio_dev->name = id->name;

This tends to end up flakey at best when different types of firmware are taken
into account - IIRC particularly when fallback compatibles are in use.
So better to switch this to "pac1921" here.

> +	indio_dev->info = &priv->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = pac1921_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(pac1921_channels);



