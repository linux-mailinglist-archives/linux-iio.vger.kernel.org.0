Return-Path: <linux-iio+bounces-11309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625569B173A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E985E28476E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B03F1D2B1A;
	Sat, 26 Oct 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRzKcc6v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB41D1F70;
	Sat, 26 Oct 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729940370; cv=none; b=JpMHRajE3LpkzFAXfAAISRk0s6m5FlSdRusfcq0Kab1DbQkFsBgG0SCg0b0Ybq/kiift4AIw4AlYTqHlFBSyaOpeVuQf68F99uxn8Kqt2Xm52CrzrznIs5SBIO9UppSyOzo4zUHgN3NuBFiqJ9qhImYeJaFT0fafiWE2jhp3tiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729940370; c=relaxed/simple;
	bh=5qN3ocnSS/In5gA+jsyFZ5udS5CVdnNtOtYmm9mrTNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLJGvI62Jc51XSA2qP86uFHyM0QRt5+fckbP9n+E+W+9vqEHpz3fpCQGLBjpJOkr+pO92NMV8k7ycm6YDpZIrFzVzNB+/P2c7U7+D8ITirL+yLfqa6kjj+HGEHC1f3QIqMp9IuC3YOqImCe7jJyvcUSV4adqKFFeo8IBGp4gszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRzKcc6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1033C4CEC6;
	Sat, 26 Oct 2024 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729940370;
	bh=5qN3ocnSS/In5gA+jsyFZ5udS5CVdnNtOtYmm9mrTNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRzKcc6v2ZGmk0V9sShfWgo0pTvcLXIgbDl5e2Dew4+rPkv42zps3eoQW6KRxh3Yl
	 nfLW6VBPnUgkAdb87LZmH8Of2rdR0jnWztkkAEOiEmg7bD5vDX9P+jfvwncA2bQ/mC
	 kykTAt6acsiOzjhWKx+TkJDgil0U82xppz2ISosD2nqXFujqltYlCxzFZ+yIfjjJzP
	 3c2PbOKeB92UFIzaozEYD/D4v1/z68k/KFw0WE9J6tGi98qNh2SoS+rdF2W5wGouhv
	 6Zp14yLAYaf7EZ6rfCy4rmYzxlpavb9i91bSo4TNSo9wSniZZNpC9fPa/mV8PVI9n9
	 W2SSBhYyOJx7Q==
Date: Sat, 26 Oct 2024 11:59:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: veml6070: add support for
 integration time
Message-ID: <20241026115921.72d02a9f@jic23-huawei>
In-Reply-To: <20241024-veml6070-integration-time-v2-2-d53272ec0feb@gmail.com>
References: <20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com>
	<20241024-veml6070-integration-time-v2-2-d53272ec0feb@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:44:49 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The integration time of the veml6070 depends on an external resistor
> (called Rset in the datasheet) and the value configured in the IT
> field of the command register, whose supported values are 1/2x, 1x,
> 2x and 4x.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Javier,

A few comments inline below.

Thanks,

Jonathan
> ---
>  drivers/iio/light/veml6070.c | 137 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 129 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index d11ae00f61f8..d4d024e1b171 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -6,7 +6,7 @@
>   *
>   * IIO driver for VEML6070 (7-bit I2C slave addresses 0x38 and 0x39)
>   *
> - * TODO: integration time, ACK signal
> + * TODO: ACK signal
>   */
>  
>  #include <linux/bitfield.h>
> @@ -29,18 +29,88 @@
>  #define VEML6070_COMMAND_RSRVD	BIT(1) /* reserved, set to 1 */
>  #define VEML6070_COMMAND_SD	BIT(0) /* shutdown mode when set */
>  
> -#define VEML6070_IT_10	0x01 /* integration time 1x */
> +#define VEML6070_IT_05		0x00
> +#define VEML6070_IT_10		0x01
> +#define VEML6070_IT_20		0x02
> +#define VEML6070_IT_40		0x03
> +
> +#define VEML6070_MIN_RSET_KOHM	75
> +#define VEML6070_MIN_IT_US	15625 /* Rset = 75 kohm, IT = 1/2 */
>  
>  struct veml6070_data {
>  	struct i2c_client *client1;
>  	struct i2c_client *client2;
>  	u8 config;
>  	struct mutex lock;
> +	u32 rset;
> +	u32 it[4][2];

int given how it is cast to an int * later. Should be no where near the point
where that makes any functional difference of course.


>  };
>  
> +static void veml6070_calc_it(struct device *dev, struct veml6070_data *data)
> +{
> +	u32 tmp_it;
> +	int i, ret;
> +
> +	ret = device_property_read_u32(dev, "rset-ohms", &data->rset);
> +	if (ret) {
> +		dev_warn(dev, "no Rset specified, using default 270 kohms\n");
> +		data->rset = 270000;
Where the dt-binding defines a default (and that is sensible) don't print
a warning if someone uses it.  Even dev_info is probably too noisy for this.

A simple pattern for default cass is
	data->rset = 270000;
	device_property_read_u32(dev, "rset-ohms", &data->rset);

That is don't check the error return and make sue of the lack of side effects
on the value in &data->rset if there is an error (typically property not found).

> +	}
> +
> +	if (data->rset < 75000) {
> +		dev_warn(dev, "Rset too low, using minimum = 75 kohms\n");
> +		data->rset = 75000;
> +	}
> +
> +	if (data->rset > 1200000) {
> +		dev_warn(dev, "Rset too high, using maximum = 1200 kohms\n");
> +		data->rset = 1200000;
> +	}
> +
> +	/**

Not kernel-doc. So /* only.

> +	 * convert to kohm to avoid overflows and work with the same units as
> +	 * in the datasheet and simplify UVI operations.
> +	 */
> +	data->rset /= 1000;
> +
> +	tmp_it = VEML6070_MIN_IT_US * data->rset / VEML6070_MIN_RSET_KOHM;
> +	for (i = 0; i < ARRAY_SIZE(data->it); i++) {
> +		data->it[i][0] = (tmp_it << i) / 1000000;
> +		data->it[i][1] = (tmp_it << i) % 1000000;
> +	}
> +}
> +
> +static int veml6070_get_it(struct veml6070_data *data, int *val, int *val2)
> +{
> +	int it_idx = FIELD_GET(VEML6070_COMMAND_IT, data->config);
> +
> +	*val = data->it[it_idx][0];
> +	*val2 = data->it[it_idx][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int veml6070_set_it(struct veml6070_data *data, int val, int val2)
> +{
> +	int it_idx;
> +
> +	for (it_idx = 0; it_idx < ARRAY_SIZE(data->it); it_idx++) {
> +		if (data->it[it_idx][0] == val && data->it[it_idx][1] == val2)
> +			break;
> +	}
> +
> +	if (it_idx >= ARRAY_SIZE(data->it))
> +		return -EINVAL;
> +
> +	data->config = (data->config & ~VEML6070_COMMAND_IT) |
> +		FIELD_PREP(VEML6070_COMMAND_IT, it_idx);
> +
> +	return i2c_smbus_write_byte(data->client1, data->config);
> +}
> +
>  static int veml6070_read(struct veml6070_data *data)
>  {
> -	int ret;
> +	int ret, it_ms, val, val2;
>  	u8 msb, lsb;
>  
>  	guard(mutex)(&data->lock);
> @@ -51,7 +121,9 @@ static int veml6070_read(struct veml6070_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	msleep(125 + 10); /* measurement takes up to 125 ms for IT 1x */
> +	veml6070_get_it(data, &val, &val2);
> +	it_ms = val * 1000 + val2 / 1000;

Perhaps some unit.h defines would make this slightly more self documenting.

	int_ms = val * MILLI + val2 / (MICRO / MILLI);

> +	msleep(it_ms + 10);
>  
>  	ret = i2c_smbus_read_byte(data->client2); /* read MSB, address 0x39 */
>  	if (ret < 0)
> @@ -81,26 +153,37 @@ static const struct iio_chan_spec veml6070_channels[] = {
>  		.modified = 1,
>  		.channel2 = IIO_MOD_LIGHT_UV,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
>  	},
>  	{
>  		.type = IIO_UVINDEX,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
>  	}
>  };
>  
> -static int veml6070_to_uv_index(unsigned int val)
> +static int veml6070_to_uv_index(struct veml6070_data *data, unsigned int val)
>  {
>  	/*
>  	 * conversion of raw UV intensity values to UV index depends on
>  	 * integration time (IT) and value of the resistor connected to
> -	 * the RSET pin (default: 270 KOhm)
> +	 * the RSET pin (default: 270 KOhm, IT = 1x)

I'm not sure documenting the default KOhm here is useful as that's
a board wiring thing we don't control. IT isn't that useful documented
here either so I'd just drop the bit in brackets.


>  	 */
>  	unsigned int uvi[11] = {
>  		187, 373, 560, /* low */
>  		746, 933, 1120, /* moderate */
>  		1308, 1494, /* high */
>  		1681, 1868, 2054}; /* very high */
> -	int i;
> +	int i, it_idx;
> +
> +	it_idx = FIELD_GET(VEML6070_COMMAND_IT, data->config);
> +
> +	if (!it_idx)
> +		val = (val * 270  / data->rset) << 1;
> +	else
> +		val = (val * 270 / data->rset) >> (it_idx - 1);
>  
>  	for (i = 0; i < ARRAY_SIZE(uvi); i++)
>  		if (val <= uvi[i])
> @@ -123,10 +206,44 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		if (mask == IIO_CHAN_INFO_PROCESSED)
> -			*val = veml6070_to_uv_index(ret);
> +			*val = veml6070_to_uv_index(data, ret);
>  		else
>  			*val = ret;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return veml6070_get_it(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml6070_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	struct veml6070_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*vals = (int *)data->it;
As above, it data type should just be an int not u32 array.
> +		*length = 2 * ARRAY_SIZE(data->it);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
>

