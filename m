Return-Path: <linux-iio+bounces-19420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D9AB271D
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 10:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B4F3A7F07
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFEB199EAD;
	Sun, 11 May 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ow7v/TnW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C9139D;
	Sun, 11 May 2025 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746950785; cv=none; b=BDNpnPSd5suIyc6KTUwaPcy/mfB9Mm4HwwgVJIQu7U4YIx9Qc0MFU+aKU5p8Oom8W4FgKQWvS9x49d0mFK7BDQ/w3vZHZF2liMUehrh8bBKgtRpnjKm1CHgfMA1taWugKqDsb0L9hL2MFWWSccsMIdET2aeA5dKx6A9Fsn2bdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746950785; c=relaxed/simple;
	bh=Y8tOJC2aMCIdltMPzejd/0tAeYVR9F6WHfmMID/mOhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4RltksRB2gHMErI6vIKgIkRNpCjNua0Bu7TF1kKMFHQFNWqjUZIfqhSzzbMu6OWQlvImbE47kkU3tAUfx0kKF/tm0LRFomgiZZCyFrLW11q1YZJcM8P2i5w6Xo47EU/NxcPTA0277JKljRG/cAZrsKEp/vwB/f9tXwZJCLp9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ow7v/TnW; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id E1YouzOWUmq1yE1YouBaim; Sun, 11 May 2025 09:57:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746950243;
	bh=S6aRKGbPJOBzR/kbTKqk+c5qg8qzb2/kJY/g0Fp409Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ow7v/TnWlYslrKEGxHRUtZoPqwChyr7PDK8vROeq3rzvirmx0FnsZcCenW1PPAoy+
	 3gaz3zowCldJ1dsjs1MMdDEj3pYGeh2ZDWsyLQITvvyIW080Za2qMwW8dgclPkhnZ6
	 fa1wPZIqEfVSeIUMAJfpaRafanE6Pb/F0uy1Sl2kO2HlO9Bp8htnWZ2j8tBYfM608U
	 CfBhWlicdjc6qO63TUL/s3pgpJzc8w99tIS8QpfM9bdDiFKNw/YSKbHP9oLm4Qnthy
	 l2a8ZEGp6QgrZoccHdO/EMFijQdGWMO4WhJ6grr0Q7KLaBZhJxzSDlxbkmQuja6+dE
	 J8yVUdgE9rW+A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 11 May 2025 09:57:23 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a0677c8f-08f6-4b0d-8393-8086972475f2@wanadoo.fr>
Date: Sun, 11 May 2025 09:57:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
To: waqar.hameed@axis.com
Cc: jic23@kernel.org, kernel@axis.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1746802541.git.waqar.hameed@axis.com>
 <c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/05/2025 à 17:03, Waqar Hameed a écrit :
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
> The low-pass and high-pass cutoff frequencies are pairwise for the
> different available filter types. Because of this, only allow to set the
> low-pass cutoff frequency from `sysfs` and use that to configure the
> corresponding high-pass cutoff frequency. This is sufficient to
> unambiguously choose a filter type.
> 
> Raw data measurements can be obtained from the device. However, since we
> rely on bit banging, it will be rather cumbersome with buffer support.
> The main reason being that the data protocol has strict timing
> requirements (it's serial like UART), and it's mainly used during
> debugging since in real-world applications only the event notification
> is of importance. Therefore, only add support for events (for now).
> 
> Signed-off-by: Waqar Hameed <waqar.hameed-VrBV9hrLPhE@public.gmane.org>
> ---

Hi,

...

> +static int d3323aa_set_lp_filter_freq(unsigned long *regmap, const int val,
> +				      int val2)
> +{
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

Missing newline.

> +		if (val == integer && val2 == fract)
> +			break;
> +	}
> +
> +	if (idx == ARRAY_SIZE(d3323aa_lp_filter_freq))
> +		return -ERANGE;
> +
> +	bitmap_write(regmap, d3323aa_lp_filter_regval[idx],
> +		     D3323AA_REG_BIT_FILSEL0, D3323AA_FILTER_TYPE_NR_BITS);
> +
> +	return 0;
> +}

...

> +static int d3323aa_probe(struct platform_device *pdev)
> +{
> +	DECLARE_BITMAP(default_regmap, D3323AA_REG_NR_BITS);
> +	struct d3323aa_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "Could not allocate iio device\n");
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&data->reset_completion);
> +
> +	ret = devm_mutex_init(data->dev, &data->regmap_lock);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not initialize mutex (%d)\n", ret);

No need to repeat the error code in the message, when using dev_err_probe().

Same for all calls below.

> +
> +	/* Request GPIOs. */
> +	data->gpiod_vdd = devm_gpiod_get(data->dev, "vdd", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_vdd))
> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_vdd),
> +				     "Could not get GPIO vdd (%ld)\n",
> +				     PTR_ERR(data->gpiod_vdd));
> +
> +	data->gpiod_clk_vout =
> +		devm_gpiod_get(data->dev, "clk-vout", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_clk_vout))
> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_clk_vout),
> +				     "Could not get GPIO clk-vout (%ld)\n",
> +				     PTR_ERR(data->gpiod_clk_vout));
> +
> +	data->gpiod_data = devm_gpiod_get(data->dev, "data", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_data))
> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_data),
> +				     "Could not get GPIO data (%ld)\n",
> +				     PTR_ERR(data->gpiod_data));
> +
> +	ret = gpiod_to_irq(data->gpiod_clk_vout);
> +	if (ret < 0)
> +		return dev_err_probe(data->dev, ret, "Could not get IRQ (%d)\n",
> +				     ret);
> +
> +	data->irq = ret;
> +
> +	/* Do one setup with the default values. */
> +	bitmap_zero(default_regmap, D3323AA_REG_NR_BITS);
> +	d3323aa_set_threshold(default_regmap, D3323AA_THRESH_DEFAULT_VAL);
> +	d3323aa_set_filter_gain(default_regmap,
> +				D3323AA_FILTER_GAIN_DEFAULT_VAL);
> +	ret = d3323aa_setup(indio_dev, default_regmap);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &d3323aa_info;
> +	indio_dev->name = D3323AA_DRV_NAME;
> +	indio_dev->channels = d3323aa_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(d3323aa_channels);
> +
> +	ret = devm_iio_device_register(data->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not register iio device (%d)\n",
> +				     ret);
> +
> +	return 0;
> +}

...

CJ


