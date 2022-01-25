Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DFA49AF0C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jan 2022 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454358AbiAYI7L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jan 2022 03:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453988AbiAYI47 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jan 2022 03:56:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E6C04D638
        for <linux-iio@vger.kernel.org>; Tue, 25 Jan 2022 00:02:21 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nCGmH-0006Qj-Ny; Tue, 25 Jan 2022 09:02:09 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nCGmF-0000KJ-Ib; Tue, 25 Jan 2022 09:02:07 +0100
Date:   Tue, 25 Jan 2022 09:02:07 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     linux-iio@vger.kernel.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, anand.ashok.dumbre@xilinx.com,
        jic23@kernel.org, lars@metafoo.de, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] arm64: dts: zynqmp: add AMS driver to device tree
Message-ID: <20220125080207.GC25856@pengutronix.de>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
 <20220120010246.3794962-2-robert.hancock@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120010246.3794962-2-robert.hancock@calian.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:59:31 up 45 days, 16:45, 76 users,  load average: 0.08, 0.36,
 0.38
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jan 2022 19:02:43 -0600, Robert Hancock wrote:
> Add an entry to the ZynqMP device tree to support the AMS device which
> now has a driver in mainline.
> 
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
>  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 +++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 26 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 1e0b1bca7c94..108592104a1b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -239,6 +239,10 @@ &lpd_watchdog {
>  	clocks = <&zynqmp_clk LPD_WDT>;
>  };
>  
> +&xilinx_ams {
> +	clocks = <&zynqmp_clk AMS_REF>;
> +};
> +
>  &zynqmp_dpdma {
>  	clocks = <&zynqmp_clk DPDMA_REF>;
>  };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 74e66443e4ce..d1fe1e5b46c1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -878,6 +878,32 @@ lpd_watchdog: watchdog@ff150000 {
>  			timeout-sec = <10>;
>  		};
>  
> +		xilinx_ams: ams@ffa50000 {
> +			compatible = "xlnx,zynqmp-ams";
> +			status = "disabled";
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 56 4>;
> +			reg = <0x0 0xffa50000 0x0 0x800>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#io-channel-cells = <1>;
> +			ranges = <0 0 0xffa50800 0x800>;
> +
> +			ams_ps: ams_ps@0 {
> +				compatible = "xlnx,zynqmp-ams-ps";
> +				status = "disabled";
> +				reg = <0x0 0x400>;
> +			};
> +
> +			ams_pl: ams_pl@400 {
> +				compatible = "xlnx,zynqmp-ams-pl";
> +				status = "disabled";
> +				reg = <0x400 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>  		zynqmp_dpdma: dma-controller@fd4c0000 {
>  			compatible = "xlnx,zynqmp-dpdma";
>  			status = "disabled";
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
