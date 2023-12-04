Return-Path: <linux-iio+bounces-588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31080388C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D25B1C20B65
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880552C1A6;
	Mon,  4 Dec 2023 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YousOfmM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FA2C19C;
	Mon,  4 Dec 2023 15:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5EFC433C8;
	Mon,  4 Dec 2023 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701703160;
	bh=5sEvSdS3ZKittuPMVcViM6IheLlMNVV6ts0oVk77otY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YousOfmMHBUnvlRCr32wRy8FZAF1dTCiHuVIv7Kp2hghkRxjzn4MqQ2IV42kUi7mm
	 O9QiotGnaRLRKMgVT9kSHYI+B0kNX5sGLb3YOcF/kzMaCF31Y2xt0yqhBWBqIRMDWq
	 uq5Arw2zDAQiMqdZtJirTTKNWaFMN4ppVhJsgzYHfyspehGngnpOAabogB9WgdXQnn
	 O0L+CzECjLKWu7s6MDvRCZY1fhRKbvtqjh7ujY9+PsMOHqFuWPemkJgn6KTSvMlH2b
	 Yjqm/OreLE8I7rJN96gXBgSlgoMwvs2dcppvhwEqvWaOMXxt3EldipR0L6XUx4VriV
	 gXJgWFPGyGguw==
Date: Mon, 4 Dec 2023 15:19:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 05/12] iio: adc: ad9467: don't ignore error codes
Message-ID: <20231204151910.6ab1728f@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:20:18 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Make sure functions that return errors are not ignored.
> 
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 368ea57be117..04474dbfa631 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mutex.h>
David noted this one...

>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -160,11 +161,12 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
>  	struct spi_device *spi = st->spi;
>  	int ret;
>  
> -	if (readval == NULL) {
> +	if (!readval) {

Nothing wrong with tidying this up if the !readval syntax is more common
in the driver, but it doesn't have anything to do with the fix, so not in this
patch.

>  		ret = ad9467_spi_write(spi, reg, writeval);
> -		ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
> -				 AN877_ADC_TRANSFER_SYNC);
> -		return ret;
> +		if (ret)
> +			return ret;
> +		return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
> +					AN877_ADC_TRANSFER_SYNC);
>  	}
>  
>  	ret = ad9467_spi_read(spi, reg);
> @@ -274,6 +276,8 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
>  	unsigned int i, vref_val;
unsigned and you check it for < 0 ..

>  
>  	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
> +	if (vref_val < 0)
> +		return vref_val;

int ret = ...

	vref_val = ret & info1->vref_mask; 
if not an error.


>  
>  	vref_val &= info1->vref_mask;
>  
> @@ -296,6 +300,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
>  	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
>  	unsigned int scale_val[2];
>  	unsigned int i;
> +	int ret;
>  
>  	if (val != 0)
>  		return -EINVAL;
> @@ -305,11 +310,13 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
>  		if (scale_val[0] != val || scale_val[1] != val2)
>  			continue;
>  
> -		ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
> -				 info->scale_table[i][1]);
> -		ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
> -				 AN877_ADC_TRANSFER_SYNC);
> -		return 0;
> +		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
> +				       info->scale_table[i][1]);
> +		if (ret < 0)
> +			return ret;
> +
> +		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
> +					AN877_ADC_TRANSFER_SYNC);
>  	}
>  
>  	return -EINVAL;
> 


