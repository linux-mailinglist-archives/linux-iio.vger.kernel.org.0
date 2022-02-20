Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B94BCE0B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 11:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiBTKyV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 05:54:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiBTKyU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 05:54:20 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BF13CA7C
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 02:53:59 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 68BBF40049
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645354438;
        bh=rbI2U7x1cHPvp7Ypc0YrVspNGO328GiT7owoM0mdXBQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=SPV6mv5wTKBUi9l9STlZwUC8okylmyBUGEttLZQHqQN9WQTXdzg0rsJKjXKpiZ1n8
         /M9ENuKzzX5witxlmnxKoD0NEYTXAqSkJzNRL46VpizI6U6ORm/aTAzLMde/2Ok38q
         OgSQNITJzvGyyK3J/cdbR82OTwqlWWT8wGynotY2bqS8qNYMWTH32YwLjNouSuNBY7
         073b5KN1tNU+Sr+ojfLGr/ifdmAUvzGREXtuvAYtjBmle2h5of8S36NtqZU2s6u18Z
         02285JFkXOEP5AWk+LoRrhkVTtH7aa2fDsTdQveiRhIYEZIKLcEoLjNkvfHPScWVUO
         MgDuWuj5Htqlg==
Received: by mail-ed1-f72.google.com with SMTP id l3-20020a50cbc3000000b0041083c11173so8491322edi.4
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 02:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbI2U7x1cHPvp7Ypc0YrVspNGO328GiT7owoM0mdXBQ=;
        b=uI5OxY94iX285DMS5LWBfRlK/mVk4jvJbDxC6LywCxOLrL+97pC5vq8f8N28mN1Qcg
         YgPi4SDHcJcaOLO18umD1IxKpgGFe6pVeBy+z+Rh3/Vn9khgZBSqn8a46bTF7X1+KQFR
         vMmqlGjrwZIhnVDLbJDcaCIwtQT1apy6reSgawq6Q6YUQ6HUQBKa5CMb2+VA8pMUSk1B
         anTyIS62OwelbJjRMLnznzAJ19qZhez+fnen/vIGJPwaSJnpDI9+AMMoQ/ERvXWr86bq
         Pkt6VT3nP143l9621ZBsaNdkMrteS2xQ0Zosx+HvS4ucGVx63wL3/Qko7alfzvFkwgpu
         oH/Q==
X-Gm-Message-State: AOAM533drCiyOVuSH4OlCB8B7YXJ5qFkFZB9CRaReurwYZu8hUAMj+fj
        j+rwoS3MCXD3+R3pPZ4NxAVHTmBx9F5Sm+lCRlbuG8lfLfOMg5zhN4nl6OiYbhM/GlbIk1jpKyx
        qZB34SLJzVSsYjWrpXarGfMwhyktqS56IWj5KrA==
X-Received: by 2002:a05:6402:520a:b0:412:8361:d11e with SMTP id s10-20020a056402520a00b004128361d11emr16281504edd.190.1645354436986;
        Sun, 20 Feb 2022 02:53:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8C7k+C/26qS39pBy5PpopktLCI0D5x+PjoZJAKXQk0+LOpRbf6bMM3TBru7V9NBB4VUGsuw==
X-Received: by 2002:a05:6402:520a:b0:412:8361:d11e with SMTP id s10-20020a056402520a00b004128361d11emr16281489edd.190.1645354436801;
        Sun, 20 Feb 2022 02:53:56 -0800 (PST)
Received: from [192.168.0.117] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id jt11sm1096778ejc.167.2022.02.20.02.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 02:53:56 -0800 (PST)
Message-ID: <69cc2a64-c273-f2f6-b25b-73fc2248bb18@canonical.com>
Date:   Sun, 20 Feb 2022 11:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings:iio:amplifiers: add ada4250 doc
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220214094115.48548-1-antoniu.miclaus@analog.com>
 <20220214094115.48548-2-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214094115.48548-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/02/2022 10:41, Antoniu Miclaus wrote:
> Add device tree bindings for the ADA4250 driver.

Please put the bindings patch as first in the series.

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/amplifiers/adi,ada4250.yaml  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> new file mode 100644
> index 000000000000..22283ab48903
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,ada4250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADA4250 Programmable Gain Instrumentation Amplifier
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Precision Low Power, 110kHz, 26uA, Programmable Gain Instrumentation Amplifier.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ada4250
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply: true

Needs a description, not a true.

As Jonathan said, you should allow spi-max-frequency (so
spi-max-frequency: true).

No io-channel-cells?

> +
> +  adi,refbuf-enable:
> +    description:
> +      Enable internal buffer to drive the reference pin.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      ada4250@0{

Generic node name, so "amplifier".

> +        compatible = "adi,ada4250";
> +        reg = <0>;
> +        avdd-supply = <&avdd>;
> +      };
> +    };
> +...


Best regards,
Krzysztof
