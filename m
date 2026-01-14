Return-Path: <linux-iio+bounces-27717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF24CD1D677
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AEBA309C132
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D65381711;
	Wed, 14 Jan 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex3xWVz4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD537F11D;
	Wed, 14 Jan 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381575; cv=none; b=ajzvzu9/r/ciH9cmi1f5n7X8CBPwd3RxHFLpET8zWc2gPdhrav/GNZnBYW6/kcdcjQL9y8vtwe2m1BW6lXnirQVSXeLksTQ7QfjcvQAvb8E8asFIHlf3LvRkamuYnh7xdOoJT02zCOCLBNsNoyFDdWntoygWfV8qIdmCa3ZWhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381575; c=relaxed/simple;
	bh=KYdqP8j7qXNdTgDTk0iu/82mcAvoZxCH5aKihyu+xOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9UghNpoemO7S/h400Zp77sdvWCBpe+f9RTg3GpJ8kQYUimSsjAo3AWXOBkaqYL0jZJjdzg4cV9/c0tx0EM8S8MlnuqtmzqiqR6/KG0AjSQTahIrfa5rrxyXClhE8Ar/ZQXNlAlaNDdZxwljb29CqR6obf4tkXY0/29UPxnLIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex3xWVz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA73C19423;
	Wed, 14 Jan 2026 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381575;
	bh=KYdqP8j7qXNdTgDTk0iu/82mcAvoZxCH5aKihyu+xOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ex3xWVz4mwdvwZv76QvlignXUolEw/jXpH03zTS5y2eFEr0iN6scYiHfpWVynD+yU
	 SXJCPRixoJ60n5OB6ZdMyYkk95XIf+pzUS5ZJXD1ZluQFBKMFuuqrjuks7WERTU2ci
	 ZK0n3AU0E+DPp1bmyDPkiqRAcOebGbVfr+PZ8dvLotmIgJUj+K2qxgfTF/+NlOItnT
	 uW59IDB68jvtGn6IFRmpsHVrH/oDA3fvoXIjOXMhnmiTP4jd7lckaaM/4zCAkpctEX
	 9PjB3YBCUbXyY9EMUtbnXbfIBDXOPx3H2LacyM4ougyvjjH2yXMOmJ5twKzQ2/hZyi
	 mthw+5NyKvEig==
Date: Wed, 14 Jan 2026 09:06:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 4/9] spi: add multi_lane_mode field to struct
 spi_transfer
Message-ID: <20260114090604.031ed4f0@jic23-huawei>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-4-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
	<20260112-spi-add-multi-bus-support-v5-4-295f4f09f6ba@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jan 2026 11:45:22 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add a new multi_lane_mode field to struct spi_transfer to allow
> peripherals that support multiple SPI lanes to be used with a single
> SPI controller.
>=20
> This requires both the peripheral and the controller to have multiple
> serializers connected to separate data lanes. It could also be used with
> a single controller and multiple peripherals that are functioning as a
> single logical device (similar to parallel memories).
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Fwiw looks fine to me (and so a tag mostly so I don't read it again in v6=20
if that happens!)
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>=20
> v4 changes:
> * Shortened commit message (useful info will be in docs instead).
> * Added whitespace to create clear grouping of macros and the field.
>=20
> v3 changes:
> * Renamed "buses" to "lanes" to reflect devicetree property name change.
> ---
>  include/linux/spi/spi.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 7aff60ab257e..eba7ae8466ac 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -981,6 +981,8 @@ struct spi_res {
>   *      (SPI_NBITS_SINGLE) is used.
>   * @rx_nbits: number of bits used for reading. If 0 the default
>   *      (SPI_NBITS_SINGLE) is used.
> + * @multi_lane_mode: How to serialize data on multiple lanes. One of the
> + *      SPI_MULTI_LANE_MODE_* values.
>   * @len: size of rx and tx buffers (in bytes)
>   * @speed_hz: Select a speed other than the device default for this
>   *      transfer. If 0 the default (from @spi_device) is used.
> @@ -1117,6 +1119,12 @@ struct spi_transfer {
>  	unsigned	cs_change:1;
>  	unsigned	tx_nbits:4;
>  	unsigned	rx_nbits:4;
> +
> +#define SPI_MULTI_LANE_MODE_SINGLE	0 /* only use single lane */
> +#define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
> +#define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
> +	unsigned	multi_lane_mode: 2;
> +
>  	unsigned	timestamped:1;
>  	bool		dtr_mode;
>  #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */
>=20


