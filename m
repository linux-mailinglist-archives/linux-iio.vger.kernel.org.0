Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3291364C66B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 10:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiLNJyj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 04:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiLNJyg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 04:54:36 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6071C4
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 01:54:35 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f16so6107577ljc.8
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8EzNEAgwzYomqvjIPtt320Z4mc8BVXKL5MkEZzJO8U=;
        b=agXh3Do5P4t1pmIZFiC7C7W3cbw91CKhYp94OmXPlGi7nie145bY0XwZwQ/v3TrkVW
         g699syysxVtbQx/K7KhLSjveR5xc+0Hxtx8prvQzSLUfs1E2MLsa1yjfieabdDToA25v
         z5jawduElToaBsb6bRRillZJAlZhO+1YB6E2sem2/JFAIt/fifIJ4v6iWQnMNljn3lYg
         +UNRwjsQ9Z3mrMzWnDF9wzlBDLj0jK7v3yaH5OiAVqYbet6t9Mud3U+x1dH3rNGvg8bR
         V6/NSdkzIdjs/WZBOy0M9QHH41M0MkKxs0gF77twEyMTDSJMeRdNG1NwQQE3neXU9Hhw
         rg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8EzNEAgwzYomqvjIPtt320Z4mc8BVXKL5MkEZzJO8U=;
        b=gnmIbbOCiJRRBJfIr/02RyYkZRP04ANQx8FzE85sR0a8J6puzDHFrXLjtgN2mB8jkn
         Pt4urQ1bPwOHeXCylFdjrcdsLjJWvXrQwLpO4KvC2PXTsLTh1Jsi7cy/fcKJNdJQY8LK
         MV99N+BUfloWsQnrWDipuB0yc0IaEXX5DbHvoYihpKpFY92ls6mD/5x2EEabiy3xqpcS
         2tzeb+tHJog2E6Z0hmCc8O3GuoYKincN0tdNc9Wo4PRBbgfPbtQdnGRmnrzUvgen1eau
         takBQA0OMl0Krt39nocA8KRVDQR++A4oafuHyelMj7nuRwRowNT3CCaH06mAnSPNr0vt
         G56Q==
X-Gm-Message-State: ANoB5pkGq4MWerwrS0Pdu2LAc+KkfwgmRBPFCkzdi0vt9a/Xl/Rxe/c2
        XLM6ngKoQ222NQz5Gfs/Kwqr+w==
X-Google-Smtp-Source: AA0mqf5MH17rQRCr7E+If9oOsnaUnGQyLICSw3RfYoz4nhcFY16UxqFkZdfeZSZZulL6GPI8ZZmsPQ==
X-Received: by 2002:a2e:6e17:0:b0:279:7e54:8386 with SMTP id j23-20020a2e6e17000000b002797e548386mr6252259ljc.34.1671011674147;
        Wed, 14 Dec 2022 01:54:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b15-20020a056512070f00b004998d9ccb62sm744242lfs.99.2022.12.14.01.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:54:33 -0800 (PST)
Message-ID: <76c5cdd9-7b90-7ce5-02c4-a2a6e5bb3a30@linaro.org>
Date:   Wed, 14 Dec 2022 10:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: accel: fxls8962af: add new
 compatible string
Content-Language: en-US
To:     Han Xu <han.xu@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
References: <20221213171536.1880089-1-han.xu@nxp.com>
 <20221213171536.1880089-5-han.xu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213171536.1880089-5-han.xu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13/12/2022 18:15, Han Xu wrote:
> Add new compatible string for the NXP FXLS8967AF accelerometer sensor.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> 
> ---
> changes in v3
> - Start commit message in capital
> - Describe all these chips are compatible
> ---
>  .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index 65ce8ea14b52..8f07ade21abb 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -14,12 +14,16 @@ description: |
>    SPI and I2C interface.
>      https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
>      https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
>  
>  properties:
>    compatible:
> +    description:
> +      These chips are compatible with each other, just have different IDs.

As pointed in other mail, the chips are not compatible, so drop the comment.

Best regards,
Krzysztof

