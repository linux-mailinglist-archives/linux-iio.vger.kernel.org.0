Return-Path: <linux-iio+bounces-19441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FFAB2961
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51117AB152
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96425C6E9;
	Sun, 11 May 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFIzoDrw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDA23E235;
	Sun, 11 May 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746977598; cv=none; b=ORxwJOiFQ91obtLtJpTRFMfRK9KWMZ3J6ZmXR5peMH86IzCeoFZyrAeBH79UCXzR15CWwfTXiAaPoj/eYKtK0ZSaIFhwSCwf49tWMQsoX8y6j/LstI1QAB0Ur6mROx5HqujXjaFnDEF3PAbXepC+LJrYg3qmi3s5xzbBvejkJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746977598; c=relaxed/simple;
	bh=C0iCaNSnIqBToiCotuuqagsumz7rSI92jdSoF5GHqQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3acIMelrtUE/BJwUPbk2BBu28ZTfuTxHZA5Nnpz9G5lcTSqeVYUjRNXolwWcbcNsOzp5joBb0nPzMR4SWqIM+AOUDvSg7OlpWwxoLBkSK8sn5z5zhoWhzVxJP0QBpsXYXT4o91flm32j/96a9p3idQTT8XAhc6WxMzh+0bU1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFIzoDrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DE7C4CEE4;
	Sun, 11 May 2025 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746977597;
	bh=C0iCaNSnIqBToiCotuuqagsumz7rSI92jdSoF5GHqQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qFIzoDrwl27jwkRwFGOK5L/6YWjcDGCVKt6pUXfLqVNdPN23EQq2gEgRri/fHazhs
	 k4E9jp1bciGlozhYfffFIfHmgCfCiVAdTdAKisXFNtO0shws/Emja54tCe6YJ9Ezu2
	 8yrM1F7ETkclYbaf+O1d2g6K6Jq9EZ1tvRQ67RwJOZF8E/vZWLIwH0tx3DBhY16mth
	 zxcd1PfRb7v2hPgN6tSwsEM+TiVzAm0oC5jtmvLxY4MnwZSqIu7Omcfnn2dJrRYSl0
	 p79v4DG3WHdHVYFaDZWaaIFB6xh2WWGyetCHt10uE9cHU1kIKvkq74w+wEXixPzqfR
	 R8BotJZb6Pz7w==
Date: Sun, 11 May 2025 16:33:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brajesh Patil <brajeshpatil11@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com,
 dlechner@baylibre.com
Subject: Re: [PATCH v2 4/5] iio: magnetometer: qmc5883l: add extended sysfs
 attributes and configuration options
Message-ID: <20250511163310.01522d27@jic23-huawei>
In-Reply-To: <20250508120900.114348-2-brajeshpatil11@gmail.com>
References: <20250508120900.114348-1-brajeshpatil11@gmail.com>
	<20250508120900.114348-2-brajeshpatil11@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 13:08:59 +0100
Brajesh Patil <brajeshpatil11@gmail.com> wrote:

> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> ---
>  drivers/iio/magnetometer/qmc5883l.c | 276 +++++++++++++++++++++++++++-
>  1 file changed, 274 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
> index 68597cdd0ca8..07c65f193def 100644
> --- a/drivers/iio/magnetometer/qmc5883l.c
> +++ b/drivers/iio/magnetometer/qmc5883l.c
> @@ -54,6 +54,20 @@
>  #define QMC5883L_OSR_MASK           0xC0
>  #define QMC5883L_OSR_SHIFT          6
> 
> +static const char *const qmc5883l_modes[] = {
> +	"standby", "continuous"

We try to tie modes like this to what sort of read paterns
we are setting. Can be done with runtime pm or difference between buffered
support and sysfs accesses but we almost never expose the control to userspace
directly.

> +};
> +
> +static const int qmc5883l_odr_avail[][2] = {
> +	{10, 0}, {50, 0}, {100, 0}, {200, 0}

{ 10 , 0 }, etc and trailing comma as not inherent to that last
value that it is a terminator or anything like that.

> +};
> +
> +static const char *const qmc5883l_osr_avail[] = {
> +	"512", "256", "128", "64"
> +};
> +
> +static const int qmc5883l_scale_avail[] = {2, 8};
{ 2, 8, }

> +
>  static const int qmc5883l_odr_map[] = {
>  	[QMC5883L_ODR_10HZ]  = 10,
>  	[QMC5883L_ODR_50HZ]  = 50,
> @@ -82,6 +96,12 @@ struct qmc5883l_data {
> 
>  static int qmc5883l_init(struct qmc5883l_data *data);
>  static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode);
> +static ssize_t qmc5883l_show_odr_avail(struct device *dev,
> +				       struct device_attribute *attr, char *buf);
> +static ssize_t qmc5883l_show_scale_avail(struct device *dev,
> +					 struct device_attribute *attr, char *buf);
> +static ssize_t qmc5883l_show_status(struct device *dev,
> +				    struct device_attribute *attr, char *buf);
> 

Generally reorganize your code to avoid need for forwards declarations.

> 
> +static const struct iio_enum qmc5883l_mode_enum = {
> +	.items = qmc5883l_modes,
> +	.num_items = ARRAY_SIZE(qmc5883l_modes),
> +	.get = qmc5883l_get_mode_iio,
> +	.set = qmc5883l_set_mode_iio,
> +};
> +
> +static const struct iio_enum qmc5883l_osr_enum = {
> +	.items = qmc5883l_osr_avail,
> +	.num_items = ARRAY_SIZE(qmc5883l_osr_avail),
> +	.get = qmc5883l_get_osr_iio,
> +	.set = qmc5883l_set_osr_iio,
> +};
> +
> +static const struct iio_chan_spec_ext_info qmc5883l_ext_info[] = {
> +	IIO_ENUM("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),

Whilst I haven't yet looked at details here, mode attributes are basically unusable by
generic software.  If at all possible hid that in the driver by auto switching
modes as appropriate to what userspace is asking you to do.

> +	IIO_ENUM_AVAILABLE("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),
> +	IIO_ENUM("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),

standard ABI, so do that the normal way.

> +	IIO_ENUM_AVAILABLE("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
> +	{ }
> +};
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(qmc5883l_show_odr_avail);
> +static IIO_DEVICE_ATTR(scale_available, 0444, qmc5883l_show_scale_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(data_ready, 0444, qmc5883l_show_status, NULL, 0);
> +static IIO_DEVICE_ATTR(overflow, 0444, qmc5883l_show_status, NULL, 0);
> +

> 
> +static int qmc5883l_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	int odr, range;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val == 10 && val2 == 0)

If val2 == 0 is required for all. Check that once only.

> +			odr = QMC5883L_ODR_10HZ;
> +		else if (val == 50 && val2 == 0)
> +			odr = QMC5883L_ODR_50HZ;
> +		else if (val == 100 && val2 == 0)
> +			odr = QMC5883L_ODR_100HZ;
> +		else if (val == 200 && val2 == 0)
> +			odr = QMC5883L_ODR_200HZ;
> +		else
> +			return -EINVAL;
> +
> +		return qmc5883l_set_odr(data, odr);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val == 2 && val2 == 0)
> +			range = QMC5883L_RNG_2G;
> +		else if (val == 8 && val2 == 0)
> +			range = QMC5883L_RNG_8G;
> +		else
> +			return -EINVAL;
> +
> +		return qmc5883l_set_rng(data, range << QMC5883L_RNG_SHIFT);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int qmc5883l_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -321,6 +577,7 @@ static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
>  		.storagebits = 16,          \
>  		.endianness = IIO_LE,           \
>  	},                      \
> +	.ext_info = qmc5883l_ext_info,      \
>  }
> 
>  static const struct iio_chan_spec qmc5883l_channels[] = {
> @@ -337,6 +594,18 @@ static const struct iio_chan_spec qmc5883l_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> 
> +static struct attribute *qmc5883l_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
Use the get_avail() callback and standard core handlign for this.

> +	&iio_dev_attr_scale_available.dev_attr.attr,
and this.

> +	&iio_dev_attr_data_ready.dev_attr.attr,
> +	&iio_dev_attr_overflow.dev_attr.attr,

Seconding what David said about custom ABI. Fit with normal ABI where possible
and think very very hard about whether additional ABI is needed or whether you
can set the relevant stuff internally.

For example data_ready isn't something we'd normally expose to userspace
directly at all.

> +	NULL
> +};

