Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2483FD0D9
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 03:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbhIABoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 21:44:12 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38683 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241525AbhIABoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 21:44:09 -0400
Received: by mail-ot1-f46.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso1633311ots.5;
        Tue, 31 Aug 2021 18:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hCM3xEaDsWUlYz9Se2pMGfcHujCF5fiVf0RMj3pYCeo=;
        b=WMRb1JPO7SNU6w3Yz9N8vfC4Cv+l5DYvp5GnYSSp8u3eA2TAI2WBTOhGHi6rAuwo2n
         PFjW61pNuPfU8WXzCCNv7+n0lyDyQM3VkO0hblU8p9TMmni3KJPyLBffdcN3HJjm+KJN
         cIRbyMrXvKCKJp97mY7ab+auTyJLqrIAPOr4UhsZ8zEvBvXZ1JVdb1/QSiwG+YeFKkHE
         6ya5B+1c/8CyUFQ3eJrEk2Lq+3whWhYumJzkkxGvM8sEN0SfDZWRDvVDR7SKm0bPSb0w
         3rWHBYa51MaONQav5ugCRSvCNW5yhHYst+LN9CkR3jgDEAQgZpABkfOOryRYkWYz70oD
         eLaw==
X-Gm-Message-State: AOAM5338IF/lvD2slU5doLhdPtknXOOy7GlwBRhPoyLFJwBda4CmQzbi
        SFixfi5K0ezMyA7jE/76U1mNcQpyoA==
X-Google-Smtp-Source: ABdhPJy5E1oEMIjLTTtUCwl2YQV+BuO2n23dP9m+AEIuAeIICepSSfHAJdDC482GpoNwA9hxg8QNtg==
X-Received: by 2002:a9d:71db:: with SMTP id z27mr27015780otj.292.1630460593123;
        Tue, 31 Aug 2021 18:43:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w12sm4069888oor.23.2021.08.31.18.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 18:43:12 -0700 (PDT)
Received: (nullmailer pid 1015346 invoked by uid 1000);
        Wed, 01 Sep 2021 01:43:11 -0000
Date:   Tue, 31 Aug 2021 20:43:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] dt-bindings: iio: chemical: sensirion,scd4x: Add
 yaml description
Message-ID: <YS7arxN5f8o5VZTI@robh.at.kernel.org>
References: <20210831074832.16310-1-roan@protonic.nl>
 <20210831074832.16310-2-roan@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831074832.16310-2-roan@protonic.nl>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 31, 2021 at 09:48:26AM +0200, Roan van Dijk wrote:
> Add documentation for the SCD4x carbon dioxide sensor from Sensirion.
> 
> Signed-off-by: Roan van Dijk <roan@protonic.nl>
> ---
>  .../iio/chemical/sensirion,scd4x.yaml         | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
> new file mode 100644
> index 000000000000..119356933b86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/sensirion,scd4x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SCD4X carbon dioxide sensor
> +
> +maintainers:
> +  - Roan van Dijk <roan@protonic.nl>
> +
> +description: |
> +  Air quality sensor capable of measuring co2 concentration, temperature
> +  and relative humidity.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,scd4x

Looks like there's 2 parts with a s/w visible difference (low power 
single shot mode). So this should be 2 compatibles without wildcards.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      co2-sensor@62 {
> +        compatible = "sensirion,scd4x";
> +        reg = <0x62>;
> +      };
> +    };
> -- 
> 2.30.2
> 
> 
