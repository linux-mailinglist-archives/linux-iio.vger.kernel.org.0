Return-Path: <linux-iio+bounces-25231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B113BED3D5
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7526A34AEF5
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3D24166C;
	Sat, 18 Oct 2025 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlaZNbEa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC413D521;
	Sat, 18 Oct 2025 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804794; cv=none; b=diNlfJpB3oabjSaBFigM5ReLUKfPscbasSMf472n8m/+9EnxPAh43JhE7RK21+lTRRFfiY0ptFv42t231vWlpyG86R4E08g7pNSxEUqAdUFyAV41BvDitygGq4B+U5BQ0yl9oDablta1Nc+OmsztFS8Gm2slLxqeHvvxrot0X3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804794; c=relaxed/simple;
	bh=rL1t/wJ1tLvV78IGL+3G159+J8nTlTIq+yCmhW7s30I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtOVvzqeH/GSKwXnNCMvEZjX/pov52SQZGslHpcbEVCDGH8fqYTDPhfNNxDtkua7EZ4RVJnyamCHBU0aGpqJzVBgMjyo1lYYDDfBpU2vRxCbz78V50ackoMeXVECiUTo4HcCBxeAqQurJw+QMke24+5Oxzx5rh80bQ8L7ltYnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlaZNbEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C86C4CEF8;
	Sat, 18 Oct 2025 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760804793;
	bh=rL1t/wJ1tLvV78IGL+3G159+J8nTlTIq+yCmhW7s30I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qlaZNbEaNpThAmrMHJnf+W2A3cuWFsosCEkKdoQoG42CHY8tnOD/zV/u33ry1kHfR
	 bjppYkKd/8Um4yWbLfUtipm11WJdMvLVV5PCMziigxcAlDJTMuMSuywpI/ChA5u2d8
	 1BbwPsAKmVg2Y9+v+5/96JRe2v03nkTf09bh9MlSDYAfCz3Wg21fLh/veCLK3czfKq
	 bFAiWrahETUA7u1TG1rkYX/8oA2/eInj3smRiNrpW04EYM2GxHmYQj/pKGh49BL3Jf
	 0Iqv/zQsZusBzOS0y81Qxx+UBe8VD/5ipwfXE6KCYim6uh2dKDc1lTQsbgZn63z8Nd
	 r7qWcoUzk9Twg==
Date: Sat, 18 Oct 2025 17:26:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 7/7] iio: adc: ad4062: Add IIO Events support
Message-ID: <20251018172625.42f13f4a@jic23-huawei>
In-Reply-To: <20251013-staging-ad4062-v1-7-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
	<20251013-staging-ad4062-v1-7-0f8ce7fef50c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 09:28:05 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
> Either signal, if not present, fallback to an I3C IBI with the same
> role.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
The one bit of this that I'm not sure on is the apparent dropping out
of monitor mode on most userspace interactions that cause register accesses.
That seems like a fairly unintuitive ABI. It might be better to block the access
until the events are turned off. Perhaps I missed something?

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad4062.c | 351 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 347 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> index 40b7c10b8ce7145b010bb11e8e4698baacb6b3d3..b5b12f81c71b52f244600ed23dad11253290b868 100644
> --- a/drivers/iio/adc/ad4062.c
> +++ b/drivers/iio/adc/ad4062.c
> @@ -13,6 +13,7 @@

> +/**
> + * A register access will cause the device to drop from monitor mode
> + * into configuration mode, update the state to reflect that.
> + */
> +static void ad4062_exit_monitor_mode(struct ad4062_state *st)
> +{
> +	if (st->wait_event) {
> +		pm_runtime_mark_last_busy(&st->i3cdev->dev);

> +		pm_runtime_put_autosuspend(&st->i3cdev->dev);
As elsewhere, no longer need to have the mark_last_busy() call here.

> +		st->wait_event = 0;
> +	}
> +}

> +static ssize_t sampling_frequency_available_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct ad4062_state *st = iio_priv(dev_to_iio_dev(dev));
> +	int ret = 0;
> +
> +	for (u8 i = AD4062_FS_OFFSET(st->chip->grade);
> +	     i < AD4062_FS_LEN(st->chip->grade); i++)
> +		ret += sysfs_emit_at(buf, ret, "%s ", ad4062_conversion_freqs[i]);
> +
> +	ret += sysfs_emit_at(buf, ret, "\n");
> +	return ret;

Has slightly ugly format of " \n" at end rather than "\n"
There are various ways to handle this perhaps easiest is something like
	for (u8 i = AD4062_FS_OFFSET(st->chip->grade);
	     i < AD4062_FS_LEN(st->chip->grade); i++)
		ret += sysfs_emit_at(buf, ret, "%s%c", ad4062_conversion_freqs[i],
				      i != (AD4062_FS_LEN(st->chip_grade) - 1) ? "\n", " ");


> +}

>  static irqreturn_t ad4062_poll_handler(int irq, void *p)
> @@ -523,6 +645,24 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
>  	struct device *dev = &st->i3cdev->dev;
>  	int ret;
>  
> +	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp0");
> +	if (ret >= 0) {
> +		ret = devm_request_threaded_irq(dev, ret, NULL,
> +						ad4062_irq_handler_thresh,
> +						IRQF_ONESHOT, indio_dev->name,
> +						indio_dev);
> +		if (ret)
> +			return ret;
> +	} else if (ret != -EPROBE_DEFER) {
> +		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
> +					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN,
> +					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN);
> +		if (ret)
> +			return ret;
> +	} else {
> +		return ret;

As before. I'd prefer error cases handled first. The earlier code suggestion
doesn't quite work but something along those lines should be doable.

> +	}
> +
>  	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp1");
>  	if (ret >= 0) {
>  		ret = devm_request_threaded_irq(dev, ret, NULL,

> @@ -779,6 +923,196 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
> +{
> +	int ret = 0;
> +
> +	if (!enable)
> +		goto out_suspend;
> +
> +	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4062_conversion_frequency_set(st, st->events_frequency);
> +	if (ret)
> +		goto out_suspend;
> +
> +	ret = ad4062_set_operation_mode(st, AD4062_MONITOR_MODE);
> +	if (ret)
> +		goto out_suspend;
> +
> +	return ret;
return 0;

> +out_suspend:
> +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> +	return ret;
> +}

>  static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct ad4062_state *st = iio_priv(indio_dev);
> @@ -788,6 +1122,7 @@ static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
>  	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
>  	if (ret)
>  		return ret;
> +	ad4062_exit_monitor_mode(st);
Hmm. So you always exist monitor mode if we enable the buffer. I assume that doesn't
change detection of events because the buffered mode also allows that?

Do we not need something to turn monitor mode on again once we disable buffered capture?
>  
>  	ret = ad4062_set_operation_mode(st, st->mode);
>  	if (ret)
> @@ -833,6 +1168,7 @@ static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg
>  
>  	if (!iio_device_claim_direct(indio_dev))
>  		return -EBUSY;
> +	ad4062_exit_monitor_mode(st);

This probably needs a comment. Not obvious to me how you end up in with it enabled
again after the debugfs read / write finishes.

>  
>  	if (readval)
>  		ret = regmap_read(st->regmap, reg, readval);

