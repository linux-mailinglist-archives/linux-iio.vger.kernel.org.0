Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50562A4AD3
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 17:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKCQKm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 11:10:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33164 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCQKl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 11:10:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id i18so11718679ots.0;
        Tue, 03 Nov 2020 08:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yRn78cnLsToSH1wV9/DYOCyeH7pBej1x5JZS5/pv6vA=;
        b=I/eKBKe395FQw9TactnXdOls2J6NnZ2zZgEPT39/C4slV48RvM348lGI7Bf5dTOlLB
         qbfPFXdhT976NBhQpxuqKhq2jwQlE0nOr8npZ5ggY+ujt4BvbcJstKOAhC7gNCALk3w4
         JtLbD8cMdgk1HrnjfWsG/atiIvQuaScy4a00OzQfcyvBCw+h+9qI03llzgubfu+B/4jH
         5BRDFuVvTu/tK3uINtth4QFXnBOmC9CqwgOGz5SfO85AExFDCfeBUdcNdobGbcGwsBfL
         kLWf/Nwoa10u1OwMUD3tfqSCdfbxSKUjmDMnBXMJHyb/ULgBfAP5/nYZbplHGRz7Dei5
         wnew==
X-Gm-Message-State: AOAM532a1MEGqqNwef8i68gkCg/uk0ZqbnjshoZ4gJmYTn48USs5UVCs
        i3YgOse859XvRCdzKS2NCA==
X-Google-Smtp-Source: ABdhPJxI8HSaxtuIFrN1LTaDt5SxzSywmyOvYmKQrmnV1yhgm9RBLm/S+wxTvgpORP+10oeyxbk5bg==
X-Received: by 2002:a05:6830:113:: with SMTP id i19mr1286216otp.372.1604419840708;
        Tue, 03 Nov 2020 08:10:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w23sm1658044otp.38.2020.11.03.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:10:39 -0800 (PST)
Received: (nullmailer pid 1757934 invoked by uid 1000);
        Tue, 03 Nov 2020 16:10:39 -0000
Date:   Tue, 3 Nov 2020 10:10:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 02/46] dt-bindings:iio:potentiometer:adi,ad5272 yaml
 conversion
Message-ID: <20201103161039.GA1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-3-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:48:10PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple direct conversion from txt to yaml as part of a general aim of
> converting all IIO bindings to this machine readable format.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Phil Reid <preid@electromag.com.au>
> ---
>  .../bindings/iio/potentiometer/ad5272.txt     | 27 ----------
>  .../iio/potentiometer/adi,ad5272.yaml         | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> deleted file mode 100644
> index f9b2eef946aa..000000000000
> --- a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* Analog Devices AD5272 digital potentiometer
> -
> -The node for this device must be a child node of a I2C controller, hence
> -all mandatory properties for your controller must be specified. See directory:
> -
> -        Documentation/devicetree/bindings/i2c
> -
> -for more details.
> -
> -Required properties:
> -	- compatible:  	Must be one of the following, depending on the model:
> -			adi,ad5272-020
> -			adi,ad5272-050
> -			adi,ad5272-100
> -			adi,ad5274-020
> -			adi,ad5274-100
> -
> -Optional properties:
> - - reset-gpios: GPIO specification for the RESET input. This is an
> -		active low signal to the AD5272.
> -
> -Example:
> -ad5272: potentiometer@2f {
> -	reg = <0x2F>;
> -	compatible = "adi,ad5272-020";
> -	reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
> new file mode 100644
> index 000000000000..b9b7d383bff1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5272.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5272 digital potentiometer
> +
> +maintainers:
> +  - Phil Reid <preid@electromag.com.au>
> +
> +description: |
> +  Datasheet: https://www.analog.com/en/products/ad5272.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5272-020
> +      - adi,ad5272-050
> +      - adi,ad5272-100
> +      - adi,ad5274-020
> +      - adi,ad5274-100
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Active low signal to the AD5272 RESET input.

Not a new problem, but active low or...

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        potentiometer@2f {
> +            compatible = "adi,ad5272-020";
> +            reg = <0x2F>;
> +            reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;

active high?

> +        };
> +    };
> +...
> -- 
> 2.28.0
> 
