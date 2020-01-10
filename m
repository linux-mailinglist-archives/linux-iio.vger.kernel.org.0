Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA9136A6F
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2020 11:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgAJKBx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 10 Jan 2020 05:01:53 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727336AbgAJKBx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 10 Jan 2020 05:01:53 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D047B70748EF312315BA;
        Fri, 10 Jan 2020 10:01:51 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 10 Jan 2020 10:01:51 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 10 Jan
 2020 10:01:51 +0000
Date:   Fri, 10 Jan 2020 10:01:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        <kernel@pengutronix.de>
Subject: Re: [PATCH v4 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20200110100148.00001033@Huawei.com>
In-Reply-To: <20200109205954.hyjvtwpddvytzgpr@pengutronix.de>
References: <20191209203248.21555-1-u.kleine-koenig@pengutronix.de>
        <20191209203248.21555-2-u.kleine-koenig@pengutronix.de>
        <20191215114958.6ad37d19@archlinux>
        <20191216083736.lzmborv33w6odlaj@pengutronix.de>
        <20191223175854.600c7254@archlinux>
        <20200109205954.hyjvtwpddvytzgpr@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 Jan 2020 21:59:54 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hello Jonathan,
> 
> On Mon, Dec 23, 2019 at 05:58:54PM +0000, Jonathan Cameron wrote:
> > On Mon, 16 Dec 2019 09:37:36 +0100
> > Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:
> >   
> > > Hello Jonathan,
> > > 
> > > On Sun, Dec 15, 2019 at 11:49:58AM +0000, Jonathan Cameron wrote:  
> > > > On Mon,  9 Dec 2019 21:32:46 +0100
> > > > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> > > >     
> > > > > The ADC only requires the standard stuff for spi devices and a reference
> > > > > voltage.
> > > > > 
> > > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>    
> > > > Thanks for figuring out what was wrong and fixing it up.    
> > > 
> > > It wasn't done primarily to do you a favour :-)
> > >   
> > > > > +  spi-max-frequency:
> > > > > +    description: maximal spi bus frequency supported by the chip    
> > > > 
> > > > dropped the "by the chip" as this is also about the wiring on the board.  If it
> > > > were just the chip, it could be put in the driver.  The unknown bit is
> > > > if there is some other reason why it might need to be set lower than the maximum.    
> > > 
> > > fine for me.
> > >   
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - vref-supply
> > > > > +  - reg
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    spi {
> > > > > +        #address-cells = <1>;
> > > > > +        #size-cells = <0>;
> > > > > +
> > > > > +        adc@0 {
> > > > > +        	compatible = "lltc,ltc2496";    
> > > > You can't easily see it here, but this is a mixture of spaces
> > > > and tabs.  Should be all spaces.  I've tidied that up.    
> > > 
> > > I did that on purpose, spaces to have the needed indention for the yaml
> > > syntax and then tabs for dts indention (as done in the dts itself, too).
> > > I thought this to be the right mix, but this was my first yaml binding,
> > > so you're probably right.  
> > 
> > I'll be honest, I'm far from sure on this.
> > 
> > I usually rely on Rob moaning about it if it's wrong :)
> > 
> > Oh well. What's there builds. If we get a 'fix' later then so be it.  
> 
> I found my commits in your tree (at
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing)
> and wonder why they don't appear in next. IMHO it would be good to have
> some exposure there to give more people the opportunity to moan. Is this
> a mistake that your tree is not included in next?
> 
> I assume being in your testing branch means I can reasonably expect they
> will go into 5.6-rc1?

Given timing yes. I tend to do last pull request 1-2 weeks before the merge window
opens.  Greg KH takes IIO through his staging tree.  One day that might change
but for now that's how we do it.  Note that I'll carry on taking things into
the togreg branch (which first becomes visible as testing) after that, but they'll
not go anywhere until after the merge window.

There was a slight delay this time around, but Greg took the pull request this
morning so they should be in Linux-next on Monday.

They are indeed heading for 5.6-rc1.

Thanks,

Jonathan

> 
> Best regards
> Uwe
> 


