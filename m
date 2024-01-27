Return-Path: <linux-iio+bounces-1946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA6E83EDDE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 16:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567431F21757
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191528DD3;
	Sat, 27 Jan 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGr2fchC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6029D08;
	Sat, 27 Jan 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368866; cv=none; b=K5A+rHwi4ryG2c0Yqm7zgRxM1t2d2aUDKARcwxCSFOD/LXovrVrsiEXgruURPajn5Fdz4pol7+hObrA1ZQbSn10Gn0AAYt/DKBMdUiMLDUAAAS6c41dvwJ680npPlEQh0YA7cHoAmk3nddwfptQ1n/xpMVM5MKYizgUTNEuyKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368866; c=relaxed/simple;
	bh=z0pu8Sga/qDq7lbfHrE53M/tvuGDdpv66kUE2iwHZ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oh3p+QX8J5epWyWrWllx+sxuy3l5yhXOnJFTIVRUuvnYHyVjffxbuMYQ3oA4jk9nnMVHMjEg8BQ7kkspAd0zUMfpnsl/z97mEUdi3iiuMvMcRzw2NGFquhl+0UV8z1NFAXYQINEzcrMaIt2wg9nYpF5iA6ABtd/myTTSS8buuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGr2fchC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC4AC433C7;
	Sat, 27 Jan 2024 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706368865;
	bh=z0pu8Sga/qDq7lbfHrE53M/tvuGDdpv66kUE2iwHZ6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGr2fchCLmpIGnkzdcLImquRSPrbmINqIw8eDw2AW22n/Zsv4wAP7be9r96NDspGP
	 eS2gg8XeK7mtUFHZcH+ok2MsNp2x2y234gV1TGqkBCA12i6L/WCn7ZZRM0W1jaywOy
	 Cyg7eYtXcBPp54XV/mEuPJFeMaNkGJ7OIZB+tTYr8rZdTLZxl7CE44jviJP9l4GzO/
	 g6JLxJdTxUNiSwGiF9D4Ta3Ff2xJBhh9vDqNNJfPoPzAX9cZReUVxaCLp927NVHEoa
	 tHH3lJ67VgfIno75z9uvOJ2eQ2fGqUvQrSGw6Hzf/Oiq7Is9UHkoLllF/j8fOEIZu4
	 1476RfC/JsdUQ==
Date: Sat, 27 Jan 2024 15:20:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v7 9/9] iio: adc: adi-axi-adc: move to backend framework
Message-ID: <20240127152049.22a8ce74@jic23-huawei>
In-Reply-To: <20240123-iio-backend-v7-9-1bff236b8693@analog.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	<20240123-iio-backend-v7-9-1bff236b8693@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 16:14:30 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Move to the IIO backend framework. Devices supported by adi-axi-adc now
> register themselves as backend devices.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
I'm still not getting the %d vs %c change..

Otherwise LGTM

> -	if (cl->info->version > ver) {
> +	if (*expected_ver > ver) {
>  		dev_err(&pdev->dev,
> -			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> -			ADI_AXI_PCORE_VER_MAJOR(cl->info->version),
> -			ADI_AXI_PCORE_VER_MINOR(cl->info->version),
> -			ADI_AXI_PCORE_VER_PATCH(cl->info->version),
> +			"IP core version is too old. Expected %d.%.2d.%d, Reported %d.%.2d.%c\n",

If it's a valid change fine, but then I'd expect both %c to change.
I'd also expect it to be in a separate patch with an explanation of why.

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

This should also be in that separate patch fixing up this formatting.

>  		 ADI_AXI_PCORE_VER_MAJOR(ver),
>  		 ADI_AXI_PCORE_VER_MINOR(ver),
>  		 ADI_AXI_PCORE_VER_PATCH(ver));
> @@ -428,6 +229,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	return 0;
>  }


