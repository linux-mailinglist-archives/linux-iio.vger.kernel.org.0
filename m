Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7273136B05
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2020 11:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgAJKY5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jan 2020 05:24:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42119 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgAJKY5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jan 2020 05:24:57 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iprTF-0006mj-Ih; Fri, 10 Jan 2020 11:24:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iprTD-0004QX-7w; Fri, 10 Jan 2020 11:24:47 +0100
Date:   Fri, 10 Jan 2020 11:24:47 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20200110102447.cf2eipc4q2aij345@pengutronix.de>
References: <20191209203248.21555-1-u.kleine-koenig@pengutronix.de>
 <20191209203248.21555-2-u.kleine-koenig@pengutronix.de>
 <20191215114958.6ad37d19@archlinux>
 <20191216083736.lzmborv33w6odlaj@pengutronix.de>
 <20191223175854.600c7254@archlinux>
 <20200109205954.hyjvtwpddvytzgpr@pengutronix.de>
 <20200110100148.00001033@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200110100148.00001033@Huawei.com>
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

On Fri, Jan 10, 2020 at 10:01:48AM +0000, Jonathan Cameron wrote:
> On Thu, 9 Jan 2020 21:59:54 +0100
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> > I found my commits in your tree (at
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing)
> > and wonder why they don't appear in next. IMHO it would be good to have
> > some exposure there to give more people the opportunity to moan. Is this
> > a mistake that your tree is not included in next?
> > 
> > I assume being in your testing branch means I can reasonably expect they
> > will go into 5.6-rc1?
> 
> Given timing yes. I tend to do last pull request 1-2 weeks before the merge window
> opens.  Greg KH takes IIO through his staging tree.  One day that might change
> but for now that's how we do it.  Note that I'll carry on taking things into
> the togreg branch (which first becomes visible as testing) after that, but they'll
> not go anywhere until after the merge window.
> 
> There was a slight delay this time around, but Greg took the pull request this
> morning so they should be in Linux-next on Monday.
> 
> They are indeed heading for 5.6-rc1.

Thanks for your explanation and taking the patches.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
