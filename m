Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C35263A9D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 04:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgIJCfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 22:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgIJCdy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 22:33:54 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8480C061573;
        Wed,  9 Sep 2020 19:32:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so4737236edv.1;
        Wed, 09 Sep 2020 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWT97yy/lfN++yK+3hmvJmTiGbb9VXyAZ9/Zg/KaUXY=;
        b=kp/7rc1enm4PY5SDiFcIoUYwg84bEnbNEYMTQ8qp+9Pp/MQeIlxEd4fMMbE1aS0TzR
         Yc2FJVyvt6AQK4yOH+BhPgSMIkken4Eg1eSbD+dPGjm9JaVcCWybamwRwMpcPIvt7BXX
         x6o75w2WDcnpHJOBRBRkXzVZC2P0LHmsdvl04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWT97yy/lfN++yK+3hmvJmTiGbb9VXyAZ9/Zg/KaUXY=;
        b=qdNcQi89KXHMhoPwbjD15LJc4B2J9NCKaNulr3dBmdqm2mP9jp2RtQHnwVcf/uFarg
         yjWoFeUxgxPG+q0qf80ysrW50JnDCJXr0KAs8gZt2taUTL4ysu7r7Iuk3STuBC+6MfI2
         jA/JLOHy7zrQDcNUbqyHaeDwpcsbtM6G8In5SJxF/nbSEYeYtZ2Kdv0v84FsAyrxklLP
         3CMYz7BsiDwpBXrXgSoC8/0SzF0ItpQYL1bzwStmbj10DAv7f9eSxqBHLTXdoY3jh+vX
         nx7RgKK69YMWuYg2pjHluhdfEvU24Rc+cIaND324/Ju4boola7nshjI0P2CBj72KIt1E
         xK2A==
X-Gm-Message-State: AOAM533d+H7EoBINMYvTcdSBUj1y35puSwEWBSLeozKWIDAfvJEZCIzz
        1RjBsfjNq1w+2CR0+ven2xYaPKebDlEOIRP9vpjpgWc8
X-Google-Smtp-Source: ABdhPJxhv5HYB0Xtoz82eBUKLuVFbP9wApM1PlcILnkhgvYHT12658eGPvVkQrcDAELzZLJ0ap/G3eFoFxqgU7JHkUw=
X-Received: by 2002:a05:6402:220d:: with SMTP id cq13mr7068356edb.260.1599705151522;
 Wed, 09 Sep 2020 19:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200909175946.395313-1-jic23@kernel.org> <20200909175946.395313-5-jic23@kernel.org>
In-Reply-To: <20200909175946.395313-5-jic23@kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Sep 2020 02:32:19 +0000
Message-ID: <CACPK8Xc+GpVVLvBdz5zHTndBeP0bd7SKLDZq7H6rDUDsd0kMdA@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] dt-bindings:iio:adc: aspeed,ast2400 yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rick Altherr <raltherr@google.com>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Sep 2020 at 18:02, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simple txt to yaml conversion. Part of a general move to convert
> all the IIO bindings over to yaml.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rick Altherr <raltherr@google.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>


> ---
>  .../bindings/iio/adc/aspeed,ast2400-adc.yaml  | 54 +++++++++++++++++++
>  .../bindings/iio/adc/aspeed_adc.txt           | 22 --------
>  2 files changed, 54 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
> new file mode 100644
> index 000000000000..09018487d690
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml

This naming doesn't make sense, as the bindings are for the ast2500
too (and they also apply for the ast2600).

> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2400-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADC that forms part of an ASPEED server management processor.
> +
> +maintainers:
> +  - Rick Altherr <raltherr@google.com>
> +
> +description:
> +  This device is a 10-bit converter for 16 voltage channels.  All inputs are
> +  single ended.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-adc
> +      - aspeed,ast2500-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Input clock used to derive the sample clock. Expected to be the
> +      SoC's APB clock.
> +
> +  resets: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    adc@1e6e9000 {
> +        compatible = "aspeed,ast2400-adc";
> +        reg = <0x1e6e9000 0xb0>;
> +        clocks = <&syscon ASPEED_CLK_APB>;
> +        resets = <&syscon ASPEED_RESET_ADC>;
> +        #io-channel-cells = <1>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> deleted file mode 100644
> index 034fc2ba100e..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -Aspeed ADC
> -
> -This device is a 10-bit converter for 16 voltage channels.  All inputs are
> -single ended.
> -
> -Required properties:
> -- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
> -- reg: memory window mapping address and length
> -- clocks: Input clock used to derive the sample clock. Expected to be the
> -          SoC's APB clock.
> -- resets: Reset controller phandle
> -- #io-channel-cells: Must be set to <1> to indicate channels are selected
> -                     by index.
> -
> -Example:
> -       adc@1e6e9000 {
> -               compatible = "aspeed,ast2400-adc";
> -               reg = <0x1e6e9000 0xb0>;
> -               clocks = <&syscon ASPEED_CLK_APB>;
> -               resets = <&syscon ASPEED_RESET_ADC>;
> -               #io-channel-cells = <1>;
> -       };
> --
> 2.28.0
>
