Return-Path: <linux-iio+bounces-24306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C1B8C491
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E6D7E5359
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F62C0F8F;
	Sat, 20 Sep 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFMgtuF/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7C26C3B6;
	Sat, 20 Sep 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360473; cv=none; b=HOIFJl+tpY/FuTadOE1tnBkKkM9erwjWowjkM7eZzBei2j6AwTcVP5ITw8aWusfTA1uax1n8UJONOMK5FFWRKSOG1xKuzvQ/y7usRVFELCeaJwG7ywzcMrtmcMYUd3svFIyKd6P9ARmTt0ZxJcWk7g56WkC8Iq1qn2pem8I2X7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360473; c=relaxed/simple;
	bh=Lc09u9X94lEEG3LBJUedroXHRx27vtfPY3DlY03XCZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHKEZI/T7RlwhbijsY8a0NQks6F7e1rv408YALhH+DMGfOnHQUTQfJ3lCVD81RK/iu8SrPoIX9D5qI60EeGLe6dtLJx2UZhATLEW6HTYPRklrX8NgICsWVi9XHlHisggUa+uuqarXPw+pAR/m91NaRn07lpvaL4KjXWhtx45L/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFMgtuF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD86C4CEEB;
	Sat, 20 Sep 2025 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758360473;
	bh=Lc09u9X94lEEG3LBJUedroXHRx27vtfPY3DlY03XCZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFMgtuF/avyYJnbD96JMFSn3PpXC7TckW3LnD0lLk9BeWpBBdYXxiOji958Q6/0hO
	 V4F8IxFRqYUxKjQvfAYeLWdFyKJu8gOtYnDqnveJvs2G+L8PEGLEMqksMFZhWCVDu5
	 Xh/NURi3QcTrMW6v4kEZBi4veDLsk6bbwI/1KYpiU7UX9oTaDIvmNdxpww6YVReGkj
	 rNtQThwRzlGcMxjJoD1XY974UwpoJBG0eNOcRgPFTptmN4+7SmXwYceP3fGb9hu1Do
	 Vyt3ljvm2tS4tOgQt1Hpl6vfmwPtkfp7BEP76SDt3GyWouJap6TmWAX0YVLr4JCH//
	 rx2wo0twLrqyw==
Date: Sat, 20 Sep 2025 10:27:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v4 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20250920102742.4cadb734@jic23-huawei>
In-Reply-To: <20250919135618.3065608-3-daniel.lezcano@linaro.org>
References: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
	<20250919135618.3065608-3-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 15:56:18 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> 
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
> 
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
> 
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers, while the author refers to
> the initial BSP driver file creator.
> 
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.
> 
> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

The main issue I'm seeing here is the mix of devm and non devm cleanup
in the remove path + some additional manual unwind that I 'think'
you should never need if the ordering is correct.

Unfortunately I missed that on previous review. Sorry about that.
Subject to the merge window opening late for some reason this had already
missed this cycle though as IIO effectively closes a few days back (rc6ish)
so I can get a pull request out to Greg before rc7 and with a few days of testing
in next before that. Hence now we have plenty of time to get this ready
for next cycle.

Jonathan

> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> new file mode 100644
> index 000000000000..4e927540f583
> --- /dev/null
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -0,0 +1,1021 @@

> +
> +/* This will be the driver name the kernel reports. */
> +#define DRIVER_NAME "nxp-sar-adc"
As below, I don't think the define is useful compared to just setting the string
where it's meaning is already clear.  The comment seems unnecessary either way.


> +static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
> +{
> +	u32 mcr;
> +
> +	mcr = readl(NXP_SAR_ADC_MCR(info->regs));
> +	mcr |= NXP_SAR_ADC_MCR_NSTART;
> +
> +	if (raw)
> +		mcr &= ~NXP_SAR_ADC_MCR_MODE;
> +	else
> +		mcr |= NXP_SAR_ADC_MCR_MODE;

Could use FIELD_MODIFY() for this though saving is minor.
Same applies in various other places in this driver (and
many others!)

> +
> +	writel(mcr, NXP_SAR_ADC_MCR(info->regs));
> +
> +	return 0;
> +}
> +
> +static int nxp_sar_adc_read_channel(struct nxp_sar_adc *info, int channel)
> +{
> +	int ret;
> +
> +	info->current_channel = channel;
> +	nxp_sar_adc_channels_enable(info, BIT(channel));
> +	nxp_sar_adc_irq_cfg(info, true);
> +	nxp_sar_adc_enable(info);
> +
> +	reinit_completion(&info->completion);
> +	ret = nxp_sar_adc_start_conversion(info, true);
> +	if (ret < 0)
> +		goto out_disable;
> +
> +	ret = wait_for_completion_interruptible_timeout(&info->completion,
> +							NXP_SAR_ADC_CONV_TIMEOUT_JF);
> +	if (ret == 0)
> +		ret = -ETIMEDOUT;
> +	if (ret > 0)
> +		ret = 0;
> +
> +	nxp_sar_adc_stop_conversion(info);
> +
> +out_disable:
> +	nxp_sar_adc_channels_disable(info, BIT(channel));
> +	nxp_sar_adc_irq_cfg(info, false);
> +	nxp_sar_adc_disable(info);
> +
> +	return ret;
> +}
> +
> +static int nxp_sar_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,

Over long line.  I still target 80 chars for IIO unless readability is hurt.
Wrapping her seems fine to do.

> +				int *val, int *val2, long mask)
> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +	u32 inpsamp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret = nxp_sar_adc_read_channel(info, chan->channel);
> +
> +		iio_device_release_direct(indio_dev);
> +
> +		if (ret)
> +			return ret;
> +
> +		*val = info->value;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = info->vref_mV;
> +		*val2 = NXP_SAR_ADC_RESOLUTION;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		inpsamp = nxp_sar_adc_conversion_timing_get(info);
> +		*val = clk_get_rate(info->clk) / (inpsamp + NXP_SAR_ADC_CONV_TIME);
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +	u32 inpsamp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/*
> +		 * Configures the sample period duration in terms of
> +		 * the SAR controller clock. The minimum acceptable

Slightly short wrap - I'd go nearer 80 chars.

> +		 * value is 8. Configuring it to a value lower than 8
> +		 * sets the sample period to 8 cycles.  We read the
> +		 * clock value and divide by the sampling timing which
> +		 * gives us the number of cycles expected. The value
> +		 * is 8 bits wide, consequently the max value is 0xFF.
> +		 */
> +		inpsamp = clk_get_rate(info->clk) / val - NXP_SAR_ADC_CONV_TIME;
> +		nxp_sar_adc_conversion_timing_set(info, inpsamp);
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +static int nxp_sar_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct nxp_sar_adc_data *data = device_get_match_data(dev);
> +	struct nxp_sar_adc *info;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	int irq;
> +	int ret;

Might as well combine these two on one line.

> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	info->vref_mV = data->vref_mV;
> +
> +	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> +	if (IS_ERR(info->regs))
> +		return dev_err_probe(dev, PTR_ERR(info->regs),
> +				     "failed to get and remap resource");
> +
> +	info->regs_phys = mem->start;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
> +			       dev_name(dev), indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
> +
> +	spin_lock_init(&info->lock);
> +
> +	info->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk),
> +				     "failed to get the clock\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&info->completion);
> +
> +	indio_dev->name = data->model;
> +	indio_dev->info = &nxp_sar_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels = nxp_sar_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(nxp_sar_adc_iio_channels);
> +
> +	nxp_sar_adc_set_default_values(info);
> +
> +	ret = nxp_sar_adc_calibration(info);
> +	if (ret)
> +		dev_err_probe(dev, ret, "Calibration failed: %d\n", ret);
> +
> +	ret = nxp_sar_adc_dma_probe(dev, info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize the dma\n");
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &nxp_sar_adc_trigger_handler,
> +					      &iio_triggered_buffer_setup_ops);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Couldn't initialise the buffer\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't register the device\n");
> +
> +	return 0;
> +}
> +
> +static void nxp_sar_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +
> +	nxp_sar_adc_stop_conversion(info);

I assume this is safe even if no start has happened and is here so
that the driver remove can run whilst buffered capture is still going on?
That should be done by the core as part of unwinding the register().
So I'd not expect a need for it here. This may be a side effect of the
ordering issue mixing devm and not causes.  The same is true of some
of these other calls - I haven't checked them all.

> +	nxp_sar_adc_channels_disable(info, NXP_SAR_ADC_CH_MASK);
> +	nxp_sar_adc_dma_channels_disable(info, NXP_SAR_ADC_CH_MASK);
> +	nxp_sar_adc_dma_cfg(info, false);
> +	nxp_sar_adc_disable(info);
> +	dmaengine_terminate_sync(info->dma_chan);

Mixing devm and non devm is a never a good idea. Here one possible issue is that
the userspace interfaces are only torn down when devm unwind gets to unwind
devm_iio_device_register();  That happens well after this code has ripped down the
dma engine that a channel read will try to use.  It might be safe to do that
but it certainly makes the driver harder to reason about.

A simple 'rule' is once you first call a non devm function in probe that needs unwinding
in remove, you cannot call any more devm functions.   Whilst there are lots of cases
that are safe, this approach ensures none of the cases that aren't sneak in and makes
review straight forward.

devm_add_action_or_reset() can often be used to keep the chain of devm calls running,
sometimes covering everything such that we don't need a remove callback.

> +}

> +
> +static SIMPLE_DEV_PM_OPS(nxp_sar_adc_pm_ops, nxp_sar_adc_suspend, nxp_sar_adc_resume);
> +
> +static const struct nxp_sar_adc_data s32g2_sar_adc_data = { .vref_mV = 1800,
> +							    .model = "s32g2-sar-adc" };
Slightly nicer I think to burn a few lines and have this as:
static const struct nxp_sar_adc_data s32g2_sar_adc_data = {
	.vref_mV = 1800,
	.model = "s32g2-sar-adc",
};

That also makes it less noisy if we need to add more fields in future as
tends to happen with chip info type structures.  I'm kind of assuming this
exists in the first place because there are some similar parts likely to be
supported by this driver.


> +
> +static const struct of_device_id nxp_sar_adc_match[] = {
> +	{ .compatible = "nxp,s32g2-sar-adc", .data = &s32g2_sar_adc_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nxp_sar_adc_match);
> +
> +static struct platform_driver nxp_sar_adc_driver = {
> +	.probe = nxp_sar_adc_probe,
> +	.remove = nxp_sar_adc_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,

Given this define is only use once. I'd prefer to see the string here
than a rather pointless define.

> +		.of_match_table = nxp_sar_adc_match,
> +		.pm = pm_ptr(&nxp_sar_adc_pm_ops),
> +	},
> +};
> +module_platform_driver(nxp_sar_adc_driver);
> +
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("NXP SAR-ADC driver");
> +MODULE_LICENSE("GPL");


