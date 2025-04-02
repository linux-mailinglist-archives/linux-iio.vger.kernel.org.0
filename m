Return-Path: <linux-iio+bounces-17562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F8A79705
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 23:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54E27A227C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F019ABB6;
	Wed,  2 Apr 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SS+3ShvU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626B1F09B8
	for <linux-iio@vger.kernel.org>; Wed,  2 Apr 2025 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627854; cv=none; b=j/Dn2WJinsoIpjeSb5ophrFJvIcW+H4KunzZsmzULYdae6XrQb2pz4o2vhco40GApeaFOnNN1eiGb/V9PghRrrL459kJyZGv4MfQ9SwIkVUgFDR3HgA+uTLVBuG5Oh51rYEG+SAKyp5TmJVjHg2nfdhoSrAVLoR8PC/TPyknX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627854; c=relaxed/simple;
	bh=9bl7Al8TcmucJOZ1piV9ws4Byidkq2KDSTJ0/uuMIxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWqEc6YmOwk3oDTB8js8RLdQ/n6UeN0um7HwHxARt7zsnH7cMsYSaI9tdOjb5Eaz4ZYUYzLm702vkjhDgCUi1uioLHHVS0Uzz4eysMw6P7hKcl7uSB1Z+HtITXvlVpjkjb1/GQTKywoIehkCcG647xgGTit6yvwMjQaSht2J24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SS+3ShvU; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72a4793d4e2so167835a34.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Apr 2025 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743627851; x=1744232651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHVmZKYaU8HGt5WXf4UlaDB5Ev+RO33OxezFlT9Bya8=;
        b=SS+3ShvUqPMNzb+6vyxvjILN42fyLoWSpwng8YktRmx8r/JW8F7p7zZv49W/pzdSDd
         QYz83PaJTvypPQ16hx9Pyd5H5L6h6/eXeKAV5KkZUi2EfdlRvPRi8bRtdeDJnOF6p3Du
         yAiFPMS4vr9CFrx8Bnmhq6J6qTLkwLzwEK1NkN0t2ok1qwZceu9bCi+aOiMpkpc2sVfU
         JYZE/8kj51njSsqXSV36xkh5YcMN7ai+sLeo75V40Eb/wEbqrLP4sbD573E36eQae1av
         x3CxtBG1Zsr6T1ek1vvB+9mQ+JKiuR6Bz7OAZnPrUVb4482la3OnlVBY9ZdfUy9Ki+Zx
         AwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743627851; x=1744232651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHVmZKYaU8HGt5WXf4UlaDB5Ev+RO33OxezFlT9Bya8=;
        b=vj5hgpNCPkLeUyWO/LoruvMaruADLuFk+7vVgviADH5NnpCWT6xWVlNtTePBtbz3ip
         GDRuKr0WD/YOsevhzTfhxQRZHMfw+lrs3w/aCJjh1/fVvjiy8NGgLs6ZW6Eur3zTCDdY
         XnGmNI4eoI7nTVkEmacHu1JMVHxtfTZTSsj+HscfaEW/OdF0nHluKH+A8QBEoFfiXC8I
         UBtQrrObIGYtbXBnP2HTTWdhGMOfBItDoWfPIYAGFtyUop7qk/va6KOt5Uq84QNJLLHO
         KICulwOHWtg6kxosQr2WFU4miCu4FeBPdGe0aUGd+Lb2IECB5ToOgAMsfFMXvmE6YNJj
         aPUg==
X-Forwarded-Encrypted: i=1; AJvYcCWzcd9T7lkJYNtPtJFDEamboinqoOpKFPh+xYRP3+IGObfd5LJj2xjn1wwMeyA4QoH69P633JYp2XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBIAxUSQOvj6DVUkv6MYoAS5/936rMG1ygFP71kTdkpbiT+x5
	HCtOK6rCiru+HkcHl5wZ8sbY3YItw5QVW1tXyzzS6/oetDN6+MDt2Qs4+/4ihB4=
X-Gm-Gg: ASbGncvO/DW01Fa06GLnCbtVWdkVSjD2Gk0dVGqEMc4fKBFt0vOH0maOvomqgPSTlD+
	VD0KQjWpboOraWeJSVJfvxMPnh8DtX85MkvG5luaKREiIzEt28aCbJlVQoCrDMeic9miYDwEHSz
	0DEwQF+odpkSQcgP+OXkYC+jfu2M2siPg6wMVFhPbdchUj95wpItn8Pqir6vr5QXwFwSVAyycy5
	FCV5Cq2PU+mnpgQmRpQflFIkssuJEaFdg1VneGpY0gdMJ6SLJ+weY+dYfeu2eRF8klGdlrJjU+Y
	7zqX2Yr4ugDSO19MrTfVtjMol2B1k5WB9mvY2P5jhP3SgGMcno8jTUYu+oyGqKjaWkXa0f0raQ+
	QTfJs/Q==
X-Google-Smtp-Source: AGHT+IEm6MEi4+/aDKfkND/DEKKXrfRXQ/0xgqv8Xqad87ZQdhhW5rDXRo5jjzJ8TnjkHIGd06rHlA==
X-Received: by 2002:a05:6830:61c5:b0:72c:320b:fc8c with SMTP id 46e09a7af769-72dae738ce3mr6840871a34.21.1743627851291;
        Wed, 02 Apr 2025 14:04:11 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c58285654sm2386290a34.57.2025.04.02.14.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:04:10 -0700 (PDT)
Message-ID: <4c3e0d23-2582-4acf-8e90-542c8f8c385f@baylibre.com>
Date: Wed, 2 Apr 2025 16:04:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iio: adc: ti-adc128s052: Simplify using
 be16_to_cpu()
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1743573284.git.mazziesaccount@gmail.com>
 <feeabbfd3d3916c7497dfd94423ff83ef5f654f1.1743573284.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <feeabbfd3d3916c7497dfd94423ff83ef5f654f1.1743573284.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 1:09 AM, Matti Vaittinen wrote:
> The register data is 12-bit big-endian data. Use be16_to_cpu() to do
> the conversion, and simple bitwise AND for masking to make it more
> obvious.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
> v1 => v2:
>  - Fix commit msg to reflect the fact there was no bug
>  - Drop Fixes tag
>  - Use union for rx / tx buffer to avoid casting
>  - Keep the shared message protected by the mutex
> ---
>  drivers/iio/adc/ti-adc128s052.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index a456ea78462f..3e69a5fce010 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -28,32 +28,34 @@ struct adc128 {
>  	struct regulator *reg;
>  	struct mutex lock;
>  
> -	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
> +	union {
> +		__be16 rx_buffer;
> +		u8 tx_buffer[2];
> +	} __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  {
>  	int ret;
> +	char *msg = &adc->tx_buffer[0];
>  
>  	mutex_lock(&adc->lock);
>  
> -	adc->buffer[0] = channel << 3;
> -	adc->buffer[1] = 0;
> +	msg[0] = channel << 3;
> +	msg[1] = 0;
>  
> -	ret = spi_write(adc->spi, &adc->buffer, 2);
> +	ret = spi_write(adc->spi, msg, sizeof(adc->tx_buffer));
>  	if (ret < 0) {
>  		mutex_unlock(&adc->lock);
>  		return ret;
>  	}
>  
> -	ret = spi_read(adc->spi, &adc->buffer, 2);
> -
> +	ret = spi_read(adc->spi, &adc->rx_buffer, 2);
>  	mutex_unlock(&adc->lock);
> -
>  	if (ret < 0)
>  		return ret;
>  
> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> +	return be16_to_cpu(adc->rx_buffer) & 0xFFF;


The cast isn't exactly beautiful, but this would save a lot of
lines of diff and a few lines of code by avoiding the need for
the union and the local msg variable.

	return be16_to_cpup((__be16 *)adc->buffer) & 0xFFF;

>  }
>  
>  static int adc128_read_raw(struct iio_dev *indio_dev,


