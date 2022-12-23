Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7E0655305
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 18:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiLWRBw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 12:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiLWRBv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 12:01:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B78D17E3A;
        Fri, 23 Dec 2022 09:01:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F6E661A59;
        Fri, 23 Dec 2022 17:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEADDC433D2;
        Fri, 23 Dec 2022 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671814909;
        bh=A4/mNrwpd8SCTmPgK53Q2xYAetuTle72u6Nc7y3va24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gK3ojnD0VOoBhhuoC8F8146qhcZr/9z2U7jpiyqW/xsMFKj6Jnntt9lZj+AGmTmTz
         cIriASH6eg9Pdady7A5nkn/e/hZDYw9CXcPw6fxDSlcSvsMpgmO+MfK8VM671dc+9E
         qxhp5kcRPbAKvjD/T+Q2RkdWTBFpg2yJjum1zaLxZg9ISSuzYmX/WnEJc1AvNu/VcX
         Ps8QCeCEwl5P9XKcd40PKFbrZpwcEwP5Adxlsgrlr8C7Eadcat18vTVcP+8ru8dRsa
         z+szRone3DF8QxAaLI7gCiHx7tT8xftKDsRJo5hELbsKyI51/g6mOLbqOdku0jA4em
         ymwHso0kkQ5og==
Date:   Fri, 23 Dec 2022 17:14:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: ti,tmp117: add binding for the
 TMP116
Message-ID: <20221223171458.7bc18893@jic23-huawei>
In-Reply-To: <20221223161051.3c6lvmly7tsjh4eu@pengutronix.de>
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
        <20221221092801.1977499-3-m.felsch@pengutronix.de>
        <20221223150803.37e2939d@jic23-huawei>
        <20221223150338.iqpnp6z3m35eb5hz@pengutronix.de>
        <20221223153729.3353a315@jic23-huawei>
        <20221223161051.3c6lvmly7tsjh4eu@pengutronix.de>
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

On Fri, 23 Dec 2022 17:10:51 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> On 22-12-23, Jonathan Cameron wrote:
> > On Fri, 23 Dec 2022 16:03:38 +0100
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >   
> > > On 22-12-23, Jonathan Cameron wrote:  
> > > > On Wed, 21 Dec 2022 10:27:59 +0100
> > > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > >     
> > > > > The TMP116 is the predecessor of the TMP117.
> > > > > 
> > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>    
> > > > I'm not sure this is introducing a valid fallback. The driver changes
> > > > imply some things the tmp117 driver supports, that this device
> > > > does not. A fallback compatible would mean that a new DT
> > > > with an old kernel would load the tmp117 against a tmp116 and
> > > > expect it to fully work.    
> > > 
> > > Since driver does all the detection an update of the bindings isn't
> > > really necessary. It is just to have a compatible already in place in
> > > case there a things we can't detected during runtime. This flow is
> > > common for a lot of SoC drivers. The fallback will be used as long as
> > > possible and once a specific feature can't be detected only via the
> > > binding, the driver adds the new binding to it of_compatible.  
> > 
> > That's true going forwards and for drivers that introduce a shared
> > generic compatible alongside the initial binding. It can't be easily
> > retrofit.
> > 
> > Fallback compatible is also to allow this to work with old kernels  
> 
> What this small series does is adding the support for the chip. So the
> support starts with the kernel version which includes these patches. Why
> do you assume that one expect to have a proper support with an older
> kernel? I fully get the point that driver needs to deal with older
> device-tree's but having using a newer device-tree's (fw) on older
> kernels and expecting that older kernels does support the chip is a bit
> odd to me.

Probably need the DT maintainers to offer the opinion on this as we
disagree on how fallback compatibles are supposed to work.
I'll accept whatever they say on this point (I've been persuaded
into a more relaxed stance in the past on this).

Allowing a new DTS file to work with old kernels is one of the advantages of
fallback compatibles. On many devices there is no coupling between the two
and there shouldn't need to be one. So in this case the device is not
compatible and we should not imply that it is.

> 
> > - which it doesn't because the kernel driver
> > a) rejects non tmp117 ids (we should fix that by just warning instead 
> > if the ID isn't what we expect. It would be good to factor that out
> > as a separate patch that we can backport)
> > 
> > b) assumes the tmp116 (after above fixed) supports things it doesn't.
> > 
> > So it's not a valid use of a fallback compatible.   
> 
> I added the compatible sring only to have it in place for the future. I
> really didn't have to do that at all since the detection can be done
> during runtime and the only compatible would be tmp117. So sorry but I
> don't get your point here.

Fallback compatibles have multiple purposes. One of them, which should work
is to allow a kernel that only support tmp117 to work with a DTS that says
it is a tmp116 with fallback to tmp117. That's not true here, so there
should not be a fallback.

> 
> > A driver can't rely on matching device IDs it didn't previously know
> > about. It sees tmp116 compatible and thinks it knows how to handle the
> > device, which it doesn't. This might lead to some very grumpy people
> > not understanding why their old kernel doesn't work.  
> 
> Why do you think that people think that the driver have to support a
> device based on the compatible? I saw device-trees with nodes not
> matching any kernel driver since the device-tree is just the firmware
> descibing the hardware. If I got Krzysztof correctly people have to
> check the driver implementation for the according support since the
> bindings can be used by other projects as well and are not limited to
> the linux-kernel.

My understanding is that supporting new compatible parts on old kernels
is one of the reasons fall back compatibles exist (as well as the case
you mention of not modifying a driver until we hit something that requires
it) If that doesn't work, then the driver is broken - which is why I suggest
we fix that.  However in this case the part is not compatible
so the fallback should not be there. You should just add the ID to the
driver given you are modifying it to support the part anyway.

Jonathan


> 
> Regards,
>   Marco
> 
> > Jonathan
> >   
> > > 
> > > Regards,
> > >   Marco
> > >   
> > > > An example is calibbias which you've dropped from the channels
> > > > array entry.
> > > > 
> > > > Jonathan
> > > > 
> > > >     
> > > > > ---
> > > > > v2:
> > > > > - drop items from single enum
> > > > > 
> > > > >  .../bindings/iio/temperature/ti,tmp117.yaml        | 14 ++++++++++----
> > > > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > > > index 8d1ec4d39b28..9b78357d6a79 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > > > @@ -7,8 +7,9 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > >  title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
> > > > >  
> > > > >  description: |
> > > > > -    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
> > > > > -    I2C interface.
> > > > > +    TI TMP116/117 - Digital temperature sensor with integrated NV memory that
> > > > > +    supports I2C interface.
> > > > > +      https://www.ti.com/lit/gpn/tmp116
> > > > >        https://www.ti.com/lit/gpn/tmp117
> > > > >  
> > > > >  maintainers:
> > > > > @@ -16,8 +17,13 @@ maintainers:
> > > > >  
> > > > >  properties:
> > > > >    compatible:
> > > > > -    enum:
> > > > > -      - ti,tmp117
> > > > > +    oneOf:
> > > > > +      - enum:
> > > > > +          - ti,tmp117
> > > > > +      - items:
> > > > > +          - enum:
> > > > > +              - ti,tmp116
> > > > > +          - const: ti,tmp117
> > > > >  
> > > > >    reg:
> > > > >      maxItems: 1    
> > > > 
> > > >     
> > 
> >   

