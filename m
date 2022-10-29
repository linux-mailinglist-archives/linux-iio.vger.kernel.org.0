Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13E861229F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJ2LyL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ2LyK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76A6C766
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8936C60EAC
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60EAC433C1;
        Sat, 29 Oct 2022 11:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667044448;
        bh=/XGEZyZWLfrm2RHjzusgzXZ0mBYQiRw95aeyjGD+c8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQzzLIjR1FU+I74OkXhU/pF/QpK9EVONd+eUFsrEccPMf32DvzTOc1u8qT70MDkYe
         0cIjNTeKXIySR8it7puLKZkpyM/7+XSPDeIayCUv3iUtFqlL5ul5NC1UzoCHrQrgWM
         SR7O6ypcIMmupGI6T/H8b6zO+lxzBVrU9AECfkCAO2KokIoKNnU/G1RXfEKSPoMmGC
         wiwdncTO6eH8Etcm5/FXy5u2uBPc/1ufOgG2mU9r8k8p+r6QCoIy9NI7yCB8VD2njK
         2wdqLyzFIRVpsqJU2w+c/iL0Prw89WimXLHujVBsIOCIa0ZIMYepiFXK8QiaOxd9RR
         9MnwraNVyBLPg==
Date:   Sat, 29 Oct 2022 13:06:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] iio: temperature: mlx90632 Style alignment for the
 driver
Message-ID: <20221029130603.4c4b87ed@jic23-huawei>
In-Reply-To: <d59aad00891c1a64e044a0f5bc7d40e42d47e9c7.1666606912.git.cmo@melexis.com>
References: <d59aad00891c1a64e044a0f5bc7d40e42d47e9c7.1666606912.git.cmo@melexis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Oct 2022 12:22:05 +0200
Crt Mori <cmo@melexis.com> wrote:

> Changing and aligning the overall style of the driver with the recent
> reviews. There is no functional change, only type generalization and
> moving to the reverse Christmas tree for variable declarations.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Crt Mori <cmo@melexis.com>
LGTM

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if it can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/mlx90632.c | 65 +++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 224db7513baa..a17fe5f4967a 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -219,11 +219,11 @@ static const struct regmap_config mlx90632_regmap = {
>  	.cache_type = REGCACHE_RBTREE,
>  };
>  
> -static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
> +static int mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>  {
>  	struct mlx90632_data *data =
>  		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> -	s32 ret;
> +	int ret;
>  
>  	if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
>  		return 0;
> @@ -234,14 +234,14 @@ static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>  		return ret;
>  
>  	data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> -	return ret;
> +	return 0;
>  }
>  
> -static s32 mlx90632_pwr_continuous(struct regmap *regmap)
> +static int mlx90632_pwr_continuous(struct regmap *regmap)
>  {
>  	struct mlx90632_data *data =
>  		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> -	s32 ret;
> +	int ret;
>  
>  	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS)
>  		return 0;
> @@ -252,7 +252,7 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
>  		return ret;
>  
>  	data->powerstatus = MLX90632_PWR_STATUS_CONTINUOUS;
> -	return ret;
> +	return 0;
>  }
>  
>  /**
> @@ -444,8 +444,8 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
>  static int mlx90632_read_ambient_raw(struct regmap *regmap,
>  				     s16 *ambient_new_raw, s16 *ambient_old_raw)
>  {
> -	int ret;
>  	unsigned int read_tmp;
> +	int ret;
>  
>  	ret = regmap_read(regmap, MLX90632_RAM_3(1), &read_tmp);
>  	if (ret < 0)
> @@ -464,11 +464,11 @@ static int mlx90632_read_object_raw(struct regmap *regmap,
>  				    int perform_measurement_ret,
>  				    s16 *object_new_raw, s16 *object_old_raw)
>  {
> -	int ret;
>  	unsigned int read_tmp;
> -	s16 read;
> -	u8 channel = 0;
>  	u8 channel_old = 0;
> +	u8 channel = 0;
> +	s16 read;
> +	int ret;
>  
>  	ret = mlx90632_channel_new_select(perform_measurement_ret, &channel,
>  					  &channel_old);
> @@ -503,7 +503,8 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>  				     s16 *ambient_new_raw, s16 *ambient_old_raw,
>  				     s16 *object_new_raw, s16 *object_old_raw)
>  {
> -	s32 ret, measurement;
> +	s32 measurement;
> +	int ret;
>  
>  	mutex_lock(&data->lock);
>  	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
> @@ -512,24 +513,24 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>  
>  	switch (data->powerstatus) {
>  	case MLX90632_PWR_STATUS_CONTINUOUS:
> -		measurement = mlx90632_perform_measurement(data);
> -		if (measurement < 0) {
> -			ret = measurement;
> +		ret = mlx90632_perform_measurement(data);
> +		if (ret < 0)
>  			goto read_unlock;
> -		}
> +
>  		break;
>  	case MLX90632_PWR_STATUS_SLEEP_STEP:
> -		measurement = mlx90632_perform_measurement_burst(data);
> -		if (measurement < 0) {
> -			ret = measurement;
> +		ret = mlx90632_perform_measurement_burst(data);
> +		if (ret < 0)
>  			goto read_unlock;
> -		}
> +
>  		break;
>  	default:
>  		ret = -EOPNOTSUPP;
>  		goto read_unlock;
>  	}
>  
> +	measurement = ret; /* If we came here ret holds the measurement position */
> +
>  	ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
>  					ambient_old_raw);
>  	if (ret < 0)
> @@ -615,15 +616,21 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>  	if (ret < 0)
>  		goto read_unlock;
>  
> -	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
> +	switch (data->powerstatus) {
> +	case MLX90632_PWR_STATUS_CONTINUOUS:
>  		ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
>  					50000, 800000, false, data);
>  		if (ret)
>  			goto read_unlock;
> -	} else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +		break;
> +	case MLX90632_PWR_STATUS_SLEEP_STEP:
>  		ret = mlx90632_perform_measurement_burst(data);
>  		if (ret < 0)
>  			goto read_unlock;
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		goto read_unlock;
>  	}
>  
>  	ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
> @@ -640,9 +647,9 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>  static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
>  				     s32 *reg_value)
>  {
> -	s32 ret;
>  	unsigned int read;
>  	u32 value;
> +	int ret;
>  
>  	ret = regmap_read(regmap, reg_lsb, &read);
>  	if (ret < 0)
> @@ -806,12 +813,12 @@ static s32 mlx90632_calc_temp_object_extended(s64 object, s64 ambient, s64 refle
>  
>  static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
>  {
> -	s32 ret;
> +	s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
>  	s32 Ea, Eb, Fa, Fb, Ga;
>  	unsigned int read_tmp;
> -	s16 Ha, Hb, Gb, Ka;
> -	s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
>  	s64 object, ambient;
> +	s16 Ha, Hb, Gb, Ka;
> +	int ret;
>  
>  	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Ea, &Ea);
>  	if (ret < 0)
> @@ -885,11 +892,11 @@ static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
>  
>  static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>  {
> -	s32 ret;
> +	s16 ambient_new_raw, ambient_old_raw;
>  	unsigned int read_tmp;
>  	s32 PT, PR, PG, PO;
> +	int ret;
>  	s16 Gb;
> -	s16 ambient_new_raw, ambient_old_raw;
>  
>  	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_R, &PR);
>  	if (ret < 0)
> @@ -1164,11 +1171,11 @@ static int mlx90632_enable_regulator(struct mlx90632_data *data)
>  static int mlx90632_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> -	struct iio_dev *indio_dev;
>  	struct mlx90632_data *mlx90632;
> +	struct iio_dev *indio_dev;
>  	struct regmap *regmap;
> -	int ret;
>  	unsigned int read;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90632));
>  	if (!indio_dev) {

