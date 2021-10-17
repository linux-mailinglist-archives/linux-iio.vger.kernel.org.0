Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA73430727
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 10:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhJQIFV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 04:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236307AbhJQIFU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 04:05:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F57861179;
        Sun, 17 Oct 2021 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634457791;
        bh=4Eein5e+Yb+JrTtO+W4RSeuL+kfX6ZP3Byr+wd5kQA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udIOA79xGgNrJyXYOFlhJ3XMHRs0iriw+/CrCMEdVmq98bdVZ3Wf2am87BkOzunlz
         QDm69NvuspWDL5GHbkeO5ul0t7x9dzzgQ+tw4pcFQ7RlSlUqyy3dX/CjakwWLa03aW
         QjwkNWj1O8ocURwEYdb5MtfwsAVUtarA8iWzwQDI=
Date:   Sun, 17 Oct 2021 10:03:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of counter and IIO new features, drivers etc for
 5.16
Message-ID: <YWvYvR7NwtQWFXpq@kroah.com>
References: <20211016165117.6a4deb27@jic23-huawei>
 <YWvXz4wxb2Mr/Hu9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWvXz4wxb2Mr/Hu9@kroah.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 17, 2021 at 09:59:11AM +0200, Greg KH wrote:
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
> 
> How can I comment on the chrdev stuff here in a way that will reach the
> proper developers?  Is this the correct thread:
> 	https://lore.kernel.org/all/cover.1632884256.git.vilhelm.gray@gmail.com/

To be specific, I do not object to this code at all, and overall it
looks great, I just have some cleanups/suggestions/removals that
probably should be done to it.  Odds are, they can just be follow-on
patches and really, I should do it myself if I want to complain, right?  :)

thanks,

greg k-h
