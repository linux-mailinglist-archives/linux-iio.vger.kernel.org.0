Return-Path: <linux-iio+bounces-8005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1493E83E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 18:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10301F21410
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516EB1891AE;
	Sun, 28 Jul 2024 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im4CjrhP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE54188CA5;
	Sun, 28 Jul 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182966; cv=none; b=RVIkafDFj2ZrFrlbHLJ/pBrr2QOdUFb7lewqmyv8Df5s4r5Xh1Ai/C/EGZObIhDHHGsC65k0vTJkdJKphWt5+q/UKG0DTJwOfgMitM9jq4Y2UKYVwYHRAVTVREflTxeacjcMruEN3tEVG0MbvUNy3E04H8HPFVUzQXx7lnn1gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182966; c=relaxed/simple;
	bh=DG5ulTQk+MG42W/U9N7gwMfUOg5bBXfQjT06OCk3/gE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MswCC8Wem19limuAtLTRDEG02PlUAEKPt9uYujT/mWSTxhsd0edOKaAtz5ejGskjW2zusqMpXiiPvUN3xeFEymSSup+l8vKFx+imj6COu6pq2l1CehRN+OyiBe7KRIRLbIYfGvbRC7iqCogcy72Wq6Cl60PGdSJQFdPltTZaMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im4CjrhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF8C4AF0B;
	Sun, 28 Jul 2024 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182965;
	bh=DG5ulTQk+MG42W/U9N7gwMfUOg5bBXfQjT06OCk3/gE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=im4CjrhPvqFwYPU1Bu6w63799uYd6O5rZtIJ6BhQuOdLumaKqNe4Bh11bcbhzbGLp
	 CEtXZ74kja4cSjQNU0CqtAD82PX5To1LxBCq4DWOXhB8cGmvgDLYAHGY45bL+hRhw1
	 WqoSLo1aVW2fnrWCcbS+7/hHz25izTdL9pj4c4DIJavkqw4fhNkozWOvz2okFPbemC
	 jE09xSPhmZuVLf8utl+gcSM0SgTgPtdkKNHgQZeafbIiIdpP7qFxmWAJNOQtb7b+7/
	 CymffrCDTsXR3tXkTdcn1e+tnOymfF+IpzE48gPcDpLu3MAkE9h9bWHW+o/LmlQoQH
	 iTpPa83HsGdcQ==
Date: Sun, 28 Jul 2024 17:09:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: pressure bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <20240728170915.26b4a01d@jic23-huawei>
In-Reply-To: <20240725231039.614536-8-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
	<20240725231039.614536-8-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 01:10:39 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> This commit intends to add the old BMP085 sensor to the new IRQ interface
> of the sensor consistence. No functional changes intended.
> 
> The BMP085 sensor is equivalent with the BMP180 with the only difference of
> BMP085 having an extra interrupt pin to inform about an End of Conversion.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Trivial comments inline + as the build bot pointed out you can't use data from
one array to fill the other.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 72 +++++++++++++++++++++++-------
>  drivers/iio/pressure/bmp280-i2c.c  |  4 +-
>  drivers/iio/pressure/bmp280-spi.c  |  4 +-
>  drivers/iio/pressure/bmp280.h      |  1 +
>  4 files changed, 60 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 4238f37b7805..e4d017358b68 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -3104,13 +3104,19 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
>  	return IRQ_HANDLED;
>  }
>  
> -static int bmp085_fetch_eoc_irq(struct device *dev,
> -				const char *name,
> -				int irq,
> -				struct bmp280_data *data)
> +static int bmp085_trigger_probe(struct iio_dev *indio_dev)
>  {
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	struct device *dev = data->dev;
> +	struct fwnode_handle *fwnode;
>  	unsigned long irq_trig;
> -	int ret;
> +	int ret, irq;
> +
> +	fwnode = dev_fwnode(data->dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	irq = fwnode_irq_get(fwnode, 0);
>  
>  	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
>  	if (irq_trig != IRQF_TRIGGER_RISING) {
> @@ -3120,13 +3126,12 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
>  
>  	init_completion(&data->done);
>  
> -	ret = devm_request_threaded_irq(dev,
> -			irq,
> -			bmp085_eoc_irq,
> -			NULL,
> -			irq_trig,
> -			name,
> -			data);
> +	ret = devm_request_irq(dev,
> +			       irq,
> +			       bmp085_eoc_irq,
> +			       irq_trig,
> +			       indio_dev->name,
> +			       data);
Whilst here, put some of those parameters on the same line (staying below
80 chars).

>  	if (ret) {
>  		/* Bail out without IRQ but keep the driver in place */
>  		dev_err(dev, "unable to request DRDY IRQ\n");
> @@ -3137,6 +3142,44 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
>  	return 0;
>  }
>  
> +const struct bmp280_chip_info bmp085_chip_info = {
> +	.id_reg = bmp180_chip_info.id_reg,
As the build bot has pointed out you can't do this.
Annoying but just duplicate the original structure with whatever
changes you need.


