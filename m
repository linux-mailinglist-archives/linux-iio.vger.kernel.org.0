Return-Path: <linux-iio+bounces-18705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191EA9DBD8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784429230E1
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E201F4720;
	Sat, 26 Apr 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFblRpa8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB13D3B8
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745681550; cv=none; b=KvZNfzF99v47NwonS0W/Rnv2HgTWCnBgqO9b+0p6Q3KZB6I2JZcbF8a64GyGvaTUfshdc1RPeI2Okr01JGXd+/HO/4GGuHyGbfWKkfOqw+uP6C8hfaWYuB/Q5rg4x3n9z0PXcFx6QdhwAsTaIRf1SLRaAIRDXDBVWuFKoqU9Zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745681550; c=relaxed/simple;
	bh=DwhHzUjrJNvuYGM0kC0Hpul2vrwQ1cJoQuLoKohyGLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsdhDulNdQCpEN9FPk6EfqY4o9QHi9S+I011GPWnSZDrVUxA9PFGIfhMqmIvQgUioXl2OWhwyQB8mE2emNvshofwx3hv2t1/B+OXAQ/Xs4o1l1TBxN/8xpZheGWK3bolqiaEUFpdVzpi9W1azFB80mit9j6xeIjpOxOh3kNagkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFblRpa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F91C4CEE2;
	Sat, 26 Apr 2025 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745681550;
	bh=DwhHzUjrJNvuYGM0kC0Hpul2vrwQ1cJoQuLoKohyGLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mFblRpa8+UjnGA93wL0b3S8z8zli/+qQVJwAUB4Zd/aM78TnhNWdElaEUaK+L5ZF0
	 zNyHYfb7WnQHWTmX0TXSrE8F4JrFHN/QNsapjgOX2kONh7g1aiSgxED3i3My7eOmpy
	 MHIE3unOMFWng9M3Fve7XZ7y3tIshRyYgukD6omgzwcUOjTdyatSzLJWZymZ///ryA
	 KefNBJcef20+IzvO8eQmiWkegMLQ8ZPWpIyEd1LuGNUHXvczKBskDCyza5ZpBej2cU
	 RyPLGlzOEP88x5EF5fGPYNPjRCcYYGZhrWbm60pQPtcYnoLoDxOamsae94f46ejtPu
	 fTwRZKATqmrUg==
Date: Sat, 26 Apr 2025 16:32:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur-Prince <r2.arthur.prince@gmail.com>
Cc: linux-iio@vger.kernel.org, arthur.prince@ime.usp.br, Mariana
 =?UTF-8?B?VmFsw6lyaW8=?= <mariana.valerio2@hotmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Kconfig: add kfifo dependency to fix
 module build
Message-ID: <20250426163224.5b367eb5@jic23-huawei>
In-Reply-To: <20250423185208.752080-3-r2.arthur.prince@gmail.com>
References: <20250423185208.752080-1-r2.arthur.prince@gmail.com>
	<20250423185208.752080-3-r2.arthur.prince@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 15:46:26 -0300
Arthur-Prince <r2.arthur.prince@gmail.com> wrote:

> Add dependency to Kconfig=E2=80=99s ti-ads1298 because compiling it as a =
module
> failed with an undefined kfifo symbol. Building the full kernel passed
> since kfifo was enabled globally. Selecting IIO_KFIFO_BUFFER in=20
> ti-ads1298=E2=80=99s Kconfig, as done by other IIO ADC drivers, now ensur=
es kfifo
> buffer support is included for module builds.
>=20
> Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
> Co-developed-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
> Signed-off-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
Fixes tag?
Otherwise looks good.

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..513f2238fdee 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1492,6 +1492,7 @@ config TI_ADS1298
>  	tristate "Texas Instruments ADS1298"
>  	depends on SPI
>  	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
>  	help
>  	  If you say yes here you get support for Texas Instruments ADS1298
>  	  medical ADC chips


