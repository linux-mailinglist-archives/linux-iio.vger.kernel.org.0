Return-Path: <linux-iio+bounces-11386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B19B1D1B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B8CB20DD4
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3DF14A611;
	Sun, 27 Oct 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhP2zhDE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1513C3F6;
	Sun, 27 Oct 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023731; cv=none; b=cPobCxdze1pK3o3ZLrzWqikol1RVz7EMHwu9E5wW5ZRI/pS2a+kBCXh/laKRBuHd1yLAGKWiJtLkGVsM/JrR8mg0E0G435T99uh3Jzijg4YHCSCSSfBzy50HrynfdDqgBKEpWXtOJ/nMqpMku1krwiD3E36XC6aTpv1Duai9NBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023731; c=relaxed/simple;
	bh=2gkNihP2BQisgd5jR51Idi/O6VeuQoQQ9abUr7pbOe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKotMrXctmXF9MHUxzWif6YBYaW+jVP12n4mx/SxjOiqo7yrohJ8lF6EM4WqwfoUFlYu2MyyC5aEaO1w8OPDRxTA7mEJuqJRtIQSOONEMa9LxPqG+NbRMkGgaQPanDR//05N/lcCwDO6E78Il+BZzeder/kkdavOAjEGyst4NCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhP2zhDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F2EC4CEC3;
	Sun, 27 Oct 2024 10:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730023730;
	bh=2gkNihP2BQisgd5jR51Idi/O6VeuQoQQ9abUr7pbOe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HhP2zhDE4zrUjRWiJaVyYuPwPPeC/rCRjk5lf3L7u9JWs/4RICh2NnGTgOT1r2IKM
	 lB0Qee4/CsidQh8h1itd7TT5vR/X0/VZfjY+s39gjGDq3fmS7B67FfMB2Hu6aTkwPm
	 t2GcuggfJzKZUZdpXgDstO1tTGOhlhPVwi+y6AAxXl3YLJ+n1Lk8lOTDrH5JZ0knW0
	 36xEBItOI4esJipsPtlaqPlpddD/eb8EMHlG/5nsuJWtNBraOBVpcfagPHeIhbszqT
	 hTp68Ah9bTxhwpnip/pm8Y+pycfyj+dWv+FLFzptoAK0p/Xz5Ub+XXmPgu2/8MIBdr
	 0Bq2PnN6FglIg==
Date: Sun, 27 Oct 2024 10:08:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] iio: chemical: bme680: Fix indentation and
 unnecessary spaces
Message-ID: <20241027100841.46cafdb2@jic23-huawei>
In-Reply-To: <20241021195316.58911-7-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-7-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:09 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Fix indentation issues, line breaking and unnecessary spaces
> reported by checkpatch.pl.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 2ff85e29bfc1..2ad427f5deb4 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -229,7 +229,7 @@ static int bme680_read_calib(struct bme680_data *data,
>  	calib->res_heat_val = data->bme680_cal_buf_3[RES_HEAT_VAL];
>  
>  	calib->res_heat_range = FIELD_GET(BME680_RHRANGE_MASK,
> -					data->bme680_cal_buf_3[RES_HEAT_RANGE]);
> +					  data->bme680_cal_buf_3[RES_HEAT_RANGE]);
>  
>  	calib->range_sw_err = FIELD_GET(BME680_RSERROR_MASK,
>  					data->bme680_cal_buf_3[RANGE_SW_ERR]);
> @@ -450,12 +450,12 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
>  		2147483647u, 2126008810u, 2147483647u, 2147483647u
>  	};
>  
> -	var1 = ((1340 + (5 * (s64) calib->range_sw_err)) *
> -			((s64)lookup_table[gas_range])) >> 16;
> +	var1 = ((1340LL + (5 * calib->range_sw_err)) *
> +			(lookup_table[gas_range])) >> 16;

Everything other than this one is straight forward and requires
checking types of range_sw_err is less than 32 bit for example.

For cleanup I'd normally avoid these subtle cases. 
An extra type case or two does little harm to readability.

Anyhow, with that in mind I've applied anyway.


>  	var2 = ((gas_res_adc << 15) - 16777216) + var1;
>  	var3 = ((125000 << (15 - gas_range)) * var1) >> 9;
>  	var3 += (var2 >> 1);
> -	calc_gas_res = div64_s64(var3, (s64) var2);
> +	calc_gas_res = div64_s64(var3, (s64)var2);
>  
>  	return calc_gas_res;
>  }
> @@ -473,7 +473,7 @@ static u8 bme680_calc_heater_res(struct bme680_data *data, u16 temp)
>  	if (temp > 400) /* Cap temperature */
>  		temp = 400;
>  
> -	var1 = (((s32) BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
> +	var1 = (((s32)BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
>  	var2 = (calib->par_gh1 + 784) * (((((calib->par_gh2 + 154009) *
>  						temp * 5) / 100)
>  						+ 3276800) / 10);
> @@ -569,9 +569,8 @@ static int bme680_chip_config(struct bme680_data *data)
>  	int ret;
>  	u8 osrs;
>  
> -	osrs = FIELD_PREP(
> -		BME680_OSRS_HUMIDITY_MASK,
> -		bme680_oversampling_to_reg(data->oversampling_humid));
> +	osrs = FIELD_PREP(BME680_OSRS_HUMIDITY_MASK,
> +			  bme680_oversampling_to_reg(data->oversampling_humid));
>  	/*
>  	 * Highly recommended to set oversampling of humidity before
>  	 * temperature/pressure oversampling.
> @@ -585,8 +584,7 @@ static int bme680_chip_config(struct bme680_data *data)
>  
>  	/* IIR filter settings */
>  	ret = regmap_update_bits(data->regmap, BME680_REG_CONFIG,
> -				 BME680_FILTER_MASK,
> -				 BME680_FILTER_COEFF_VAL);
> +				 BME680_FILTER_MASK, BME680_FILTER_COEFF_VAL);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to write config register\n");
>  		return ret;
> @@ -885,8 +883,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  	data->heater_temp = 320; /* degree Celsius */
>  	data->heater_dur = 150;  /* milliseconds */
>  
> -	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
> -			   BME680_CMD_SOFTRESET);
> +	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to reset chip\n");
>  


