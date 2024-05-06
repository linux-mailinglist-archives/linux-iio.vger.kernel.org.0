Return-Path: <linux-iio+bounces-4835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8F8BCE26
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17320B2737B
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02777F2C;
	Mon,  6 May 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3x2GVa9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1106CDA5;
	Mon,  6 May 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999147; cv=none; b=YNOfWE13XLhYQyVHOLUHcb1FYxEpuCYRr3DbiORu+sZDxkhKu1RAI8bkb3gtyemUkrS8aCE5gwdVJNOVH/+H881Dk+lBHCrtB03GNpauPEWxnjj4xZv1VUw65wl7D+tW/Gyk5BGhE9jyllbflXw7nYEoU3AVhcnmKvGC7+eTmoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999147; c=relaxed/simple;
	bh=EQQ7vomZ9H1eAMMwkYW5ZmmmIHYI1496zlpDaX4DaN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1TVh1K7OIkuNQY06mNndE5gs5d2b+lDk4VAW6bQLR5SxAX87wK61oGPR4fALXfZkHNubgWpoRpkb2YkAJf4GUsF02+H94diIgbuRbBrl4on2DenXrdmU5900iAkU5x9fjR3Tc+wDDt8hlr6uIH7ZhpLRaUxxYiC3ythftCwP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3x2GVa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B54C116B1;
	Mon,  6 May 2024 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714999146;
	bh=EQQ7vomZ9H1eAMMwkYW5ZmmmIHYI1496zlpDaX4DaN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j3x2GVa92pjApNsXc8TvCX11D3cYvwyNPCbQS34FWcHBxut3g//s8yzKABFJzdEqn
	 YMZvzwm2JWgL/8e20tDxJcPH7g1eR2Kmblji0r3mGKCdSlmu4Jh/mPEZpwMzY78CZM
	 jD/oJpfIZAbQFezc2a0hBOqdSz5fRUX8NtfU5JrgU7jnmhdAbPOM6nHvqgFWDAUZRP
	 wNrXv51RG99GC+j8FzyBBDxMjqXLdAFEbx+tJnHwCLDwwa1CWhAyjbHxsdYA+Cr32z
	 272tOCcSSo0DivlTC7DxBjiy/ePkdypuzxJFnRRC2U8x8uCPtyN3GfRUBHQdNA5Yms
	 +jDVqDuZrwTcw==
Date: Mon, 6 May 2024 13:38:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] iio: pressure: bmp280: Improve indentation and
 line wrapping
Message-ID: <20240506133853.462a350c@jic23-huawei>
In-Reply-To: <20240506000452.GD17986@vamoiridPC>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-2-vassilisamir@gmail.com>
	<20240505195155.0c682ec2@jic23-huawei>
	<20240506000452.GD17986@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 May 2024 02:04:52 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, May 05, 2024 at 07:51:55PM +0100, Jonathan Cameron wrote:
> > On Mon, 29 Apr 2024 21:00:37 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >  =20
> > > Fix indentations that are not following the standards, remove
> > > extra white lines and add missing white lines.
> > >=20
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com> =20
> >=20
> > Possibly some reviewers will feel one or two of these are a little over=
 zealous,
> > but this does both improve things and bring consistency to this code.
> >=20
> > I'll pick up some of these cleanups now (maybe the whole set but who kn=
ows)
> > to reduce what is left if we end up with a v6.
> >=20
> > Applied this one to the togreg branch of iio.git and pushed out as test=
ing
> > for 0-day to see if we missed anything,
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
>=20
> Hi Jonathan,
>=20
> I noticed that, another commit for this driver has been accepted here [1],
> which will affect some patches of this series that I am adding. It's not
> difficult at all to apply changes to my patches with respect to this new
> addition. Should I move on with a v6 without taking into consideration
> this change, and if everything is finally approved, I can send
> later a v7 with only the changes needed for this new commit?
Thanks for pointing that out. Please carry on as if that patch wasn't queued
up but mention it in your cover letter for v6.

It may take a little while for that patch to get upstream due to timing wrt
to the merge window but it will take a quicker path than this series.

If the merge resolution is similar enough, we may just do it upstream rather
than in my trees.

Jonathan

>=20
> Cheers,
> Vasilis
>=20
> [1] https://lore.kernel.org/linux-iio/043f2be49df3c11152aaf32fc5467ed43fd=
59faa.camel@gmail.com/T/#t
>=20
> > > ---
> > >  drivers/iio/pressure/bmp280-core.c | 108 ++++++++++++++++-----------=
--
> > >  drivers/iio/pressure/bmp280-spi.c  |   4 +-
> > >  2 files changed, 61 insertions(+), 51 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressur=
e/bmp280-core.c
> > > index 09f53d987c7d..1a3241a41768 100644
> > > --- a/drivers/iio/pressure/bmp280-core.c
> > > +++ b/drivers/iio/pressure/bmp280-core.c
> > > @@ -52,7 +52,6 @@
> > >   */
> > >  enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> > > =20
> > > -
> > >  enum bmp380_odr {
> > >  	BMP380_ODR_200HZ,
> > >  	BMP380_ODR_100HZ,
> > > @@ -181,18 +180,19 @@ static int bmp280_read_calib(struct bmp280_data=
 *data)
> > >  	struct bmp280_calib *calib =3D &data->calib.bmp280;
> > >  	int ret;
> > > =20
> > > -
> > >  	/* Read temperature and pressure calibration values. */
> > >  	ret =3D regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
> > > -			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
> > > +			       data->bmp280_cal_buf,
> > > +			       sizeof(data->bmp280_cal_buf));
> > >  	if (ret < 0) {
> > >  		dev_err(data->dev,
> > > -			"failed to read temperature and pressure calibration parameters\n=
");
> > > +			"failed to read calibration parameters\n");
> > >  		return ret;
> > >  	}
> > > =20
> > > -	/* Toss the temperature and pressure calibration data into the entr=
opy pool */
> > > -	add_device_randomness(data->bmp280_cal_buf, sizeof(data->bmp280_cal=
_buf));
> > > +	/* Toss calibration data into the entropy pool */
> > > +	add_device_randomness(data->bmp280_cal_buf,
> > > +			      sizeof(data->bmp280_cal_buf));
> > > =20
> > >  	/* Parse temperature calibration values. */
> > >  	calib->T1 =3D le16_to_cpu(data->bmp280_cal_buf[T1]);
> > > @@ -223,7 +223,7 @@ static int bme280_read_calib(struct bmp280_data *=
data)
> > >  	/* Load shared calibration params with bmp280 first */
> > >  	ret =3D bmp280_read_calib(data);
> > >  	if  (ret < 0) {
> > > -		dev_err(dev, "failed to read common bmp280 calibration parameters\=
n");
> > > +		dev_err(dev, "failed to read calibration parameters\n");
> > >  		return ret;
> > >  	}
> > > =20
> > > @@ -283,6 +283,7 @@ static int bme280_read_calib(struct bmp280_data *=
data)
> > > =20
> > >  	return 0;
> > >  }
> > > +
> > >  /*
> > >   * Returns humidity in percent, resolution is 0.01 percent. Output v=
alue of
> > >   * "47445" represents 47445/1024 =3D 46.333 %RH.
> > > @@ -305,7 +306,7 @@ static u32 bmp280_compensate_humidity(struct bmp2=
80_data *data,
> > >  	var =3D clamp_val(var, 0, 419430400);
> > > =20
> > >  	return var >> 12;
> > > -};
> > > +}
> > > =20
> > >  /*
> > >   * Returns temperature in DegC, resolution is 0.01 DegC.  Output val=
ue of
> > > @@ -538,7 +539,7 @@ static int bmp280_read_raw(struct iio_dev *indio_=
dev,
> > >  }
> > > =20
> > >  static int bmp280_write_oversampling_ratio_humid(struct bmp280_data =
*data,
> > > -					       int val)
> > > +						 int val)
> > >  {
> > >  	const int *avail =3D data->chip_info->oversampling_humid_avail;
> > >  	const int n =3D data->chip_info->num_oversampling_humid_avail;
> > > @@ -563,7 +564,7 @@ static int bmp280_write_oversampling_ratio_humid(=
struct bmp280_data *data,
> > >  }
> > > =20
> > >  static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *=
data,
> > > -					       int val)
> > > +						int val)
> > >  {
> > >  	const int *avail =3D data->chip_info->oversampling_temp_avail;
> > >  	const int n =3D data->chip_info->num_oversampling_temp_avail;
> > > @@ -588,7 +589,7 @@ static int bmp280_write_oversampling_ratio_temp(s=
truct bmp280_data *data,
> > >  }
> > > =20
> > >  static int bmp280_write_oversampling_ratio_press(struct bmp280_data =
*data,
> > > -					       int val)
> > > +						 int val)
> > >  {
> > >  	const int *avail =3D data->chip_info->oversampling_press_avail;
> > >  	const int n =3D data->chip_info->num_oversampling_press_avail;
> > > @@ -772,13 +773,12 @@ static int bmp280_chip_config(struct bmp280_dat=
a *data)
> > >  	int ret;
> > > =20
> > >  	ret =3D regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> > > -				 BMP280_OSRS_TEMP_MASK |
> > > -				 BMP280_OSRS_PRESS_MASK |
> > > -				 BMP280_MODE_MASK,
> > > -				 osrs | BMP280_MODE_NORMAL);
> > > +				BMP280_OSRS_TEMP_MASK |
> > > +				BMP280_OSRS_PRESS_MASK |
> > > +				BMP280_MODE_MASK,
> > > +				osrs | BMP280_MODE_NORMAL);
> > >  	if (ret < 0) {
> > > -		dev_err(data->dev,
> > > -			"failed to write ctrl_meas register\n");
> > > +		dev_err(data->dev, "failed to write ctrl_meas register\n");
> > >  		return ret;
> > >  	}
> > > =20
> > > @@ -786,8 +786,7 @@ static int bmp280_chip_config(struct bmp280_data =
*data)
> > >  				 BMP280_FILTER_MASK,
> > >  				 BMP280_FILTER_4X);
> > >  	if (ret < 0) {
> > > -		dev_err(data->dev,
> > > -			"failed to write config register\n");
> > > +		dev_err(data->dev, "failed to write config register\n");
> > >  		return ret;
> > >  	}
> > > =20
> > > @@ -926,8 +925,8 @@ static int bmp380_cmd(struct bmp280_data *data, u=
8 cmd)
> > >  }
> > > =20
> > >  /*
> > > - * Returns temperature in Celsius degrees, resolution is 0.01=C2=BA =
C. Output value of
> > > - * "5123" equals 51.2=C2=BA C. t_fine carries fine temperature as gl=
obal value.
> > > + * Returns temperature in Celsius degrees, resolution is 0.01=C2=BA =
C. Output value
> > > + * of "5123" equals 51.2=C2=BA C. t_fine carries fine temperature as=
 global value.
> > >   *
> > >   * Taken from datasheet, Section Appendix 9, "Compensation formula" =
and repo
> > >   * https://github.com/BoschSensortec/BMP3-Sensor-API.
> > > @@ -1069,7 +1068,8 @@ static int bmp380_read_calib(struct bmp280_data=
 *data)
> > > =20
> > >  	/* Read temperature and pressure calibration data */
> > >  	ret =3D regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START,
> > > -			       data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf));
> > > +			       data->bmp380_cal_buf,
> > > +			       sizeof(data->bmp380_cal_buf));
> > >  	if (ret) {
> > >  		dev_err(data->dev,
> > >  			"failed to read temperature calibration parameters\n");
> > > @@ -1077,7 +1077,8 @@ static int bmp380_read_calib(struct bmp280_data=
 *data)
> > >  	}
> > > =20
> > >  	/* Toss the temperature calibration data into the entropy pool */
> > > -	add_device_randomness(data->bmp380_cal_buf, sizeof(data->bmp380_cal=
_buf));
> > > +	add_device_randomness(data->bmp380_cal_buf,
> > > +			      sizeof(data->bmp380_cal_buf));
> > > =20
> > >  	/* Parse calibration values */
> > >  	calib->T1 =3D get_unaligned_le16(&data->bmp380_cal_buf[BMP380_T1]);
> > > @@ -1159,7 +1160,8 @@ static int bmp380_chip_config(struct bmp280_dat=
a *data)
> > > =20
> > >  	/* Configure output data rate */
> > >  	ret =3D regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
> > > -				       BMP380_ODRS_MASK, data->sampling_freq, &aux);
> > > +				       BMP380_ODRS_MASK, data->sampling_freq,
> > > +				       &aux);
> > >  	if (ret) {
> > >  		dev_err(data->dev, "failed to write ODR selection register\n");
> > >  		return ret;
> > > @@ -1178,12 +1180,13 @@ static int bmp380_chip_config(struct bmp280_d=
ata *data)
> > > =20
> > >  	if (change) {
> > >  		/*
> > > -		 * The configurations errors are detected on the fly during a meas=
urement
> > > -		 * cycle. If the sampling frequency is too low, it's faster to res=
et
> > > -		 * the measurement loop than wait until the next measurement is du=
e.
> > > +		 * The configurations errors are detected on the fly during a
> > > +		 * measurement cycle. If the sampling frequency is too low, it's
> > > +		 * faster to reset the measurement loop than wait until the next
> > > +		 * measurement is due.
> > >  		 *
> > > -		 * Resets sensor measurement loop toggling between sleep and normal
> > > -		 * operating modes.
> > > +		 * Resets sensor measurement loop toggling between sleep and
> > > +		 * normal operating modes.
> > >  		 */
> > >  		ret =3D regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> > >  					BMP380_MODE_MASK,
> > > @@ -1201,22 +1204,21 @@ static int bmp380_chip_config(struct bmp280_d=
ata *data)
> > >  			return ret;
> > >  		}
> > >  		/*
> > > -		 * Waits for measurement before checking configuration error flag.
> > > -		 * Selected longest measure time indicated in section 3.9.1
> > > -		 * in the datasheet.
> > > +		 * Waits for measurement before checking configuration error
> > > +		 * flag. Selected longest measure time indicated in
> > > +		 * section 3.9.1 in the datasheet.
> > >  		 */
> > >  		msleep(80);
> > > =20
> > >  		/* Check config error flag */
> > >  		ret =3D regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
> > >  		if (ret) {
> > > -			dev_err(data->dev,
> > > -				"failed to read error register\n");
> > > +			dev_err(data->dev, "failed to read error register\n");
> > >  			return ret;
> > >  		}
> > >  		if (tmp & BMP380_ERR_CONF_MASK) {
> > >  			dev_warn(data->dev,
> > > -				"sensor flagged configuration as incompatible\n");
> > > +				 "sensor flagged configuration as incompatible\n");
> > >  			return -EINVAL;
> > >  		}
> > >  	}
> > > @@ -1317,9 +1319,11 @@ static int bmp580_nvm_operation(struct bmp280_=
data *data, bool is_write)
> > >  	}
> > > =20
> > >  	/* Start NVM operation sequence */
> > > -	ret =3D regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_O=
P_SEQ_0);
> > > +	ret =3D regmap_write(data->regmap, BMP580_REG_CMD,
> > > +			   BMP580_CMD_NVM_OP_SEQ_0);
> > >  	if (ret) {
> > > -		dev_err(data->dev, "failed to send nvm operation's first sequence\=
n");
> > > +		dev_err(data->dev,
> > > +			"failed to send nvm operation's first sequence\n");
> > >  		return ret;
> > >  	}
> > >  	if (is_write) {
> > > @@ -1327,7 +1331,8 @@ static int bmp580_nvm_operation(struct bmp280_d=
ata *data, bool is_write)
> > >  		ret =3D regmap_write(data->regmap, BMP580_REG_CMD,
> > >  				   BMP580_CMD_NVM_WRITE_SEQ_1);
> > >  		if (ret) {
> > > -			dev_err(data->dev, "failed to send nvm write sequence\n");
> > > +			dev_err(data->dev,
> > > +				"failed to send nvm write sequence\n");
> > >  			return ret;
> > >  		}
> > >  		/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
> > > @@ -1338,7 +1343,8 @@ static int bmp580_nvm_operation(struct bmp280_d=
ata *data, bool is_write)
> > >  		ret =3D regmap_write(data->regmap, BMP580_REG_CMD,
> > >  				   BMP580_CMD_NVM_READ_SEQ_1);
> > >  		if (ret) {
> > > -			dev_err(data->dev, "failed to send nvm read sequence\n");
> > > +			dev_err(data->dev,
> > > +				"failed to send nvm read sequence\n");
> > >  			return ret;
> > >  		}
> > >  		/* Datasheet says on 4.8.1.1 it takes approximately 200us */
> > > @@ -1501,8 +1507,8 @@ static int bmp580_nvmem_read(void *priv, unsign=
ed int offset, void *val,
> > >  		if (ret)
> > >  			goto exit;
> > > =20
> > > -		ret =3D regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &d=
ata->le16,
> > > -				       sizeof(data->le16));
> > > +		ret =3D regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB,
> > > +				       &data->le16, sizeof(data->le16));
> > >  		if (ret) {
> > >  			dev_err(data->dev, "error reading nvm data regs\n");
> > >  			goto exit;
> > > @@ -1546,7 +1552,8 @@ static int bmp580_nvmem_write(void *priv, unsig=
ned int offset, void *val,
> > >  	while (bytes >=3D sizeof(*buf)) {
> > >  		addr =3D bmp580_nvmem_addrs[offset / sizeof(*buf)];
> > > =20
> > > -		ret =3D regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM=
_PROG_EN |
> > > +		ret =3D regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
> > > +				   BMP580_NVM_PROG_EN |
> > >  				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
> > >  		if (ret) {
> > >  			dev_err(data->dev, "error writing nvm address\n");
> > > @@ -1554,8 +1561,8 @@ static int bmp580_nvmem_write(void *priv, unsig=
ned int offset, void *val,
> > >  		}
> > >  		data->le16 =3D cpu_to_le16(*buf++);
> > > =20
> > > -		ret =3D regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &=
data->le16,
> > > -					sizeof(data->le16));
> > > +		ret =3D regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB,
> > > +					&data->le16, sizeof(data->le16));
> > >  		if (ret) {
> > >  			dev_err(data->dev, "error writing LSB NVM data regs\n");
> > >  			goto exit;
> > > @@ -1662,7 +1669,8 @@ static int bmp580_chip_config(struct bmp280_dat=
a *data)
> > >  		  BMP580_OSR_PRESS_EN;
> > > =20
> > >  	ret =3D regmap_update_bits_check(data->regmap, BMP580_REG_OSR_CONFI=
G,
> > > -				       BMP580_OSR_TEMP_MASK | BMP580_OSR_PRESS_MASK |
> > > +				       BMP580_OSR_TEMP_MASK |
> > > +				       BMP580_OSR_PRESS_MASK |
> > >  				       BMP580_OSR_PRESS_EN,
> > >  				       reg_val, &aux);
> > >  	if (ret) {
> > > @@ -1713,7 +1721,8 @@ static int bmp580_chip_config(struct bmp280_dat=
a *data)
> > >  		 */
> > >  		ret =3D regmap_read(data->regmap, BMP580_REG_EFF_OSR, &tmp);
> > >  		if (ret) {
> > > -			dev_err(data->dev, "error reading effective OSR register\n");
> > > +			dev_err(data->dev,
> > > +				"error reading effective OSR register\n");
> > >  			return ret;
> > >  		}
> > >  		if (!(tmp & BMP580_EFF_OSR_VALID_ODR)) {
> > > @@ -1848,7 +1857,8 @@ static int bmp180_read_calib(struct bmp280_data=
 *data)
> > >  	}
> > > =20
> > >  	/* Toss the calibration data into the entropy pool */
> > > -	add_device_randomness(data->bmp180_cal_buf, sizeof(data->bmp180_cal=
_buf));
> > > +	add_device_randomness(data->bmp180_cal_buf,
> > > +			      sizeof(data->bmp180_cal_buf));
> > > =20
> > >  	calib->AC1 =3D be16_to_cpu(data->bmp180_cal_buf[AC1]);
> > >  	calib->AC2 =3D be16_to_cpu(data->bmp180_cal_buf[AC2]);
> > > @@ -1963,8 +1973,7 @@ static u32 bmp180_compensate_press(struct bmp28=
0_data *data, s32 adc_press)
> > >  	return p + ((x1 + x2 + 3791) >> 4);
> > >  }
> > > =20
> > > -static int bmp180_read_press(struct bmp280_data *data,
> > > -			     int *val, int *val2)
> > > +static int bmp180_read_press(struct bmp280_data *data, int *val, int=
 *val2)
> > >  {
> > >  	u32 comp_press;
> > >  	s32 adc_press;
> > > @@ -2241,6 +2250,7 @@ static int bmp280_runtime_resume(struct device =
*dev)
> > >  	ret =3D regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
> > >  	if (ret)
> > >  		return ret;
> > > +
> > >  	usleep_range(data->start_up_time, data->start_up_time + 100);
> > >  	return data->chip_info->chip_config(data);
> > >  }
> > > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure=
/bmp280-spi.c
> > > index 4e19ea0b4d39..62b4e58104cf 100644
> > > --- a/drivers/iio/pressure/bmp280-spi.c
> > > +++ b/drivers/iio/pressure/bmp280-spi.c
> > > @@ -13,7 +13,7 @@
> > >  #include "bmp280.h"
> > > =20
> > >  static int bmp280_regmap_spi_write(void *context, const void *data,
> > > -                                   size_t count)
> > > +				   size_t count)
> > >  {
> > >  	struct spi_device *spi =3D to_spi_device(context);
> > >  	u8 buf[2];
> > > @@ -29,7 +29,7 @@ static int bmp280_regmap_spi_write(void *context, c=
onst void *data,
> > >  }
> > > =20
> > >  static int bmp280_regmap_spi_read(void *context, const void *reg,
> > > -                                  size_t reg_size, void *val, size_t=
 val_size)
> > > +				  size_t reg_size, void *val, size_t val_size)
> > >  {
> > >  	struct spi_device *spi =3D to_spi_device(context);
> > > =20
> > >=20
> > > base-commit: b0a2c79c6f3590b74742cbbc76687014d47972d8 =20
> >  =20


