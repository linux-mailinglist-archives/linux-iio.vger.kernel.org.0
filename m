Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19432154D48
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 21:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgBFUqR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 15:46:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33299 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgBFUqM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 15:46:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so51470plb.0;
        Thu, 06 Feb 2020 12:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sMMUOJ1dmkcOXYOO3yw5bPGn6S7i93VnJXQW8PuR95g=;
        b=YZXj+IW++eKcnHShzZe5TITnHdOALEDkU5ga7lcmhn29d/95gRs4zOX3E+/np0iTfS
         vfs943Qx716q5IDh6xLlkOOv7LI59a7yoyboIWHummRlVj1S8746SyBpl2cCE+Mf8Mtb
         GLRFDnqhHTfnIYUPCfz4BV5ciRMYxtZSVWlMUXPOuI66jw/iMmyA3GZ468uFcgN/JWVX
         6FgB/ArqJzZ3UEetB9WXqf27thyIBRolhunjgX2AzyLw4cb23x7wgvgnKBDl+BYp9Deh
         WmG55shxiXRFoB5iqyqjl/Ze4osganyMWP/dZmdMTBgdcM4uYqSZ/Caklu7oBe5DN6VQ
         Y3gQ==
X-Gm-Message-State: APjAAAVPNL1uyx7v1IZsbPNgEG0P159JuNr5YJ4cmnVGb9nZEXbm5ZGJ
        TmVh2I6sIRoPqddxGIgMFw==
X-Google-Smtp-Source: APXvYqzGp2S5nKGhFS/AzmjJ2SfKCyJUGc80hTOiA6U59PWgA2OUv3astvinezo/swqiqr6tcm8gbQ==
X-Received: by 2002:a17:902:bc89:: with SMTP id bb9mr5595992plb.162.1581021972166;
        Thu, 06 Feb 2020 12:46:12 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id i64sm288884pgc.51.2020.02.06.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:11 -0800 (PST)
Received: (nullmailer pid 13714 invoked by uid 1000);
        Thu, 06 Feb 2020 19:07:58 -0000
Date:   Thu, 6 Feb 2020 19:07:58 +0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3320A
Message-ID: <20200206190758.GA11064@bogus>
References: <20200204093031.616409-1-david@ixit.cz>
 <20200204093031.616409-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204093031.616409-2-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 04, 2020 at 10:30:27AM +0100, David Heidelberg wrote:
> This commit add dt-bindings support to al3320a driver and vendor-prefix
> dynaimage.
> 
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/iio/light/al3320a.yaml           | 45 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/al3320a.yaml b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
> new file mode 100644
> index 000000000000..08e7ee4bdf55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only)

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/al3320a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dyna-Image AL3320A sensor
> +
> +maintainers:
> +  - David Heidelberg <david@ixit.cz>
> +
> +properties:
> +  compatible:
> +    const: dynaimage,al3320a
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
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdd-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        al3320a@1c {

light-sensor@1c

> +            compatible = "dynaimage,al3320a";
> +            reg = <0x1c>;
> +            vdd-supply = <&vdd_reg>;
> +            interrupts = <0 99 4>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 9cd52d9e1f7f..8d2ebf3d0aa1 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -267,6 +267,8 @@ patternProperties:
>      description: Dragino Technology Co., Limited
>    "^dserve,.*":
>      description: dServe Technology B.V.
> +  "^dynaimage,.*":
> +    description: Dyna-Image
>    "^ea,.*":
>      description: Embedded Artists AB
>    "^ebs-systart,.*":
> -- 
> 2.25.0
> 
