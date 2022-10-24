Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21047609DFA
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJXJ1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJXJ1c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 05:27:32 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 02:27:30 PDT
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E479645C6
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 02:27:29 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id mtcgo3mEsnj75mtcgoCSpB; Mon, 24 Oct 2022 11:19:55 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Oct 2022 11:19:55 +0200
X-ME-IP: 86.243.100.34
Message-ID: <70172749-e4e3-84f5-aa88-bb61d5156439@wanadoo.fr>
Date:   Mon, 24 Oct 2022 11:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iio: temperature: mlx90632 Style alignment for the driver
To:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <c65f8a6f2c1ccadc9682b0e87b1fd9c47b912af7.1666599595.git.cmo@melexis.com>
Content-Language: fr
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c65f8a6f2c1ccadc9682b0e87b1fd9c47b912af7.1666599595.git.cmo@melexis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Le 24/10/2022 à 10:23, Crt Mori a écrit :
> Changing and aligning the overall style of the driver with the recent
> reviews. There is no functional change, only type generalization and
> moving to the reverse Christmas tree for variable declarations.
>

Hi,

i don't have the patch on which it is based, but I think that a few 
s/s32/int/ are missing.

See below.

CJ


> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>   drivers/iio/temperature/mlx90632.c | 65 +++++++++++++++++-------------
>   1 file changed, 36 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 224db7513baa..a1b9d7fb2bb0 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -219,11 +219,11 @@ static const struct regmap_config mlx90632_regmap = {
>   	.cache_type = REGCACHE_RBTREE,
>   };
>   
> -static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
> +static int mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>   {
>   	struct mlx90632_data *data =
>   		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> -	s32 ret;
> +	int ret;
>   
>   	if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
>   		return 0;
> @@ -234,14 +234,14 @@ static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>   		return ret;
>   
>   	data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> -	return ret;
> +	return 0;
>   }
>   
> -static s32 mlx90632_pwr_continuous(struct regmap *regmap)
> +static int mlx90632_pwr_continuous(struct regmap *regmap)
>   {
>   	struct mlx90632_data *data =
>   		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> -	s32 ret;
> +	int ret;
>   
>   	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS)
>   		return 0;
> @@ -252,7 +252,7 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
>   		return ret;
>   
>   	data->powerstatus = MLX90632_PWR_STATUS_CONTINUOUS;
> -	return ret;
> +	return 0;
>   }
>   
>   /**
> @@ -444,8 +444,8 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
>   static int mlx90632_read_ambient_raw(struct regmap *regmap,
>   				     s16 *ambient_new_raw, s16 *ambient_old_raw)
>   {
> -	int ret;
>   	unsigned int read_tmp;
> +	int ret;
>   
>   	ret = regmap_read(regmap, MLX90632_RAM_3(1), &read_tmp);
>   	if (ret < 0)
> @@ -464,11 +464,11 @@ static int mlx90632_read_object_raw(struct regmap *regmap,
>   				    int perform_measurement_ret,
>   				    s16 *object_new_raw, s16 *object_old_raw)
>   {
> -	int ret;
>   	unsigned int read_tmp;
> -	s16 read;
> -	u8 channel = 0;
>   	u8 channel_old = 0;
> +	u8 channel = 0;
> +	s16 read;
> +	int ret;
>   
>   	ret = mlx90632_channel_new_select(perform_measurement_ret, &channel,
>   					  &channel_old);
> @@ -503,7 +503,8 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>   				     s16 *ambient_new_raw, s16 *ambient_old_raw,
>   				     s16 *object_new_raw, s16 *object_old_raw)
>   {
> -	s32 ret, measurement;
> +	s32 measurement;
> +	int ret;
>   
>   	mutex_lock(&data->lock);
>   	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
> @@ -512,24 +513,24 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>   
>   	switch (data->powerstatus) {
>   	case MLX90632_PWR_STATUS_CONTINUOUS:
> -		measurement = mlx90632_perform_measurement(data);
> -		if (measurement < 0) {
> -			ret = measurement;
> +		ret = mlx90632_perform_measurement(data);
> +		if (ret < 0)
>   			goto read_unlock;
> -		}
> +
>   		break;
>   	case MLX90632_PWR_STATUS_SLEEP_STEP:
> -		measurement = mlx90632_perform_measurement_burst(data);
> -		if (measurement < 0) {
> -			ret = measurement;
> +		ret = mlx90632_perform_measurement_burst(data);
> +		if (ret < 0)
>   			goto read_unlock;
> -		}
> +
>   		break;
>   	default:
>   		ret = -EOPNOTSUPP;
>   		goto read_unlock;
>   	}
>   
> +	measurement = ret; /* If we came here ret holds the measurement position */
> +
>   	ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
>   					ambient_old_raw);
>   	if (ret < 0)
> @@ -615,15 +616,21 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>   	if (ret < 0)
>   		goto read_unlock;
>   
> -	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
> +	switch (data->powerstatus) {
> +	case MLX90632_PWR_STATUS_CONTINUOUS:
>   		ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
>   					50000, 800000, false, data);
>   		if (ret)
>   			goto read_unlock;
> -	} else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +		break;
> +	case MLX90632_PWR_STATUS_SLEEP_STEP:
>   		ret = mlx90632_perform_measurement_burst(data);
>   		if (ret < 0)
>   			goto read_unlock;
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		goto read_unlock;
>   	}
>   
>   	ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
> @@ -640,9 +647,9 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>   static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
>   				     s32 *reg_value)
>   {
> -	s32 ret;
>   	unsigned int read;
>   	u32 value;
> +	s32 ret;


int?


>   
>   	ret = regmap_read(regmap, reg_lsb, &read);
>   	if (ret < 0)
> @@ -806,12 +813,12 @@ static s32 mlx90632_calc_temp_object_extended(s64 object, s64 ambient, s64 refle
>   
>   static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
>   {
> -	s32 ret;
> +	s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
>   	s32 Ea, Eb, Fa, Fb, Ga;
>   	unsigned int read_tmp;
> -	s16 Ha, Hb, Gb, Ka;
> -	s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
>   	s64 object, ambient;
> +	s16 Ha, Hb, Gb, Ka;
> +	s32 ret;

int?


>   	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Ea, &Ea);
>   	if (ret < 0)
> @@ -885,11 +892,11 @@ static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
>   
>   static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>   {
> -	s32 ret;
> +	s16 ambient_new_raw, ambient_old_raw;
>   	unsigned int read_tmp;
>   	s32 PT, PR, PG, PO;
> +	s32 ret;


int?


>   	s16 Gb;
> -	s16 ambient_new_raw, ambient_old_raw;
>   
>   	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_R, &PR);
>   	if (ret < 0)
> @@ -1164,11 +1171,11 @@ static int mlx90632_enable_regulator(struct mlx90632_data *data)
>   static int mlx90632_probe(struct i2c_client *client,
>   			  const struct i2c_device_id *id)
>   {
> -	struct iio_dev *indio_dev;
>   	struct mlx90632_data *mlx90632;
> +	struct iio_dev *indio_dev;
>   	struct regmap *regmap;
> -	int ret;
>   	unsigned int read;
> +	int ret;
>   
>   	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90632));
>   	if (!indio_dev) {
