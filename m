Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFF525E86
	for <lists+linux-iio@lfdr.de>; Fri, 13 May 2022 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378530AbiEMIsw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 May 2022 04:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378570AbiEMIst (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 May 2022 04:48:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A084814C760
        for <linux-iio@vger.kernel.org>; Fri, 13 May 2022 01:48:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d6so9156618ede.8
        for <linux-iio@vger.kernel.org>; Fri, 13 May 2022 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gxWA2eI2ibgIIaNeL9BTiWwh7yepFkmtPplmsANljIU=;
        b=fyAZtNkVRet3CqlJuO3iUCqEInUUV7abCdfI3nC47/p+HyZW30V2Vqrf+fPT60vTKA
         RIuPeM4ArUI5eLAdjAKZQlwWMpVBe3YHq8m6AFAKoSHbW2UCn/1O45utYv3zKHj99jYH
         7Vs127/rj4k8sttyEIiDotLztO82wNJUWMXn0JP9Sw8Lz0wTSXkt4vMVhCJQTbHW1e24
         ggBUS7baKZHkD6jhr+yDbGdUDjhWt2DvJTbc9fknVHrdW7CRUGYKSvyhbwgVe0xdQW6a
         tWpxs/pQH0PQzsJlKjLbOXBaIxyNC/jpLdLnDPRZsnMXjLyjvjMRm5/2z9xy7gwQDfc3
         yckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gxWA2eI2ibgIIaNeL9BTiWwh7yepFkmtPplmsANljIU=;
        b=LG82xU+XK5bTzaAPUB3FKc6R1iDVkmiAwwQQ52b3Ww0um7J3uMTNouN4FxRyliCAf8
         Ok7XYV9zrSllVTpPC+6ofOSJsehPQF/fgo4CQ/Y2shVcZYRp2NS8NXsaHYa9kmr/4z3T
         5foyD+q9t8NKwq23/RKnaJvG20Rb1mvdsXwJJN39M0D2srBE2j9i0PbuvjY2Jki+Jro5
         4qi3pbJSTD9+I4EucySLju7pH+jxkqYpGyhDiHvQBGjITSSOAeH+WfYjPOM+ybsbpbeI
         QnsoNvXiPsl+laOFQvXxcfxklcdWxdE+Jzxnq/trQRyG1TBJGRD+CMpe/NuvNilMsZg5
         7zuw==
X-Gm-Message-State: AOAM531jDVclgxuj9fQHiz6S8G9JSrqQoMpPy/lRBVKuQPS5u6qx2Dl4
        4R0F0z1YqJXSbhPedrF3bIW56g==
X-Google-Smtp-Source: ABdhPJwlWwvXgU7aF6Cscno2USHQ0ZXgPfK8ccIxhOVwMYKRXjcKM9wagMsXjaQh8FIahP3a0yeKUw==
X-Received: by 2002:a05:6402:3490:b0:427:b471:9e1e with SMTP id v16-20020a056402349000b00427b4719e1emr38861806edc.36.1652431723172;
        Fri, 13 May 2022 01:48:43 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t20-20020a056402525400b0042617ba63ccsm667368edd.86.2022.05.13.01.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:48:42 -0700 (PDT)
Message-ID: <aa090e32-6e6e-b318-f2ef-5f61d0d89da7@linaro.org>
Date:   Fri, 13 May 2022 10:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dbarksdale@uplogix.com
References: <20220511190835.51046-1-eajames@linux.ibm.com>
 <20220511190835.51046-2-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511190835.51046-2-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/05/2022 21:08, Eddie James wrote:
> Document the si7020 bindings with a new "silabs,skip-reset" property.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Thank you for your patch. There is something to discuss/improve.

> ---
>  .../bindings/iio/humidity/silabs,si7020.yaml  | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> new file mode 100644
> index 000000000000..ab53bb8d9606
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/silabs,si7020.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SI7020 humidity + temperature sensor
> +
> +maintainers:
> +  - David Barksdale <dbarksdale@uplogix.com>
> +
> +description: |
> +   The Silicon Labs Si7013/20/21 Relative Humidity and Temperature Sensors
> +   are i2c devices which have an identical programming interface for
> +   measuring relative humidity and temperature.
> +
> +properties:
> +  compatible:
> +    const: silabs,si7020
> +
> +  reg:
> +    maxItems: 1
> +
> +  siliabs,skip-reset:

Do not describe implementation (driver) behavior, but the device hardware.

> +    $ref: /schemas/types.yaml#/definitions/flag

"type:boolean" is shorter

> +    description:
> +      Disables resetting of the device during probe
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    si7021-a20@40 {

Generic node name, so "sensor"?

> +        silabs,skip-reset;
> +        compatible = "silabs,si7020";
> +        reg = <0x40>;

Order the properties: 1. compatible, 2. reg, then the rest.

> +    };
> +...


Best regards,
Krzysztof
