Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E868A728
	for <lists+linux-iio@lfdr.de>; Sat,  4 Feb 2023 01:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBDAN5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Feb 2023 19:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBDANy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 19:13:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65124A77BC
        for <linux-iio@vger.kernel.org>; Fri,  3 Feb 2023 16:13:49 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pO6BU-0000Gp-1s; Sat, 04 Feb 2023 01:13:36 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pO6BR-0003jE-U4; Sat, 04 Feb 2023 01:13:33 +0100
Date:   Sat, 4 Feb 2023 01:13:33 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: add missing vref-supply
Message-ID: <20230204001333.ywrkty3an3cbuq33@pengutronix.de>
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com>
 <1922814.PYKUYFuaPT@steina-w>
 <20230203141217.et55oxbtxcilg3ig@pengutronix.de>
 <3214924.aeNJFYEL58@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3214924.aeNJFYEL58@steina-w>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

HI Alexander,

On 23-02-03, Alexander Stein wrote:
> Am Freitag, 3. Februar 2023, 15:12:17 CET schrieb Marco Felsch:
> > Hi,
> > 
> > On 23-02-03, Alexander Stein wrote:
> > 
> > ...
> > 
> > > > > > > > +  vref-supply:
> > > > > > > > +    description: External ADC reference voltage supply on VREFH
> > > > > > > > pad.
> > > > > > > 
> > > > > > > Please add it to the list of required properties, we can remove it
> > > > > > > as
> > > > > > > soon as the driver has support for the internal reference
> > > > > > > voltages.
> > > > > > 
> > > > > > I was thinking in doing so before as well. But DT describes the
> > > > > > hardware, and this ADC apparently would be functioning without a
> > > > > > reference voltage on that pad, using a different one. What the
> > > > > > driver
> > > > > > actual does is a different matter.>
> > > > > 
> > > > > I have also thought about it first but than I checked the RM which
> > > > > says
> > > > > that "multi-reference selection" is chip dependent.
> > > 
> > > Nice for pointing this out. I wasn't aware that there are differences.
> > > 
> > > > Oh goody. So is it detectable?
> > > 
> > > That's my problem. I didn't find any source of information which chips do
> > > support multiple references and which don't.
> > > Marco, do you have some information on this?
> > 
> > You can download the RM from the NXP website but you need an account for
> > it:
> > https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/
> > i-mx-applications-processors/i-mx-8-applications-processors/i-mx-8-family-ar
> > m-cortex-a53-cortex-a72-virtualization-vision-3d-graphics-4k-video:i.MX8
> > 
> > Or is this the wrong model? The naming scheme is quite confusing to me.
> 
> That's i.MX8 (imx8qm), the bindings are for i.MX8X (imx8qxp/imx8dxp). But I 
> assume the ADC is similar/identical.
> 
> > > > If we are going to stick to a single compatible rather than adding them
> > > > for
> > > > the variants with and without this feature, should probably add a note
> > > > at
> > > > least to say it is required for some parts.
> > > 
> > > That's a good idea. I'm okay with that, until there is more information
> > > available.
> > 
> > According the RM there is a bit which can be read: Multi Vref
> > Implemented (MVI).
> 
> Ah, nice. So there is a hardware feature. From the RM I have available it is 
> set for both imx8qm and imx8qxp. Given that I will not mark this as required, 
> but add a comment regarding this feature bit.

Can you check the comments about the refsel please? Since this is the
important part.  Since the RM above states that this bit will indicate a
multiref device but it can also the case that, you have a chip with just
on ref selection option (external). I can't check this since I don't
have the RM for this. @NXP can you give us more information please?

Regards,
  Marco
