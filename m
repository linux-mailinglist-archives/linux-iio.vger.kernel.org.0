Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055852D8CFB
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 13:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406339AbgLMMF2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 07:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406296AbgLMMF1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 07:05:27 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C105F23121;
        Sun, 13 Dec 2020 12:04:45 +0000 (UTC)
Date:   Sun, 13 Dec 2020 12:04:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATH v3 0/3] iio: adc: xilinx: use even more devres
Message-ID: <20201213120442.3f98814a@archlinux>
In-Reply-To: <BY5PR02MB6916FD4844C5471C635DAD1AA9CA0@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20201130142759.28216-1-brgl@bgdev.pl>
        <20201130202110.62e7f989@archlinux>
        <BY5PR02MB6916FD4844C5471C635DAD1AA9CA0@BY5PR02MB6916.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Dec 2020 12:15:15 +0000
Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Monday 30 November 2020 8:21 PM
> > To: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>; Michal Simek <michals@xilinx.com>; linux-
> > iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Bartosz Golaszewski
> > <bgolaszewski@baylibre.com>; Anand Ashok Dumbre
> > <ANANDASH@xilinx.com>
> > Subject: Re: [PATH v3 0/3] iio: adc: xilinx: use even more devres
> > 
> > On Mon, 30 Nov 2020 15:27:56 +0100
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >   
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc:
> > > use devm_krealloc()"). I noticed we can use even more devres helpers
> > > and entirely drop the remove() callback.
> > >
> > > v1 -> v2:
> > > - squash three patches adding more devres calls into one for easier
> > > review
> > > - don't insist on the 80 characters limit
> > > - add a new helper: devm_krealloc_array() and use it
> > >
> > > v2 -> v3:
> > > - drop the devm_krealloc_array() helper
> > >
> > > Bartosz Golaszewski (3):
> > >   iio: adc: xilinx: use helper variable for &pdev->dev
> > >   iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
> > >   iio: adc: xilinx: use more devres helpers and remove remove()
> > >
> > >  drivers/iio/adc/xilinx-xadc-core.c | 157
> > > ++++++++++++++---------------
> > >  1 file changed, 74 insertions(+), 83 deletions(-)
> > >  
> > 
> > Series looks good to me but would like to leave it a little longer to let others
> > take a look at it. That will probably mean it falls into next cycle now.
> > 
> > +CC Anand who is looking at another series touching this driver and
> > +might
> > give this one a spin as well.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Hi Jonathan, Bartosz,
> 
> I have tested and reviewed the patch and everything looks good.
> I have another patch series on the same files that might cause conflicts.
> 
> Reviewed-by: Anand Ashok Dumbre <anandash@xilinx.com>
> Tested-by: Anand Ashok Dumbre <anandash@xilinx.com>
Thanks,

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

There was a small amount of fuzz.

Thanks,

Jonathan

> 
> Thanks,
> Anand

