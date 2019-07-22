Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8958670490
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfGVPwF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 11:52:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfGVPvy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 11:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YOtnv5kilBDnIuNIM7uB6lgkqy9fntG3COwWbK/lDVY=; b=isf58cBUJXt3FDFfKcAkQ6p9m
        6oMXQ91QMCgqUsdO3p0tZdwBEX8RBwuj4L75IeuwpNoswYuHIEfLY0q8pWhL+uPjSw/plQdNSAyI9
        drug/jrTyLAjlUs+xY4qOHykRUB7LrFLqgxYGpyrf1pRkJwfW1yYMxT75/YhKMK8PNvV+6o6gwf2B
        MaAKecVGvfhQfmdPY+Lc1zyzACndfPxn04bO9ahzrOPMurJGvVvyMH1odVNsP+Z54eU9h/Lb9ZR8E
        l9EbRmTOlPm7egB6RwatuUrldOYjNulDPFayokBcPca79W1jMmXsYHCxLzmBUx4u+WRy3SAFxt6RT
        bEG9CBbig==;
Received: from 177.157.124.3.dynamic.adsl.gvt.net.br ([177.157.124.3] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpabB-0001Y5-KH; Mon, 22 Jul 2019 15:51:38 +0000
Date:   Mon, 22 Jul 2019 12:51:33 -0300
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
Message-ID: <20190722125133.5cda0da3@coco.lan>
In-Reply-To: <20190722152110.GE4756@sirena.org.uk>
References: <cover.1563792333.git.mchehab+samsung@kernel.org>
        <be171b438013f8824425595e3d637f5e7d466249.1563792334.git.mchehab+samsung@kernel.org>
        <20190722121151.GC4756@sirena.org.uk>
        <20190722101035.4f61c1bf@coco.lan>
        <20190722152110.GE4756@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Mon, 22 Jul 2019 16:21:10 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Mon, Jul 22, 2019 at 10:10:35AM -0300, Mauro Carvalho Chehab wrote:
> > Mark Brown <broonie@kernel.org> escreveu:  
> 
> > > On Mon, Jul 22, 2019 at 08:07:31AM -0300, Mauro Carvalho Chehab wrote:  
> > > > While there's one file there with briefily describes the uAPI,
> > > > the documentation was written just like most subsystems: focused
> > > > on kernel developers. So, add it together with driver-api books.    
> 
> > > Please use subject lines matching the style for the subsystem.  This
> > > makes it easier for people to identify relevant patches.  
> 
> > Sure. Do you prefer this prefixed by:  
> 
> > 	spi: docs:  
> 
> > Or with something else?  
> 
> Anything starting with spi:

Ok.

> 
> > > >  Documentation/spi/{spidev => spidev.rst}      |  30 +++--    
> > > 
> > > This is clearly a userspace focused document rather than a kernel
> > > internal one.  
> > 
> > True. What I've been doing so far is, for all drivers that I'm converting
> > with carries more than one documentation type (kABI, uABI and/or 
> > admin-guide) is to keep the directory as-is, adding them under
> > this section at Documentation/index.rst:

...

> > Btw, if you look at spidev file, it contains stuff for both
> > userspace-api:
> > 
> > 	"SPI devices have a limited userspace API, supporting basic half-duplex
> > 	 read() and write() access to SPI slave devices.  Using ioctl() requests,"  
> 
> > And for admin-guide:  
> 
> > 	"For a SPI device with chipselect C on bus B, you should see:
> > 
> > 	    /dev/spidevB.C ... character special device, major number 153 with
> > 		a dynamically chosen minor device number. "  
> 
> I think that split is higly artificial...
> 
> > So, if we're willing to move it, the best is to do on a separate patch
> > with would split its contents into two files: admin-guide/spi-devices.rst and 
> > userspace-api/spi-api.rst.  
> 
> ...
> 
> > Ideally, we should split what's there at media/uapi into admin-guide
> > and userspace-api, but this would mean *a lot* of efforts. Not sure
> > if it is worth the effort.  
> 
> Is the admin/API stuff even sensible for things that are more embedded
> or desktop focused?  

Yes. Btw, the plan is to add everything under Documentation/ABI at the
admin guide (parsed via some scripts).

> It feels very arbatrary and unhelpful for things
> like spidev where theuser is going to be writing a program.

I tend to agree with you. Doing such split may actually make things
worse for app developers, without providing much benefit for sysadmins.

I sent today an e-mail to the KS discussion ML about that, as, IMHO,
this is something that we should discuss at the Documentation track
there.

While the idea of having users/sysadmin-faced stuff at admin-guide
seems to be nice, doing it for driver-specific stuff could be overkill,
and will mean a lot of extra work.

Thanks,
Mauro
