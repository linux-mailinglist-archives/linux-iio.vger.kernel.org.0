Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1AD185BE3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 11:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgCOKVN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 06:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbgCOKVN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 06:21:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACB720578;
        Sun, 15 Mar 2020 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584267672;
        bh=qSrdTdk+Bozzx6kRvjzqGnSnWYLTir83lwA0ikq8NP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KKGydK0cx0rTn8tjYeYi2WvlhSlF54CgzfR17XqNMjbHbZOYRmFKMLCw6vDQzPpPB
         ElCG+Qo7LqS7Aek/8dBcIBiAb/Mr/fjjPBkMxTUGfCvj+5PsvebTKRH5orPr4jwEu1
         qmDZ74IV1bi+WwHdy3mJdiNNVBKdyDgiaj+2tkqg=
Date:   Sun, 15 Mar 2020 10:21:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: add document bindings for
 mp2629
Message-ID: <20200315102107.5c174611@archlinux>
In-Reply-To: <20200315000013.4440-2-sravanhome@gmail.com>
References: <20200315000013.4440-1-sravanhome@gmail.com>
        <20200315000013.4440-2-sravanhome@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 01:00:09 +0100
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Add device tree binding information for mp2629 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Trivial inline.

> ---
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> new file mode 100644
> index 000000000000..f5b8c73123c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0
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
> +  MP2629 is an PMIC providing battery charging and power supply for smartphones,
> +  Wireless camera and portable devices. Chip is contrlled over I2C.

wireless (odd capitalization)

> +
> +  The MFD device handles battery charger controller and ADC IIO device for
> +  battery, system voltage
> +
> +properties:
> +  compatible:
> +    const: mps,mp2629
> +
> +  reg:
> +    description:
> +      I2C device address.

Could drop the description. It's a standard element for an i2c device.

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

