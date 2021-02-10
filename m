Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C1316F06
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 19:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhBJSom (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 13:44:42 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:43861 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhBJSmj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 13:42:39 -0500
Received: by mail-oi1-f179.google.com with SMTP id d20so3131668oiw.10;
        Wed, 10 Feb 2021 10:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvRsBEYZg1OGL2h8YrNGcRIKhfQwRTmU700nenwBJCU=;
        b=uf7i3Eshy9nmmEOyIefUjfxJYoRUBAEefN6uMpB0kSP7Ynv+21cKgwt9C4n45x03nT
         JcBjd83wOVNyRGMthLbL7v96CmTEXQlYqold9hagjp/MYW9jmf8X4e3ioj8ruXLAvLx3
         RUE86ymRjE0QjpIlXoeLkPTx47a4qAOtpUGS/I94CZDsCG85/jifaVnF9DKh1RIKfRH7
         /Urd7B9U6Js3OKM/K/x3pOV9lL6qj5FKT5GMFu7CoW9YEQKDD6yALqpnz/kyieGuRZir
         VR5rMIK2awT85A2EBe8Pr/oqx8fBhYyMwSR/C6M8Tv078DqOeD4hawVgfubrNZ7Ex07P
         xnpQ==
X-Gm-Message-State: AOAM530J+3Z1kkkXwmEcdtCwAyd/IewB8NqKv/RD0lh6ABo6InGd9z2c
        Omr6cMEByHk/jiR2SznKqg==
X-Google-Smtp-Source: ABdhPJy0dg2yL5pxwbejadofc57qJPksnh692O5UxdLMRiQVAsyc9qhhuYg0uPu28Ga8QsPWujeKTA==
X-Received: by 2002:aca:c704:: with SMTP id x4mr270547oif.24.1612982501184;
        Wed, 10 Feb 2021 10:41:41 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t19sm537508otr.64.2021.02.10.10.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:41:40 -0800 (PST)
Received: (nullmailer pid 2516555 invoked by uid 1000);
        Wed, 10 Feb 2021 18:41:38 -0000
Date:   Wed, 10 Feb 2021 12:41:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: counter: add event-counter binding
Message-ID: <20210210184138.GA2504266@robh.at.kernel.org>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208135347.18494-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 08, 2021 at 02:53:46PM +0100, Oleksij Rempel wrote:
> Add binding for the event counter node
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/counter/event-counter.yaml       | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/event-counter.yaml
> 
> diff --git a/Documentation/devicetree/bindings/counter/event-counter.yaml b/Documentation/devicetree/bindings/counter/event-counter.yaml
> new file mode 100644
> index 000000000000..bd05c1b38f20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/event-counter.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/event-counter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Event counter
> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description: |
> +  A generic event counter to measure event frequency. It was developed and used
> +  for agricultural devices to measure rotation speed of wheels or other tools.
> +  Since the direction of rotation is not important, only one signal line is
> +  needed.
> +
> +properties:
> +  compatible:
> +    const: event-counter
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpios:
> +    description: Optional diagnostic interface to measure signal level

This description seems wrong in the case of only having a GPIO.

Also, a GPIO only implies polled mode because if the GPIO is interrupt 
capable, 'interrupts' should be required. For gpio-keys, we split the 
compatible strings in this case. I leave it to you if you want to make 
it more explicit.

> +    maxItems: 1
> +
> +required:
> +  - compatible

anyOf:
  - required: [ interrupts ]
  - required: [ gpios ]

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    counter-0 {
> +        compatible = "event-counter";
> +        interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_RISING>;
> +    };
> +
> +    counter-1 {
> +        compatible = "event-counter";
> +        gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +    counter-2 {
> +        compatible = "event-counter";
> +        interrupts-extended = <&gpio 2 IRQ_TYPE_EDGE_RISING>;
> +        gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +...
> -- 
> 2.30.0
> 
