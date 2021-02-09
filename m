Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6853158FD
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 22:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhBIVwR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Feb 2021 16:52:17 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:41050 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbhBIVOh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2021 16:14:37 -0500
Received: by mail-oi1-f182.google.com with SMTP id v193so15533241oie.8;
        Tue, 09 Feb 2021 13:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y21BGXF/rTK0RY5HUqN7he2nqNs3jANAETLtHL2mgms=;
        b=UGRrTjzAGDsHSUqihj1r476Q+Hdtuul1xh5oA3jxWCzPvPoJw3+bT1IaZq6aAW0+qA
         LV+EBZNf0TQPAdR/s2wPhZM3IvGzXEaPj/dXOK32PxeH4zkrz8t553X/QmD3iVfPmPwF
         4cj8rb7dESHnpAikRYei71C7d6AB17UaGN4yzOtKv35aDPRyd6Jm5i9fu98PTqnF34zr
         UUrIHwdbMPbR2yCh8lxs2XfcH3WNoAHmyeLRmTRsFja2jotna1aad4aIkY+YfTsfR3WO
         f5Rx9OMJ+uAQeocsKu0UQoxSrdVBogfHSQtmQpu4mrNf6SW7QzjlI9+I6hx2ZXFQRZuq
         UPqQ==
X-Gm-Message-State: AOAM532FbWnDKvOOrGeeHqCiwKwjQu7EZcN8pimHx1O7rVPDg6kcqUIp
        QzKBRKoFGBTb5O4nMb9lgQ==
X-Google-Smtp-Source: ABdhPJzW1L/htZimMn1IPJG0SH9yT33KVK4LUAmwRUK4AYWsnh5Q4++AwWfU6W3pQYX85woXUTyUMQ==
X-Received: by 2002:aca:4085:: with SMTP id n127mr3755717oia.8.1612905230094;
        Tue, 09 Feb 2021 13:13:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k67sm3175110oia.7.2021.02.09.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:13:48 -0800 (PST)
Received: (nullmailer pid 197152 invoked by uid 1000);
        Tue, 09 Feb 2021 21:13:47 -0000
Date:   Tue, 9 Feb 2021 15:13:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Message-ID: <20210209211347.GA183847@robh.at.kernel.org>
References: <20210202184434.42644-1-swboyd@chromium.org>
 <20210202184434.42644-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184434.42644-3-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 02, 2021 at 10:44:33AM -0800, Stephen Boyd wrote:
> Some cros ECs support a front proximity MKBP event via
> 'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature via
> a node that is a child of the main cros_ec device node. Devices that
> have this ability will describe this in firmware.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../google,cros-ec-mkbp-proximity.yaml        | 46 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  3 ++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
> new file mode 100644
> index 000000000000..d82b929af445
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS EC MKBP Proximity Sensor
> +
> +maintainers:
> +  - Stephen Boyd <swboyd@chromium.org>
> +  - Benson Leung <bleung@chromium.org>
> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +
> +description: |
> +  Google's ChromeOS EC sometimes has the ability to detect user proximity.
> +  This is implemented on the EC as near/far logic and exposed to the OS
> +  via an MKBP switch bit.
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-mkbp-proximity
> +
> +  label:
> +    description: Name for proximity sensor
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +additionalProperties: false

Only need one. In this case 'additionalProperties'.

> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      ec@0 {
> +        compatible = "google,cros-ec-spi";
> +        reg = <0>;
> +        proximity {
> +          compatible = "google,cros-ec-mkbp-proximity";
> +          label = "proximity-wifi-lte";
> +        };

The complete examples I prefer is 1 example for the whole MFD in the MFD 
schema and no example here.

> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 76bf16ee27ec..479a9f15de32 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -94,6 +94,9 @@ properties:
>    keyboard-controller:
>      $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
>  
> +  proximity:
> +    $ref: "/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#"
> +
>    codecs:
>      type: object
>      additionalProperties: false
> -- 
> https://chromeos.dev
> 
