Return-Path: <linux-iio+bounces-24499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696DBA61C0
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CEE16BD6C
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC6290D81;
	Sat, 27 Sep 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0VFrQ02"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230411F12F8;
	Sat, 27 Sep 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758992111; cv=none; b=se3dW8Rim8e29JGY8DaPUBxhwW3PiPTyOf2LjzI794+mS4RiFolmpWA5aym3WSf6EMIEZDtplzgtuwub1570KkbPfYOWmH2uvbFPZjdGcB/r9GhmkEkaN5Tv8otGqChN/DYcKg44vF4GKAc5pwqbmFyoxuUTnDW2+3IuVhB++wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758992111; c=relaxed/simple;
	bh=drBnAG/nqExeMC0SeVOzWg/l5QZw1yStpWxdPYDJaKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEjyPXsjN5iek915aDY4LC5882bQiLifoq5BUcwiuwkErXxlcJxGYE1IUOtImS4v7g/KUBeI4uDgIFgucTK9+atVPTGGZxvAOEadSAYKDyI23oTAuoVjsMMPCJKeYPyuWeamTQ7NWuGBzVtrdBHe9PnXQDR6wcbKMMVXiuxpY3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0VFrQ02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76553C4CEE7;
	Sat, 27 Sep 2025 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758992110;
	bh=drBnAG/nqExeMC0SeVOzWg/l5QZw1yStpWxdPYDJaKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f0VFrQ02PWEFQm0sr+ZDnJDG2UNIr/3iSNq7Teh/uAYAE5tfVaAq+Rqpi0P/2fyCA
	 QqrkvcqIHV4gUXLa6H/Rd2/JQ5YODhcLKUzyLHfbFl1DH9UIr3eakD6gz5ubFt2TyQ
	 miLjFlGSuHsR2h16D55becXUZNpK2GqjPo5fUX8IapsWzQ1h3TwXLJYyDbY2XZvA52
	 Scje+z2w506fXgsTv4nXeKK683al471ZGFw+e/jvhzLaODQkxhfxNvH3Jlq3i6heWd
	 HYQV49Z8anMyi6A9p9/Nv6Wvgl4bAAymZKU+nlRqkhlmiMS6pPkoSPv4nEuKPZzqWh
	 TXftG3s06rhAg==
Date: Sat, 27 Sep 2025 17:54:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
 naresh.solanki@9elements.com, michal.simek@amd.com,
 grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 4/4] iio: mpl3115: add support for sampling frequency
Message-ID: <20250927175343.156e00da@jic23-huawei>
In-Reply-To: <20250926220150.22560-5-apokusinski01@gmail.com>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
	<20250926220150.22560-5-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Sep 2025 00:01:50 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> When the device is in ACTIVE mode the temperature and pressure measuremen=
ts
> are collected with a frequency determined by the ST[3:0] bits of CTRL_REG2
> register.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
One minor formatting thing inline.

And whilst I'm here, slow down a little.  No need to send a v3 for a missing
include.  Just do as you did and reply to say that it needs adding then wait
for reviews on v2.

In general, leaving a series on list for a week or more is a good plan to g=
ather reviews
before doing a new version.

Jonathan


> ---
>  drivers/iio/pressure/mpl3115.c | 82 ++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>=20
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl311=
5.c
> index 13c8b338a15e..04c126ff4d46 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -10,6 +10,7 @@
>   * user offset correction, raw mode
>   */
> =20
> +#include <linux/bitfield.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> @@ -30,6 +31,7 @@
>  #define MPL3115_INT_SOURCE 0x12
>  #define MPL3115_PT_DATA_CFG 0x13
>  #define MPL3115_CTRL_REG1 0x26
> +#define MPL3115_CTRL_REG2 0x27
>  #define MPL3115_CTRL_REG3 0x28
>  #define MPL3115_CTRL_REG4 0x29
>  #define MPL3115_CTRL_REG5 0x2a
> @@ -48,6 +50,8 @@
>  #define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
>  #define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
> =20
> +#define MPL3115_CTRL2_ST GENMASK(3, 0)
> +
>  #define MPL3115_CTRL3_IPOL1 BIT(5)
>  #define MPL3115_CTRL3_IPOL2 BIT(1)
> =20
> @@ -57,6 +61,25 @@
> =20
>  #define MPL3115_INT2 BIT(2) /* flag that indicates INT2 in use */
> =20
> +static const unsigned int mpl3115_samp_freq_table[][2] =3D {
> +	{ 1,      0},

space before } in each of these.


> +	{ 0, 500000},
> +	{ 0, 250000},
> +	{ 0, 125000},
> +	{ 0,  62500},
> +	{ 0,  31250},
> +	{ 0,  15625},
> +	{ 0,   7812},
> +	{ 0,   3906},
> +	{ 0,   1953},
> +	{ 0,    976},
> +	{ 0,    488},
> +	{ 0,    244},
> +	{ 0,    122},
> +	{ 0,     61},
> +	{ 0,     30},
> +};



