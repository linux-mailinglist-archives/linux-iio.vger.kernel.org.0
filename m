Return-Path: <linux-iio+bounces-18020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C8A86E72
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D158C1FC1
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84C20468C;
	Sat, 12 Apr 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhEevoeY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257E6BFCE;
	Sat, 12 Apr 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744479882; cv=none; b=eKwgTOBamTPfay7Mm59JDPg0XWn2tJ/ph3VWbJqbLIuyjJsDfmA2EE97JnCavm4hij3HYQ90MjnHDllFRVnwsjuRopaQdsAHfFuQZRnrDK0LJok4PHusvKYV1/wvIqvK8dWoyvAnd8tA5tB72dnljrJn2/0zRSNbgRdrwgIJeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744479882; c=relaxed/simple;
	bh=+97YbZag3EjvYCU3VxRZgKfybyukADSNBGMn9Y/e/68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTJvBeKnj1TV9CUoKyLivthR7oQ/wjZiVA29wUEZIO5dfBNZb3Ey0idY2JXAMdkAVZ+tNlX+Yizgo4VMncKN9v12CU2Hp+R697Ro7hf5tseI4oGlD25oDQv5LDWZRU6HRrdOFtRN0p+naFbMzUeiI7d333rM8W1v0nnPzhyP6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhEevoeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B372C4CEE3;
	Sat, 12 Apr 2025 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744479880;
	bh=+97YbZag3EjvYCU3VxRZgKfybyukADSNBGMn9Y/e/68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MhEevoeYQDUmweha7t8vIzMbxTlsGaztIEh+dOf4bLghh6+AkRqDOd9rA4FE3Qj6R
	 lHk+mwd41FgCgdEgxskxnNc0yDoAx484VfJUwH0FUYJBMxTrC/hO5Hoq8fcr7ihPMN
	 VVVEBeBPbvC6riE55QTsKM2hL2K+7KneG1eyNIfWmIepSGJ8hM0FhR4HOVzvSL0x3U
	 zqLwG/0ct0LPTL4zID2dISJHncfyCo4NcEodVHywuALbPqQuUJsrQyK7GgeDJwXSGp
	 MXK+JiXbuRXDm/H6HJr7PkQm4QY1TTpGa29k3UlXotFu5rdkWHgbkJqj8JD2t9jXKr
	 UJ8XQMLN4Q/Dg==
Date: Sat, 12 Apr 2025 18:44:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <20250412184433.58f0a9d5@jic23-huawei>
In-Reply-To: <20250412-togreg-v4-3-cb9e5309b99d@analog.com>
References: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
	<20250412-togreg-v4-3-cb9e5309b99d@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Apr 2025 13:57:32 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disabl=
ed
> by default.
>=20
> Support for monitoring internal die temperature, output voltages, and
> current of a selected channel via the MUXOUT pin using an external ADC
> is currently not implemented.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Hi,

One really small comment from me.  Otherwise this just needs
to sit on list for a little while to give other reviewers time.
If nothing else comes up I may just tweak the thing below (or leave
it alone!)

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ffa04f678b86d8da6f5e47c35=
c265b6648121843
> --- /dev/null
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -0,0 +1,506 @@

...

> +static int ad3530r_probe(struct spi_device *spi)
> +{

...

> +	vref =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (vref < 0 && vref !=3D -ENODEV)
> +		return vref;
> +
> +	has_external_vref =3D vref !=3D -ENODEV;
> +
> +	if (!st->chip_info->internal_ref_support && !has_external_vref)
> +		return vref;
If doing a v5 I'd go with
		return -ENODEV;
rather than having people scratch their heads to figure out what is in vref.

> +

