Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB839FD3
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFHNIn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfFHNIm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 09:08:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D235C214D8;
        Sat,  8 Jun 2019 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559999322;
        bh=qibYb2+Tw2dU1CRX2K6Pe0fUHlSQcrMnJPszrmFTEhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kTRP1lkBO7Th+hJvCqVvf+XqzIVK/0uWu3eIEfvOUMeo08sbbZhNqAWA4tBhpRAAU
         cxZT+WUFVo+JH59Hs5VOuMgzNoEe2MsbRoE+A3YnHo+I1inieh/m26DbgtMebGfp3g
         QTlveRLXp53g509Wy8dIXpS6xQCnxcwBp/vZKkEw=
Date:   Sat, 8 Jun 2019 14:08:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: dt-bindings: add the Amlogic Meson
 Temperature Sensor
Message-ID: <20190608140837.34a499a4@archlinux>
In-Reply-To: <20190604144714.2009-2-glaroque@baylibre.com>
References: <20190604144714.2009-1-glaroque@baylibre.com>
        <20190604144714.2009-2-glaroque@baylibre.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  4 Jun 2019 16:47:12 +0200
Guillaume La Roque <glaroque@baylibre.com> wrote:

> This adds the devicetree binding documentation for the Temperature
> Sensor found in the Amlogic Meson G12 SoCs.
> Currently only the G12A SoCs are supported.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Hi Guillaume,

I'm afraid we decided a month or so back that all new dt bindings proposed
for IIO drivers should be in yaml format.

Please reformat this appropriately for v2 and make sure to run
make dt_bindings_check.

There are a few examples in tree already, but we are deliberately
not converting existing bindings too quickly to avoid overloading
reviewers.

Thanks,

Jonathan

> ---
>  .../iio/temperature/amlogic,meson-tsensor.txt | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> new file mode 100644
> index 000000000000..d064db0e9cac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> @@ -0,0 +1,31 @@
> +* Amlogic Meson Temperature Sensor
> +
> +Required properties:
> +- compatible:	depending on the SoC and the position of the sensor,
> +		this should be one of:
> +		- "amlogic,meson-g12a-cpu-tsensor" for the CPU G12A SoC sensor
> +		- "amlogic,meson-g12a-ddr-tsensor" for the DDR G12A SoC sensor
> +		followed by the common :
> +		- "amlogic,meson-g12a-tsensor" for G12A SoC family
> +- reg:		the physical base address and length of the registers
> +- interrupts:	the interrupt indicating end of sampling
> +- clocks:	phandle identifier for the reference clock of temperature sensor
> +- #io-channel-cells: must be 1, see ../iio-bindings.txt
> +- amlogic,ao-secure: phandle to the ao-secure syscon
> +
> +Optional properties:
> +- amlogic,critical-temperature: temperature value in milli degrees Celsius
> +	to set automatic reboot on too high temperature
> +
> +Example:
> +	cpu_temp: temperature-sensor@ff634800 {
> +		compatible = "amlogic,meson-g12a-cpu-tsensor",
> +			     "amlogic,meson-g12a-tsensor";
> +		reg = <0x0 0xff634800 0x0 0x50>;
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc CLKID_TS>;
> +		status = "okay";
> +		#io-channel-cells = <1>;
> +		amlogic,meson-ao-secure = <&sec_AO>;
> +		amlogic,critical-temperature = <115000>;
> +	};

