Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCC59C968
	for <lists+linux-iio@lfdr.de>; Mon, 22 Aug 2022 21:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiHVT7N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Aug 2022 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiHVT7K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2022 15:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A32ED48;
        Mon, 22 Aug 2022 12:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E5361268;
        Mon, 22 Aug 2022 19:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB98C433D6;
        Mon, 22 Aug 2022 19:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661198343;
        bh=DyI3t8tEVvUlMKrONGNmpaBQQiZiHW1qaggJxfPqUDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogIxteFut606xWhAb+66+D56KTO0OHtro0EOuQEf7paZ+0CSRSBbd/MgYoJ+XtvqQ
         aLmrrdozqKgXnGe7kZPZQvnfNsHsb5l9kK2sNTDgBAZ204P1exn1ddAwam+jNgS78+
         KawD5/gAdzBoMbunRYJBdVGlurbi9KOGRPdv8/4bkkzi51IazbiusDCzyH/EER1w6a
         Y0cNtQmthaxrLBUjS9HQJ3l4rw1PzXN/s8dpH0KGisj5kPsppxUjcQ95iTrmWcvy31
         O2F2u6XJ2NBGJcGejmFvXQMyV5SHTqrf4KdOx+XH2F9hg6o8VOHHqKlFFqJoddxHVp
         ryfIEocGA/Bsg==
Date:   Mon, 22 Aug 2022 20:24:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add docs for LTC2499
Message-ID: <20220822202435.7dd54583@jic23-huawei>
In-Reply-To: <20220822125106.1106798-2-ciprian.regus@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
        <20220822125106.1106798-2-ciprian.regus@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Aug 2022 15:51:04 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> Update the bindings documentation for ltc2497 to include the ltc2499.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Looks fine to me.  Maybe a separate patch to add the ltc2496 binding
given the driver is included in this MAINTAINERS entry?
A random comment inline.

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 6 +++++-
>  MAINTAINERS                                                 | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> index c1772b568cd1..7bb30eafc543 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> @@ -13,10 +13,14 @@ description: |
>    16bit ADC supporting up to 16 single ended or 8 differential inputs.
>    I2C interface.
>  
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2497fb.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
> +
>  properties:
>    compatible:
> -    const:
> +    enum:
>        lltc,ltc2497
> +      lltc,ltc2499
>  
>    reg: true
>    vref-supply: true
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..3c847619ceb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1327,6 +1327,7 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>  F:	Documentation/devicetree/bindings/iio/*/adi,*
> +F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml

Unrelated question, but why is this here given the wild cards above match?

>  F:	drivers/iio/*/ad*
>  F:	drivers/iio/adc/ltc249*
