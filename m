Return-Path: <linux-iio+bounces-15981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8E5A40AB5
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54C73B2587
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4581E990D;
	Sat, 22 Feb 2025 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVPHzYKA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7D10E4;
	Sat, 22 Feb 2025 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245514; cv=none; b=Vb2M9XPs10/oUlARe60hHhnv90q8aXHftGpL0+KVX93hf2r96wZXsSJJUJ8kfECWOyczBuHaFyP5Ca3vO1iclqw3uNMGLe/op4WgQLXHXSV/FWsy+GG9A1kYt5VcHTAHUTIIrIbK9ac4eL30iulRCu0LMlCY6yfzVTM4Yj5qAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245514; c=relaxed/simple;
	bh=ptZu2YxZBcaSLeEUXF7yE1LwQ/fHrApKWLTroBP7Xac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFB5r94w7wUKsD8/85wWL3XPBpueWm1CNPlKGq9MTgX1VaLnCYzo5+/qGLWqhmYqV+1X3ogpKd/eiHudSC/QholJTuT50Zy7imlFpGw3jo95sHPgGvdQ3ndWvpNyt9bxV+7hxpHzBnbfX4Z2hgQhS3TK/ERrKRqmrxo0N1lM6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVPHzYKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F7AC4CED1;
	Sat, 22 Feb 2025 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740245514;
	bh=ptZu2YxZBcaSLeEUXF7yE1LwQ/fHrApKWLTroBP7Xac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVPHzYKAocmQlUNz2meKMXRBrAzOHWavpQVdmyb2oUBpdnuk28k07ASblsTkERA4o
	 R0fsbPug1ZXRL/TTlf3aE4ehW+Uv3IM0cfccNMnFk/emlVbV7N9BwrSvxU9PfyiRxp
	 /QWLPonPd3HBnD/u+L0eyjPQpCNR9g2PCQLIn8LVp3FKiqW5f1cFA75JiExqbuBYY3
	 oN/W0ADoNM7hnpu03SSmNOGNo3tvCW+1g0XgOb3BkVdDTnKgg9icLwunZv5WPEirNL
	 FsfIRY4mxThIwOxN7l9RoawLMywN7ejVTgqvhOXT8z9m6KlpoIZOeka4s8RRJhLJ+7
	 wzlJz2G1fsqGg==
Date: Sat, 22 Feb 2025 17:31:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: bmi270: rename variable bmi270_device to
 data
Message-ID: <20250222173146.089ba66a@jic23-huawei>
In-Reply-To: <20250219-bmi270-irq-v1-2-145d02bbca3b@gmail.com>
References: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
	<20250219-bmi270-irq-v1-2-145d02bbca3b@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 20:54:46 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Rename all instances of 'struct bmi270_data' to 'data', to ensure
> consistency across the driver.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 79 ++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 9f24d4044ed6f00f67fd3a8f5adda821c3140a18..56ebd887fcec94b684dc23f1b4503b719fb39239 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -90,7 +90,7 @@ struct bmi270_data {
>  	struct {
>  		__le16 channels[6];
>  		aligned_s64 timestamp;
> -	} data __aligned(IIO_DMA_MINALIGN);
> +	} buffer __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  enum bmi270_scan {
> @@ -284,7 +284,7 @@ static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
>  	return -EINVAL;
>  }
>  
> -static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
> +static int bmi270_get_scale(struct bmi270_data *data, int chan_type,
>  			    int *scale, int *uscale)
>  {
>  	int ret;
> @@ -293,7 +293,7 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
>  
>  	switch (chan_type) {
>  	case IIO_ACCEL:
> -		ret = regmap_read(bmi270_device->regmap,
> +		ret = regmap_read(data->regmap,
>  				  BMI270_ACC_CONF_RANGE_REG, &val);

Given shorter naming, a few places like this should be re line wrapped.

>  		if (ret)
>  			return ret;


