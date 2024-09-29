Return-Path: <linux-iio+bounces-9884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1844698964D
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 18:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4131F22732
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0F17BB11;
	Sun, 29 Sep 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ139Y0Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48379FD;
	Sun, 29 Sep 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628535; cv=none; b=dAhoL3dkl0ISjhl8DkoBkRCfJQf+9hYuHXRIqULxW1QbXAhcLPEDQR3LrU7+mHrxdbT7u9v2H1y51D7G6U1XPExX9kLzr8Xbki0wgehdyghv2vnyC7ANESVMQkb3RNR5jpZ5kv452ZMPepHxz4RUUL5LLIbtK/M/7O2nKDm0TQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628535; c=relaxed/simple;
	bh=vxIOftNGf+6LFdoEM3akH8I2x6IeDSOWCFcqei83no8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC7X93tAbl3svrfyNQ5c3vPu47cvgopaVgZ2qdpk3y5eiZtVEf/+NIbZfIssKuvxT8uFJRRnt4r5XQzieDNaGeOk/vnoRgvjuFma1KtTQPEjVlwsdvuEZCpXNfCsDRvWsas+fhzvpDY8YQpM5Y0M4w09I+bgcc1ugM1Vr8TIujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ139Y0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29C9C4CEC5;
	Sun, 29 Sep 2024 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727628534;
	bh=vxIOftNGf+6LFdoEM3akH8I2x6IeDSOWCFcqei83no8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jJ139Y0Yzu67wlybm7X/TZi3kfFERmxj8Nfh43zpw94sY1ckRghyDCsHCnd38zCVl
	 N7inZTAjQRy1qwZV+pRLfNXzcnIdxyOVLpAbWeFo8eNkFjOUU2OJEY70IpKyDx+uGS
	 HZmw59SaYPnRoIaq0sbVTFOu2T62TC+RietWetuViDlSIe1JLYDes6pR5VB1oCHEVd
	 NyOKQ0WQrEGNEvT7MDkOUmvhvSSWsG1RAzUsr0JRjitebh5cp9LcIwGfN9y/TWJ8x8
	 LhncbnH+rQoUo4WL7iWsqxAzaEXWYdvB4YMpZJJGB+smHw4kBFCRcuVDKrq1yYeGeZ
	 mXgYSdxVG0cPw==
Date: Sun, 29 Sep 2024 17:48:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, lars@metafoo.de, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH] iio: adc: mt6360-adc: Converted to use
 get_unaligned_be16()
Message-ID: <20240929174845.5bac3f62@jic23-huawei>
In-Reply-To: <20240928161108.163647-1-abhashkumarjha123@gmail.com>
References: <20240928161108.163647-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Sep 2024 21:41:08 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Changed the manual shifting and adding of bytes to use
> get_unaligned_be16() api instead.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Looks simple so I've applied it, but plenty of time for
additional reviews to come in.

Jonathan

> ---
>  drivers/iio/adc/mt6360-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> index 3710473e5..91befe2cd 100644
> --- a/drivers/iio/adc/mt6360-adc.c
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -124,7 +124,7 @@ static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int
>  		usleep_range(ADC_LOOP_TIME_US / 2, ADC_LOOP_TIME_US);
>  	}
>  
> -	*val = rpt[1] << 8 | rpt[2];
> +	*val = get_unaligned_be16(&rpt[1]);
>  	ret = IIO_VAL_INT;
>  
>  out_adc_conv:


