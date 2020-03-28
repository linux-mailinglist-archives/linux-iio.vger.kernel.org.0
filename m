Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594A61966D2
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgC1Ozj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgC1Ozj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:55:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672F3206F2;
        Sat, 28 Mar 2020 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585407338;
        bh=sTN/yOwC7X0uLoNfJ9ADxa7Cha6qzKRX2MNvBqrW41M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OLbqOcprrVgGuO5bodcCM4BQ/l6Al3r3Ww9tqVljQ+YOVriGez5jmY1ilVGbU2RI5
         MChEZD5Ex6p5UEOCJnpXSy5lxMIhODy/AjtkuYZUqKSGeRKbL3lIcZMxkM+9QwpTWp
         JAFwjKLwtTg54ZMiipEWS13nL6qBWSgBuz5DeViE=
Date:   Sat, 28 Mar 2020 14:55:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/2] iio: proximity: provide device tree binding
 document
Message-ID: <20200328145533.35f77e48@archlinux>
In-Reply-To: <20200327104954.27829-2-i.mikhaylov@yadro.com>
References: <20200327104954.27829-1-i.mikhaylov@yadro.com>
        <20200327104954.27829-2-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020 13:49:53 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

A few things inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/proximity/vcnl3020.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> new file mode 100644
> index 000000000000..116aa0e0174d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0
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
> +  led-current:
> +    description:

Given it has real values, that would be human readable, lets use them!
Also I don't think this is a standard binding so also need a vendor
prefix.

vishay,led-current-microamp taking
0, 10, 20, 30 etc..

Threat it as an enum with all the values listed and we can also enforce
that it is a valid value via the binding.

> +        IR LED current value with valid Range = 0 to 20d. e.g. 0 = 0 mA,
> +        1 = 10 mA, 20 = 200 mA (2 = 20 mA = DEFAULT). LED Current is
> +        limited to 200 mA for values higher than decimal 20.
> +
> +required:
> +  - compatible
> +  - reg
> +  - led-current

You list a default above so is it required?

> +
> +examples:
> +  - |
> +    i2c {
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        iio-proximity@13 {

just proximity.  IIO is a linux concept, devicetree is general.

> +              compatible = "vishay,vcnl3020";
> +              reg = <0x13>;
> +              led-current = <0x14>;
> +        };
> +    };

