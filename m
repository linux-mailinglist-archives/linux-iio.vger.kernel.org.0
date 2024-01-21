Return-Path: <linux-iio+bounces-1807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1EB83572C
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 18:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5E11F2136C
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5C381CB;
	Sun, 21 Jan 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb4/byoO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB7364A4;
	Sun, 21 Jan 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705859541; cv=none; b=OVdAyBWr+jW0nV1dSPInHL1LgUUYnPKLIQmFNCFd8X3sdP+c98HHIvfUOWaSwiah4syLwg1J6MrApUcupuS74g9ZcczLQtpvXk6Vwa1JuFf04x5Z5YcbkZsbS8Q6XYacV7WIZdqwE9DPBlS+MDrMwVuUy+6yTHYOLBzuCuzwAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705859541; c=relaxed/simple;
	bh=wpcZtPsKklpxeY1mKokdYDx9wl7TJiKcaWenw0suIRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXlV0fHsdUJ4cfk7H/l1Y6gIL7sXjoBRV1z1UUa6SjDWS6xtDARxKVLHRt1s0aq/pVtYNH4Vn1wIejUABiqVbL+90Ycj/V07CP3ctvBDKfwWGfrcvxRFkesPDsKLG73Uj7B2wTQEbO75mj3qmwAVsrHgMezUoJW//tq7eiJFPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb4/byoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD73C433F1;
	Sun, 21 Jan 2024 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705859540;
	bh=wpcZtPsKklpxeY1mKokdYDx9wl7TJiKcaWenw0suIRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zb4/byoO9MRcnOkxO73cerBS81NmKBWlkqxpwpPKm1niGLHa+w1F+zdgAvvkogY6+
	 M9iCaI2ojzU8owyc5tCyDAtRt0AEGaCJZMbSHV51dN48zXI3kxrH18el6FwRJwwN04
	 qXs1H+mhmjkVZdJ+yVUrz0FjLrQksy6bFJaISN2jzbQaAuzKDVMUgdMX2+hRYD4Ve/
	 GmpfWYZ8eKo/SSv+B1eBQIWY28SNL2EDIDK6+w7lXu9pmmbAJtP2oSz873L6Yy7Sgb
	 x98dx/Xu4aizqYNFo7i88alydyQxz2OQBXq+wrBdSXJun0ewu4soU8bMkiygHuWNtE
	 +xGH1DnGciegQ==
Date: Sun, 21 Jan 2024 17:52:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v6 7/8] iio: adc: ad9467: convert to backend framework
Message-ID: <20240121175206.598bd93a@jic23-huawei>
In-Reply-To: <20240119-iio-backend-v6-7-189536c35a05@analog.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
	<20240119-iio-backend-v6-7-189536c35a05@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 17:00:53 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Convert the driver to use the new IIO backend framework. The device
> functionality is expected to be the same (meaning no added or removed
> features).
> 
> Also note this patch effectively breaks ABI and that's needed so we can
> properly support this device and add needed features making use of the
> new IIO framework.

A statement here on why we think no one will notice or that, if anyone does,
they can be helped around the incompatibility by Analog tech support etc
would be good to have here.

I'm happy to accept that is this the case but such a statement in this patch
description would be good to avoid scaring people too much with the ABI breakage.

One trivial comment inline.

Jonathan


> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |   2 +-
>  drivers/iio/adc/ad9467.c | 272 +++++++++++++++++++++++++++++++----------------
>  2 files changed, 181 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 10316e15c954..ff88e5b29f33 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -324,7 +324,7 @@ config AD799X
>  config AD9467
>  	tristate "Analog Devices AD9467 High Speed ADC driver"
>  	depends on SPI
> -	depends on ADI_AXI_ADC
> +	select IIO_BACKEND
>  	help
>  	  Say yes here to build support for Analog Devices:
>  	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 6581fce4ba95..9e448c4c6b92 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -17,13 +17,12 @@
>  #include <linux/of.h>
>  
>
> -static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
> +static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
>  {
> -	const struct adi_axi_adc_chip_info *info = conv->chip_info;
> -	const struct ad9467_chip_info *info1 = to_ad9467_chip_info(info);
> -	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
> +	const struct ad9467_chip_info *info = st->info;
>  	unsigned int i, vref_val;
>  	int ret;
>  
> @@ -282,25 +278,24 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
>  	if (ret < 0)
>  		return ret;
>  
> -	vref_val = ret & info1->vref_mask;
> +	vref_val = ret & info->vref_mask;
>  
> -	for (i = 0; i < info->num_scales; i++) {
> +	for (i = 0; i < st->info->num_scales; i++) {

Use local variable info for this as well, and the other one below.

>  		if (vref_val == info->scale_table[i][1])
>  			break;
>  	}
>  
> -	if (i == info->num_scales)
> +	if (i == st->info->num_scales)
>  		return -ERANGE;
>  
> -	__ad9467_get_scale(conv, i, val, val2);
> +	__ad9467_get_scale(st, i, val, val2);
>  
>  	return IIO_VAL_INT_PLUS_MICRO;
>  }



