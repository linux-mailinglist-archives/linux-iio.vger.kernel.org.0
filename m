Return-Path: <linux-iio+bounces-20313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D7AD12FE
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB5D3A6F16
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD424EA90;
	Sun,  8 Jun 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU4auRJh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4627261B;
	Sun,  8 Jun 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749396468; cv=none; b=TpH+SzifeoFSEzuC7xGyP7l/yy/Uz8aUhzBaaLMBi8Xy5sAmXSJJvZRROMZCvfL4NiS71+ktxI/A8enPghJcOKUmYQTunGd9uGzjIu59iVZc9UZjr+XeywgodzBYR1BrWXskqQS9Qnmqets2l75d9Vp5pWdHdzntQyLYSrzxYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749396468; c=relaxed/simple;
	bh=EuSTOe6/qMN3/LBueliKwj7QBZAIU9oGW22JAbGeBY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBlz6MfLLE+4cpq4BEUSTDJWSxzfK7qiqIVOMZkLdHYHngR1K1+jzfK4RSdwofC3dER6s8VK9BaJS0OvsrFNmhPRhEm5ptJd9JhlogYP+r2VY7FMSTRiG4rH1dTi5eTofUSdlYsFoyZo5H3tF08E7E6BRgoyjizOoq/Z1EaJmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU4auRJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB8DC4CEF1;
	Sun,  8 Jun 2025 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749396467;
	bh=EuSTOe6/qMN3/LBueliKwj7QBZAIU9oGW22JAbGeBY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KU4auRJhrFD+9wRLtcvxQxP99v7SW27CMo5pPLquBnWAVYKIWOW+RE9gwqbJi2LVv
	 sBznw7WPziN5Dw/a6rQpdJGIGYs9QuPGd/InRhwkoKeLt8oElMMF/YJDrIz/QPLgpw
	 YfzSgaaxRUyagEIJk4iw7Av/NbYcweme5fkjlrm6xVAfgFRka7aNdxuRb/+gyFN/cb
	 d0+pPMmFfLtOV/hpxno9RNaGD28ZnttDm9tDlLo+PABZHBxM5DKkS++H5xsBCZiEp8
	 JddDyx9ug4BEPmc1FaJ+kkBD5NU7FDrbPh+qWhIhZfz6ciAYbQqFua4KXME2VDbvcz
	 oQh0IB3mv+Lxw==
Date: Sun, 8 Jun 2025 16:27:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/11] iio: accel: adxl313: add function to enable
 measurement
Message-ID: <20250608162738.407c7d20@jic23-huawei>
In-Reply-To: <20250601172139.59156-5-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Jun 2025 17:21:32 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Rework controlling measurement and standby of the sensor. Therefore,
> replace writing the register directly by encapsulating this and dealing
> with the return value in a separte function to enable and disable
> measurement. This will help to avoid redundant code in all locations
> where the sensor configuration needs to be adjusted, thus measurement will
> be set to standby, in follow up patches.
> 
> Further, reduce the control mask to only the measurement bit. The sleep bit
> actually controls a different behavior (not just putting the sensor to
> standby for configuration, but turning it into sleep mode) and it is not
> used so far. In consequence, there is no need to cover sleep bit and
> measurement with the same mask.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
This is a good bit to have as a precursor patch (as you have done)
because it is refactoring the existing code.  It doesn't stand on it's
own though given for now there is only one caller, so I won't pick it up
until the patch that uses it is ready to go.

Jonathan

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
>  }
>  
>  /**


