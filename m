Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71746122FA
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ2MjK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ2MjJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 08:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB4F5BC;
        Sat, 29 Oct 2022 05:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CAC60921;
        Sat, 29 Oct 2022 12:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC9C433C1;
        Sat, 29 Oct 2022 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667047147;
        bh=s6DwFZr4p5Nv9auYKCqUUdyR1/gRNx0yp6nQ1POqRos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OVjseauTUkV2BjIQy3hWO1e+MajwDmaGHPM4rwIB05d9EGS+perUmOjkA6YyWC3cg
         J0jQ2ggaIG2byBR4tBMUv5o8C9HyEAAisdo4S/rxtednpRByjSuCmmb+f6dPgQg8P+
         tjz4s3Na5y76MTMvzEXUTKgoQhpIwT5+W/SmPGxkzR16XsFOK3uBgt71x5H+mPzDnS
         x8gO4Wlpkp6Y4YfmRK9c/FRnsvV+yt0jSII0dRsG6SeX/A4A13apSwXBGokvzxF4tC
         LmGCWfzWFNC84lTKMABBI8dPD/0xhVcyQJqI/3gMdQ+3hif9PGKcfZ95Kv0SaqJsyC
         HpiNsw5Ag0Qew==
Date:   Sat, 29 Oct 2022 13:51:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rcar-gyroadc:
 Miscellaneous improvements
Message-ID: <20221029135102.5bb9d786@jic23-huawei>
In-Reply-To: <3c0895a3-2da6-3bd1-c786-01cf5eaa2452@linaro.org>
References: <7b7a13680fa24282c3407e12b5943a66a2ed9068.1666611184.git.geert+renesas@glider.be>
        <3c0895a3-2da6-3bd1-c786-01cf5eaa2452@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Oct 2022 08:23:43 -0400
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 24/10/2022 07:34, Geert Uytterhoeven wrote:
> > Set limits on the number of power-domains and resets, and make them
> > required.
> > 
> > Simplify the example, and update it to match reality:
> >   - Convert from obsolete MSTP to CPG/MSSR bindings,
> >   - Examples should use #{address,size}-cells = <1>,
> >   - Add missing resets property,
> >   - Drop soc container and pinctrl properties, which are not needed in
> >     examples.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied,
Thanks

Jonathan

> 
> Best regards,
> Krzysztof
> 

