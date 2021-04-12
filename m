Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6539A35D250
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhDLVCk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 17:02:40 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39914 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbhDLVCk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 17:02:40 -0400
Received: by mail-oi1-f172.google.com with SMTP id i81so14837176oif.6;
        Mon, 12 Apr 2021 14:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHMtmNecrmY3y2fepgRRAMQ6iU5MAkDsfuHyT8BFdP8=;
        b=HaOVxIf9egW/Lrho1zEK4JvxV6Qw0N34RauFQA23uods3bFbZ1HMNCXQ3ZNlgUjwUy
         KxOSDTjJQYoBF3YBncLmQgpnR5MLIHR+c+jADyJoi57kqp+2QiWMFgB0s9zue75FuuJY
         XNBmwJxW3a5e4TibSROCNWgeuYYCHgGAOImVUydpZQrdlDleJDEHNVhMFSiPnfw9R4dg
         iNWualXVvCmZ6kP+X9mzqxbV7CumNGLJEQdaMyJ5+hGaxgedinyNoffHCntyRqCy5cEz
         FZPlT27BA7UgZXX1z8gzXE+SfpRRc62ai25iTEzAsbXDatnb2DLSadTB9DWXzwtrAqmt
         g6Sg==
X-Gm-Message-State: AOAM530VEluq3iKMV8WmRtFXHnyUvCVzzjrWJO6m52NiPbu5CR+dVs/Y
        JruV82UmjU4VGYwuEejX5cMDRqFXFQ==
X-Google-Smtp-Source: ABdhPJzMPKGimFvL8PxrICxQEBRfodPPJLvgC+E29eYLqMvHDh2koh5QSSC/u6KZd3VWtqCFyAH3LQ==
X-Received: by 2002:aca:75c6:: with SMTP id q189mr809266oic.29.1618261340214;
        Mon, 12 Apr 2021 14:02:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o18sm2919100ota.31.2021.04.12.14.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:02:19 -0700 (PDT)
Received: (nullmailer pid 164433 invoked by uid 1000);
        Mon, 12 Apr 2021 21:02:18 -0000
Date:   Mon, 12 Apr 2021 16:02:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: Add SCA3300 documentation
Message-ID: <20210412210218.GA162500@robh.at.kernel.org>
References: <20210412075056.56301-1-tomas.melin@vaisala.com>
 <20210412075056.56301-2-tomas.melin@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412075056.56301-2-tomas.melin@vaisala.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 12, 2021 at 10:50:55AM +0300, Tomas Melin wrote:
> initial DT bindings for Murata SCA3300 Accelerometer.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  .../bindings/iio/accel/sca3300.yaml           | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/sca3300.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/sca3300.yaml
> new file mode 100644
> index 000000000000..32fe4b647cd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/sca3300.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only)

For new bindings:

GPL-2.0-only OR BSD-2-Clause

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/sca3300.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Murata SCA3300 Accelerometer
> +
> +description: |
> +  3-axis industrial accelerometer with digital SPI interface
> +  https://www.murata.com/en-global/products/sensor/accel/sca3300
> +
> +maintainers:
> +  - Tomas Melin <tomas.melin@vaisala.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - murata,sca3300
> +
> +  reg:
> +    maxItems: 1
> +    description: SPI chip select number according to the general SPI bindings
> +
> +  spi-max-frequency:
> +    maximum: 8000000
> +
> +  murata,opmode:
> +    description: Accelerometer operation mode as described in datasheet (MODE)
> +    $ref: /schemas/types.yaml#/definitions/uint32

0 - 2^32 are all valid modes?

> +
> +required:
> +  - compatible
> +  - reg
> +  - murata,opmode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        sca3300@0 {

accelerometer@0

> +            compatible = "murata,sca3300";
> +            reg = <0x0>;
> +            spi-max-frequency = <4000000>;
> +            murata,opmode = <4>;
> +        };
> +    };
> +...
> -- 
> 2.21.3
> 
