Return-Path: <linux-iio+bounces-22464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D45FB1EA51
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44129A07D10
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC5727EFEF;
	Fri,  8 Aug 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go5/5BA+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28F2750ED;
	Fri,  8 Aug 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663024; cv=none; b=I0Zk3XZ2X8TRMi+ul0Cnh2lMkdy0OtLgJ8UOPSCA7RrYkiLqH3vRBIiFAl3RkcuwueuPVro59d3y4YdY+kPuKv6M0Aa+uBuyqCFWO2djzst5KunmC1e+0EV7s4ykvke7B9NZ2ErWCtUnXhswYKDxGZujvs/aqYL8C6b0kk/Llck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663024; c=relaxed/simple;
	bh=DtU9jEY3LwH49Q0ZMHpA8Bnrf5sEH3YFNsLyxNclX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRSBXWTtwjQMujoFX1MciebpLlgpYF49aN2luEnXPNeZTfSIEl7hbp9AY6kfU2/hMXR3Qx67x9ZoFID/R9sdDety67uc6jCNKxY83mHBGv8XvERncgRD+p+BfxR9F8FtR9zEHBatx6V7tJAC3+M2TfNT0P1kDKjtrxPpmemVUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go5/5BA+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70744318bb3so19130746d6.3;
        Fri, 08 Aug 2025 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754663021; x=1755267821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1zPzUFUv/zyatupFCi5Bzm9po7cPCCGYJYFMabs0Gm4=;
        b=Go5/5BA+OcT7NQf/cH0vq3WUXoMv8KTUDKWYRED3/1CzZ3ivd6kirNpdbzsBClvGIg
         1jXUTrbgczFqLebmMA97rsQkkCILMCU3pWrwPhrFNcQE76RBE3EGANUu85iRi+cr/mb4
         YQmBlIG8YG+pYvNyzig8S87hcCmz+KgceyDG6KFIY7hTRVSKr1gSohH/HQSWpixovuX1
         skEFfdAFuZ+CH0GYn3ICteTVZJYFE/bFvq42JCh+BV7prkAuRhAKBULkrxIX7jcT+wKB
         1X/w624W2Inm61tCSRPX0inhAdFp3N7Q/Wm3HeL3VovwzOm+N/tsDnbWhk4E8nDCg2db
         ypPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663021; x=1755267821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zPzUFUv/zyatupFCi5Bzm9po7cPCCGYJYFMabs0Gm4=;
        b=h90SOd+3bXpLx6PKqB60QyPvCswdsyCGBZb7BEHPSEa3wsV1502BSTxIelSw8mBCMq
         fibSv1TJgEfYjVIPCnqyXpxyj/rzzJUssga9OiAlD+A4fNc5+cBL1sWr9yksojDL6kAU
         oy1nNmM4YVJIOFKAj3kt2kYUoPn3zfLTxd8lYtQ3fyl//tbrKAyiijA5GSrod7USGHPk
         nzKYzf2BgP/JEMkDJOMdTWExOc6GriwCY55pQBQLCvZRrqZMxKzOXgoSuJ3kuswEK95J
         h+nqBpdxvDoxiAoDxmPelqxF1vUcbdjgGpowv/BJM0+kqx4b4EiSAf1Jr2pFhOOZOCoe
         L6YA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ10uRyj+D77LuVRpM6gQ9FcLVuIoe1DT+lOnW6EaAW4tQ5s1HPfvD0h2XcLAKYnlHcty9y2Dfd06q@vger.kernel.org, AJvYcCV/xMMooFPTXtTYOUWiRsAs9OZ/d5+tu+zga+r4otckIORoWCVdH3yiBZ1W1E+RTv9tPs5cJOq08S0Dp3q4@vger.kernel.org, AJvYcCXsyZUPiqNJkaoakKVybIfVcE1MtDVN+jK/udiPKb5s5enFcMnFk+GqjNnJOR2NP0T+g/YgEpU1L6N+@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSxlDTulcLpV0mBSNE8lDB51KPx5roQ26ZEamtZNEvX7sRsBN
	ikkGbw3Hj/MK2CP1b3tC6Rwzig4YlSQurUeHrVu1rdrHcNEgtKD/hKYq
X-Gm-Gg: ASbGncuSFTKSh0q+0PvMo8X2kk0U0al1Fga7RgMKBaDtb/kb+mkBJTHNNpfT1d6GbrD
	sWZZjt/hpMpKqNy3NmjpFKsFJdPlBV6M8jRuO4P0M6XEfMEF10eZfXCzLps+zeHai2e82/Uw2FM
	5UU/UT5u/Y3dIRBLMYsrd9bHFaNf06fBekJohx7/DhPXpXMD2F3RcdbePKRshEfu8AWqd1nuJlF
	uCwi1s2Uc9u8xH9vT1mrKASAtEQbtGZFuP13xPuf/QRUxHqR7kI6W80TqAFNTaDp+MLjJiruj+K
	Mpfk9RuAubYqF8lTm6BLlbNCEFm1k8iX+pxWOH6PLy3Bg18LsZZL/gn+Y1X1ZSX3TrYaGKtVKA/
	qN164Q5FHIrJpPozi/hln+Sb4
X-Google-Smtp-Source: AGHT+IEakrZlxdSDWbU6urrh2LZv71gA0Sm8Hhk5We4J6qo3HG6kj1nQ4DgoO2znlAE6zUkpF8Dc0w==
X-Received: by 2002:a05:6214:f21:b0:707:63b8:b3f9 with SMTP id 6a1803df08f44-7099a1cf2a6mr47390976d6.3.1754663021167;
        Fri, 08 Aug 2025 07:23:41 -0700 (PDT)
Received: from nsa ([87.249.138.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca5897bsm115034186d6.39.2025.08.08.07.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:23:40 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:23:55 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] iio: adc: ad7476: Conditionally call convstart
Message-ID: <lnehdamxzehdsos2ksfmbxy4hub7femah77vl3rvh67nhcffy7@ynrqs7j76djj>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
 <57284a156afeb1531fae39897eba4e73d90fa5b9.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57284a156afeb1531fae39897eba4e73d90fa5b9.1754641960.git.mazziesaccount@gmail.com>

On Fri, Aug 08, 2025 at 11:54:09AM +0300, Matti Vaittinen wrote:
> The ad7476 supports two IC variants which may have a 'convstart' -GPIO
> for starting the conversion. Currently the driver calls a function which
> tries to access the GPIO for all of the IC variants, whether they
> support 'convstart' or not. This is not an error because this function
> returns early if GPIO information is not populated.
> 
> We can do a tad better by calling this function only for the ICs which
> have the 'convstart' by providing a function pointer to the convstart
> function from the chip_info structure, and calling this function only
> for the ICs which have the function pointer set.
> 
> This does also allow to support ICs which require different convstart
> handling than the currently supported ICs.
> 
> Call convstart function only on the ICs which can support it and allow
> IC-specific convstart functions for the ICs which require different
> handling.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
>  v2 => v3:
>  - Use indirect call to convstart (via function pointer) also from the
>    ad7476_scan_direct().
>  - Adapt to the change which returned the chip_info pointer back to the
>    driver's state structure.
> 
>  v1 => v2:
>  - Adapt to the change which removed the chip_info pointer from the
>   driver's state structure.
> 
> The follow-up patch adding support for the ROHM BD79105 will bring
> different 'convstart' functions in use. The IC specific pointer will
> also prepare the way for this.
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7476.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index ad9e629f0cbd..6cb2cbeafbd3 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -31,6 +31,7 @@ struct ad7476_chip_info {
>  	unsigned int			int_vref_mv;
>  	struct iio_chan_spec		channel[2];
>  	void (*reset)(struct ad7476_state *);
> +	void (*conversion_pre_op)(struct ad7476_state *st);
>  	bool				has_vref;
>  	bool				has_vdrive;
>  };
> @@ -70,7 +71,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	struct ad7476_state *st = iio_priv(indio_dev);
>  	int b_sent;
>  
> -	ad7091_convst(st);
> +	if (st->chip_info->conversion_pre_op)
> +		st->chip_info->conversion_pre_op(st);
>  
>  	b_sent = spi_sync(st->spi, &st->msg);
>  	if (b_sent < 0)
> @@ -94,7 +96,8 @@ static int ad7476_scan_direct(struct ad7476_state *st)
>  {
>  	int ret;
>  
> -	ad7091_convst(st);
> +	if (st->chip_info->conversion_pre_op)
> +		st->chip_info->conversion_pre_op(st);
>  
>  	ret = spi_sync(st->spi, &st->msg);
>  	if (ret)
> @@ -160,12 +163,14 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  static const struct ad7476_chip_info ad7091_chip_info = {
>  	.channel[0] = AD7091R_CHAN(12),
>  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	.conversion_pre_op = ad7091_convst,
>  	.reset = ad7091_reset,
>  };
>  
>  static const struct ad7476_chip_info ad7091r_chip_info = {
>  	.channel[0] = AD7091R_CHAN(12),
>  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	.conversion_pre_op = ad7091_convst,
>  	.int_vref_mv = 2500,
>  	.has_vref = true,
>  	.reset = ad7091_reset,
> -- 
> 2.50.1
> 



