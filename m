Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3553D55B275
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 16:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiFZO3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiFZO3l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 10:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C5DF4A;
        Sun, 26 Jun 2022 07:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBF2861255;
        Sun, 26 Jun 2022 14:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889A7C34114;
        Sun, 26 Jun 2022 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656253779;
        bh=bH3usP7pZbcRTm6go50AOVwKzM+HofK+c3akIXH9cGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=afYOZjNnlFt/mOedeOf6EEWpxaBTMgjGKLrDgRVKf0m5GOA4sReNkqhronkCkshiq
         LqCBsmQaTh8O6AShooWUWJwpNEwBIR8+2HkTqZ+rZuU+nGy7HCVar9SUAJ1BPYcy19
         M4vA+dfomeT5iTqMhYLefelwIoyA4GTYj/KGAlosHAIIXlAihx0axwQLfHzIfNvd6j
         4YK50mB9tRgJITx7pAAMknp0ju94PXnqMhcTTYPo04cTyS43nI7ac6kt9gLuhFEHrc
         TP/X6diUMqXE3DZroTOi9e4G/VxG9rFsM7xzlNAZgEEEpgXqEtCnlWSaBIC+FieNNb
         RjBxN/+fvVVGg==
Date:   Sun, 26 Jun 2022 15:39:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: pressure: bmp280: Adds more tunable config
 parameters for BMP380
Message-ID: <20220626153908.5b71d2ac@jic23-huawei>
In-Reply-To: <20220625151039.48148-1-ang.iglesiasg@gmail.com>
References: <20220625151039.48148-1-ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Jun 2022 17:10:36 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Allows to configure the IIR filter coefficient and the sampling frequency
> The IIR filter coefficient is exposed using the sysfs attribute
> "filter_low_pass_3db_frequency"
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Hi Angel

A few comments inline,
> ---
>  drivers/iio/pressure/bmp280-core.c | 168 ++++++++++++++++++++++++++++-
>  drivers/iio/pressure/bmp280.h      |  18 ----
>  2 files changed, 166 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 3887475a9059..3d22fc844e87 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -96,6 +96,27 @@ static const char *const bmp280_supply_names[] = {
>  	"vddd", "vdda"
>  };
>  
> +enum bmp380_odr {
> +	BMP380_ODR_200HZ,
> +	BMP380_ODR_100HZ,
> +	BMP380_ODR_50HZ,
> +	BMP380_ODR_25HZ,
> +	BMP380_ODR_12_5HZ,
> +	BMP380_ODR_6_25HZ,
> +	BMP380_ODR_3_125HZ,
> +	BMP380_ODR_1_5625HZ,
> +	BMP380_ODR_0_78HZ,
> +	BMP380_ODR_0_39HZ,
> +	BMP380_ODR_0_2HZ,
> +	BMP380_ODR_0_1HZ,
> +	BMP380_ODR_0_05HZ,
> +	BMP380_ODR_0_02HZ,
> +	BMP380_ODR_0_01HZ,
> +	BMP380_ODR_0_006HZ,
> +	BMP380_ODR_0_003HZ,
> +	BMP380_ODR_0_0015HZ
> +};
> +
>  #define BMP280_NUM_SUPPLIES ARRAY_SIZE(bmp280_supply_names)
>  
>  struct bmp280_data {
> @@ -117,6 +138,16 @@ struct bmp280_data {
>  	u8 oversampling_press;
>  	u8 oversampling_temp;
>  	u8 oversampling_humid;
> +	u8 iir_filter_coeff;
> +
> +	/* BMP380 devices introduce sampling frequecy configuration. See
> +	 * datasheet sections 3.3.3. and 4.3.19.
> +	 *
> +	 * BMx280 devices allowed indirect configuration of sampling frequency
> +	 * changing the t_standby duration between measurements. See datasheet
> +	 * section 3.6.3
> +	 */
> +	int sampling_freq;
>  
>  	/*
>  	 * Carryover value from temperature conversion, used in pressure
> @@ -135,6 +166,12 @@ struct bmp280_chip_info {
>  	const int *oversampling_humid_avail;
>  	int num_oversampling_humid_avail;
>  
> +	const int *iir_filter_coeffs_avail;
> +	int num_iir_filter_coeffs_avail;
> +
> +	const int (*sampling_freq_avail)[2];
> +	int num_sampling_freq_avail;
> +
>  	int (*chip_config)(struct bmp280_data *);
>  	int (*read_temp)(struct bmp280_data *, int *);
>  	int (*read_press)(struct bmp280_data *, int *, int *);
> @@ -185,6 +222,30 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  	},
>  };
>  
> +static const struct iio_chan_spec bmp380_channels[] = {
> +	{
> +		.type = IIO_PRESSURE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +	},
> +};
> +
>  static int bmp280_read_calib(struct bmp280_data *data,
>  			     struct bmp280_calib *calib,
>  			     unsigned int chip)
> @@ -514,6 +575,15 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
This is currently safe, but given sampling_freq_avail is only present for one device type,
I'd prefer a sanity check that it is not NULL.

> +		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*val = data->chip_info->iir_filter_coeffs_avail[data->iir_filter_coeff];
> +		ret = IIO_VAL_INT;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -577,6 +647,39 @@ static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
>  	return -EINVAL;
>  }
>  
> +static int bmp280_write_sampling_frequency(struct bmp280_data *data,
> +					   int val, int val2)
> +{
> +	int i;
> +	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
> +	const int n = data->chip_info->num_sampling_freq_avail;
> +
> +	for (i = 0; i < n; i++) {
> +		if (avail[i][0] == val && avail[i][1] == val2) {
> +			data->sampling_freq = i;
better to only set the cached value if the write succeeds.

e.g.
			ret = data->chip_info->chip_config(data);
			if (ret)
				return ret;

			data->sampling_freq = i;

			return 0;
> +
> +			return data->chip_info->chip_config(data);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
> +{
> +	int i;
> +	const int *avail = data->chip_info->iir_filter_coeffs_avail;
> +	const int n = data->chip_info->num_iir_filter_coeffs_avail;
> +
> +	for (i = 0; i < n; i++) {
> +		if (avail[i] == val) {
> +			data->iir_filter_coeff = i;
> +
As for previous function, set the cached value only after you know the write
succeeded.

> +			return data->chip_info->chip_config(data);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
>  static int bmp280_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val, int val2, long mask)
> @@ -606,6 +709,22 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
>  		pm_runtime_mark_last_busy(data->dev);
>  		pm_runtime_put_autosuspend(data->dev);
>  		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		pm_runtime_get_sync(data->dev);
> +		mutex_lock(&data->lock);
> +		ret = bmp280_write_sampling_frequency(data, val, val2);
> +		mutex_unlock(&data->lock);
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
> +		break;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		pm_runtime_get_sync(data->dev);
> +		mutex_lock(&data->lock);
> +		ret = bmp280_write_iir_filter_coeffs(data, val);
> +		mutex_unlock(&data->lock);
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -636,6 +755,17 @@ static int bmp280_read_avail(struct iio_dev *indio_dev,
>  		}
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (const int *)data->chip_info->sampling_freq_avail;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		/* Values are stored in a 2D matrix */
> +		*length = data->chip_info->num_sampling_freq_avail;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = data->chip_info->iir_filter_coeffs_avail;
> +		*type = IIO_VAL_INT;
> +		*length = data->chip_info->num_iir_filter_coeffs_avail;
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -749,7 +879,7 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
>  		goto failure;
>  	}
>  	/* wait for 2ms for command to be proccessed */
> -	usleep_range(2000, 2500);
> +	usleep_range(data->start_up_time, data->start_up_time + 100);
>  	/* check for command processing error */
>  	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
>  	if (ret) {
> @@ -943,6 +1073,27 @@ static int bmp380_read_calib(struct bmp280_data *data,
>  	return 0;
>  }
>  
> +static const int bmp380_odr_table[][2] = {
> +	[BMP380_ODR_200HZ]	= {200, 0},
> +	[BMP380_ODR_100HZ]	= {100, 0},
> +	[BMP380_ODR_50HZ]	= {50, 0},
> +	[BMP380_ODR_25HZ]	= {25, 0},
> +	[BMP380_ODR_12_5HZ]	= {12, 500000},
> +	[BMP380_ODR_6_25HZ]	= {6, 250000},
> +	[BMP380_ODR_3_125HZ]	= {3, 125000},
> +	[BMP380_ODR_1_5625HZ]	= {1, 562500},
> +	[BMP380_ODR_0_78HZ]	= {0, 781250},
> +	[BMP380_ODR_0_39HZ]	= {0, 390625},
> +	[BMP380_ODR_0_2HZ]	= {0, 195313},
> +	[BMP380_ODR_0_1HZ]	= {0, 97656},
> +	[BMP380_ODR_0_05HZ]	= {0, 48828},
> +	[BMP380_ODR_0_02HZ]	= {0, 24414},
> +	[BMP380_ODR_0_01HZ]	= {0, 12207},
> +	[BMP380_ODR_0_006HZ]	= {0, 6104},
> +	[BMP380_ODR_0_003HZ]	= {0, 3052},
> +	[BMP380_ODR_0_0015HZ]	= {0, 1526},
> +};
> +
>  static int bmp380_chip_config(struct bmp280_data *data)
>  {
>  	u8 osrs;
> @@ -976,7 +1127,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  
>  	/* configure output data rate */
>  	ret = regmap_write_bits(data->regmap, BMP380_REG_ODR,
> -				BMP380_ODRS_MASK, BMP380_ODRS_50HZ);
> +				BMP380_ODRS_MASK, data->sampling_freq);
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to write ODR selection register\n");
>  		return ret;
> @@ -990,6 +1141,9 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  		return ret;
>  	}
>  
> +	/* startup time wait to verify config */
> +	usleep_range(data->start_up_time, data->start_up_time + 100);
> +

Only necessary now?  Or is this a fix for what was here before?

>  	/* check config error flag */
>  	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
>  	if (ret < 0) {
> @@ -1007,6 +1161,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  }
>  
>  static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
> +static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };
>  
>  static const struct bmp280_chip_info bmp380_chip_info = {
>  	.oversampling_temp_avail = bmp380_oversampling_avail,
> @@ -1015,6 +1170,12 @@ static const struct bmp280_chip_info bmp380_chip_info = {
>  	.oversampling_press_avail = bmp380_oversampling_avail,
>  	.num_oversampling_press_avail = ARRAY_SIZE(bmp380_oversampling_avail),
>  
> +	.sampling_freq_avail = bmp380_odr_table,
> +	.num_sampling_freq_avail = ARRAY_SIZE(bmp380_odr_table) * 2,
> +
> +	.iir_filter_coeffs_avail = bmp380_iir_filter_coeffs_avail,
> +	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
> +
>  	.chip_config = bmp380_chip_config,
>  	.read_temp = bmp380_read_temp,
>  	.read_press = bmp380_read_press,
> @@ -1369,9 +1530,12 @@ int bmp280_common_probe(struct device *dev,
>  		break;
>  	case BMP380_CHIP_ID:
>  		indio_dev->num_channels = 2;
> +		indio_dev->channels = bmp380_channels;
>  		data->chip_info = &bmp380_chip_info;
>  		data->oversampling_press = ilog2(4);
>  		data->oversampling_temp = ilog2(1);
> +		data->iir_filter_coeff = 2;
> +		data->sampling_freq = BMP380_ODR_50HZ;
>  		data->start_up_time = 2000;
>  		break;
>  	default:
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index b4c122525ffe..f9e21546957e 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -71,24 +71,6 @@
>  #define BMP380_OSRS_PRESS_32X		BMP380_OSRS_PRESS_X(5)
>  
>  #define BMP380_ODRS_MASK		GENMASK(4, 0)
> -#define BMP380_ODRS_200HZ		0x00
> -#define BMP380_ODRS_100HZ		0x01
> -#define BMP380_ODRS_50HZ		0x02
> -#define BMP380_ODRS_25HZ		0x03
> -#define BMP380_ODRS_12_5HZ		0x04
> -#define BMP380_ODRS_6_25HZ		0x05
> -#define BMP380_ODRS_3_1HZ		0x06
> -#define BMP380_ODRS_1_5HZ		0x07
> -#define BMP380_ODRS_0_78HZ		0x08
> -#define BMP380_ODRS_0_39HZ		0x09
> -#define BMP380_ODRS_0_2HZ		0x0A
> -#define BMP380_ODRS_0_1HZ		0x0B
> -#define BMP380_ODRS_0_05HZ		0x0C
> -#define BMP380_ODRS_0_02HZ		0x0D
> -#define BMP380_ODRS_0_01HZ		0x0E
> -#define BMP380_ODRS_0_006HZ		0x0F
> -#define BMP380_ODRS_0_003HZ		0x10
> -#define BMP380_ODRS_0_0015HZ		0x11
>  
>  #define BMP380_CTRL_SENSORS_MASK	GENMASK(1, 0)
>  #define BMP380_CTRL_SENSORS_PRESS_EN	BIT(0)

