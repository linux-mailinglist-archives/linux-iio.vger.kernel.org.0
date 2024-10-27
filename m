Return-Path: <linux-iio+bounces-11398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB80C9B1D93
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 13:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F5B1F215D6
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3D14B941;
	Sun, 27 Oct 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZHtwAl4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B671747;
	Sun, 27 Oct 2024 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030688; cv=none; b=I/VZfpFRjR20t4iOsocPgKny2yD/A3oOChW/v6F2GqBiJkVhLocacuTt482Ts1e+dTEIxDmY6BNDkmcUb4P5rY2jdDKEqy3Y1Wpq+mqrWyHaYTQS9CLYilxgxKLmKuSKTlwtrlII7e36le27SxMoR3+roPEKbRZB7dz8I6C3kd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030688; c=relaxed/simple;
	bh=rEeuT4721V3IdmzMnFRS5E3GS9UL13xeeJrz0S9lWfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZscX3jFir7Mic48CNPO+Al9vkd9Al8ZnoV216LwFXwBbHTWPr/WyTHcgDl9UAe5UPYv7bNxwvYrjSwu80U9XJtrR8/iCm0qjzjkC3FtEQVRh5NB8mq9hxK1ptjWu2MtR89Bftz5L7l8+HuKS7YsRD1VQ1JQ4OyDE3g9NGhY3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZHtwAl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7967FC4CEC3;
	Sun, 27 Oct 2024 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730030687;
	bh=rEeuT4721V3IdmzMnFRS5E3GS9UL13xeeJrz0S9lWfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZHtwAl4r4k296EG1ppZ9njff2FkJnBBLgqR5bf9PBBlQrWADYE1AzmU+XsRKahiB
	 UkVZKTUr5SVIsyFmX9gWvEiPLe0nYZButH2wub3L80IwD/00rv2nZBEXpeDLxHrxYX
	 5FSrg4kL4oCDLWVlq2ybDBRLw9ZQBXWMJYvxeUUqSuph9Kx6v5Jta6hH9tpQpznG75
	 NucdJH6xaI/kMGqBIDuUdOm4iYhyU37fkRf9m+tfet3wsN11FCTDhZoD4Lw0sFitPs
	 TAVTRvUXyr2QEKAgcPzyI3TwTd9NO+DbebioQMiO3lci0UjxjnBRvQFqE+gFG42WVU
	 ueACumbcjle/w==
Date: Sun, 27 Oct 2024 12:04:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Dumitru
 Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: ad_sigma_delta: Add support for reading
 irq status using a GPIO
Message-ID: <20241027120439.664bc74f@jic23-huawei>
In-Reply-To: <20241024171703.201436-7-u.kleine-koenig@baylibre.com>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
	<20241024171703.201436-7-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 19:17:04 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Some of the ADCs by Analog signal their irq condition on the MISO line.
> So typically that line is connected to an SPI controller and a GPIO. The
> GPIO is used as input and the respective interrupt is enabled when the
> last SPI transfer is completed.
>=20
> Depending on the GPIO controller the toggling MISO line might make the
> interrupt pending even while it's masked. In that case the irq handler
> is called immediately after irq_enable() and so before the device
> actually pulls that line low which results in non-sense values being
> reported to the upper layers.
>=20
> The only way to find out if the line was actually pulled low is to read
> the GPIO. (There is a flag in AD7124's status register that also signals
> if an interrupt was asserted, but reading that register toggles the MISO
> line and so might trigger another spurious interrupt.)
>=20
> Add the possibility to specify an interrupt GPIO in the machine
> description instead of a plain interrupt. This GPIO is used as interrupt
> source and to check if the irq line is actually active in the irq
> handler.

Maybe we should just implement polling instead and never enable the interru=
pt
for cases like this?

I'm not sure if it is the device assumptions that are wrong wrt to the Linux
interrupt model, or the GPIO/IRQ chip you have doing something it shouldn't.
I am worried this solution is fragile.

Polling was never in the driver because the interrupt is always wired
but if we need it to get around the fact it is wired, but to a pin we can't
really use as an interrupt, then maybe it is time to add polling.
(probably just a fixed delay and check the status register).

>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 36 +++++++++++++++++++++-----
>  include/linux/iio/adc/ad_sigma_delta.h |  1 +
>  2 files changed, 31 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index e2bed2d648f2..d35602cfb093 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -539,12 +539,29 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq=
, void *private)
>  {
>  	struct ad_sigma_delta *sigma_delta =3D private;
> =20
> -	complete(&sigma_delta->completion);
> -	disable_irq_nosync(irq);
> -	sigma_delta->irq_dis =3D true;
> -	iio_trigger_poll(sigma_delta->trig);
> +	/*
> +	 * AD7124 and a few others use the same physical line for interrupt
> +	 * reporting (nRDY) and MISO.

This is pretty common, so I'd drop the 'and a few others' bit.

> +	 * As MISO toggles when reading a register, this likely results in a
> +	 * pending interrupt. This has two consequences: a) The irq might
> +	 * trigger immediately after it's enabled even though the conversion
> +	 * isn't done yet; and b) checking the STATUS register's nRDY flag is
> +	 * off-limits as reading that would trigger another irq event.
> +	 *
> +	 * So read the MOSI line as GPIO (if available) and only trigger the irq
> +	 * if the line is active.
> +	 */
> =20
> -	return IRQ_HANDLED;
> +	if (!sigma_delta->irq_gpiod || gpiod_get_value(sigma_delta->irq_gpiod))=
 {
> +		complete(&sigma_delta->completion);
> +		disable_irq_nosync(irq);
> +		sigma_delta->irq_dis =3D true;
> +		iio_trigger_poll(sigma_delta->trig);
> +
> +		return IRQ_HANDLED;
> +	} else {
> +		return IRQ_NONE;
> +	}
>  }
> =20
>  /**
> @@ -676,8 +693,15 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, s=
truct iio_dev *indio_dev,
> =20
>  	if (info->irq_line)
>  		sigma_delta->irq_line =3D info->irq_line;
> -	else
> +	else if (spi->irq)
>  		sigma_delta->irq_line =3D spi->irq;
> +	else {
> +		sigma_delta->irq_gpiod =3D devm_gpiod_get(&spi->dev, "interrupt", GPIO=
D_IN);
> +		if (IS_ERR(sigma_delta->irq_gpiod))
> +			return dev_err_probe(&spi->dev, PTR_ERR(sigma_delta->irq_gpiod),
> +					     "Failed to find interrupt gpio\n");
> +		sigma_delta->irq_line =3D gpiod_to_irq(sigma_delta->irq_gpiod);

As I mentioned on the binding if this is something we are going to do there=
 should be
no assumption of the gpio and the irq being the same pin.

> +	}
> =20
>  	iio_device_set_drvdata(indio_dev, sigma_delta);
> =20
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/a=
dc/ad_sigma_delta.h
> index f8c1d2505940..fc0141e0f0ef 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -96,6 +96,7 @@ struct ad_sigma_delta {
>  	unsigned int		active_slots;
>  	unsigned int		current_slot;
>  	unsigned int		num_slots;
> +	struct gpio_desc	*irq_gpiod;
>  	int		irq_line;
>  	bool			status_appended;
>  	/* map slots to channels in order to know what to expect from devices */


