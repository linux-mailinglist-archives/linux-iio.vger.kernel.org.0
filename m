Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46FD5009
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfJLNUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbfJLNUK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:20:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089A321850;
        Sat, 12 Oct 2019 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570886409;
        bh=qLiGTXixko5CMA2LjChwy7duQbXkGNkxSVarDaXHLvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MapyDucHCMu+FDt4rO0BlTtCTio4/lDozdCgNF5BK2TaVfj+Sv5u/oCVTKXO+1yXI
         rFsWAkdDEQzRnl8P+xJKJaUdvLbenSjE56rryL8i4RF9g+OijFIAVzHDLwjsYmq/eC
         dHWESFcWhPk5vkS9KeJpdMzc6Koh4je3GFrasqXw=
Date:   Sat, 12 Oct 2019 14:20:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Mario Tesi <mario.tesi@st.com>, lorenzo.bianconi83@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: add odr calibration feature
Message-ID: <20191012142004.42cb7ce4@archlinux>
In-Reply-To: <20191007140727.GE3192@localhost.localdomain>
References: <1570456586-16696-1-git-send-email-mario.tesi@st.com>
        <20191007140727.GE3192@localhost.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 16:07:27 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > 	On LSM6DSO/LSM6DSR/LSM6DSOX/ASM330LHH and ISH330DHCX
> > 	devices it is possible to trim the hardware timestamp
> > 	resolution through the FREQ_FINE[7:0] bits of the
> > 	INTERNAL_FREQ_FINE register, which contains the difference
> > 	in percentage of the effective ODR (and timestamp rate)
> > 	with respect to the typical value.
> >=20
> > 	The formula for calculating the effective ODR reported
> > 	in the application notes has been linearized to the first
> > 	order to simplify the calculation (pls. see note on source
> > 	code).
> >=20
> > 	This change may be useful in the outcome of CTS
> > 	tests regarding the SingleSensorTests and the
> > 	SensorTest#testSensorTimeStamps for high ODRs
> >=20
> > Signed-off-by: Mario Tesi <mario.tesi@st.com> =20
>=20
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Hi.

The leading tabs on the commit message are a bit unusual,
but as far as I can tell the code is good.

Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  4 ++++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  5 ++---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 23 ++++++++++++++++++=
+++++
> >  3 files changed, 29 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 7485423..9a40587 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -153,12 +153,14 @@ struct st_lsm6dsx_fifo_ops {
> >   * @hr_timer: Hw timer resolution register info (addr + mask).
> >   * @fifo_en: Hw timer FIFO enable register info (addr + mask).
> >   * @decimator: Hw timer FIFO decimator register info (addr + mask).
> > + * @freq_fine: Difference in % of ODR with respect to the typical.
> >   */
> >  struct st_lsm6dsx_hw_ts_settings {
> >  	struct st_lsm6dsx_reg timer_en;
> >  	struct st_lsm6dsx_reg hr_timer;
> >  	struct st_lsm6dsx_reg fifo_en;
> >  	struct st_lsm6dsx_reg decimator;
> > +	u8 freq_fine;
> >  };
> > =20
> >  /**
> > @@ -344,6 +346,7 @@ struct st_lsm6dsx_sensor {
> >   * @fifo_mode: FIFO operating mode supported by the device.
> >   * @suspend_mask: Suspended sensor bitmask.
> >   * @enable_mask: Enabled sensor bitmask.
> > + * @ts_gain: Hw timestamp rate after internal calibration.
> >   * @ts_sip: Total number of timestamp samples in a given pattern.
> >   * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
> >   * @buff: Device read buffer.
> > @@ -365,6 +368,7 @@ struct st_lsm6dsx_hw {
> >  	enum st_lsm6dsx_fifo_mode fifo_mode;
> >  	u8 suspend_mask;
> >  	u8 enable_mask;
> > +	s64 ts_gain;
> >  	u8 ts_sip;
> >  	u8 sip;
> > =20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index cabd4bf..d7cacb9 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -50,7 +50,6 @@
> > =20
> >  #define ST_LSM6DSX_MAX_FIFO_ODR_VAL		0x08
> > =20
> > -#define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
> >  #define ST_LSM6DSX_TS_RESET_VAL			0xaa
> > =20
> >  struct st_lsm6dsx_decimator_entry {
> > @@ -423,7 +422,7 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  				 */
> >  				if (!reset_ts && ts >=3D 0xff0000)
> >  					reset_ts =3D true;
> > -				ts *=3D ST_LSM6DSX_TS_SENSITIVITY;
> > +				ts *=3D hw->ts_gain;
> > =20
> >  				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
> >  			}
> > @@ -566,7 +565,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_h=
w *hw)
> >  				 */
> >  				if (!reset_ts && ts >=3D 0xffff0000)
> >  					reset_ts =3D true;
> > -				ts *=3D ST_LSM6DSX_TS_SENSITIVITY;
> > +				ts *=3D hw->ts_gain;
> >  			} else {
> >  				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
> >  							    ts);
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index bacc908..2b54ce1 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -63,6 +63,8 @@
> > =20
> >  #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
> > =20
> > +#define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
> > +
> >  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
> >  	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> >  	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> > @@ -832,6 +834,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  				.addr =3D 0x0a,
> >  				.mask =3D GENMASK(7, 6),
> >  			},
> > +			.freq_fine =3D 0x63,
> >  		},
> >  		.shub_settings =3D {
> >  			.page_mux =3D {
> > @@ -1020,6 +1023,7 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  				.addr =3D 0x0a,
> >  				.mask =3D GENMASK(7, 6),
> >  			},
> > +			.freq_fine =3D 0x63,
> >  		},
> >  		.event_settings =3D {
> >  			.enable_reg =3D {
> > @@ -1185,6 +1189,7 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  				.addr =3D 0x0a,
> >  				.mask =3D GENMASK(7, 6),
> >  			},
> > +			.freq_fine =3D 0x63,
> >  		},
> >  		.shub_settings =3D {
> >  			.page_mux =3D {
> > @@ -1874,6 +1879,24 @@ static int st_lsm6dsx_init_hw_timer(struct st_ls=
m6dsx_hw *hw)
> >  		if (err < 0)
> >  			return err;
> >  	}
> > +
> > +	/* calibrate timestamp sensitivity */
> > +	hw->ts_gain =3D ST_LSM6DSX_TS_SENSITIVITY;
> > +	if (ts_settings->freq_fine) {
> > +		err =3D regmap_read(hw->regmap, ts_settings->freq_fine, &val);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		/*
> > +		 * linearize the AN5192 formula:
> > +		 * 1 / (1 + x) ~=3D 1 - x (Taylor=E2=80=99s Series)
> > +		 * ttrim[s] =3D 1 / (40000 * (1 + 0.0015 * val))
> > +		 * ttrim[ns] ~=3D 25000 - 37.5 * val
> > +		 * ttrim[ns] ~=3D 25000 - (37500 * val) / 1000
> > +		 */
> > +		hw->ts_gain -=3D ((s8)val * 37500) / 1000;
> > +	}
> > +
> >  	return 0;
> >  }
> > =20
> > --=20
> > 2.7.4
> >  =20

