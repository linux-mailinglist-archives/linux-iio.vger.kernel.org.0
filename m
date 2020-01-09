Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39F13621C
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 22:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgAIVAA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 16:00:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51913 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgAIVAA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 16:00:00 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipeuK-0003wo-H9; Thu, 09 Jan 2020 21:59:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipeuI-0001J3-7H; Thu, 09 Jan 2020 21:59:54 +0100
Date:   Thu, 9 Jan 2020 21:59:54 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20200109205954.hyjvtwpddvytzgpr@pengutronix.de>
References: <20191209203248.21555-1-u.kleine-koenig@pengutronix.de>
 <20191209203248.21555-2-u.kleine-koenig@pengutronix.de>
 <20191215114958.6ad37d19@archlinux>
 <20191216083736.lzmborv33w6odlaj@pengutronix.de>
 <20191223175854.600c7254@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223175854.600c7254@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

On Mon, Dec 23, 2019 at 05:58:54PM +0000, Jonathan Cameron wrote:
> On Mon, 16 Dec 2019 09:37:36 +0100
> Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Hello Jonathan,
> > 
> > On Sun, Dec 15, 2019 at 11:49:58AM +0000, Jonathan Cameron wrote:
> > > On Mon,  9 Dec 2019 21:32:46 +0100
> > > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> > >   
> > > > The ADC only requires the standard stuff for spi devices and a reference
> > > > voltage.
> > > > 
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>  
> > > Thanks for figuring out what was wrong and fixing it up.  
> > 
> > It wasn't done primarily to do you a favour :-)
> > 
> > > > +  spi-max-frequency:
> > > > +    description: maximal spi bus frequency supported by the chip  
> > > 
> > > dropped the "by the chip" as this is also about the wiring on the board.  If it
> > > were just the chip, it could be put in the driver.  The unknown bit is
> > > if there is some other reason why it might need to be set lower than the maximum.  
> > 
> > fine for me.
> > 
> > > > +required:
> > > > +  - compatible
> > > > +  - vref-supply
> > > > +  - reg
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    spi {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +
> > > > +        adc@0 {
> > > > +        	compatible = "lltc,ltc2496";  
> > > You can't easily see it here, but this is a mixture of spaces
> > > and tabs.  Should be all spaces.  I've tidied that up.  
> > 
> > I did that on purpose, spaces to have the needed indention for the yaml
> > syntax and then tabs for dts indention (as done in the dts itself, too).
> > I thought this to be the right mix, but this was my first yaml binding,
> > so you're probably right.
> 
> I'll be honest, I'm far from sure on this.
> 
> I usually rely on Rob moaning about it if it's wrong :)
> 
> Oh well. What's there builds. If we get a 'fix' later then so be it.

I found my commits in your tree (at
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing)
and wonder why they don't appear in next. IMHO it would be good to have
some exposure there to give more people the opportunity to moan. Is this
a mistake that your tree is not included in next?

I assume being in your testing branch means I can reasonably expect they
will go into 5.6-rc1?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
