Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C80F34D0EE
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 15:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhC2NG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 09:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhC2NGa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 09:06:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1070C061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 06:06:29 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lQrb3-0006o4-6z; Mon, 29 Mar 2021 15:06:21 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lQrb2-000345-I5; Mon, 29 Mar 2021 15:06:20 +0200
Date:   Mon, 29 Mar 2021 15:06:20 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings:iio:adc: add generic settling-time-us
 and oversampling-ratio channel properties
Message-ID: <20210329130620.utfdlgwzixrenqka@pengutronix.de>
References: <20210329073131.1759-1-o.rempel@pengutronix.de>
 <20210329073131.1759-2-o.rempel@pengutronix.de>
 <20210329112532.174825d6@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210329112532.174825d6@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:57:12 up 117 days,  3:03, 48 users,  load average: 0.14, 0.14,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 29, 2021 at 11:25:32AM +0100, Jonathan Cameron wrote:
> On Mon, 29 Mar 2021 09:31:29 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Settling time and over sampling is a typical challenge for different IIO ADC
> > devices. So, introduce channel specific settling-time-us and oversampling-ratio
> > properties to cover this use case.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > index 912a7635edc4..d5bc86d2a2af 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > @@ -39,4 +39,12 @@ properties:
> >        The first value specifies the positive input pin, the second
> >        specifies the negative input pin.
> >  
> > +  settling-time-us:
> > +    description:
> > +      Time between enabling the channel and firs stable readings.
> 
> first

ack

> > +
> > +  oversampling-ratio:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Number of data samples which are averaged for each read.
> 
> I think I've asked about this in previous reviews, but I want a clear statement
> of why you think this property is a feature of the 'board' (and hence should be
> in device tree) rather than setting sensible defaults and leaving any control
> to userspace?

yes, my reply was:
> Oversampling is used as replacement of or addition to the low-pass filter. The
> filter can be implemented on board, but it will change settling time
> characteristic. Since low-pass filter is board specific characteristic, this
> property belongs in device tree as well.

I could imagine that this values can be overwritten from user space for
diagnostic, but we need some working default values. 

Should I integrate this comment in to the yaml?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
