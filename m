Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF3311A73
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 04:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBFDrk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 22:47:40 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:44540 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhBFDqB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 22:46:01 -0500
Received: by mail-yb1-f173.google.com with SMTP id r2so8753338ybk.11;
        Fri, 05 Feb 2021 19:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AcoHueHL4Wy2Pr1abC9BKUiPNmDLmBdlWfI1XWRBONM=;
        b=mzcx5IqU/FXiySpZJNqVXesUlFsT46cWaStGdRJ2RbJruaAojZAuEY9MCaZ6HQIZKC
         krsRxNiqgNF89cXO9qWRS4Y1QAcEIyXmUkfi0DFUFY9rHRhd+tj8PeerRTN025wrHUYR
         YonK/pmMyd23q9IzqNtD1Lfo/qBZtAtQCfr0Qzxqj8+EYtO6tpEQsaIrGHgtJJ+ljYqF
         yizglPyTVJvrw1wHNxUrfDq1wSwzhZEdKs3Vf7GmueAuKd5SMw17fIUa76BmiVG5wz6R
         0jjtYp/64tmobuUiyQ/OrxF1GMkPj+Bq9DgthXpqSAOBeBHvM3JhaaKz3RzkZIsNXp9T
         /BeA==
X-Gm-Message-State: AOAM531RO545iule3qjvRk/5/Vtz6NB706PI77xF6XRfVp/F+143OtFS
        uH7lf9p9XCbJg7r5x433WVEnzXVKVw==
X-Google-Smtp-Source: ABdhPJysckCTiEn4BNOgsJXp+mp8XOnY9U26In4PM5Rfmj18l/aBfio/eMtVXS8Vr++qgTQZHHkzxA==
X-Received: by 2002:a9d:2035:: with SMTP id n50mr4917292ota.44.1612568066555;
        Fri, 05 Feb 2021 15:34:26 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 36sm2096266oty.62.2021.02.05.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 15:34:25 -0800 (PST)
Received: (nullmailer pid 3971304 invoked by uid 1000);
        Fri, 05 Feb 2021 23:34:24 -0000
Date:   Fri, 5 Feb 2021 17:34:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: counter: add pulse-counter binding
Message-ID: <20210205233424.GA3955177@robh.at.kernel.org>
References: <20210126131239.8335-1-o.rempel@pengutronix.de>
 <20210126131239.8335-2-o.rempel@pengutronix.de>
 <CACRpkdY2XYi2jqYiXaBUfRO1+UEK3QCC8JQ0duENVGoOfYTmBA@mail.gmail.com>
 <20210128133922.khkb4zyccoxdnlyp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128133922.khkb4zyccoxdnlyp@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 28, 2021 at 02:39:22PM +0100, Oleksij Rempel wrote:
> On Thu, Jan 28, 2021 at 09:17:23AM +0100, Linus Walleij wrote:
> > Hi Oleksij,
> > 
> > thanks for your patch!
> > 
> > On Tue, Jan 26, 2021 at 2:15 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > Add binding for the pulse counter node
> > >
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > (...)
> > 
> > > +properties:
> > > +  compatible:
> > > +    const: virtual,pulse-counter
> > 
> > What is so virtual about this? The device seems very real.
> 
> Currently there are two ways:
> 1. use "virtual" or "linux" vendor. Same as "virtual,mdio-gpio"

virtual is used by exactly one case. linux for a few more, mostly 
linux,spdif-dit and extcon (deprecated).

> 2. Extend the list of "not vendor" prefixes in the prefixes list:
>    Documentation/devicetree/bindings/vendor-prefixes.yaml

Pretty sure that says 'DON'T ADD MORE'. Maybe I forgot to scream it.

> 
> Since both ways seems to be valid, i personally prefer to use existing
> prefix instead of maintaining the vendor-prefixes.yaml
> 
> @Rob, what do you prefer?

For vendorless bindings, no vendor prefix! 'gpio-counter' if only gpio 
interfaced. No idea what other options would be.

> 
> > However it is certainly a GPIO counter.
> 
> This was my first implementation. @Jonathan you suggest to use GPIO-free
> way, can you and Linus please decide what is the way to go.
> 
> I personally can imagine that this driver can be attached to any IRQ
> source, including drivers/iio/trigger/iio-trig-sysfs.c
> 
> > I would call it "gpio-counter" simply.
> > 
> > Define:
> >   $nodename:
> >      pattern: "^counter(@.*)?$"
> > 
> > > +    counter-0 {
> > 
> > counter@0 {
> > 
> > > +    counter-1 {
> > 
> > counter@1 {
> 
> In this case the dtc compiler will say:
> /counter@0: node has a unit name, but no reg property

counter-0 then.

> 
> Regards,
> Oleksij
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
