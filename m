Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1B92A4ADE
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 17:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCQL0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 11:11:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38956 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgKCQL0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 11:11:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id u127so18870456oib.6;
        Tue, 03 Nov 2020 08:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=izA+DsFWYrWR2JdLI3pux6z34mNI3rFF6y95SulNLCQ=;
        b=WyuTTy6iWu6U+Qj5Xm1q/3SlcS5XwBHZVGhbSqvp3obOUnuZsyYa1VfcQahCog/vnN
         zthBk22m2Pjpu49r3D67svYzR9xX/e4fX5lgvbFpJjMWkLazaygKPHNOYcB+Jl0oFud5
         NbfjCFZqD+FkXEwoBPql7OpDY5KLcRd0hLRHvYkF3YVHckU2dSFLvRJm709XhDoypZhV
         bEHxQho18M3aTVTOEjPRieZ4DRA6EILMFgaJlWtG17nJ7LjPPmzU0CnXqCDRd5PWtvIE
         mFvgIhuV5qm5dHNCAzLbL3kCat5CaCAkCEKYfutXhrFKWAsJIG/wYUHhMDBIsXhHpvzV
         CPXg==
X-Gm-Message-State: AOAM530ZU8l0NrGiqZ7bgwnpJgaLYIw8ayy2DAZyKaMi+Ka6WiUVr1QT
        oxQPmuCw+8MGoSVS8AmiFuIyVqCFjw==
X-Google-Smtp-Source: ABdhPJxe2/uKBTQXgkyLGuoIdrSyU5x7yb6M9oyC2y1F7y1tB6iFmC4QgFevS/SxuZ5ShSVC6jFzgA==
X-Received: by 2002:aca:5dc5:: with SMTP id r188mr293516oib.120.1604419884945;
        Tue, 03 Nov 2020 08:11:24 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w79sm3045087oia.28.2020.11.03.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:11:24 -0800 (PST)
Received: (nullmailer pid 1758930 invoked by uid 1000);
        Tue, 03 Nov 2020 16:11:23 -0000
Date:   Tue, 3 Nov 2020 10:11:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: Re: [PATCH 03/46] dt-bindings:iio:potentiometer:microchip,mcp4131
 txt to yaml conversion
Message-ID: <20201103161123.GB1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-4-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:48:11PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This binding is very simple, but I think the very large number of
> compatible values make it unsuitable for moving to trivial-devices.yaml.
> Main change in the conversion was reordering the compatible list to
> numerical order.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Slawomir Stepien <sst@poczta.fm>
> ---
>  .../bindings/iio/potentiometer/mcp4131.txt    |  84 ---------------
>  .../iio/potentiometer/microchip,mcp4131.yaml  | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 84 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp4131.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp4131.txt
> deleted file mode 100644
> index 3ccba16f7035..000000000000
> --- a/Documentation/devicetree/bindings/iio/potentiometer/mcp4131.txt
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -* Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X Digital Potentiometer
> -  driver
> -
> -The node for this driver must be a child node of a SPI controller, hence
> -all mandatory properties described in
> -
> -        Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -must be specified.
> -
> -Required properties:
> -	- compatible:  	Must be one of the following, depending on the
> -			model:
> -			"microchip,mcp4131-502"
> -			"microchip,mcp4131-103"
> -			"microchip,mcp4131-503"
> -			"microchip,mcp4131-104"
> -			"microchip,mcp4132-502"
> -			"microchip,mcp4132-103"
> -			"microchip,mcp4132-503"
> -			"microchip,mcp4132-104"
> -			"microchip,mcp4141-502"
> -			"microchip,mcp4141-103"
> -			"microchip,mcp4141-503"
> -			"microchip,mcp4141-104"
> -			"microchip,mcp4142-502"
> -			"microchip,mcp4142-103"
> -			"microchip,mcp4142-503"
> -			"microchip,mcp4142-104"
> -			"microchip,mcp4151-502"
> -			"microchip,mcp4151-103"
> -			"microchip,mcp4151-503"
> -			"microchip,mcp4151-104"
> -			"microchip,mcp4152-502"
> -			"microchip,mcp4152-103"
> -			"microchip,mcp4152-503"
> -			"microchip,mcp4152-104"
> -			"microchip,mcp4161-502"
> -			"microchip,mcp4161-103"
> -			"microchip,mcp4161-503"
> -			"microchip,mcp4161-104"
> -			"microchip,mcp4162-502"
> -			"microchip,mcp4162-103"
> -			"microchip,mcp4162-503"
> -			"microchip,mcp4162-104"
> -			"microchip,mcp4231-502"
> -			"microchip,mcp4231-103"
> -			"microchip,mcp4231-503"
> -			"microchip,mcp4231-104"
> -			"microchip,mcp4232-502"
> -			"microchip,mcp4232-103"
> -			"microchip,mcp4232-503"
> -			"microchip,mcp4232-104"
> -			"microchip,mcp4241-502"
> -			"microchip,mcp4241-103"
> -			"microchip,mcp4241-503"
> -			"microchip,mcp4241-104"
> -			"microchip,mcp4242-502"
> -			"microchip,mcp4242-103"
> -			"microchip,mcp4242-503"
> -			"microchip,mcp4242-104"
> -			"microchip,mcp4251-502"
> -			"microchip,mcp4251-103"
> -			"microchip,mcp4251-503"
> -			"microchip,mcp4251-104"
> -			"microchip,mcp4252-502"
> -			"microchip,mcp4252-103"
> -			"microchip,mcp4252-503"
> -			"microchip,mcp4252-104"
> -			"microchip,mcp4261-502"
> -			"microchip,mcp4261-103"
> -			"microchip,mcp4261-503"
> -			"microchip,mcp4261-104"
> -			"microchip,mcp4262-502"
> -			"microchip,mcp4262-103"
> -			"microchip,mcp4262-503"
> -			"microchip,mcp4262-104"
> -
> -Example:
> -mcp4131: mcp4131@0 {
> -	compatible = "mcp4131-502";
> -	reg = <0>;
> -	spi-max-frequency = <500000>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
> new file mode 100644
> index 000000000000..834d17ae3730
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/potentiometer/microchip,mcp4131.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X Digital Potentiometer

Blank line here.

> +maintainers:
> +  - Slawomir Stepien <sst@poczta.fm>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp4131-103
> +      - microchip,mcp4131-104
> +      - microchip,mcp4131-502
> +      - microchip,mcp4131-503
> +      - microchip,mcp4132-103
> +      - microchip,mcp4132-104
> +      - microchip,mcp4132-502
> +      - microchip,mcp4132-503
> +      - microchip,mcp4141-103
> +      - microchip,mcp4141-104
> +      - microchip,mcp4141-502
> +      - microchip,mcp4141-503
> +      - microchip,mcp4142-103
> +      - microchip,mcp4142-104
> +      - microchip,mcp4142-502
> +      - microchip,mcp4142-503
> +      - microchip,mcp4151-103
> +      - microchip,mcp4151-104
> +      - microchip,mcp4151-502
> +      - microchip,mcp4151-503
> +      - microchip,mcp4152-103
> +      - microchip,mcp4152-104
> +      - microchip,mcp4152-502
> +      - microchip,mcp4152-503
> +      - microchip,mcp4161-103
> +      - microchip,mcp4161-104
> +      - microchip,mcp4161-502
> +      - microchip,mcp4161-503
> +      - microchip,mcp4162-103
> +      - microchip,mcp4162-104
> +      - microchip,mcp4162-502
> +      - microchip,mcp4162-503
> +      - microchip,mcp4231-103
> +      - microchip,mcp4231-104
> +      - microchip,mcp4231-502
> +      - microchip,mcp4231-503
> +      - microchip,mcp4232-103
> +      - microchip,mcp4232-104
> +      - microchip,mcp4232-502
> +      - microchip,mcp4232-503
> +      - microchip,mcp4241-103
> +      - microchip,mcp4241-104
> +      - microchip,mcp4241-502
> +      - microchip,mcp4241-503
> +      - microchip,mcp4242-103
> +      - microchip,mcp4242-104
> +      - microchip,mcp4242-502
> +      - microchip,mcp4242-503
> +      - microchip,mcp4251-103
> +      - microchip,mcp4251-104
> +      - microchip,mcp4251-502
> +      - microchip,mcp4251-503
> +      - microchip,mcp4252-103
> +      - microchip,mcp4252-104
> +      - microchip,mcp4252-502
> +      - microchip,mcp4252-503
> +      - microchip,mcp4261-103
> +      - microchip,mcp4261-104
> +      - microchip,mcp4261-502
> +      - microchip,mcp4261-503
> +      - microchip,mcp4262-103
> +      - microchip,mcp4262-104
> +      - microchip,mcp4262-502
> +      - microchip,mcp4262-503
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        potentiometer@0 {
> +            compatible = "mcp4131-502";
> +            reg = <0>;
> +            spi-max-frequency = <500000>;
> +        };
> +    };
> +...
> -- 
> 2.28.0
> 
