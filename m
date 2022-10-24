Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24C6609C85
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 10:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiJXI2W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 04:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiJXI17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 04:27:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60852458
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 01:27:35 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id n18so750689qvt.11
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UTrMANNFTcPcVGBrv2Ro2+sKwQI2ADpXILA1Nbi8sIQ=;
        b=RuVnLsWYvCphFsv5d0F4eJpwXLIPpCK8wU7iYMTaR6n2BVEnjA5Z4GDNWQUbHY4eSn
         mk7rE7CkVZfOFX1jcVHw3vRdfCxqCXMV+6bBUw+BLDo+PDWkAVCT87iLDdztUHqXJq5M
         fYhCGOY4seLYbDfqD68LJK6sG9FOmw82suNBtjmSL2v/8QdJS4wifKTdsbYbE6ab/KIg
         DGNe4GNzsPN1E818K/7sRfU3dWloyis7VmHThOwFnQX2f0rMumBFA3Dr9qc6g1Ep5FCp
         9YwHBKunlb0QGbe7ZjVbXc+xkDAjyzTIOujn6//RSBK59WESlhpn2H/olGlTce790yMt
         7W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTrMANNFTcPcVGBrv2Ro2+sKwQI2ADpXILA1Nbi8sIQ=;
        b=r3TlO1fVF9EpAitQQpnINHUAJ1P9SLoteYUp/KukXMnWd/CT8TJG8PWkrHwve5Lbk6
         inudJYIj0w5KrJz8Bk+Gujh200/Bp0RxWeH7f1pcq0lBMlf3C0eJkjYY2tT0yQ+g2gd+
         QZJoTTaxl36Hu0YtQdxvq3F4iJtbA5koqO3ZGRHCW2MWFP4oi1hB5kCFXBDUjc4tFXTt
         Fg/WnLAGrTifsghaWZ9INPbubdIDOD9OBuPPM5BuJCf7qW8/245epQr74Knvbl7L2CLE
         hulq4KDtPMrK9bkJioISFNOudYp3+0qO4LiAKV0mPdl+Bba6/BO/4+Qvi4HysT3u2sUL
         C1xA==
X-Gm-Message-State: ACrzQf0rXzsPyAOPEfBjWTPYtg77jp7LC6kkvHNj5cOP2Vwxv8acwj0Q
        SbxH9qi41yxe7x/pvkdAsyq5RKveddnuyGKw5wc=
X-Google-Smtp-Source: AMsMyM7K4gjOSxqTaWHYIas7rWlQtUd83cxUhi2sAbfwHoO53Yp5QrTVVxETZrDgRH/Ekqf8MKiw1fI/3cqqmU2GnJc=
X-Received: by 2002:a05:6214:762:b0:4b1:c5d2:3fd0 with SMTP id
 f2-20020a056214076200b004b1c5d23fd0mr26974780qvz.97.1666600053469; Mon, 24
 Oct 2022 01:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <c65f8a6f2c1ccadc9682b0e87b1fd9c47b912af7.1666599595.git.cmo@melexis.com>
In-Reply-To: <c65f8a6f2c1ccadc9682b0e87b1fd9c47b912af7.1666599595.git.cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Oct 2022 11:26:57 +0300
Message-ID: <CAHp75VcTopkbKyS--hN4MkWaAi6dUO-kmHSgVNsG7KOUYVFwRA@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90632 Style alignment for the driver
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 24, 2022 at 11:24 AM Crt Mori <cmo@melexis.com> wrote:
>
> Changing and aligning the overall style of the driver with the recent
> reviews. There is no functional change, only type generalization and
> moving to the reverse Christmas tree for variable declarations.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 65 +++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 224db7513baa..a1b9d7fb2bb0 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -219,11 +219,11 @@ static const struct regmap_config mlx90632_regmap = {
>         .cache_type = REGCACHE_RBTREE,
>  };
>
> -static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
> +static int mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>  {
>         struct mlx90632_data *data =
>                 iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> -       s32 ret;
> +       int ret;
>
>         if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
>                 return 0;
> @@ -234,14 +234,14 @@ static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>                 return ret;
>
>         data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> -       return ret;
> +       return 0;
>  }
>
> -static s32 mlx90632_pwr_continuous(struct regmap *regmap)
> +static int mlx90632_pwr_continuous(struct regmap *regmap)
>  {
>         struct mlx90632_data *data =
>                 iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> -       s32 ret;
> +       int ret;
>
>         if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS)
>                 return 0;
> @@ -252,7 +252,7 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
>                 return ret;
>
>         data->powerstatus = MLX90632_PWR_STATUS_CONTINUOUS;
> -       return ret;
> +       return 0;
>  }
>
>  /**
> @@ -444,8 +444,8 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
>  static int mlx90632_read_ambient_raw(struct regmap *regmap,
>                                      s16 *ambient_new_raw, s16 *ambient_old_raw)
>  {
> -       int ret;
>         unsigned int read_tmp;
> +       int ret;
>
>         ret = regmap_read(regmap, MLX90632_RAM_3(1), &read_tmp);
>         if (ret < 0)
> @@ -464,11 +464,11 @@ static int mlx90632_read_object_raw(struct regmap *regmap,
>                                     int perform_measurement_ret,
>                                     s16 *object_new_raw, s16 *object_old_raw)
>  {
> -       int ret;
>         unsigned int read_tmp;
> -       s16 read;
> -       u8 channel = 0;
>         u8 channel_old = 0;
> +       u8 channel = 0;
> +       s16 read;
> +       int ret;
>
>         ret = mlx90632_channel_new_select(perform_measurement_ret, &channel,
>                                           &channel_old);
> @@ -503,7 +503,8 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>                                      s16 *ambient_new_raw, s16 *ambient_old_raw,
>                                      s16 *object_new_raw, s16 *object_old_raw)
>  {
> -       s32 ret, measurement;
> +       s32 measurement;
> +       int ret;
>
>         mutex_lock(&data->lock);
>         ret = mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
> @@ -512,24 +513,24 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>
>         switch (data->powerstatus) {
>         case MLX90632_PWR_STATUS_CONTINUOUS:
> -               measurement = mlx90632_perform_measurement(data);
> -               if (measurement < 0) {
> -                       ret = measurement;
> +               ret = mlx90632_perform_measurement(data);
> +               if (ret < 0)
>                         goto read_unlock;
> -               }
> +
>                 break;
>         case MLX90632_PWR_STATUS_SLEEP_STEP:
> -               measurement = mlx90632_perform_measurement_burst(data);
> -               if (measurement < 0) {
> -                       ret = measurement;
> +               ret = mlx90632_perform_measurement_burst(data);
> +               if (ret < 0)
>                         goto read_unlock;
> -               }
> +
>                 break;
>         default:
>                 ret = -EOPNOTSUPP;
>                 goto read_unlock;
>         }
>
> +       measurement = ret; /* If we came here ret holds the measurement position */
> +
>         ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
>                                         ambient_old_raw);
>         if (ret < 0)
> @@ -615,15 +616,21 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>         if (ret < 0)
>                 goto read_unlock;
>
> -       if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
> +       switch (data->powerstatus) {
> +       case MLX90632_PWR_STATUS_CONTINUOUS:
>                 ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
>                                         50000, 800000, false, data);
>                 if (ret)
>                         goto read_unlock;
> -       } else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +               break;
> +       case MLX90632_PWR_STATUS_SLEEP_STEP:
>                 ret = mlx90632_perform_measurement_burst(data);
>                 if (ret < 0)
>                         goto read_unlock;
> +               break;
> +       default:
> +               ret = -EOPNOTSUPP;
> +               goto read_unlock;
>         }
>
>         ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
> @@ -640,9 +647,9 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>  static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
>                                      s32 *reg_value)
>  {
> -       s32 ret;
>         unsigned int read;
>         u32 value;
> +       s32 ret;
>
>         ret = regmap_read(regmap, reg_lsb, &read);
>         if (ret < 0)
> @@ -806,12 +813,12 @@ static s32 mlx90632_calc_temp_object_extended(s64 object, s64 ambient, s64 refle
>
>  static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
>  {
> -       s32 ret;
> +       s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
>         s32 Ea, Eb, Fa, Fb, Ga;
>         unsigned int read_tmp;
> -       s16 Ha, Hb, Gb, Ka;
> -       s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
>         s64 object, ambient;
> +       s16 Ha, Hb, Gb, Ka;
> +       s32 ret;
>
>         ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Ea, &Ea);
>         if (ret < 0)
> @@ -885,11 +892,11 @@ static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
>
>  static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>  {
> -       s32 ret;
> +       s16 ambient_new_raw, ambient_old_raw;
>         unsigned int read_tmp;
>         s32 PT, PR, PG, PO;
> +       s32 ret;
>         s16 Gb;
> -       s16 ambient_new_raw, ambient_old_raw;
>
>         ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_R, &PR);
>         if (ret < 0)
> @@ -1164,11 +1171,11 @@ static int mlx90632_enable_regulator(struct mlx90632_data *data)
>  static int mlx90632_probe(struct i2c_client *client,
>                           const struct i2c_device_id *id)
>  {
> -       struct iio_dev *indio_dev;
>         struct mlx90632_data *mlx90632;
> +       struct iio_dev *indio_dev;
>         struct regmap *regmap;
> -       int ret;
>         unsigned int read;
> +       int ret;
>
>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90632));
>         if (!indio_dev) {
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
