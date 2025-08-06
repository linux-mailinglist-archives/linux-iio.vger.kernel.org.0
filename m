Return-Path: <linux-iio+bounces-22334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04902B1C807
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 16:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE5664E24CC
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768EA220F25;
	Wed,  6 Aug 2025 14:59:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D942A99;
	Wed,  6 Aug 2025 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492342; cv=none; b=I6M3cu3d46CdtP4ZkxFnQAj6zPo0mmoc67jEAK1sZQ9rU3KCRsrotKRvV5WSEaijShtfE5s+mz2c789RERG1mR4VoOXtEwZ6QKhoHbyLfgIHl/+sOGur6B/ONNlfPBvBjkdhTyiuN3WZFbIWRrmwrCLHMbQbYYGR+i0EElCt2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492342; c=relaxed/simple;
	bh=8lh07oe3MB8WKmJHDb2YTbmF7VrfefsF/Uss67nAQg8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8xfPxp3zibfYRneA/XR7D8hqZV4JOmEIcNvuuKPhZJCv5ZrQuQK7pRDQIFPLMdzrQAex2O6qz82LFmKyJ4Kh4MlaYdK0j8KQw7Lm3Xd7n4Od+Ho4yQLxrtpiTeVQownprAr67f5+La2MO7JxQeNcb9phd0dQKpEJx6h2JY7knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxtfY4ymcz6L5RZ;
	Wed,  6 Aug 2025 22:56:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C5BA1402EC;
	Wed,  6 Aug 2025 22:58:56 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 16:58:55 +0200
Date: Wed, 6 Aug 2025 15:58:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Stefano Manni <stefano.manni@gmail.com>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: ad799x: add reference voltage capability
 to chip_info
Message-ID: <20250806155853.00003f0b@huawei.com>
In-Reply-To: <20250806090158.117628-2-stefano.manni@gmail.com>
References: <20250806090158.117628-1-stefano.manni@gmail.com>
	<20250806090158.117628-2-stefano.manni@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  6 Aug 2025 11:01:57 +0200
Stefano Manni <stefano.manni@gmail.com> wrote:

> If the chip supports an external reference voltage
> on REFIN pin then the "vref-supply" regulator may be used.
> 
> This commit partially refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
> to add the capability of the chip to have an external
> voltage reference and then remove the ugly conditional check
> on chip id.
> 
> Signed-off-by: Stefano Manni <stefano.manni@gmail.com>

Hi Stefano,
`
A few minor things inline.

Mostly looks good to me. 

Jonathan

> ---
>  drivers/iio/adc/ad799x.c | 45 +++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 9c02f9199139..955d845407b9 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -114,11 +114,13 @@ struct ad799x_chip_config {
>   * @num_channels:	number of channels
>   * @noirq_config:	device configuration w/o IRQ
>   * @irq_config:		device configuration w/IRQ
> + * @has_vref:		device supports external reference voltage
>   */
>  struct ad799x_chip_info {
>  	int				num_channels;
>  	const struct ad799x_chip_config	noirq_config;
>  	const struct ad799x_chip_config	irq_config;
> +	bool has_vref;
>  };
>  
>  struct ad799x_state {
> @@ -604,6 +606,7 @@ static const struct iio_event_spec ad799x_events[] = {
>  static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	[ad7991] = {
>  		.num_channels = 5,
> +		.has_vref = true,
>  		.noirq_config = {
>  			.channel = {
>  				AD799X_CHANNEL(0, 12),
> @@ -617,6 +620,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  	[ad7995] = {
>  		.num_channels = 5,
> +		.has_vref = true,
>  		.noirq_config = {
>  			.channel = {
>  				AD799X_CHANNEL(0, 10),
> @@ -630,6 +634,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  	[ad7999] = {
>  		.num_channels = 5,
> +		.has_vref = true,
>  		.noirq_config = {
>  			.channel = {
>  				AD799X_CHANNEL(0, 8),
> @@ -643,6 +648,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  	[ad7992] = {
>  		.num_channels = 3,
> +		.has_vref = false,
>  		.noirq_config = {
>  			.channel = {
>  				AD799X_CHANNEL(0, 12),
> @@ -663,6 +669,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  	[ad7993] = {
>  		.num_channels = 5,
> +		.has_vref = false,
>  		.noirq_config = {
>  			.channel = {
>  				AD799X_CHANNEL(0, 10),
> @@ -687,6 +694,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  	[ad7994] = {
>  		.num_channels = 5,
> +		.has_vref = false,
>  		.noirq_config = {
>  			.channel = {
>  				AD799X_CHANNEL(0, 12),
> @@ -711,6 +719,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  	[ad7997] = {
>  		.num_channels = 9,
> +		.has_vref = false,

Seems like 'not' having a vref is a reasonable default, so you could just not
set it at all in those cases and rely on the default being false.

>  		.noirq_config = {
>  			.channel = {
>  				AD799X_CHANNEL(0, 10),
> @@ -743,6 +752,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  	[ad7998] = {
>  		.num_channels = 9,
> +		.has_vref = false,
>  		.noirq_config = {
>  			.channel = {
>  				AD799X_CHANNEL(0, 12),
> @@ -809,34 +819,31 @@ static int ad799x_probe(struct i2c_client *client)
>  		return ret;
>  
>  	/* check if an external reference is supplied */
> -	st->vref = devm_regulator_get_optional(&client->dev, "vref");
> -
> -	if (IS_ERR(st->vref)) {
> -		if (PTR_ERR(st->vref) == -ENODEV) {
> -			st->vref = NULL;
> -			dev_info(&client->dev, "Using VCC reference voltage\n");
> -		} else {
> -			ret = PTR_ERR(st->vref);
> -			goto error_disable_reg;
> +	if (chip_info->has_vref) {
> +		st->vref = devm_regulator_get_optional(&client->dev, "vref");
> +
> +		if (IS_ERR(st->vref)) {
> +			if (PTR_ERR(st->vref) == -ENODEV) {
> +				st->vref = NULL;
> +				dev_info(&client->dev, "Using VCC reference voltage\n");
> +			} else {
> +				ret = PTR_ERR(st->vref);
> +				goto error_disable_reg;
> +			}
>  		}
> -	}
>  
> -	if (st->vref) {
> -		/*
> -		 * Use external reference voltage if supported by hardware.
> -		 * This is optional if voltage / regulator present, use VCC otherwise.
> -		 */
> -		if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
> +		if (st->vref) {
>  			dev_info(&client->dev, "Using external reference voltage\n");
>  			extra_config |= AD7991_REF_SEL;
>  			ret = regulator_enable(st->vref);
>  			if (ret)
>  				goto error_disable_reg;
> -		} else {
> -			st->vref = NULL;
> -			dev_warn(&client->dev, "Supplied reference not supported\n");
>  		}
>  	}
> +	else {

	} else {

> +		st->vref = NULL;
> +		dev_dbg(&client->dev, "Supplied reference not supported\n");
> +	}
>  
>  	st->client = client;
>  


