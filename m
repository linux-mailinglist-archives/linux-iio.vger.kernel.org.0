Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639222918B4
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 19:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgJRRxA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 13:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRRxA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 13:53:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3A422255;
        Sun, 18 Oct 2020 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603043579;
        bh=iQJlPjG3NBfM3PpFtjHDMaFpdxDT0niI2IBbsXp4df4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wu/ddRUXiOt8SEa6Hd3CY/6sRq0dVbeey3QP4XjhVEhs+BX4XNuEot1FmaQPvPa/5
         sjeLrItjqWnUBmSNNG+Z53mzZe+B/oHRHcpbIEiGPJN5uwAxWodmCKBwSLJCNRWtqV
         sSUv2EsOHfOyjWyyYVSCqJaDyMdKaN69tpRL9od0=
Date:   Sun, 18 Oct 2020 18:52:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 22/29] dt-bindings:iio:dac:nxp,lpc1850-dac yaml
 conversion.
Message-ID: <20201018185254.5b7f3e0f@archlinux>
In-Reply-To: <20201011170749.243680-23-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-23-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Oct 2020 18:07:42 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Very similar binding to that for the ADC on the same device.
> Conversion from txt to yaml format.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
Joachim's email is bouncing, so I'll list myself as maintainer for this
one.  @Vladimir, you are listed as maintainer of the lpc18xx parts in
general.  Any views on maintaining this binding?

+CC 	Vladimir Zapolskiy 
> ---
>  .../bindings/iio/dac/lpc1850-dac.txt          | 19 ------
>  .../bindings/iio/dac/nxp,lpc1850-dac.yaml     | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt b/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
> deleted file mode 100644
> index 42db783c4e75..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -NXP LPC1850 DAC bindings
> -
> -Required properties:
> -- compatible: Should be "nxp,lpc1850-dac"
> -- reg: Offset and length of the register set for the ADC device
> -- interrupts: The interrupt number for the ADC device
> -- clocks: The root clock of the ADC controller
> -- vref-supply: The regulator supply ADC reference voltage
> -- resets: phandle to reset controller and line specifier
> -
> -Example:
> -dac: dac@400e1000 {
> -	compatible = "nxp,lpc1850-dac";
> -	reg = <0x400e1000 0x1000>;
> -	interrupts = <0>;
> -	clocks = <&ccu1 CLK_APB3_DAC>;
> -	vref-supply = <&reg_vdda>;
> -	resets = <&rgu 42>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml b/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml
> new file mode 100644
> index 000000000000..2728ec3433e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/nxp,lpc1850-dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC1850 DAC bindings
> +
> +maintainers:
> +  - Joachim Eastwood <manabian@gmail.com>
> +
> +description:
> +  Supports the DAC found on the LPC1850 SoC.
> +
> +properties:
> +  compatible:
> +    const: nxp,lpc1850-dac
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  vref-supply: true
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - vref-supply
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/lpc18xx-ccu.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        dac: dac@400e1000 {
> +            compatible = "nxp,lpc1850-dac";
> +            reg = <0x400e1000 0x1000>;
> +            interrupts = <0>;
> +            clocks = <&ccu1 CLK_APB3_DAC>;
> +            vref-supply = <&reg_vdda>;
> +            resets = <&rgu 42>;
> +        };
> +    };
> +...

