Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11384307D0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhJQKRw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 06:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbhJQKRv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 06:17:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 788596103B;
        Sun, 17 Oct 2021 10:15:41 +0000 (UTC)
Date:   Sun, 17 Oct 2021 11:19:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PULL] 1st set of counter and IIO new features, drivers etc for
 5.16
Message-ID: <20211017111955.12c73cc5@jic23-huawei>
In-Reply-To: <YWvXz4wxb2Mr/Hu9@kroah.com>
References: <20211016165117.6a4deb27@jic23-huawei>
        <YWvXz4wxb2Mr/Hu9@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Oct 2021 09:59:11 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Oct 16, 2021 at 04:51:17PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > 
> >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16a
> > 
> > for you to fetch changes up to 9dd58cce7873d97e31faff7abdb7968593cb3005:
> > 
> >   iio: imx8qxp-adc: mark PM functions as __maybe_unused (2021-10-14 18:43:28 +0100)
> > 
> > ----------------------------------------------------------------
> > First set of IIO and counter new device and feature support for the 5.16 cycle
> > 
> > This has been a busy cycle in both subsystems, so lots here and a few
> > more stragglers to come next week.
> > 
> > Counter
> > ======
> > 
> > Most interesting element this time is the new chrdev based interface
> > for the counter subsystem.  Affects all drivers. Some minor precursor
> > patches.
> > 
> > Major parts:
> > * Bring all the sysfs attribute setup into the counter core rather than
> >   leaving it to individual drivers.  Docs updates accompany these changes.
> > * Move various definitions to a uapi header as now needed from userspace.
> > * Add the chardev interface + extensive documentation and example tool
> > * Add new ABI needed to identify indexes needed for chrdev interface
> > * Implement new interface for the 104-quad-8
> > * Follow up deals with wrong path for documentation build
> > * Various trivial cleanups and missing feature additions related to this
> >   series  
> 
> This is a lot, and I have some comments on some of the individual
> changes here.  Are we sure this should all be going through the staging
> tree still?  How about char/misc now?

I don't really mind on the route.

> 
> How can I comment on the chrdev stuff here in a way that will reach the
> proper developers?  Is this the correct thread:
> 	https://lore.kernel.org/all/cover.1632884256.git.vilhelm.gray@gmail.com/

That's the main series.

> 
> And why does this have to go through the iio tree?

Habit that needs rethinking!  I'll split the trees and send a pair of pull
requests so you can look at them separately.  Whilst I don't mind handling the
counter tree, I'm also fine if William sends these directly to you if that
works better. If we do that I'll carry on reviewing them.

There will shortly be iio-togreg and counter-togreg branches in
iio.git that I'll merge into togreg as a temporary measure as that's what
Stephen is picking up for next.

> 
> The IIO stuff looks fine, any way to send me a pull request with just
> those changes now?

Will do.
> 
> And again, should we reconsider just sending all of this through the
> char/misc tree now that you have really outgrown the staging tree?

I'm absolutely fine with that if it works better for you.  This is based
off rc1 anyway at the moment, so that should cause no problems process wise.

Jonathan

> 
> thanks,
> 
> greg k-h

