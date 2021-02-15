Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF52E31B961
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 13:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBOMiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 07:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBOMiW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 07:38:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3891564DC3;
        Mon, 15 Feb 2021 12:37:41 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:37:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: add labels with accel-location to bmc150 and
 kxcjk-1013 drivers
Message-ID: <20210215123738.40416763@archlinux>
In-Reply-To: <9f3dfd69-c0cc-13d1-d7b5-738387dcb9e4@redhat.com>
References: <20210207160901.110643-1-hdegoede@redhat.com>
        <20210212183332.7769e70b@archlinux>
        <9f3dfd69-c0cc-13d1-d7b5-738387dcb9e4@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 19:39:11 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/12/21 7:33 PM, Jonathan Cameron wrote:
> > On Sun,  7 Feb 2021 17:08:58 +0100
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> Hi All,
> >>
> >> Here is a patch-set implementing the standardized "accel-display"
> >> and "accel-base" label sysfs-attributes defined in my earlier
> >> "[PATCH 1/2] iio: documentation: Document proximity sensor label use"
> >> "[PATCH 2/2] iio: documentation: Document accelerometer label use"
> >> series.
> >>
> >> This patch sets adds these labels to the bmc150 and kxcjk-1013 accel
> >> drivers.  
> > Series applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to poke at it.  
> 
> Thanks, much appreciated.
> 
> But this was sorta a follow-up to:
> 
> [PATCH 1/2] iio: documentation: Document proximity sensor label use
> [PATCH 2/2] iio: documentation: Document accelerometer label use
> 
> Where 2/2 defines the standardized label values which this series uses
> and AFAIK those have not been merged yet?
> 
> I guess we can always fix the labels if discussion surrounding those
> leads to standardizing on different label contents for this. But if
> the discussion surrounding those results in the conclusion to not
> use labels for this at all, while we already have this merged, then
> we probably need to revert 2/3 and 3/3 of this series...
> 
> But maybe I just missed the 2 documentation patches getting merged ?

Understood.   The changes for the docs patch that I was looking for
are just editorial, so I wasn't that fussed if it goes in slightly out of
order.

Jonathan

> 
> > Note we are almost certainly too late for coming merge window so this
> > will be next time around.  
> 
> That is fine.
> 
> Regards,
> 
> Hans
> 

