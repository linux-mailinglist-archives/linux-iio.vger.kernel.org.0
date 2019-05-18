Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97BB22252
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbfERIrq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 04:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfERIrp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 04:47:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDAC220872;
        Sat, 18 May 2019 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558169264;
        bh=xVQ4s+W1pGRI/yxYKXMVWLMNge7XwCa3L+oWi9nJOFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U56U6slCwFHle97J2KcCEMBVp2EuvNwjTujhS5G9Po497VICNcue/PbzfYI6depBk
         qgtJ9wm0KmNLsF4b3aHy43TV3SbcLe7pSukPDnOWSZxUdNo2k30GUThoRDnIzFIZZd
         NRvPV4ymRq+hmIam2hWu7ki5vvD47D1cLgKBBicg=
Date:   Sat, 18 May 2019 09:47:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v2 3/3] iio: dps310: Add pressure sensing capability
Message-ID: <20190518094739.45d3a912@archlinux>
In-Reply-To: <d865007c-2f60-4a04-fd1d-404ee4819f52@linux.vnet.ibm.com>
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
        <1557344128-690-4-git-send-email-eajames@linux.ibm.com>
        <20190511104822.304a1ead@archlinux>
        <d865007c-2f60-4a04-fd1d-404ee4819f52@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 May 2019 15:25:55 -0500
Eddie James <eajames@linux.vnet.ibm.com> wrote:

> On 5/11/19 4:48 AM, Jonathan Cameron wrote:
> > On Wed,  8 May 2019 14:35:28 -0500
> > Eddie James <eajames@linux.ibm.com> wrote:
> > =20
> >> The DPS310 supports measurement of pressure, so support that in the
> >> driver. Use background measurement like the temperature sensing and
> >> default to lowest precision and lowest measurement rate.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com> =20
> > Hi Eddie,
> >
> > A few comments inline.  One is around how you might look at adding
> > fifo support (pushing to an IIO buffer) in the future...  The IIO
> > data model isn't as flexible as this device can be, so we may need
> > to put some restrictions on combinations of options.
> >
> > Jonathan =20
> >> ---
> >>   drivers/iio/pressure/dps310.c | 331 ++++++++++++++++++++++++++++++++=
+++++++---
> >>   1 file changed, 307 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps3=
10.c
> >> index c42808e..a7ee28c 100644
> >> --- a/drivers/iio/pressure/dps310.c
> >> +++ b/drivers/iio/pressure/dps310.c
> >> @@ -11,11 +11,11 @@
> >>    *   c0 * 0.5 + c1 * T_raw / kT =C2=B0C
> >>    *
> >>    * TODO:
> >> - *  - Pressure sensor readings
> >>    *  - Optionally support the FIFO
> >>    */
> >>  =20
> >>   #include <linux/i2c.h>
> >> +#include <linux/math64.h>
> >>   #include <linux/module.h>
> >>   #include <linux/regmap.h>
> >>  =20
> >> @@ -29,6 +29,8 @@
> >>   #define DPS310_TMP_B1		0x04
> >>   #define DPS310_TMP_B2		0x05
> >>   #define DPS310_PRS_CFG		0x06
> >> +#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
> >> +#define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
> >>   #define DPS310_TMP_CFG		0x07
> >>   #define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
> >>   #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
> >> @@ -82,6 +84,8 @@ struct dps310_data {
> >>   	struct regmap *regmap;
> >>    =20
>=20
> >> +
> >>   static bool dps310_is_writeable_reg(struct device *dev, unsigned int=
 reg)
> >>   {
> >>   	switch (reg) {
> >> @@ -253,24 +387,141 @@ static int dps310_write_raw(struct iio_dev *iio,
> >>   {
> >>   	struct dps310_data *data =3D iio_priv(iio);
> >>  =20
> >> -	if (chan->type !=3D IIO_TEMP)
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		switch (chan->type) {
> >> +		case IIO_PRESSURE:
> >> +			return dps310_set_pres_samp_freq(data, val);
> >> +
> >> +		case IIO_TEMP:
> >> +			return dps310_set_temp_samp_freq(data, val); =20
> > This may need a bit of thought if there is any chance we will later sup=
port
> > the fifo.
> >
> > The IIO model is that of scans that read all channels at each 'trigger'=
. In
> > devices like this which allow for different sampling rates for differen=
t sensor
> > channels there are two options.
> >
> > 1) Don't support it.
> > 2) Deal with registering two separate IIO devices and do the demux in t=
he
> > driver to the relevant one.
> >
> > All depends on whether there is a substantial usecase for different sam=
pling
> > rates or not.  Here I suspect the answer is not.
> >
> > The complexity is that, you then need to work out how to 'upgrade' the
> > interface when buffered support is added. Obvious options are:
> >
> > 1) Refuse to move to buffered mode if the sampling frequencies are diff=
erent.
> > 2) Force the slower channel to be sampled faster if that is possible.
> > 3) Change to only having one exposed sampling frequency at all - the pr=
oblem
> > with this last one is that it changes the ABI for existing users.
> >
> > It may be no one ever cares about the fifo mode though as high speed pr=
essure
> > measurement is 'unusual' ;) =20
>=20
>=20
> Thanks for the comments Jonathan. I will follow your suggestions=20
> throughout the driver.
>=20
> The sampling rates are a bit confusing for me, and I haven't looked into=
=20
> the buffered mode at all. Are you saying that in the current form, it=20
> won't work to use different sampling frequencies for the two sensors=20
> (without buffered mode I mean)? I haven't noticed any problems in my=20
> tests. I'm inclined force the slower channel to be sampled faster if=20
> necessary when buffered mode is implemented.
That would be a 'slightly' interesting interpretation of the ABI, but
I'd 'probably' let it go as any correct userspace should be fine
receiving data at a higher rate than it asked for.

Jonathan
>=20
> Thanks,
>=20
> Eddie
>=20
>=20
> > =20
> >> +
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >> +		switch (chan->type) {
> >> +		case IIO_PRESSURE:
> >> +			return dps310_set_pres_precision(data, val);
> >> +
> >> +		case IIO_TEMP:
> >> +			return dps310_set_temp_precision(data, val);
> >> +
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +	default:
> >>   		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >> +static int dps310_calculate_pressure(struct dps310_data *data)
> >> +{
> >> +	int i, r, t_ready;
> >> +	int kpi =3D dps310_get_pres_k(data);
> >> +	int kti =3D dps310_get_temp_k(data);
> >> +	s64 rem =3D 0ULL;
> >> +	s64 pressure =3D 0ULL;
> >> +	s64 p;
> >> +	s64 t;
> >> +	s64 denoms[7];
> >> +	s64 nums[7];
> >> +	s64 rems[7];
> >> +	s64 kp;
> >> +	s64 kt;
> >> +
> >> +	if (kpi < 0)
> >> +		return kpi;
> >> +
> >> +	if (kti < 0)
> >> +		return kti;
> >> +
> >> +	kp =3D (s64)kpi;
> >> +	kt =3D (s64)kti;
> >> +
> >> +	/* Refresh temp if it's ready, otherwise just use the latest value */
> >> +	r =3D regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
> >> +	if (r >=3D 0 && t_ready & DPS310_TMP_RDY)
> >> +		dps310_read_temp_ready(data);
> >> +
> >> +	p =3D (s64)data->pressure_raw;
> >> +	t =3D (s64)data->temp_raw;
> >> +
> >> +	/* Section 4.9.1 of the DPS310 spec; algebra'd to avoid underflow */
> >> +	nums[0] =3D (s64)data->c00;
> >> +	denoms[0] =3D 1LL;
> >> +	nums[1] =3D p * (s64)data->c10;
> >> +	denoms[1] =3D kp;
> >> +	nums[2] =3D p * p * (s64)data->c20;
> >> +	denoms[2] =3D kp * kp;
> >> +	nums[3] =3D p * p * p * (s64)data->c30;
> >> +	denoms[3] =3D kp * kp * kp;
> >> +	nums[4] =3D t * (s64)data->c01;
> >> +	denoms[4] =3D kt;
> >> +	nums[5] =3D t * p * (s64)data->c11;
> >> +	denoms[5] =3D kp * kt;
> >> +	nums[6] =3D t * p * p * (s64)data->c21;
> >> +	denoms[6] =3D kp * kp * kt;
> >> +
> >> +	/* Kernel lacks a div64_s64_rem function; denoms are all positive */
> >> +	for (i =3D 0; i < 7; ++i) {
> >> +		u64 rem;
> >> +
> >> +		if (nums[i] < 0LL) {
> >> +			pressure -=3D div64_u64_rem(-nums[i], denoms[i], &rem);
> >> +			rems[i] =3D -rem;
> >> +		} else {
> >> +			pressure +=3D div64_u64_rem(nums[i], denoms[i], &rem);
> >> +			rems[i] =3D (s64)rem;
> >> +		}
> >> +	}
> >> +
> >> +	/* Increase precision and calculate the remainder sum */
> >> +	for (i =3D 0; i < 7; ++i)
> >> +		rem +=3D div64_s64((s64)rems[i] * 1000000000LL, denoms[i]);
> >> +
> >> +	pressure +=3D div_s64(rem, 1000000000LL);
> >> +
> >> +	return (int)pressure;
> >> +}
> >> +
> >> +static int dps310_read_pressure(struct dps310_data *data, int *val, i=
nt *val2,
> >> +				long mask)
> >> +{
> >> +	int ret;
> >>  =20
> >>   	switch (mask) {
> >>   	case IIO_CHAN_INFO_SAMP_FREQ:
> >> -		return dps310_set_temp_samp_freq(data, val);
> >> +		*val =3D dps310_get_pres_samp_freq(data);
> >> +		return IIO_VAL_INT;
> >> +
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		ret =3D dps310_read_pres_raw(data);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		*val =3D dps310_calculate_pressure(data); =20
> > This is rather far from raw :)  It might be better at this point to just
> > go for PROCESSED and apply the scale in here.
> > =20
> >> +		return IIO_VAL_INT;
> >> +
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		*val =3D 1;
> >> +		*val2 =3D 1000; /* Convert Pa to KPa per IIO ABI */
> >> +		return IIO_VAL_FRACTIONAL;
> >> +
> >>   	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >> -		return dps310_set_temp_precision(data, val);
> >> +		*val =3D dps310_get_pres_precision(data);
> >> +		return IIO_VAL_INT;
> >> +
> >>   	default:
> >>   		return -EINVAL;
> >>   	}
> >>   }
> >>  =20
> >> -static int dps310_read_raw(struct iio_dev *iio,
> >> -			   struct iio_chan_spec const *chan,
> >> -			   int *val, int *val2, long mask)
> >> +static int dps310_read_temp(struct dps310_data *data, int *val, int *=
val2,
> >> +			    long mask)
> >>   {
> >> -	struct dps310_data *data =3D iio_priv(iio);
> >>   	int ret;
> >>  =20
> >>   	switch (mask) {
> >> @@ -279,7 +530,7 @@ static int dps310_read_raw(struct iio_dev *iio,
> >>   		return IIO_VAL_INT;
> >>  =20
> >>   	case IIO_CHAN_INFO_RAW:
> >> -		ret =3D dps310_read_temp(data);
> >> +		ret =3D dps310_read_temp_raw(data);
> >>   		if (ret)
> >>   			return ret;
> >>  =20
> >> @@ -312,6 +563,24 @@ static int dps310_read_raw(struct iio_dev *iio,
> >>   	}
> >>   }
> >>  =20
> >> +static int dps310_read_raw(struct iio_dev *iio,
> >> +			   struct iio_chan_spec const *chan,
> >> +			   int *val, int *val2, long mask)
> >> +{
> >> +	struct dps310_data *data =3D iio_priv(iio);
> >> +
> >> +	switch (chan->type) {
> >> +	case IIO_PRESSURE:
> >> +		return dps310_read_pressure(data, val, val2, mask);
> >> +
> >> +	case IIO_TEMP:
> >> +		return dps310_read_temp(data, val, val2, mask);
> >> +
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >>   static const struct regmap_config dps310_regmap_config =3D {
> >>   	.reg_bits =3D 8,
> >>   	.val_bits =3D 8,
> >> @@ -393,6 +662,13 @@ static int dps310_probe(struct i2c_client *client,
> >>   		return PTR_ERR(data->regmap);
> >>  =20
> >>   	/*
> >> +	 * Set up pressure sensor in single sample, one measurement per seco=
nd
> >> +	 * mode
> >> +	 */
> >> +	r =3D regmap_write(data->regmap, DPS310_PRS_CFG,
> >> +			 DPS310_CALC_RATE(1) | DPS310_CALC_PRC(1));
> >> +
> >> +	/*
> >>   	 * Set up external (MEMS) temperature sensor in single sample, one
> >>   	 * measurement per second mode
> >>   	 */
> >> @@ -402,16 +678,23 @@ static int dps310_probe(struct i2c_client *clien=
t,
> >>   	if (r < 0)
> >>   		goto err;
> >>  =20
> >> -	/* Temp shift is disabled when PRC <=3D 8 */
> >> +	/* Temp and pressure shifts are disabled when PRC <=3D 8 */
> >>   	r =3D regmap_write_bits(data->regmap, DPS310_CFG_REG,
> >> -			      DPS310_TMP_SHIFT_EN, 0);
> >> +			      DPS310_TMP_SHIFT_EN | DPS310_PRS_SHIFT_EN, 0);
> >> +	if (r < 0)
> >> +		goto err;
> >> +
> >> +	/* MEAS_CFG doesn't seem to update unless first written with 0 */
> >> +	r =3D regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> >> +			      DPS310_MEAS_CTRL_BITS, 0);
> >>   	if (r < 0)
> >>   		goto err;
> >>  =20
> >> -	/* Turn on temperature measurement in the background */
> >> +	/* Turn on temperature and pressure measurement in the background */
> >>   	r =3D regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> >>   			      DPS310_MEAS_CTRL_BITS,
> >> -			      DPS310_TEMP_EN | DPS310_BACKGROUND);
> >> +			      DPS310_PRS_EN | DPS310_TEMP_EN |
> >> +			      DPS310_BACKGROUND);
> >>   	if (r < 0)
> >>   		goto err;
> >>  =20
> >> @@ -424,7 +707,7 @@ static int dps310_probe(struct i2c_client *client,
> >>   	if (r < 0)
> >>   		goto err;
> >>  =20
> >> -	r =3D dps310_get_temp_coef(data);
> >> +	r =3D dps310_get_coefs(data);
> >>   	if (r < 0)
> >>   		goto err;
> >>    =20
>=20

