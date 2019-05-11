Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D521A74C
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfEKJs3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 05:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfEKJs3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 05:48:29 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0EC2173B;
        Sat, 11 May 2019 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557568107;
        bh=EMtgBhJcZDesQ6ffof05Tp2or4zn//1RaNLqNKoiK6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZrenXPBn3BQ3w+wG9a+5ccqja6P3fas9tFfgMzQQRw1HU0ZLOn02CiH7mE8KFxSUe
         C4OIIA1eOgF++a8N15XfQPueQqTzlfskXlQtb01TR+p4FbznA41nj2bpst1qkHMxkI
         vl1iDxxLzjy8usHv3JfQgH6t7XWYpGtd2WkWCY0M=
Date:   Sat, 11 May 2019 10:48:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v2 3/3] iio: dps310: Add pressure sensing capability
Message-ID: <20190511104822.304a1ead@archlinux>
In-Reply-To: <1557344128-690-4-git-send-email-eajames@linux.ibm.com>
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
        <1557344128-690-4-git-send-email-eajames@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  8 May 2019 14:35:28 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> The DPS310 supports measurement of pressure, so support that in the
> driver. Use background measurement like the temperature sensing and
> default to lowest precision and lowest measurement rate.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
Hi Eddie,

A few comments inline.  One is around how you might look at adding
fifo support (pushing to an IIO buffer) in the future...  The IIO=20
data model isn't as flexible as this device can be, so we may need
to put some restrictions on combinations of options.

Jonathan
> ---
>  drivers/iio/pressure/dps310.c | 331 ++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 307 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index c42808e..a7ee28c 100644
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
> @@ -29,6 +29,8 @@
>  #define DPS310_TMP_B1		0x04
>  #define DPS310_TMP_B2		0x05
>  #define DPS310_PRS_CFG		0x06
> +#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
> +#define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
>  #define DPS310_TMP_CFG		0x07
>  #define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
>  #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
> @@ -82,6 +84,8 @@ struct dps310_data {
>  	struct regmap *regmap;
> =20
>  	s32 c0, c1;
> +	s32 c00, c10, c20, c30, c01, c11, c21;
> +	s32 pressure_raw;
>  	s32 temp_raw;
>  };
> =20
> @@ -94,33 +98,79 @@ struct dps310_data {
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  			BIT(IIO_CHAN_INFO_RAW),
>  	},
> +	{
> +		.type =3D IIO_PRESSURE,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_RAW),
> +	},
>  };
> =20
>  /* To be called after checking the COEF_RDY bit in MEAS_CFG */
> -static int dps310_get_temp_coef(struct dps310_data *data)
> +static int dps310_get_coefs(struct dps310_data *data)
>  {
>  	struct regmap *regmap =3D data->regmap;
> -	u8 coef[3];
>  	int r;
> +	u8 coef[18];
>  	u32 c0, c1;
> +	u32 c00, c10, c20, c30, c01, c11, c21;
> =20
> -	/*
> -	 * Read temperature calibration coefficients c0 and c1 from the
> -	 * COEF register. The numbers are 12-bit 2's compliment numbers
> -	 */
> +	/* Read all sensor calibration coefficients from the COEF registers. */
>  	r =3D regmap_bulk_read(regmap, DPS310_COEF_BASE, coef, sizeof(coef));
>  	if (r < 0)
>  		return r;
> =20
> +	/*
> +	 * Calculate temperature calibration coefficients c0 and c1. The numbers
> +	 * are 12-bit 2's complement numbers.
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
> +	int val, r;
> +
> +	r =3D regmap_read(data->regmap, DPS310_PRS_CFG, &val);
> +	if (r < 0)
> +		return r;
> +
> +	return BIT(val & GENMASK(2, 0));
> +}
> +
>  static int dps310_get_temp_precision(struct dps310_data *data)
>  {
>  	int val, r;
> @@ -136,6 +186,24 @@ static int dps310_get_temp_precision(struct dps310_d=
ata *data)
>  	return BIT(val & GENMASK(2, 0));
>  }
> =20
> +static int dps310_set_pres_precision(struct dps310_data *data, int val)
> +{
> +	int ret;
> +	u8 shift_en;
> +
> +	if (val < 0 || val > 128)
> +		return -EINVAL;
> +
> +	shift_en =3D val >=3D 16 ? DPS310_PRS_SHIFT_EN : 0;
> +	ret =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +				DPS310_PRS_SHIFT_EN, shift_en);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
> +				  DPS310_PRS_PRC_BITS, DPS310_CALC_PRC(val));
> +}
> +
>  static int dps310_set_temp_precision(struct dps310_data *data, int val)
>  {
>  	int ret;
> @@ -154,6 +222,19 @@ static int dps310_set_temp_precision(struct dps310_d=
ata *data, int val)
>  				  DPS310_TMP_PRC_BITS, DPS310_CALC_PRC(val));
>  }
> =20
> +static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
> +{
> +	u8 val;
> +
> +	if (freq < 0 || freq > 128)
> +		return -EINVAL;
> +
> +	val =3D DPS310_CALC_RATE(freq) << 4;
> +
> +	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
> +				  DPS310_PRS_RATE_BITS, val);
> +}
> +
>  static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
>  {
>  	u8 val;
> @@ -167,6 +248,17 @@ static int dps310_set_temp_samp_freq(struct dps310_d=
ata *data, int freq)
>  				  DPS310_TMP_RATE_BITS, val);
>  }
> =20
> +static int dps310_get_pres_samp_freq(struct dps310_data *data)
> +{
> +	int val, r;
> +
> +	r =3D regmap_read(data->regmap, DPS310_PRS_CFG, &val);
> +	if (r < 0)
> +		return r;
> +
> +	return BIT((val & DPS310_PRS_RATE_BITS) >> 4);
> +}
> +
>  static int dps310_get_temp_samp_freq(struct dps310_data *data)
>  {
>  	int val, r;
> @@ -178,6 +270,16 @@ static int dps310_get_temp_samp_freq(struct dps310_d=
ata *data)
>  	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
>  }
> =20
> +static int dps310_get_pres_k(struct dps310_data *data)
> +{
> +	int r =3D dps310_get_pres_precision(data);
> +
> +	if (r < 0)
> +		return r;
> +
> +	return scale_factors[DPS310_CALC_PRC(r)];
> +}
> +
>  static int dps310_get_temp_k(struct dps310_data *data)
>  {
>  	int r =3D dps310_get_temp_precision(data);
> @@ -188,21 +290,37 @@ static int dps310_get_temp_k(struct dps310_data *da=
ta)
>  	return scale_factors[DPS310_CALC_PRC(r)];
>  }
> =20
> -static int dps310_read_temp(struct dps310_data *data)
> +static int dps310_read_pres_raw(struct dps310_data *data)
>  {
> +	int r, ready;
>  	u8 val[3];
>  	s32 raw;
> -	int r, ready;
> -	int rate =3D dps310_get_temp_samp_freq(data);
> +	int rate =3D dps310_get_pres_samp_freq(data);
>  	int timeout =3D DPS310_POLL_TIMEOUT_US(rate);
> =20
>  	/* Poll for sensor readiness; base the timeout upon the sample rate. */
>  	r =3D regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -				     ready & DPS310_TMP_RDY,
> +				     ready & DPS310_PRS_RDY,
>  				     DPS310_POLL_SLEEP_US(timeout), timeout);
> +	if (r)
> +		return r;
> +
> +	r =3D regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
>  	if (r < 0)
>  		return r;
> =20
> +	raw =3D (val[0] << 16) | (val[1] << 8) | val[2];
> +	data->pressure_raw =3D sign_extend32(raw, 23);
> +
> +	return 0;
> +}
> +
> +static int dps310_read_temp_ready(struct dps310_data *data)
> +{
> +	int r;
> +	u8 val[3];
> +	s32 raw;
> +
>  	r =3D regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val));
>  	if (r < 0)
>  		return r;
> @@ -213,6 +331,22 @@ static int dps310_read_temp(struct dps310_data *data)
>  	return 0;
>  }
> =20
> +static int dps310_read_temp_raw(struct dps310_data *data)
> +{
> +	int r, ready;
> +	int rate =3D dps310_get_temp_samp_freq(data);
> +	int timeout =3D DPS310_POLL_TIMEOUT_US(rate);
> +
> +	/* Poll for sensor readiness; base the timeout upon the sample rate. */
> +	r =3D regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> +				     ready & DPS310_TMP_RDY,
> +				     DPS310_POLL_SLEEP_US(timeout), timeout);
> +	if (r < 0)
> +		return r;
> +
> +	return dps310_read_temp_ready(data);
> +}
> +
>  static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> @@ -253,24 +387,141 @@ static int dps310_write_raw(struct iio_dev *iio,
>  {
>  	struct dps310_data *data =3D iio_priv(iio);
> =20
> -	if (chan->type !=3D IIO_TEMP)
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			return dps310_set_pres_samp_freq(data, val);
> +
> +		case IIO_TEMP:
> +			return dps310_set_temp_samp_freq(data, val);

This may need a bit of thought if there is any chance we will later support
the fifo.

The IIO model is that of scans that read all channels at each 'trigger'. In
devices like this which allow for different sampling rates for different se=
nsor
channels there are two options.

1) Don't support it.
2) Deal with registering two separate IIO devices and do the demux in the
driver to the relevant one.

All depends on whether there is a substantial usecase for different sampling
rates or not.  Here I suspect the answer is not.

The complexity is that, you then need to work out how to 'upgrade' the
interface when buffered support is added. Obvious options are:

1) Refuse to move to buffered mode if the sampling frequencies are differen=
t.
2) Force the slower channel to be sampled faster if that is possible.
3) Change to only having one exposed sampling frequency at all - the problem
with this last one is that it changes the ABI for existing users.

It may be no one ever cares about the fifo mode though as high speed pressu=
re
measurement is 'unusual' ;)

> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			return dps310_set_pres_precision(data, val);
> +
> +		case IIO_TEMP:
> +			return dps310_set_temp_precision(data, val);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
>  		return -EINVAL;
> +	}
> +}
> +
> +static int dps310_calculate_pressure(struct dps310_data *data)
> +{
> +	int i, r, t_ready;
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
> +	r =3D regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
> +	if (r >=3D 0 && t_ready & DPS310_TMP_RDY)
> +		dps310_read_temp_ready(data);
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
> +		u64 rem;
> +
> +		if (nums[i] < 0LL) {
> +			pressure -=3D div64_u64_rem(-nums[i], denoms[i], &rem);
> +			rems[i] =3D -rem;
> +		} else {
> +			pressure +=3D div64_u64_rem(nums[i], denoms[i], &rem);
> +			rems[i] =3D (s64)rem;
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
> +}
> +
> +static int dps310_read_pressure(struct dps310_data *data, int *val, int =
*val2,
> +				long mask)
> +{
> +	int ret;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return dps310_set_temp_samp_freq(data, val);
> +		*val =3D dps310_get_pres_samp_freq(data);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D dps310_read_pres_raw(data);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D dps310_calculate_pressure(data);
This is rather far from raw :)  It might be better at this point to just
go for PROCESSED and apply the scale in here.

> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 1;
> +		*val2 =3D 1000; /* Convert Pa to KPa per IIO ABI */
> +		return IIO_VAL_FRACTIONAL;
> +
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		return dps310_set_temp_precision(data, val);
> +		*val =3D dps310_get_pres_precision(data);
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
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
>  	int ret;
> =20
>  	switch (mask) {
> @@ -279,7 +530,7 @@ static int dps310_read_raw(struct iio_dev *iio,
>  		return IIO_VAL_INT;
> =20
>  	case IIO_CHAN_INFO_RAW:
> -		ret =3D dps310_read_temp(data);
> +		ret =3D dps310_read_temp_raw(data);
>  		if (ret)
>  			return ret;
> =20
> @@ -312,6 +563,24 @@ static int dps310_read_raw(struct iio_dev *iio,
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
>  static const struct regmap_config dps310_regmap_config =3D {
>  	.reg_bits =3D 8,
>  	.val_bits =3D 8,
> @@ -393,6 +662,13 @@ static int dps310_probe(struct i2c_client *client,
>  		return PTR_ERR(data->regmap);
> =20
>  	/*
> +	 * Set up pressure sensor in single sample, one measurement per second
> +	 * mode
> +	 */
> +	r =3D regmap_write(data->regmap, DPS310_PRS_CFG,
> +			 DPS310_CALC_RATE(1) | DPS310_CALC_PRC(1));
> +
> +	/*
>  	 * Set up external (MEMS) temperature sensor in single sample, one
>  	 * measurement per second mode
>  	 */
> @@ -402,16 +678,23 @@ static int dps310_probe(struct i2c_client *client,
>  	if (r < 0)
>  		goto err;
> =20
> -	/* Temp shift is disabled when PRC <=3D 8 */
> +	/* Temp and pressure shifts are disabled when PRC <=3D 8 */
>  	r =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> -			      DPS310_TMP_SHIFT_EN, 0);
> +			      DPS310_TMP_SHIFT_EN | DPS310_PRS_SHIFT_EN, 0);
> +	if (r < 0)
> +		goto err;
> +
> +	/* MEAS_CFG doesn't seem to update unless first written with 0 */
> +	r =3D regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +			      DPS310_MEAS_CTRL_BITS, 0);
>  	if (r < 0)
>  		goto err;
> =20
> -	/* Turn on temperature measurement in the background */
> +	/* Turn on temperature and pressure measurement in the background */
>  	r =3D regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>  			      DPS310_MEAS_CTRL_BITS,
> -			      DPS310_TEMP_EN | DPS310_BACKGROUND);
> +			      DPS310_PRS_EN | DPS310_TEMP_EN |
> +			      DPS310_BACKGROUND);
>  	if (r < 0)
>  		goto err;
> =20
> @@ -424,7 +707,7 @@ static int dps310_probe(struct i2c_client *client,
>  	if (r < 0)
>  		goto err;
> =20
> -	r =3D dps310_get_temp_coef(data);
> +	r =3D dps310_get_coefs(data);
>  	if (r < 0)
>  		goto err;
> =20

