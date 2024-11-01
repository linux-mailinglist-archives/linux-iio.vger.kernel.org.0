Return-Path: <linux-iio+bounces-11815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A09B987B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 20:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5521C21D90
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE41D07BC;
	Fri,  1 Nov 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LwSQ9dA8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A51D0785
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489190; cv=none; b=PSDZEWuHgew9jByq3a1GQw87+QLLJxPl19lrHsWvDQHvdBp2ZGD3dPp3yXv/s5MyTuWgd1kH+IxK9ApHtTmbIj9+8rq3/ZMY+9WXdem4Fc73kFMIO28kXaqRz8/lvmju6f4JOEylkoXl/T8FCWogYumXHz54XRBkXYeaeaoodVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489190; c=relaxed/simple;
	bh=5YQIiDu0dUlJHULMrj11OKIb/F1m9NxdbYFo8bpLXbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nrQmxDsU7fAtA4rFbZDnijnxVNxA8zkUvp3uEzOsEKx63Fq3Wo4RcR1eTMbA12WVn9TabBUnduV3myft+x/AdIBULy8YrxgiJ1g1nDvM3i0N93XcHzp4QcbW5IhuYAUsNf2jDQBRJaPEuu3d+u/ZAoEz+xNMqxN0p2UEQ08bxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LwSQ9dA8; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-28cdd9d8d01so1239498fac.1
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730489185; x=1731093985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSXJbaaZjYaOy9jDlQqwtzCh35NpZ0KX5EKFSupi5Yw=;
        b=LwSQ9dA8reOOTsnRVD+Qk8RQHjAwDXy250S81qKE0tVH9VNlQpvwGI/aFPo/4US2gx
         Sc+EFiLoAyXIZsaaJUEjktSitacecrfX47p2kKl1+pNG0CB6RMcVAVsmIcAX+ZQu8Ayh
         MO4JjKpOy4nYV2P+G4wA7kH6nVBFsHIQ1C7e3m//6rdVbG3Nrqu6F8pS+OOKyuommSHe
         BZqGk9kvXkVfZMhzFfIalDToVUYajVz8FbS6PrT5eIqwj6XcfQ1OaLs+sT/gnx0Kvjvc
         gPXwuS0E1cdBo/uu3M/Pu3bcUDP+aMfOTTE0LRZIQpYZpsoUqq3dlfRiPtjz4qDvhMY5
         ivNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489185; x=1731093985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSXJbaaZjYaOy9jDlQqwtzCh35NpZ0KX5EKFSupi5Yw=;
        b=bnqj0/ff0IwjE87sEnHyuWqfaX6wyHyXN0JvqE2s45V4nB1ac/nAiNTBU4GLy2YnsD
         iFPT/RgIntv1InIMpQM1+cYfcJRAchAEGJjOmGt2OkojDzvvZ8pDX6rohpXQtRV2zCM5
         epSjYmC/yEe2eIRZC2Ns4pqXnLISyzGqWDiZMqEo/OFagyn0iyQLSQRhElVuGt6wLG/n
         SS6sMKOJBlEeixITFoBjl/tJmaoFW7JH4Abx0KAFaaWC9Rv9nEpepnFQckIw3x9OEWF1
         tZv0k64Ud5P7Ws4VQmimUSA35Z6ME+VzqancCcfOFSX5ODykBBG++u0sj7VaFZJFzZF0
         ooLw==
X-Forwarded-Encrypted: i=1; AJvYcCUA6QZ5zdiC0mOG8mQgVoHCBW561du16uEuS8XlxEWvH0/0NFUjO6NEvfwQVqH1LdGsrjWxKtptHxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQwI9N6oOMlW37N+a5CSIdUfmLdpwKwXVOGJ9zp2FSE35PLDQ
	+hHLuoh5zWv+44rDQBI7R8gdfXQ5Z5g+pCpOQLCEP3nudD6o1l6suUBk28grswU=
X-Google-Smtp-Source: AGHT+IFn0omlwGkmEwEHPxzlpz5Xt8pkBY2VI53QJJufULOaAOfpzCfWQfonqed9e6SbxptQhnksgQ==
X-Received: by 2002:a05:6870:ab8d:b0:278:222c:98c4 with SMTP id 586e51a60fabf-294647c553fmr10961567fac.21.1730489184823;
        Fri, 01 Nov 2024 12:26:24 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29487485e8csm1249796fac.17.2024.11.01.12.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 12:26:23 -0700 (PDT)
Message-ID: <bff6d5d6-1cbb-4447-9682-4c20223ee03e@baylibre.com>
Date: Fri, 1 Nov 2024 14:26:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] iio: adc: adi-axi-adc: add interface type
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-4-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241101112358.22996-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 6:23 AM, Antoniu Miclaus wrote:
> Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
> IP.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

> changes in v5:
>  - use IIO_BACKEND_INTERFACE_SERIAL_CMOS and IIO_BACKEND_INTERFACE_SERIAL_LVDS
>  drivers/iio/adc/adi-axi-adc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 5c8c87eb36d1..f6475bc93796 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -39,6 +39,9 @@
>  #define   ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
>  #define   ADI_AXI_REG_RSTN_RSTN			BIT(0)
>  
> +#define ADI_AXI_ADC_REG_CONFIG			0x000c
> +#define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
> +
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
> @@ -290,6 +293,25 @@ static int axi_adc_chan_disable(struct iio_backend *back, unsigned int chan)
>  				 ADI_AXI_REG_CHAN_CTRL_ENABLE);
>  }
>  
> +static int axi_adc_interface_type_get(struct iio_backend *back,
> +				      enum iio_backend_interface_type *type)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CONFIG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N)

FIELD_GET() also works here.

> +		*type = IIO_BACKEND_INTERFACE_SERIAL_CMOS;
> +	else
> +		*type = IIO_BACKEND_INTERFACE_SERIAL_LVDS;
> +
> +	return 0;
> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -337,6 +359,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.iodelay_set = axi_adc_iodelays_set,
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
> +	.interface_type_get = axi_adc_interface_type_get,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


