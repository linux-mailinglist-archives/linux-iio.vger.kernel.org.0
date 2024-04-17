Return-Path: <linux-iio+bounces-4326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561A8A8F06
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 00:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A17B2198A
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496B184FDB;
	Wed, 17 Apr 2024 22:55:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F784E1A;
	Wed, 17 Apr 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394548; cv=none; b=gjN1ZX9rsfOShGtNCuaOFo73CeBS9xyq7wXivL7LOxXx5R1TML2zJY/85zFVoM9CiP/ASI0wBvUg1ZdSTZUb5UhcleCe+I6nGlHqzFKsW2wPXw4WnYvBILqkW9FmWGKlRrzXV23/z0jy4kVC7Ma7GtwuVsLvOQ3KS8lfYnq4450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394548; c=relaxed/simple;
	bh=XUY7I9S7jT5JPtg05FHC5ABGEZ/eQWq4Bz2rnKOXsoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ag/IymAfxGIga5JBJ//41HmfH9gQGIcUVz8vHU1UYVe06MgFMNkJYNhmc++kKexcQfGEmRsC9v51gbjTk1CKt+A5lKNBady4ec81SN67JhCbo44nnPfYl/2G8yVO1iqejTzEN/WuWMkmTrF0kNXgzxXYr0at3+sIQQGD+cFLDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B04B339;
	Wed, 17 Apr 2024 15:56:12 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFB323F738;
	Wed, 17 Apr 2024 15:55:42 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:55:34 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 p.zabel@pengutronix.de, sboyd@kernel.org, mturquette@baylibre.com,
 samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, Chris Morgan
 <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/3] clk: sunxi-ng: h616: Add clock/reset for GPADC
Message-ID: <20240417235534.78446638@minigeek.lan>
In-Reply-To: <20240417170423.20640-2-macroalpha82@gmail.com>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
	<20240417170423.20640-2-macroalpha82@gmail.com>
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

On Wed, 17 Apr 2024 12:04:21 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

Hi,

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the GPADC required clock and reset which is used for the onboard
> GPADC.

Compared the register offsets, bit numbers and parent clock against the
manual: they match. Also the new clock numbers look fine.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c      | 5 +++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.h      | 2 +-
>  include/dt-bindings/clock/sun50i-h616-ccu.h | 1 +
>  include/dt-bindings/reset/sun50i-h616-ccu.h | 1 +
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> index 21e918582aa5..3646be2b88ab 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> @@ -489,6 +489,8 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x9b0,
>  
>  static SUNXI_CCU_GATE(bus_ts_clk, "bus-ts", "ahb3", 0x9bc, BIT(0), 0);
>  
> +static SUNXI_CCU_GATE(bus_gpadc_clk, "bus-gpadc", "apb1", 0x9ec, BIT(0), 0);
> +
>  static SUNXI_CCU_GATE(bus_ths_clk, "bus-ths", "apb1", 0x9fc, BIT(0), 0);
>  
>  static const char * const audio_parents[] = { "pll-audio-1x", "pll-audio-2x",
> @@ -807,6 +809,7 @@ static struct ccu_common *sun50i_h616_ccu_clks[] = {
>  	&bus_emac1_clk.common,
>  	&ts_clk.common,
>  	&bus_ts_clk.common,
> +	&bus_gpadc_clk.common,
>  	&bus_ths_clk.common,
>  	&spdif_clk.common,
>  	&bus_spdif_clk.common,
> @@ -940,6 +943,7 @@ static struct clk_hw_onecell_data sun50i_h616_hw_clks = {
>  		[CLK_BUS_EMAC1]		= &bus_emac1_clk.common.hw,
>  		[CLK_TS]		= &ts_clk.common.hw,
>  		[CLK_BUS_TS]		= &bus_ts_clk.common.hw,
> +		[CLK_BUS_GPADC]		= &bus_gpadc_clk.common.hw,
>  		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
>  		[CLK_SPDIF]		= &spdif_clk.common.hw,
>  		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
> @@ -1021,6 +1025,7 @@ static struct ccu_reset_map sun50i_h616_ccu_resets[] = {
>  	[RST_BUS_EMAC0]		= { 0x97c, BIT(16) },
>  	[RST_BUS_EMAC1]		= { 0x97c, BIT(17) },
>  	[RST_BUS_TS]		= { 0x9bc, BIT(16) },
> +	[RST_BUS_GPADC]		= { 0x9ec, BIT(16) },
>  	[RST_BUS_THS]		= { 0x9fc, BIT(16) },
>  	[RST_BUS_SPDIF]		= { 0xa2c, BIT(16) },
>  	[RST_BUS_DMIC]		= { 0xa4c, BIT(16) },
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> index fdd2f4d5103f..a75803b49f6a 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> @@ -51,6 +51,6 @@
>  
>  #define CLK_BUS_DRAM		56
>  
> -#define CLK_NUMBER		(CLK_PLL_SYSTEM_32K + 1)
> +#define CLK_NUMBER		(CLK_BUS_GPADC + 1)
>  
>  #endif /* _CCU_SUN50I_H616_H_ */
> diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h b/include/dt-bindings/clock/sun50i-h616-ccu.h
> index 6f8f01e67628..ebb146ab7f8c 100644
> --- a/include/dt-bindings/clock/sun50i-h616-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
> @@ -112,5 +112,6 @@
>  #define CLK_HDCP		126
>  #define CLK_BUS_HDCP		127
>  #define CLK_PLL_SYSTEM_32K	128
> +#define CLK_BUS_GPADC		129
>  
>  #endif /* _DT_BINDINGS_CLK_SUN50I_H616_H_ */
> diff --git a/include/dt-bindings/reset/sun50i-h616-ccu.h b/include/dt-bindings/reset/sun50i-h616-ccu.h
> index 1bd8bb0a11be..ed177c04afdd 100644
> --- a/include/dt-bindings/reset/sun50i-h616-ccu.h
> +++ b/include/dt-bindings/reset/sun50i-h616-ccu.h
> @@ -66,5 +66,6 @@
>  #define RST_BUS_TVE0		57
>  #define RST_BUS_HDCP		58
>  #define RST_BUS_KEYADC		59
> +#define RST_BUS_GPADC		60
>  
>  #endif /* _DT_BINDINGS_RESET_SUN50I_H616_H_ */


