Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9384E12995A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLWR3c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfLWR3c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:29:32 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE559206CB;
        Mon, 23 Dec 2019 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577122171;
        bh=OhBJDQuvvBQRwwpX9+apVAcfuyIsDuFNSzitpLw6gDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hGjGa7kn159KcoYs07EoVhDAvpjg/dCbpae9Snkz0JnwzGXuIfM5dXtQcHYK9IJtt
         pMRghJK2u/9o9OEeA2OESfb5tQ/ZLw2tIXWNlLUrCxDRMeGCWkSh4hixly/aRDw10v
         u2ey43L3MYnQm7acFUNXavlKy44Ap1/3k7jM0omg=
Date:   Mon, 23 Dec 2019 17:29:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: core: use debugfs_remove_recursive() on IIO unload
Message-ID: <20191223172927.1d7eee6f@archlinux>
In-Reply-To: <4728487938a37207f20cc5d4cb6fbbdd04f56358.camel@analog.com>
References: <20191211145903.22395-1-alexandru.ardelean@analog.com>
        <20191215162525.56516ce4@archlinux>
        <4728487938a37207f20cc5d4cb6fbbdd04f56358.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 07:43:30 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-12-15 at 16:25 +0000, Jonathan Cameron wrote:
> > [External]
> > 
> > On Wed, 11 Dec 2019 16:59:03 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > From: Lars-Peter Clausen <lars@metafoo.de>
> > > 
> > > The debugfs dir may have multiple files/dirs attached to it. Use
> > > debugfs_remove_recursive() to clean it up when the IIO module unloads.
> > > 
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > > 
> > > Note: note sure if this needs a Fixes tag. It's been in here for ages
> > > now,
> > >       so it may not be a big issue.  
> > 
> > There is some argument in favour of doing this as a defensive measure,
> > but
> > in current IIO debugfs directories are only created by drivers that call
> > (indirectly) iio_device_register_debugfs and those must call
> > (again indirectly) iio_device_unregister_debugfs which has called
> > the recursive free on everything in their directories.  So unless
> > something
> > very odd is going on this isn't a bug.
> > 
> > Am I missing something?  
> 
> So, I admit my note is open for interpretation.
> [ Rergarding the "Fixes" tag, I'm still not super-clear on when/why/how
> it's needed. I'll get there soon though. ]
> 
> This patch has been in our tree since 2012, and I'm not sure why it's using
> debugfs_remove_recursive() vs plain debugfs_remove().
> 
> I sometimes take a look at these old patches, try to make some sense of
> them and upstream them, or override them with the version of upstream code.
> My intent is to sync ADI code [for IIO] closer to upstream. Which would
> make it easier to track any divergence.
> 
> We're not seeing any bug with/without this.
> I guess my note about the "Fixes" tag may be a bit clumsy.
> 
> From my side, both debugfs_remove_recursive() & plain debugfs_remove() are
> fine.
I'd rather leave it be as it kind of avoids people thinking they can get away
without cleaning up properly at the higher levels.

Thanks,

Jonathan

> 
> Thanks
> Alex
> 
> > 
> >   
> > >  drivers/iio/industrialio-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/industrialio-core.c
> > > b/drivers/iio/industrialio-core.c
> > > index 9a3579943574..dab67cb69fe6 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -292,7 +292,7 @@ static void __exit iio_exit(void)
> > >  	if (iio_devt)
> > >  		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
> > >  	bus_unregister(&iio_bus_type);
> > > -	debugfs_remove(iio_debugfs_dentry);
> > > +	debugfs_remove_recursive(iio_debugfs_dentry);
> > >  }
> > >  
> > >  #if defined(CONFIG_DEBUG_FS)  

