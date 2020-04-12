Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71751A5EAF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLNFo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 09:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDLNFo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 09:05:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F86820705;
        Sun, 12 Apr 2020 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586696744;
        bh=vQ2ijPfgHyfD5uLqbnIBZ1qOAfAzreu0lThBZ/PCPUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A1sBPEX9yB5LNire+7Z43N3bLt7iLiCE0PVaiuwtl4intBYM+MgQ27zEyK687+m1v
         i5I2yClxSsnUPnOQezTT/1dJfbrYbw8WSLxY9mrk+7QTpLRXyUatQczYoc7m2pPfcu
         EEwm+MTaptw8JjWRHdiDjq2+jzC1Zy5Bfk1pUtnI=
Date:   Sun, 12 Apr 2020 14:05:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8 1/2] iio: proximity: provide device tree binding
 document
Message-ID: <20200412140539.4b4ddff1@archlinux>
In-Reply-To: <20200406172002.18028-2-i.mikhaylov@yadro.com>
References: <20200406172002.18028-1-i.mikhaylov@yadro.com>
        <20200406172002.18028-2-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Apr 2020 20:20:01 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
One comment inline preempting likely review from Rob.  I'd also like
there to be plenty of time for Rob and others to take a look before I
apply this.

Thanks,

Jonathan

> ---
>  .../bindings/iio/proximity/vcnl3020.yaml      | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> new file mode 100644
> index 000000000000..29ab2dee1694
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0

Very much preferred for new bindings to have a dual license including
BSD to allow there use outside of the Linux kernel.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/vcnl3020.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Integrated Proximity Sensor With Infrared Emitter
> +
> +maintainers:
> +  - Ivan Mikhaylov <i.mikhaylov@yadro.com>
> +
> +description: |
> +  The VCNL3020 is a fully integrated proximity sensor. Fully integrated means
> +  that the infrared emitter is included in the package. It has 16-bit
> +  resolution. It includes a signal processing IC and features standard I2C
> +  communication interface. It features an interrupt function.
> +
> +  Specifications about the devices can be found at:
> +  https://www.vishay.com/docs/84150/vcnl3020.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vishay,vcnl3020
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: IRQ line for the proximity sensor
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +  vishay,led-current-milliamp:
> +    description:
> +        IR LED current value with valid Range = 0 to 20d. e.g. 0 = 0 mA,
> +        1 = 10 mA, 20 = 200 mA (2 = 20 mA = DEFAULT). LED Current is
> +        limited to 200 mA for values higher than decimal 20.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
> +              18, 19, 20]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        proximity@13 {
> +              compatible = "vishay,vcnl3020";
> +              reg = <0x13>;
> +              vishay,led-current-milliamp = <0x14>;
> +        };
> +    };

