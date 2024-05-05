Return-Path: <linux-iio+bounces-4817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C708BC320
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46D81F2141A
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7D850297;
	Sun,  5 May 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbSXV4GH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D73D551;
	Sun,  5 May 2024 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714935129; cv=none; b=JrQ1NGt/K7s2/I3SyC26hKR123QeP5YB57uhQNnjlqijcvSCNxdZCbhsR13YlsvESX15a2eKlbRoy5DjTQ05WjAutc7T9yQb6s9EcLeIZ9X3EF9ZODiDLLNVDOay56vczBGykNNQZNDKZIEeOBBWRhtz2IbAkQh6CatjdAXmeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714935129; c=relaxed/simple;
	bh=j2+VqfUG3m2W3T8LUpEnM+eQ09gmluJpJ/iFmKB/zW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHUPNEjuiT0DEEnOKEjBCe1qu7CgOML3eom/Gja8jQ2hl++VmV0oCJsULVx7UHQrRC5Kr1uxTOYFPMZB619Acvf796M0k3BrXKQG4XhykVHszh5YIklZc59WCX0OZcwiJ/KKqoD17jfWHsfMn9loGSjzog6LID8NjLbXmdXptTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbSXV4GH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD7DC113CC;
	Sun,  5 May 2024 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714935129;
	bh=j2+VqfUG3m2W3T8LUpEnM+eQ09gmluJpJ/iFmKB/zW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nbSXV4GHmUy7NIMcHM7DK70XraFRadLOPzye9Y8aG315xeEpuA+fwi9UPFm+A0RlD
	 aILKsnHjnYHuI8zXYBbFXy0Y/w9NriisadGkyhbuNdgqyWETEkFbA5vkiZyL5LPEPN
	 iVqSz/b1eTpqUCsnvtlg8/zJSDUapU478vQSPIPab40YZcEm7PZfUp3d4z86P3T0B3
	 0d0p8vGvacvHEB2jKgXO1r+IsVTEzlSdUhfF+8zaFLrDrnYGlXFBiT95VzpWctzTu+
	 Vq00zdzc/6P6gDLOcStlpwMx+njAJL4wfFeqB+f3jadfo5GPBPR6OtuUQtqsLaUGdU
	 eC4DgGv4OKIig==
Date: Sun, 5 May 2024 19:51:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] iio: pressure: bmp280: Improve indentation and
 line wrapping
Message-ID: <20240505195155.0c682ec2@jic23-huawei>
In-Reply-To: <20240429190046.24252-2-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024 21:00:37 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Fix indentations that are not following the standards, remove
> extra white lines and add missing white lines.
>=20
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Possibly some reviewers will feel one or two of these are a little over zea=
lous,
but this does both improve things and bring consistency to this code.

I'll pick up some of these cleanups now (maybe the whole set but who knows)
to reduce what is left if we end up with a v6.

Applied this one to the togreg branch of iio.git and pushed out as testing
for 0-day to see if we missed anything,

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 108 ++++++++++++++++-------------
>  drivers/iio/pressure/bmp280-spi.c  |   4 +-
>  2 files changed, 61 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bm=
p280-core.c
> index 09f53d987c7d..1a3241a41768 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -52,7 +52,6 @@
>   */
>  enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> =20
> -
>  enum bmp380_odr {
>  	BMP380_ODR_200HZ,
>  	BMP380_ODR_100HZ,
> @@ -181,18 +180,19 @@ static int bmp280_read_calib(struct bmp280_data *da=
ta)
>  	struct bmp280_calib *calib =3D &data->calib.bmp280;
>  	int ret;
> =20
> -
>  	/* Read temperature and pressure calibration values. */
>  	ret =3D regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
> -			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
> +			       data->bmp280_cal_buf,
> +			       sizeof(data->bmp280_cal_buf));
>  	if (ret < 0) {
>  		dev_err(data->dev,
> -			"failed to read temperature and pressure calibration parameters\n");
> +			"failed to read calibration parameters\n");
>  		return ret;
>  	}
> =20
> -	/* Toss the temperature and pressure calibration data into the entropy =
pool */
> -	add_device_randomness(data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf=
));
> +	/* Toss calibration data into the entropy pool */
> +	add_device_randomness(data->bmp280_cal_buf,
> +			      sizeof(data->bmp280_cal_buf));
> =20
>  	/* Parse temperature calibration values. */
>  	calib->T1 =3D le16_to_cpu(data->bmp280_cal_buf[T1]);
> @@ -223,7 +223,7 @@ static int bme280_read_calib(struct bmp280_data *data)
>  	/* Load shared calibration params with bmp280 first */
>  	ret =3D bmp280_read_calib(data);
>  	if  (ret < 0) {
> -		dev_err(dev, "failed to read common bmp280 calibration parameters\n");
> +		dev_err(dev, "failed to read calibration parameters\n");
>  		return ret;
>  	}
> =20
> @@ -283,6 +283,7 @@ static int bme280_read_calib(struct bmp280_data *data)
> =20
>  	return 0;
>  }
> +
>  /*
>   * Returns humidity in percent, resolution is 0.01 percent. Output value=
 of
>   * "47445" represents 47445/1024 =3D 46.333 %RH.
> @@ -305,7 +306,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_d=
ata *data,
>  	var =3D clamp_val(var, 0, 419430400);
> =20
>  	return var >> 12;
> -};
> +}
> =20
>  /*
>   * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
> @@ -538,7 +539,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  }
> =20
>  static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *dat=
a,
> -					       int val)
> +						 int val)
>  {
>  	const int *avail =3D data->chip_info->oversampling_humid_avail;
>  	const int n =3D data->chip_info->num_oversampling_humid_avail;
> @@ -563,7 +564,7 @@ static int bmp280_write_oversampling_ratio_humid(stru=
ct bmp280_data *data,
>  }
> =20
>  static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
> -					       int val)
> +						int val)
>  {
>  	const int *avail =3D data->chip_info->oversampling_temp_avail;
>  	const int n =3D data->chip_info->num_oversampling_temp_avail;
> @@ -588,7 +589,7 @@ static int bmp280_write_oversampling_ratio_temp(struc=
t bmp280_data *data,
>  }
> =20
>  static int bmp280_write_oversampling_ratio_press(struct bmp280_data *dat=
a,
> -					       int val)
> +						 int val)
>  {
>  	const int *avail =3D data->chip_info->oversampling_press_avail;
>  	const int n =3D data->chip_info->num_oversampling_press_avail;
> @@ -772,13 +773,12 @@ static int bmp280_chip_config(struct bmp280_data *d=
ata)
>  	int ret;
> =20
>  	ret =3D regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> -				 BMP280_OSRS_TEMP_MASK |
> -				 BMP280_OSRS_PRESS_MASK |
> -				 BMP280_MODE_MASK,
> -				 osrs | BMP280_MODE_NORMAL);
> +				BMP280_OSRS_TEMP_MASK |
> +				BMP280_OSRS_PRESS_MASK |
> +				BMP280_MODE_MASK,
> +				osrs | BMP280_MODE_NORMAL);
>  	if (ret < 0) {
> -		dev_err(data->dev,
> -			"failed to write ctrl_meas register\n");
> +		dev_err(data->dev, "failed to write ctrl_meas register\n");
>  		return ret;
>  	}
> =20
> @@ -786,8 +786,7 @@ static int bmp280_chip_config(struct bmp280_data *dat=
a)
>  				 BMP280_FILTER_MASK,
>  				 BMP280_FILTER_4X);
>  	if (ret < 0) {
> -		dev_err(data->dev,
> -			"failed to write config register\n");
> +		dev_err(data->dev, "failed to write config register\n");
>  		return ret;
>  	}
> =20
> @@ -926,8 +925,8 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cm=
d)
>  }
> =20
>  /*
> - * Returns temperature in Celsius degrees, resolution is 0.01=C2=BA C. O=
utput value of
> - * "5123" equals 51.2=C2=BA C. t_fine carries fine temperature as global=
 value.
> + * Returns temperature in Celsius degrees, resolution is 0.01=C2=BA C. O=
utput value
> + * of "5123" equals 51.2=C2=BA C. t_fine carries fine temperature as glo=
bal value.
>   *
>   * Taken from datasheet, Section Appendix 9, "Compensation formula" and =
repo
>   * https://github.com/BoschSensortec/BMP3-Sensor-API.
> @@ -1069,7 +1068,8 @@ static int bmp380_read_calib(struct bmp280_data *da=
ta)
> =20
>  	/* Read temperature and pressure calibration data */
>  	ret =3D regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START,
> -			       data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf));
> +			       data->bmp380_cal_buf,
> +			       sizeof(data->bmp380_cal_buf));
>  	if (ret) {
>  		dev_err(data->dev,
>  			"failed to read temperature calibration parameters\n");
> @@ -1077,7 +1077,8 @@ static int bmp380_read_calib(struct bmp280_data *da=
ta)
>  	}
> =20
>  	/* Toss the temperature calibration data into the entropy pool */
> -	add_device_randomness(data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf=
));
> +	add_device_randomness(data->bmp380_cal_buf,
> +			      sizeof(data->bmp380_cal_buf));
> =20
>  	/* Parse calibration values */
>  	calib->T1 =3D get_unaligned_le16(&data->bmp380_cal_buf[BMP380_T1]);
> @@ -1159,7 +1160,8 @@ static int bmp380_chip_config(struct bmp280_data *d=
ata)
> =20
>  	/* Configure output data rate */
>  	ret =3D regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
> -				       BMP380_ODRS_MASK, data->sampling_freq, &aux);
> +				       BMP380_ODRS_MASK, data->sampling_freq,
> +				       &aux);
>  	if (ret) {
>  		dev_err(data->dev, "failed to write ODR selection register\n");
>  		return ret;
> @@ -1178,12 +1180,13 @@ static int bmp380_chip_config(struct bmp280_data =
*data)
> =20
>  	if (change) {
>  		/*
> -		 * The configurations errors are detected on the fly during a measurem=
ent
> -		 * cycle. If the sampling frequency is too low, it's faster to reset
> -		 * the measurement loop than wait until the next measurement is due.
> +		 * The configurations errors are detected on the fly during a
> +		 * measurement cycle. If the sampling frequency is too low, it's
> +		 * faster to reset the measurement loop than wait until the next
> +		 * measurement is due.
>  		 *
> -		 * Resets sensor measurement loop toggling between sleep and normal
> -		 * operating modes.
> +		 * Resets sensor measurement loop toggling between sleep and
> +		 * normal operating modes.
>  		 */
>  		ret =3D regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
>  					BMP380_MODE_MASK,
> @@ -1201,22 +1204,21 @@ static int bmp380_chip_config(struct bmp280_data =
*data)
>  			return ret;
>  		}
>  		/*
> -		 * Waits for measurement before checking configuration error flag.
> -		 * Selected longest measure time indicated in section 3.9.1
> -		 * in the datasheet.
> +		 * Waits for measurement before checking configuration error
> +		 * flag. Selected longest measure time indicated in
> +		 * section 3.9.1 in the datasheet.
>  		 */
>  		msleep(80);
> =20
>  		/* Check config error flag */
>  		ret =3D regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
>  		if (ret) {
> -			dev_err(data->dev,
> -				"failed to read error register\n");
> +			dev_err(data->dev, "failed to read error register\n");
>  			return ret;
>  		}
>  		if (tmp & BMP380_ERR_CONF_MASK) {
>  			dev_warn(data->dev,
> -				"sensor flagged configuration as incompatible\n");
> +				 "sensor flagged configuration as incompatible\n");
>  			return -EINVAL;
>  		}
>  	}
> @@ -1317,9 +1319,11 @@ static int bmp580_nvm_operation(struct bmp280_data=
 *data, bool is_write)
>  	}
> =20
>  	/* Start NVM operation sequence */
> -	ret =3D regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_OP_SE=
Q_0);
> +	ret =3D regmap_write(data->regmap, BMP580_REG_CMD,
> +			   BMP580_CMD_NVM_OP_SEQ_0);
>  	if (ret) {
> -		dev_err(data->dev, "failed to send nvm operation's first sequence\n");
> +		dev_err(data->dev,
> +			"failed to send nvm operation's first sequence\n");
>  		return ret;
>  	}
>  	if (is_write) {
> @@ -1327,7 +1331,8 @@ static int bmp580_nvm_operation(struct bmp280_data =
*data, bool is_write)
>  		ret =3D regmap_write(data->regmap, BMP580_REG_CMD,
>  				   BMP580_CMD_NVM_WRITE_SEQ_1);
>  		if (ret) {
> -			dev_err(data->dev, "failed to send nvm write sequence\n");
> +			dev_err(data->dev,
> +				"failed to send nvm write sequence\n");
>  			return ret;
>  		}
>  		/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
> @@ -1338,7 +1343,8 @@ static int bmp580_nvm_operation(struct bmp280_data =
*data, bool is_write)
>  		ret =3D regmap_write(data->regmap, BMP580_REG_CMD,
>  				   BMP580_CMD_NVM_READ_SEQ_1);
>  		if (ret) {
> -			dev_err(data->dev, "failed to send nvm read sequence\n");
> +			dev_err(data->dev,
> +				"failed to send nvm read sequence\n");
>  			return ret;
>  		}
>  		/* Datasheet says on 4.8.1.1 it takes approximately 200us */
> @@ -1501,8 +1507,8 @@ static int bmp580_nvmem_read(void *priv, unsigned i=
nt offset, void *val,
>  		if (ret)
>  			goto exit;
> =20
> -		ret =3D regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &data-=
>le16,
> -				       sizeof(data->le16));
> +		ret =3D regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB,
> +				       &data->le16, sizeof(data->le16));
>  		if (ret) {
>  			dev_err(data->dev, "error reading nvm data regs\n");
>  			goto exit;
> @@ -1546,7 +1552,8 @@ static int bmp580_nvmem_write(void *priv, unsigned =
int offset, void *val,
>  	while (bytes >=3D sizeof(*buf)) {
>  		addr =3D bmp580_nvmem_addrs[offset / sizeof(*buf)];
> =20
> -		ret =3D regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM_PRO=
G_EN |
> +		ret =3D regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
> +				   BMP580_NVM_PROG_EN |
>  				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
>  		if (ret) {
>  			dev_err(data->dev, "error writing nvm address\n");
> @@ -1554,8 +1561,8 @@ static int bmp580_nvmem_write(void *priv, unsigned =
int offset, void *val,
>  		}
>  		data->le16 =3D cpu_to_le16(*buf++);
> =20
> -		ret =3D regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &data=
->le16,
> -					sizeof(data->le16));
> +		ret =3D regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB,
> +					&data->le16, sizeof(data->le16));
>  		if (ret) {
>  			dev_err(data->dev, "error writing LSB NVM data regs\n");
>  			goto exit;
> @@ -1662,7 +1669,8 @@ static int bmp580_chip_config(struct bmp280_data *d=
ata)
>  		  BMP580_OSR_PRESS_EN;
> =20
>  	ret =3D regmap_update_bits_check(data->regmap, BMP580_REG_OSR_CONFIG,
> -				       BMP580_OSR_TEMP_MASK | BMP580_OSR_PRESS_MASK |
> +				       BMP580_OSR_TEMP_MASK |
> +				       BMP580_OSR_PRESS_MASK |
>  				       BMP580_OSR_PRESS_EN,
>  				       reg_val, &aux);
>  	if (ret) {
> @@ -1713,7 +1721,8 @@ static int bmp580_chip_config(struct bmp280_data *d=
ata)
>  		 */
>  		ret =3D regmap_read(data->regmap, BMP580_REG_EFF_OSR, &tmp);
>  		if (ret) {
> -			dev_err(data->dev, "error reading effective OSR register\n");
> +			dev_err(data->dev,
> +				"error reading effective OSR register\n");
>  			return ret;
>  		}
>  		if (!(tmp & BMP580_EFF_OSR_VALID_ODR)) {
> @@ -1848,7 +1857,8 @@ static int bmp180_read_calib(struct bmp280_data *da=
ta)
>  	}
> =20
>  	/* Toss the calibration data into the entropy pool */
> -	add_device_randomness(data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf=
));
> +	add_device_randomness(data->bmp180_cal_buf,
> +			      sizeof(data->bmp180_cal_buf));
> =20
>  	calib->AC1 =3D be16_to_cpu(data->bmp180_cal_buf[AC1]);
>  	calib->AC2 =3D be16_to_cpu(data->bmp180_cal_buf[AC2]);
> @@ -1963,8 +1973,7 @@ static u32 bmp180_compensate_press(struct bmp280_da=
ta *data, s32 adc_press)
>  	return p + ((x1 + x2 + 3791) >> 4);
>  }
> =20
> -static int bmp180_read_press(struct bmp280_data *data,
> -			     int *val, int *val2)
> +static int bmp180_read_press(struct bmp280_data *data, int *val, int *va=
l2)
>  {
>  	u32 comp_press;
>  	s32 adc_press;
> @@ -2241,6 +2250,7 @@ static int bmp280_runtime_resume(struct device *dev)
>  	ret =3D regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
>  	if (ret)
>  		return ret;
> +
>  	usleep_range(data->start_up_time, data->start_up_time + 100);
>  	return data->chip_info->chip_config(data);
>  }
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp=
280-spi.c
> index 4e19ea0b4d39..62b4e58104cf 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -13,7 +13,7 @@
>  #include "bmp280.h"
> =20
>  static int bmp280_regmap_spi_write(void *context, const void *data,
> -                                   size_t count)
> +				   size_t count)
>  {
>  	struct spi_device *spi =3D to_spi_device(context);
>  	u8 buf[2];
> @@ -29,7 +29,7 @@ static int bmp280_regmap_spi_write(void *context, const=
 void *data,
>  }
> =20
>  static int bmp280_regmap_spi_read(void *context, const void *reg,
> -                                  size_t reg_size, void *val, size_t val=
_size)
> +				  size_t reg_size, void *val, size_t val_size)
>  {
>  	struct spi_device *spi =3D to_spi_device(context);
> =20
>=20
> base-commit: b0a2c79c6f3590b74742cbbc76687014d47972d8


