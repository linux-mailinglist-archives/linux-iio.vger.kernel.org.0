Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9950B243917
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 13:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMLG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 07:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMLGY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 07:06:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CFAC061757;
        Thu, 13 Aug 2020 04:06:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so2611588pjb.4;
        Thu, 13 Aug 2020 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPhpd7luL94KzHRS86zkcCFc1rMkDrTRDbwwKaZlIr0=;
        b=coefxy7rJiBGW9H3ndOX4j9Prx5AArQ8dEXN4sX1UWmvaeXpqNZZaCzY5qoRHvapSK
         9279RQhioK0NNwjLnEhxjnW4jw6/Bt2BUQYXPlrIfyUwqzMJQeCccQjVf3MyeMfTOjfF
         cT9DtQlu01l/T1Jn8afrhaOS3ym1TpZrABmACnQj/NOOeUc5u8Arcu7JAGMibXTvAudv
         g1CB7qjdgpi2buHqqh6lEFXwVDwj8XcAs7UEeGk4olIxZP2FSR0tu9mBm7JCR9nD8Rmx
         7icC5b3pfORncWTqEt0WRDcKjsDU3k99AdnHbB51KHchIBDBwSuiD/Z5x629+8w2TsPz
         D6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPhpd7luL94KzHRS86zkcCFc1rMkDrTRDbwwKaZlIr0=;
        b=sP6rvkY8eZJvMKYInY7zfq9XUG59A4Iq4Rck/4Es12IzjQA3Lkn9yfqYizWe2llWA5
         1blFt0EWOiTG/CwKKqf7yPB7oF1ouNUdEu4Y8ZcA0j3C2c7eiKb31a87OCrDDHQyhd/T
         yO36fFRfH2iwMnhpoOnoHfwkUgOY7h6jdUsA50PFweN+7ZCGTDop8pmTfc/eS+As2ZVn
         2C1Y8roqeZVNk3sfgdvJbqgmRq3tEHcpSURQ6WePM5BT5GhOVmRNI5Pmw8IrU50rf7XV
         0NjQYoEuOx3UO4OjeUxY20P5hecfUkfrfRSnbG+vuewYVzTI1LqKwR2/nCS17jV8mrlY
         jMyQ==
X-Gm-Message-State: AOAM532hAUQqIibYDGFPCcNzAamynUjv3TKXieq7plEq1wLMHpvZ2IGk
        xqp/1pvyLGjKNv1rUWXCPGhrXmubM7Wg/hyAG7dpDTMXsvQugg==
X-Google-Smtp-Source: ABdhPJzUMtjNVZJJysKA0Y6XPA4W3zoRb2JjU3HQ0NN7jYAfUsyi7J46lVJv/j6QF/O+ehpRFyCWRb2iCU0YxOtP+ck=
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr4657607pjb.129.1597316783993;
 Thu, 13 Aug 2020 04:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-5-cmo@melexis.com>
In-Reply-To: <20200813075125.4949-5-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Aug 2020 14:06:07 +0300
Message-ID: <CAHp75VcTm_9_TGwz0LC-p3MU1UPSP_R-gL75P_p26tfMdOjtiA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] iio:temperature:mlx90632: Adding extended
 calibration option
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
>
> For some time the market wants medical grade accuracy in medical range,
> while still retaining the declared accuracy outside of the medical range
> within the same sensor. That is why we created extended calibration
> which is automatically switched to when object temperature is too high.
>
> This patch also introduces the object_ambient_temperature variable which
> is needed for more accurate calculation of the object infra-red
> footprint as sensor's ambient temperature might be totally different
> than what the ambient temperature is at object and that is why we can
> have some more errors which can be eliminated. Currently this temperature
> is fixed at 25, but the interface to adjust it by user (with external
> sensor or just IR measurement of the other object which acts as ambient),
> will be introduced in another commit.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 224 ++++++++++++++++++++++++++++-
>  1 file changed, 222 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index d87c792b7e72..9fa8c078c037 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -11,6 +11,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> +#include <linux/limits.h>
>  #include <linux/module.h>
>  #include <linux/math64.h>
>  #include <linux/of.h>
> @@ -58,6 +59,8 @@
>  /* Control register address - volatile */
>  #define MLX90632_REG_CONTROL   0x3001 /* Control Register address */
>  #define   MLX90632_CFG_PWR_MASK                GENMASK(2, 1) /* PowerMode Mask */
> +#define   MLX90632_CFG_MTYP_MASK               GENMASK(8, 4) /* Meas select Mask */
> +
>  /* PowerModes statuses */
>  #define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
>  #define MLX90632_PWR_STATUS_HALT MLX90632_PWR_STATUS(0) /* hold */
> @@ -65,6 +68,18 @@
>  #define MLX90632_PWR_STATUS_STEP MLX90632_PWR_STATUS(2) /* step */
>  #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
>
> +/* Measurement types */
> +#define MLX90632_MTYP_MEDICAL 0
> +#define MLX90632_MTYP_EXTENDED 17
> +
> +/* Measurement type select*/
> +#define MLX90632_MTYP_STATUS(ctrl_val) (ctrl_val << 4)
> +#define MLX90632_MTYP_STATUS_MEDICAL MLX90632_MTYP_STATUS(MLX90632_MTYP_MEDICAL)
> +#define MLX90632_MTYP_STATUS_EXTENDED MLX90632_MTYP_STATUS(MLX90632_MTYP_EXTENDED)
> +
> +/* I2C command register - volatile */
> +#define MLX90632_REG_I2C_CMD    0x3005 /* I2C command Register address */
> +
>  /* Device status register - volatile */
>  #define MLX90632_REG_STATUS    0x3fff /* Device status register */
>  #define   MLX90632_STAT_BUSY           BIT(10) /* Device busy indicator */
> @@ -78,9 +93,21 @@
>  #define MLX90632_RAM_2(meas_num)       (MLX90632_ADDR_RAM + 3 * meas_num + 1)
>  #define MLX90632_RAM_3(meas_num)       (MLX90632_ADDR_RAM + 3 * meas_num + 2)
>
> +/* Name important RAM_MEAS channels */
> +#define MLX90632_RAM_DSP5_EXTENDED_AMBIENT_1 MLX90632_RAM_3(17)
> +#define MLX90632_RAM_DSP5_EXTENDED_AMBIENT_2 MLX90632_RAM_3(18)
> +#define MLX90632_RAM_DSP5_EXTENDED_OBJECT_1 MLX90632_RAM_1(17)
> +#define MLX90632_RAM_DSP5_EXTENDED_OBJECT_2 MLX90632_RAM_2(17)
> +#define MLX90632_RAM_DSP5_EXTENDED_OBJECT_3 MLX90632_RAM_1(18)
> +#define MLX90632_RAM_DSP5_EXTENDED_OBJECT_4 MLX90632_RAM_2(18)
> +#define MLX90632_RAM_DSP5_EXTENDED_OBJECT_5 MLX90632_RAM_1(19)
> +#define MLX90632_RAM_DSP5_EXTENDED_OBJECT_6 MLX90632_RAM_2(19)
> +
>  /* Magic constants */
>  #define MLX90632_ID_MEDICAL    0x0105 /* EEPROM DSPv5 Medical device id */
>  #define MLX90632_ID_CONSUMER   0x0205 /* EEPROM DSPv5 Consumer device id */
> +#define MLX90632_ID_EXTENDED   0x0505 /* EEPROM DSPv5 Extended range device id */
> +#define MLX90632_ID_MASK       GENMASK(14, 0) /* DSP version and device ID in EE_VERSION */
>  #define MLX90632_DSP_VERSION   5 /* DSP version */
>  #define MLX90632_DSP_MASK      GENMASK(7, 0) /* DSP version in EE_VERSION */
>  #define MLX90632_RESET_CMD     0x0006 /* Reset sensor (address or global) */
> @@ -88,6 +115,7 @@
>  #define MLX90632_REF_3         12LL /**< ResCtrlRef value of Channel 3 */
>  #define MLX90632_MAX_MEAS_NUM  31 /**< Maximum measurements in list */
>  #define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
> +#define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
>
>  /**
>   * struct mlx90632_data - private data for the MLX90632 device
> @@ -95,16 +123,23 @@
>   * @lock: Internal mutex for multiple reads for single measurement
>   * @regmap: Regmap of the device
>   * @emissivity: Object emissivity from 0 to 1000 where 1000 = 1.
> + * @mtyp: Measurement type physical sensor configuration for extended range
> + *        calculations
> + * @object_ambient_temperature: Ambient temperature at object (might differ of
> + *                              the ambient temperature of sensor.
>   */
>  struct mlx90632_data {
>         struct i2c_client *client;
>         struct mutex lock;
>         struct regmap *regmap;
>         u16 emissivity;
> +       u8 mtyp;
> +       u32 object_ambient_temperature;
>  };
>
>  static const struct regmap_range mlx90632_volatile_reg_range[] = {
>         regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
> +       regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
>         regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
>         regmap_reg_range(MLX90632_RAM_1(0),
>                          MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
> @@ -120,6 +155,7 @@ static const struct regmap_range mlx90632_read_reg_range[] = {
>         regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
>         regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
>         regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
> +       regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
>         regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
>         regmap_reg_range(MLX90632_RAM_1(0),
>                          MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
> @@ -204,6 +240,26 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
>         return (reg_status & MLX90632_STAT_CYCLE_POS) >> 2;
>  }
>
> +static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
> +{
> +       int ret;
> +
> +       if ((type != MLX90632_MTYP_MEDICAL) && (type != MLX90632_MTYP_EXTENDED))
> +               return -EINVAL;
> +
> +       ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> +                                (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
> +                                (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
> +       if (ret < 0)
> +               return ret;
> +
> +       return mlx90632_pwr_continuous(regmap);
> +}
> +
>  static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
>                                        uint8_t *channel_old)
>  {
> @@ -305,6 +361,104 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>         return ret;
>  }
>
> +static int mlx90632_read_ambient_raw_extended(struct regmap *regmap,
> +                                             s16 *ambient_new_raw, s16 *ambient_old_raw)
> +{
> +       unsigned int read_tmp;
> +       int ret;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_DSP5_EXTENDED_AMBIENT_1, &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       *ambient_new_raw = (s16)read_tmp;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_DSP5_EXTENDED_AMBIENT_2, &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       *ambient_old_raw = (s16)read_tmp;
> +
> +       return 0;
> +}
> +
> +static int mlx90632_read_object_raw_extended(struct regmap *regmap, s16 *object_new_raw)
> +{
> +       unsigned int read_tmp;
> +       s32 read;
> +       int ret;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_DSP5_EXTENDED_OBJECT_1, &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       read = (s16)read_tmp;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_DSP5_EXTENDED_OBJECT_2, &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       read = read - (s16)read_tmp;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_DSP5_EXTENDED_OBJECT_3, &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       read = read - (s16)read_tmp;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_DSP5_EXTENDED_OBJECT_4, &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       read = (read + (s16)read_tmp) / 2;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_DSP5_EXTENDED_OBJECT_5, &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       read = read + (s16)read_tmp;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_DSP5_EXTENDED_OBJECT_6, &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       read = read + (s16)read_tmp;
> +
> +       if (read > S16_MAX || read < S16_MIN)
> +               return -ERANGE;
> +
> +       *object_new_raw = read;
> +
> +       return 0;
> +}
> +
> +static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *object_new_raw,
> +                                             s16 *ambient_new_raw, s16 *ambient_old_raw)
> +{
> +       int tries = 4;
> +       int ret;
> +
> +       mutex_lock(&data->lock);
> +       ret = mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_EXTENDED);
> +       if (ret < 0)
> +               goto read_unlock;
> +
> +       do {
> +               ret = mlx90632_perform_measurement(data);
> +               if (ret < 0)
> +                       goto read_unlock;
> +       } while ((ret != 19) && tries--);
> +
> +       if (tries < 0) {
> +               ret = -ETIMEDOUT;
> +               goto read_unlock;
> +       }
> +
> +       ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
> +       if (ret < 0)
> +               goto read_unlock;
> +
> +       ret = mlx90632_read_ambient_raw_extended(data->regmap, ambient_new_raw, ambient_old_raw);
> +
> +read_unlock:
> +       (void) mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_MEDICAL);
> +
> +       mutex_unlock(&data->lock);
> +       return ret;
> +}
> +
>  static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
>                                      s32 *reg_value)
>  {
> @@ -359,9 +513,23 @@ static s64 mlx90632_preprocess_temp_obj(s16 object_new_raw, s16 object_old_raw,
>         return div64_s64((tmp << 19ULL), 1000LL);
>  }
>
> +static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
> +                                                s16 ambient_old_raw, s16 Ka)
> +{
> +       s64 VR_IR, kKa, tmp;
> +
> +       kKa = ((s64)Ka * 1000LL) >> 10ULL;
> +       VR_IR = (s64)ambient_old_raw * 1000000LL +
> +               kKa * div64_s64((s64)ambient_new_raw * 1000LL,
> +                               MLX90632_REF_3);
> +       tmp = div64_s64(
> +                       div64_s64((s64) object_new_raw * 1000000000000LL, MLX90632_REF_12),
> +                       VR_IR);
> +       return div64_s64(tmp << 19ULL, 1000LL);
> +}
> +
>  static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
> -                                     s32 P_T, s32 P_R, s32 P_G, s32 P_O,
> -                                     s16 Gb)
> +                                     s32 P_T, s32 P_R, s32 P_G, s32 P_O, s16 Gb)
>  {
>         s64 Asub, Bsub, Ablock, Bblock, Cblock, AMB, sum;
>
> @@ -433,6 +601,31 @@ static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
>         return temp;
>  }
>
> +static s32 mlx90632_calc_temp_object_extended(s64 object, s64 ambient, s64 reflected,
> +                                             s32 Ea, s32 Eb, s32 Fa, s32 Fb, s32 Ga,
> +                                             s16 Ha, s16 Hb, u16 tmp_emi)
> +{
> +       s64 kTA, kTA0, TAdut, TAdut4, Tr4, TaTr4;
> +       s64 temp = 25000;
> +       s8 i;
> +
> +       kTA = (Ea * 1000LL) >> 16LL;
> +       kTA0 = (Eb * 1000LL) >> 8LL;
> +       TAdut = div64_s64((ambient - kTA0) * 1000000LL, kTA) + 25 * 1000000LL;
> +       Tr4 = mlx90632_calc_ta4(reflected, 10);
> +       TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
> +       TaTr4 = Tr4 - div64_s64(Tr4 - TAdut4, tmp_emi) * 1000;
> +
> +       /* Iterations of calculation as described in datasheet */
> +       for (i = 0; i < 5; ++i) {
> +               temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TaTr4,
> +                                                          Fa / 2, Fb, Ga, Ha, Hb,
> +                                                          tmp_emi);
> +       }
> +
> +       return temp;
> +}
> +
>  static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
>  {
>         s32 ret;
> @@ -480,6 +673,26 @@ static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
>         if (ret < 0)
>                 return ret;
>
> +       if (object_new_raw > MLX90632_EXTENDED_LIMIT &&
> +           data->mtyp == MLX90632_MTYP_EXTENDED) {
> +               ret = mlx90632_read_all_channel_extended(data, &object_new_raw,
> +                                                        &ambient_new_raw, &ambient_old_raw);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* Use extended mode calculations */
> +               ambient = mlx90632_preprocess_temp_amb(ambient_new_raw,
> +                                                      ambient_old_raw, Gb);
> +               object = mlx90632_preprocess_temp_obj_extended(object_new_raw,
> +                                                              ambient_new_raw,
> +                                                              ambient_old_raw, Ka);
> +               *val = mlx90632_calc_temp_object_extended(object, ambient,
> +                                                         data->object_ambient_temperature,
> +                                                         Ea, Eb, Fa, Fb, Ga,
> +                                                         Ha, Hb, data->emissivity);
> +               return 0;
> +       }
> +
>         ambient = mlx90632_preprocess_temp_amb(ambient_new_raw,
>                                                ambient_old_raw, Gb);
>         object = mlx90632_preprocess_temp_obj(object_new_raw,
> @@ -653,6 +866,7 @@ static int mlx90632_probe(struct i2c_client *client,
>         i2c_set_clientdata(client, indio_dev);
>         mlx90632->client = client;
>         mlx90632->regmap = regmap;
> +       mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
>
>         mutex_init(&mlx90632->lock);
>         indio_dev->name = id->name;
> @@ -672,12 +886,17 @@ static int mlx90632_probe(struct i2c_client *client,
>                 dev_err(&client->dev, "read of version failed: %d\n", ret);
>                 return ret;
>         }
> +       read = read & MLX90632_ID_MASK;
>         if (read == MLX90632_ID_MEDICAL) {
>                 dev_dbg(&client->dev,
>                         "Detected Medical EEPROM calibration %x\n", read);
>         } else if (read == MLX90632_ID_CONSUMER) {
>                 dev_dbg(&client->dev,
>                         "Detected Consumer EEPROM calibration %x\n", read);
> +       } else if (read == MLX90632_ID_EXTENDED) {
> +               dev_dbg(&client->dev,
> +                       "Detected Extended range EEPROM calibration %x\n", read);
> +               mlx90632->mtyp = MLX90632_MTYP_EXTENDED;
>         } else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
>                 dev_dbg(&client->dev,
>                         "Detected Unknown EEPROM calibration %x\n", read);
> @@ -689,6 +908,7 @@ static int mlx90632_probe(struct i2c_client *client,
>         }
>
>         mlx90632->emissivity = 1000;
> +       mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
>
>         pm_runtime_disable(&client->dev);
>         ret = pm_runtime_set_active(&client->dev);
> --
> 2.25.1
>


--
With Best Regards,
Andy Shevchenko
