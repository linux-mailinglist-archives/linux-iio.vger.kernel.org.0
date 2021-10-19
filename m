Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74904332D5
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhJSJvF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 05:51:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4002 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhJSJvF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 05:51:05 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HYTPC2xN7z67Cnk;
        Tue, 19 Oct 2021 17:45:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 11:48:50 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 10:48:49 +0100
Date:   Tue, 19 Oct 2021 10:48:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL V3] 1st set of IIO new device support, features and
 cleanup for  the 5.16 cycle
Message-ID: <20211019104848.00002a1f@Huawei.com>
In-Reply-To: <YW6TO7re7r9mR4Er@kroah.com>
References: <20211018192351.39245b42@jic23-huawei>
        <YW5v6OPgC84X73Qg@kroah.com>
        <20211019084227.475ecdb0@jic23-huawei>
        <YW6TO7re7r9mR4Er@kroah.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 11:43:23 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Oct 19, 2021 at 08:42:27AM +0100, Jonathan Cameron wrote:
> > On Tue, 19 Oct 2021 09:12:40 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Mon, Oct 18, 2021 at 07:23:51PM +0100, Jonathan Cameron wrote:  
> > > > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > > > 
> > > >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16a-split-take3    
> > > 
> > > Almost :(
> > > 
> > > I get the following error from my scripts:
> > > 
> > > Commit: 4862202a0171 ("dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add vid reg")
> > > 	Fixes tag: Fixes: 7e000fbff7a0 ("dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer")
> > > 	Has these problem(s):
> > > 	        - empty lines surround the Fixes tag
> > > 
> > > Also, there was a merge conflict in drivers/iio/adc/aspeed_adc.c, but
> > > that was easy for me to resolve.
> > > 
> > > thanks,
> > > 
> > > greg k-h  
> > 
> > Sigh.
> > 
> > The version of your scripts I have doesn't check for that particular one.
> > Anywhere I can get a newer version from?  
> 
> Sure, it's here:
> 	https://github.com/gregkh/gregkh-linux/blob/master/work/verify_fixes.sh
> and:
> 	https://github.com/gregkh/gregkh-linux/blob/master/work/verify_signedoff.sh

Thanks.  Hopefully that'll clean up my future pull requests.

Hopefully I'll get another one to you in a few days.

Thanks for putting up with my mess ups!

Jonathan

> 
> > V4 sent out. *crosses fingers*  Naturally the commit above was early
> > in the series so I had to fix all the other fixes tags again.  
> 
> Ick, sorry.  I'll go try that now...
> 
> greg k-h

