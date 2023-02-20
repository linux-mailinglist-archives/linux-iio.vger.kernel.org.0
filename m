Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D71869C63E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Feb 2023 09:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjBTICt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Feb 2023 03:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBTICs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2023 03:02:48 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D115275
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 00:02:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id eq27so5829489edb.5
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 00:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pW3SF2TfTTc/IbsBO77I3ErLxlmWr32PfAVbSQweI+I=;
        b=lSGbS0wInFSN2/r2egsNZ+QR770N08v+vcd085+mgOEcZbGV4/XZwLI83f293OEQeP
         uDYpMpA1XnNngRC32S2KTxobmdzkAKqal0zQqTv6XCC5zgUlNkiceRfuqD3mGlfsEi2K
         xld1pxZrX3Z1Su+o7uKWGxxNuL3Q1UsBqmtS/9SjFVzVi3UlTiujk25jTShgfrQppTXP
         DU3ocV/5pzFC5Vkt3cspZZrs+1+TrK/hplObeeSYIcnarjexIlHbq4Hb5xKRXUSvD40o
         AL4DU5qykPbpOEltNfNZGEkFH5aoZs9lmvOjuGew8NQ6m2HxuenasQnr07TKbeE+xMAq
         +8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pW3SF2TfTTc/IbsBO77I3ErLxlmWr32PfAVbSQweI+I=;
        b=S91gQXwTJr87KVu3ouTFFhKKVP6avMzM0IetHY5e++MlS4ZBGtbaKt5nu+kS4vzXkF
         9jwyuH19PlauKwI/Z58kjOGGlZK/NaxWCfpqscutJx2/tAc3LRec28r2uY7Fa5ODAlSM
         Wd3XR1riYvfg/vKZs3CY5CcAMfr5AiYlSE2UzSlYtwkeLGbM4nWLnFi30o4Faf/Xb9eG
         b2+nIphdzMB5jKt+CiuK24t8glR7XoQNYvRnZ4NCewnlVAWDIbaSpEnFpPOzDkL1nAHx
         9dusV4rr8wiuvwXgjze0XH7At7YXqKyw7rqsSwyYiqkP8mIjVzgzESE1tVQ+oo2N819C
         iLBA==
X-Gm-Message-State: AO0yUKUZfyRltHkDbWcmDIVY4MRwq/QsF/rHDfLU4Afl9xvfJT+BeRvl
        WAi/40e+w2KDmYmO9L2GXVGqIA==
X-Google-Smtp-Source: AK7set8GOobu8rWcq+OsrseIMRuJ83TxxGOrl9DfLH9W5Mrddkj7Qu19rjdgNoMgK2BzaeEnsVeQag==
X-Received: by 2002:a17:906:6956:b0:88c:a43d:81bc with SMTP id c22-20020a170906695600b0088ca43d81bcmr6267775ejs.58.1676880165256;
        Mon, 20 Feb 2023 00:02:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j24-20020a1709062a1800b0087223b8d6efsm5502545eje.16.2023.02.20.00.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:02:44 -0800 (PST)
Message-ID: <56826d1d-50c9-4bce-3197-6ecc3efbe51e@linaro.org>
Date:   Mon, 20 Feb 2023 09:02:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: ti,tmp117: add binding for the
 TMP116
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, puranjay12@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
References: <20230217093711.1891564-1-m.felsch@pengutronix.de>
 <20230217093711.1891564-3-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217093711.1891564-3-m.felsch@pengutronix.de>
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

On 17/02/2023 10:37, Marco Felsch wrote:
> The TMP116 is the predecessor of the TMP117.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v3:
> - don't use tmp117 as fallback, therefore I didn't add Krzysztof
>   rb.
> v2:
> - drop items from single enum
> 
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index 8d1ec4d39b28c..a2f647fe0760c 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -7,8 +7,9 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
>  
>  description: |
> -    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
> -    I2C interface.
> +    TI TMP116/117 - Digital temperature sensor with integrated NV memory that
> +    supports I2C interface.
> +      https://www.ti.com/lit/gpn/tmp116
>        https://www.ti.com/lit/gpn/tmp117
>  
>  maintainers:
> @@ -18,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - ti,tmp117
> +      - ti,tmp116

Don't add entries to the end, but keep some order. Less conflicts.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

