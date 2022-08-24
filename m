Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB059FADF
	for <lists+linux-iio@lfdr.de>; Wed, 24 Aug 2022 15:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiHXNHv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Aug 2022 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiHXNHu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2022 09:07:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE0F97534
        for <linux-iio@vger.kernel.org>; Wed, 24 Aug 2022 06:07:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s1so21114797lfp.6
        for <linux-iio@vger.kernel.org>; Wed, 24 Aug 2022 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=07vPvByHp737Z4ko55zqWLWNBnP96zmWmjtNwCBec98=;
        b=sTVjoh9c/E4kr0cniahRXMsvKK0b2tP3WbbNAyyeLZ0BjxqXHD15wAOoepB3jeaRgL
         pICcDosxLt7ph0fVQJ17htSiwYxTDueBhpmX1bJNIgQuxNz/VOchbrsBOW2Hq2kWeZ50
         /y5MCVTdM5aV0bKlL9nAlNIbVHC45X8SfuzTLullIpcZ6zzFosDqWO0/o++qvkiznOcI
         NxtLkodrxpx4Z2y7gFtrmj8O/PPr9tlV9IJt0lcpHxrfMyw59gSsvcKzsXVPpshzz5xD
         j2mMx81U8zbjJJjkSDEVMU0xZAtW7iq7zjYmcbPJeyfVcJffPCssM9BX3h9LepL7L5Al
         4fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=07vPvByHp737Z4ko55zqWLWNBnP96zmWmjtNwCBec98=;
        b=xSWvzdj6DoCEpK1pyT+eHX/v11DVFvEyIFkXATvl/eMETz0kKVdiu/5+/C115sQi2z
         qX/2lc0pr0CyDp/fLL/mvykKkH+UBFaRd/gUukBwVkewNtCgeceMYoxMNuxR7dtwDNg8
         kNnL5PKuS69FCH7gdOYebyiyDfCrYhFXmtdoF+4+4gLuJGHdLdFoUrqnNRCQ94z8dQyl
         rQDgg/pl1tOLlMdMNRSAlKg7k2UTa+e5MQJ+liniyQlsMkQUouNdagqHb3P1C9CkwF45
         dbVoLHHZ7J806IUUHWxtDtRXBbC3QAYkNCEiS+H+/6rlPsHIw+XwmzGJF4sXi0e7T6We
         MEVg==
X-Gm-Message-State: ACgBeo2hyvxBT1qsIftdVCRdNDnw3b14Ivo0kzK4vWk1VF9sfcUcPdJT
        eMD/iVCuPqD5/oH6dvf8LEybf9bGINR1gSDNNiU=
X-Google-Smtp-Source: AA6agR4MCTFUzzLJVCo+j8gtwAABrGcjHkwermyL3XDTUedLgroX4T6ImdZs9pPR9Ms2iQ45ySG8XQ==
X-Received: by 2002:a05:6512:1191:b0:493:57c:84e3 with SMTP id g17-20020a056512119100b00493057c84e3mr1194980lfr.177.1661346463003;
        Wed, 24 Aug 2022 06:07:43 -0700 (PDT)
Received: from [10.243.4.185] ([194.204.13.210])
        by smtp.gmail.com with ESMTPSA id d4-20020a056512368400b00492daab838bsm2069672lfs.46.2022.08.24.06.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:07:42 -0700 (PDT)
Message-ID: <33eb031c-f1b5-b80d-52b0-48bcab02d697@linaro.org>
Date:   Wed, 24 Aug 2022 16:07:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] bindings: iio: adc: Add max11205 documentation file
Content-Language: en-US
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824125203.685287-1-ramona.bolboaca@analog.com>
 <20220824125203.685287-2-ramona.bolboaca@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824125203.685287-2-ramona.bolboaca@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/08/2022 15:52, Ramona Bolboaca wrote:
> Add bindings documentation file and MAINTAINERS entry for MAX11205.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
>  .../bindings/iio/adc/maxim,max11205.yaml      | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> new file mode 100644
> index 000000000000..bddd18a44969
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max11205.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX11205 ADC
> +
> +maintainers:
> +  - Ramona Bolboaca <ramona.bolboaca@analog.com>
> +
> +description: |
> +  The MAX11205 is an ultra-low-power (< 300FA max
> +  active current), high-resolution, serial-output ADC.
> +
> +  https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max11205a
> +      - maxim,max11205b
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  spi-cpha: true

Both properties are good, but still you should reference
/schemas/spi/spi-peripheral-props.yaml in allOf and use
unevaluatedProperties:false. See other bindings for SPI devices.

> +
> +  vref-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpha
> +  - interrupts
> +  - vref-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        max11205@0 {

adc
Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +                      compatible = "maxim,max11205a";

Messed up indentation. Use 4 spaces.

> +                      reg = <0>;
> +                      spi-max-frequency = <5000000>;
> +                      spi-cpha;

Best regards,
Krzysztof
