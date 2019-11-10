Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C47F6A7D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKJRMc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 12:12:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfKJRMc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 12:12:32 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF11C20842;
        Sun, 10 Nov 2019 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573405951;
        bh=/KkqecyOJYBFCx0D/yKSm7L3y/HCier7+TlwX0yrVvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SvdgotGvRwAnYxOLtptKKpssSMmVhvud+ObHtZ7BYFLo2jKkciYUqlomIWoXoSEZS
         JXfjuOzbbavz1bcnwvXnqOSyYBW/BzFQUHdwJIYo4X4ydPIE3D9laPxWMzbzdJZCSc
         SPnuKVR0d5gG2Jn4g7xqlbdKGyupiA0esTW0bFms=
Date:   Sun, 10 Nov 2019 17:12:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] tools: iio: Correctly add make dependency for iio_utils
Message-ID: <20191110171226.13b68f18@archlinux>
In-Reply-To: <20191027165414.3e4c3530@archlinux>
References: <20191018172908.3761-1-labbott@redhat.com>
        <20191027165414.3e4c3530@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Oct 2019 16:54:14 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 18 Oct 2019 13:29:08 -0400
> Laura Abbott <labbott@redhat.com> wrote:
> 
> > iio tools fail to build correctly with make parallelization:
> > 
> > $ make -s -j24
> > fixdep: error opening depfile: ./.iio_utils.o.d: No such file or directory
> > make[1]: *** [/home/labbott/linux_upstream/tools/build/Makefile.build:96: iio_utils.o] Error 2
> > make: *** [Makefile:43: iio_event_monitor-in.o] Error 2
> > make: *** Waiting for unfinished jobs....
> > 
> > This is because iio_utils.o is used across multiple targets.
> > Fix this by making iio_utils.o a proper dependency.
> > 
> > Signed-off-by: Laura Abbott <labbott@redhat.com>  
> This looks fine to me, but my Makefile foo is decidedly limited. 
> Anyone else want to give a view?
> 
> It seems sensible to backport this to stable as it seems low
> risk and will avoid some odd issues for distros.
I've applied it to the togreg branch of iio.git for now. We can
request a stable backport once it's in mainline.  It might
make the coming merge window if Linus suggest we are looking
at an rc8.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> > ---
> > I realize that we don't really need the parallelization for tools
> > because it's so small but when building with the distro we want to use
> > the same make command and -j wherever possible.
> > 
> > This same issue also appears in the gpio tools so if this looks like an
> > okay approach I'll fix it there as well.
> > ---
> >  tools/iio/Build    |  1 +
> >  tools/iio/Makefile | 10 +++++++---
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/iio/Build b/tools/iio/Build
> > index f74cbda64710..8d0f3af3723f 100644
> > --- a/tools/iio/Build
> > +++ b/tools/iio/Build
> > @@ -1,3 +1,4 @@
> > +iio_utils-y += iio_utils.o
> >  lsiio-y += lsiio.o iio_utils.o
> >  iio_event_monitor-y += iio_event_monitor.o iio_utils.o
> >  iio_generic_buffer-y += iio_generic_buffer.o iio_utils.o
> > diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> > index e22378dba244..3de763d9ab70 100644
> > --- a/tools/iio/Makefile
> > +++ b/tools/iio/Makefile
> > @@ -32,20 +32,24 @@ $(OUTPUT)include/linux/iio: ../../include/uapi/linux/iio
> >  
> >  prepare: $(OUTPUT)include/linux/iio
> >  
> > +IIO_UTILS_IN := $(OUTPUT)iio_utils-in.o
> > +$(IIO_UTILS_IN): prepare FORCE
> > +	$(Q)$(MAKE) $(build)=iio_utils
> > +
> >  LSIIO_IN := $(OUTPUT)lsiio-in.o
> > -$(LSIIO_IN): prepare FORCE
> > +$(LSIIO_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
> >  	$(Q)$(MAKE) $(build)=lsiio
> >  $(OUTPUT)lsiio: $(LSIIO_IN)
> >  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> >  
> >  IIO_EVENT_MONITOR_IN := $(OUTPUT)iio_event_monitor-in.o
> > -$(IIO_EVENT_MONITOR_IN): prepare FORCE
> > +$(IIO_EVENT_MONITOR_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
> >  	$(Q)$(MAKE) $(build)=iio_event_monitor
> >  $(OUTPUT)iio_event_monitor: $(IIO_EVENT_MONITOR_IN)
> >  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> >  
> >  IIO_GENERIC_BUFFER_IN := $(OUTPUT)iio_generic_buffer-in.o
> > -$(IIO_GENERIC_BUFFER_IN): prepare FORCE
> > +$(IIO_GENERIC_BUFFER_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
> >  	$(Q)$(MAKE) $(build)=iio_generic_buffer
> >  $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
> >  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@  
> 

