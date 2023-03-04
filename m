Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857C76AA94C
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCDLVE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 06:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCDLVD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 06:21:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524EA1040D
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 03:21:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u9so20175375edd.2
        for <linux-iio@vger.kernel.org>; Sat, 04 Mar 2023 03:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677928860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhHobUVMtsu0PhlE7aAW4qybE/Xxfbd3jkBj+Ur23CQ=;
        b=oMr7cxZ0V4XviCNTRxo+KZkz8/5YR+jjcrhupiKIQldCL+8FKp7+hVgA5ki60DsEEA
         27/APGAbldWtnUR2vcCrRVCElLMkxuRIiZDlTklW8Aq0NrcCmEEoCyuU1oqhsqNIKMLN
         LD/WrFOtkU68PJW3uloabFSgeFjsmMarsPL7gBNQA5ZZvuBEkbtnehQ41MAAQhA2OfYc
         uRJ1k3jTgfD+vcLqQjf0xuEqyfty7GDQWO+gpUTUZdot7FF98zvoRjjb5H6dQgrjqndh
         oFmecKNdG2O4kkrj0VP1EcPTeCmXuOzHy3O54cUyI0306MUnPOLdaoQgSEUtxWXVNe7y
         lDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677928860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhHobUVMtsu0PhlE7aAW4qybE/Xxfbd3jkBj+Ur23CQ=;
        b=FOCTl1T/y8bGdAslfWnL2ewT47tgK/uVxUe0nKH85iSI1Y15xEJT4ZdLRencr3NSBS
         dSb7QTzscvwxQRDsMIBxpQ5tKz5OML4tbhAgKtW42R3L+UC6lBZu31HDmycPXUqw8QeL
         B2dWfhAlsRx0ySbOnywxGxSd7EJ9urthshEiJ4gQ9wjvM7ATS5q9p5I55aRsbR4D4yYb
         9w/VyKJXmlNEM3BIpzoAnledWs6mdIlFaf+W33ifg3i8/jmOccTeJbHp1JrbhSMQKQJI
         u2YxrWG/NpQ+Ds4DLPHcan2mPQsbChh5nWv5ck37LAKmhg8Vh0aOSCPQ0GjynNtOCP1N
         xeQA==
X-Gm-Message-State: AO0yUKUCBp6jrZ4RP9zfTLj+dzrZ/v7fkT0wLvWhee/kKFtkbN+5Gb+Q
        w3kIdmgvygfZ4ima+lF7m/q1qw==
X-Google-Smtp-Source: AK7set8+kfpwszLRIY9wnGra+1M4z0jqk6FRk9+pxHVUN94cn1oq40TToK7RI/8wJPpmyNbo7yyc5g==
X-Received: by 2002:a05:6402:b11:b0:4ab:4c2f:adfe with SMTP id bm17-20020a0564020b1100b004ab4c2fadfemr4336974edb.37.1677928859865;
        Sat, 04 Mar 2023 03:20:59 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:b758:6326:1292:e2aa? ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id k21-20020a05640212d500b004aee4e2a56esm2300396edx.0.2023.03.04.03.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 03:20:59 -0800 (PST)
Message-ID: <73aa71ad-4cde-09d6-1af8-774701e330cd@linaro.org>
Date:   Sat, 4 Mar 2023 12:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF
 converter bindings
Content-Language: en-US
To:     Andrew Hepp <andrew.hepp@ahepp.dev>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20230304004109.78659-1-andrew.hepp@ahepp.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304004109.78659-1-andrew.hepp@ahepp.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/03/2023 01:41, Andrew Hepp wrote:
> Add support for the MCP9600 thermocouple EMF converter.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>

Thank you for your patch. There is something to discuss/improve.

> +description: |

Drop '|'

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

The interrupts should be usually strictly ordered and you allow any
combinations. Why?

Why are they optional?


> +        - open
> +        - short
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
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>

No need for this header.

> +    #include <dt-bindings/iio/temperature/thermocouple.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mcp9600@60 {

Node names should be generic, so temp-sensor, thermocouple or something
else matching the type.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "microchip,mcp9600";
> +            reg = <0x60>;

Best regards,
Krzysztof

