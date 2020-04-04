Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3F19E640
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 17:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDDPsM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 11:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgDDPsM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 11:48:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B423206F8;
        Sat,  4 Apr 2020 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586015292;
        bh=f79TrnrnhzuAnsy0dVUGOTKKJcCZ4TFJB6dIy6CFPoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u6A75/dHENWT1DMubW2G0YYioDbgl/1hzaP+/TkAfdMx6OIYBX6Y362tVblQ0hAz9
         kCPCmBWSeNP67D2NGvb3a+23lgyZ8O5gyOXcAl1f3UWhI6pUDO2Q4IKNuJOV5BQLDH
         bmzTRMlavCQt91Buts3pOw+sAqiEkuqZWGkMyNpU=
Date:   Sat, 4 Apr 2020 16:48:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/5] dt-bindings: mfd: add document bindings for
 mp2629
Message-ID: <20200404164807.76b4d306@archlinux>
In-Reply-To: <20200329123110.26482-2-sravanhome@gmail.com>
References: <20200329123110.26482-1-sravanhome@gmail.com>
        <20200329123110.26482-2-sravanhome@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Mar 2020 14:31:06 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Add device tree binding information for mp2629 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> new file mode 100644
> index 000000000000..3c3cd023256a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0

For new bindings a dual license is preferred.  See most of the
bindings added recently.  This is to aid sharing outside of
the linux kernel tree.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MP2629 Battery Charger PMIC from Monolithic Power System.
> +
> +maintainers:
> +  - Saravanan Sekar <sravanhome@gmail.com>
> +
> +description: |
> +  MP2629 is a PMIC providing battery charging and power supply for smartphones,
> +  wireless camera and portable devices. Chip is contrlled over I2C.
> +
> +  The battery charge management device handles battery charger controller and
> +  ADC IIO device for battery, system voltage
> +
> +properties:
> +  compatible:
> +    const: mps,mp2629
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +    description:
> +      The first cell is the IRQ number, the second cell is the trigger type.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/input/linux-event-codes.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@4b {
> +            compatible = "mps,mp2629";
> +            reg = <0x4b>;
> +
> +            interrupt-controller;
> +            interrupt-parent = <&gpio2>;
> +            #interrupt-cells = <2>;
> +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };

