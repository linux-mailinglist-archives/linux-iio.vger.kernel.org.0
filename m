Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562B566BA2B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 10:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjAPJXT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 04:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjAPJXQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 04:23:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE234ECA
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 01:23:15 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pHLhq-0006wh-GD; Mon, 16 Jan 2023 10:23:06 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pHLhq-0000GP-3b; Mon, 16 Jan 2023 10:23:06 +0100
Date:   Mon, 16 Jan 2023 10:23:06 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: ti,tmp117: add binding for the
 TMP116
Message-ID: <20230116092306.arawj4ku3tpgtzmv@pengutronix.de>
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
 <20221221092801.1977499-3-m.felsch@pengutronix.de>
 <20221223150803.37e2939d@jic23-huawei>
 <20221223150338.iqpnp6z3m35eb5hz@pengutronix.de>
 <20221223153729.3353a315@jic23-huawei>
 <20221223161051.3c6lvmly7tsjh4eu@pengutronix.de>
 <20221223171458.7bc18893@jic23-huawei>
 <20221223171323.qhuhq42tivcdllvq@pengutronix.de>
 <144609b6-8da2-1a2b-941c-4163d38adab1@linaro.org>
 <20221230175921.06e0d4c0@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230175921.06e0d4c0@jic23-huawei>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22-12-30, Jonathan Cameron wrote:
> On Tue, 27 Dec 2022 09:40:13 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 23/12/2022 18:13, Marco Felsch wrote:
> > > Hi Jonathan,
> > > 
> > > On 22-12-23, Jonathan Cameron wrote:  
> > >> On Fri, 23 Dec 2022 17:10:51 +0100
> > >> Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >>  
> > >>> On 22-12-23, Jonathan Cameron wrote:  
> > >>>> On Fri, 23 Dec 2022 16:03:38 +0100
> > >>>> Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >>>>     
> > >>>>> On 22-12-23, Jonathan Cameron wrote:    
> > >>>>>> On Wed, 21 Dec 2022 10:27:59 +0100
> > >>>>>> Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >>>>>>       
> > >>>>>>> The TMP116 is the predecessor of the TMP117.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>      
> > >>>>>> I'm not sure this is introducing a valid fallback. The driver changes
> > >>>>>> imply some things the tmp117 driver supports, that this device
> > >>>>>> does not. A fallback compatible would mean that a new DT
> > >>>>>> with an old kernel would load the tmp117 against a tmp116 and
> > >>>>>> expect it to fully work.      
> > >>>>>
> > >>>>> Since driver does all the detection an update of the bindings isn't
> > >>>>> really necessary. It is just to have a compatible already in place in
> > >>>>> case there a things we can't detected during runtime. This flow is
> > >>>>> common for a lot of SoC drivers. The fallback will be used as long as
> > >>>>> possible and once a specific feature can't be detected only via the
> > >>>>> binding, the driver adds the new binding to it of_compatible.    
> > >>>>
> > >>>> That's true going forwards and for drivers that introduce a shared
> > >>>> generic compatible alongside the initial binding. It can't be easily
> > >>>> retrofit.
> > >>>>
> > >>>> Fallback compatible is also to allow this to work with old kernels    
> > 
> > Yes, if the devices are compatible, e.g. there is no need to change in
> > the driver to support new device.
> > 
> > If the devices need auto-detection and are compatible in an auto-detect
> > way, then I don't think we have such goal.
> > 
> > >>>
> > >>> What this small series does is adding the support for the chip. So the
> > >>> support starts with the kernel version which includes these patches. Why
> > >>> do you assume that one expect to have a proper support with an older
> > >>> kernel? I fully get the point that driver needs to deal with older
> > >>> device-tree's but having using a newer device-tree's (fw) on older
> > >>> kernels and expecting that older kernels does support the chip is a bit
> > >>> odd to me.  
> > >>
> > >> Probably need the DT maintainers to offer the opinion on this as we
> > >> disagree on how fallback compatibles are supposed to work.
> > >> I'll accept whatever they say on this point (I've been persuaded
> > >> into a more relaxed stance in the past on this).  
> > 
> > DTS can be used outside of kernel - other projects or new DTS with old
> > kernel - and the way of working is bound by bindings. Therefore it is
> > really good if you use new DTS with older kernel and it works.
> > 
> > As I said above, for devices that are fully compatible, this should be
> > the goal. Many SoC components are like this and we describe them that
> > way. However they do not have mostly auto-detection.
> > 
> > Now for devices which are both:
> >  - compatible according to the binding (so the interface is the same,
> > stable and handled by Linux),
> >  - AND actually significantly different, where the difference is
> > recognized by auto-detection,
> > the Linux should be reasonable and it might freely choose not to support
> > unknown devices.
> 
> Ok. In this case my gut feeling would be that a new ID and no fallback
> is the best balance.  Ironically if we'd had a binding for the tmp116 first
> and fell back to that from the tmp117 we'd probably be fine (just
> have fewer features).  I guess nothing stops us documenting that binding
> even though the tmp117 is already used to match in Linux.

Hi Jonathan, Krzysztof,

thanks for the detailed explanation. IMHO the fallback mechanism is
still fine but if you are worried about it I will change this to have a
separate compatible.

Regards,
  Marco

> > You can compare it to the world without DT where everything is
> > auto-detectable. The Linux kernel performs auto-detection and based on
> > this either works or does not work with the device. But the kernel has
> > full discretion to decide about it.
> > 
> > Users would be happy if kernel would work with unknown, new devices. But
> > also users would be unhappy if this damages their system because of e.g.
> > wrong voltage.
> 
> Agreed - using old code is a nice to have, but not always the best choice.
> 
> Jonathan
> 
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> 
