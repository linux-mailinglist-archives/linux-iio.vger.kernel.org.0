Return-Path: <linux-iio+bounces-15603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87598A3765A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E3E3B0EAC
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8019D881;
	Sun, 16 Feb 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWel6brK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2642070;
	Sun, 16 Feb 2025 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739727669; cv=none; b=vAW5BKVyxQTfGpih/EmyQnPDeXPUp7o7ikBi4E/dKHyZDDWTDBCcm1L47kpsCgExKGIYW/cMZ9TQ/XKhmEku35EEPb7N28z2UQf7llAQdJgyPItpDaGuA4dDMvplkjL4pfKRyzLXhwHlv/8NlkcgKgQakcz//2vcAE8VfUVEbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739727669; c=relaxed/simple;
	bh=6RNYKQuP+TjxgyMPY35CewBj9PCs9JmqzBQdsvqdgxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYR0C0d+baHdrthGiphdEOWHFW48/Q2CPw2VfWXNfX2M30zLTpHGLHI3AJDcjaaCJtyYpfOqxBj1QccHs+etkQF8t+l8E11ZyMe/AlWFSByYQePuzw6nBUPscxgkSMFYZjs2f5uDTCB7MX2T/VYxVZ495R7EZVgFGH80291rMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWel6brK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E6C4CEDD;
	Sun, 16 Feb 2025 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739727668;
	bh=6RNYKQuP+TjxgyMPY35CewBj9PCs9JmqzBQdsvqdgxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VWel6brKc9IinaYi5TVwJrWuIDYwwKxXa61P6lrj+7UbDwRpHp8Fzb8CVYqegDf34
	 4E1NQqE/OgcMJxr+CPnh3XecpeGaBkInJpov4xWChrpZBBHpLgh7mlntGRSacqDbbP
	 zblCUuforYEtn7sWtNKU11oIkMn/SNWMKXAvZez5PiAA1C2Zw4oSnowcP9trRABmrG
	 ag8SucSxiEESjZdUHjs90oAjgvk5WxIqkCTCsVq76HiYkwG3f8b/nUI6Y6Q5Uul0ZN
	 UWhQXqQs56sggolLQhT5EgWBxzcNDIYjUxRiFqaJj72pZ0ELnUkn2HUDJ1LfxuICGp
	 h0gdc9UF1RIdQ==
Date: Sun, 16 Feb 2025 17:41:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 10/14] iio: accel: adxl345: add g-range configuration
Message-ID: <20250216174100.73b0bece@jic23-huawei>
In-Reply-To: <20250210110119.260858-11-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:15 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce means to configure and work with the available g-ranges
> keeping the precision of 13 digits.
> 
> This is in preparation for the activity/inactivity feature.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
A few really trivial comments on this one.

> ---
>  drivers/iio/accel/adxl345_core.c | 92 ++++++++++++++++++++++++++++++--
>  1 file changed, 89 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 08ad71875c5e..ea7bfe193d31 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -86,6 +86,13 @@ enum adxl345_odr {
>  	ADXL345_ODR_3200HZ,
>  };
>  
> +enum adxl345_range {
> +	ADXL345_2G_RANGE = 0,
> +	ADXL345_4G_RANGE,
> +	ADXL345_8G_RANGE,
> +	ADXL345_16G_RANGE,
> +};
> +
>  /* Certain features recommend 12.5 Hz - 400 Hz ODR */
>  static const int adxl345_odr_tbl[][2] = {
>  	[ADXL345_ODR_0P10HZ]	= {   0,  97000},
> @@ -106,6 +113,33 @@ static const int adxl345_odr_tbl[][2] = {
>  	[ADXL345_ODR_3200HZ]	= {3200, 0},
>  };
>  
> +/*
> + * Full resolution frequency table:
> + * (g * 2 * 9.80665) / (2^(resolution) - 1)
> + *
> + * resolution := 13 (full)
> + * g := 2|4|8|16
> + *
> + *  2g at 13bit: 0.004789
> + *  4g at 13bit: 0.009578
> + *  8g at 13bit: 0.019156
> + * 16g at 16bit: 0.038312
> + */
> +static const int adxl345_fullres_range_tbl[][2] = {
> +	[ADXL345_2G_RANGE]  = {0, 4789},

I'm slowly trying to standardize a few more corners of the kernel style for IIO at least.
This hits one of them. So if you don't mind adding spaces after { and before }
it will one day save me time on a cleanup series.

> +	[ADXL345_4G_RANGE]  = {0, 9578},
> +	[ADXL345_8G_RANGE]  = {0, 19156},
> +	[ADXL345_16G_RANGE] = {0, 38312},
> +};


> @@ -1252,6 +1335,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	 * undesired behavior.
>  	 */
>  	ret = adxl345_set_odr(st, ADXL345_ODR_200HZ);
> +	if (ret)
> +		return ret;

Trivial but I'd put a blank line here for slightly improved readability.

> +	ret = adxl345_set_range(st, ADXL345_16G_RANGE);
>  	if (ret)
>  		return ret;
>  


