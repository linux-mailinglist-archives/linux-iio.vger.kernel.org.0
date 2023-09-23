Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9047AC413
	for <lists+linux-iio@lfdr.de>; Sat, 23 Sep 2023 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjIWRkn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Sep 2023 13:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjIWRkm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Sep 2023 13:40:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B9124
        for <linux-iio@vger.kernel.org>; Sat, 23 Sep 2023 10:40:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE7CC433C7;
        Sat, 23 Sep 2023 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695490836;
        bh=ugb+Q7yUo6vOZ78Q9LWkOQP4MwXiiPMfFXOkwc1MmKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q0nkZFCJxBNOzqUYCxVViad5Be+xfCn7Z507+LJLbHAIu9UmJBD1U8ZNfpENFLkbe
         WNBQA35eqlfSaQaXTiwxLZ5D9yhYA7DzoHhOh+ftWbffQVsCpktUvSk3AK4I9g55Pa
         lxE/Oc62ttZEiHr7kEcWwqGT/uFd0CJ2swJZjbgP9lNId/Js8I/bN3Qa9F3GOWPyBJ
         oy/6DOQxXLEQ0JSrf1Fibo/TmAIcBz8msJEbE+zyxAuT5+PiMW6NQkMZynD3CddgNX
         sZFmJZ4/UJ5E852Ql634BKWLm9ZEPXUVqWVor3kGwm5c4xv5bQVS/y7d6g4yeWrJ8d
         ZJpfFGHItCXAQ==
Date:   Sat, 23 Sep 2023 18:40:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Alexandru Lazar <alazar@startmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: Document optional
 interrupt line
Message-ID: <20230923184026.577d4644@jic23-huawei>
In-Reply-To: <20230922-demise-shallot-2623f8ff869b@spud>
References: <20230921192420.70643-1-marex@denx.de>
        <20230922-demise-shallot-2623f8ff869b@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Sep 2023 12:30:06 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Sep 21, 2023 at 09:24:20PM +0200, Marek Vasut wrote:
> > The ADS1015 can have optional IRQ line connected, document it in the DT bindings.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> > Cc: Alexandru Lazar <alazar@startmail.com>
> > Cc: Conor Dooley <conor+dt@kernel.org>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan

> 
> Thanks,
> Conor.
> 
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Marco Felsch <m.felsch@pengutronix.de>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > index e004659099c19..d605999ffe288 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > @@ -23,6 +23,9 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  interrupts:
> > +    maxItems: 1
> > +
> >    "#address-cells":
> >      const: 1
> >  
> > -- 
> > 2.40.1
> >   

