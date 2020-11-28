Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F832C7493
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgK1Vtb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387395AbgK1TGv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:06:51 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE26D24677;
        Sat, 28 Nov 2020 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606570834;
        bh=rbJeBPUYhl6GPSmdIP1yrJCzYX5bhCpiHnCO9FSCpO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CdRpV3F8GM4g7JT3uG7+z/efdsNNfdAOW6lk1RF/CFWqonhORWspIVpMGGOJq1zRw
         PSKagrQSk9/vGw2ok0/oMSX9zTYHlZfj7PVBNRCtUaguDMhxHLDg2lyRXbqSOIB5tD
         J3En5I4Kr8pbQ/n2TxdEVfSs28t8B5cRlvH2Q1YM=
Date:   Sat, 28 Nov 2020 13:40:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/3 v3] iio: accel: bmc150-accel: Add rudimentary
 regulator support
Message-ID: <20201128134030.1dc08d21@archlinux>
In-Reply-To: <CACRpkdbP3ccrEK47jaQ=r8sYkFuXBcH=+LTKC1xz+kgXmkwomg@mail.gmail.com>
References: <20201115205745.618455-1-linus.walleij@linaro.org>
        <20201115205745.618455-3-linus.walleij@linaro.org>
        <20201121164505.30767f9f@archlinux>
        <CACRpkdbP3ccrEK47jaQ=r8sYkFuXBcH=+LTKC1xz+kgXmkwomg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 12:44:26 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Nov 21, 2020 at 5:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun, 15 Nov 2020 21:57:45 +0100
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> >  
> > > These Bosch accelerometers have two supplies, VDD and VDDIO.
> > > Add some rudimentary support to obtain and enable these
> > > regulators during probe() and disable them during remove()
> > > or on the errorpath.
> > >
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> 
> > All looks good to me.  Will leave it for a bit longer though to let
> > Rob have a chance to look at the dt binding doc.
> >
> > As ever, if it seems to have gotten lost it is probably worth
> > poking me.  
> 
> It's been another week and the bindings are simple enough
> I think? There has been plenty of time to review these
> bindings as they are now in v3 even, but it's a soft measure,
> I know there is usually this YAML-bot that complains if
> something is way out of line at least.
Agreed. No need to bother Rob with this one if he's busy.
It's had 2 weeks in it's final patch version.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to poke at it.

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

