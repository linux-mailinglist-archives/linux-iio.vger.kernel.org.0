Return-Path: <linux-iio+bounces-21283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360ABAF6BE9
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 09:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2F9522A67
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141C2989B7;
	Thu,  3 Jul 2025 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHLB+Hbb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8F1FFC46;
	Thu,  3 Jul 2025 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528839; cv=none; b=sE1vz6fOvw7PgCmtdljONl0YKGuPSKuPcNkKKjSpzv2cFeVLEW1CO/5zdy/nfHKC2lhumklvEHbcYcniMEzs+WUTpMsesxYp6pMiTDJFthJ253lYvyQ3zWzixV8oO8XbYIBqkH8tEiAqK4uwaUnrgx+82GcidoVLXU1XHeFF7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528839; c=relaxed/simple;
	bh=stYO2V0uO/CUicfgagttLRTcd8cErTfGnqGNs0OZwAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh6djpGWnbNEzYwuJSQ6PjdzHYsNU+zJqr5LMjeicJyJapH+Ib9X5L7puzYKpiSGwRYGczTWhGv5AFGdZnRB2a8U1Io6P3wyY7aLOG8ZYy57BLF9q6ymAYeAFxKHv2X9yik5dUVcC0/Lc2LneP1ixGq8jYXzQSd5bn4vAQTkkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHLB+Hbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58284C4CEEB;
	Thu,  3 Jul 2025 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751528838;
	bh=stYO2V0uO/CUicfgagttLRTcd8cErTfGnqGNs0OZwAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHLB+HbbUl8LbzGylH6tLSSxxToxrOYIyLIUpy4fK2ZHH2RQtaoQ29DMjdhEbHcy6
	 /WU0H0WiyEzAsSfp5Q5igIxWeOGHlOJ+YSbXlke5ux3KP+0GqtX2CWgG5mZ/bHCIYw
	 /t0v1S32AvYErRFZLqX0b5LWT+e11OSQQQF4iaTu5leTXTADXmHUxPlZXEqpfs7OPd
	 9Sj1+YzuJ/QU5guzicL0d9t+z7YylwMDZChMiPllUS7xwuzQ/mu7jgthjIcNAFJJZd
	 yjXTb8cKNpo8vdkleAXj/4w5MT8HhJLnTGhKRdrpZ5nyTCqC8IvnzouzYI4D6YHT/T
	 Z+ssvl6fail0Q==
Date: Thu, 3 Jul 2025 09:47:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	zhiyong.tao@mediatek.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add thermal sensor support
 on mt7981
Message-ID: <20250703-precious-busy-grouse-eb04b5@krzk-bin>
References: <20250702214830.255898-1-olek2@wp.pl>
 <20250702214830.255898-3-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702214830.255898-3-olek2@wp.pl>

On Wed, Jul 02, 2025 at 11:48:30PM +0200, Aleksander Jan Bajkowski wrote:
> The temperature sensor in the MT7981 is same as in the MT7986.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 32 ++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index 5cbea9cd411f..759b9e8059d9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> @@ -76,7 +76,7 @@ watchdog: watchdog@1001c000 {
>  			#reset-cells = <1>;
>  		};
>  
> -		clock-controller@1001e000 {
> +		apmixedsys: clock-controller@1001e000 {
>  			compatible = "mediatek,mt7981-apmixedsys";
>  			reg = <0 0x1001e000 0 0x1000>;
>  			#clock-cells = <1>;
> @@ -184,6 +184,32 @@ spi@1100b000 {
>  			status = "disabled";
>  		};
>  
> +		thermal@1100c800 {
> +			compatible = "mediatek,mt7981-thermal",
> +				     "mediatek,mt7986-thermal";
> +			reg = <0 0x1100c800 0 0x800>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_INFRA_THERM_CK>,
> +				 <&infracfg CLK_INFRA_ADC_26M_CK>;
> +			clock-names = "therm", "auxadc";
> +			nvmem-cells = <&thermal_calibration>;
> +			nvmem-cell-names = "calibration-data";
> +			#thermal-sensor-cells = <1>;
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +		};
> +
> +		auxadc: adc@1100d000 {
> +			compatible = "mediatek,mt7981-auxadc",
> +				     "mediatek,mt7986-auxadc",
> +				     "mediatek,mt7622-auxadc";

That's not what your binding said.

It does not look like you tested the DTS against bindings. Please run
'make dtbs_check W=1' (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

Best regards,
Krzysztof


