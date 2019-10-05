Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8418CCA47
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfJEOON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfJEOOM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:14:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8D120862;
        Sat,  5 Oct 2019 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570284851;
        bh=TuHflHmEutPUZp7LZpISROZKG+shrx1bA5GiMj2kLHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VciFKt0glXSsiTwp/G8D2YxJNiHTtUbK3rLe3DFTDFDxBWY8NSTbcJx5JahZ3Evn/
         p3NzfmXg4fJHQ4Mrp5hrnv057OZ5411sWDZ/7fyQclVbepiff0yMBxdfSMSXO2ZNOp
         Srg4VNhYrD0Au7or1nm4O1ewIAwPW+KWxFR6CBjY=
Date:   Sat, 5 Oct 2019 15:14:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com, wsa+renesas@sang-engineering.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/3] dt-bindings: iio: light: add veml6030 ALS
 bindings
Message-ID: <20191005151404.5fc7386f@archlinux>
In-Reply-To: <b9d5cb134c7c2c7351025a0b556148bca23f302f.1569321085.git.gupt21@gmail.com>
References: <cover.1569321085.git.gupt21@gmail.com>
        <b9d5cb134c7c2c7351025a0b556148bca23f302f.1569321085.git.gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Sep 2019 16:21:57 +0530
Rishi Gupta <gupt21@gmail.com> wrote:

> This commit adds device tree bindings for veml6030 ambient
> light sensor.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
looks fine to me, but...

DT bindings should always be sent to the DT-bindings maintainers and mailing list
for review.

+CC Rob, Mark and devicetree list.

Jonathan

> ---
> Changes in v2:
> * Corrected grammatical mistake from 'is' to 'are' in description of bindings
> 
>  .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
> new file mode 100644
> index 0000000..969b314
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/veml6030.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VEML6030 Ambient Light Sensor (ALS)
> +
> +maintainers:
> +  - Rishi Gupta <gupt21@gmail.com>
> +
> +description: |
> +  Bindings for the ambient light sensor veml6030 from Vishay
> +  Semiconductors over an i2c interface.
> +
> +  Irrespective of whether interrupt is used or not, application
> +  can get the ALS and White channel reading from IIO raw interface.
> +
> +  If the interrupts are used, application will receive an IIO event
> +  whenever configured threshold is crossed.
> +
> +  Specifications about the sensor can be found at:
> +    https://www.vishay.com/docs/84366/veml6030.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vishay,veml6030
> +
> +  reg:
> +    description:
> +      I2C address of the device. If the ADDR pin on veml6030
> +      is pulled up, this address is 0x48. If the ADDR pin is
> +      pulled down, this address is 0x10.
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ. Configure with IRQ_TYPE_LEVEL_LOW.
> +      Refer to interrupt-controller/interrupts.txt for generic
> +      interrupt client node bindings.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@10 {
> +                compatible = "vishay,veml6030";
> +                reg = <0x10>;
> +                interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...

