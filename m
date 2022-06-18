Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E176C550615
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 18:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiFRQQy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRQQy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 12:16:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F44DEBC;
        Sat, 18 Jun 2022 09:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB2F6B80A3A;
        Sat, 18 Jun 2022 16:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF08C3411A;
        Sat, 18 Jun 2022 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655569010;
        bh=c9Y3EvZa2xM0DjuSlwHgoqGCtBVg51LiTWySW1LQHZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ChXJoqhhSx4prP3vuEv4vyzVjvAuy9juc48OcFVWWRcMi+ohQ7zUCvPF9dG+BAo4S
         /HXNR+1m4yhb0YmGVfnm4i15JHjP2sy+mGk1B2GfkBmQy6tijwOQdh6yMU1SJ0PYmP
         dGAKOwCYx1iZQiMTljZMt0pVmHSU8pfOuJhncKp1XMkSsFuw+mNFJm8m78Xaz4suVl
         /50nX4MnCC+Y5S2e8bEcMl1Q4ZURo2QfpC/iiHDHsyEWCl+cZzcVaXl83MWyqRlFRc
         eu8XLGRF/gOKkym89+NGiqZM5mz9+cHli8ffCTYKGJItVGQakEqiumJkl9NPhRlD/T
         bQeVFghY/qeTg==
Date:   Sat, 18 Jun 2022 17:26:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio/accel: Fix adi,adxl345/6 example I2C
 address
Message-ID: <20220618172607.15dbae8f@jic23-huawei>
In-Reply-To: <20220615233411.90621-1-marex@denx.de>
References: <20220615233411.90621-1-marex@denx.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jun 2022 01:34:11 +0200
Marek Vasut <marex@denx.de> wrote:

> Align the example node address and reg content to be 0x2a for both.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Seems obviously correct to me, so I've applied it to the togreg
branch of iio.git and pushed that out as testing for 0-day to poke
at it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 11d32a2885352..9bb039e2f5331 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -55,7 +55,7 @@ examples:
>          /* Example for a I2C device node */
>          accelerometer@2a {
>              compatible = "adi,adxl345";
> -            reg = <0x53>;
> +            reg = <0x2a>;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
>          };

