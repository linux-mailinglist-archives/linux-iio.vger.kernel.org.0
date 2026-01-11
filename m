Return-Path: <linux-iio+bounces-27601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 513AFD0EDEB
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEAB2300EA2C
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA072330B20;
	Sun, 11 Jan 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co04IrTO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2E14F70;
	Sun, 11 Jan 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768134732; cv=none; b=aSJo5qk25rYrrvC2r68dQaViit43qUDLFyecZBMRZ0NMaOmzPAQRDHzvjA4WsWaTUKOl5VDoeXcMcON52W8DLYitHizabM/qSP9Cr6ql3ab+Rdygnvub3+NzMbUkRoeg5gGV/6AQxa1r0gdCa8SlpRq3rtNRv/FliIL8XB3Eopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768134732; c=relaxed/simple;
	bh=/pd5RYXxAu3TC9tzJphDPUQ5fhdFaNq6CB5bXbU/wiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1997zHfmnvYz8QFvQ6h6jW3Iz5/CPfQbijIaBxdq1NaxSXqSjR+zxt9RzTyvkeZONfLhFmi1Baz3NbrWr0LgPMU2xw1a9WuiNKI3JDOUST2GK4XwGjxfUwCxIP0yLfjn07M+k315lDjb96y9jnSKO4g2HVTl3un4kVhjCHgG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co04IrTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938ABC4CEF7;
	Sun, 11 Jan 2026 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768134732;
	bh=/pd5RYXxAu3TC9tzJphDPUQ5fhdFaNq6CB5bXbU/wiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Co04IrTOUyHZCmLvXU8QnWA204LTqwROk447Eok9bHD4n8ga+um6wuVU5pI01Bdzt
	 O0V9gmT5Uy0WBtT30VhPa2VGQVR1S+1OF/RxUQu8Ye/mm5kTApOXSLIPvXj05BaP7E
	 w1OObGKrcwSYhgLSkLSk1qXEXRr8+vNAiL+mCEoB+F1i9ykx1vXjQGodLNMmNDOk0z
	 bxLnPCj8PlCPcTrf7PdnS0shr5eE/P7WD3HtmlzIpgD//zKQwEwhvjNZXbYCvXkHrt
	 6ViXwOcpqPMn9UEsAJUVYSnVq+8aBnUL9X9o5xvbKEs1VtAUwjssM3SVJ8uLu9uGUO
	 O5yEiRiSyOBRw==
Date: Sun, 11 Jan 2026 12:32:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: akemnade@kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas
 Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in
 iio device property
Message-ID: <20260111123200.6871a41b@jic23-huawei>
In-Reply-To: <20251231-mpu9150-v1-2-08ecf085c4ae@kernel.org>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
	<20251231-mpu9150-v1-2-08ecf085c4ae@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 22:14:17 +0100
akemnade@kernel.org wrote:

> From: Andreas Kemnade <andreas@kemnade.info>
> 
> Define interrupts properly. Unfortunately, this hides a bug in the linux
> driver, so it needs to be used with the driver fixed only.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Not related to patch 1 so if TI soc folk can pick this up that would be
great.

> ---
>  arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
> index c90f43cc2fae9..a9f0cfd7c999d 100644
> --- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
> +++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
> @@ -346,7 +346,7 @@ mpu9150h: imu@68 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&mpu9150h_pins>;
>  		interrupt-parent = <&gpio2>;
> -		interrupt = <19 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  };
>  
> @@ -408,7 +408,7 @@ mpu9150: imu@68 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&mpu9150_pins>;
>  		interrupt-parent = <&gpio2>;
> -		interrupt = <7 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
>  		vddio-supply = <&cb_v18>;
>  		vdd-supply = <&cb_v33>;
>  		invensense,level-shifter;
> 


