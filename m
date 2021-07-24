Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32B43D4879
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhGXPRJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 11:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXPRJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 11:17:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C548160E8E;
        Sat, 24 Jul 2021 15:57:37 +0000 (UTC)
Date:   Sat, 24 Jul 2021 17:00:07 +0100
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
Subject: Re: [PATCH 1/4] dt-bindings: iio: accel: bma255: Add
 interrupt-names
Message-ID: <20210724170007.40c93072@jic23-huawei>
In-Reply-To: <20210719112156.27087-2-stephan@gerhold.net>
References: <20210719112156.27087-1-stephan@gerhold.net>
        <20210719112156.27087-2-stephan@gerhold.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Jul 2021 13:21:53 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> The binding already allows specifying both interrupt pins, but there
> is currently no way to describe a board where (for whatever reason)
> only INT2 is connected. Make it possible to use "interrupt-names"
> to make it explicit which interrupt pin is meant in the interrupts.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/iio/accel/bosch,bma255.yaml      | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> index 5b35856b1942..897a1d808ef5 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> @@ -49,6 +49,14 @@ properties:
>        the second (optional) interrupt listed must be the one connected to the
>        INT2 pin (if available). The type should be IRQ_TYPE_EDGE_RISING.

Looks like this comment needs updating to say the ordering is only true if
interrupt-names is not present.

Jonathan


>  
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
>    mount-matrix:
>      description: an optional 3x3 mounting rotation matrix.
>  
> @@ -73,6 +81,7 @@ examples:
>              vddio-supply = <&vddio>;
>              vdd-supply = <&vdd>;
>              interrupts = <57 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "INT1";
>          };
>      };
>    - |

