Return-Path: <linux-iio+bounces-19066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597FAA88C5
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599E117263D
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA6246765;
	Sun,  4 May 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjtGEINI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F14219FC;
	Sun,  4 May 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746381061; cv=none; b=Z1VG/8teZRx7ZqnGbDzvPe81leeoiRPAuxWs6Ru2HJ4WfbuzviaM2C+i4pWTfGH55imPpp7qyBRPjCJsgOmQ3KfSf4ZeZxT8W47JTrpooi/RM3CKrqvWnjmqmvcRbGMkoLe5E6oHJw5NkyXfz3yYfMcrKKoXG8tQIHqAvgqBe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746381061; c=relaxed/simple;
	bh=USOArNxVc6EwKB4dVOaY0DMUOH7lSVexDC5Oqs4JFMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PINWc5PS/LMSX8NC9mqyTdJ5loVpslG5YVBI9vlZLkSmaiRE8JZ9B1iuqQ23RyfAhMl4Cxh7jbeVO263KI7Z5ru/Kz0F/y0SqY/nqpYUBlv1ADcCdtLyPqIRe/zQ1GvqRU1W2Qdj5AUe+kTaxHaYjV8lI9syvhjxx5eXc7ta6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjtGEINI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132E6C4CEE7;
	Sun,  4 May 2025 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746381061;
	bh=USOArNxVc6EwKB4dVOaY0DMUOH7lSVexDC5Oqs4JFMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MjtGEINIejAOnQ3JRqkYGVJfWPG9sfo7oHYLyvR65r725hS0jyxk3bJ+ODJtQJFX8
	 7AzqDNvxTUVE6r4ezjr3matDOpnKuRHB8tF+/QiwzsCt0GwDMfWUm/17ZoDEzkP+gZ
	 gNgVGIg3To8ZKV6HDDZAbOU81bWA9xFYWHt5cD1vpnGjmEsYiz/BJhODxMylunhp8a
	 3GsOZJ5klc1B0ZCwjnrC/MQdlbEBbM87tkgelJjECcdSdOxJTZ5dZRYtY1fDBIbT71
	 3sFfLg5jHa3sSPFqffCYO7nhpsuJ+5Ci5TTplXqtoaQB1fv3icvxgjwO1DDrK2sFyM
	 SeOt98Sq8g1Bw==
Date: Sun, 4 May 2025 18:50:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 5/7] iio: adc: ad4170: Add GPIO controller support
Message-ID: <20250504185051.563c5220@jic23-huawei>
In-Reply-To: <e4abdd44a28c395dd51c5a492aeda5074331e6ea.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
	<e4abdd44a28c395dd51c5a492aeda5074331e6ea.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 09:28:55 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The AD4170 has four multifunctional pins that can be used as GPIOs. The
> GPIO functionality can be accessed when the AD4170 chip is not busy
> performing continuous data capture or handling any other register
> read/write request. Also, the AD4170 does not provide any interrupt based
> on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.
> 
> Implement gpio_chip callbacks to make AD4170 GPIO pins controllable through
> the gpiochip interface.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
For GPIO controllers, even ones outside of driver/gpio we generally +CC the maintainer
and list.  They don't have to comment but that at least gets it on their radar if
we are misusing the GPIO chip infrastructure!
Make sure to do that on v3.

In meantime I didn't look hard, but I'm not immediately seeing why we have to disable
the gpios when switching direction.

Jonathan


>
> +
> +static int ad4170_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(gc);
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = regmap_clear_bits(st->regmap, AD4170_GPIO_MODE_REG,
> +				BIT(offset * 2 + 1));
> +	if (ret)
> +		goto err_release;
> +
> +	ret = regmap_set_bits(st->regmap, AD4170_GPIO_MODE_REG,
> +			      BIT(offset * 2));
As below. If we have to go via disabled, then we need a comment on why.

> +
> +err_release:
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad4170_gpio_direction_output(struct gpio_chip *gc,
> +					unsigned int offset, int value)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(gc);
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad4170_gpio_set(gc, offset, value);
> +	if (ret)
> +		return ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = regmap_clear_bits(st->regmap, AD4170_GPIO_MODE_REG,
> +				BIT(offset * 2));
This is odd enough that if required it needs a comment.
I suspect you can just directly update both bits in one write though
and this should be a regmap_update_bits() setting the two bit
field to the value 2 which is output (vs 1 which is input).

> +	if (ret)
> +		goto err_release;
> +
> +	ret = regmap_set_bits(st->regmap, AD4170_GPIO_MODE_REG,
> +			      BIT(offset * 2 + 1));
> +
> +err_release:
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}


