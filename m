Return-Path: <linux-iio+bounces-7051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033091CE7D
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF0E282D08
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703B712F392;
	Sat, 29 Jun 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="palDqF2z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333621364;
	Sat, 29 Jun 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719684350; cv=none; b=Sda+7bMpJU+vfWghYZeYiwrqv4Khe0TkHfZFcCCHj3e/qs/OAz2tVxzf9uVUBGijFSzPrk0qmv+yi0Q4yN78SG4lQOoK7q/z84mD51fk2Ddj6fw5QAE7hIwyXemEaa0kNpH47AUz6EmKAlQ5LHGN1AH2pEFCIpfluSWt480Vwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719684350; c=relaxed/simple;
	bh=dI4k+SaZT6NTxHrwYQE5RM+6yWoN2i+6zAWER+Q+Nr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMOugFzKKwmXWkMzHmtcqr9GcV24ftXGVEvmdZ7QTq3Slt3vvz5eeITP5q7uvNNrqQLXUIrmfRP5qZ45zat8OfBCMAL8x1vMUb0TSBTJ43xh7uwLR1n4iYQyUZV3L6uLG7OMitgFN9l5iqcmbDPnM7MpiLno+VIRCky5uVw7xoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=palDqF2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5592C2BBFC;
	Sat, 29 Jun 2024 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719684349;
	bh=dI4k+SaZT6NTxHrwYQE5RM+6yWoN2i+6zAWER+Q+Nr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=palDqF2z5omqov0r4C2DPdRaoyl+8QeBtl+VNAKn/7Pv69omfUMNGNaB0y7EELGry
	 ua+Stz6ceIcxmhWjfn3u3V2o1zUerEH/MQE7SV6qfK3RWPhbgvH9AvTepZZf4MPgsu
	 T9l1GZ6UQaDpGylmw1J/w+hWTzxoFXejOiw8NuO1iUhQlErX1zCrGFlpWVq2v71tr/
	 7OGXHT34fNjDly/kM32sQb/+9PFZMQjE7wewAl1443ZT9y5oAKM6JZoS6thdV8GPCz
	 MgBwVXBO3vZRRNMUJ/St4FlC9/4SL8m/zUTveLtAwSzXP+6fQlVFIZ0UFvZFHOLnIA
	 vNwk26s8cwxsQ==
Date: Sat, 29 Jun 2024 19:05:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
Message-ID: <20240629190538.46b5fc90@jic23-huawei>
In-Reply-To: <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
	<eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 18:55:27 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for AD4000 series of low noise, low power, high speed,
> successive approximation register (SAR) ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

You've clearly gotten some good review for this version so I only
had a quick scan through.  One thing did jump out at me though.

> +
> +static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +}
> +
> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	bool span_comp_en;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		mutex_lock(&st->lock);
> +		ret = ad4000_read_reg(st, &reg_val);
> +		if (ret < 0)
> +			goto err_unlock;
> +
> +		span_comp_en = val2 == st->scale_tbl[1][1];
> +		reg_val &= ~AD4000_CFG_SPAN_COMP;
> +		reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
> +
> +		ret = ad4000_write_reg(st, reg_val);
> +		if (ret < 0)
> +			goto err_unlock;
> +
> +		st->span_comp = span_comp_en;
> +err_unlock:
> +		iio_device_release_direct_mode(indio_dev);
> +		mutex_unlock(&st->lock);

Lock ordering needs another look. I'm not sure we an trigger
a deadlock but it definitely looks problematic. 

J



