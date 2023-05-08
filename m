Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6696FA535
	for <lists+linux-iio@lfdr.de>; Mon,  8 May 2023 12:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjEHKHB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 May 2023 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjEHKG7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2023 06:06:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8D3AB4
        for <linux-iio@vger.kernel.org>; Mon,  8 May 2023 03:06:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso4890670e87.0
        for <linux-iio@vger.kernel.org>; Mon, 08 May 2023 03:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1683540415; x=1686132415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KpoE2VLnf1mKIeTB6E7g6TOHf8y+rt4lEFjnjBpyk4A=;
        b=Cbm//Y7JvvtjWrsf96UgRZUHOe2pHhURnK9iFvSR1dd83WyyJeBxXtfaiiChgq9nNq
         lOO/N4duaQdeXvT7ERys7pu8JzHruXuBBABfw3ZfxTPriQwjysU3mPLrsgD/Ct1nf+GM
         6WLO3UWQddXPzDVB9EOBMmMq5zyJUAG9zuVj4xhXz35DyWm2xcZmBAakUztD1mwURTRY
         HDtXXOYgEdITyKDmBE88iSXf2lZxn0jh0Rj8LUJGbkdILH+3BDxHVRin/Oc+HUsfrJdD
         qzJQBi9nPAnLovA+qp4lvvc0wbIUczvlhM6ggqb7g8BVMn/0joUabMJYF0OAluCMqblz
         L87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683540415; x=1686132415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpoE2VLnf1mKIeTB6E7g6TOHf8y+rt4lEFjnjBpyk4A=;
        b=BbTeCXE4ThCiqkji/HEkrY6HeTcFmZnKDsl3/1LbiogURwPmtomJIQnqRXLF28N3go
         5jp/NcYdxl1tvPCY7b7KMoSayVRTnZ6lnTqRs9qU8NZP9GNOmpTZt97Fpv07XDlw5BJP
         vpSvwsNXYmtwo3e38IASC0tM32k414nPr8OAYs2dsuOcDuoazVUK275++D33YqyX1mDU
         6eD4adlKVMLxTuxJXt/8/sqd6okd5XFqDmhLtrzCaIlzAbnbmBuaqXw59NfFKH61eYpy
         MzuMC/aall/XWK04IPFT71ojJt27rdtPZAHzASpu+Giuo6dkXnRd5tAN0pgi+fXT1xoZ
         Wr0A==
X-Gm-Message-State: AC+VfDwJ13BIcPBadrFziqk2clOeSweF76T2yBoGDjOEBdX73I1u2B6q
        9bDfRyzVsFVUqdIF0FMnctc/aZdfsIvetBZpvntoow==
X-Google-Smtp-Source: ACHHUZ4iE9LewJqahYiJDnFcFGlUiHkHhCA21UJBzgZ9P6lhilgQR51vYDTMClLZeE8BLJcgN+SODzTk2XvSIGVYRqI=
X-Received: by 2002:a19:c20d:0:b0:4f2:4419:932c with SMTP id
 l13-20020a19c20d000000b004f24419932cmr1124241lfc.23.1683540414747; Mon, 08
 May 2023 03:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230507184649.39290-1-marex@denx.de> <20230507184649.39290-4-marex@denx.de>
In-Reply-To: <20230507184649.39290-4-marex@denx.de>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 8 May 2023 12:06:18 +0200
Message-ID: <CAKv63utMHQnkKNNYDGmAb7CBYQswDy9CqAByMgyLC-0FKmKh2g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: mlx90614: Factor our register IO and
 constants into model specific descriptor
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I did some basic tests with this patch to ensure that 90614 still
reports data and that frequency can also be adjusted (and read back)
along with emissivity changes and reported values. I all works.

Thanks for your improvement of the driver.

Acked-by: Crt Mori <cmo@melexis.com> (not sure if reviewed by is
expected here as maintainer)
Tested-by: Crt Mori <cmo@melexis.com>

On Sun, 7 May 2023 at 20:47, Marek Vasut <marex@denx.de> wrote:
>
> Factor out all the differences between MLX90614 and other similar chips
> into a structure which describes the chip and allows abstracting out the
> differences from the driver code. No functional change.
>
> This patch moves all the RAM and EEPROM IO opcodes into the descriptor
> structure and combines them, instead of combining the opcode and offset
> in macros.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Crt Mori <cmo@melexis.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
> V2: New patch
> ---
>  drivers/iio/temperature/mlx90614.c | 183 +++++++++++++++++++----------
>  1 file changed, 124 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index b0f69a7b05abc..d6d2a5afaf8c0 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -25,6 +25,7 @@
>  #include <linux/i2c.h>
>  #include <linux/jiffies.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>
>  #include <linux/iio/iio.h>
> @@ -34,15 +35,6 @@
>  #define MLX90614_OP_EEPROM     0x20
>  #define MLX90614_OP_SLEEP      0xff
>
> -/* RAM offsets with 16-bit data, MSB first */
> -#define MLX90614_TA    (MLX90614_OP_RAM | 0x06) /* ambient temperature */
> -#define MLX90614_TOBJ1 (MLX90614_OP_RAM | 0x07) /* object 1 temperature */
> -#define MLX90614_TOBJ2 (MLX90614_OP_RAM | 0x08) /* object 2 temperature */
> -
> -/* EEPROM offsets with 16-bit data, MSB first */
> -#define MLX90614_EMISSIVITY    (MLX90614_OP_EEPROM | 0x04) /* emissivity correction coefficient */
> -#define MLX90614_CONFIG                (MLX90614_OP_EEPROM | 0x05) /* configuration register */
> -
>  /* Control bits in configuration register */
>  #define MLX90614_CONFIG_IIR_SHIFT 0 /* IIR coefficient */
>  #define MLX90614_CONFIG_IIR_MASK (0x7 << MLX90614_CONFIG_IIR_SHIFT)
> @@ -62,30 +54,45 @@
>  #define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin offset */
>  #define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
>  #define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
> -#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */
> -#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */
>  #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
>
> +/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#define field_prep(_mask, _val)        (((_val) << (ffs(_mask) - 1)) & (_mask))
> +
> +struct mlx_chip_info {
> +       /* EEPROM offsets with 16-bit data, MSB first */
> +       /* emissivity correction coefficient */
> +       u8                      op_eeprom_emissivity;
> +       u8                      op_eeprom_config1;
> +       /* RAM offsets with 16-bit data, MSB first */
> +       /* ambient temperature */
> +       u8                      op_ram_ta;
> +       /* object 1 temperature */
> +       u8                      op_ram_tobj1;
> +       /* object 2 temperature */
> +       u8                      op_ram_tobj2;
> +       u8                      op_sleep;
> +       /* support for two input channels (MLX90614 only) */
> +       u8                      dual_channel;
> +       u8                      wakeup_delay_ms;
> +       u16                     emissivity_max;
> +       u16                     emissivity_res;
> +       u16                     fir_config_mask;
> +       u16                     iir_config_mask;
> +       int                     iir_valid_offset;
> +       u16                     iir_values[8];
> +       int                     iir_freqs[8][2];
> +};
> +
>  struct mlx90614_data {
>         struct i2c_client *client;
>         struct mutex lock; /* for EEPROM access only */
>         struct gpio_desc *wakeup_gpio; /* NULL to disable sleep/wake-up */
> +       const struct mlx_chip_info *chip_info; /* Chip hardware details */
>         unsigned long ready_timestamp; /* in jiffies */
>  };
>
> -/* Bandwidth values for IIR filtering */
> -static const int mlx90614_iir_values[] = {77, 31, 20, 15, 723, 153, 110, 86};
> -static const int mlx90614_freqs[][2] = {
> -       {0, 150000},
> -       {0, 200000},
> -       {0, 310000},
> -       {0, 770000},
> -       {0, 860000},
> -       {1, 100000},
> -       {1, 530000},
> -       {7, 230000}
> -};
> -
>  /*
>   * Erase an address and write word.
>   * The mutex must be locked before calling.
> @@ -125,21 +132,26 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
>  }
>
>  /*
> - * Find the IIR value inside mlx90614_iir_values array and return its position
> + * Find the IIR value inside iir_values array and return its position
>   * which is equivalent to the bit value in sensor register
>   */
>  static inline s32 mlx90614_iir_search(const struct i2c_client *client,
>                                       int value)
>  {
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +       struct mlx90614_data *data = iio_priv(indio_dev);
> +       const struct mlx_chip_info *chip_info = data->chip_info;
>         int i;
>         s32 ret;
>
> -       for (i = 0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
> -               if (value == mlx90614_iir_values[i])
> +       for (i = chip_info->iir_valid_offset;
> +            i < ARRAY_SIZE(chip_info->iir_values);
> +            i++) {
> +               if (value == chip_info->iir_values[i])
>                         break;
>         }
>
> -       if (i == ARRAY_SIZE(mlx90614_iir_values))
> +       if (i == ARRAY_SIZE(chip_info->iir_values))
>                 return -EINVAL;
>
>         /*
> @@ -147,17 +159,21 @@ static inline s32 mlx90614_iir_search(const struct i2c_client *client,
>          * we must read them before we actually write
>          * changes
>          */
> -       ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
> +       ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
>         if (ret < 0)
>                 return ret;
>
> -       ret &= ~MLX90614_CONFIG_FIR_MASK;
> -       ret |= MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT;
> -       ret &= ~MLX90614_CONFIG_IIR_MASK;
> -       ret |= i << MLX90614_CONFIG_IIR_SHIFT;
> +       /* Modify FIR on parts which have configurable FIR filter */
> +       if (chip_info->fir_config_mask) {
> +               ret &= ~chip_info->fir_config_mask;
> +               ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
> +       }
> +
> +       ret &= ~chip_info->iir_config_mask;
> +       ret |= field_prep(chip_info->iir_config_mask, i);
>
>         /* Write changed values */
> -       ret = mlx90614_write_word(client, MLX90614_CONFIG, ret);
> +       ret = mlx90614_write_word(client, chip_info->op_eeprom_config1, ret);
>         return ret;
>  }
>
> @@ -217,22 +233,26 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>                             int *val2, long mask)
>  {
>         struct mlx90614_data *data = iio_priv(indio_dev);
> -       u8 cmd;
> +       const struct mlx_chip_info *chip_info = data->chip_info;
> +       u8 cmd, idx;
>         s32 ret;
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW: /* 0.02K / LSB */
>                 switch (channel->channel2) {
>                 case IIO_MOD_TEMP_AMBIENT:
> -                       cmd = MLX90614_TA;
> +                       cmd = chip_info->op_ram_ta;
>                         break;
>                 case IIO_MOD_TEMP_OBJECT:
> +                       if (chip_info->dual_channel && channel->channel)
> +                               return -EINVAL;
> +
>                         switch (channel->channel) {
>                         case 0:
> -                               cmd = MLX90614_TOBJ1;
> +                               cmd = chip_info->op_ram_tobj1;
>                                 break;
>                         case 1:
> -                               cmd = MLX90614_TOBJ2;
> +                               cmd = chip_info->op_ram_tobj2;
>                                 break;
>                         default:
>                                 return -EINVAL;
> @@ -264,26 +284,26 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>         case IIO_CHAN_INFO_SCALE:
>                 *val = MLX90614_CONST_SCALE;
>                 return IIO_VAL_INT;
> -       case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
> +       case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/emissivity_max / LSB */
>                 ret = mlx90614_power_get(data, false);
>                 if (ret < 0)
>                         return ret;
>
>                 mutex_lock(&data->lock);
>                 ret = i2c_smbus_read_word_data(data->client,
> -                                              MLX90614_EMISSIVITY);
> +                                              chip_info->op_eeprom_emissivity);
>                 mutex_unlock(&data->lock);
>                 mlx90614_power_put(data);
>
>                 if (ret < 0)
>                         return ret;
>
> -               if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
> +               if (ret == chip_info->emissivity_max) {
>                         *val = 1;
>                         *val2 = 0;
>                 } else {
>                         *val = 0;
> -                       *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
> +                       *val2 = ret * chip_info->emissivity_res;
>                 }
>                 return IIO_VAL_INT_PLUS_NANO;
>         case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
> @@ -293,16 +313,19 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>                         return ret;
>
>                 mutex_lock(&data->lock);
> -               ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
> +               ret = i2c_smbus_read_word_data(data->client,
> +                                              chip_info->op_eeprom_config1);
>                 mutex_unlock(&data->lock);
>                 mlx90614_power_put(data);
>
>                 if (ret < 0)
>                         return ret;
>
> -               *val = mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK] / 100;
> -               *val2 = (mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK] % 100) *
> -                       10000;
> +               idx = field_get(chip_info->iir_config_mask, ret) -
> +                     chip_info->iir_valid_offset;
> +
> +               *val = chip_info->iir_values[idx] / 100;
> +               *val2 = (chip_info->iir_values[idx] % 100) * 10000;
>                 return IIO_VAL_INT_PLUS_MICRO;
>         default:
>                 return -EINVAL;
> @@ -314,22 +337,23 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>                              int val2, long mask)
>  {
>         struct mlx90614_data *data = iio_priv(indio_dev);
> +       const struct mlx_chip_info *chip_info = data->chip_info;
>         s32 ret;
>
>         switch (mask) {
> -       case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
> +       case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/emissivity_max / LSB */
>                 if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 != 0))
>                         return -EINVAL;
> -               val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
> -                       val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
> +               val = val * chip_info->emissivity_max +
> +                     val2 / chip_info->emissivity_res;
>
>                 ret = mlx90614_power_get(data, false);
>                 if (ret < 0)
>                         return ret;
>
>                 mutex_lock(&data->lock);
> -               ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY,
> -                                         val);
> +               ret = mlx90614_write_word(data->client,
> +                                         chip_info->op_eeprom_emissivity, val);
>                 mutex_unlock(&data->lock);
>                 mlx90614_power_put(data);
>
> @@ -373,11 +397,15 @@ static int mlx90614_read_avail(struct iio_dev *indio_dev,
>                                const int **vals, int *type, int *length,
>                                long mask)
>  {
> +       struct mlx90614_data *data = iio_priv(indio_dev);
> +       const struct mlx_chip_info *chip_info = data->chip_info;
> +
>         switch (mask) {
>         case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -               *vals = (int *)mlx90614_freqs;
> +               *vals = (int *)chip_info->iir_freqs;
>                 *type = IIO_VAL_INT_PLUS_MICRO;
> -               *length = 2 * ARRAY_SIZE(mlx90614_freqs);
> +               *length = 2 * (ARRAY_SIZE(chip_info->iir_freqs) -
> +                              chip_info->iir_valid_offset);
>                 return IIO_AVAIL_LIST;
>         default:
>                 return -EINVAL;
> @@ -431,6 +459,7 @@ static const struct iio_info mlx90614_info = {
>  #ifdef CONFIG_PM
>  static int mlx90614_sleep(struct mlx90614_data *data)
>  {
> +       const struct mlx_chip_info *chip_info = data->chip_info;
>         s32 ret;
>
>         if (!data->wakeup_gpio) {
> @@ -443,7 +472,7 @@ static int mlx90614_sleep(struct mlx90614_data *data)
>         mutex_lock(&data->lock);
>         ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
>                              data->client->flags | I2C_CLIENT_PEC,
> -                            I2C_SMBUS_WRITE, MLX90614_OP_SLEEP,
> +                            I2C_SMBUS_WRITE, chip_info->op_sleep,
>                              I2C_SMBUS_BYTE, NULL);
>         mutex_unlock(&data->lock);
>
> @@ -452,6 +481,8 @@ static int mlx90614_sleep(struct mlx90614_data *data)
>
>  static int mlx90614_wakeup(struct mlx90614_data *data)
>  {
> +       const struct mlx_chip_info *chip_info = data->chip_info;
> +
>         if (!data->wakeup_gpio) {
>                 dev_dbg(&data->client->dev, "Wake-up disabled");
>                 return -ENOSYS;
> @@ -461,7 +492,7 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
>
>         i2c_lock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
>         gpiod_direction_output(data->wakeup_gpio, 0);
> -       msleep(MLX90614_TIMING_WAKEUP);
> +       msleep(chip_info->wakeup_delay_ms);
>         gpiod_direction_input(data->wakeup_gpio);
>         i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
>
> @@ -474,7 +505,7 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
>          * If the read fails, the controller will probably be reset so that
>          * further reads will work.
>          */
> -       i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
> +       i2c_smbus_read_word_data(data->client, chip_info->op_eeprom_config1);
>
>         return 0;
>  }
> @@ -523,9 +554,15 @@ static inline struct gpio_desc *mlx90614_probe_wakeup(struct i2c_client *client)
>  /* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
>  static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
>  {
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +       struct mlx90614_data *data = iio_priv(indio_dev);
> +       const struct mlx_chip_info *chip_info = data->chip_info;
>         s32 ret;
>
> -       ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
> +       if (chip_info->dual_channel)
> +               return 0;
> +
> +       ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
>
>         if (ret < 0)
>                 return ret;
> @@ -552,6 +589,7 @@ static int mlx90614_probe(struct i2c_client *client)
>         data->client = client;
>         mutex_init(&data->lock);
>         data->wakeup_gpio = mlx90614_probe_wakeup(client);
> +       data->chip_info = device_get_match_data(&client->dev);
>
>         mlx90614_wakeup(data);
>
> @@ -601,14 +639,41 @@ static void mlx90614_remove(struct i2c_client *client)
>         }
>  }
>
> +static const struct mlx_chip_info mlx90614_chip_info = {
> +       .op_eeprom_emissivity           = MLX90614_OP_EEPROM | 0x04,
> +       .op_eeprom_config1              = MLX90614_OP_EEPROM | 0x05,
> +       .op_ram_ta                      = MLX90614_OP_RAM | 0x06,
> +       .op_ram_tobj1                   = MLX90614_OP_RAM | 0x07,
> +       .op_ram_tobj2                   = MLX90614_OP_RAM | 0x08,
> +       .op_sleep                       = MLX90614_OP_SLEEP,
> +       .dual_channel                   = true,
> +       .wakeup_delay_ms                = MLX90614_TIMING_WAKEUP,
> +       .emissivity_max                 = 65535,
> +       .emissivity_res                 = 1000000000 / 65535,
> +       .fir_config_mask                = MLX90614_CONFIG_FIR_MASK,
> +       .iir_config_mask                = MLX90614_CONFIG_IIR_MASK,
> +       .iir_valid_offset               = 0,
> +       .iir_values                     = { 77, 31, 20, 15, 723, 153, 110, 86 },
> +       .iir_freqs                      = {
> +               { 0, 150000 },  /* 13% ~= 0.15 Hz */
> +               { 0, 200000 },  /* 17% ~= 0.20 Hz */
> +               { 0, 310000 },  /* 25% ~= 0.31 Hz */
> +               { 0, 770000 },  /* 50% ~= 0.77 Hz */
> +               { 0, 860000 },  /* 57% ~= 0.86 Hz */
> +               { 1, 100000 },  /* 67% ~= 1.10 Hz */
> +               { 1, 530000 },  /* 80% ~= 1.53 Hz */
> +               { 7, 230000 }   /* 100% ~= 7.23 Hz */
> +       },
> +};
> +
>  static const struct i2c_device_id mlx90614_id[] = {
> -       { "mlx90614", 0 },
> +       { "mlx90614", .driver_data = (kernel_ulong_t)&mlx90614_chip_info },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, mlx90614_id);
>
>  static const struct of_device_id mlx90614_of_match[] = {
> -       { .compatible = "melexis,mlx90614" },
> +       { .compatible = "melexis,mlx90614", .data = &mlx90614_chip_info },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, mlx90614_of_match);
> --
> 2.39.2
>
