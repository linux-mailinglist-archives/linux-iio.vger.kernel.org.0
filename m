Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21E1AAAD8
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392440AbgDOOuZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 10:50:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34088 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392458AbgDOOuX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 10:50:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id m2so172244otr.1;
        Wed, 15 Apr 2020 07:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BCfQgZxvV4MoTZSYDxb0wNI9nAJHYoGxVLajTWTSLyY=;
        b=hl+ewQckLqhwBCz+umnf/61TE4+tdl5IzY2XZbw0EKxdGLwHUVFJOBYMVQfIODeIxD
         4rBgTjpluem8ZTvlobWiU7/tjMo/wrNrUgQT4HRhjP8+ZuiafSZXQ6bXVVALFBJ08uTx
         Cl41/icceRtRyCUs33OVukVWoEk4aeLKS+44cIX+kMOwXTYn3FmUS6+m/9gURX9Mh1ce
         A4pw0AWDUv90Jh9dVNdUcxkT7qQ6yhtVOuRVpK756V/y7GMOetdutSCZoKbDs0DOkpar
         JZ5GEHeo82l/kNxsZYZHFncxDM4Scw+4n3jv7QEl6842FsLG4Di7Cp8xHJre6FTJQw67
         p7MQ==
X-Gm-Message-State: AGi0Pub7TBeFQcPCtQtK9a4wS2sMitDVb+O1vFQ4n35WeeJ+lVYetG5T
        +R37nbvtbglmNDlyC0y2Rg==
X-Google-Smtp-Source: APiQypKcpijmKSyWUjzt28VMefad1XpVXfp9yRjVfdZ1IEIYQs06OXNoEWQPyd3SSWHWptV5JNctTA==
X-Received: by 2002:a05:6830:1606:: with SMTP id g6mr24123812otr.315.1586962222629;
        Wed, 15 Apr 2020 07:50:22 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm4454831otp.25.2020.04.15.07.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:50:21 -0700 (PDT)
Received: (nullmailer pid 25733 invoked by uid 1000);
        Wed, 15 Apr 2020 14:50:21 -0000
Date:   Wed, 15 Apr 2020 09:50:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8 1/2] iio: proximity: provide device tree binding
 document
Message-ID: <20200415145021.GA16420@bogus>
References: <20200406172002.18028-1-i.mikhaylov@yadro.com>
 <20200406172002.18028-2-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406172002.18028-2-i.mikhaylov@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 06, 2020 at 08:20:01PM +0300, Ivan Mikhaylov wrote:
> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
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

Dual license as Jonathan said.

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

Can drop this.

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

Should be indented 2 fewer spaces.

> +        1 = 10 mA, 20 = 200 mA (2 = 20 mA = DEFAULT). LED Current is
> +        limited to 200 mA for values higher than decimal 20.

Use the 'default' property to define the default.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Can drop this as standard units have a type already. However, the 
standard unit is '-microamp', so use that. Also, looks like this is 
in units of register values, not milliamps. Use microamps (e.g. 200000).

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
> -- 
> 2.21.1
> 
