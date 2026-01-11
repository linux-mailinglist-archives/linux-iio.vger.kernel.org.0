Return-Path: <linux-iio+bounces-27600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4ABD0EDD2
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC843018D43
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E613733C1B3;
	Sun, 11 Jan 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVFcqDam"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4A2CCB9;
	Sun, 11 Jan 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768134614; cv=none; b=FEiH6yXnqZr2eN/2Tacw7rWQvGaUcUcJSzICk/1CgUSmYxLYbt8R2+39eEzzblV3cayuLgMk3fopNbxolmLqitvJywX6ddiMOH5ZN9pSbxwUVBZpnOjkIaD5OQDjVX+tDOV96btk8h7z+NEdGu2w53v79rk1GEJDEU0XyWvPJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768134614; c=relaxed/simple;
	bh=NIb+rv4NQye6pipuuktVd+nuDj8ezYg/9eCRhZxNeLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0/Pld8hgz9cOjnnFwSrhxT4Wrz8oyQ4xrHfqazFXa20tjXlf3WBVyV0zZaEIXSTOyrhU1Bj9DnuK4ZLY0hYWE84eYUH35hjWFpBkvx2NhwQX/F8tc7VQoa0zMLvzbtKI61zr7iUTcqsA3Jo3/+vI9CdKLbFNRiD3sR9gXPBscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVFcqDam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AAFC4CEF7;
	Sun, 11 Jan 2026 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768134614;
	bh=NIb+rv4NQye6pipuuktVd+nuDj8ezYg/9eCRhZxNeLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVFcqDamFWW5J4D5vM59jJcU1DOMcqxjc6QPwPRGXqtjE821z5Edf6CIm7a+2e0SU
	 3sc0yl3KR5wTsFdMsdh0G7FZp4P+iLIRrJJznjK7vSqsd6KOb2Ync7+N/87Xg0rrV4
	 bAQuCbPJaUJ13ocwS30Ukn1TTRQdevjbT5Q0nbBwAK6CcozsjtKXudq1VE1n9eAdwe
	 HTDeHU0PlNnxI1jX2haMr9Wi2epO3oS/S+HyHPXaEkFWvQdGVsUb690+Kh3xqvB4Pk
	 BZjmFJQxImlC+9zeWHR928ec92MUL2CnvbMAWjinEDYk4EaeLKDniOZRaAO4/tPrux
	 Sj339xiAzGTiA==
Date: Sun, 11 Jan 2026 12:30:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: akemnade@kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas
 Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: inv-mpu9150: fix irq ack preventing irq
 storms
Message-ID: <20260111123003.450bec98@jic23-huawei>
In-Reply-To: <20251231-mpu9150-v1-1-08ecf085c4ae@kernel.org>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
	<20251231-mpu9150-v1-1-08ecf085c4ae@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 22:14:16 +0100
akemnade@kernel.org wrote:

> From: Andreas Kemnade <andreas@kemnade.info>
> 
> IRQ needs to be acked. for some odd reasons, reading from irq status does
> not reliable help, enable acking from any register to be on the safe side
> and read the irq status register. Comments in the code indicate a known
> unreliability with that register.
> The blamed commit was tested with mpu6050 in lg,p895 and lg,p880 according
> to Tested-bys. But with the MPU9150 in the Epson Moverio BT-200 this leads
> to irq storms without properly acking the irq.
> 
> Fixes: 0a3b517c8089 ("iio: imu: inv_mpu6050: fix interrupt status read for old buggy chips")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Jean-Baptiste,

If you have time to look at this that would be great.

Whilst here I'll note the defines in this driver could really do with consistency
improvements.  I'd like to see GENMASK() and BIT() used everywhere.
Currently it's mostly the style used in this patch with a few fields in
the newer style.  

Thanks

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 8 ++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 5 ++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index b2fa1f4957a5b..5796896d54cd8 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1943,6 +1943,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  			irq_type);
>  		return -EINVAL;
>  	}
> +
> +	/*
> +	 * Acking interrupts by status register does not work reliably
> +	 * but seem to work when this bit is set.
> +	 */
> +	if (st->chip_type == INV_MPU9150)
> +		st->irq_mask |= INV_MPU6050_INT_RD_CLEAR;
> +
>  	device_set_wakeup_capable(dev, true);
>  
>  	st->vdd_supply = devm_regulator_get(dev, "vdd");
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 211901f8b8eb6..6239b1a803f77 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -390,6 +390,8 @@ struct inv_mpu6050_state {
>  /* enable level triggering */
>  #define INV_MPU6050_LATCH_INT_EN	0x20
>  #define INV_MPU6050_BIT_BYPASS_EN	0x2
> +/* allow acking interrupts by any register read */
> +#define INV_MPU6050_INT_RD_CLEAR	0x10
>  
>  /* Allowed timestamp period jitter in percent */
>  #define INV_MPU6050_TS_PERIOD_JITTER	4
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 10a4733420759..22c1ce66f99ee 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -248,7 +248,6 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
>  	switch (st->chip_type) {
>  	case INV_MPU6000:
>  	case INV_MPU6050:
> -	case INV_MPU9150:
>  		/*
>  		 * WoM is not supported and interrupt status read seems to be broken for
>  		 * some chips. Since data ready is the only interrupt, bypass interrupt
> @@ -257,6 +256,10 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
>  		wom_bits = 0;
>  		int_status = INV_MPU6050_BIT_RAW_DATA_RDY_INT;
>  		goto data_ready_interrupt;
> +	case INV_MPU9150:
> +		/* IRQ needs to be acked */
> +		wom_bits = 0;
> +		break;
>  	case INV_MPU6500:
>  	case INV_MPU6515:
>  	case INV_MPU6880:
> 


