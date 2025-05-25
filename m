Return-Path: <linux-iio+bounces-19867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D83AC340D
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52DD3B4D93
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A28199938;
	Sun, 25 May 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2FjCTG8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F943ABC;
	Sun, 25 May 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171017; cv=none; b=P+KTiCVPExUUeajVNTSh2k4Ug9l5e8sUti+djgUX09vTLF/vXYi6pii90jxnExd3o5gp6y1r5l34KlAlnNl3dPvZczpRPFVwvK5yXKs+H9BfDV1KeIesUcT+C7typ+j6jOkypq0Ed1O13VSPGHSb/cPW5JeZW+7Hz4LPSic1iRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171017; c=relaxed/simple;
	bh=chu79/4aGh/Hzre04wvQeJAuO9XJ4T5JaMtASKFMp4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1tAR4vLl6X1us3AHetow0DPJ4OjNPx+TB2VqZrnPxkadIx4lHd4BEPNRYsvOU8Womv5trZiWyhvYTOAj8hYeO0+1hs3VaWQk+yu1jCg0oyndlTJAD2WJk+TCb3A385mN8Jsl1U1C29RSf55noNLxJh2puQHgKNqYSsInmavHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2FjCTG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506E8C4CEEA;
	Sun, 25 May 2025 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748171017;
	bh=chu79/4aGh/Hzre04wvQeJAuO9XJ4T5JaMtASKFMp4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G2FjCTG8MUY2tXDmBKlTMhycZaMFN2duUU3qL3e+A1mRfB89PbMv/QjYn3W3yskf/
	 qjIn0Vvb4YEh1e5Qg77ky/ZprGtdD6O48RccJ4fPhIAzSNoAeX9cl4ZbT2Fryf/iS3
	 HHOn7TjXaE+WxmxaLnkEehphJimigQa8LJq/dK0nM7IoTIVhqMgNrMHYtY+slSQUeD
	 QOHJm79ithYIebFQUMhkE8g6TKZ1yjRuY40ip9leLYqkazpcLx3pmkelajPoYH8Pqk
	 F7SGHlTi+eNWN/UBXyScVWEgV2LlPYvV4Ve/XOPVfVadF9+Z9t/jXfwN2GW7F8rXJy
	 fqMtlXGIb3DkQ==
Date: Sun, 25 May 2025 12:03:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, "Dragos Bogdan" <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] iio: adc: ad7405: add ad7405 driver
Message-ID: <20250525120324.1e721515@jic23-huawei>
In-Reply-To: <20250519140220.81489-7-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
	<20250519140220.81489-7-pop.ioan-daniel@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 May 2025 17:02:14 +0300
Pop Ioan Daniel <pop.ioan-daniel@analog.com> wrote:

> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order =CE=A3-=CE=94 modulator that conver=
ts an
> analog input signal into a high speed, single-bit data stream.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Hi Pop,

Just one additional trivial comment from me as you are going around
again anyway.

Thanks,

J
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07d4b832c42e..8115f30b7862 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_AD7291) +=3D ad7291.o
>  obj-$(CONFIG_AD7292) +=3D ad7292.o
>  obj-$(CONFIG_AD7298) +=3D ad7298.o
>  obj-$(CONFIG_AD7380) +=3D ad7380.o
> +obj-$(CONFIG_AD7405) +=3D ad7405.o
>  obj-$(CONFIG_AD7476) +=3D ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c

> +
> +/* Match table for of_platform binding */

This comment doesn't really add anything useful so I'd drop it.

> +static const struct of_device_id ad7405_of_match[] =3D {

