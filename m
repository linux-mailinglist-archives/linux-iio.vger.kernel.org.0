Return-Path: <linux-iio+bounces-19051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F829AA8824
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689FE7A1E0B
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07731DCB09;
	Sun,  4 May 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUr0pUfI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA8156F45
	for <linux-iio@vger.kernel.org>; Sun,  4 May 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746377208; cv=none; b=OpvsIHDdqFe+Djvr5QkLSC98vM/xyfy1QMxGUWO4tJIVQqkK4nwgbAE8gmERscrObYITDLyfcRzIjNd60RdSBod+ChuOtMJ6JfKML8tAptyQjpi8nS3TK5uHyU1b8H5yohOOeXvHLnMd+p8hus3HkiEB3LnSXQR2zsqFPIwcfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746377208; c=relaxed/simple;
	bh=VY1JnMNPod/eMQARFKWyYjfOrsPuwmVewyRarRyDuhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwFeJN0ZGhztxwo9TujoqFtXVOIiPx6W0oS3YEOU8u/rezCSeU3YEICIdsq/gDPtxLnQxt/9mGBx5Q72Wu31Cowredb05GsyJ2KCOkV3bj+6xDuVlmuFkNZNiwM7A26YrqhndwwjMpAEPhzWta1jVWpqgIYigVmwirU6mlR2TAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUr0pUfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AD3C4CEE7;
	Sun,  4 May 2025 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746377208;
	bh=VY1JnMNPod/eMQARFKWyYjfOrsPuwmVewyRarRyDuhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fUr0pUfIJLbb+HG5ibCfTwwSaJ6n5wtZirfs+K8MxrvxKXBD0OJJf4J8qzT7hRv7t
	 C6nGekoYMzB0gVYm/YzXNFhZKeWXY1RyC4KeAUtEfY9foerDynVUJ3hhT2YjjL0pU7
	 6vMjLDEKiTCINX51s3bDYYM5boe2AzEUiCj2lyV90qJQT3ravFt0nl0g/JBNP529jJ
	 eWv9BHq6xMuZwfzCB0N3VJWzr+Y8Ms5VzRH9T58vjFdNHakf1GUT17ixrPaVdqKODW
	 O+XyIW6XB+i6UAvNrWZxseG0M6tnfVNb36A5JwHe3doDOiueHSb52fd0VQEZjFCwPq
	 BoZecjjKlXtyA==
Date: Sun, 4 May 2025 17:46:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: r2.arthur.prince@gmail.com
Cc: linux-iio@vger.kernel.org, arthur.prince@ime.usp.br, Mariana
 =?UTF-8?B?VmFsw6lyaW8=?= <mariana.valerio2@hotmail.com>
Subject: Re: [PATCH] iio: adc: Kconfig: add kfifo dependency to fix module
 build
Message-ID: <20250504174643.40feaa67@jic23-huawei>
In-Reply-To: <20250430191131.120831-1-r2.arthur.prince@gmail.com>
References: <20250430191131.120831-1-r2.arthur.prince@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 16:07:37 -0300
r2.arthur.prince@gmail.com wrote:

> From: Arthur-Prince <r2.arthur.prince@gmail.com>
>=20
> Add dependency to Kconfig=E2=80=99s ti-ads1298 because compiling it as a =
module
> failed with an undefined kfifo symbol.
>=20
> Fixes: 00ef7708fa6 ("iio: adc: ti-ads1298: Add driver")
> Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
> Co-developed-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
> Signed-off-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
Applied and marked for stable

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


