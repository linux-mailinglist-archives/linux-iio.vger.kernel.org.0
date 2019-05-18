Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541B622350
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfERKqE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERKqE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 06:46:04 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50EF820872;
        Sat, 18 May 2019 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558176362;
        bh=2nOcZ2ekK31izKp9m1dB+dl+5VXtlyBGPAwWEINySsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ScNNez3lhdXjjI9YjeaK/yk4uzEo4VndC9767eX8L7nl1hqztFrKQ150qlj+lFmW0
         /s8wYDknEG7Sdq7eBOKrAxwLoG+LtP1Qp5wIxZR/6og/Ln8Uo6DjK8lJLY0Py4o0G4
         2MTFfCRBSdKZ3Tq1pmyNTsjnjQALMMZhYFXVwqcE=
Date:   Sat, 18 May 2019 11:45:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v3 3/3] iio: dps310: Add pressure sensing capability
Message-ID: <20190518114558.1e18f2d7@archlinux>
In-Reply-To: <1557945677-12838-4-git-send-email-eajames@linux.ibm.com>
References: <1557945677-12838-1-git-send-email-eajames@linux.ibm.com>
        <1557945677-12838-4-git-send-email-eajames@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 May 2019 13:41:17 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> The DPS310 supports measurement of pressure, so support that in the
> driver. Use background measurement like the temperature sensing and
> default to lowest precision and lowest measurement rate.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
One really minor comment inline.

Otherwise looks good to me. For reference

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/pressure/dps310.c | 360 ++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 334 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index a093e3a..8a96d9d 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -11,11 +11,11 @@
>   *   c0 * 0.5 + c1 * T_raw / kT =C2=B0C
>   *
>   * TODO:
> - *  - Pressure sensor readings
>   *  - Optionally support the FIFO
>   */
> =20
>  #include <linux/i2c.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> =20
> @@ -31,6 +31,8 @@
>  #define DPS310_TMP_B1		0x04
>  #define DPS310_TMP_B2		0x05
>  #define DPS310_PRS_CFG		0x06
> +#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
> +#define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
>  #define DPS310_TMP_CFG		0x07
>  #define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
>  #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
> @@ -83,6 +85,8 @@ struct dps310_data {
>  	struct mutex lock;	/* Lock for sequential HW access functions */
> =20
>  	s32 c0, c1;
> +	s32 c00, c10, c20, c30, c01, c11, c21;
> +	s32 pressure_raw;
>  	s32 temp_raw;
>  };
> =20
> @@ -93,33 +97,79 @@ struct dps310_data {
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  			BIT(IIO_CHAN_INFO_PROCESSED),
>  	},
> +	{
> +		.type =3D IIO_PRESSURE,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
>  };
> =20
>  /* To be called after checking the COEF_RDY bit in MEAS_CFG */
> -static int dps310_get_temp_coef(struct dps310_data *data)
> +static int dps310_get_coefs(struct dps310_data *data)
>  {
>  	int rc;
> -	u8 coef[3];
> +	u8 coef[18];
>  	u32 c0, c1;
> +	u32 c00, c10, c20, c30, c01, c11, c21;
> =20
> -	/*
> -	 * Read temperature calibration coefficients c0 and c1 from the
> -	 * COEF register. The numbers are 12-bit 2's compliment numbers
> -	 */
> +	/* Read all sensor calibration coefficients from the COEF registers. */
>  	rc =3D regmap_bulk_read(data->regmap, DPS310_COEF_BASE, coef,
>  			      sizeof(coef));
>  	if (rc < 0)
>  		return rc;
> =20
> +	/*
> +	 * Calculate temperature calibration coefficients c0 and c1. The
> +	 * numbers are 12-bit 2's complement numbers.
> +	 */
>  	c0 =3D (coef[0] << 4) | (coef[1] >> 4);
>  	data->c0 =3D sign_extend32(c0, 11);
> =20
>  	c1 =3D ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
>  	data->c1 =3D sign_extend32(c1, 11);
> =20
> +	/*
> +	 * Calculate pressure calibration coefficients. c00 and c10 are 20 bit
> +	 * 2's complement numbers, while the rest are 16 bit 2's complement
> +	 * numbers.
> +	 */
> +	c00 =3D (coef[3] << 12) | (coef[4] << 4) | (coef[5] >> 4);
> +	data->c00 =3D sign_extend32(c00, 19);
> +
> +	c10 =3D ((coef[5] & GENMASK(3, 0)) << 16) | (coef[6] << 8) | coef[7];
> +	data->c10 =3D sign_extend32(c10, 19);
> +
> +	c01 =3D (coef[8] << 8) | coef[9];
> +	data->c01 =3D sign_extend32(c01, 15);
> +
> +	c11 =3D (coef[10] << 8) | coef[11];
> +	data->c11 =3D sign_extend32(c11, 15);
> +
> +	c20 =3D (coef[12] << 8) | coef[13];
> +	data->c20 =3D sign_extend32(c20, 15);
> +
> +	c21 =3D (coef[14] << 8) | coef[15];
> +	data->c21 =3D sign_extend32(c21, 15);
> +
> +	c30 =3D (coef[16] << 8) | coef[17];
> +	data->c30 =3D sign_extend32(c30, 15);
> +
>  	return 0;
>  }
> =20
> +static int dps310_get_pres_precision(struct dps310_data *data)
> +{
> +	int rc;
> +	int val;
> +
> +	rc =3D regmap_read(data->regmap, DPS310_PRS_CFG, &val);
> +	if (rc < 0)
> +		return rc;
> +
> +	return BIT(val & GENMASK(2, 0));
> +}
> +
>  static int dps310_get_temp_precision(struct dps310_data *data)
>  {
>  	int rc;
> @@ -137,6 +187,25 @@ static int dps310_get_temp_precision(struct dps310_d=
ata *data)
>  }
> =20
>  /* Called with lock held */
> +static int dps310_set_pres_precision(struct dps310_data *data, int val)
> +{
> +	int rc;
> +	u8 shift_en;
> +
> +	if (val < 0 || val > 128)
> +		return -EINVAL;
> +
> +	shift_en =3D val >=3D 16 ? DPS310_PRS_SHIFT_EN : 0;
> +	rc =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +			       DPS310_PRS_SHIFT_EN, shift_en);
> +	if (rc)
> +		return rc;
> +
> +	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
> +				  DPS310_PRS_PRC_BITS, ilog2(val));
> +}
> +
> +/* Called with lock held */
>  static int dps310_set_temp_precision(struct dps310_data *data, int val)
>  {
>  	int rc;
> @@ -156,6 +225,20 @@ static int dps310_set_temp_precision(struct dps310_d=
ata *data, int val)
>  }
> =20
>  /* Called with lock held */
> +static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
> +{
> +	u8 val;
> +
> +	if (freq < 0 || freq > 128)
> +		return -EINVAL;
> +
> +	val =3D ilog2(freq) << 4;
> +
> +	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
> +				  DPS310_PRS_RATE_BITS, val);
> +}
> +
> +/* Called with lock held */
>  static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
>  {
>  	u8 val;
> @@ -169,6 +252,18 @@ static int dps310_set_temp_samp_freq(struct dps310_d=
ata *data, int freq)
>  				  DPS310_TMP_RATE_BITS, val);
>  }
> =20
> +static int dps310_get_pres_samp_freq(struct dps310_data *data)
> +{
> +	int rc;
> +	int val;
> +
> +	rc =3D regmap_read(data->regmap, DPS310_PRS_CFG, &val);
> +	if (rc < 0)
> +		return rc;
> +
> +	return BIT((val & DPS310_PRS_RATE_BITS) >> 4);
> +}
> +
>  static int dps310_get_temp_samp_freq(struct dps310_data *data)
>  {
>  	int rc;
> @@ -181,6 +276,16 @@ static int dps310_get_temp_samp_freq(struct dps310_d=
ata *data)
>  	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
>  }
> =20
> +static int dps310_get_pres_k(struct dps310_data *data)
> +{
> +	int rc =3D dps310_get_pres_precision(data);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	return scale_factors[ilog2(rc)];
> +}
> +
>  static int dps310_get_temp_k(struct dps310_data *data)
>  {
>  	int rc =3D dps310_get_temp_precision(data);
> @@ -191,7 +296,7 @@ static int dps310_get_temp_k(struct dps310_data *data)
>  	return scale_factors[ilog2(rc)];
>  }
> =20
> -static int dps310_read_temp(struct dps310_data *data)
> +static int dps310_read_pres_raw(struct dps310_data *data)
>  {
>  	int rc;
>  	int rate;
> @@ -203,23 +308,67 @@ static int dps310_read_temp(struct dps310_data *dat=
a)
>  	if (mutex_lock_interruptible(&data->lock))
>  		return -EINTR;
> =20
> -	rate =3D dps310_get_temp_samp_freq(data);
> +	rate =3D dps310_get_pres_samp_freq(data);
>  	timeout =3D DPS310_POLL_TIMEOUT_US(rate);
> =20
>  	/* Poll for sensor readiness; base the timeout upon the sample rate. */
>  	rc =3D regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -				      ready & DPS310_TMP_RDY,
> +				      ready & DPS310_PRS_RDY,
>  				      DPS310_POLL_SLEEP_US(timeout), timeout);
> +	if (rc)
> +		goto done;
> +
> +	rc =3D regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val)=
);
>  	if (rc < 0)
>  		goto done;
> =20
> +	raw =3D (val[0] << 16) | (val[1] << 8) | val[2];
> +	data->pressure_raw =3D sign_extend32(raw, 23);
> +
> +done:
> +	mutex_unlock(&data->lock);
> +	return rc;
> +}
> +
> +/* Called with lock held */
> +static int dps310_read_temp_ready(struct dps310_data *data)
> +{
> +	int rc;
> +	u8 val[3];
> +	s32 raw;
> +
>  	rc =3D regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val)=
);
>  	if (rc < 0)
> -		goto done;
> +		return rc;
> =20
>  	raw =3D (val[0] << 16) | (val[1] << 8) | val[2];
>  	data->temp_raw =3D sign_extend32(raw, 23);
> =20
> +	return 0;
> +}
> +
> +static int dps310_read_temp_raw(struct dps310_data *data)
> +{
> +	int rc;
> +	int rate;
> +	int ready;
> +	int timeout;
> +
> +	if (mutex_lock_interruptible(&data->lock))
> +		return -EINTR;
> +
> +	rate =3D dps310_get_temp_samp_freq(data);
> +	timeout =3D DPS310_POLL_TIMEOUT_US(rate);
> +
> +	/* Poll for sensor readiness; base the timeout upon the sample rate. */
> +	rc =3D regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> +				      ready & DPS310_TMP_RDY,
> +				      DPS310_POLL_SLEEP_US(timeout), timeout);
> +	if (rc < 0)
> +		goto done;
> +
> +	rc =3D dps310_read_temp_ready(data);
> +
>  done:
>  	mutex_unlock(&data->lock);
>  	return rc;
> @@ -267,19 +416,40 @@ static int dps310_write_raw(struct iio_dev *iio,
>  	int rc;
>  	struct dps310_data *data =3D iio_priv(iio);
> =20
> -	if (chan->type !=3D IIO_TEMP)
> -		return -EINVAL;
> -
>  	if (mutex_lock_interruptible(&data->lock))
>  		return -EINTR;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		rc =3D dps310_set_temp_samp_freq(data, val);
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			rc =3D dps310_set_pres_samp_freq(data, val);
> +			break;
> +
> +		case IIO_TEMP:
> +			rc =3D dps310_set_temp_samp_freq(data, val);
> +			break;
> +
> +		default:
> +			rc =3D -EINVAL;
> +			break;
> +		}
>  		break;
> =20
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		rc =3D dps310_set_temp_precision(data, val);
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			rc =3D dps310_set_pres_precision(data, val);
> +			break;
> +
> +		case IIO_TEMP:
> +			rc =3D dps310_set_temp_precision(data, val);
> +			break;
> +
> +		default:
> +			rc =3D -EINVAL;
> +			break;
> +		}
>  		break;
> =20
>  	default:
> @@ -291,6 +461,122 @@ static int dps310_write_raw(struct iio_dev *iio,
>  	return rc;
>  }
> =20
> +static int dps310_calculate_pressure(struct dps310_data *data)
> +{
> +	int i;
> +	int rc;
> +	int t_ready;
> +	int kpi =3D dps310_get_pres_k(data);
> +	int kti =3D dps310_get_temp_k(data);
> +	s64 rem =3D 0ULL;
> +	s64 pressure =3D 0ULL;
> +	s64 p;
> +	s64 t;
> +	s64 denoms[7];
> +	s64 nums[7];
> +	s64 rems[7];
> +	s64 kp;
> +	s64 kt;
> +
> +	if (kpi < 0)
> +		return kpi;
> +
> +	if (kti < 0)
> +		return kti;
> +
> +	kp =3D (s64)kpi;
> +	kt =3D (s64)kti;
> +
> +	/* Refresh temp if it's ready, otherwise just use the latest value */
> +	if (mutex_trylock(&data->lock)) {
> +		rc =3D regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
> +		if (rc >=3D 0 && t_ready & DPS310_TMP_RDY)
> +			dps310_read_temp_ready(data);
> +
> +		mutex_unlock(&data->lock);
> +	}
> +
> +	p =3D (s64)data->pressure_raw;
> +	t =3D (s64)data->temp_raw;
> +
> +	/* Section 4.9.1 of the DPS310 spec; algebra'd to avoid underflow */
> +	nums[0] =3D (s64)data->c00;
> +	denoms[0] =3D 1LL;
> +	nums[1] =3D p * (s64)data->c10;
> +	denoms[1] =3D kp;
> +	nums[2] =3D p * p * (s64)data->c20;
> +	denoms[2] =3D kp * kp;
> +	nums[3] =3D p * p * p * (s64)data->c30;
> +	denoms[3] =3D kp * kp * kp;
> +	nums[4] =3D t * (s64)data->c01;
> +	denoms[4] =3D kt;
> +	nums[5] =3D t * p * (s64)data->c11;
> +	denoms[5] =3D kp * kt;
> +	nums[6] =3D t * p * p * (s64)data->c21;
> +	denoms[6] =3D kp * kp * kt;
> +
> +	/* Kernel lacks a div64_s64_rem function; denoms are all positive */
> +	for (i =3D 0; i < 7; ++i) {
> +		u64 irem;
> +
> +		if (nums[i] < 0LL) {
> +			pressure -=3D div64_u64_rem(-nums[i], denoms[i], &irem);
> +			rems[i] =3D -irem;
> +		} else {
> +			pressure +=3D div64_u64_rem(nums[i], denoms[i], &irem);
> +			rems[i] =3D (s64)irem;
> +		}
> +	}
> +
> +	/* Increase precision and calculate the remainder sum */
> +	for (i =3D 0; i < 7; ++i)
> +		rem +=3D div64_s64((s64)rems[i] * 1000000000LL, denoms[i]);
> +
> +	pressure +=3D div_s64(rem, 1000000000LL);
> +
> +	return (int)pressure;
I have a vague feeling that one of the static checkers will moan about this.
It may be worth an explicit masking or min to ensure that it can tell we
are definitely within range.


> +}
> +
> +static int dps310_read_pressure(struct dps310_data *data, int *val, int =
*val2,
> +				long mask)
> +{
> +	int rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rc =3D dps310_get_pres_samp_freq(data);
> +		if (rc < 0)
> +			return rc;
> +
> +		*val =3D rc;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		rc =3D dps310_read_pres_raw(data);
> +		if (rc)
> +			return rc;
> +
> +		rc =3D dps310_calculate_pressure(data);
> +		if (rc < 0)
> +			return rc;
> +
> +		*val =3D rc;
> +		*val2 =3D 1000; /* Convert Pa to KPa per IIO ABI */
> +		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		rc =3D dps310_get_pres_precision(data);
> +		if (rc < 0)
> +			return rc;
> +
> +		*val =3D rc;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int dps310_calculate_temp(struct dps310_data *data)
>  {
>  	s64 c0;
> @@ -310,11 +596,9 @@ static int dps310_calculate_temp(struct dps310_data =
*data)
>  	return (int)div_s64(t * 1000LL, kt);
>  }
> =20
> -static int dps310_read_raw(struct iio_dev *iio,
> -			   struct iio_chan_spec const *chan,
> -			   int *val, int *val2, long mask)
> +static int dps310_read_temp(struct dps310_data *data, int *val, int *val=
2,
> +			    long mask)
>  {
> -	struct dps310_data *data =3D iio_priv(iio);
>  	int rc;
> =20
>  	switch (mask) {
> @@ -327,7 +611,7 @@ static int dps310_read_raw(struct iio_dev *iio,
>  		return IIO_VAL_INT;
> =20
>  	case IIO_CHAN_INFO_PROCESSED:
> -		rc =3D dps310_read_temp(data);
> +		rc =3D dps310_read_temp_raw(data);
>  		if (rc)
>  			return rc;
> =20
> @@ -351,6 +635,24 @@ static int dps310_read_raw(struct iio_dev *iio,
>  	}
>  }
> =20
> +static int dps310_read_raw(struct iio_dev *iio,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct dps310_data *data =3D iio_priv(iio);
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		return dps310_read_pressure(data, val, val2, mask);
> +
> +	case IIO_TEMP:
> +		return dps310_read_temp(data, val, val2, mask);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static void dps310_reset(void *action_data)
>  {
>  	struct dps310_data *data =3D action_data;
> @@ -444,6 +746,12 @@ static int dps310_probe(struct i2c_client *client,
>  		return rc;
> =20
>  	/*
> +	 * Set up pressure sensor in single sample, one measurement per second
> +	 * mode
> +	 */
> +	rc =3D regmap_write(data->regmap, DPS310_PRS_CFG, 0);
> +
> +	/*
>  	 * Set up external (MEMS) temperature sensor in single sample, one
>  	 * measurement per second mode
>  	 */
> @@ -451,9 +759,9 @@ static int dps310_probe(struct i2c_client *client,
>  	if (rc < 0)
>  		return rc;
> =20
> -	/* Temp shift is disabled when PRC <=3D 8 */
> +	/* Temp and pressure shifts are disabled when PRC <=3D 8 */
>  	rc =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> -			       DPS310_TMP_SHIFT_EN, 0);
> +			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
>  	if (rc < 0)
>  		return rc;
> =20
> @@ -463,9 +771,9 @@ static int dps310_probe(struct i2c_client *client,
>  	if (rc < 0)
>  		return rc;
> =20
> -	/* Turn on temperature measurement in the background */
> +	/* Turn on temperature and pressure measurement in the background */
>  	rc =3D regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> -			       DPS310_MEAS_CTRL_BITS,
> +			       DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
>  			       DPS310_TEMP_EN | DPS310_BACKGROUND);
>  	if (rc < 0)
>  		return rc;
> @@ -479,7 +787,7 @@ static int dps310_probe(struct i2c_client *client,
>  	if (rc < 0)
>  		return rc;
> =20
> -	rc =3D dps310_get_temp_coef(data);
> +	rc =3D dps310_get_coefs(data);
>  	if (rc < 0)
>  		return rc;
> =20

