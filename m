Return-Path: <linux-iio+bounces-7069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C891CEDC
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15577B2184F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA5132118;
	Sat, 29 Jun 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9SUy0kk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E3101F7;
	Sat, 29 Jun 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719690034; cv=none; b=ENB9alTvDN2VqtLAHG0hiUvbkydg8lSsAmqQADJzOjknjxFMV+6IzN/ywaT1fe92Lf53hLYaFZBxy8nfSJVkgVOaOdR6AzeajYHXbKToopVvEWl1DtC+B593BSDCzkVJNVLzbOXG1oytEloZSh5z4QUnm0Ce4otg/hB/8HOktvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719690034; c=relaxed/simple;
	bh=CLqV4T7POX7Nto6uLWv8qFe9eUAumC1+HgHxGpgT82g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpvpNH0m7OOZwFd/7FT3KqyEI4N+d5CjMZCKt9WHU9Ug+kTwFOGUbax0fiTboebTGKd92qSe1j5hvwxI22YEysTxBRN0xPd73yIB8ejbXe47ucwpdc3URq089ypQsPgyOzspf4gV2BnsyuiUlyjQhYszBAJ2KmTitc8e+jgw56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9SUy0kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87023C2BBFC;
	Sat, 29 Jun 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719690033;
	bh=CLqV4T7POX7Nto6uLWv8qFe9eUAumC1+HgHxGpgT82g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f9SUy0kkMsqEqHSodFumADPi9zKq82xLTNMbjGp9otlqPx/Kdwb2rGGiujUwtGHa3
	 Y0XkNSbfgfMmGt3WtAygWMMGcXVt6+7F28Kl2TWGtz+urvn4BAMdbrbB+fOSVmRAcq
	 dJKkNYWXFIlsONj9iLuMMJTsz7y3LZCrpAI86z1cVL6/qdTTM7YhYup1VACrTqiC0E
	 sST4ETm8wpQCruUm+DPEjrm3w/KtkGznaOgQVWfUbjf14UKZYSdKxBBwSH5bejENGk
	 f01jsaCwRA1Bp8wCNSkPBMUF8Qh2MSbyZvYOX7sui34n/zluR2fimv/4aTphdaZCOg
	 R11dqUqocCvSw==
Date: Sat, 29 Jun 2024 20:40:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
Message-ID: <20240629204025.683b1b69@jic23-huawei>
In-Reply-To: <20240624173105.909554-3-jbrunet@baylibre.com>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<20240624173105.909554-3-jbrunet@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 19:31:03 +0200
Jerome Brunet <jbrunet@baylibre.com> wrote:

> Add support for the HW found in most Amlogic SoC dedicated to measure
> system clocks.
> 
> This drivers aims to replace the one found in
> drivers/soc/amlogic/meson-clk-measure.c with following improvements:
> 
> * Access to the measurements through the IIO API:
>   Easier re-use of the results in userspace and other drivers
> * Controllable scale with raw measurements
> * Higher precision with processed measurements
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Interesting device and the driver is pretty clean.

Needs a new channel type though as altvoltage is in volts not hz.

Various minor comments inline.

Thanks,

Jonathan

> +
> +struct amlogic_cmsr {
> +	struct regmap *reg;
> +	struct regmap *duty;
> +	struct mutex lock;
Add a comment on the data protected by this lock.  Scope isn't always obvious.
> +};

> +static struct iio_chan_spec *cmsr_populate_channels(struct device *dev,
> +						    const char * const *conf)
> +{
> +	struct iio_chan_spec *chan;
> +	int i;
> +
> +	chan = devm_kzalloc(dev, sizeof(*chan) * CLK_MSR_MAX, GFP_KERNEL);
> +	if (!chan)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < CLK_MSR_MAX; i++) {
> +		chan[i].type = IIO_ALTVOLTAGE;

As per other branch of the thread.  I think this needs to be a new
IIO_FREQUENCY channel as the input we care about here is simply frequency,
not the voltage.

> +		chan[i].indexed = 1;
> +		chan[i].channel = i;
> +		chan[i].info_mask_separate = (BIT(IIO_CHAN_INFO_RAW) |
> +					    BIT(IIO_CHAN_INFO_PROCESSED));

Drop outer ()

> +		chan[i].info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +		chan[i].datasheet_name = conf[i];
> +	}
> +
> +	return chan;
> +}


> +static int cmsr_measure_processed_unlocked(struct amlogic_cmsr *cm,
> +					   unsigned int idx,
> +					   int *val2)
> +{
> +	unsigned int time = CLK_MIN_TIME;
> +	u64 rate;
> +	int ret;
> +
> +	/*
> +	 * The challenge here is to provide the best accuracy
> +	 * while not spending to much time doing it.
> +	 * - Starting with a short duration risk not detecting
> +	 *   slow clocks, but it is fast. All 128 can be done in ~8ms
> +	 * - Starting with a long duration risk overflowing the
> +	 *   measurement counter and would be way to long, especially
> +	 *   considering the number of disabled clocks. ~4s for all
> +	 *   128 worst case.
> +	 *
> +	 * This IP measures system clocks so all clock are expected
> +	 * to be 1kHz < f < 8GHz. We can compromise based on this,
> +	 * doing it in 3 pass:
> +	 * #1 Starting if 64us window: detects 30kHz < f < 8GHz
> +	 *    - Go to #2 if no detection, Go to #3 otherwise
> +	 * #2 Extend duration to 1024us (f > 1kHz)
> +	      - Assume f = 0Hz if no detection, Go to #3 otherwise
> +	 * #3 Clock has been detected, adjust window for best accuracy
> +	 *
> +	 * Doing the range detection takes ~1ms per clock, including disabled
> +	   clocks.
> +	 * Actual measurement takes at most ~65ms in step #3 for slow clocks,
> +	 * when the full range the HW is used.
> +	 */
> +
> +	/* Step #1 - quick measurement */
> +	cmsr_set_time_unlocked(cm, time);
> +	ret = cmsr_measure_unlocked(cm, idx);
> +	if (ret < 0)
> +		return ret;
> +

if (ret == 0)

> +	else if (ret == 0) {
> +		/* Step #2 - extend the window if necessary */
> +		time *= 16;
> +		cmsr_set_time_unlocked(cm, time);
> +		ret = cmsr_measure_unlocked(cm, idx);
> +		if (ret < 0)
> +			return ret;
> +
		if (ret == 0)

> +		else if (ret == 0) {
> +			/* Still nothing - assume no clock */
> +			*val2 = 0;
> +			return 0;
> +		}
> +	}
> +
> +	/* Step #3: Adapt scale for better precision */
> +	time = time * MSR_MEASURED * 3 / (ret * 4); /* 25% margin */
> +	time = min_t(unsigned int, MSR_TIME_MAX, time);
> +
> +	/* Actually measure rate with an optimized scale */
> +	cmsr_set_time_unlocked(cm, time);
> +	ret = cmsr_measure_unlocked(cm, idx);
> +	if (ret < 0)
> +		return ret;
> +
> +	rate = DIV_ROUND_CLOSEST_ULL(ret * 1000000ULL, time);
> +	*val2 = rate >> 32ULL;
> +	return (int)rate;
> +}



> +static int cmsr_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct amlogic_cmsr *cm;
> +	const char * const *conf;
> +	void __iomem *regs;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*cm));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, indio_dev);
> +	cm = iio_priv(indio_dev);
> +
> +	conf = of_device_get_match_data(dev);

We try to avoid of specific calls in IIO drivers.
device_get_match_data() should work here.

Reason for this is not that it matters in one driver, but that people tend
to cut and paste device tree stuff and it ends up in drivers where ACPI
and other firmware types are relevant.

Also I only have remember how one type of firmware property read call works ;)

> +	if (!conf) {
> +		dev_err(dev, "failed to match device\n");
> +		return -ENODEV;
> +	}
> +
> +	regs = devm_platform_ioremap_resource_byname(pdev, "reg");
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	cm->reg = devm_regmap_init_mmio(dev, regs, &cmsr_regmap_cfg);
> +	if (IS_ERR(cm->reg)) {
> +		dev_err(dev, "failed to init main regmap: %ld\n",
> +			PTR_ERR(cm->reg));
> +		return PTR_ERR(cm->reg);
> +	}
> +
> +	regs = devm_platform_ioremap_resource_byname(pdev, "duty");
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	cm->duty = devm_regmap_init_mmio(dev, regs, &cmsr_regmap_cfg);
> +	if (IS_ERR(cm->duty)) {
> +		dev_err(dev, "failed to init duty regmap: %ld\n",
> +			PTR_ERR(cm->duty));
> +		return PTR_ERR(cm->duty);
Preference for dev_err_probe() for all errors in probe() and functions
that will only be called form probe. There is a nice version that handled PTR_ERR
under review though so maybe we can come around later and use that once it's available

> +	}
> +
> +	mutex_init(&cm->lock);
> +
> +	/* Init scale with a sane default */
> +	cmsr_set_time_unlocked(cm, CLK_MIN_TIME);
> +
> +	indio_dev->name = "amlogic-clk-msr";
> +	indio_dev->info = &cmsr_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = CLK_MSR_MAX;

Superficially looks like the number of channels depends on the compatible.
Ideally we shouldn't provide channels to userspace that aren't useful.

You could search the name arrays to see how far they go, but that is bit ugly.
Probably wrap those in a structure with a num_channels parameter as well.

> +	indio_dev->channels = cmsr_populate_channels(dev, conf);
> +	if (IS_ERR(indio_dev->channels))
> +		return PTR_ERR(indio_dev->channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

