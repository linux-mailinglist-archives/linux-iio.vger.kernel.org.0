Return-Path: <linux-iio+bounces-18689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4D0A9DB39
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C717AE1B8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 13:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27451DDC16;
	Sat, 26 Apr 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcQjy28L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF91DDA36;
	Sat, 26 Apr 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674825; cv=none; b=i7960ljtu+0na8Lz2L1TKrgV0P3x17U44RNpQRR55/wHp3iSn6UaL0M5qmxHXoF4lxh/bjUNC4831aMAQpAPJi/7TRtzrqZzd+yFSfLqCxr6M3x3KhxA2FzLfYOvzmb+yaOpnEejcADpEbyb7ny7ezMq8dr/D/gdR4BHpGIZtWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674825; c=relaxed/simple;
	bh=a9YheHxg1bV1k91w8fVr/bZrKoFwcOIpG9RZjVvkrz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY3dKXbPsOehQQupswXK0DoxqDrMphjthIfRjaR/2LoNQta5yLJusICTLkvv7yK6tFfp6pw/aPbHsT88/a5q/fIqe2AtmdRqMwbeMgzyzdzI1v/H3n4iYqk97VRYd6BVzDWMAV8rBGjjjTbYs/ZkfuuT94VQ3b1rI+0rR/+aSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcQjy28L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C27C4CEE2;
	Sat, 26 Apr 2025 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674825;
	bh=a9YheHxg1bV1k91w8fVr/bZrKoFwcOIpG9RZjVvkrz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BcQjy28LSXcL4Q7Bmqje5GO1AGtsKqSv2gl4lumrPJNhK6Mv6Z9Wj8Eo6/KHjjLfr
	 ky7vQJmVAdT3yC0RBIm7fL1+MM6GmTVzpn9imZtGMn3YZE6UNMpQbJ3RDxCqeTdlhG
	 kSpyf317MAUowNgjb4/xX4y9mGUD+pb2RROh01/QgkgAeGFivUB0dDeaDS2SaJgCLN
	 WfWPTshnGHUxHvHgGLb1zeJZ6FLVl3ReuFSlhl4866CNEFqhuphfe/Pas2rBMzSiYw
	 feaYelGO4AgVrCw4tI8YZTL51UZc5aeJAfvqevlB33JCp8yq5JlWR3MiwG6ia3Vdak
	 Gq7o5DnsSb7VQ==
Date: Sat, 26 Apr 2025 14:40:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <20250426144020.2633f9cb@jic23-huawei>
In-Reply-To: <20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
	<20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 21:14:50 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Add a channel for enabling/disabling the step counter, reading the
> number of steps and resetting the counter.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Hi Gustavo,

This is tripping over the somewhat theoretical requirement for
regmap to be provided with DMA safe buffers for bulk accesses.

Jonathan

> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 127 +++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..f09d8dead9df63df5ae8550cf473b5573374955b 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -31,6 +31,8 @@

>  /* See datasheet section 4.6.14, Temperature Sensor */
>  #define BMI270_TEMP_OFFSET				11776
>  #define BMI270_TEMP_SCALE				1953125
> @@ -111,6 +118,7 @@ struct bmi270_data {
>  	struct iio_trigger *trig;
>  	 /* Protect device's private data from concurrent access */
>  	struct mutex mutex;
> +	int steps_enabled;

Seems a little odd to have a thing called _enabled as an integer.
Probably better as a bool even though that will require slightly more
code to handle read / write.


>  
>  	/*
>  	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
> @@ -282,6 +290,99 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
>  	},
>  };
>  
> +enum bmi270_feature_reg_id {
> +	BMI270_SC_26_REG,
> +};
> +
> +struct bmi270_feature_reg {
> +	u8 page;
> +	u8 addr;
> +};
> +
> +static const struct bmi270_feature_reg bmi270_feature_regs[] = {
> +	[BMI270_SC_26_REG] = {
> +		.page = 6,
> +		.addr = 0x32,
> +	},
> +};
> +
> +static int bmi270_write_feature_reg(struct bmi270_data *data,
> +				    enum bmi270_feature_reg_id id,
> +				    u16 val)
> +{
> +	const struct bmi270_feature_reg *reg = &bmi270_feature_regs[id];
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI270_FEAT_PAGE_REG, reg->page);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_bulk_write(data->regmap, reg->addr, &val, sizeof(val));

For a regmap on top of an SPI bus. I think we are still requiring DMA safe
buffers until we can get confirmation that the API guarantees that isn't
needed.  (there is another thread going on where we are trying to get that
confirmation).

That is a pain here because this can run concurrently with buffered
capture and as such I think we can't just put a additional element after
data->data but instead need to mark that new element __aligned(IIO_DMA_MINALIGN)
as well (and add a comment that it can be used concurrently with data->data).

This hole thing is a mess because in reality I think the regmap core is always
bouncing data today. In theory it could sometimes be avoiding copies
and the underlying regmap_spi does require DMA safe buffers. This all relies
on an old discussion where Mark Brown said that we should not assume any
different requirements from the the underlying bus.

> +}
> +
> +static int bmi270_read_feature_reg(struct bmi270_data *data,
> +				   enum bmi270_feature_reg_id id,
> +				   u16 *val)
> +{
> +	const struct bmi270_feature_reg *reg = &bmi270_feature_regs[id];
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI270_FEAT_PAGE_REG, reg->page);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_bulk_read(data->regmap, reg->addr, val, sizeof(*val));
> +}
> +
> +static int bmi270_update_feature_reg(struct bmi270_data *data,
> +				     enum bmi270_feature_reg_id id,
> +				     u16 mask, u16 val)
> +{
> +	u16 reg_val;
> +	int ret;
> +
> +	ret = bmi270_read_feature_reg(data, id, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	set_mask_bits(&reg_val, mask, val);
> +
> +	return bmi270_write_feature_reg(data, id, reg_val);
> +}

> +
> +static int bmi270_read_steps(struct bmi270_data *data, int *val)
> +{
> +	__le16 steps_count;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMI270_SC_OUT_0_REG, &steps_count,
> +			       sizeof(steps_count));
> +	if (ret)
> +		return ret;
> +
> +	*val = sign_extend32(le16_to_cpu(steps_count), 15);
> +	return IIO_VAL_INT;
> +}
> +
>  static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
>  {
>  	int i;
> @@ -551,6 +652,8 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
>  	struct bmi270_data *data = iio_priv(indio_dev);
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		return bmi270_read_steps(data, val);
>  	case IIO_CHAN_INFO_RAW:
>  		if (!iio_device_claim_direct(indio_dev))
>  			return -EBUSY;
> @@ -571,6 +674,10 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = bmi270_get_odr(data, chan->type, val, val2);
>  		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_ENABLE:
> +		scoped_guard(mutex, &data->mutex)
> +			*val = data->steps_enabled;

What race is this protecting against?  Protecting the write is fine because it
is about ensuring we don't race an enable against a clear of the counter.
A race here would I think just give the same as either the race to take the lock
being won by this or not (so not a race as such, just ordering of calls)
So I don't think you need the lock here.

> +		return IIO_VAL_INT;



