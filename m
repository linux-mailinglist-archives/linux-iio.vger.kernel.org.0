Return-Path: <linux-iio+bounces-19886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2755AC34D0
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45483A596B
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6641F3B96;
	Sun, 25 May 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuHf3UVO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502315E97;
	Sun, 25 May 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748178897; cv=none; b=qWenTCZR1fi22PHOYzOaYaDAvwzTNVLz5kmfwj9zUEkluIFONmq4az4vd+Om6re/e1kueaBBeuCMn34ou51EL2HDDW3W3YMoD3MGJ3EMlfTOXatepTssdS81Fa5FpNbBnUz+0tHh6GDsTOakzJwHoldzJYdD0S/dt3R0C0G4BYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748178897; c=relaxed/simple;
	bh=rlxKz0XcixSYwe2iLlZbx9iqRm7pJ5TiBDIAEPXRUlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkZeu5+0B0OtfAFStUfLGWJ3+9mK7Ycc4I0qXbTeHgwdGIrG4DokmdWvVkCoCrKBde0zGRRmdq8YQArlm8645j9xHtGX40AoJR4ghENPaJbbOyIf9z6CbTWvN3+KWOoybePJdP48sBglzMa5ZwcH7m22TDWnR7SZe09RpPDKk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuHf3UVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A742C4CEEA;
	Sun, 25 May 2025 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748178896;
	bh=rlxKz0XcixSYwe2iLlZbx9iqRm7pJ5TiBDIAEPXRUlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WuHf3UVOsSds/JnbJq7TrAzPp6+VX+PWHVbAwTCbAyawc2iiYJiaueDwCEEryfhEr
	 CqOux1mD+7LdYtcmJbfCpyyG5ZJJeC/zmIYi1izxlZm80qGn46hHI91U2FM6yqWKAw
	 3Id1sq+NHaxUvQIJDn27TS3289yTLHSvAkEnYfRZc8FsZ3yVZ8rBEfI5TZ6OUjdlSX
	 8VxnLkFD99sYpwORVwn2teNNPcGhoWkodHF5MuApzW6+XbmdtgQxX9RhqXsRPwQqPA
	 zaT+CRW8iTMKPfDLTgQW5ZsvWTmpP9z9pimWK6pl14lrgonrV3UPGlFxxLFijIZVNM
	 DG3SHyKs76HBA==
Date: Sun, 25 May 2025 14:14:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/12] iio: accel: adxl313: implement power-save on
 inactivity
Message-ID: <20250525141446.47e4440a@jic23-huawei>
In-Reply-To: <20250523223523.35218-12-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-12-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:22 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Link activity and inactivity to indicate the internal power-saving state.
> Add auto-sleep to be linked to inactivity.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl313.h      |  3 +++
>  drivers/iio/accel/adxl313_core.c | 25 +++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> index 374e4bfe6e05..fae2378fa4ed 100644
> --- a/drivers/iio/accel/adxl313.h
> +++ b/drivers/iio/accel/adxl313.h
> @@ -41,6 +41,9 @@
>  #define ADXL313_RATE_BASE		6
>  
>  #define ADXL313_POWER_CTL_MSK		BIT(3)
> +#define ADXL313_POWER_CTL_INACT_MSK	GENMASK(5, 4)
> +#define ADXL313_POWER_CTL_LINK		BIT(5)
> +#define ADXL313_POWER_CTL_AUTO_SLEEP	BIT(4)
>  
>  #define ADXL313_RANGE_MSK		GENMASK(1, 0)
>  #define ADXL313_RANGE_MAX		3
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index f7baca814da7..d65380901f66 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -389,6 +389,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
>  	unsigned int axis_ctrl;
>  	unsigned int threshold;
>  	unsigned int inact_time_s;
> +	int act_en, inact_en;
>  	bool en;
>  	int ret;
>  
> @@ -415,8 +416,28 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
>  		en = en && inact_time_s;
>  	}
>  
> -	return regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> -				  adxl313_act_int_reg[type], en);
> +	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> +				 adxl313_act_int_reg[type], en);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Advanced power saving: Set sleep and link bit only when ACT and INACT
> +	 * are set. Check enable against regmap cached values.

No need to mention regmap cache.  That's just an optimization to avoid us
going and asking the device for register contents.  It should not be
a fundamental part of how the driver works - rather it should just allow
us to not bother with our own optimizations when it already does the job.

> +	 */
> +	act_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
> +	if (act_en < 0)
> +		return act_en;
> +
> +	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
> +	if (inact_en < 0)
> +		return inact_en;
> +
> +	en = en && act_en && inact_en;
> +
> +	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
> +				  (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK),
> +				  en);

For the clearing of link there advice in the spec to exit measurement mode and reenter it
that I'm not spotting here.  See "Link bit" section.


>  }
>  
>  static int adxl313_read_raw(struct iio_dev *indio_dev,


