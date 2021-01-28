Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ACD307746
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 14:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhA1NkH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jan 2021 08:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhA1NkH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jan 2021 08:40:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231A3C061574
        for <linux-iio@vger.kernel.org>; Thu, 28 Jan 2021 05:39:27 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l57W7-0004tf-81; Thu, 28 Jan 2021 14:39:23 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1l57W6-0005Fj-Kg; Thu, 28 Jan 2021 14:39:22 +0100
Date:   Thu, 28 Jan 2021 14:39:22 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: counter: add pulse-counter binding
Message-ID: <20210128133922.khkb4zyccoxdnlyp@pengutronix.de>
References: <20210126131239.8335-1-o.rempel@pengutronix.de>
 <20210126131239.8335-2-o.rempel@pengutronix.de>
 <CACRpkdY2XYi2jqYiXaBUfRO1+UEK3QCC8JQ0duENVGoOfYTmBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdY2XYi2jqYiXaBUfRO1+UEK3QCC8JQ0duENVGoOfYTmBA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:43:14 up 57 days,  2:49, 33 users,  load average: 0.00, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 28, 2021 at 09:17:23AM +0100, Linus Walleij wrote:
> Hi Oleksij,
> 
> thanks for your patch!
> 
> On Tue, Jan 26, 2021 at 2:15 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Add binding for the pulse counter node
> >
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> (...)
> 
> > +properties:
> > +  compatible:
> > +    const: virtual,pulse-counter
> 
> What is so virtual about this? The device seems very real.

Currently there are two ways:
1. use "virtual" or "linux" vendor. Same as "virtual,mdio-gpio"
2. Extend the list of "not vendor" prefixes in the prefixes list:
   Documentation/devicetree/bindings/vendor-prefixes.yaml

Since both ways seems to be valid, i personally prefer to use existing
prefix instead of maintaining the vendor-prefixes.yaml

@Rob, what do you prefer?

> However it is certainly a GPIO counter.

This was my first implementation. @Jonathan you suggest to use GPIO-free
way, can you and Linus please decide what is the way to go.

I personally can imagine that this driver can be attached to any IRQ
source, including drivers/iio/trigger/iio-trig-sysfs.c

> I would call it "gpio-counter" simply.
> 
> Define:
>   $nodename:
>      pattern: "^counter(@.*)?$"
> 
> > +    counter-0 {
> 
> counter@0 {
> 
> > +    counter-1 {
> 
> counter@1 {

In this case the dtc compiler will say:
/counter@0: node has a unit name, but no reg property

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
