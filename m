Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80927198567
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 22:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgC3Ucy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 16:32:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38997 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgC3Ucx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 16:32:53 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so4877360iod.6;
        Mon, 30 Mar 2020 13:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uGrV7jzmVZ6lp3fYoGfMXzMSFPwx7qqWA6yYs9+zPaY=;
        b=cf0zldYflIzgrv/bLNls6d3ytDYRxsDkvBcj7STxLY1NFZTgF6ooEv+tUNWJT5XpvB
         O/E+mMIpyGet9Omgmp7aQTgQF3tQ8I+wZc7aHvz4RSKqUyZoBlHXs1pDCUcvIPyP1Lgo
         MDX2PV2p8lY4vaN94UmT3FjW59et+cYU2BUhKdgxPEga+qoVPpDp3LdL3HOL3pGWcGIX
         rKV1LDWK9UMu4DHqMbWSA455ksCwjjS5BvGyMeJUGX/hCYZuU1ShKIT1Pq3MJa3UgOfD
         Mx9HIfO/bR2m8HKXuo3bGn8kjwFR1xZpwC+mNIzdZRGuR3nXgm90MC9R34TelzsXai4N
         OxQg==
X-Gm-Message-State: ANhLgQ2UVRnqhXuW0Stwb+qaNZseFPkK120EPVf8tLBl0xeKoQ7iM0X8
        PJtaOK58wHB/4Ip2urOLWRe4fPE=
X-Google-Smtp-Source: ADFU+vuRS1yb0ZpQ8s0w4xohZ7ExBOpVYoxyX8tyHejpPPcJs/BEMfP74Okao3IbmgWtRAsHP/AlBA==
X-Received: by 2002:a5e:da0c:: with SMTP id x12mr12154932ioj.69.1585600372335;
        Mon, 30 Mar 2020 13:32:52 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i6sm5221949ila.20.2020.03.30.13.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:32:51 -0700 (PDT)
Received: (nullmailer pid 27005 invoked by uid 1000);
        Mon, 30 Mar 2020 20:32:50 -0000
Date:   Mon, 30 Mar 2020 14:32:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: iio: Add adis16475 documentation
Message-ID: <20200330203250.GA14978@bogus>
References: <20200316125312.39178-1-nuno.sa@analog.com>
 <20200316125312.39178-7-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316125312.39178-7-nuno.sa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 16, 2020 at 01:53:12PM +0100, Nuno Sá wrote:
> Document the ADIS16475 device devicetree bindings.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
> Changes in v2:
>  * Remove burst32 property;
>  * Rename clk-mode to adi,sync-mode;
>  * Remove clock-names;
>  * Add conditionals to state that clocks is only needed depending on adi,sync-mode property
> 
>  .../bindings/iio/imu/adi,adis16475.yaml       | 146 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> new file mode 100644
> index 000000000000..9eeb42773edd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16475.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16475 and similar IMUs
> +
> +maintainers:
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description: |
> +  Analog Devices ADIS16475 and similar IMUs
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADIS16475.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16475-1
> +      - adi,adis16475-2
> +      - adi,adis16475-3
> +      - adi,adis16477-1
> +      - adi,adis16477-2
> +      - adi,adis16477-3
> +      - adi,adis16470
> +      - adi,adis16465-1
> +      - adi,adis16465-2
> +      - adi,adis16465-3
> +      - adi,adis16467-1
> +      - adi,adis16467-2
> +      - adi,adis16467-3
> +      - adi,adis16500
> +      - adi,adis16505-1
> +      - adi,adis16505-2
> +      - adi,adis16505-3
> +      - adi,adis16507-1
> +      - adi,adis16507-2
> +      - adi,adis16507-3
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,
> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  adi,sync-mode:
> +    description:
> +      Configures the device SYNC pin. The following modes are supported
> +      0 - output_sync
> +      1 - direct_sync
> +      2 - scaled_sync
> +      3 - pulse_sync
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +
> +  adi,scaled-output-hz:
> +    description:
> +      This property must be present if the clock mode is scaled-sync through
> +      clock-names property. In this mode, the input clock can have a range
> +      of 1Hz to 128HZ which must be scaled to originate an allowable sample
> +      rate. This property specifies that rate.
> +    minimum: 1900
> +    maximum: 2100
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - adi,adis16500
> +          - adi,adis16505-1
> +          - adi,adis16505-2
> +          - adi,adis16505-3
> +          - adi,adis16507-1
> +          - adi,adis16507-2
> +          - adi,adis16507-3
> +
> +then:
> +  properties:
> +    adi,sync-mode:
> +      minimum: 0
> +      maximum: 2
> +
> +  if:
> +    properties:
> +      adi,sync-mode:
> +        enum: [1, 2]
> +
> +  then:
> +    dependencies:
> +      adi,sync-mode: [ clocks ]

You can remove this if/then if you...

> +
> +else:

> +  if:
> +    properties:
> +      adi,sync-mode:
> +        enum: [1, 2, 3]
> +
> +  then:
> +    dependencies:
> +      adi,sync-mode: [ clocks ]

...put this if by itself under an 'allOf'. (And then the 1st if should 
go under the 'allOf' too).

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            adis16475: adis16475-3@0 {
> +                    compatible = "adi,adis16475-3";
> +                    reg = <0>;
> +                    spi-cpha;
> +                    spi-cpol;
> +                    spi-max-frequency = <2000000>;
> +                    interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> +                    interrupt-parent = <&gpio>;
> +            };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f11262f1f3bb..f8ccc92ab378 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1015,6 +1015,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/imu/adis16475.c
>  F:	Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>  
>  ANALOG DEVICES INC ADM1177 DRIVER
>  M:	Beniamin Bia <beniamin.bia@analog.com>
> -- 
> 2.25.1
> 
