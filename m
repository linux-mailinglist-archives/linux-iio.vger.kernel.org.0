Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A3258C52
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 12:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgIAKGt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 06:06:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgIAKGt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Sep 2020 06:06:49 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 62181FA968FB6EDB2EAE;
        Tue,  1 Sep 2020 11:06:48 +0100 (IST)
Received: from localhost (10.52.122.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Sep 2020
 11:06:48 +0100
Date:   Tue, 1 Sep 2020 11:05:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        <linux-iio@vger.kernel.org>
Subject: Re: [iio:fixes-togreg 19/19] drivers/iio/adc/mcp3422.c:147:3-9:
 preceding lock on line 137 (fwd)
Message-ID: <20200901110512.00003e52@Huawei.com>
In-Reply-To: <20200901090859.GA148841@kroah.com>
References: <alpine.DEB.2.22.394.2008292228320.3629@hadrien>
        <CA+TH9VkAo4CgCVDGvQumfePvNCg9ffwEHbqic7TsYJn4VZ3aTw@mail.gmail.com>
        <alpine.DEB.2.22.394.2008310947020.2533@hadrien>
        <CA+TH9VmQq3=Kf=f72CSn2ZziKP3YP6qjsXQL1nXzS-O8FscBWw@mail.gmail.com>
        <20200901095041.0000279e@Huawei.com>
        <20200901090859.GA148841@kroah.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Sep 2020 11:08:59 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Sep 01, 2020 at 09:50:41AM +0100, Jonathan Cameron wrote:
> > On Mon, 31 Aug 2020 11:09:53 +0200
> > Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
> >   
> > > Il giorno lun 31 ago 2020 alle ore 09:48 Julia Lawall
> > > <julia.lawall@inria.fr> ha scritto:  
> > > >
> > > >
> > > >
> > > > On Mon, 31 Aug 2020, Angelo Compagnucci wrote:
> > > >    
> > > > > Hi Julia,
> > > > >
> > > > > Il giorno sab 29 ago 2020 alle ore 22:29 Julia Lawall
> > > > > <julia.lawall@inria.fr> ha scritto:    
> > > > > >
> > > > > > Please check whether there should be a mutex_unlock before line 147.    
> > > > >
> > > > > Having  a mutex_unlock before line 147 is wrong here, cause the lock
> > > > > should be held for the entire reading operation. Adding an unlock
> > > > > before the lock means that a concurrent call can unlock the lock
> > > > > previously held by another call and the result ends up mixing the
> > > > > reading for the first call to the reading of the second call.    
> > > >
> > > > OK, I don't know the calling context.  But you have a function where the
> > > > lock is held on the failure path and is released on the success path,
> > > > which seems at least a little strange.    
> > > 
> > > I see.
> > > 
> > > I have to respin!
> > > 
> > > Thanks for your support!  
> > Hi Julia, Angelo,
> > 
> > Please can we cc linux-iio@vger.kernel.org for such reports.
> > The fix has headed upstream. So we need to chase it with a fix asap.
> > 
> > Greg, would you prefer a following fix (please cc Greg directly) or
> > to revert the patch? 
> > 
> > 3f1093d83d71 ("iio: adc: mcp3422: fix locking scope")
> > 
> > Sorry I missed this one. Was working on wrong computer to access
> > the account this went to.  
> 
> A patch is always easier for me to apply than a revert is.

Great.  Angelo replied very quickly so you should have it now
(thanks Angelo!)

Thanks for your help.

Jonathan

> 
> thanks,
> 
> greg k-h


