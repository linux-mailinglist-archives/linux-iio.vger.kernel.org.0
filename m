Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B10528991
	for <lists+linux-iio@lfdr.de>; Mon, 16 May 2022 18:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiEPQHx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 May 2022 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245735AbiEPQHs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 May 2022 12:07:48 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FDA37A90;
        Mon, 16 May 2022 09:07:47 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id w130so19225268oig.0;
        Mon, 16 May 2022 09:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2EISucrHwn09zYBJZ3CQdN9SDlOOKF7wKfYmfL/1ww=;
        b=bX7/gwZg13Mv30rILFQLvgI3Bu9t64P8sWaBdy8Y0l4oORQS+Q9r+ByaaoaOwsA2dr
         hOgEzLwtQaPbNgZski4sfzMRPCk7EmDB2bgfL8RMk7KZt01aYCX9EqirBpGxw+Abhs/U
         VMwx1X3U1DnFibel0EO0gR4npmOriITFJEoLc1nidGd33vwOnqDSWIEBoDKrMCbe9hvH
         9E4bTV2WYDauMugHv3OC2VQhj1o//h1IS4CokCT0Yq7BEdLOCBJ2f/PdKjThMV9aNdm0
         sQVKHqHclcP3O9gxOhhgU90Y8C1v/0jPBuUR4JVVLOeuTZw7/moAEWeaH6y46ftUCWHa
         E9zg==
X-Gm-Message-State: AOAM530IACmZ3k9dYoUw0pqRN68mm68SVsgK7UHMnpp1PpqgwIL8wGAb
        k/SjpOYg6vEg5/WPhYRbmA==
X-Google-Smtp-Source: ABdhPJwyWfBL6qdXzCaCB0rIQwj553Wvs3k7fKbeOqxpF/2D/lclfPCQX12M3tnnUkV0W0Tl9f9Tpg==
X-Received: by 2002:a05:6808:2086:b0:328:a434:2915 with SMTP id s6-20020a056808208600b00328a4342915mr13464491oiw.279.1652717266262;
        Mon, 16 May 2022 09:07:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c16-20020a05687093d000b000e9b8376a7bsm5332793oal.23.2022.05.16.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:07:45 -0700 (PDT)
Received: (nullmailer pid 2740392 invoked by uid 1000);
        Mon, 16 May 2022 16:07:44 -0000
Date:   Mon, 16 May 2022 11:07:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Message-ID: <20220516160744.GA2740328-robh@kernel.org>
References: <20220515060337.16513-1-biju.das.jz@bp.renesas.com>
 <20220515060337.16513-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515060337.16513-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 May 2022 07:03:35 +0100, Biju Das wrote:
> Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> on the RZ/G2L.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v4->v5:
>  * Removed redundant "type:object"
>  * Added Rb tag from Krzysztof Kozlowski
> v3->v4:
>  * Removed unnecessary SoC specific reg description as it is
>    equivalent to the logic used in reg.
>  * Removed Items from reg.
> v2->v3:
>  * Added generic description for reg.
>  * Improved schema validation by restricting both channel and reg to [0-1].
> v1->v2:
>  * Started using generic compatible for RZ/G2UL and added SoC specific validation
>    for channels.
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 28 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
