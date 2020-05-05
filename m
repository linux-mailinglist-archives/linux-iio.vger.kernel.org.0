Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0231A1C5C37
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgEEPpc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 11:45:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43115 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbgEEPpb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2020 11:45:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id j16so2171804oih.10;
        Tue, 05 May 2020 08:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ERx4rFY8Dz8RC1gA8oeju/oL9ln3h6g/sbUq2ZIsMqI=;
        b=UfhzIl90Cx/F9yuIdyxeWiIAluj9jHVn52BAWVU7+xF4MUL2VQkgcVKpzRvtrMnzfD
         /KVAbI+MORiK3Tzt0DxInwcc21gq6fifSNKoCckeGBpScp+MlJnXhb8p/8zE+UFBlMeU
         SuvTfpDebNXhobP7xUsnv/cPtiXpDb86C+i4YJwpbL6QQeA3whkBGTHu57sqaUoBuBZW
         Vbcvmm01xrNmGzHDBBDLZbJ9wB93B61DfBPD0UEpTAjr5gqsRqsIvHKD/v/VLHeTd63P
         ae7M6/dQceBZwzCMlDj4jZiY+JV4X4CBaQuA18azQiGfFN/jURRWE4DgLf7gw0TqfhQg
         tCiw==
X-Gm-Message-State: AGi0PuY7ZK+8owYLfyC/KZQr8CqD03wZI+ocz+HRfuD5jAoOkJ4brE7Q
        H9C6LPgc1VGFNU6YVec5mw==
X-Google-Smtp-Source: APiQypLcJPiZQqfn4NTS17L4CqyYIL327lpeUG2R1ri3KMTOCuIxKZ2yhA2w+R3hoxnFV84blQoz4w==
X-Received: by 2002:aca:3a55:: with SMTP id h82mr1248106oia.135.1588693530523;
        Tue, 05 May 2020 08:45:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m18sm625885oie.38.2020.05.05.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:45:29 -0700 (PDT)
Received: (nullmailer pid 11594 invoked by uid 1000);
        Tue, 05 May 2020 15:45:29 -0000
Date:   Tue, 5 May 2020 10:45:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v11 1/2] iio: proximity: provide device tree binding
 document
Message-ID: <20200505154528.GB4630@bogus>
References: <20200422160509.7117-1-i.mikhaylov@yadro.com>
 <20200422160509.7117-2-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422160509.7117-2-i.mikhaylov@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 07:05:08PM +0300, Ivan Mikhaylov wrote:
> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  .../bindings/iio/proximity/vcnl3020.yaml      | 64 +++++++++++++++++++

vishay,vcnl3020.yaml

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
> -- 
> 2.21.1
> 
