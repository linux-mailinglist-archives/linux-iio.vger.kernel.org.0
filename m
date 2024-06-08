Return-Path: <linux-iio+bounces-6078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E3D901313
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE81F21B32
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427671C290;
	Sat,  8 Jun 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0/4dmIS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099B1BDC3
	for <linux-iio@vger.kernel.org>; Sat,  8 Jun 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717868139; cv=none; b=qq6THgK2tkjq/2imZvXF9u8/VerheJ/JYbK2MNpUz2BP8LxCtvjTTTKW1pFq5YEFj2/6OEnDil5n0jhRm1TPZOi1UQptZCMSfsfNixZ+MzN6r64WXsyBDwq4YkwcZdQQdh78o1gF2h4i4I0PWnIAc1OQ7ZyLmOxYyUcZtV92vfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717868139; c=relaxed/simple;
	bh=QPPW1+Ra+sJbNeHko7BtDFpAHa0M5Gv0akEDfrQtAwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDtMdA4QXKEIIiIw5pws5pe/KQzazbMmYOoSebt4P8mL67ug8dR33w60SNeBnBXLxnw8JskIdIB2sLpQJyN2XX6GYy16+jv0nGTyJWhZjWGhItBF9Xna8WpOuOWFPTh8cKOQrPOeKnAH7CcTJ+yeSD/gNzHHBXFcoo4Z8ABiXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0/4dmIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9800C2BD11;
	Sat,  8 Jun 2024 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717868138;
	bh=QPPW1+Ra+sJbNeHko7BtDFpAHa0M5Gv0akEDfrQtAwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0/4dmISp15YV1ylI88taN6loLBFznVsi0GlZERGC4xQQGVnAqm5E1v+1a6eBFEzM
	 2eK/jRS7JYws7VUmzoBupo2wIwqVs8CUITfDaiCnj3B8KFUp4PBOw65kqNhRbaVBFm
	 P1M+2e17pH6tniapOYm2p7WdJ5Jc3tPiIyBn3oqW1FV6q/oD4f4eagBXGtP+Yworn0
	 BVDksm8flCShq3YldZTxbQ0S5vN+u+V7k9CcpjorSTG2sRKp28ZAllxy5htUFKASlC
	 VDX/Cmt3bzAvmg5tAfjIAugi2ddkqKF25oBVv8k8d+1jjcepviB0wxP45WhmAXxfwg
	 /L6++wSODFYzg==
Date: Sat, 8 Jun 2024 18:35:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH] iio: dac: adi-axi-dac: add platform dependencies
Message-ID: <20240608183533.072dbcc6@jic23-huawei>
In-Reply-To: <20240604-dev-axi-dac-kconfig-v1-1-99ccd03938d1@analog.com>
References: <20240604-dev-axi-dac-kconfig-v1-1-99ccd03938d1@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Jun 2024 11:19:56 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
>=20
> Being this device a soft core, it's only supported on some/specific
> platforms. Hence add proper dependencies for the supported platforms.
> Also add COMPILE_TEST to increase the build coverage.
>=20
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied
> ---
>  drivers/iio/dac/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index ee0d9798d8b44..a2596c2d3de31 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -149,6 +149,7 @@ config AD9739A
> =20
>  config ADI_AXI_DAC
>  	tristate "Analog Devices Generic AXI DAC IP core driver"
> +	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTE=
L_SOCFPGA || COMPILE_TEST
>  	select IIO_BUFFER
>  	select IIO_BUFFER_DMAENGINE
>  	select REGMAP_MMIO
>=20
> ---
> base-commit: b3019fcdeb286b2cfe45e44bccb44dbcd8ff66dd
> change-id: 20240604-dev-axi-dac-kconfig-a74d4652ebd6
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


