Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C276551AF
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 15:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiLWOzF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 09:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiLWOy6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 09:54:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529EC379E8;
        Fri, 23 Dec 2022 06:54:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DDBEB82047;
        Fri, 23 Dec 2022 14:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826DC433D2;
        Fri, 23 Dec 2022 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671807294;
        bh=k9WrQ8H0AQEiNau36Ze39eTejBuhe2nI+o4E+SLxItU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NyAZsAFlo0a4S+q5zv3IcTOBYXH8Q/xOQ0E0iVBak9Ge9f7RBxy3vHFpYJ5gFI9r8
         RAdwflsyC28NVqC7HbVdTQUtk512YG58E3vnNweKqAFYdLwhGRBTkydmFYeX55su4V
         Zpdutfz0yQXqqlYPi1B8CnwHTscB0u9OXBB2tZY98dB1sHcvwZm8OlWpKJgLCAu7Ql
         ocWBsrL39HChjTprX8efRRefuXJgJTEeKt2R4gAGS5zcT0cx4m9NlvVzOTGBaVkAOp
         M+pb+J7uAzlqx1Uohyh2xrs/FybXfgpepOUC8zIIihDsrUB8C2PNi8ggCxXEyM/EFw
         w5j5A1lqFkqrA==
Date:   Fri, 23 Dec 2022 15:08:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: ti,tmp117: add binding for the
 TMP116
Message-ID: <20221223150803.37e2939d@jic23-huawei>
In-Reply-To: <20221221092801.1977499-3-m.felsch@pengutronix.de>
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
        <20221221092801.1977499-3-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Dec 2022 10:27:59 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> The TMP116 is the predecessor of the TMP117.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
I'm not sure this is introducing a valid fallback. The driver changes
imply some things the tmp117 driver supports, that this device
does not. A fallback compatible would mean that a new DT
with an old kernel would load the tmp117 against a tmp116 and
expect it to fully work.

An example is calibbias which you've dropped from the channels
array entry.

Jonathan


> ---
> v2:
> - drop items from single enum
> 
>  .../bindings/iio/temperature/ti,tmp117.yaml        | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index 8d1ec4d39b28..9b78357d6a79 100644
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
> @@ -16,8 +17,13 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,tmp117
> +    oneOf:
> +      - enum:
> +          - ti,tmp117
> +      - items:
> +          - enum:
> +              - ti,tmp116
> +          - const: ti,tmp117
>  
>    reg:
>      maxItems: 1

