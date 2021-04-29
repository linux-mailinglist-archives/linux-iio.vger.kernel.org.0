Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC136E437
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 06:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhD2E2e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 00:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhD2E2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 00:28:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F773C06138C
        for <linux-iio@vger.kernel.org>; Wed, 28 Apr 2021 21:27:11 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lbyGU-0006mq-Fp; Thu, 29 Apr 2021 06:27:02 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lbyGR-0007Ca-4z; Thu, 29 Apr 2021 06:26:59 +0200
Date:   Thu, 29 Apr 2021 06:26:59 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings:iio:adc: add generic settling-time-us
 and oversampling-ratio channel properties
Message-ID: <20210429042659.rioipw3sqdmtmymy@pengutronix.de>
References: <20210428073208.19570-1-o.rempel@pengutronix.de>
 <20210428073208.19570-2-o.rempel@pengutronix.de>
 <20210428175931.00002a7e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210428175931.00002a7e@Huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:26:38 up 147 days, 18:33, 33 users,  load average: 0.15, 0.06,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 28, 2021 at 05:59:31PM +0100, Jonathan Cameron wrote:
> On Wed, 28 Apr 2021 09:32:06 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Settling time and over sampling is a typical challenge for different IIO ADC
> > devices. So, introduce channel specific settling-time-us and oversampling-ratio
> > properties to cover this use case.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> This and patch 2 both look good to me.  Given Rob gave a minor comment on the
> previous version I don't feel I need him to look at this again.
> 
> Will pick up in a few days if no other reviews come in to require a v7.

Ok, thank you!


> Thanks,
> 
> Jonathan
> 
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adc.yaml | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > index 912a7635edc4..db348fcbb52c 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > @@ -39,4 +39,16 @@ properties:
> >        The first value specifies the positive input pin, the second
> >        specifies the negative input pin.
> >  
> > +  settling-time-us:
> > +    description:
> > +      Time between enabling the channel and first stable readings.
> > +
> > +  oversampling-ratio:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Oversampling is used as replacement of or addition to the low-pass filter.
> > +      In some cases, the desired filtering characteristics are a function the
> > +      device design and can interact with other characteristics such as
> > +      settling time.
> > +
> >  additionalProperties: true
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
