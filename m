Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9477C138125
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgAKLez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 06:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgAKLez (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:34:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A469720848;
        Sat, 11 Jan 2020 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578742493;
        bh=RpnUmlgLDLtBjJk4lV0+ihG4A2+Vcn31e3VgKPL4ieE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jEQh//xVXX3mawER50XybcZ7pU/D0PDBXqqlrR9ptMq2yajrWivta4CqWikc2ziaH
         BiW0wSsu1qhZqdDO6ZFGlF9vElGfcIn3oZqQFnXU6QoOCHVm2OUOJ1s8A9hQ2Y/UG6
         rm5iA37k1gpNpoRfiihyr+npQt8+mwNKWzzoXd/s=
Date:   Sat, 11 Jan 2020 11:34:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/2] iio: adis: Introduce timeouts structure
Message-ID: <20200111113448.3f4b79d2@archlinux>
In-Reply-To: <20200107111705.24138-1-alexandru.ardelean@analog.com>
References: <20200107111705.24138-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Jan 2020 13:17:04 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> The adis library only allows to define a `startup_delay` which for some
> devices is enough. However, other devices define different timeouts with
> significantly different timings which could lead to devices to not wait
> enough time or to wait a lot more than necessary (which is not
> efficient). This patch introduces a new timeout struct that must be
> passed into `adis_init()`. There are mainly, for now, three timeouts
> used. This is also an introductory patch with the goal of refactoring
> `adis_initial_startup()`. New driver's (eg: adis16480, adis16460) are
> replicating code for the device initial setup. With some changes (being
> this the first one) we can pass this to `adis_initial_startup()`.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

I'm a little unsure if this is the right option long term.
You may be better off putting the _data structure as a member of
the chip info structures (using macros to handle the parts that
are reused).  That would avoid either the need for memcpy or
to pass a 'per driver' part and a 'per chip_info' part into the init
function.

However, for now this is fairly clean.  The best option will depend
in the long run on what else we find needs similar handling to these
timeouts.

As such.. Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to poke at it. =20
> ---
>=20
> Changelog v1 - v2:
> * rework patch to remove manual assignments for adis16136, adis16400,
>   adis16480 and do memcpy() from the static adis_data
>=20
>=20
>  drivers/iio/accel/adis16201.c         |  7 +++
>  drivers/iio/accel/adis16209.c         |  7 +++
>  drivers/iio/gyro/adis16136.c          | 40 ++++++++++++++++-
>  drivers/iio/gyro/adis16260.c          |  7 +++
>  drivers/iio/imu/adis.c                | 18 ++++++--
>  drivers/iio/imu/adis16400.c           | 63 ++++++++++++++++++++++++++-
>  drivers/iio/imu/adis16460.c           |  7 +++
>  drivers/iio/imu/adis16480.c           | 58 +++++++++++++++++++++++-
>  drivers/staging/iio/accel/adis16203.c |  7 +++
>  drivers/staging/iio/accel/adis16240.c |  7 +++
>  include/linux/iio/imu/adis.h          | 13 ++++++
>  11 files changed, 227 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index c4810c73b2a2..c92d22387b01 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -233,6 +233,12 @@ static const char * const adis16201_status_error_msg=
s[] =3D {
>  	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] =3D "Power supply below 2.975V",
>  };
> =20
> +static const struct adis_timeout adis16201_timeouts =3D {
> +	.reset_ms =3D ADIS16201_STARTUP_DELAY_MS,
> +	.sw_reset_ms =3D ADIS16201_STARTUP_DELAY_MS,
> +	.self_test_ms =3D ADIS16201_STARTUP_DELAY_MS,
> +};
> +
>  static const struct adis_data adis16201_data =3D {
>  	.read_delay =3D 20,
>  	.msc_ctrl_reg =3D ADIS16201_MSC_CTRL_REG,
> @@ -242,6 +248,7 @@ static const struct adis_data adis16201_data =3D {
>  	.self_test_mask =3D ADIS16201_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear =3D true,
>  	.startup_delay =3D ADIS16201_STARTUP_DELAY_MS,
> +	.timeouts =3D &adis16201_timeouts,
> =20
>  	.status_error_msgs =3D adis16201_status_error_msgs,
>  	.status_error_mask =3D BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> index 98d77af8a2b0..f5a78fc11919 100644
> --- a/drivers/iio/accel/adis16209.c
> +++ b/drivers/iio/accel/adis16209.c
> @@ -243,6 +243,12 @@ static const char * const adis16209_status_error_msg=
s[] =3D {
>  	[ADIS16209_STAT_POWER_LOW_BIT] =3D "Power supply below 2.975V",
>  };
> =20
> +static const struct adis_timeout adis16209_timeouts =3D {
> +	.reset_ms =3D ADIS16209_STARTUP_DELAY_MS,
> +	.self_test_ms =3D ADIS16209_STARTUP_DELAY_MS,
> +	.sw_reset_ms =3D ADIS16209_STARTUP_DELAY_MS,
> +};
> +
>  static const struct adis_data adis16209_data =3D {
>  	.read_delay =3D 30,
>  	.msc_ctrl_reg =3D ADIS16209_MSC_CTRL_REG,
> @@ -252,6 +258,7 @@ static const struct adis_data adis16209_data =3D {
>  	.self_test_mask =3D ADIS16209_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear =3D true,
>  	.startup_delay =3D ADIS16209_STARTUP_DELAY_MS,
> +	.timeouts =3D &adis16209_timeouts,
> =20
>  	.status_error_msgs =3D adis16209_status_error_msgs,
>  	.status_error_mask =3D BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index f10c4f173898..dc91d8df7697 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -59,6 +59,7 @@
>  struct adis16136_chip_info {
>  	unsigned int precision;
>  	unsigned int fullscale;
> +	const struct adis_timeout *timeouts;
>  };
> =20
>  struct adis16136 {
> @@ -490,30 +491,63 @@ enum adis16136_id {
>  	ID_ADIS16137,
>  };
> =20
> +static const struct adis_timeout adis16133_timeouts =3D {
> +	.reset_ms =3D 75,
> +	.sw_reset_ms =3D 75,
> +	.self_test_ms =3D 50,
> +};
> +
> +static const struct adis_timeout adis16136_timeouts =3D {
> +	.reset_ms =3D 128,
> +	.sw_reset_ms =3D 75,
> +	.self_test_ms =3D 245,
> +};
> +
>  static const struct adis16136_chip_info adis16136_chip_info[] =3D {
>  	[ID_ADIS16133] =3D {
>  		.precision =3D IIO_DEGREE_TO_RAD(1200),
>  		.fullscale =3D 24000,
> +		.timeouts =3D &adis16133_timeouts,
>  	},
>  	[ID_ADIS16135] =3D {
>  		.precision =3D IIO_DEGREE_TO_RAD(300),
>  		.fullscale =3D 24000,
> +		.timeouts =3D &adis16133_timeouts,
>  	},
>  	[ID_ADIS16136] =3D {
>  		.precision =3D IIO_DEGREE_TO_RAD(450),
>  		.fullscale =3D 24623,
> +		.timeouts =3D &adis16136_timeouts,
>  	},
>  	[ID_ADIS16137] =3D {
>  		.precision =3D IIO_DEGREE_TO_RAD(1000),
>  		.fullscale =3D 24609,
> +		.timeouts =3D &adis16136_timeouts,
>  	},
>  };
> =20
> +static struct adis_data *adis16136_adis_data_alloc(struct adis16136 *st,
> +						   struct device *dev)
> +{
> +	struct adis_data *data;
> +
> +	data =3D devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memcpy(data, &adis16136_data, sizeof(*data));
> +
> +	data->timeouts =3D st->chip_info->timeouts;
> +
> +	return data;
> +}
> +
>  static int adis16136_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
>  	struct adis16136 *adis16136;
>  	struct iio_dev *indio_dev;
> +	const struct adis_data *adis16136_data;
>  	int ret;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adis16136));
> @@ -532,7 +566,11 @@ static int adis16136_probe(struct spi_device *spi)
>  	indio_dev->info =3D &adis16136_info;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =20
> -	ret =3D adis_init(&adis16136->adis, indio_dev, spi, &adis16136_data);
> +	adis16136_data =3D adis16136_adis_data_alloc(adis16136, &spi->dev);
> +	if (IS_ERR(adis16136_data))
> +		return PTR_ERR(adis16136_data);
> +
> +	ret =3D adis_init(&adis16136->adis, indio_dev, spi, adis16136_data);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> index 726a0aa321a8..0e3a66a7726d 100644
> --- a/drivers/iio/gyro/adis16260.c
> +++ b/drivers/iio/gyro/adis16260.c
> @@ -332,6 +332,12 @@ static const char * const adis1620_status_error_msgs=
[] =3D {
>  	[ADIS16260_DIAG_STAT_POWER_LOW_BIT] =3D "Power supply below 4.75",
>  };
> =20
> +static const struct adis_timeout adis16260_timeouts =3D {
> +	.reset_ms =3D ADIS16260_STARTUP_DELAY,
> +	.sw_reset_ms =3D ADIS16260_STARTUP_DELAY,
> +	.self_test_ms =3D ADIS16260_STARTUP_DELAY,
> +};
> +
>  static const struct adis_data adis16260_data =3D {
>  	.write_delay =3D 30,
>  	.read_delay =3D 30,
> @@ -341,6 +347,7 @@ static const struct adis_data adis16260_data =3D {
> =20
>  	.self_test_mask =3D ADIS16260_MSC_CTRL_MEM_TEST,
>  	.startup_delay =3D ADIS16260_STARTUP_DELAY,
> +	.timeouts =3D &adis16260_timeouts,
> =20
>  	.status_error_msgs =3D adis1620_status_error_msgs,
>  	.status_error_mask =3D BIT(ADIS16260_DIAG_STAT_FLASH_CHK_BIT) |
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index c53f3ed3cb97..3e12ad4b71ba 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -317,19 +317,25 @@ EXPORT_SYMBOL_GPL(__adis_check_status);
>  int __adis_reset(struct adis *adis)
>  {
>  	int ret;
> +	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> =20
>  	ret =3D __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
>  			ADIS_GLOB_CMD_SW_RESET);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
> +		return ret;
> +	}
> =20
> -	return ret;
> +	msleep(timeouts->sw_reset_ms);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(__adis_reset);
> =20
>  static int adis_self_test(struct adis *adis)
>  {
>  	int ret;
> +	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> =20
>  	ret =3D __adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
>  			adis->data->self_test_mask);
> @@ -339,7 +345,7 @@ static int adis_self_test(struct adis *adis)
>  		return ret;
>  	}
> =20
> -	msleep(adis->data->startup_delay);
> +	msleep(timeouts->self_test_ms);
> =20
>  	ret =3D __adis_check_status(adis);
> =20
> @@ -368,7 +374,6 @@ int adis_initial_startup(struct adis *adis)
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
>  		__adis_reset(adis);
> -		msleep(adis->data->startup_delay);
>  		ret =3D adis_self_test(adis);
>  		if (ret) {
>  			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
> @@ -444,6 +449,11 @@ EXPORT_SYMBOL_GPL(adis_single_conversion);
>  int adis_init(struct adis *adis, struct iio_dev *indio_dev,
>  	struct spi_device *spi, const struct adis_data *data)
>  {
> +	if (!data || !data->timeouts) {
> +		dev_err(&spi->dev, "No config data or timeouts not defined!\n");
> +		return -EINVAL;
> +	}
> +
>  	mutex_init(&adis->state_lock);
>  	adis->spi =3D spi;
>  	adis->data =3D data;
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 662cb5367c11..51b1ec23b8ef 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -156,6 +156,7 @@ struct adis16400_state;
> =20
>  struct adis16400_chip_info {
>  	const struct iio_chan_spec *channels;
> +	const struct adis_timeout *timeouts;
>  	const int num_channels;
>  	const long flags;
>  	unsigned int gyro_scale_micro;
> @@ -929,6 +930,36 @@ static const struct iio_chan_spec adis16334_channels=
[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(ADIS16400_SCAN_TIMESTAMP),
>  };
> =20
> +static const struct adis_timeout adis16300_timeouts =3D {
> +	.reset_ms =3D ADIS16400_STARTUP_DELAY,
> +	.sw_reset_ms =3D ADIS16400_STARTUP_DELAY,
> +	.self_test_ms =3D ADIS16400_STARTUP_DELAY,
> +};
> +
> +static const struct adis_timeout adis16362_timeouts =3D {
> +	.reset_ms =3D 130,
> +	.sw_reset_ms =3D 130,
> +	.self_test_ms =3D 12,
> +};
> +
> +static const struct adis_timeout adis16400_timeouts =3D {
> +	.reset_ms =3D 170,
> +	.sw_reset_ms =3D 170,
> +	.self_test_ms =3D 12,
> +};
> +
> +static const struct adis_timeout adis16445_timeouts =3D {
> +	.reset_ms =3D 55,
> +	.sw_reset_ms =3D 55,
> +	.self_test_ms =3D 16,
> +};
> +
> +static const struct adis_timeout adis16448_timeouts =3D {
> +	.reset_ms =3D 90,
> +	.sw_reset_ms =3D 90,
> +	.self_test_ms =3D 45,
> +};
> +
>  static struct adis16400_chip_info adis16400_chips[] =3D {
>  	[ADIS16300] =3D {
>  		.channels =3D adis16300_channels,
> @@ -941,6 +972,7 @@ static struct adis16400_chip_info adis16400_chips[] =
=3D {
>  		.temp_offset =3D 25000000 / 140000, /* 25 C =3D 0x00 */
>  		.set_freq =3D adis16400_set_freq,
>  		.get_freq =3D adis16400_get_freq,
> +		.timeouts =3D &adis16300_timeouts,
>  	},
>  	[ADIS16334] =3D {
>  		.channels =3D adis16334_channels,
> @@ -964,6 +996,7 @@ static struct adis16400_chip_info adis16400_chips[] =
=3D {
>  		.flags =3D ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
>  		.set_freq =3D adis16400_set_freq,
>  		.get_freq =3D adis16400_get_freq,
> +		.timeouts =3D &adis16300_timeouts,
>  	},
>  	[ADIS16360] =3D {
>  		.channels =3D adis16350_channels,
> @@ -976,6 +1009,7 @@ static struct adis16400_chip_info adis16400_chips[] =
=3D {
>  		.temp_offset =3D 25000000 / 136000, /* 25 C =3D 0x00 */
>  		.set_freq =3D adis16400_set_freq,
>  		.get_freq =3D adis16400_get_freq,
> +		.timeouts =3D &adis16300_timeouts,
>  	},
>  	[ADIS16362] =3D {
>  		.channels =3D adis16350_channels,
> @@ -988,6 +1022,7 @@ static struct adis16400_chip_info adis16400_chips[] =
=3D {
>  		.temp_offset =3D 25000000 / 136000, /* 25 C =3D 0x00 */
>  		.set_freq =3D adis16400_set_freq,
>  		.get_freq =3D adis16400_get_freq,
> +		.timeouts =3D &adis16362_timeouts,
>  	},
>  	[ADIS16364] =3D {
>  		.channels =3D adis16350_channels,
> @@ -1000,6 +1035,7 @@ static struct adis16400_chip_info adis16400_chips[]=
 =3D {
>  		.temp_offset =3D 25000000 / 136000, /* 25 C =3D 0x00 */
>  		.set_freq =3D adis16400_set_freq,
>  		.get_freq =3D adis16400_get_freq,
> +		.timeouts =3D &adis16362_timeouts,
>  	},
>  	[ADIS16367] =3D {
>  		.channels =3D adis16350_channels,
> @@ -1012,6 +1048,7 @@ static struct adis16400_chip_info adis16400_chips[]=
 =3D {
>  		.temp_offset =3D 25000000 / 136000, /* 25 C =3D 0x00 */
>  		.set_freq =3D adis16400_set_freq,
>  		.get_freq =3D adis16400_get_freq,
> +		.timeouts =3D &adis16300_timeouts,
>  	},
>  	[ADIS16400] =3D {
>  		.channels =3D adis16400_channels,
> @@ -1023,6 +1060,7 @@ static struct adis16400_chip_info adis16400_chips[]=
 =3D {
>  		.temp_offset =3D 25000000 / 140000, /* 25 C =3D 0x00 */
>  		.set_freq =3D adis16400_set_freq,
>  		.get_freq =3D adis16400_get_freq,
> +		.timeouts =3D &adis16400_timeouts,
>  	},
>  	[ADIS16445] =3D {
>  		.channels =3D adis16445_channels,
> @@ -1036,6 +1074,7 @@ static struct adis16400_chip_info adis16400_chips[]=
 =3D {
>  		.temp_offset =3D 31000000 / 73860, /* 31 C =3D 0x00 */
>  		.set_freq =3D adis16334_set_freq,
>  		.get_freq =3D adis16334_get_freq,
> +		.timeouts =3D &adis16445_timeouts,
>  	},
>  	[ADIS16448] =3D {
>  		.channels =3D adis16448_channels,
> @@ -1049,6 +1088,7 @@ static struct adis16400_chip_info adis16400_chips[]=
 =3D {
>  		.temp_offset =3D 31000000 / 73860, /* 31 C =3D 0x00 */
>  		.set_freq =3D adis16334_set_freq,
>  		.get_freq =3D adis16334_get_freq,
> +		.timeouts =3D &adis16448_timeouts,
>  	}
>  };
> =20
> @@ -1120,11 +1160,28 @@ static void adis16400_setup_chan_mask(struct adis=
16400_state *st)
>  	}
>  }
> =20
> +static struct adis_data *adis16400_adis_data_alloc(struct adis16400_stat=
e *st,
> +						   struct device *dev)
> +{
> +	struct adis_data *data;
> +
> +	data =3D devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memcpy(data, &adis16400_data, sizeof(*data));
> +
> +	data->timeouts =3D st->variant->timeouts;
> +
> +	return data;
> +}
> +
>  static int adis16400_probe(struct spi_device *spi)
>  {
>  	struct adis16400_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	const struct adis_data *adis16400_data;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev =3D=3D NULL)
> @@ -1151,7 +1208,11 @@ static int adis16400_probe(struct spi_device *spi)
>  			st->adis.burst->extra_len =3D sizeof(u16);
>  	}
> =20
> -	ret =3D adis_init(&st->adis, indio_dev, spi, &adis16400_data);
> +	adis16400_data =3D adis16400_adis_data_alloc(st, &spi->dev);
> +	if (IS_ERR(adis16400_data))
> +		return PTR_ERR(adis16400_data);
> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, adis16400_data);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index b55812521537..9539cfe4a259 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -383,6 +383,12 @@ static const char * const adis16460_status_error_msg=
s[] =3D {
>  	[ADIS16460_DIAG_STAT_FLASH_UPT] =3D "Flash update failure",
>  };
> =20
> +static const struct adis_timeout adis16460_timeouts =3D {
> +	.reset_ms =3D 225,
> +	.sw_reset_ms =3D 225,
> +	.self_test_ms =3D 10,
> +};
> +
>  static const struct adis_data adis16460_data =3D {
>  	.diag_stat_reg =3D ADIS16460_REG_DIAG_STAT,
>  	.glob_cmd_reg =3D ADIS16460_REG_GLOB_CMD,
> @@ -398,6 +404,7 @@ static const struct adis_data adis16460_data =3D {
>  		BIT(ADIS16460_DIAG_STAT_SPI_COMM) |
>  		BIT(ADIS16460_DIAG_STAT_FLASH_UPT),
>  	.enable_irq =3D adis16460_enable_irq,
> +	.timeouts =3D &adis16460_timeouts,
>  };
> =20
>  static int adis16460_probe(struct spi_device *spi)
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index f73094e8d35d..f0ad7ce64861 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -138,6 +138,7 @@ struct adis16480_chip_info {
>  	unsigned int max_dec_rate;
>  	const unsigned int *filter_freqs;
>  	bool has_pps_clk_mode;
> +	const struct adis_timeout *timeouts;
>  };
> =20
>  enum adis16480_int_pin {
> @@ -794,6 +795,30 @@ enum adis16480_variant {
>  	ADIS16497_3,
>  };
> =20
> +static const struct adis_timeout adis16485_timeouts =3D {
> +	.reset_ms =3D 560,
> +	.sw_reset_ms =3D 120,
> +	.self_test_ms =3D 12,
> +};
> +
> +static const struct adis_timeout adis16480_timeouts =3D {
> +	.reset_ms =3D 560,
> +	.sw_reset_ms =3D 560,
> +	.self_test_ms =3D 12,
> +};
> +
> +static const struct adis_timeout adis16495_timeouts =3D {
> +	.reset_ms =3D 170,
> +	.sw_reset_ms =3D 130,
> +	.self_test_ms =3D 40,
> +};
> +
> +static const struct adis_timeout adis16495_1_timeouts =3D {
> +	.reset_ms =3D 250,
> +	.sw_reset_ms =3D 210,
> +	.self_test_ms =3D 20,
> +};
> +
>  static const struct adis16480_chip_info adis16480_chip_info[] =3D {
>  	[ADIS16375] =3D {
>  		.channels =3D adis16485_channels,
> @@ -812,6 +837,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.int_clk =3D 2460000,
>  		.max_dec_rate =3D 2048,
>  		.filter_freqs =3D adis16480_def_filter_freqs,
> +		.timeouts =3D &adis16485_timeouts,
>  	},
>  	[ADIS16480] =3D {
>  		.channels =3D adis16480_channels,
> @@ -824,6 +850,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.int_clk =3D 2460000,
>  		.max_dec_rate =3D 2048,
>  		.filter_freqs =3D adis16480_def_filter_freqs,
> +		.timeouts =3D &adis16480_timeouts,
>  	},
>  	[ADIS16485] =3D {
>  		.channels =3D adis16485_channels,
> @@ -836,6 +863,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.int_clk =3D 2460000,
>  		.max_dec_rate =3D 2048,
>  		.filter_freqs =3D adis16480_def_filter_freqs,
> +		.timeouts =3D &adis16485_timeouts,
>  	},
>  	[ADIS16488] =3D {
>  		.channels =3D adis16480_channels,
> @@ -848,6 +876,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.int_clk =3D 2460000,
>  		.max_dec_rate =3D 2048,
>  		.filter_freqs =3D adis16480_def_filter_freqs,
> +		.timeouts =3D &adis16485_timeouts,
>  	},
>  	[ADIS16495_1] =3D {
>  		.channels =3D adis16485_channels,
> @@ -861,6 +890,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> +		.timeouts =3D &adis16495_1_timeouts,
>  	},
>  	[ADIS16495_2] =3D {
>  		.channels =3D adis16485_channels,
> @@ -874,6 +904,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> +		.timeouts =3D &adis16495_1_timeouts,
>  	},
>  	[ADIS16495_3] =3D {
>  		.channels =3D adis16485_channels,
> @@ -887,6 +918,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> +		.timeouts =3D &adis16495_1_timeouts,
>  	},
>  	[ADIS16497_1] =3D {
>  		.channels =3D adis16485_channels,
> @@ -900,6 +932,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> +		.timeouts =3D &adis16495_1_timeouts,
>  	},
>  	[ADIS16497_2] =3D {
>  		.channels =3D adis16485_channels,
> @@ -913,6 +946,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> +		.timeouts =3D &adis16495_1_timeouts,
>  	},
>  	[ADIS16497_3] =3D {
>  		.channels =3D adis16485_channels,
> @@ -926,6 +960,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> +		.timeouts =3D &adis16495_1_timeouts,
>  	},
>  };
> =20
> @@ -1195,9 +1230,26 @@ static int adis16480_get_ext_clocks(struct adis164=
80 *st)
>  	return 0;
>  }
> =20
> +static struct adis_data *adis16480_adis_data_alloc(struct adis16480 *st,
> +						   struct device *dev)
> +{
> +	struct adis_data *data;
> +
> +	data =3D devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memcpy(data, &adis16480_data, sizeof(*data));
> +
> +	data->timeouts =3D st->chip_info->timeouts;
> +
> +	return data;
> +}
> +
>  static int adis16480_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
> +	const struct adis_data *adis16480_data;
>  	struct iio_dev *indio_dev;
>  	struct adis16480 *st;
>  	int ret;
> @@ -1218,7 +1270,11 @@ static int adis16480_probe(struct spi_device *spi)
>  	indio_dev->info =3D &adis16480_info;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =20
> -	ret =3D adis_init(&st->adis, indio_dev, spi, &adis16480_data);
> +	adis16480_data =3D adis16480_adis_data_alloc(st, &spi->dev);
> +	if (IS_ERR(adis16480_data))
> +		return PTR_ERR(adis16480_data);
> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, adis16480_data);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/=
accel/adis16203.c
> index 39687139a7d3..3d706ee02df0 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -237,6 +237,12 @@ static const char * const adis16203_status_error_msg=
s[] =3D {
>  	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] =3D "Power supply below 2.975V",
>  };
> =20
> +static const struct adis_timeout adis16203_timeouts =3D {
> +	.reset_ms =3D ADIS16203_STARTUP_DELAY,
> +	.sw_reset_ms =3D ADIS16203_STARTUP_DELAY,
> +	.self_test_ms =3D ADIS16203_STARTUP_DELAY
> +};
> +
>  static const struct adis_data adis16203_data =3D {
>  	.read_delay =3D 20,
>  	.msc_ctrl_reg =3D ADIS16203_MSC_CTRL,
> @@ -246,6 +252,7 @@ static const struct adis_data adis16203_data =3D {
>  	.self_test_mask =3D ADIS16203_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear =3D true,
>  	.startup_delay =3D ADIS16203_STARTUP_DELAY,
> +	.timeouts =3D &adis16203_timeouts,
> =20
>  	.status_error_msgs =3D adis16203_status_error_msgs,
>  	.status_error_mask =3D BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/=
accel/adis16240.c
> index 794f063e6c86..d4848ef78c75 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -359,6 +359,12 @@ static const char * const adis16240_status_error_msg=
s[] =3D {
>  	[ADIS16240_DIAG_STAT_POWER_LOW_BIT] =3D "Power supply below 2.225V",
>  };
> =20
> +static const struct adis_timeout adis16240_timeouts =3D {
> +	.reset_ms =3D ADIS16240_STARTUP_DELAY,
> +	.sw_reset_ms =3D ADIS16240_STARTUP_DELAY,
> +	.self_test_ms =3D ADIS16240_STARTUP_DELAY,
> +};
> +
>  static const struct adis_data adis16240_data =3D {
>  	.write_delay =3D 35,
>  	.read_delay =3D 35,
> @@ -369,6 +375,7 @@ static const struct adis_data adis16240_data =3D {
>  	.self_test_mask =3D ADIS16240_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear =3D true,
>  	.startup_delay =3D ADIS16240_STARTUP_DELAY,
> +	.timeouts =3D &adis16240_timeouts,
> =20
>  	.status_error_msgs =3D adis16240_status_error_msgs,
>  	.status_error_mask =3D BIT(ADIS16240_DIAG_STAT_PWRON_FAIL_BIT) |
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 4b5bc0e06e69..853dc8c8365c 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -22,6 +22,17 @@
>  struct adis;
>  struct adis_burst;
> =20
> +/**
> + * struct adis_timeouts - ADIS chip variant timeouts
> + * @reset_ms - Wait time after rst pin goes inactive
> + * @sw_reset_ms - Wait time after sw reset command
> + * @self_test_ms - Wait time after self test command
> + */
> +struct adis_timeout {
> +	u16 reset_ms;
> +	u16 sw_reset_ms;
> +	u16 self_test_ms;
> +};
>  /**
>   * struct adis_data - ADIS chip variant specific data
>   * @read_delay: SPI delay for read operations in us
> @@ -32,6 +43,7 @@ struct adis_burst;
>   * @diag_stat_reg: Register address of the DIAG_STAT register
>   * @status_error_msgs: Array of error messgaes
>   * @status_error_mask:
> + * @timeouts: Chip specific delays
>   */
>  struct adis_data {
>  	unsigned int read_delay;
> @@ -45,6 +57,7 @@ struct adis_data {
>  	unsigned int self_test_mask;
>  	bool self_test_no_autoclear;
>  	unsigned int startup_delay;
> +	const struct adis_timeout *timeouts;
> =20
>  	const char * const *status_error_msgs;
>  	unsigned int status_error_mask;

