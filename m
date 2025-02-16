Return-Path: <linux-iio+bounces-15581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD36A375AA
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C761884A9B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD5199FA2;
	Sun, 16 Feb 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba0Ts5BV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A21B808;
	Sun, 16 Feb 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722901; cv=none; b=YcDHgN+Fsm7oB+o9+jDo6fj98rSpHXznL1qGti2L/juFCOMMwHAUk8Afzl83mlZgKknGF30gbqtNvtfY7y4UB+BI2vwnkLALxO/5CMMCda5ONhIbFbaRucJFwxoVGPqr8Q+dQV88unasvoJIMY/OsWlZL/JZFQrOPjaS7JzoGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722901; c=relaxed/simple;
	bh=fT2zYqJ6YLeX9QSBNjyLADGTECUTNaknokkdN6W1JFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Th55akttqFfJ4H6+xIH2Vxoy7qZfvkjIAf+3W/rFTSLA4NvTBLu5LGjZE/Vf+TGzERwaNiuX2blmZ4B+CNSYFtoHIfmT+dwXa6gxpVwEVxMXSsXrlbp1LhXZ5BRpm5D169Zt8K4X6Xh30+dsDX2vY4mWGq++jlls1D4nOhGiu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba0Ts5BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A940C4CEDD;
	Sun, 16 Feb 2025 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739722900;
	bh=fT2zYqJ6YLeX9QSBNjyLADGTECUTNaknokkdN6W1JFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ba0Ts5BVlDLjr2cniFRNNRjBTB7Xai2R/EIDFg1mvKBXWa4sV4yqZuxMF/7H+SQCc
	 u5ay3x3Q1xX09FKUDRhQXyzgWinQmXGpyyhHM5JBVsSCQPn+RzdG+UeZzeNTf+FA6h
	 dC7R8h2LjAuMCyv9ZkavCJyz86R3yiF6C2gK2QIGFyKSyQc3SmI4zkM9oZXORvqzzq
	 SEed9CF+ccUyo318XGJ3oNYEzUrBKzdh+Fvf5dZdZ1E7bltHpuZfTG/hJ5BUZFuNLz
	 ZuMGqyeyzniD81LcDS4S7ViVK3qjJN+beXG/Q37NwD1+LkMzX5SZCqTauwo7N2lJ7N
	 uDasgv3X3l70w==
Date: Sun, 16 Feb 2025 16:21:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <dlechner@baylibre.com>
Subject: Re: [PATCH RESEND v3 15/17] iio: adc: ad7768-1: replace manual
 attribute declaration
Message-ID: <20250216162130.0de4f148@jic23-huawei>
In-Reply-To: <ea5d5ef777d4d7d15471369813c1613990fee862.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
	<ea5d5ef777d4d7d15471369813c1613990fee862.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:18:48 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Use read_avail callback from struct iio_info to replace the manual
> declaration of sampling_frequency_available attribute.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * New patch in v3.
> ---
>  drivers/iio/adc/ad7768-1.c | 58 +++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 716cf3582577..8aea38c154fe 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -187,6 +187,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.indexed = 1,
>  		.channel = 0,
>  		.scan_index = 0,
> @@ -207,6 +208,7 @@ struct ad7768_state {
>  	unsigned int mclk_freq;
>  	unsigned int dec_rate;
>  	unsigned int samp_freq;
> +	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_clk_config)];
>  	struct completion completion;
>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
> @@ -564,28 +566,6 @@ static int ad7768_set_freq(struct ad7768_state *st,
>  	return 0;
>  }
>  
> -static ssize_t ad7768_sampling_freq_avail(struct device *dev,
> -					  struct device_attribute *attr,
> -					  char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7768_state *st = iio_priv(indio_dev);
> -	unsigned int freq;
> -	int i, len = 0;
> -
> -	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
> -		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
> -					 ad7768_clk_config[i].clk_div);
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
> -	}
> -
> -	buf[len - 1] = '\n';
> -
> -	return len;
> -}
> -
> -static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
> -
>  static int ad7768_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
> @@ -633,6 +613,29 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int ad7768_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int i;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
> +			st->samp_freq_avail[i] = DIV_ROUND_CLOSEST(st->mclk_freq,
> +								   ad7768_clk_config[i].clk_div);
There are some complex race conditions around these available arrays, so in
general it is better to make it obvious when they are static after
init vs actually dynamic.  In this case I think we can fill this
in the moment we know mclk_freq?  If so please move the calculation into
probe() and just reference it here.

How to close the race condition is an ongoing topic but I don't think
that problem applies here anyway!

Jonathan

> +
> +		*vals = (int *)st->samp_freq_avail;
> +		*length = ARRAY_SIZE(ad7768_clk_config);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int ad7768_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val, int val2, long info)
> @@ -655,15 +658,6 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
>  	return sprintf(label, "%s\n", st->labels[chan->channel]);
>  }
>  
> -static struct attribute *ad7768_attributes[] = {
> -	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group ad7768_group = {
> -	.attrs = ad7768_attributes,
> -};
> -
>  static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
>  					const struct iio_chan_spec *chan)
>  {
> @@ -674,8 +668,8 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info ad7768_info = {
> -	.attrs = &ad7768_group,
>  	.read_raw = &ad7768_read_raw,
> +	.read_avail = &ad7768_read_avail,
>  	.write_raw = &ad7768_write_raw,
>  	.read_label = ad7768_read_label,
>  	.get_current_scan_type = &ad7768_get_current_scan_type,


