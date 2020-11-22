Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EA62BC797
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKVRxE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 12:53:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgKVRxD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 12:53:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED84F20724;
        Sun, 22 Nov 2020 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606067582;
        bh=RuDsmgE6d/zwEDp4FusU75slPiHVn988+nwADEMHSuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gxoEQxxgNR3R6xEn4o5MOFDhFyoJoLTFjNzPPClL8Nm8zMd02J+LBvi4UIQqL0uqS
         DHiJI1VmXSIDTCIzNWpm4PUVMItU+VFJAyUcfZRhajcYVAhnoCfeCZTkrFMglywwgU
         EwEH2DliO0geE0I9U4zJ6erzSOARJYMdxo3Cbvm4=
Date:   Sun, 22 Nov 2020 17:52:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 21/46] dt-bindings:iio:light:vishay,vcnl4035: txt to
 yaml conversion
Message-ID: <20201122175258.28d5eab6@archlinux>
In-Reply-To: <20201031184854.745828-22-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-22-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 18:48:29 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Only significant change in here was dropping the statement that the
> i2c address should be 60.  The datasheet suggests there are variants
> available with several different addresses.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Parthiban Nallathambi <pn@denx.de>
Parithiban's email address is bouncing so for now I've put myself as maintainer.

Applied to the togreg branch of iio.git etc.

Thanks,

Jonathan

> ---
>  .../bindings/iio/light/vcnl4035.txt           | 18 --------
>  .../bindings/iio/light/vishay,vcnl4035.yaml   | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> deleted file mode 100644
> index c07c7f052556..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -VISHAY VCNL4035 -  Ambient Light and proximity sensor
> -
> -Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
> -
> -Required properties:
> -
> -	-compatible: should be "vishay,vcnl4035"
> -	-reg: I2C address of the sensor, should be 0x60
> -	-interrupts: interrupt mapping for GPIO IRQ (level active low)
> -
> -Example:
> -
> -light-sensor@60 {
> -	compatible = "vishay,vcnl4035";
> -	reg = <0x60>;
> -	interrupt-parent = <&gpio4>;
> -	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4035.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4035.yaml
> new file mode 100644
> index 000000000000..e41c25817dd8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4035.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/vishay,vcnl4035.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VISHAY VCNL4035 ambient Light and proximity sensor
> +
> +maintainers:
> +  - Parthiban Nallathambi <pn@denx.de>
> +
> +description: |
> +  Datasheet at https://www.vishay.com/docs/84251/vcnl4035x01.pdf
> +
> +properties:
> +  compatible:
> +    const: vishay,vcnl4035
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@60 {
> +            compatible = "vishay,vcnl4035";
> +            reg = <0x60>;
> +            interrupt-parent = <&gpio4>;
> +            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...

