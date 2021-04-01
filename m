Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126D7351E95
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhDASnx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238339AbhDASh7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 14:37:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9787461264;
        Thu,  1 Apr 2021 15:00:11 +0000 (UTC)
Date:   Thu, 1 Apr 2021 16:00:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/5] iio: Documentation: update definitions for
 bufferY and scan_elements
Message-ID: <20210401160020.17537821@jic23-huawei>
In-Reply-To: <20210401154408.5f26a3c6@coco.lan>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
        <20210217083438.37865-2-alexandru.ardelean@analog.com>
        <20210401154408.5f26a3c6@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Apr 2021 15:44:08 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 17 Feb 2021 10:34:34 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> escreveu:
> 
> > Since the new change to the IIO buffer infrastructure, the buffer/ and
> > scan_elements/ directories have been merged into bufferY/ to have some
> > attributes available per-buffer.
> > 
> > This change updates the ABI docs to reflect this change.
> > 
> > The hwfifo attributes are not updated, as for now these should be used
> > via the legacy buffer/ directory until they are moved into core.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 85 +++++++++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index d957f5da5c04..f2a72d7fbacb 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1118,12 +1118,16 @@ Description:
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/buffer/length
> >  KernelVersion:	2.6.35
> > +What:		/sys/bus/iio/devices/iio:deviceX/bufferY/length
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Number of scans contained by the buffer.  
> 
> The ABI parser doesn't like things like this:
> 
> 	$ ./scripts/get_abi.pl validate
> 
> 	Warning: file Documentation/ABI/testing/sysfs-bus-iio#1167:
> 		What '/sys/bus/iio/devices/iio:deviceX/buffer/length' doesn't have a description
> 
> The main reason is that all properties, including KernelVersion, 
> Contact and Description are associated to a group of properties.
> 
> To be frank, for me that don't work with IIO, the above ABI
> description doesn't sound clear.
> 
> I mean, what's the difference between
> 	/sys/bus/iio/devices/iio:deviceX/buffer/length
> and
> 	/sys/bus/iio/devices/iio:deviceX/bufferY/length?
> 
> 
> If the intention is to tell that:
> 	/sys/bus/iio/devices/iio:deviceX/buffer/length
> was obsoleted by:
> 	/sys/bus/iio/devices/iio:deviceX/bufferY/length
> 
> IMO, the right thing would be to move the deprecated definition to
> 	Documentation/ABI/obsolete/
> 
> If, on the other hand, both are completely identical and 
> non-obsoleted, why to have both APIs? 
> 
> Or did you just missed adding a different description for the
> new ABI symbols, but this was dropped due to some merge
> conflict?

You are right that the version with out the index is obsolete
but it's only just become so and there are no realistic way we
are going to ever be able to remove it however much we encourage
userspace to use the new interface.  We are stuck with this bit
of backwards compatibility indefinitely.

I'm fine with moving it and related definitions over to
ABI/obsolete if that makes sense.

Jonathan



> 
> Thanks,
> Mauro

