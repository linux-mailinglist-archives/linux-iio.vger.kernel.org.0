Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC343D487E
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhGXPUT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 11:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXPUT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 11:20:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7116E60EAF;
        Sat, 24 Jul 2021 16:00:47 +0000 (UTC)
Date:   Sat, 24 Jul 2021 17:03:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 2/4] dt-bindings: iio: accel: bma255: Add
 bosch,bmc156_accel
Message-ID: <20210724170318.771cbeeb@jic23-huawei>
In-Reply-To: <20210719112156.27087-3-stephan@gerhold.net>
References: <20210719112156.27087-1-stephan@gerhold.net>
        <20210719112156.27087-3-stephan@gerhold.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Jul 2021 13:21:54 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> BMC156 is very smilar to BMC150, but it has only one accelerometer
> interrupt pin. It would make sense if only INT1 was exposed but someone
> at Bosch was crazy and decided to only have an INT2 pin.
> 
> In this case, it does not make sense if the first interrupt pin is
> treated as INT1 (since that pin does not exist). Add a note to the
> bindings that the first interrupt pin is treated as INT2 for BMC156.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/iio/accel/bosch,bma255.yaml       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> index 897a1d808ef5..f7848e4a7b29 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> @@ -26,6 +26,7 @@ properties:
>        - bosch,bma255
>        - bosch,bma280
>        - bosch,bmc150_accel
> +      - bosch,bmc156_accel
>        - bosch,bmi055_accel
>  
>        # bma180 driver in Linux
> @@ -49,6 +50,9 @@ properties:
>        the second (optional) interrupt listed must be the one connected to the
>        INT2 pin (if available). The type should be IRQ_TYPE_EDGE_RISING.
>  
> +      BMC156 does not have an INT1 pin, therefore the first interrupt pin is
> +      always treated as INT2.

We 'could' enforce any name present for the bmc156 to be INT2, but we probably
still want the fallback you have in the driver to handle the case of
not interrupt-name provided.

Rob, do you think it's worth the complexity for this corner case?

Jonathan
> +
>    interrupt-names:
>      minItems: 1
>      maxItems: 2
> @@ -84,6 +88,20 @@ examples:
>              interrupt-names = "INT1";
>          };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        accelerometer@10 {
> +            compatible = "bosch,bmc156_accel";
> +            reg = <0x10>;
> +            vddio-supply = <&vddio>;
> +            vdd-supply = <&vdd>;
> +            interrupts = <116 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "INT2";
> +        };
> +    };
>    - |
>      # include <dt-bindings/interrupt-controller/irq.h>
>      spi {

