Return-Path: <linux-iio+bounces-18860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93059AA1566
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFEE16ACFE
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8910253951;
	Tue, 29 Apr 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="28KTo4U+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD025334D
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947361; cv=none; b=eja+jVCWjxfcwmN0bkpNVrDU9V+XSSvENKmzrw/O5WWRbIZxBCsReTll0UHypKQqQVurjhWsLpkT5uFYL77NE56oVwnITpUxGBXT43fBwxE7lNQgIxBJdF42MbzXZUUf1OIczLnbvPugBpC2VcTyqx+6cvaZ9aD46roeGkCH3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947361; c=relaxed/simple;
	bh=hd3+lVmsRDVjj+Z5GVr6xUAaSWueaTm/lJYeNOXKlcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MYciBwWmpGkeoiTA76jdmlTEj+9X3KbYqbmSaWPmO82p5fExmcHa8ZrWH5FsiBazS4Dwl7tgE/Bxb5huGR/GvIB0H121+a2lTKwm0l/gn2TUVSUShy4VZ3hExSgA7CLbX9bk5ILqsgG3oFybmL0521x7On9HfpWvmAN0ly5fSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=28KTo4U+; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60638c07cabso3594597eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745947358; x=1746552158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGhyF+xl7A86AqVMpy/9SlmHfbiCKP2Ou9wI7yu1X7Y=;
        b=28KTo4U+XNglsNOeg2Q0pntAd8AzxDZEiGpSh41iKHyWx4czyEGTiYG52uDnD1Ep1E
         No7OspR56hG/qYC1NHLy07wyBSong44oj1TagDZ0klKWXEaR5hfiohZS1KYUsN475dbY
         9T6utgXb4wMSf0AqcsIgtrWO82q5TrizuIma0UUq83rMDvNl++SeM4E0x6Y1Uog6sN1Z
         mg4urckmEUh/60dkewdHZwbAGdb25AINc0/DimOmUafjPJl2iD61bL20JKGiMgA7W+hc
         Ph2uzQ6iv0NrYn8s/hbUW/AH8b5T1V/T8LC9kIkB95JyfA81u2mq7J0CGP4XtbQeZPlV
         FNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947358; x=1746552158;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGhyF+xl7A86AqVMpy/9SlmHfbiCKP2Ou9wI7yu1X7Y=;
        b=aousGUHWx0J3eZnb2UGwv8oV4JBT2xAcWvmO7KCjqXCqaJqyIaWb4hpUxemtrEONSY
         ai+4n5Z7iU8NUJAW9PoNDK+kYZIjGgNzu9cIbQ4pPVS0gyqKW7BSt9izpQ7lsG3bdR3F
         D6LzxK8Mt6lNKxZBN0WL8XYy4XWDSKtMwrSy3dqjvXB/uthvYUT8lIRvDidMFPhCf8i7
         7/SCTC5wuUh7oLogdPS6KzYEBxfUouuuixOZajJXSBN0Td5p4Ua6FJzI5s+t8PdIQNkr
         Zk4oK/l2AAxPqG7m8jcsl1aWRnivBFhYiXoWzlZRf8HuH4ppD1UfcLgHx4uxxPz7CDtT
         S0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXn+Uytk6ORpFvSALtdYZdWAfjJA8SIHO5DDKDtebxv1AgTOty8aD/qvbE9pQ/DX9X7g5pQbe9/dFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGI9ggEQA0mtK2mAoLpqnMaAV9VL02u/4KapATkv8yTYrwZYI
	dwo+5WYDOL03DYDBm9PsYI1pINSyA9yDKgiYoDNu4RhYxFv1/669mzZjNmur+DQ=
X-Gm-Gg: ASbGncu+ZjgcqjEWTz95yL2Ai3nf1+rgo6xoLtTvVAryJLQJh7vsYANmWHvMhLA0vEd
	8LoHdOdSbKx2+jWnNOZUe6FsZ8TGqpDbFWbPDkrhGZVnXyKmSNEE955Mvlnf2OIRrbraGUgCD3K
	TAbAMsSshcnBJfmt5WV4icylikA1ux2fYJhTyeKhA8PA/+pN6tUcp4Wwoxiki3bDh8jw/e5x72V
	v5i2qwsbZLWqqVZPIAQVd4/+bZpbVL9TxfSYriszryD0zVzduQ4OFv0B8zChoedZHC2rc1BWrSu
	cv20AxqjIDWWXKa6/pe4BDsHxau7wHR0D0J7dy0K4ZFqaxWv8CDQgV8g+yTXLNm3PFWWHkvBaRr
	dbDC2Dfi8bOJakbE2oRS5lp4S8HnE
X-Google-Smtp-Source: AGHT+IGQmNgXh/vTAF4JQdFuX1/hGnU+mdkA5sH8NZCqQ59Hy4noA5TyHnFaxhEo4kCvtuKCNuMi8g==
X-Received: by 2002:a05:6871:3405:b0:29e:2da3:3f7b with SMTP id 586e51a60fabf-2da4841e18bmr1988174fac.7.1745947357870;
        Tue, 29 Apr 2025 10:22:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b314b5dsm377480a34.64.2025.04.29.10.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 10:22:37 -0700 (PDT)
Message-ID: <d21e4f98-0b9f-4a89-84ab-2460ead95d40@baylibre.com>
Date: Tue, 29 Apr 2025 12:22:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] iio: adc: adi-axi-adc: add sync enable/disable
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
 <20250425112538.59792-8-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250425112538.59792-8-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 6:25 AM, Antoniu Miclaus wrote:
> Add support for enabling/disabling the sync process used for data
> capture alignment.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - update the function to match the new backend interface.
>  drivers/iio/adc/adi-axi-adc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 2a3a6c3f5e59..9947be059f98 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -44,6 +44,7 @@
>  #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
>  
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
> +#define    AXI_AD408X_CTRL_SYNC_MSK		BIT(3)

If this bit applies to AXI ADC in general, then it shouldn't have AD408X in the
name. Or, if this is really specific to AD408X, then...

>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
>  #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> @@ -416,6 +417,22 @@ static int axi_adc_ad408x_filter_type_set(struct iio_backend *back,
>  				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
>  }
>  
> +static int axi_adc_sync_enable(struct iio_backend *back)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +
> +	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> +			       AXI_AD408X_CTRL_SYNC_MSK);
> +}
> +
> +static int axi_adc_sync_disable(struct iio_backend *back)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +
> +	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> +				 AXI_AD408X_CTRL_SYNC_MSK);
> +}

... these functions should have ad408x in the name to make that clear and ...

> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -559,6 +576,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.request_buffer = axi_adc_request_buffer,
>  	.free_buffer = axi_adc_free_buffer,
>  	.data_sample_trigger = axi_adc_data_sample_trigger,
> +	.data_alignment_enable = axi_adc_sync_enable,
> +	.data_alignment_disable = axi_adc_sync_disable,

... we shouldn't be adding them to the generic core ops.

>  	.iodelay_set = axi_adc_iodelays_set,
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
> @@ -605,6 +624,8 @@ static const struct iio_backend_ops adi_ad408x_ops = {
>  	.free_buffer = axi_adc_free_buffer,
>  	.data_sample_trigger = axi_adc_data_sample_trigger,
>  	.filter_type_set = axi_adc_ad408x_filter_type_set,
> +	.data_alignment_enable = axi_adc_sync_enable,
> +	.data_alignment_disable = axi_adc_sync_disable,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


