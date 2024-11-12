Return-Path: <linux-iio+bounces-12190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528479C6243
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 21:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D435C1F228EF
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD789219E31;
	Tue, 12 Nov 2024 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NNgq+tKe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A72219CB4
	for <linux-iio@vger.kernel.org>; Tue, 12 Nov 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442269; cv=none; b=ABFChn4kq+bQyMHPVvYBJ4jK4tL5m+F2O61D6LNjkqyV1/M2lPJ2yZm+hwO6KRBxWISLXTzyca2AQSirF4nzqvXJyml1QeHY7hgaZCnd1S0/4FSmSUZLiS4jcgbZl7LkCWxCo+Y5dM/4/zDo0lM9K5bewgrpynewrtc0fCVJ4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442269; c=relaxed/simple;
	bh=fteZp6EQzbZ911bBZrJ6izyV2r05kYP0Pbayo+oFsoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jd39NPtPr1j7uJzDRu9KjuYMreflnkDYnVfDGih0OVPm0m+JTOBQl6+aevYv2W7v/CimTZ7yBF+od98VyP7k/ie65N2nw7qbLadAPvXkwiWb5zc1ieOKOkM264ULMO+5v0TebkRgJOzdmweBWo/cKu4fudFVPThpGpLg8aaB7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NNgq+tKe; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso3729461fac.1
        for <linux-iio@vger.kernel.org>; Tue, 12 Nov 2024 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731442266; x=1732047066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbULEEF6aEIKAIsr8AyCaOWu9fse79T/kPGd6JJ3qrc=;
        b=NNgq+tKeUvh6Mvuzx9PNbxxx+sZYwO6lvLj5chZLNXCxsDR9/8p8easKSPVhwTSUIk
         9azGamJBkTwCb69IsSu0gSj7BNCnDUGj8E/wO9tuNko2IOZ6YOZM/+VSAKpsqXtGu3RQ
         IoB5NQzIYkSYz68qaff3g9fJc0TmPGnKALXomif7/+j0XsD5Qu5Z4elLpl1tLUCtedtQ
         7C9IgvxC6j3oILuQYFy40uV6h+VXNruN2TIOhkY5f0c6teHYTgaoqO631+0xJAJf4K60
         A5gQabP4XgeM6/YT2teJxCekLVo5BC+/qwJ6hfIk+V5EYS/h8JOGfBnEFDnLt7Lv5HA9
         5tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731442266; x=1732047066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbULEEF6aEIKAIsr8AyCaOWu9fse79T/kPGd6JJ3qrc=;
        b=oQwN2YSdD3LHO5PYrWAjJ+2pSMefd/MhvBaFmfRZedt7WNtomb07kmAVHrlVxLvljr
         nCeSnrgplDHYySryf58tl8D42GrzwCG6IHWwElSVwS4iTjFFDqtTSOrDPKN2N2W8WFmH
         fELB3ef8PN2oZLCZmP1T17KqJMx94YLEJ6ivwxUn85GpV9fnxPQS8AFwk9fO0MT9bIPa
         daYWVfwG38TSjXDDukWmkzSWg0PL1yI2LdwTZONiu8M/YlID8PReGDMQC/ibaypDLMe5
         t3Foh1QZDj5MKmdQCr8OVCWyCCbrSnVTkd1KjedsXOVKRdX+CNLWa0I42I+dSbIsPg2+
         cF9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/vyhJV3OYkq8zwfD424r92YfCRDOK9W6UVx+wrnnza4xnEJjdahSvEoXJSjrUBLEKjAADjBIBx9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtstar/y888Rt+B1yMgvQq5wQttNIUVaaUx5THDKvH/ih36HB
	DgtEARb7msOOh7uf3wQAeqNN7MKJG63pRcRtCA5z2IrbX1FSbqdoF6TCfJ7vTHY=
X-Google-Smtp-Source: AGHT+IGoJL24zLoc7lvgsozAskpdsa9m6cU2yrPoyHpCZDMO49GHOItUjTiLdNCCiXLwQXg7LdgbkQ==
X-Received: by 2002:a05:6871:378f:b0:27b:5890:bd38 with SMTP id 586e51a60fabf-295e8ccb3b6mr417797fac.7.1731442266484;
        Tue, 12 Nov 2024 12:11:06 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e92c5ab0sm55643fac.39.2024.11.12.12.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:11:05 -0800 (PST)
Message-ID: <c42a631a-4d07-44ec-9cec-862ca25af15e@baylibre.com>
Date: Tue, 12 Nov 2024 14:11:05 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] iio: adc: adi-axi-adc: set data format
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
 <20241111121203.3699-6-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241111121203.3699-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 6:12 AM, Antoniu Miclaus wrote:
> Add support for selecting the data format within the AXI ADC ip.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
>  - use switch case
>  - add macro definition for packet format mask and sizes 
>  drivers/iio/adc/adi-axi-adc.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index f6475bc93796..9bf967d5b730 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -45,6 +45,12 @@
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define   AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK	GENMASK(1, 0)
> +#define   AD485X_PACKET_FORMAT_20BIT		0x0
> +#define   AD485X_PACKET_FORMAT_24BIT		0x1
> +#define   AD485X_PACKET_FORMAT_32BIT		0x2
> +
>  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
>  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
>  
> @@ -312,6 +318,29 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
>  	return 0;
>  }
>  
> +static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	unsigned int val;
> +
> +	switch (size) {

What happened to 16 bit for 16-bit chips?

Ideally there should be an identification register we can read or
a compatible string from the devicetree that says if the HDL was
compiled for a 16-bit or 20-bit chip and we would have two different
versions of this function and pick one based on what HDL is being
used.

> +	case 20:
> +		val = AD485X_PACKET_FORMAT_20BIT;
> +		break;
> +	case 24:
> +		val = AD485X_PACKET_FORMAT_24BIT;
> +		break;
> +	case 32:
> +		val = AD485X_PACKET_FORMAT_32BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				  AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK, val);
> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -360,6 +389,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
> +	.data_size_set = axi_adc_data_size_set,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


