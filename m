Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5421B8E38
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 11:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgDZJer (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 05:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgDZJer (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 05:34:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBD920700;
        Sun, 26 Apr 2020 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587893686;
        bh=kR/2T0w9mJ2ALzxxWE7yrQhRXtKJQ4uWeSGOt4AfhqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fho/YBffK/t7UX26k+VLGEZmmfe9aTKeWH1BSRttXhmqktyT/BqwPnW/Mh/D33Y0f
         KHd41pE2W33CpmB0/233MxFgvQf1TOUDfI/5Q1vm71pEgQTAUvkTon2hc/3ho6eX8I
         tKPh1C2RP3iZnSb/8JSamvLoR1OCBR80op9zKYpA=
Date:   Sun, 26 Apr 2020 10:34:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v11 1/2] iio: proximity: provide device tree binding
 document
Message-ID: <20200426103441.6d822c7c@archlinux>
In-Reply-To: <20200422160509.7117-2-i.mikhaylov@yadro.com>
References: <20200422160509.7117-1-i.mikhaylov@yadro.com>
        <20200422160509.7117-2-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 19:05:08 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Hm. I missed on previous versions that the title of this patch doesn't
match the dt-bindings standard.  Please look at other bindings patches.

e.g. dt-bindings: proximity: Add docs for vcnl3020 

One other comment inline from me.
> ---
>  .../bindings/iio/proximity/vcnl3020.yaml      | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> new file mode 100644
> index 000000000000..ac47770609d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +  vishay,led-current-microamp:
> +    description:
> +      IR LED current value with valid Range = 0 to 20d. e.g. 0 = 0 mA,
> +      1 = 10 mA, 20 = 200 mA. LED Current is limited to 200 mA for values
> +      higher than decimal 20.
The text doesn't add anything to the enum which fully defines the values.
I'd go with something simple like:

	 The drive current for the LED used in proximity sensing.

> +    enum: [0, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000,
> +          100000, 110000, 120000, 130000, 140000, 150000, 160000, 170000,
> +          180000, 190000, 200000]
> +    default: 20000
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
> +              vishay,led-current-microamp = <200000>;
> +        };
> +    };

