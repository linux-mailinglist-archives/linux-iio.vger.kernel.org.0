Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AD26FA3A4
	for <lists+linux-iio@lfdr.de>; Mon,  8 May 2023 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjEHJtJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 May 2023 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjEHJtE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2023 05:49:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE471FABA
        for <linux-iio@vger.kernel.org>; Mon,  8 May 2023 02:49:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so4908818e87.2
        for <linux-iio@vger.kernel.org>; Mon, 08 May 2023 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1683539340; x=1686131340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mIodw2IOkts5z/EAeBd4VX53RqXd6u6N3X4h8AJjDxs=;
        b=RHT3dh9m5jC2Ndy/xFTA0Fvj1yLyEvid0qI4cKfNORJmqPnuycnSrJe0xafYNdJCY7
         FepPw5uK79NbIMa9YPazC7wYVYJnavFpYS/i8swwbfhtYlKKiz6f2eAMtUZZksQSCLMv
         0Bv/BwwUm0yGn/9v9kBX0kGLaEMfxCqkG6kYcss7aaLZBZeI+nvQxrFXVV3YxGzl5YyE
         1g3KPmme0ne01mI43G7V4f8BCMCH27P+olkKBSZ2Ni9ra4i8aDexzcHu8SbdrFxwRNfT
         cL3pIAvRj+rGSKJBOwQEuIp8/id10HDR/agksTsHWBq1velwkIOAd6Ezn+kZs6i4+f/w
         o+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683539340; x=1686131340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIodw2IOkts5z/EAeBd4VX53RqXd6u6N3X4h8AJjDxs=;
        b=ebZguzb0FGtQPsEdCn/vAnS6sT9YEXpBtk0RItDpOGO0adKGm3oo7HMK3x81K92qlE
         cU+tAm1gdkvEef7SrsaQLvAhF2m0fuahpMwnr4JFz2sv4tXwJur/M8RUgGhBJqY5leEO
         Aa5ORbH1upQgXOmBlG38eg7Q6X+wYypbDrUvRxRq6CSS/Q/0aab44EkdqAp7pCxv2Ky+
         AEqvuRiuA1jorH5QyNHeAuFdve3pvI7uIvNwO6EQCwi08c6kInJmIU49yudIwM35iucn
         B86SlWmcp2qCb9LYgYT7Xt0p3+MIKn1vh95nuJfWlwByrYQ3NQwOr4a6csK7vmDj8es0
         sX1Q==
X-Gm-Message-State: AC+VfDwvDXDUlCKCRNLWm0Fv/ts6bKsna+6oAhAU24nBTkuIOLJRt51Q
        wfHsaVvxXAKP2aL3j1FstXb2B0qGboMWwpvH+H68kw==
X-Google-Smtp-Source: ACHHUZ79ULkbGM5EVpXxj4WW8A5JowX53CGbWgPEbBR/uKVy+5H/BH7ZBO1/oyHo83zousXS8sKvbUjrrS7pZSNfO4c=
X-Received: by 2002:a05:6512:3c8:b0:4f0:276:295b with SMTP id
 w8-20020a05651203c800b004f00276295bmr2345063lfp.46.1683539340548; Mon, 08 May
 2023 02:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230507184649.39290-1-marex@denx.de>
In-Reply-To: <20230507184649.39290-1-marex@denx.de>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 8 May 2023 11:48:24 +0200
Message-ID: <CAKv63us81+fJmOp+ZunihY=0c6_-bHAd0c6ahGp+QdAf9XP=pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: temperature: melexis,mlx90614:
 Document MLX90615 support
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Crt Mori <cmo@melexis.com>

(also tested that existing dts's work without any modification).

On Sun, 7 May 2023 at 20:47, Marek Vasut <marex@denx.de> wrote:
>
> Document support for MLX90615 Infra Red Thermometer, which seems to
> be the predecesor of MLX90614 . There are significant differences in
> the register layout compared to MLX90614, but the functionality of
> the device is virtually identical.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Crt Mori <cmo@melexis.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
> V2: - Add spaces to subject tags
>     - Add AB from Krzysztof
> ---
>  .../bindings/iio/temperature/melexis,mlx90614.yaml          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> index d6965a0c1cf30..654d31f65d360 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: Melexis MLX90614 contactless IR temperature sensor
> +title: Melexis MLX90614/MLX90615 contactless IR temperature sensor
>
>  maintainers:
>    - Peter Meerwald <pmeerw@pmeerw.net>
> @@ -15,7 +15,9 @@ description: |
>
>  properties:
>    compatible:
> -    const: melexis,mlx90614
> +    enum:
> +      - melexis,mlx90614
> +      - melexis,mlx90615
>
>    reg:
>      maxItems: 1
> --
> 2.39.2
>
