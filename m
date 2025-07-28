Return-Path: <linux-iio+bounces-22103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F576B13C25
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CCE188C5C8
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9DC27280F;
	Mon, 28 Jul 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXf2/+nF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B6272804;
	Mon, 28 Jul 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710787; cv=none; b=UtJhK659EVBZy+tAECamozaQ8feku//cq5qsK5f60gu13soJEB77c+JFrz5T4w1s+sL80ELcu81k61LQ07XaqpaIei7zqqDHn8vepX7wPlXVrtsvj+ofGBPkO2Dl/Q89gxghGigZSnpEjaUT6jKKkfOdxm1vSp1nljZdtVxdxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710787; c=relaxed/simple;
	bh=0o84i38T9pvqjzCREHxuGnFLiFQbUiNjH/f+5BHtDW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWQ7d76ieRe4dLRCMqB2pqSK7zdZ+D91LLkrEmpi89Z7ij3+J305ujeSJ/zm7+M7wN0mahR8fvw9k6ckZXy/c3tMznQzeZdgNytROW5LXUivWSdvwnMNbUCTxnzhGrPkHGfs4h9BEhC41tomGrM6YnlYIM/rWKr7suW7yjRyEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXf2/+nF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3824C4CEF7;
	Mon, 28 Jul 2025 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710787;
	bh=0o84i38T9pvqjzCREHxuGnFLiFQbUiNjH/f+5BHtDW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mXf2/+nFzENtmd8fC5UgIzY2kp+Z0Ba6ihP8jFcz6FdFxf+pR9vEEjPnCEcNxYXAK
	 QeMbVhBM232KoS87rF5q8N4tNBz0zvbd7pWzwL2PdpVI0nkap62+tdHmqoVNAgfQJG
	 SSGqV9R2SdvM3UXf1Z9tyyS1bQUo4VYNdiazeFK71YcUaats3lYiuAHNqs8+92W2or
	 kHl7E+tkowhR9+y1el99IPsm4/K97g0tLEyjKnLsxvQmSpccbU59n3VkTIzvp6RmfQ
	 AhNYY4RQtZSOCzAp8DczociipCwA0XuBIz+1X++nZzJpGa/Hh1cTxY2fXHqKnj3VLJ
	 iqI11dksnXHJw==
Date: Mon, 28 Jul 2025 14:52:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: ltr390: Add debugfs register access
 support
Message-ID: <20250728145259.753b3999@jic23-huawei>
In-Reply-To: <20250724143945.636380-1-akshayaj.lkd@gmail.com>
References: <20250724143945.636380-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 20:09:39 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Add support for debugfs_reg_access through the driver's iio_info structure
> to enable low-level register read/write access for debugging.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>

>  drivers/iio/light/ltr390.c | 53 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index ee59bbb8aa09..b1028d027e1b 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -38,12 +38,21 @@
>  #define LTR390_ALS_UVS_GAIN		0x05
>  #define LTR390_PART_ID			0x06
>  #define LTR390_MAIN_STATUS		0x07
> +
>  #define LTR390_ALS_DATA			0x0D
> +#define LTR390_ALS_DATA_BYTE(n)		((LTR390_ALS_DATA) + (n))
						(LTR390_ALS_DATA + (n))

etc  There is no benefit in brackets around the bit that isn't a parameter
of the macro that I can see.


> +
>  #define LTR390_UVS_DATA			0x10
> +#define LTR390_UVS_DATA_BYTE(n)		((LTR390_UVS_DATA) + (n))
> +
>  #define LTR390_INT_CFG			0x19
>  #define LTR390_INT_PST			0x1A
> +
>  #define LTR390_THRESH_UP		0x21
> +#define LTR390_THRESH_UP_BYTE(n)	((LTR390_THRESH_UP) + (n))
> +
>  #define LTR390_THRESH_LOW		0x24
> +#define LTR390_THRESH_LOW_BYTE(n)	((LTR390_THRESH_LOW) + (n))
>  
>  #define LTR390_PART_NUMBER_ID		0xb
>  #define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
> @@ -98,11 +107,40 @@ struct ltr390_data {
>  	int int_time_us;
>  };
>  
> +static const struct regmap_range ltr390_readable_reg_ranges[] = {
> +	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
> +	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_MAIN_STATUS),
> +	regmap_reg_range(LTR390_ALS_DATA_BYTE(0), LTR390_ALS_DATA_BYTE(2)),
> +	regmap_reg_range(LTR390_UVS_DATA_BYTE(0), LTR390_UVS_DATA_BYTE(2)),

If we are doing maximum length ranges can we not combine the two above?
Looks to be 0xd,0xe,0xf,0x10,0x11 and 0x012, so a continuous range similar
to the thresholds below.

> +	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
> +	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
> +};

Thanks,

Jonathan


