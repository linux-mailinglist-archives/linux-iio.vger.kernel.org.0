Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3C301CC1
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 15:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbhAXOfF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 09:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbhAXOew (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 09:34:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C028622CF6;
        Sun, 24 Jan 2021 14:34:09 +0000 (UTC)
Date:   Sun, 24 Jan 2021 14:34:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: counter: add gpio-pulse-counter
 binding
Message-ID: <20210124143404.4a029d62@archlinux>
In-Reply-To: <20210122112434.27886-2-o.rempel@pengutronix.de>
References: <20210122112434.27886-1-o.rempel@pengutronix.de>
        <20210122112434.27886-2-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Jan 2021 12:24:33 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add binding for GPIO based pulse counter node
> 
This does make me wonder a bit on whether we are going to soon need
a  provider / consumer interface for the counter subsystem.

Afterall, this pulse is coming from something and I doubt it will
be long before we want to describe that 'something' plus it may
have additional controls etc.

Anyhow, that's a question for another day.  A few minor things inline.

Jonathan


> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/counter/gpio-pulse-counter.yaml  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml
> 
> diff --git a/Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml b/Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml
> new file mode 100644
> index 000000000000..dfa93956f15c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/gpio-pulse-counter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO base pulse counter

Whilst it's moderately obvious I think a short description here
would be useful. 


> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    const: virtual,gpio-pulse-counter
> +
> +  gpios:
> +    maxItems: 1
> +
> +required:
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    counter-0 {
> +        compatible = "virtual,gpio-pulse-counter";
> +        gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +    counter-1 {
> +        compatible = "virtual,gpio-pulse-counter";
> +        gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
> +    };

The second example doesn't tell us anything new, so I'd drop
it and just have counter-0



> +
> +...

