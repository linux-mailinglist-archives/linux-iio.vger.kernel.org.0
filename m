Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC974256A5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhJGPfg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 11:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhJGPff (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 11:35:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DABF161245;
        Thu,  7 Oct 2021 15:33:39 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:37:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH -next] counter: fix docum. build problems after filename
 change
Message-ID: <20211007163743.2326f4b0@jic23-huawei>
In-Reply-To: <YVvqjOYTo1+zd4bn@shinobu>
References: <20211005055157.22937-1-rdunlap@infradead.org>
        <YVvqjOYTo1+zd4bn@shinobu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Oct 2021 15:02:52 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Mon, Oct 04, 2021 at 10:51:57PM -0700, Randy Dunlap wrote:
> > Fix documentation build warnings due to a source file being
> > renamed.
> > 
> > WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -sphinx-version 1.8.5 -export ../drivers/counter/counter.c' failed with return code 2
> > 
> > Error: Cannot open file ../drivers/counter/counter.c
> > 
> > Fixes: d70e46af7531 ("counter: Internalize sysfs interface code")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> > Cc: linux-iio@vger.kernel.org
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org  
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing to let 0-day
poke at other things I have queued up before I make a potential mess of next.

Thanks,

Jonathan

> 
> > ---
> >  Documentation/driver-api/generic-counter.rst |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-next-20211001.orig/Documentation/driver-api/generic-counter.rst
> > +++ linux-next-20211001/Documentation/driver-api/generic-counter.rst
> > @@ -247,7 +247,7 @@ for defining a counter device.
> >  .. kernel-doc:: include/linux/counter.h
> >     :internal:
> >  
> > -.. kernel-doc:: drivers/counter/counter.c
> > +.. kernel-doc:: drivers/counter/counter-core.c
> >     :export:
> >  
> >  Driver Implementation  

