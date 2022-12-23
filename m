Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6C6551FF
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 16:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLWPYX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 10:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiLWPYW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 10:24:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B058644954;
        Fri, 23 Dec 2022 07:24:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0316C613B3;
        Fri, 23 Dec 2022 15:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BD0C433D2;
        Fri, 23 Dec 2022 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671809060;
        bh=WHnWK9DbQq4R0T/pOjLswrnzE42oO7aoOIyi4cfjU18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TH2Y8bT24HW1cUJp04r++FdgmCk9qRAs0MZIyjYcy+3fbkznrfoBbd5K93GA8fkmt
         BygH2SRBkIjOTyJmde3psD9SBhfyGC7P7RGdHJ2TE9KYqb+Sz3WBpe4FnTjKutgAFC
         /1AHcr79eA/M2V/LKkO96OBPzlhxMdmlL85fKVUHIFeve1e9nZDUdsYl71GzxjWQh2
         RAw0xlmsTxB1fA73E0EDj4db8ZGke/Y4gl29xslBr1l1K2MZoqvqjMAMCFnbisP2aU
         7AvlRqOqpdTDOhUJPcxYwM0YT8GKfI6aj4V3sE7XvrS/aGrbKTfkL66eFwSRfZsL6Y
         pJr0ZYZMwubaA==
Date:   Fri, 23 Dec 2022 15:37:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: ti,tmp117: add binding for the
 TMP116
Message-ID: <20221223153729.3353a315@jic23-huawei>
In-Reply-To: <20221223150338.iqpnp6z3m35eb5hz@pengutronix.de>
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
        <20221221092801.1977499-3-m.felsch@pengutronix.de>
        <20221223150803.37e2939d@jic23-huawei>
        <20221223150338.iqpnp6z3m35eb5hz@pengutronix.de>
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

On Fri, 23 Dec 2022 16:03:38 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> On 22-12-23, Jonathan Cameron wrote:
> > On Wed, 21 Dec 2022 10:27:59 +0100
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >   
> > > The TMP116 is the predecessor of the TMP117.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>  
> > I'm not sure this is introducing a valid fallback. The driver changes
> > imply some things the tmp117 driver supports, that this device
> > does not. A fallback compatible would mean that a new DT
> > with an old kernel would load the tmp117 against a tmp116 and
> > expect it to fully work.  
> 
> Since driver does all the detection an update of the bindings isn't
> really necessary. It is just to have a compatible already in place in
> case there a things we can't detected during runtime. This flow is
> common for a lot of SoC drivers. The fallback will be used as long as
> possible and once a specific feature can't be detected only via the
> binding, the driver adds the new binding to it of_compatible.

That's true going forwards and for drivers that introduce a shared
generic compatible alongside the initial binding. It can't be easily
retrofit.

Fallback compatible is also to allow this to work with old kernels
- which it doesn't because the kernel driver
a) rejects non tmp117 ids (we should fix that by just warning instead 
if the ID isn't what we expect. It would be good to factor that out
as a separate patch that we can backport)

b) assumes the tmp116 (after above fixed) supports things it doesn't.

So it's not a valid use of a fallback compatible.  A driver can't
rely on matching device IDs it didn't previously know about. It sees
tmp116 compatible and thinks it knows how to handle the device, which
it doesn't. This might lead to some very grumpy people not understanding
why their old kernel doesn't work.

Jonathan

> 
> Regards,
>   Marco
> 
> > An example is calibbias which you've dropped from the channels
> > array entry.
> > 
> > Jonathan
> > 
> >   
> > > ---
> > > v2:
> > > - drop items from single enum
> > > 
> > >  .../bindings/iio/temperature/ti,tmp117.yaml        | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > index 8d1ec4d39b28..9b78357d6a79 100644
> > > --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > @@ -7,8 +7,9 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > >  title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
> > >  
> > >  description: |
> > > -    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
> > > -    I2C interface.
> > > +    TI TMP116/117 - Digital temperature sensor with integrated NV memory that
> > > +    supports I2C interface.
> > > +      https://www.ti.com/lit/gpn/tmp116
> > >        https://www.ti.com/lit/gpn/tmp117
> > >  
> > >  maintainers:
> > > @@ -16,8 +17,13 @@ maintainers:
> > >  
> > >  properties:
> > >    compatible:
> > > -    enum:
> > > -      - ti,tmp117
> > > +    oneOf:
> > > +      - enum:
> > > +          - ti,tmp117
> > > +      - items:
> > > +          - enum:
> > > +              - ti,tmp116
> > > +          - const: ti,tmp117
> > >  
> > >    reg:
> > >      maxItems: 1  
> > 
> >   

