Return-Path: <linux-iio+bounces-8752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED795DD4A
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 12:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C961D1C210DB
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325B3155346;
	Sat, 24 Aug 2024 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmbB+T0G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03114D6F7;
	Sat, 24 Aug 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724493780; cv=none; b=nC57hYT0Ecip2XVNyTR6RJhRmXWbpL5JCH8d1fGS51pJGle3aIbuIxpc6feTVNIFqO15G5JV+FXa9zJo42LzWYmm+VjLIaMq5huj1TN6VJnLpZBbyx8rwsG7XwBUI9MK7vYjx/C2Oxz/bjUHfCRASzib6GI9h/jrkPH1OkL0hL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724493780; c=relaxed/simple;
	bh=gEss3k3hNjGY8pGqol7gjXQ/eBnIIuOWnz3frtQtm2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWHPADOcgzDtx9O0Vc5R2RvAV+nclyDBIjzuGOxxX5LbupdSWm6Tg6r063hQh8HSUlcf26eqH1eIDYVgcP3PyMV2wJ+QAropb/OiwfNdIjeC9dIoav5uyVpRO4ETJUq33idCHtEgzDU70RIOZFcZ/nsyxmuwO96+IWSFOeJdbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmbB+T0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAE2C32781;
	Sat, 24 Aug 2024 10:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724493779;
	bh=gEss3k3hNjGY8pGqol7gjXQ/eBnIIuOWnz3frtQtm2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mmbB+T0GYRYkT1+CzN822JhehSykt+PEuef+5GJK7eTD6/9aTREfNJ4fXFgp1zEzI
	 t3a6pZb1RQKB43Pj2SfnYbl8xmP/4ffyCbii+6C/51owU+K3f+j3nV2q0z1sjZtNdP
	 faJGZXjTtBYLaNUwlDYWEulp5ryT+FGpnI893iRjyaGlgdnjC5GYikRhLaCjdfKOKk
	 arFhmDe5PaxIQe7hE/wTtcuivVT37QeDz13P0YkcXNUIlHa2exeKCgoUKSO5mMVZsU
	 U2yv9J3n+vdjm6Nek2udcPB322iTl2v8vKK8KP5Ih+NbqyxrsklsS8MrHBsncw3m3t
	 fPGAD9P5G3mGw==
Date: Sat, 24 Aug 2024 11:02:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: pressure: bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <20240824110242.1de08d96@jic23-huawei>
In-Reply-To: <20240823181714.64545-8-vassilisamir@gmail.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
	<20240823181714.64545-8-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 20:17:14 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> This commit intends to add the old BMP085 sensor to the new IRQ interface
> of the sensor consistence. No functional changes intended.

interface of the driver for consistence

> 
> The BMP085 sensor is equivalent with the BMP180 with the only difference of
> BMP085 having an extra interrupt pin to inform about an End of Conversion.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 68 ++++++++++++++++++++++--------
>  drivers/iio/pressure/bmp280-i2c.c  |  4 +-
>  drivers/iio/pressure/bmp280-spi.c  |  4 +-
>  drivers/iio/pressure/bmp280.h      |  1 +
>  4 files changed, 56 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index f5268a13bfdb..1d27777d8a2c 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -3058,13 +3058,19 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
>  	return IRQ_HANDLED;
>  }
>  
> -static int bmp085_fetch_eoc_irq(struct device *dev,
> -				const char *name,
> -				int irq,
> -				struct bmp280_data *data)
> +static int bmp085_trigger_probe(struct iio_dev *indio_dev)
>  {
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	struct device *dev = data->dev;
> +	struct fwnode_handle *fwnode;
>  	unsigned long irq_trig;
> -	int ret;
> +	int ret, irq;
> +
> +	fwnode = dev_fwnode(data->dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	irq = fwnode_irq_get(fwnode, 0);

Should check this + as Andy pointed out in earlier review this
call will return an error if fwnode not present anyway so can skip
earlier check.
see fwnode_call_int_op() definition.

Otherwise, Andy has given some detailed review. I wouldn't suggest
applying the style cleanup to existing code but he's entirely
correct that we can make the stuff being touched anyway easier
to read.

The more functional stuff maybe needs to be looked at in other
drivers though.

Jonathan

