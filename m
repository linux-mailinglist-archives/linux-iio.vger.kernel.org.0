Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ABE258B00
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIAJIc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 05:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgIAJIc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Sep 2020 05:08:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B05F2083B;
        Tue,  1 Sep 2020 09:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598951311;
        bh=Thkxl8aw3GkQcxt2SVVjHBZqg6jCFBhKcBEA3gSDrPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaoS1mtLPSSGDXRMjpdLlME0dYE11lQKkR4WWBJ1bxvb6l4M57MXQRrsmNpv1S3yN
         lMwQiXJk0rhejHw+pKgE9iNj30vSHewv4pXds4zc1WIVDTkqwj8L81x2wmDZH/1kFX
         b0T8uv7tepvoZp1MRRm94sdMsg/E6FXS44uJQcfU=
Date:   Tue, 1 Sep 2020 11:08:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>, linux-iio@vger.kernel.org
Subject: Re: [iio:fixes-togreg 19/19] drivers/iio/adc/mcp3422.c:147:3-9:
 preceding lock on line 137 (fwd)
Message-ID: <20200901090859.GA148841@kroah.com>
References: <alpine.DEB.2.22.394.2008292228320.3629@hadrien>
 <CA+TH9VkAo4CgCVDGvQumfePvNCg9ffwEHbqic7TsYJn4VZ3aTw@mail.gmail.com>
 <alpine.DEB.2.22.394.2008310947020.2533@hadrien>
 <CA+TH9VmQq3=Kf=f72CSn2ZziKP3YP6qjsXQL1nXzS-O8FscBWw@mail.gmail.com>
 <20200901095041.0000279e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901095041.0000279e@Huawei.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 01, 2020 at 09:50:41AM +0100, Jonathan Cameron wrote:
> On Mon, 31 Aug 2020 11:09:53 +0200
> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
> 
> > Il giorno lun 31 ago 2020 alle ore 09:48 Julia Lawall
> > <julia.lawall@inria.fr> ha scritto:
> > >
> > >
> > >
> > > On Mon, 31 Aug 2020, Angelo Compagnucci wrote:
> > >  
> > > > Hi Julia,
> > > >
> > > > Il giorno sab 29 ago 2020 alle ore 22:29 Julia Lawall
> > > > <julia.lawall@inria.fr> ha scritto:  
> > > > >
> > > > > Please check whether there should be a mutex_unlock before line 147.  
> > > >
> > > > Having  a mutex_unlock before line 147 is wrong here, cause the lock
> > > > should be held for the entire reading operation. Adding an unlock
> > > > before the lock means that a concurrent call can unlock the lock
> > > > previously held by another call and the result ends up mixing the
> > > > reading for the first call to the reading of the second call.  
> > >
> > > OK, I don't know the calling context.  But you have a function where the
> > > lock is held on the failure path and is released on the success path,
> > > which seems at least a little strange.  
> > 
> > I see.
> > 
> > I have to respin!
> > 
> > Thanks for your support!
> Hi Julia, Angelo,
> 
> Please can we cc linux-iio@vger.kernel.org for such reports.
> The fix has headed upstream. So we need to chase it with a fix asap.
> 
> Greg, would you prefer a following fix (please cc Greg directly) or
> to revert the patch? 
> 
> 3f1093d83d71 ("iio: adc: mcp3422: fix locking scope")
> 
> Sorry I missed this one. Was working on wrong computer to access
> the account this went to.

A patch is always easier for me to apply than a revert is.

thanks,

greg k-h
