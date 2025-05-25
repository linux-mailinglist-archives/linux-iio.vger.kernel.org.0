Return-Path: <linux-iio+bounces-19876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C27DDAC348C
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D287ACAF0
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CD71F0E50;
	Sun, 25 May 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFYdmNaK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12993D984;
	Sun, 25 May 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748176020; cv=none; b=kY53/H/Ja1FFiolu/AvEBkh0pgkKmUa8GemL4nx119N7SMP7hWKqLOopQAjT+woHg1eBaUVVwmayqXWFeq1MSGUjFUEqErg/Rc6g52ZKdHTQdTa5rnYgEzQ70Q65wS5oZhERJ1lHzspyguwZYZXA0CdCDSmjoC+O2/wmlN5FAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748176020; c=relaxed/simple;
	bh=g6gSSAx8RMkQAqBEmyaI2M4+2uwDbQxsl5jyh2U6Ad8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rtj0VbB8K9f/Z6oRFzyg6DD8Is4yBcW1njbOIIt2sKBQ97UP2Ym0/97aNnGpQoE/p59aDERhWvUQGzQeyxs0sHEQu3lpboCG+7f2tm0udn2PorPz/8MiqrZw+7laSZkCeT5xy/i6j7ujH3+3edaIiZZ23NKA23as27KSLRXZs7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFYdmNaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347B6C4CEEA;
	Sun, 25 May 2025 12:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748176019;
	bh=g6gSSAx8RMkQAqBEmyaI2M4+2uwDbQxsl5jyh2U6Ad8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mFYdmNaKTm/t5X/F/oR29UyZyyIGJiqEvFbkC3atb5+h1NyPDo9qqFgdAkhZL8K5R
	 rcHagxt+S1LXLsplwEg9G/bviU32dScfjnXSQWHE7tvWmtbuecN8fdUkjx7872ecxs
	 045UtYK4AhdBW/GOkggpfcYyW6eGv8KMveYoOTzBV+LK/AXwlTfn2M8KIcDu3+3r8N
	 BDCVfR9r2VSrJQWV6g1AiapPWF6qJXydWlmu3qZZ4CawghxoPn5vPqqp2kfw/nn9nl
	 QtgESpZJR/WHmGS0OAc0dt8MNiZ51a+JwskyJn3xzqrhqGWKtaNUOvnmIJ9eG8qGIS
	 mo5gEdiD/2K6A==
Date: Sun, 25 May 2025 13:26:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/12] iio: accel: adxl313: add function to enable
 measurement
Message-ID: <20250525132652.0167f617@jic23-huawei>
In-Reply-To: <20250523223523.35218-6-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:16 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a function to enable measurement. The data-sheet recomments turning of
> measurement while modifying certain config registers. This is a preparatory
> step.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl313.h      |  3 +--
>  drivers/iio/accel/adxl313_core.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> index fc937bdf83b6..9bf2facdbf87 100644
> --- a/drivers/iio/accel/adxl313.h
> +++ b/drivers/iio/accel/adxl313.h
> @@ -36,8 +36,7 @@
>  #define ADXL313_RATE_MSK		GENMASK(3, 0)
>  #define ADXL313_RATE_BASE		6
>  
> -#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
> -#define ADXL313_MEASUREMENT_MODE	BIT(3)
> +#define ADXL313_POWER_CTL_MSK		BIT(3)
>  
>  #define ADXL313_RANGE_MSK		GENMASK(1, 0)
>  #define ADXL313_RANGE_MAX		3
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 0c893c286017..6170c9daa30f 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -63,6 +63,12 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
>  
> +static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
> +{
> +	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
> +				  ADXL313_POWER_CTL_MSK, en);
> +}
> +
>  static int adxl312_check_id(struct device *dev,
>  			    struct adxl313_data *data)
>  {
> @@ -410,9 +416,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
>  	}
>  
>  	/* Enables measurement mode */
> -	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
> -				  ADXL313_POWER_CTL_MSK,
> -				  ADXL313_MEASUREMENT_MODE);
> +	return adxl313_set_measure_en(data, true);
The original code is also clearing the sleep bit.

I'd expect the patch description to have stated why no longer doing that
is fine. I guess no one ever sets it?

>  }
>  
>  /**


