Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFB2700B0
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 15:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfGVNKt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 09:10:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfGVNKt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 09:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GLfj3XE94O2rj+M1sDTUTWfglE0+aX441ii2IeKx/CI=; b=nRZwn/4NR9XHQ9sVhmDigrjy7
        3S3HlKrJQkjiz0voh8ZPb7dQm7aJXztF5PbsOj0DSouxZY2y0qPviHngwp1ZWVrE+dxDw6SoKrY2l
        pF6HqDdBwRqqDDaHnXCfoXdLSq23wo9bRL8C9N7rA0GirCNhiSUCdOscHoY0mKB4XKMjBJr4C4oRh
        8InhsLufSJN14DVBLsEuEp593sGGRaSS/RMWrTSz+MbrSvcSPAbpcD8HDOLR5mJ2mkkG7qC1Pw8Lz
        I6wbdSuhVGHJBJlMFyz2F5TAmgmsWf1ZollbkM6ttMGYn2Ap7eilwDCK0Ku392VFkvbWxZQ77m2Mo
        4dM8QpNxQ==;
Received: from 177.157.124.3.dynamic.adsl.gvt.net.br ([177.157.124.3] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpY5P-0002aj-VB; Mon, 22 Jul 2019 13:10:40 +0000
Date:   Mon, 22 Jul 2019 10:10:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 04/22] docs: spi: convert to ReST and add it to the kABI
 bookset
Message-ID: <20190722101035.4f61c1bf@coco.lan>
In-Reply-To: <20190722121151.GC4756@sirena.org.uk>
References: <cover.1563792333.git.mchehab+samsung@kernel.org>
        <be171b438013f8824425595e3d637f5e7d466249.1563792334.git.mchehab+samsung@kernel.org>
        <20190722121151.GC4756@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Mon, 22 Jul 2019 13:11:51 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Mon, Jul 22, 2019 at 08:07:31AM -0300, Mauro Carvalho Chehab wrote:
> > While there's one file there with briefily describes the uAPI,
> > the documentation was written just like most subsystems: focused
> > on kernel developers. So, add it together with driver-api books.  
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

Sure. Do you prefer this prefixed by:

	spi: docs:

Or with something else?

> >  Documentation/spi/{spidev => spidev.rst}      |  30 +++--  
> 
> This is clearly a userspace focused document rather than a kernel
> internal one.

True. What I've been doing so far is, for all drivers that I'm converting
with carries more than one documentation type (kABI, uABI and/or 
admin-guide) is to keep the directory as-is, adding them under
this section at Documentation/index.rst:

	Kernel API documentation
	------------------------

That's the case of media, input, hwmon, and so many other subsystems.

Yet, you're right: this implies that there will be some things
to be done, as the long-term documentation should be like:

	Documentation/admin-guide/{media, input, hwmon, spi, ...}
	Documentation/userspace-api/{media, input, hwmon, spi, ...}
	Documentation/driver-api/{media, input, hwmon, spi, ...}

Btw, if you look at spidev file, it contains stuff for both
userspace-api:

	"SPI devices have a limited userspace API, supporting basic half-duplex
	 read() and write() access to SPI slave devices.  Using ioctl() requests,"

And for admin-guide:

	"For a SPI device with chipselect C on bus B, you should see:

	    /dev/spidevB.C ... character special device, major number 153 with
		a dynamically chosen minor device number. "

So, if we're willing to move it, the best is to do on a separate patch
with would split its contents into two files: admin-guide/spi-devices.rst and 
userspace-api/spi-api.rst.

-

There are a couple of reasons why I opted for this strategy:

1) There are *lots* of docs that contain all 3 types of information
   on it on a single file.

2) On media, we use SPHINXDIRS to produce the media book from our
   devel tree:
	https://linuxtv.org/downloads/v4l-dvb-apis-new/index.html

   When documents are built with either PDF SPHINXDIRS, each subdir
   will be on a different book and all inter-book cross-references
   will break.
   
   For this to be fixed, we'll likely need to use something like
   intersphinx extension, but this would probably require a
   per-subsystem mapping (for example, saying that, for media, the
   site used to resolve broken cross references is linuxtv.org). 
   Maintaining it can be painful.

3) So far, I was unable to split even the media docs! Shame on
   me! The reason is that this is not an easy task.


One interesting example is at what we consider to be the media
uAPI book. It actually contains both sysadmin and uAPI documentation.

For example, at:

	Documentation/media/uapi/v4l/open.rst

You'll see that, while most things there belong to the admin
guide (device node descriptions, multiple opens, etc), it
mentions the Kernel userspace API - open(), read(), close() syscalls.

Splitting this file on two separate books won't be that easy.

Ideally, we should split what's there at media/uapi into admin-guide
and userspace-api, but this would mean *a lot* of efforts. Not sure
if it is worth the effort.


Thanks,
Mauro
