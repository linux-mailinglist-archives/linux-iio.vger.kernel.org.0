Return-Path: <linux-iio+bounces-1621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A682C4D3
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 18:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E91D1C22386
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF73E2263D;
	Fri, 12 Jan 2024 17:39:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640922634;
	Fri, 12 Jan 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBTJ53gg0z6K5kq;
	Sat, 13 Jan 2024 01:37:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E0D0B140A36;
	Sat, 13 Jan 2024 01:39:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 17:39:21 +0000
Date: Fri, 12 Jan 2024 17:39:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
CC: <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
Subject: Re: [PATCH v5 8/8] iio: adc: adi-axi-adc: move to backend framework
Message-ID: <20240112173920.000014c6@Huawei.com>
In-Reply-To: <20240112-iio-backend-v5-8-bdecad041ab4@analog.com>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
	<20240112-iio-backend-v5-8-bdecad041ab4@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 12 Jan 2024 17:40:22 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Move to the IIO backend framework. Devices supported by adi-axi-adc now
> register themselves as backend devices.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

A few quick drive by comments whist I wait for a build to finish...

> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 0f21d1d98b9f..741b53c25bb1 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -8,6 +8,7 @@
>>  static int adi_axi_adc_probe(struct platform_device *pdev)
>  {
...

> @@ -390,37 +205,23 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (cl->info->version > ver) {
> +	if (*expected_ver > ver) {
>  		dev_err(&pdev->dev,
>  			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",

Format doesn't match with later.

> -			ADI_AXI_PCORE_VER_MAJOR(cl->info->version),
> -			ADI_AXI_PCORE_VER_MINOR(cl->info->version),
> -			ADI_AXI_PCORE_VER_PATCH(cl->info->version),
> +			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> +			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> +			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
>  			ADI_AXI_PCORE_VER_MAJOR(ver),
>  			ADI_AXI_PCORE_VER_MINOR(ver),
>  			ADI_AXI_PCORE_VER_PATCH(ver));
>  		return -ENODEV;
>  	}
>  
> -	indio_dev->info = &adi_axi_adc_info;
> -	indio_dev->name = "adi-axi-adc";
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->num_channels = conv->chip_info->num_channels;
> -	indio_dev->channels = conv->chip_info->channels;
> -
> -	ret = adi_axi_adc_config_dma_buffer(&pdev->dev, indio_dev);
> +	ret = devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generic, st);
>  	if (ret)
>  		return ret;
>  
> -	ret = adi_axi_adc_setup_channels(&pdev->dev, st);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
> +	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%d) probed\n",
I'd rip this (I think) unrelated change out to reduce noise in here somewhat.
I'm curious though as it's still %c above.


>  		 ADI_AXI_PCORE_VER_MAJOR(ver),
>  		 ADI_AXI_PCORE_VER_MINOR(ver),
>  		 ADI_AXI_PCORE_VER_PATCH(ver));
> @@ -428,6 +229,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	return 0;
>  }




