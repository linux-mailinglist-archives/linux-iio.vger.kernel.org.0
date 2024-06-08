Return-Path: <linux-iio+bounces-6077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A756A901312
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4481E1F21D20
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF71C287;
	Sat,  8 Jun 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hql048Hp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678A1BDC3
	for <linux-iio@vger.kernel.org>; Sat,  8 Jun 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717868099; cv=none; b=n1/PpsGph2glyX8rUJncW+YuI7TeBjbsGkdO2ECADMz3yx+IqRPsvYR4YyFpuTa+tPHa462qe2G6q4n/YjuqRstYEfVgmQHP6eX/j9vf625JudIqle8uJddrGv6aGAOAZFmDGkqYC8eZDtRAaR3FXlj0UQNeqlP3bbnEg9DiRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717868099; c=relaxed/simple;
	bh=i8LuskcfVhJ5AQBZmAYeDhmGynCwy8xtWi4+QGL4O0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ8rRcjo6PEr6sR/3gOpTKaSwaUrF1W6c/e8UVsvP+LhzfttfTHdoW9/+e882ac8YrE/UAe3BbSYAvHTd01SCqUt/lNVftwuhOCjmLVZNkNTEInZCpLxKC7c2V/9Q2BR3DtMXdxQ6En+EEgkmb2oXtWsjL5FE6LOdiWtrSePaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hql048Hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAE2C2BD11;
	Sat,  8 Jun 2024 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717868099;
	bh=i8LuskcfVhJ5AQBZmAYeDhmGynCwy8xtWi4+QGL4O0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hql048HpG6YSglcPxgrORewHVXlJx5Odzy1xg6KVMXorz0c00j34MZMWcfUjcq1ST
	 My36QmPmvSXxPZMu97tyWjq47XolsciKl0li755vZ3nayMpKGfPvFesJkv7cCeHBYH
	 Ax0rib7j0OO0NC4dgzQfi36VXRUA/k1gWZm2h7g1YxNUiqtILBluFQKqXfA2OabI7h
	 11NGN1AQ2RrtF4YK8FMfCLPOL9T4BF0yCEZB3sl3jhCY2pRWP3AvsOZWGIcmmJsA8b
	 9lnKxy7huDIElatKNvSWazTQFkC3LCXqz3b/WLGP071Sz7s7MDDtsG0oOTU4qa8ClW
	 YOE/+8jiO11xA==
Date: Sat, 8 Jun 2024 18:34:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: add platform dependencies
Message-ID: <20240608183455.01cf3e7c@jic23-huawei>
In-Reply-To: <20240604-dev-axi-adc-kconfig-v1-1-cfb725606b8e@analog.com>
References: <20240604-dev-axi-adc-kconfig-v1-1-cfb725606b8e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Jun 2024 11:16:58 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
>=20
> Being this device a soft core, it's only supported on some/specific
> platforms. Hence add proper dependencies for the supported platforms.
> Also add COMPILE_TEST to increase the build coverage.
People build kernels without COMPILE_TEST?  Weird :)

Applied

>=20
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5030319249c5..3d91015af6ea 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -353,6 +353,7 @@ config AD9467
> =20
>  config ADI_AXI_ADC
>  	tristate "Analog Devices Generic AXI ADC IP core driver"
> +	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTE=
L_SOCFPGA || COMPILE_TEST
>  	select IIO_BUFFER
>  	select IIO_BUFFER_HW_CONSUMER
>  	select IIO_BUFFER_DMAENGINE
>=20
> ---
> base-commit: b3019fcdeb286b2cfe45e44bccb44dbcd8ff66dd
> change-id: 20240604-dev-axi-adc-kconfig-1058732cb384
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


