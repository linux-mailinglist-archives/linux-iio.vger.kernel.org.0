Return-Path: <linux-iio+bounces-20839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE2AE2F73
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 13:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E75E3AA935
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5B1D07BA;
	Sun, 22 Jun 2025 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkQ45GX+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68578FC0A;
	Sun, 22 Jun 2025 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750590484; cv=none; b=tOcJQ1SeVLyCeSP2dQfor2f/o3eS1jwFtg2PELyeFpzYe0/ZbqZ2lNeVN177O2z1fy3V+pCii9l3eCahEMqVyZE0sQBFzRwDpxkgX+b1HSANsbTwVbS/JwUlinfGeYVzntbqUvquxFb+2Kh9N85v2S4itZrZD5/BptIn+mfU4xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750590484; c=relaxed/simple;
	bh=/yYTax06xlTe/0kQcfJRbRTxV832gjWFG275Oh9hmnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ/PNUGdOgJgPF9Pljo4CgRb+p25LkhXTwd2XT/gfjXriAOgCMPlLMM0REO2HUIe9nrhcBFK5jVK7XXpmYjxPybv++VqsjJtMH3mCJg7iuiIehVYrpRhlj+pojdDbQWNoT2PRlpuS0bQ3QAke7DnM1eBLsggQ/N1+SXBvPG/Caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkQ45GX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6093C4CEE3;
	Sun, 22 Jun 2025 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750590484;
	bh=/yYTax06xlTe/0kQcfJRbRTxV832gjWFG275Oh9hmnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rkQ45GX+QqPurL6j2gAcWykGtLE4jfq7H/fvrjEvOOrmFOimUH9XJP4sq09e5q0uP
	 Lu+PEfGmvluShOsg3jzRHn8pnp/TXf2jUH+b9siF/RQsBkDtelnc4xgMi1XgKNdPBR
	 NhNYzk3n13p8ucU4e7EdNQ7SETxsGYDFjFpajxGMzqDFtqqmu6aEJ9Sz8g4GORmPpM
	 94GUqb0Uq920QyLDYPH2+QBvrC6dlpr8XH0kpeUjaPbqBcuByMG5BOL2oQixNmFwyU
	 TA1IzW5Kb21id6MOpckMS3BGcBTWvViZKClroUe/FTwKNUv9/KKCPAtR+0YiQisiw3
	 +xL8eE8vtIT8A==
Date: Sun, 22 Jun 2025 12:07:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
Message-ID: <20250622120756.3865fc4b@jic23-huawei>
In-Reply-To: <5d12fcd6faae86f7280e753f887ea60513b22ea9.1749938844.git.waqar.hameed@axis.com>
References: <cover.1749938844.git.waqar.hameed@axis.com>
	<5d12fcd6faae86f7280e753f887ea60513b22ea9.1749938844.git.waqar.hameed@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Jun 2025 00:14:05 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Nicera D3-323-AA is a PIR sensor for human detection. It has support for
> raw data measurements and detection notification. The communication
> protocol is custom made and therefore needs to be GPIO bit banged.
> 
> The device has two main settings that can be configured: a threshold
> value for detection and a band-pass filter. The configurable parameters
> for the band-pass filter are the high-pass and low-pass cutoff
> frequencies and its peak gain. Map these settings to the corresponding
> parameters in the `iio` framework.
> 
> Raw data measurements can be obtained from the device. However, since we
> rely on bit banging, it will be rather cumbersome with buffer support.
> The main reason being that the data protocol has strict timing
> requirements (it's serial like UART), and it's mainly used during
> debugging since in real-world applications only the event notification
> is of importance. Therefore, only add support for events (for now).
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

A few minor comments inline given you are doing another version for the DT change.


> diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
> new file mode 100644
> index 000000000000..71bccca75abd
> --- /dev/null
> +++ b/drivers/iio/proximity/d3323aa.c
> @@ -0,0 +1,808 @@

> +
> +static irqreturn_t d3323aa_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	enum iio_event_direction dir;
> +	int val;
> +
> +	val = gpiod_get_value(data->gpiod_clkin_detectout);
> +	if (val < 0) {
> +		dev_err_ratelimited(data->dev,
> +				    "Could not read from GPIO vout-clk (%d)\n",
> +				    val);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!data->detecting) {
> +		/* Reset interrupt counting falling edges. */
> +		if (!val && atomic_inc_return(&data->irq_reset_count) ==
> +				    D3323AA_IRQ_RESET_COUNT)
Odd line break
		if (!val &&
		    atomic_inc_return(&data->irq_reset_count) == D3323AA_IRQ_RESET_COUNT)

Is a bit better though rather long line.  I'm not completely clear on why it needs
to be an atomic counter though as the comment in reset() to to imply this
can't race with the zeroing and no one else touches it.


> +			complete(&data->reset_completion);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* Detection interrupt. */
> +	dir = val ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
> +	iio_push_event(indio_dev,
> +		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +					    IIO_EV_TYPE_THRESH, dir),
> +		       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int d3323aa_reset(struct iio_dev *indio_dev)
> +{
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	long time;
> +	int ret;
> +
> +	if (regulator_is_enabled(data->regulator_vdd)) {

Add a comment to say this check is only for the use in probe() where
the power may not be on yet.  In other paths I think it will always
be on.

> +		ret = regulator_disable(data->regulator_vdd);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Datasheet says VDD needs to be low at least for 30 ms. Let's add a
> +	 * couple more to allow VDD to completely discharge as well.
> +	 */
> +	msleep(30 + 5);

Use fsleep here as well with the parameter value in usecs.  It will use msleep
under the hood but we don't need to enforce that in the driver.  On some particular
platform some other sleep call may be more suited.

> +
> +	/*
> +	 * After setting VDD to high, the device signals with

This is a little odd.  vdd, as the regulator is currently low as you powered it down.
This is referring I think to what happens later.  Edit the comment to make that
clearer.  Someting like * When VDD is later enabled...


> +	 * D3323AA_IRQ_RESET_COUNT falling edges on Vout/CLK that it is now
> +	 * ready for configuration. Datasheet says that this should happen
> +	 * within D3323AA_RESET_TIMEOUT ms. Count these two edges within that
> +	 * timeout.
> +	 */
> +	atomic_set(&data->irq_reset_count, 0);
> +	reinit_completion(&data->reset_completion);
> +	data->detecting = false;
> +
> +	ret = gpiod_direction_input(data->gpiod_clkin_detectout);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(data->dev, "Resetting...\n");
> +
> +	ret = regulator_enable(data->regulator_vdd);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait for VDD to completely charge up. Measurements have shown that
> +	 * Vout/CLK signal slowly ramps up during this period. Thus, the digital
> +	 * signal will have bogus values. It is therefore necessary to wait
> +	 * before we can count the "real" falling edges.
> +	 */
> +	usleep_range(2000, 5000);
> +
> +	time = wait_for_completion_killable_timeout(
> +		&data->reset_completion,
> +		msecs_to_jiffies(D3323AA_RESET_TIMEOUT));
> +	if (time == 0) {
> +		return -ETIMEDOUT;
> +	} else if (time < 0) {
> +		/* Got interrupted. */
> +		return time;
> +	}
> +
> +	dev_dbg(data->dev, "Reset completed\n");
> +
> +	return 0;
> +}
> +
> +static int d3323aa_setup(struct iio_dev *indio_dev, size_t lp_filter_freq_idx,
> +			 size_t filter_gain_idx, u8 detect_thresh)
> +{
> +	DECLARE_BITMAP(write_regbitmap, D3323AA_REG_NR_BITS);
> +	DECLARE_BITMAP(read_regbitmap, D3323AA_REG_NR_BITS);
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	unsigned long start_time;
> +	int ret;
> +
> +	ret = d3323aa_reset(indio_dev);
> +	if (ret) {
> +		if (ret != -ERESTARTSYS)
> +			dev_err(data->dev, "Could not reset device (%d)\n",
> +				ret);
> +
> +		return ret;
> +	}
> +
> +	/*
> +	 * Datasheet says to wait 10 us before setting the configuration.
> +	 * Moreover, the total configuration should be done within
> +	 * D3323AA_CONFIG_TIMEOUT ms. Clock it.
> +	 */
> +	usleep_range(10, 20);

fsleep() preferred as that generalizes the tolerances fed to usleep_range()
so we don't have to think if they are appropriate in each call.


> +	start_time = jiffies;
> +
> +	ret = d3323aa_write_settings(indio_dev, write_regbitmap);
> +	if (ret) {
> +		dev_err(data->dev, "Could not write settings (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = d3323aa_read_settings(indio_dev, read_regbitmap);
> +	if (ret) {
> +		dev_err(data->dev, "Could not read settings (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	if (time_is_before_jiffies(start_time +
> +				   msecs_to_jiffies(D3323AA_CONFIG_TIMEOUT))) {
> +		dev_err(data->dev, "Could not set up configuration in time\n");
> +		return -EAGAIN;
> +	}
> +
> +	/* Check if settings were set successfully. */
> +	if (!bitmap_equal(write_regbitmap, read_regbitmap,
> +			  D3323AA_REG_NR_BITS)) {
> +		dev_err(data->dev, "Settings data mismatch\n");
> +		return -EIO;
> +	}
> +
> +	/* Now in operational mode. */
> +	ret = gpiod_direction_input(data->gpiod_clkin_detectout);
> +	if (ret) {
> +		dev_err(data->dev,
> +			"Could not set GPIO vout-clk as input (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_direction_input(data->gpiod_data);
> +	if (ret) {
> +		dev_err(data->dev, "Could not set GPIO data as input (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	data->lp_filter_freq_idx = lp_filter_freq_idx;
> +	data->filter_gain_idx = filter_gain_idx;
> +	data->detect_thresh = detect_thresh;
> +	data->detecting = true;
> +
> +	dev_dbg(data->dev, "Setup done\n");
> +
> +	return 0;
> +}
> +
> +static int d3323aa_set_lp_filter_freq(struct iio_dev *indio_dev, const int val,
> +				      int val2)
> +{
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	size_t idx;
> +
> +	/* Truncate fractional part to one digit. */
> +	val2 /= 100000;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(d3323aa_lp_filter_freq); ++idx) {
> +		int integer = d3323aa_lp_filter_freq[idx][0] /
> +			      d3323aa_lp_filter_freq[idx][1];
> +		int fract = d3323aa_lp_filter_freq[idx][0] %
> +			    d3323aa_lp_filter_freq[idx][1];
> +
> +		if (val == integer && val2 == fract)
> +			break;
> +	}
> +
> +	if (idx == ARRAY_SIZE(d3323aa_lp_filter_freq))
> +		return -ERANGE;

It's a patch not a range check, so -EINVAL may make more sense as
a return value.

> +
> +	return d3323aa_setup(indio_dev, idx, data->filter_gain_idx,
> +			     data->detect_thresh);
> +}

> +
> +static void d3323aa_disable_regulator(void *indata)
> +{
> +	struct d3323aa_data *data = indata;
> +	int ret;
> +
> +	if (!regulator_is_enabled(data->regulator_vdd))
> +		return;
> +

This is unusual and I think an artefact of where you are registering
the devm callback and the use of reset later.  Needs a comments
at the very least to explain why the check is needed.

> +	ret = regulator_disable(data->regulator_vdd);
> +	if (ret)
> +		dev_err(data->dev, "Could not disable regulator (%d)\n", ret);
> +}
> +
> +static int d3323aa_probe(struct platform_device *pdev)
> +{
> +	struct d3323aa_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,

Given there is a lot of use of either pdev->dev or data->dev which is
the same thing, I'd suggest a local declaration at the top and use that
throughout.

	struct device *dev = &pdev->dev;

> +				     "Could not allocate iio device\n");
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = &pdev->dev;
> +
> +	init_completion(&data->reset_completion);
> +
> +	ret = devm_mutex_init(data->dev, &data->statevar_lock);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not initialize mutex\n");
> +
> +	data->regulator_vdd = devm_regulator_get_exclusive(data->dev, "vdd");
> +	if (IS_ERR(data->regulator_vdd))
> +		return dev_err_probe(data->dev, PTR_ERR(data->regulator_vdd),
> +				     "Could not get regulator\n");
> +
> +	ret = devm_add_action_or_reset(data->dev, d3323aa_disable_regulator,

This is in a slightly odd place as you haven't turned it on yet. 
At very least add a comment. 


> +				       data);
> +	if (ret)
> +		return dev_err_probe(
> +			data->dev, ret,
> +			"Could not add disable regulator action\n");
Odd formatting.

		return dev_err_probe(dev, ret,
				     "Could not add disable regulator action\n");

It's fine to go a little over 80 chars if it helps readability and here I think
it does. However it is vanishingly unlikely this would fail (as it basically means
memory allocation is failing in which case not much is going to work) so
common practice is not to bother with prints for failed devm_add_action_or_reset().
Those prints do make sense for devm calls that are doing something more complex
though so keep the rest.

	if (ret)
		return ret;

is fine here.


> +
> +	data->gpiod_clkin_detectout =
> +		devm_gpiod_get(data->dev, "vout-clk", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_clkin_detectout))
> +		return dev_err_probe(data->dev,
> +				     PTR_ERR(data->gpiod_clkin_detectout),
> +				     "Could not get GPIO vout-clk\n");
> +
> +	data->gpiod_data = devm_gpiod_get(data->dev, "data", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_data))
> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_data),
> +				     "Could not get GPIO data\n");
> +
> +	ret = gpiod_to_irq(data->gpiod_clkin_detectout);
> +	if (ret < 0)
> +		return dev_err_probe(data->dev, ret, "Could not get IRQ\n");
> +
> +	/*
> +	 * Device signals with a rising or falling detection signal when the
> +	 * proximity data is above or below the threshold, respectively.
> +	 */
> +	ret = devm_request_irq(data->dev, ret, d3323aa_irq_handler,
> +			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +			       dev_name(data->dev), indio_dev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> +
> +	ret = d3323aa_setup(indio_dev, D3323AA_LP_FILTER_FREQ_DEFAULT_IDX,
> +			    D3323AA_FILTER_GAIN_DEFAULT_IDX,
> +			    D3323AA_THRESH_DEFAULT_VAL);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &d3323aa_info;
> +	indio_dev->name = "d3323aa";
> +	indio_dev->channels = d3323aa_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(d3323aa_channels);
> +
> +	ret = devm_iio_device_register(data->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not register iio device\n");
> +
> +	return 0;
> +}

