Return-Path: <linux-iio+bounces-18018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D0A86E3F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A0B16FF00
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908477104;
	Sat, 12 Apr 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSCqJOD0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBA1662E7;
	Sat, 12 Apr 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744477481; cv=none; b=H/G0pkTmvvUfMoEreAboTDCiY34MKFMdLCQSoChSEmIVwI4n1w/bFxRRLddiPguSB/LRYDk1H5lf3GOJov8GZuSGisg1gL1vw/lUGFq+2QpDOKHIEGQpx7+R2YkNYtPl8OmlmKcvtwQUXLc8IesMfaGkl9J+u3tuTgqrnM2QHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744477481; c=relaxed/simple;
	bh=9Hh3y1adPkFB/uc/FlYasejGcYGxbWwcKdlxTL4OqIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIVaBncpEf/QozMHo0QKVgTJCYp7oauaEO4VVPx79hf8VwUbB0Tkm6vAdF1Lted4s/OPTSRNlMR66BfGFkL/2MqMFcw8Kph5D0m7Q9CSN7HbKcC9AULUCYEyPzIQnHOAmTKC10FSV0z9O3lb1jrphw/YfnqHGuoiCDRHj0msadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSCqJOD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D6C4CEE3;
	Sat, 12 Apr 2025 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744477480;
	bh=9Hh3y1adPkFB/uc/FlYasejGcYGxbWwcKdlxTL4OqIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uSCqJOD0q7qxBhWbnZqOqowbX2wFxyckklTAjY+NzSz/14k7zP2UKKOken3E/2IQP
	 KAkUFVuOAb+eTF32Q0hwI2TTw/yxge8vkmdOhOc7KxN6goY071Ka/QLEoZW8Me1emr
	 QQPMtAdMBoxTBUr/4jT/dbTkP2kVc+fudwt14O7/3OcYJx54mmmhZ3gGN6gnc+6Gef
	 NjGegD2/FYs2u0xDa0/ALm4tkDwDfDDDiS/RFxW0nuxZlVnZec6uBrkLziFI4MfhMz
	 ddhAQCx7AHSTwPKPAgXl7QrBa0gYiOK2K8acVRghE45ZN92+c9Tw1y42sz+W5w2udD
	 qe3a2oRZ33HVA==
Date: Sat, 12 Apr 2025 18:04:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/13] iio: adc: adi-axi-adc: add sync status
Message-ID: <20250412180434.34f1426b@jic23-huawei>
In-Reply-To: <20250411123627.6114-11-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
	<20250411123627.6114-11-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 15:36:24 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for checking the ADC sync status.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v2.
>  drivers/iio/adc/adi-axi-adc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 017685854895..0d12c0121bbc 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -56,6 +56,9 @@
>  #define   AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK	BIT(1)
>  #define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
>  
> +#define ADI_AXI_ADC_REG_SYNC_STATUS		0x0068
> +#define   ADI_AXI_ADC_SYNC			BIT(0)
> +
>  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
>  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
>  
> @@ -453,6 +456,21 @@ static int axi_adc_ad408x_self_sync_disable(struct iio_backend *back)
>  				 AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK);
>  }
>  
> +static int axi_adc_sync_status_get(struct iio_backend *back, bool *sync_en)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_SYNC_STATUS, &val);
> +	if (ret)
> +		return ret;
> +
> +	*sync_en = (bool)FIELD_GET(ADI_AXI_ADC_SYNC, val);

Trivial but implicit casting from a bool to an int is fine.  I.e. drop
the (bool) as it doesn't add anything.

> +
> +	return 0;
> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -600,6 +618,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
> +	.sync_status_get = axi_adc_sync_status_get,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };
> @@ -647,6 +666,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
>  	.data_alignment_disable = axi_adc_ad408x_bitslip_disable,
>  	.self_sync_enable = axi_adc_ad408x_self_sync_enable,
>  	.self_sync_disable = axi_adc_ad408x_self_sync_disable,
> +	.sync_status_get = axi_adc_sync_status_get,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


