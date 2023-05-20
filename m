Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5420070A900
	for <lists+linux-iio@lfdr.de>; Sat, 20 May 2023 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjETQMJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 May 2023 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETQMI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2023 12:12:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065AC4;
        Sat, 20 May 2023 09:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4697614CF;
        Sat, 20 May 2023 16:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE10C433D2;
        Sat, 20 May 2023 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684599126;
        bh=kdacPFn14rPvw7YtMOZjZ5VztGWuqedD+DJfzX98O90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dSDZvsMBY7KWvOR1Frf2wX5VfTIQXOigJN2U9v4LWQHV5J7NIYnuJ4WKJBcOnnqK9
         2VDStILUhYUCGXlrMlB7SwFE10yfzor1qM+3tHLMC/3I2e2BMkl5UcBGRNCJEopctX
         myL1N15hCMLkPh8I4PRLjZKRLJ9BIgQWniD6yXiYahrLxJFSzY0diPnRIF+vur+g5S
         /V7k6/sSdu1fYViqXfcNY1lihTNwKvIMC2ZWxr4PT93ibGfrAZBVixZjQ/YWua90Ip
         TT21lYXtEtit+y1qADlIv1uxtJtveb35C9nbGKatbupEbBXzgvhGO+tAW2IKATbtcO
         HmB5ASn48+7Jw==
Date:   Sat, 20 May 2023 17:28:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: temperature: melexis,mlx90614:
 Document MLX90615 support
Message-ID: <20230520172815.7475418b@jic23-huawei>
In-Reply-To: <20230510102251.10118-1-marex@denx.de>
References: <20230510102251.10118-1-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 May 2023 12:22:46 +0200
Marek Vasut <marex@denx.de> wrote:

> Document support for MLX90615 Infra Red Thermometer, which seems to
> be the predecesor of MLX90614 . There are significant differences in
> the register layout compared to MLX90614, but the functionality of
> the device is virtually identical.
> 
> Acked-by: Crt Mori <cmo@melexis.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>
Series applied to the togreg branch of iio.git and pushed out initially
as testing for 0-day to give it a whirl.

Thanks

Jonathan

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
> V3: Add AB from Crt
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

