Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6911C60C6
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEETHz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 15:07:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43729 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgEETHz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2020 15:07:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id g14so2619590otg.10;
        Tue, 05 May 2020 12:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yRzXKHUNDJ+mtxR4YILju7sSskHiz9OTnTLXZbQ3p2Y=;
        b=hIvg7SPDZem/i5nuv/x0WIHo3fP8UXKpoIxYdnDvlKZqdJFoCALTaVUOkXgNVFBqFa
         MVmbgeAecx9cWY3LFz9TW44i9g8n0DnazcP1MeDyyHVUt7OR0R0Ys/7nxpgONNIzGTDO
         9Smp5KK3fMUs6nmZIEmKIB3+F3WNbgzT+ZItryeunhuj6byIVBqErLA8y8nsLssxYxNN
         3as4AFTSUPMVD9rW/wJiAH+/34SbIzjCdm3MOngQR8HoHTvrlyV+BpUF68YshYYgAaDF
         KbZrkDmNvIshCsOhyF9gyvjQObU6l7SiOWVgXS4HbGOV6qlLo2y6Ga9kNtKjUW0od+zw
         ltug==
X-Gm-Message-State: AGi0PuYNHe4lL4/ufB+J9t/Vz2A9iWmQ2X2JaOMlrdULIHHUBkwzcNgF
        rhq9/RrwOt26X6Nkprw6yQ==
X-Google-Smtp-Source: APiQypK2eZKZF5A9T34e/f8dTGyfZ0o4fZJqUzZkYfTgjBhAmNs3W9y7CwGgIbJcYFLhw+3Fn9UvsA==
X-Received: by 2002:a9d:4716:: with SMTP id a22mr3514646otf.46.1588705674224;
        Tue, 05 May 2020 12:07:54 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm464168oon.5.2020.05.05.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 12:07:53 -0700 (PDT)
Received: (nullmailer pid 19674 invoked by uid 1000);
        Tue, 05 May 2020 19:07:52 -0000
Date:   Tue, 5 May 2020 14:07:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: iio/adc: Convert ingenic-adc docs to
 YAML.
Message-ID: <20200505190752.GA16143@bogus>
References: <20200503171451.44034-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503171451.44034-1-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 03, 2020 at 07:14:45PM +0200, Artur Rojek wrote:
> Convert the textual documentation of Device Tree bindings for the
> Ingenic JZ47xx SoCs ADC controller to YAML.
> 
> The `interrupts` property is now explicitly listed and marked as
> required. While missing from the previous textual documentation, this
> property has been used with all the boards which probe this driver.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v6: new patch
> 
>  .../bindings/iio/adc/ingenic,adc.txt          | 49 ------------
>  .../bindings/iio/adc/ingenic,adc.yaml         | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> deleted file mode 100644
> index cd9048cf9dcf..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -* Ingenic JZ47xx ADC controller IIO bindings
> -
> -Required properties:
> -
> -- compatible: Should be one of:
> -  * ingenic,jz4725b-adc
> -  * ingenic,jz4740-adc
> -  * ingenic,jz4770-adc
> -- reg: ADC controller registers location and length.
> -- clocks: phandle to the SoC's ADC clock.
> -- clock-names: Must be set to "adc".
> -- #io-channel-cells: Must be set to <1> to indicate channels are selected
> -  by index.
> -
> -ADC clients must use the format described in iio-bindings.txt, giving
> -a phandle and IIO specifier pair ("io-channels") to the ADC controller.
> -
> -Example:
> -
> -#include <dt-bindings/iio/adc/ingenic,adc.h>
> -
> -adc: adc@10070000 {
> -	compatible = "ingenic,jz4740-adc";
> -	#io-channel-cells = <1>;
> -
> -	reg = <0x10070000 0x30>;
> -
> -	clocks = <&cgu JZ4740_CLK_ADC>;
> -	clock-names = "adc";
> -
> -	interrupt-parent = <&intc>;
> -	interrupts = <18>;
> -};
> -
> -adc-keys {
> -	...
> -	compatible = "adc-keys";
> -	io-channels = <&adc INGENIC_ADC_AUX>;
> -	io-channel-names = "buttons";
> -	...
> -};
> -
> -battery {
> -	...
> -	compatible = "ingenic,jz4740-battery";
> -	io-channels = <&adc INGENIC_ADC_BATTERY>;
> -	io-channel-names = "battery";
> -	...
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> new file mode 100644
> index 000000000000..e9c46fff840a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019-2020 Artur Rojek
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/adc/ingenic,adc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Ingenic JZ47xx ADC controller IIO bindings
> +
> +maintainers:
> +  - Artur Rojek <contact@artur-rojek.eu>
> +
> +description: >
> +  Industrial I/O subsystem bindings for ADC controller found in
> +  Ingenic JZ47xx SoCs.
> +
> +  ADC clients must use the format described in iio-bindings.txt, giving
> +  a phandle and IIO specifier pair ("io-channels") to the ADC controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ingenic,jz4725b-adc
> +      - ingenic,jz4740-adc
> +      - ingenic,jz4770-adc
> +
> +  '#io-channel-cells':
> +    const: 1
> +    description:
> +      Must be set to <1> to indicate channels are selected by index.
> +
> +  reg:
> +    items:
> +      - description: ADC controller registers location and length.

That's all 'reg' properties. Just 'maxItems: 1' is good for single 
entry.

> +
> +  clocks:
> +    items:
> +      - description: phandle to the SoC's ADC clock.

Same here.

> +
> +  clock-names:
> +    items:
> +      - const: adc
> +
> +  interrupts:
> +    items:
> +      - description: IRQ line for the ADC.

And here.

> +
> +required:
> +  - compatible
> +  - '#io-channel-cells'
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/jz4740-cgu.h>
> +    #include <dt-bindings/iio/adc/ingenic,adc.h>
> +
> +    adc@10070000 {
> +            compatible = "ingenic,jz4740-adc";
> +            #io-channel-cells = <1>;
> +
> +            reg = <0x10070000 0x30>;
> +
> +            clocks = <&cgu JZ4740_CLK_ADC>;
> +            clock-names = "adc";
> +
> +            interrupt-parent = <&intc>;
> +            interrupts = <18>;
> +    };
> -- 
> 2.26.2
> 
