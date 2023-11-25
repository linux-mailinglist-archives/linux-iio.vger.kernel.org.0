Return-Path: <linux-iio+bounces-350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB67F8C46
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BE22814D4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6A229428;
	Sat, 25 Nov 2023 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tej3oOMZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106AD2940E;
	Sat, 25 Nov 2023 16:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F4C433C7;
	Sat, 25 Nov 2023 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700928798;
	bh=SC6r2enSVMPPwuOivo7HJSkxH1xec3XgzYtzK0Z2Zwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tej3oOMZ8KX/iNNwFL13dS9OhCryXzjQfCAw8XR/RyaYPW/6VuknIZbW/dAk0Bn1Q
	 0+OTogNXfNyWTesm5fU0ptjcICj1FXobceg61uV/FKIxarpRx66+SsgLOJ0pmmTA7v
	 ntLVacLrbTzsMizOsLsp+DByRdWVYjt1ROGi5G09LxFUPwh9YLavlV2A4umUMyJDrF
	 3lt5K+kpp/6wz0Fnj/fu95Va4nmzCjLAz0zsOqWpjDjZqapHzgGz7P97FJSfbsmTSJ
	 YgTXOploLlKKRKM+9m/r4cczUsNlP6SgHDv/TJ3/w5pZUkthfmHsY3y8fceSlMdfQ8
	 67nZ/9LV3Kohg==
Date: Sat, 25 Nov 2023 16:13:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
 <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] iio: adc: ad7091r-base: Set alert config and
 drvdata
Message-ID: <20231125161313.71aa345b@jic23-huawei>
In-Reply-To: <b485b1ccafad79f9ac3bb1a6b5e6d68b24ad4ad5.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
	<b485b1ccafad79f9ac3bb1a6b5e6d68b24ad4ad5.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 13:40:16 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

Hi Marcelo,

Thanks for the patch. Content looks fine but it wants breaking up into
2 fixes and one reformat.

> Write 1 to bit 4 in the configuration register to set ALERT/BUSY/GPO pin
> to be used as ALERT.

That's s one fix.

> Set device driver data so it can be retrieved when handling alert
> events, avoiding null pointer dereference.

That's one fix - so this should be at least 2 patches.

> 
> Fixes: <ca69300173b6> (iio: adc: Add support for AD7091R5 ADC)
That's not the syntax for a fixes tag.

> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/adc/ad7091r-base.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 8e252cde735b..3ecac3164446 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -28,6 +28,7 @@
>  #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
>  
>  /* AD7091R_REG_CONF */
> +#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
>  #define AD7091R_REG_CONF_AUTO   BIT(8)
>  #define AD7091R_REG_CONF_CMD    BIT(10)
>  
> @@ -232,9 +233,16 @@ int ad7091r_probe(struct device *dev, const char *name,
>  	iio_dev->channels = chip_info->channels;
>  
>  	if (irq) {
> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
> +		if (ret)
> +			return ret;
> +
> +		dev_set_drvdata(st->dev, iio_dev);
>  		ret = devm_request_threaded_irq(dev, irq, NULL,
> -				ad7091r_event_handler,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
> +						ad7091r_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT, name, st);

This is alignment cleanup. Should not be in a fix.

>  		if (ret)
>  			return ret;
>  	}


