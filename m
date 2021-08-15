Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394D93EC9F6
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 17:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhHOPb0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 15 Aug 2021 11:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHOPb0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 11:31:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF7E6120D;
        Sun, 15 Aug 2021 15:30:54 +0000 (UTC)
Date:   Sun, 15 Aug 2021 16:33:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
Message-ID: <20210815163353.4ae25f81@jic23-huawei>
In-Reply-To: <20210812191919.00000217@Huawei.com>
References: <20210811133220.190264-1-nuno.sa@analog.com>
        <20210811133220.190264-2-nuno.sa@analog.com>
        <CAHp75Vfp_u9mbnUzcBXdv_RmFu9m4JK0=R5us6j3bquG4HzRvQ@mail.gmail.com>
        <PH0PR03MB6366AC51BA01533E28001A3F99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20210812191919.00000217@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Aug 2021 19:19:19 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 12 Aug 2021 06:54:13 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> 
> > > -----Original Message-----
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Wednesday, August 11, 2021 6:15 PM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Drew
> > > Fustini <drew@pdp7.com>
> > > Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
> > > 
> > > [External]
> > > 
> > > On Wed, Aug 11, 2021 at 4:32 PM Nuno Sá <nuno.sa@analog.com>
> > > wrote:
> > > 
> > > Thanks for an update, my comments below.
> > > Depending on Jonathan's wishes it may or may not require a v3.
> > > If you address the minor issues I commented on, take mine
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >     
> > 
> > Thanks for reviewing... Yeah, I will wait for Jonathan's feedback before
> > sending a v3. It might be that he can apply your inputs when applying
> > the patch.  
> 
> Patch looks sensible. I can make the tweaks whilst applying when I
> happen to be on the right computer.
Given we are too late for fixes (other than urgent regressions introduced
this cycle) I've tweaked as Andy suggested and applied to the togreg branch of
iio.git (pushed out as testing for 0-day to take first go at breaking it).

I've also marked it for stable.

Thanks,

Jonathan

> 
> Having glanced at the datasheet, I wonder if you ever had the
> reset pin wired up (and perhaps decided to drop that
> complexity later)?  The driver rather oddly
> include of_gpio.h and has no gpio accesses which makes me
> wonder ;)
> 
> Jonathan
> 
> > 
> > Thanks!
> > - Nuno Sá  
> 

