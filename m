Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A186EB084
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDURZq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 13:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjDURZY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 13:25:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF8AD2D
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 10:25:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-956ff2399c9so247982966b.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682097921; x=1684689921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuR1QTA5de2XpIRxwF6wkpWoxygn8gWhtK3M4m5P0yo=;
        b=Vn1pb6ehuFwl3wRaUgASiDignPRsqNKSAol5FaiF0SheHyxVCprP/+QoCMfMUp+MjU
         ssO0wpHBSlzJMTEvG1JgnRKVkck5isRzEzVXwNIFtYxJr37MNBTzLQtxQy9tbychWwDH
         PKWwZLTyTKb75qUQrVDxBZ5Q9u71P4Kz1+wLi/RqosCl2NyGLrS48BSaIZzz8Sdc/hEW
         +mK/bGu7nqBdyN8J9w6DrfMVl42HLCIYbjjx7Ajhvi1qsqELNASaAaZKoA+Fau+ejKxv
         bO9buZEOgqYPeu9nzaMX7qE4W3RQVyo5NuIahkbzqN7moGAzyEnvoIyyd9VDfBrzp+eO
         Jg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097921; x=1684689921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuR1QTA5de2XpIRxwF6wkpWoxygn8gWhtK3M4m5P0yo=;
        b=EZBJvFNm/GVqgw5d7LO9n3/i4kj5Cf3pzWwucE0s+Wt55WB9fqVCMw2m6GBNvxiEaK
         4tt+rN6ypPzM4HGXQ7LkeuSJSR4HaYUjPqFmW3ugIZQqSlxIuQ4BeWMxUOpJsdc0Im/7
         ZlfAvZ+cD2nEVToO6xb6iVIapuNqxuRqajdsTtsmqARYfdna93qT89ctIcQSzKk1TUzo
         fZ9LcWsBHTMMee03XEpTEXP9dtB5ORZzYKvIQI7mL1eDIJpR5xR1FfwWQrPYwaMog9Tn
         Vw52l6N8Xv7XaVdWHjcvFgCxcPFOxUsmC/z1J3RjR/HNZBzR570tdnd6Xe+L9+PAn+eh
         dNeQ==
X-Gm-Message-State: AAQBX9cUef1sox2HnBXkzAA44e3SjV+cadyPSOyS3DQtn9MSmdAaQZKf
        KRPZ2ug98PP78s8N/kdzX8k5Mg==
X-Google-Smtp-Source: AKy350akQcwHtVGFCaVm9vH8T6/N5IsWemFtVpqLTZasE7IGcZlk4RlNsMzNd2z0PCpZeEIJU9aQxQ==
X-Received: by 2002:a17:906:ecb7:b0:8b1:3467:d71b with SMTP id qh23-20020a170906ecb700b008b13467d71bmr3000598ejb.48.1682097921527;
        Fri, 21 Apr 2023 10:25:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:687d:8c5:41cb:9883? ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id bj1-20020a170906b04100b0094f7acbafe0sm1243769ejb.177.2023.04.21.10.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:25:20 -0700 (PDT)
Message-ID: <fde5c0af-8691-6066-3238-01b500000e11@linaro.org>
Date:   Fri, 21 Apr 2023 19:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230421085245.302169-1-herve.codina@bootlin.com>
 <20230421085245.302169-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421085245.302169-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21/04/2023 10:52, Herve Codina wrote:
> The Renesas X9250 is a quad digitally controlled potentiometers.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../iio/potentiometer/renesas,x9250.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> new file mode 100644
> index 000000000000..dfa36b23eb0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/potentiometer/renesas,x9250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas X9250 quad potentiometers
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The Renesas X9250 integrates four digitally controlled potentiometers.
> +  On each potentiometer, the X9250T has a 100 kOhms total resistance and the
> +  X9250U has a 50 kOhms total resistance.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +  - $ref: /schemas/iio/iio.yaml

Apologies, I missed it last time - you do not need iio.yaml. It's coming
from core schema and is always selected. You won't find its usage
anywhere in the kernel (git grep iio.yaml)

With iio.yaml dropped:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

