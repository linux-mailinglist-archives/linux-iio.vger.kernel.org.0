Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF34107EB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 19:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhIRRxT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 13:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhIRRxS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 13:53:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9996101B;
        Sat, 18 Sep 2021 17:51:50 +0000 (UTC)
Date:   Sat, 18 Sep 2021 18:55:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v5 04/15] iio: adc: aspeed: Keep model data to driver data.
Message-ID: <20210918185530.4f667796@jic23-huawei>
In-Reply-To: <CACPK8Xe4KifkDxm0H6LtpCJZ1n07GLvxR_nF4Cfy5+4WXn9Z6g@mail.gmail.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
        <20210831071458.2334-5-billy_tsai@aspeedtech.com>
        <20210905153339.751732cc@jic23-huawei>
        <20210905155029.3faa2c04@jic23-huawei>
        <CACPK8Xe4KifkDxm0H6LtpCJZ1n07GLvxR_nF4Cfy5+4WXn9Z6g@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Sep 2021 03:52:24 +0000
Joel Stanley <joel@jms.id.au> wrote:

> On Sun, 5 Sept 2021 at 14:47, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sun, 5 Sep 2021 15:33:39 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > On Tue, 31 Aug 2021 15:14:47 +0800
> > > Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> > >  
> > > > Keep the model data pointer to driver data for reducing the usage of
> > > > of_device_get_match_data().
> > > >
> > > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> > > This one starts to be impacted by the fix (as its in the context).
> > > Rather than making a mess of things for linux-next etc I'll hold
> > > off on these until that fix is upstream in a few weeks.
> > >
> > > If I seem to have lost it (it's been known to happen :( ) then
> > > feel free to poke me!  
> >
> > Having taken another look at the rest of the series (and Philipp's review)
> > please do a v6 starting from this patch.  
> 
> I'd recommend against the practice of half applying a series. I have
> just spent a good chunk of time looking at v6, and wondering why it
> won't apply to any tags in Linus tree nor to next.

Hi Joel,

In this particular case it may been unwise, but in general it allows me to
handle a higher volume of patches than would otherwise be possible.
There are of course other approaches, but this one works well for me.
I did express to what tree and branch these were being applied
+ exposed for build tests.

> 
> (It was made worse by the branch you applied them to not being part of
> linux-next.)

It will be shortly. That was just unfortunate timing because of the end of the
merge window and a some issues that 0-day found in other patches in the tree
that needed to be fixed up before making a mess in next.

Jonathan

> 
> Cheers,
> 
> Joel

