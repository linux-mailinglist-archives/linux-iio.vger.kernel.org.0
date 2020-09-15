Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1397126ACFA
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgIOTFr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:05:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39231 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbgIOTDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:03:31 -0400
Received: by mail-io1-f67.google.com with SMTP id b6so5336444iof.6;
        Tue, 15 Sep 2020 12:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ly1yz9nKm3JN/gXJzH8btmk8nm+s28fFu8Tr5Az4Nhs=;
        b=VF7ibmSVkZsC0gEOGAioDYKGU2zjXU+ZeE4st5mSbr8Q/DCqSkG6UsQsgzlAf3EPsQ
         uVG6g3UQJJYO7rpsnOxLWQOvEjeMyTQ5R8VXT8lHgIpzol7MtmJZ/3YjClVSG147UD64
         n3shktEKd8wAey2y3UrA7bDkVpjNcprPklBzCUT1F59CCBeO5IqGpMmhX3f643e7ZmgD
         BiBdNOpOOjQ+IknrifF+WCCtH4pMudbAX8qtCGPl40DFIUUoZJrxsRImUjlfl/AfhPtA
         p43RJiiT1JHyn9oG0u63JB97e+pxAIx2jA5RslQx04ttMNP1q9JZjk+ulyjYod3fZ6Y5
         f1UQ==
X-Gm-Message-State: AOAM5302FKQ+f7auDjP7qLxxB9RVo3V/f5RwKonPwFId4dgHrSryt2MH
        da1JZQE03DiYCHjnHE1n8A==
X-Google-Smtp-Source: ABdhPJwPBHgpfTVrB3kSP+nsCZ7KrhOb3SVQ+rUaykN7vwhynoz0YKX+lX5bMeY/9gsuPsIee7+dCA==
X-Received: by 2002:a6b:f301:: with SMTP id m1mr15824880ioh.162.1600196609836;
        Tue, 15 Sep 2020 12:03:29 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l12sm7997799ioq.50.2020.09.15.12.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:03:29 -0700 (PDT)
Received: (nullmailer pid 2317192 invoked by uid 1000);
        Tue, 15 Sep 2020 19:03:28 -0000
Date:   Tue, 15 Sep 2020 13:03:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rick Altherr <raltherr@google.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH v2 04/20] dt-bindings:iio:adc: aspeed,ast2400 yaml
 conversion
Message-ID: <20200915190328.GA2315043@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-5-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 09, 2020 at 06:59:30PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple txt to yaml conversion. Part of a general move to convert
> all the IIO bindings over to yaml.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rick Altherr <raltherr@google.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
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

maxItems: 1

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

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
> -	adc@1e6e9000 {
> -		compatible = "aspeed,ast2400-adc";
> -		reg = <0x1e6e9000 0xb0>;
> -		clocks = <&syscon ASPEED_CLK_APB>;
> -		resets = <&syscon ASPEED_RESET_ADC>;
> -		#io-channel-cells = <1>;
> -	};
> -- 
> 2.28.0
> 
