Return-Path: <linux-iio+bounces-16541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0302A57A5C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7673B2785
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D391C3C04;
	Sat,  8 Mar 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjm1IRrG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5C1EEE6;
	Sat,  8 Mar 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741439597; cv=none; b=l/5lPiIRQUeg+Zy7IpUkXYislsB1NjMqOfWr3gAv3WtuUUtOa/jzGuC+lIEXP9ye4RC5MVR6+jNtvhrBojAz1RBpqzHQ9T2YOLtn05ceFddCPg4VGCrI1hIr9tqO1TCU+ieufhnD57URdZQri/V7+Bp/GDEeAD4+MU94FVzDA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741439597; c=relaxed/simple;
	bh=Mu1JYlNbht7PhEkBeODrtPs98Kbx8sXfGcUu/q1sXGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6nyQQ4jkRle9lDJcZnvFbCILM0OyuXxDXXOSH5y9CzWsw26+8c70SnOFGBUVOvh7HPTYCGwSfQSGJ/NTWR5ja0V1GZlG5mcKinbPZfJ/Q0lXH9VeFAl9BB30fA9Ws0bU+vR/Qn7AEIxSBr/ikG/zxNZ8bRNO1sIoiZDsDqUTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjm1IRrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9425C4CEE0;
	Sat,  8 Mar 2025 13:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741439596;
	bh=Mu1JYlNbht7PhEkBeODrtPs98Kbx8sXfGcUu/q1sXGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hjm1IRrG2xBDwXP5AUrXq28RFJdPyWTKrsXMiLKqT4urLAyjUJiieOpLLYCBuZglQ
	 EdnIb/0mmY4ROTahbh5I/SLoFD7VZAFyZJe8+q4dEl3X07by8Y4SNo/8lZonROVbSt
	 QbdaW5FwnUA+8Whwo1QHBDqd4FKnK5mZ7DYnmpqNTHndTxoGxCM/qCq7phuV/Be2d1
	 jLqpzm1A9AE4AE9b5qEe68i1OR1mmLYorv90R24wM3d0DJL7lGGx4osxdLEVh2/0oI
	 3gHhAWsAhSDIsh0P4xOoe9lusmROe6H2PlFX4MwCE+HedJwlyAPLOgKp/rWiFBTpe9
	 dqFkGsHBIhH8w==
Date: Sat, 8 Mar 2025 13:13:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v4 01/17] iio: adc: ad7768-1: Fix conversion result sign
Message-ID: <20250308131306.63ee1e6e@jic23-huawei>
In-Reply-To: <505994d3b71c2aa38ba714d909a68e021f12124c.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<505994d3b71c2aa38ba714d909a68e021f12124c.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 18:00:29 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The ad7768-1 ADC output code is two's complement, meaning that the voltage
> conversion result is a signed value.. Since the value is a 24 bit one,
> stored in a 32 bit variable, the sign should be extended in order to get
> the correct representation.
> 
> Also the channel description has been updated to signed representation,
> to match the ADC specifications.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
I'm going to start picking up the first part of this series now to
reduce the scale for future versions.

I have applied this one and marked it for stable. Note that the
recent iio_device_claim_direct() series changed the handling
of *val so I applied the equivalent of this by hand.  Please
check the result in the testing branch of iio.git.

Thanks,

Jonathan

> ---
> v4 Changes:
> * none.
> 
> v3 Changes:
> * Added missing SoB.
> 
> v2 Changes:
> * Patch moved to the start of the patch series.
> ---
>  drivers/iio/adc/ad7768-1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 113703fb7245..c3cf04311c40 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  		.channel = 0,
>  		.scan_index = 0,
>  		.scan_type = {
> -			.sign = 'u',
> +			.sign = 's',
>  			.realbits = 24,
>  			.storagebits = 32,
>  			.shift = 8,
> @@ -371,7 +371,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = ad7768_scan_direct(indio_dev);
>  		if (ret >= 0)
> -			*val = ret;
> +			*val = sign_extend32(ret, chan->scan_type.realbits - 1);
>  
>  		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)


