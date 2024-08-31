Return-Path: <linux-iio+bounces-8907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95980967136
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 13:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D901C21A99
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0F017D340;
	Sat, 31 Aug 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgRa8u81"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4D17DFEB;
	Sat, 31 Aug 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102867; cv=none; b=FOp9TsvLx5TfpxGYoKfs21X2u0oQOeIxlHT4rJrGfMCBvAJt90MfhPbKNHPU/26e6HmaNZNCGvMSkcU+bTnMA/64qAzL65uqHW9BDaOXR8VHbEjG9AKtjcr73qpVcZSGxy2KGgpiiic2SuXRrfZg3SRfNIM6bTUgJxAwsoTVeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102867; c=relaxed/simple;
	bh=JoeQ1+9FykwPktoL15ThTao/9Vu+3+00UVGBonSwU0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db6ZV6+aC1jO/fPnDihBOldihxUehoJspyDqZMA5INPw26ffN/QVRlRkLau8oCwdgKJUWHQOUnzzMrnp3MKKu9ZbCZn811DO6eK88DwPowfsOrpkCMZ9OwN2xnwMk5WDWovm+qTyAs3dtputSpoB4ZPDb/fXqqQYqJTy/m0B6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgRa8u81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2E8C4CEC0;
	Sat, 31 Aug 2024 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725102866;
	bh=JoeQ1+9FykwPktoL15ThTao/9Vu+3+00UVGBonSwU0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PgRa8u81fp8I5BesmFFAMHoypMHilmrdMf9Iy5m16yRQ5eYOhlRIJrS/QzzfabJjD
	 z7V+taqA+3T0WLSH5OeGxM9HgmAV5ZfzlpH3gYKK4KeXO3PccYtG7H9LC67vhK+D2k
	 9PXfWXMF9DPSlGB7jh5Uq39NdeBxUvluSQngLrf+IZsuucRUtBuRLspNFhj7Wuw6nu
	 BT77xAEngPGRXXktE3Hc6L1q3ebrVJmCw/6YsvRi+/EnCjlPv/aLFn4GvEixoaKFtk
	 Kyu46zCyrZ4hbYuhPQY7wJck/9Rp9A4fycU+A2A00nPBGjQbrikLT4hYw8EQhH3m/6
	 oG623bSI1gUyg==
Date: Sat, 31 Aug 2024 12:14:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/3] Add SARADC support on Sophgo CV18XX series
Message-ID: <20240831121415.4888cf11@jic23-huawei>
In-Reply-To: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 14:31:49 +0200
Thomas Bonnefille <thomas.bonnefille@bootlin.com> wrote:

> This patchset adds initial ADC support for Sophgo CV18XX series SoC. This driver can
> work with or without interrupt.
> 
> Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2002-trm-v1.0/sg2002_trm_en.pdf
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Applied patches 1 and 2 to the togreg branch of iio.git. Currently that's
just pushed out as testing because I want to rebase shortly to get some
usptream fixes needed for other series.

Thanks,

Jonathan




> ---
> Changes in v5:
> - Add the ability to read the sample frequency
> - Edit commit message to remove No-Die reference and add precision on
>   the ADC series
> - Rename binding and driver file to match compatible
> - Reformat the channel property in the binding
> - Clean driver code
> - Link to v4: https://lore.kernel.org/r/20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com
> 
> Changes in v4:
> - Lowercase register hexadecimal value in dts
> - Reorder properties in dts
> - Use only a const in the compatible property of the device tree bindings
> - Specify the series of SoC in the driver to avoid confusing with other
>   Sophgo SoCs
> - Add channel description in the bindings
> - Use FIELD_PREP in the default configuration
> - Index channels from 0
> - Return PTR_ERR instead of IS_ERR
> - Link to v3: https://lore.kernel.org/r/20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com
> 
> Changes in v3:
> - Subdivide default cycle configuration into multiple elementary
>   configurations
> - Fix formatting in the driver
> - Use devm_mutex_init
> - Use devm_clk_get_enabled now because the clock is no more optional
> - Remove handling of Saradc in No-Die Domain as RTC isn't implemented yet
> - Use cv1800-saradc as default compatible instead of a wildcard
> - Remove platform_set_drvdata as it wasn't used
> - Link to v2: https://lore.kernel.org/r/20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com
> 
> Changes in v2:
> - Drop modifications in MAINTAINERS file
> - Rename the ADC from "sophgo-adc" to "sophgo-cv18xx-adc" to avoid
>   conflict with ADCs available in future Sophgo SoCs.
> - Reorder nodes in DT to match DTS coding style
> - Switch from including <linux/of.h> to <linux/mod_devicetable.h>
> - Use scoped_guard instead of mutex_lock/unlock
> - Check IRQ Status in the handler
> - Change IIO device name
> - Use devm_clk_get_optional_enabled instead of a clock variable
> - Init completion before the IRQ request
> - Removed unnecessary iio_info structure in the private data of the
>   driver
> - Use SoC specific compatible in the bindings and device trees
> - Link to v1: https://lore.kernel.org/r/20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com
> 
> ---
> Thomas Bonnefille (3):
>       dt-bindings: iio: adc: sophgo,cv1800b-saradc: Add Sophgo CV1800B SARADC
>       iio: adc: sophgo-saradc: Add driver for Sophgo CV1800B SARADC
>       riscv: dts: sophgo: Add SARADC description for Sophgo CV1800B
> 
>  .../bindings/iio/adc/sophgo,cv1800b-saradc.yaml    |  83 ++++++++
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |  22 +++
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/sophgo-cv1800b-adc.c               | 218 +++++++++++++++++++++
>  5 files changed, 334 insertions(+)
> ---
> base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
> change-id: 20240527-sg2002-adc-924b862cd3f2
> 
> Best regards,


