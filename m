Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5D2FA1D6
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 14:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404643AbhARNjy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 08:39:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2365 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404641AbhARNjt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 08:39:49 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKCRW1pPDz67dFQ;
        Mon, 18 Jan 2021 21:33:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 18 Jan 2021 14:39:07 +0100
Received: from localhost (10.47.75.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 18 Jan
 2021 13:39:06 +0000
Date:   Mon, 18 Jan 2021 13:38:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Anand Ashok Dumbre" <ANANDASH@xilinx.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michals@xilinx.com>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATH v3 0/3] iio: adc: xilinx: use even more devres
Message-ID: <20210118133826.00004ba6@Huawei.com>
In-Reply-To: <CAMRc=MfJec9cM8Y7MDux-kd1cuFxy_OiZHU7v-FH3A96H0LHGg@mail.gmail.com>
References: <20201130142759.28216-1-brgl@bgdev.pl>
        <20201130202110.62e7f989@archlinux>
        <BY5PR02MB6916FD4844C5471C635DAD1AA9CA0@BY5PR02MB6916.namprd02.prod.outlook.com>
        <20201213120442.3f98814a@archlinux>
        <CAMRc=MfJec9cM8Y7MDux-kd1cuFxy_OiZHU7v-FH3A96H0LHGg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Jan 2021 10:09:56 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Sun, Dec 13, 2020 at 1:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 11 Dec 2020 12:15:15 +0000
> > Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
> >  
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Monday 30 November 2020 8:21 PM
> > > > To: Bartosz Golaszewski <brgl@bgdev.pl>
> > > > Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> > > > <pmeerw@pmeerw.net>; Michal Simek <michals@xilinx.com>; linux-
> > > > iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; Bartosz Golaszewski
> > > > <bgolaszewski@baylibre.com>; Anand Ashok Dumbre
> > > > <ANANDASH@xilinx.com>
> > > > Subject: Re: [PATH v3 0/3] iio: adc: xilinx: use even more devres
> > > >
> > > > On Mon, 30 Nov 2020 15:27:56 +0100
> > > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >  
> > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > >
> > > > > This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc:
> > > > > use devm_krealloc()"). I noticed we can use even more devres helpers
> > > > > and entirely drop the remove() callback.
> > > > >
> > > > > v1 -> v2:
> > > > > - squash three patches adding more devres calls into one for easier
> > > > > review
> > > > > - don't insist on the 80 characters limit
> > > > > - add a new helper: devm_krealloc_array() and use it
> > > > >
> > > > > v2 -> v3:
> > > > > - drop the devm_krealloc_array() helper
> > > > >
> > > > > Bartosz Golaszewski (3):
> > > > >   iio: adc: xilinx: use helper variable for &pdev->dev
> > > > >   iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
> > > > >   iio: adc: xilinx: use more devres helpers and remove remove()
> > > > >
> > > > >  drivers/iio/adc/xilinx-xadc-core.c | 157
> > > > > ++++++++++++++---------------
> > > > >  1 file changed, 74 insertions(+), 83 deletions(-)
> > > > >  
> > > >
> > > > Series looks good to me but would like to leave it a little longer to let others
> > > > take a look at it. That will probably mean it falls into next cycle now.
> > > >
> > > > +CC Anand who is looking at another series touching this driver and
> > > > +might
> > > > give this one a spin as well.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan  
> > >
> > > Hi Jonathan, Bartosz,
> > >
> > > I have tested and reviewed the patch and everything looks good.
> > > I have another patch series on the same files that might cause conflicts.
> > >
> > > Reviewed-by: Anand Ashok Dumbre <anandash@xilinx.com>
> > > Tested-by: Anand Ashok Dumbre <anandash@xilinx.com>  
> > Thanks,
> >
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to play with it.
> >
> > There was a small amount of fuzz.
> >
> > Thanks,
> >
> > Jonathan
> >  
> 
> Hi Jonathan,
> 
> I still don't see these patches in next - is any action required of me
> to get this in for the next release?

Nope.  I still haven't gotten round to asking for the iio tree itself
to be pulled into next, and I've been a bit busy so haven't yet sent a
pull request to Greg KH this cycle.

I'll get the second sorted, probably later this week.

J

> 
> Bartosz
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

