Return-Path: <linux-iio+bounces-4327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B28A8F0C
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 00:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB311C21354
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 22:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762384FDB;
	Wed, 17 Apr 2024 22:59:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB581748;
	Wed, 17 Apr 2024 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394744; cv=none; b=hVWgLJlil49YPbRnk4DCyexXjKp5/2amv66AO4/HCYqA8DnduXp0TeleUb2VJXp50R1Lqm854jbXXb3Sg1wdKndg1o2F9jIBpa9OAd3huCvzbklMlApmO4/Cn6d702licXG0SSnqgTEd01+JpbTCU19qcrp7jfz27NK2jztuafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394744; c=relaxed/simple;
	bh=6EV6uarjLYYDBWbSCEP741zg032Z+wl87/udIspl27U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBF2jRFok/wqSIT19qLNcKIh8nm6KRn/fN1iUC+V0qC+fG6z9vMz7J4tP3kRC3++Ld2Jqa8Ur3+q/I243dq9er27N7V5E02iNUBU4mJT0WwowSQRCYxsDIWUyX6mFKys/ayDZf84mL6q5ipSU3yH4Iush7eEsPwvdOmwNN29quM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F50339;
	Wed, 17 Apr 2024 15:59:29 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CD213F738;
	Wed, 17 Apr 2024 15:58:59 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:58:50 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 p.zabel@pengutronix.de, sboyd@kernel.org, mturquette@baylibre.com,
 samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, Chris Morgan
 <macromorgan@hotmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h616: Add GPADC device node
Message-ID: <20240417235850.15ab1a62@minigeek.lan>
In-Reply-To: <20240417170423.20640-4-macroalpha82@gmail.com>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
	<20240417170423.20640-4-macroalpha82@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 12:04:23 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The H616 has a GPADC controller which is identical to the one found on
> the D1/T113s/R329/T507 SoCs.

Compared against the manual:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre


> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index b2e85e52d1a1..3da37948b89f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -581,6 +581,17 @@ spdif: spdif@5093000 {
>  			status = "disabled";
>  		};
>  
> +		gpadc: adc@5070000 {
> +			compatible = "allwinner,sun50i-h616-gpadc",
> +				     "allwinner,sun20i-d1-gpadc";
> +			reg = <0x05070000 0x400>;
> +			clocks = <&ccu CLK_BUS_GPADC>;
> +			resets = <&ccu RST_BUS_GPADC>;
> +			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#io-channel-cells = <1>;
> +		};
> +
>  		ths: thermal-sensor@5070400 {
>  			compatible = "allwinner,sun50i-h616-ths";
>  			reg = <0x05070400 0x400>;


