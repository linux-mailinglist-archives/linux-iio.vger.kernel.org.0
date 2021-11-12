Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5244EC13
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 18:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhKLRmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 12:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233404AbhKLRmO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 12:42:14 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0064260FE3;
        Fri, 12 Nov 2021 17:39:21 +0000 (UTC)
Date:   Fri, 12 Nov 2021 17:44:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: add filter subfolder
Message-ID: <20211112174406.7915970e@jic23-huawei>
In-Reply-To: <20211112173621.0ce23ef3@jic23-huawei>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
        <20211109123127.96399-2-antoniu.miclaus@analog.com>
        <20211112173621.0ce23ef3@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Nov 2021 17:36:21 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 9 Nov 2021 14:31:24 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > Add filter subfolder for IIO devices that handle filter functionality.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>  
> 
> Hi Antoniu,
> 
> Are we likely to see many filter drivers?  If not we could classify them
> as analog front ends and put them in the AFE directory?

On actually reading what device was I'm fine with filters directory.
AFE is more appropriate if we are talking about a front end for something
we are going to feed to an ADC rather that filtering a microwave frequency signal.

Jonathan

> 
> If there are going to be lots then I'm fine with a new directory.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/Kconfig         | 1 +
> >  drivers/iio/Makefile        | 1 +
> >  drivers/iio/filter/Kconfig  | 8 ++++++++
> >  drivers/iio/filter/Makefile | 6 ++++++
> >  4 files changed, 16 insertions(+)
> >  create mode 100644 drivers/iio/filter/Kconfig
> >  create mode 100644 drivers/iio/filter/Makefile
> > 
> > diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> > index 2334ad249b46..3a496a28bad4 100644
> > --- a/drivers/iio/Kconfig
> > +++ b/drivers/iio/Kconfig
> > @@ -77,6 +77,7 @@ source "drivers/iio/chemical/Kconfig"
> >  source "drivers/iio/common/Kconfig"
> >  source "drivers/iio/dac/Kconfig"
> >  source "drivers/iio/dummy/Kconfig"
> > +source "drivers/iio/filter/Kconfig"
> >  source "drivers/iio/frequency/Kconfig"
> >  source "drivers/iio/gyro/Kconfig"
> >  source "drivers/iio/health/Kconfig"
> > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > index 65e39bd4f934..97d2fbcf0950 100644
> > --- a/drivers/iio/Makefile
> > +++ b/drivers/iio/Makefile
> > @@ -24,6 +24,7 @@ obj-y += common/
> >  obj-y += dac/
> >  obj-y += dummy/
> >  obj-y += gyro/
> > +obj-y += filter/
> >  obj-y += frequency/
> >  obj-y += health/
> >  obj-y += humidity/
> > diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
> > new file mode 100644
> > index 000000000000..e268bba43852
> > --- /dev/null
> > +++ b/drivers/iio/filter/Kconfig
> > @@ -0,0 +1,8 @@
> > +#
> > +# Filter drivers
> > +#
> > +# When adding new entries keep the list in alphabetical order
> > +
> > +menu "Filters"
> > +
> > +endmenu
> > diff --git a/drivers/iio/filter/Makefile b/drivers/iio/filter/Makefile
> > new file mode 100644
> > index 000000000000..cc0892c01142
> > --- /dev/null
> > +++ b/drivers/iio/filter/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for industrial I/O Filter drivers
> > +#
> > +
> > +# When adding new entries keep the list in alphabetical order  
> 

