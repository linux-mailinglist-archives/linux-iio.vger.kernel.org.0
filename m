Return-Path: <linux-iio+bounces-18528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54FA97469
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B973AC457
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB262973B9;
	Tue, 22 Apr 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpL+AeL0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4D28541C
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346020; cv=none; b=WYSUNIihDVZa88SZotLF5CVGuCxvGKvOQZhVYnvFx0GFAGpvSBDEdE7+CdBp33ZVd5Nwu2FoDd7B1jdPRN2E5Ep4DLJF2oqCJonNv/oFuOROSa36djlqqcsDIAKzzCn5W+8AIJr4tZLVYh7jMjSP/iBVySQ/fTHg0RaQTKxF+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346020; c=relaxed/simple;
	bh=zBY4D0hEh96fJI3ML12LPp085No6fCADnwSwdHDSlCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6cu22xycXWGpiJBjKMQlEL0TcLK+ecsAOlIGZib+HV74hoODO/wdnYZ4dq2gOtAAmN9tjlpq+EtPt7q0Fv4c98x/JX5hYQxzIVIgaV/xz35J2wJ3H1aGtqu6bZnj02hejAxH48mtm4Y6rLjD3BSGhKn2QcDVX0t1U6YzhyquW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpL+AeL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0CFC4CEE9;
	Tue, 22 Apr 2025 18:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745346019;
	bh=zBY4D0hEh96fJI3ML12LPp085No6fCADnwSwdHDSlCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BpL+AeL00ETShIy6ZvDDSlSD44jY8JWejylRS+kY9VpEEx0WGoVxXEhLa1aiyNod8
	 yaym3AnHssP7dMhGCQ1KAA6Sk6A7CgtoLESCzKPSMKw3FXB5c6Cc00nH9iifK8P8lC
	 UO30yY3WQ09isgt4bI4qBVWxx8kHwPCAEa7USaDME6s8awl7Qdtuqfs4UTTQzSavXn
	 52RnQuJgCA3hOFf3cPALjg3JHiicsCKJMxsvm6xlRiZu9OEpKw5UnbwTV2BQkhO/Nx
	 r0JqCR7VUGZuHSzlp+CLe2Ch2DAVgphDDgagHsMsz925+Bj0jhuDGa8I/AYoCvN4NQ
	 QLXz3AMNMA16w==
Date: Tue, 22 Apr 2025 19:20:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: nattan <nattanferreira58@gmail.com>
Cc: subhajit.ghosh@tweaklogic.com, lucasantonio.santos@usp.br,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: apds9306: Refactor threshold get/set
 functions to use helper
Message-ID: <20250422192013.0f98ea64@jic23-huawei>
In-Reply-To: <20250422171503.26532-1-nattanferreira58@gmail.com>
References: <20250422171503.26532-1-nattanferreira58@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 14:15:02 -0300
nattan <nattanferreira58@gmail.com> wrote:

> From: Nattan Ferreira <nattanferreira58@gmail.com>
> 
> Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set
> functions to use a helper function (apds9306_get_thresh_reg) for obtaining the
> correct register based on the direction of the event. This improves code
> readability,minimize the number of lines  and maintains consistency
> in accessing threshold registers.
> 
> Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
> Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
> Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
> ---
>  drivers/iio/light/apds9306.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 69a0d609c..d46fb45ae 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -744,20 +744,27 @@ static int apds9306_event_period_set(struct apds9306_data *data, int val)
>  	return regmap_field_write(rf->int_persist_val, val);
>  }
>  
> -static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> -				     int *val)
> +static int apds9306_get_thresh_reg(int dir)
>  {
> -	int var, ret;
> -	u8 buff[3];
> -
>  	if (dir == IIO_EV_DIR_RISING)
> -		var = APDS9306_ALS_THRES_UP_0_REG;
> +		return  APDS9306_ALS_THRES_UP_0_REG;

As per v1 review.  There are 2 spaces after that return. Should only be one.

>  	else if (dir == IIO_EV_DIR_FALLING)
> -		var = APDS9306_ALS_THRES_LOW_0_REG;
> +		return APDS9306_ALS_THRES_LOW_0_REG;
>  	else
>  		return -EINVAL;
> +}
> +
> +static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> +				     int *val)
> +{
> +	int reg, ret;
> +	u8 buff[3];
>  
> -	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
> +	reg = apds9306_get_thresh_reg(dir);
> +	if (reg == -EINVAL)

Just check if < 0


> +		return reg;
> +
> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
>  	if (ret)
>  		return ret;
>  
> @@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
>  static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
>  				     int val)
>  {
> -	int var;
> +	int reg;
>  	u8 buff[3];
>  
> -	if (dir == IIO_EV_DIR_RISING)
> -		var = APDS9306_ALS_THRES_UP_0_REG;
> -	else if (dir == IIO_EV_DIR_FALLING)
> -		var = APDS9306_ALS_THRES_LOW_0_REG;
> -	else
> -		return -EINVAL;
> +	reg = apds9306_get_thresh_reg(dir);
> +	if (reg == -EINVAL)
As above.

> +		return reg;
>  
>  	if (!in_range(val, 0, APDS9306_ALS_THRES_VAL_MAX))
>  		return -EINVAL;
>  
>  	put_unaligned_le24(val, buff);
>  
> -	return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
> +	return regmap_bulk_write(data->regmap, reg, buff, sizeof(buff));
>  }
>  
>  static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data, int *val)


