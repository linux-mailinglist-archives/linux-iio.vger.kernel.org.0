Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7596439C246
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 23:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhFDVXK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 17:23:10 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36412 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFDVXI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 17:23:08 -0400
Received: by mail-ot1-f45.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10443213otl.3;
        Fri, 04 Jun 2021 14:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kYosb/cKVUWSGYlvgmKNCribweRE9u9fE7VTsItEJq8=;
        b=egbtU/CULIqm7WF2q7Auv6aAP/rXl3qcDNJzs4AkQ0bIc7a/i/QUs5bmsbbB5vsCEh
         ppNusBjiR4NKkKUpdFgkcxHfkeftZ8HY7Fk/Hg2S/kzJFgx8eGb7e5wjrwlRckPHgXKa
         rs5x4lOjLbWW0xinvJYnTIOUcGHAD5zoaF1hms93GHYIlqvD878EaL6spPAEULUV9dDn
         Wy1mx/wo97OVMXjqazItF8iavoUTSpS/W0c7szgZ9Z02wc2n/nILtVuq/s6NJGaSiUQm
         QPZm6lu5OqfNGaP3TBfzK8uLs7dKzIyLkwjJY9VScP3dz8xXKf13oY2S60BjiazCQs4A
         PaGA==
X-Gm-Message-State: AOAM530H15/S6Ze1zYsweLZeqYLNwYfhweRhn96KbUMi2MoCV+rNHb0K
        ZkvM3Xqz7Q0wAtVDSUfCQFx6DqG17A==
X-Google-Smtp-Source: ABdhPJzJEcsl68ZtAR0iGgHQuxDOSOPtQhkbVNlb/wOKiOor0QOcpNhV4HL8BPALAi7wTGqZ4qZiSQ==
X-Received: by 2002:a05:6830:13c4:: with SMTP id e4mr5080999otq.315.1622841667469;
        Fri, 04 Jun 2021 14:21:07 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m6sm718311ots.74.2021.06.04.14.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:21:06 -0700 (PDT)
Received: (nullmailer pid 3939769 invoked by uid 1000);
        Fri, 04 Jun 2021 21:21:05 -0000
Date:   Fri, 4 Jun 2021 16:21:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 8/9] dt-bindings: iio: afe: add binding for
 temperature-sense-current
Message-ID: <20210604212105.GA3933811@robh.at.kernel.org>
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-9-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530005917.20953-9-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 29, 2021 at 08:59:16PM -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, the measurement of a temperature through
> a current sense amplifier (such as an AD590) and a sense resistor.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-current.yaml    | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> new file mode 100644
> index 000000000000..1bac74486102
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-current.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Sense Current
> +
> +maintainers:
> +  - Liam Beguin <lvb@xiphos.com>
> +
> +description: |
> +  When an io-channel measures the output voltage for a temperature current
> +  sense amplifier such as the AD950, the interesting measurement is almost
> +  always the corresponding temperature, not the voltage output.
> +  This binding describes such a circuit.
> +
> +properties:
> +  compatible:
> +    const: temperature-sense-current
> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  '#io-channel-cells':
> +    const: 1

Belongs in provider unless this is a consumer and provider.

> +
> +  sense-resistor-ohms:
> +    description: The sense resistance.
> +
> +  alpha-micro-amps-per-degree:
> +    description: |
> +      Linear output current gain of the temperature IC.
> +
> +  use-kelvin-scale:
> +    type: boolean
> +    description: |
> +      Boolean indicating if alpha uses Kelvin degrees instead of Celsius.
> +
> +additionalProperties: false

blank line

> +required:
> +  - compatible
> +  - io-channels
> +  - sense-resistor-ohms
> +  - alpha-micro-amps-per-degree
> +
> +examples:
> +  - |
> +    ad590: iio-rescale0 {
> +        compatible = "temperature-sense-current";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc 2>;
> +
> +        sense-resistor-ohms = <8060>;
> +        use-kelvin-scale;
> +        alpha-micro-amps-per-degree = <1>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7279af85adb..0eb7fcd94b66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
> -- 
> 2.30.1.489.g328c10930387
