Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE0C270E24
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgISNdy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 09:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISNdy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 09:33:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B10A20709;
        Sat, 19 Sep 2020 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600522433;
        bh=O6A21An7afWZtqrmulH4Ozq6BM/kRyb6vZ8Y+wavVxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TQ9hXU1d3SUx3H1qefokNDQxEL3pKGABtcxVZyymZmhGBd7mSIHZs5Mwqq9SDvIyI
         Fs45nh+EqVQfdGkoYZKGta9RjBmd/vZaTgYUAnPCYXu8mdKd+M0KxrNJ9ljixTgcEp
         9aH/ArDdosHf19uQ6aLu7qSZXxgyhWslSk1jIhRY=
Date:   Sat, 19 Sep 2020 14:33:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rob Herring <robh@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 01/20] dt-bindings:iio:adc:fsl,vf610-adc conversion
 to yaml.
Message-ID: <20200919143348.624cab27@archlinux>
In-Reply-To: <AM8PR04MB73155DCE23BC613898AD43FDFF3E0@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-2-jic23@kernel.org>
        <CAL_JsqJhBFqi8=gku8sv5=8MTB1uCTq=DkuoVzEaUMxO1QhBAg@mail.gmail.com>
        <20200916113401.00006d86@Huawei.com>
        <AM8PR04MB73155DCE23BC613898AD43FDFF3E0@AM8PR04MB7315.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Sep 2020 02:24:36 +0000
Andy Duan <fugang.duan@nxp.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com> Sent: Wednesday, September 16, 2020 6:34 PM
> > On Tue, 15 Sep 2020 14:45:58 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >   
> > > On Wed, Sep 9, 2020 at 12:02 PM Jonathan Cameron <jic23@kernel.org>  
> > wrote:  
> > > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > A simple conversion of this freescale ADC binding from txt to yaml.
> > > > For maintainer I went with Fugang Duan as the original author of the
> > > > binding. Would be great to have confirmation of this.
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Fugang Duan <B38611@freescale.com>
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  .../bindings/iio/adc/fsl,vf610-adc.yaml       | 81  
> > +++++++++++++++++++  
> > > >  .../devicetree/bindings/iio/adc/vf610-adc.txt | 36 ---------
> > > >  2 files changed, 81 insertions(+), 36 deletions(-)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > > > b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > > > new file mode 100644
> > > > index 000000000000..99b6b55fd0a3
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > > > @@ -0,0 +1,81 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > > +---
> > > > +$id:
> > > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fde
> > > >  
> > +vicetree.org%2Fschemas%2Fiio%2Fadc%2Ffsl%2Cvf610-adc.yaml%23&amp;da  
> > > >  
> > +ta=02%7C01%7Cfugang.duan%40nxp.com%7C750fcd8ebdf34af6655308d85a2
> > c41  
> > > >  
> > +8d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63735849344455
> > 0580&  
> > > >  
> > +amp;sdata=SwRIWqN5caXEUZBTmnjKKHJKAZ1FQ03s1Gdpf%2FTyXzE%3D&am
> > p;rese  
> > > > +rved=0
> > > > +$schema:
> > > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fde
> > > >  
> > +vicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Cfug
> > an  
> > > >  
> > +g.duan%40nxp.com%7C750fcd8ebdf34af6655308d85a2c418d%7C686ea1d3bc
> > 2b4  
> > > >  
> > +c6fa92cd99c5c301635%7C0%7C0%7C637358493444550580&amp;sdata=c4To
> > ZCOG  
> > > > +iPM0XbxCnLGJEEXvnMvFKqSgg3gtLeDYACI%3D&amp;reserved=0
> > > > +
> > > > +title: ADC found on Freescale vf610 and similar SoCs
> > > > +
> > > > +maintainers:
> > > > +  - Fugang Duan <B38611@freescale.com>  
> > >
> > > I assume you got a bunch of bounces on this series, too? Looks like 1,
> > > 4, 7, 9, 13, 16, 19, and 20 bounced. Please fix those addresses before
> > > applying.  
> > 
> > Yup. I missed them on v1, but have saved the set for v2 to be able to fix those I
> > can.
> > 
> > for some I can make a reasonable stab at a suitable maintainer as covered by a
> > catch all.  For the others if I can't find a newer address I'll cover them myself
> > until someone else steps up.
> > I think that's just 9 and 13.  For 4 I didn't get a bounce but can add that to my
> > list!
> > 
> > For this particular one looks like fugang duan is still active but now with an NXP
> > address so I'll update that. I've changed the cc on this mail.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Thanks, Jonathan.
> 
> For the patch, it looks good.
> 
> Reviewed-by: Fugang Duan <fugang.duan@nxp.com>

I've updated the maintainer address to the one you have for this tag
and applied to the togreg branch of iio.git, pushing out as testing
for the autobuilders to perhaps poke at it.

Thanks,

Jonathan

> > 
> >   
> > >
> > > Rob  
> >   
> 

