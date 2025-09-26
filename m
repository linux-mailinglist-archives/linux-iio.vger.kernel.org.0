Return-Path: <linux-iio+bounces-24461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02946BA491C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD4E1734A7
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CD223D281;
	Fri, 26 Sep 2025 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSeGqp+6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6C23E229;
	Fri, 26 Sep 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903109; cv=none; b=sgZpVO13v0k1TYMy4twwklXsKfBbXw7jDfT+/nCnE20GFGphCwZa2UhYBLLvdBfsFd7NF9bgvp6K0OPhO+LLhIUvHVgO7QSnAc76ABAI3gS+cFo3pinm1s63f0VnOKvgtOOWbQ8N/7tI+/dml+ZJhhRswxb9tAT2PAKtaY02QxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903109; c=relaxed/simple;
	bh=1KDgmYma2MnC8zChopyw3az3a1NpfHFpCuPoWCHv96Q=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=oi2XJcVk4LycKHXSY/j509n+ScQv3cD3vCs08LTVTaNNrZFOxaFdVAMixs+REzxeNvugEjhkj5OZwVGFL2N/RBvvxE5JxiuoHIpGK6uounXq/WYi1w8XOGXsv11QiiOLLQqZ9Dy3NOK7YB+JnOwgUhl+ZtGo9874vLVLXGZCo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSeGqp+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A586C4CEF4;
	Fri, 26 Sep 2025 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758903107;
	bh=1KDgmYma2MnC8zChopyw3az3a1NpfHFpCuPoWCHv96Q=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OSeGqp+6hiXXNiT7HIdZdAa9zHJ84BrXo50dVLoOZF7t2lzFo1tgeOKsl1Ga25Zot
	 4+XlN6qIpsJ2/T1JU9zWqYZ92OJYa2gzwjdUruoIIf7WxYYu3kyc9fdEpkjJap2o7D
	 kT5+/5Lerqgd8Ht/51vvc5evgHvQBlF9vrKeOlMJpzU1Zol7dNEBO6HjbG8idzl9T2
	 fW93itZzkyKFyYLlYKqvGJFPgu0l5592VLpm2x1+6/3yTKP7Kzvrb7fFrNV1+iftLG
	 od1W5uM8Yf+2UbCMOn3bcBAClsuaaPIPefWzyGt904Y5y1tpeS5cmKmBRbMg/J5A5A
	 I1YcgIUqILcAg==
Date: Fri, 26 Sep 2025 11:11:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Magnus Damm <magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
Message-Id: <175890301803.880384.843495445196930858.robh@kernel.org>
Subject: Re: [PATCH v2 0/7] Add ADCs support for RZ/T2H and RZ/N2H


On Fri, 26 Sep 2025 01:40:02 +0300, Cosmin Tanislav wrote:
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
> 12-Bit successive approximation A/D converters.
> 
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
> 
> Add support for them.
> 
> V2:
>  * pick up Reviewed-by from Geert
>  * dt-bindings: move required after patternProperties
>  * dt-bindings: describe 16 channels, but limit per-SoC to 6 / 15
>  * dt-bindings: use uppercase for clock descriptions
>  * remove max-channels property and find it from parsed channel subnodes
>  * remove start/stop wrappers
>  * stop calibration even on failure
>  * move data reading to rzt2h_adc_read_single() instead of interrupt
>  * handler
> 
> Cosmin Tanislav (7):
>   clk: renesas: r9a09g077: Add ADC modules clock
>   dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
>   iio: adc: add RZ/T2H / RZ/N2H ADC driver
>   arm64: dts: renesas: r9a09g077: Add ADCs support
>   arm64: dts: renesas: r9a09g087: Add ADCs support
>   arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
>   arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver
> 
>  .../iio/adc/renesas,r9a09g077-adc.yaml        | 160 +++++++++
>  MAINTAINERS                                   |   8 +
>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  69 ++++
>  .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  28 ++
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  69 ++++
>  .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  64 ++++
>  .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  79 +++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/r9a09g077-cpg.c           |   3 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/rzt2h_adc.c                   | 306 ++++++++++++++++++
>  12 files changed, 798 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
>  create mode 100644 drivers/iio/adc/rzt2h_adc.c
> 
> --
> 2.51.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250925 (best guess, 2/10 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/renesas/' for 20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com:

arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dtb: adc@90014000 (renesas,r9a09g077-adc): 'renesas,max-channels' does not match any of the regexes: '^channel@[0-9a-f]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dtb: adc@90014400 (renesas,r9a09g077-adc): 'renesas,max-channels' does not match any of the regexes: '^channel@[0-9a-f]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dtb: adc@80008000 (renesas,r9a09g077-adc): 'renesas,max-channels' does not match any of the regexes: '^channel@[0-9a-f]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dtb: adc@90014000 (renesas,r9a09g087-adc): 'renesas,max-channels' does not match any of the regexes: '^channel@[0-9a-f]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dtb: adc@90014400 (renesas,r9a09g087-adc): 'renesas,max-channels' does not match any of the regexes: '^channel@[0-9a-f]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dtb: adc@80008000 (renesas,r9a09g087-adc): 'renesas,max-channels' does not match any of the regexes: '^channel@[0-9a-f]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#






