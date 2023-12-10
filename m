Return-Path: <linux-iio+bounces-789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004880BA8D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6FF1F20ECB
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4E8BE8;
	Sun, 10 Dec 2023 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLtF++eb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95B79F5
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 11:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33EDC433C7;
	Sun, 10 Dec 2023 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702209482;
	bh=DpV7EiXArdDWYASPu8hWSawQuI3cDQxpuG8fb58Ogh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLtF++ebyWlFS1gix4G72wNUWUcECpsvvhZgHwevv7wJN3CwI4N4Ipz8WnRHMwV+B
	 Q+nXrng0qkDvVKV1xEXPKyDjdJH8SSVttHfyPDuQKzsudEl5ixu85iodcEwbLcYuUc
	 t07Dm6pbCDykT26fzi7f7fItUUP0xrY9PessLj8rUuR/zq3AZF8NrxKGcfP0F3tB6/
	 690d0h+ociH2ta6+yLBtjt8oNhY6no6fDoxPM5E98AliX83OkIediMpHEMEoydDvih
	 t0gcN7gfDTnjoAdsfaMU+/MZpQJ9ZKrt+YSJk+XkqVeGRnMAd3tmE8aFv8lMnMcNmP
	 HwurT1Pyndl3w==
Date: Sun, 10 Dec 2023 11:57:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp
 <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: temperature: mlx90635 MLX90635 IR
 Temperature sensor
Message-ID: <20231210115756.04fe05cb@jic23-huawei>
In-Reply-To: <c6590e4fb8d993a5317b486a3e45e1bb6e9e3318.1701872051.git.cmo@melexis.com>
References: <cover.1701872051.git.cmo@melexis.com>
	<c6590e4fb8d993a5317b486a3e45e1bb6e9e3318.1701872051.git.cmo@melexis.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 21:49:33 +0100
Crt Mori <cmo@melexis.com> wrote:

> MLX90635 is an Infra Red contactless temperature sensor most suitable
> for consumer applications where measured object temperature is in range
> between -20 to 100 degrees Celsius. It has improved accuracy for
> measurements within temperature range of human body and can operate in
> ambient temperature range between -20 to 85 degrees Celsius.
> 
> Driver provides simple power management possibility as it returns to
> lowest possible power mode (Step sleep mode) in which temperature
> measurements can still be performed, yet for continuous measuring it
> switches to Continuous power mode where measurements constantly change
> without triggering.
> 
> Signed-off-by: Crt Mori<cmo@melexis.com>
Nice work

I've made a few comments inline for future possible improvements, but
given the cleanup.h stuff is fairly new I'll not block this merging based
on that.

I made some tiny tweak for readability whilst applying. Please sanity check
that. diff was all about return values that must be 0 as they come out of regmap and
we've already checked for error cases.
diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index 1b3bde36f18a..1f5c962c1818 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -306,7 +306,7 @@ static int mlx90635_read_ee_ambient(struct regmap *regmap, s16 *PG, s16 *PO, s16
                return ret;
        *Gb = (u16)read_tmp;
 
-       return ret;
+       return 0;
 }
 
 static int mlx90635_read_ee_object(struct regmap *regmap, u32 *Ea, u32 *Eb, u32 *Fa, s16 *Fb,
@@ -357,7 +357,7 @@ static int mlx90635_read_ee_object(struct regmap *regmap, u32 *Ea, u32 *Eb, u32
                return ret;
        *Fa_scale = (u16)read_tmp;
 
-       return ret;
+       return 0;
 }
 
 static int mlx90635_calculate_dataset_ready_time(struct mlx90635_data *data, int *refresh_time)
@@ -405,7 +405,7 @@ static int mlx90635_perform_measurement_burst(struct mlx90635_data *data)
                return -ETIMEDOUT;
        }
 
-       return ret;
+       return 0;
 }
 
 static int mlx90635_read_ambient_raw(struct regmap *regmap,
@@ -424,7 +424,7 @@ static int mlx90635_read_ambient_raw(struct regmap *regmap,
                return ret;
        *ambient_old_raw = (s16)read_tmp;
 
-       return ret;
+       return 0;
 }
 
 static int mlx90635_read_object_raw(struct regmap *regmap, s16 *object_raw)
@@ -444,7 +444,7 @@ static int mlx90635_read_object_raw(struct regmap *regmap, s16 *object_raw)
                return ret;
        *object_raw = (read - (s16)read_tmp) / 2;
 
-       return ret;
+       return 0;
 }


Applied to the togreg branch of iio.git and pushed out as testing for all the normal
reasons.

> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> new file mode 100644
> index 000000000000..1b3bde36f18a
> --- /dev/null
> +++ b/drivers/iio/temperature/mlx90635.c


> +static int mlx90635_perform_measurement_burst(struct mlx90635_data *data)
> +{
> +	unsigned int reg_status;
> +	int refresh_time;
> +	int ret;
> +
> +	ret = regmap_write_bits(data->regmap, MLX90635_REG_STATUS,
> +				MLX90635_STAT_END_CONV, MLX90635_STAT_END_CONV);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mlx90635_calculate_dataset_ready_time(data, &refresh_time);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write_bits(data->regmap, MLX90635_REG_CTRL2,
> +				FIELD_PREP(MLX90635_CTRL2_SOB_MASK, 1),
> +				FIELD_PREP(MLX90635_CTRL2_SOB_MASK, 1));
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(refresh_time); /* Wait minimum time for dataset to be ready */
> +
> +	ret = regmap_read_poll_timeout(data->regmap, MLX90635_REG_STATUS, reg_status,
> +				       (!(reg_status & MLX90635_STAT_END_CONV)) == 0,
> +				       MLX90635_TIMING_POLLING, MLX90635_READ_RETRIES * 10000);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "data not ready");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return ret;
I'll tweak this one to return 0 to make it explicit that no postive values
are returned.

> +}


> +static int mlx90635_read_all_channel(struct mlx90635_data *data,
> +				     s16 *ambient_new_raw, s16 *ambient_old_raw,
> +				     s16 *object_raw)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP) {
> +		/* Trigger measurement in Sleep Step mode */
> +		ret = mlx90635_perform_measurement_burst(data);
> +		if (ret < 0)
> +			goto read_unlock;
> +	}
> +
> +	ret = mlx90635_read_ambient_raw(data->regmap, ambient_new_raw,
> +					ambient_old_raw);
> +	if (ret < 0)
> +		goto read_unlock;
> +
> +	ret = mlx90635_read_object_raw(data->regmap, object_raw);
> +read_unlock:
> +	mutex_unlock(&data->lock);

A good function to use guard(mutex)(&data->lock)

> +	return ret;
> +}
> +

> +static int mlx90635_calc_ambient(struct mlx90635_data *data, int *val)
> +{
> +	s16 ambient_new_raw, ambient_old_raw;
> +	s16 PG, PO, Gb;
> +	int ret;
> +
> +	ret = mlx90635_read_ee_ambient(data->regmap_ee, &PG, &PO, &Gb);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&data->lock);
I don't mind this not changing for now, but this is exactly the
sort of place for scoped_guard()
Something like:

	scoped_guard(mutex, &data->lock) {
		if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP) {
			ret = mlx90635_perform_measurement_burst(data);
			if (ret < 0)
				return ret;
		}
	
		ret = mlx90635_read_ambient_raw(data->regmap, &ambient_new_raw,
					&ambient_old_raw);
		if (ret < 0)
			return ret;
	}

> +	if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP) {
> +		ret = mlx90635_perform_measurement_burst(data);
> +		if (ret < 0)
> +			goto read_ambient_unlock;
> +	}
> +
> +	ret = mlx90635_read_ambient_raw(data->regmap, &ambient_new_raw,
> +					&ambient_old_raw);
> +read_ambient_unlock:
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = mlx90635_calc_temp_ambient(ambient_new_raw, ambient_old_raw,
> +					  PG, PO, Gb);
> +	return ret;
> +}


