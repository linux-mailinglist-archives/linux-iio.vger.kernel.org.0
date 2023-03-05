Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C36AAEEC
	for <lists+linux-iio@lfdr.de>; Sun,  5 Mar 2023 10:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCEJ7A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Mar 2023 04:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCEJ67 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2023 04:58:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D7EB55
        for <linux-iio@vger.kernel.org>; Sun,  5 Mar 2023 01:58:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u9so27085441edd.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2023 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678010336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwptTmMxU2eTk/ioiOf7vOzl5V1fb4l0SP1uJj4qZW8=;
        b=LyMSh7Etjh0QxzqrKTulhxy9xevja9jADQcJTwN1yDhMjXDYZUEtzT96CVL66a5z0r
         zJwTA7NqAO/fBHsgBB1Q6VliKewggXXQQ66wWNRUOd3mUZwSeZ+BGlVqjSUrsZvPX+UE
         6ZcrGn5+5vYvjjXv1IHGGZ5TB34dyJoh4uM/+VhvFt+iAItd//xIQ9Uy+XudMY7dKRso
         CW4wX8rUYVlrLOQucrIs4PajlPUu0gCNOnMJJ6t96MIexBOo8aJ36ajE/8zas6VPH+R8
         AhwC/qFJ/2QD0ZlGBNI72KpVoezm3+/M5yOeGhP1sFOi/+ej0ZkG9iktSZpRmT63MUdN
         lzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678010336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwptTmMxU2eTk/ioiOf7vOzl5V1fb4l0SP1uJj4qZW8=;
        b=619bIycYt6/7PD3a4+qeSsnZY3PjidUaVSjnrc6hMuprBHEy2TuQ/O2NjXtYjODel8
         bywdPCMVvb8TNar5XRmn5Iwj/z8Da+mrxoABvj070J1YP0wUyLjBZo6xCcrsnR+z6WAA
         9uRypuDF70x4FfPXZKQEmGErDOctPWrlKsexnCAjNY9rg+l5uSToRHvGHFxs3567dgiA
         ffhVZVkz8j2rwxMVZJPP7kCWvg+7CkgeER7W8MhUO9per2p6JEp4ep18F+m2DWqpXso1
         3/rU8f0BDgIifBBfyrURCU687LDhJRb/TeDQbrsu0TnR1fa9J+20ZfwKzLqXvHpp5lQT
         kcrQ==
X-Gm-Message-State: AO0yUKXRc0cnXUzztPXsEDlv2P3Nq9CUjKnlhe2j9P7TXsR0Af+R+IF1
        Zg5+R6LMCQsP+f5PM6VP0NQW1w==
X-Google-Smtp-Source: AK7set9yj87Pu/jT2jMmdqoNG9KvihWLGHUSzrMu6dm0wxOho0Ulq3P1LD5pa6uV1Kr4HMBKnS3CXw==
X-Received: by 2002:a17:906:4c84:b0:8b1:e78f:598b with SMTP id q4-20020a1709064c8400b008b1e78f598bmr7528569eju.50.1678010336274;
        Sun, 05 Mar 2023 01:58:56 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id qt16-20020a170906ecf000b008ea5f4fab5fsm3068275ejb.145.2023.03.05.01.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 01:58:55 -0800 (PST)
Message-ID: <7ce02f0a-afac-7f7a-0f56-81f1ffaeeaaa@linaro.org>
Date:   Sun, 5 Mar 2023 10:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF
 converter bindings
Content-Language: en-US
To:     Andrew Hepp <andrew.hepp@ahepp.dev>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20230304185954.1492-1-andrew.hepp@ahepp.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304185954.1492-1-andrew.hepp@ahepp.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/03/2023 19:59, Andrew Hepp wrote:
> Add support for the MCP9600 thermocouple EMF converter.
> 

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
> ---
> Changes for v4:
> - use descriptive names for open/short circuit interrupts
> - remove vdd regulator description
> - remove unused import
> - use generic sensor name in example
> - don't use literal style for doc description
> Changes for v3:
> - Added dt-bindings
> ---
>  .../iio/temperature/microchip,mcp9600.yaml    | 70 ++++++++++++++++++
>  microchip,mcp9600.yaml                        | 72 +++++++++++++++++++

Your patch is corrupted/second file does not make sense.

>  2 files changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>  create mode 100644 microchip,mcp9600.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> new file mode 100644
> index 000000000000..5916d331e759
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP9600 thermocouple EMF converter
> +
> +maintainers:
> +  - Andrew Hepp <andrew.hepp@ahepp.dev>
> +
> +description:
> +  https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> +
> +properties:
> +  compatible:
> +    const: microchip,mcp9600
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 6
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      enum:
> +        - open-circuit
> +        - short-circuit
> +        - alert1
> +        - alert2
> +        - alert3
> +        - alert4
> +
> +  thermocouple-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
> +      Use defines in dt-bindings/iio/temperature/thermocouple.h.
> +      Supported types are B, E, J, K, N, R, S, T.
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

I missed this one - this should be instead additionalProperties: false



Best regards,
Krzysztof

