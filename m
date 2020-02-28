Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9B17383A
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 14:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgB1NYI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 08:24:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2479 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgB1NYI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Feb 2020 08:24:08 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E9AD13620E0E587DB714;
        Fri, 28 Feb 2020 13:24:05 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Feb 2020 13:24:05 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 13:24:05 +0000
Date:   Fri, 28 Feb 2020 13:24:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: query about locking in IIO
Message-ID: <20200228132402.00002d9e@Huawei.com>
In-Reply-To: <a644fc06b461361e6d6b001fe2e4e50dbaba6943.camel@analog.com>
References: <20200225171150.GD24663@SARKAR>
        <67108b1b3172e5f51d54a51fbe5a23c7ff4ce5ba.camel@analog.com>
        <5e56aa03.1c69fb81.3f3c3.8b05@mx.google.com>
        <a644fc06b461361e6d6b001fe2e4e50dbaba6943.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 06:58:11 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2020-02-26 at 22:55 +0530, Rohit Sarkar wrote:
> > [External]
> > 
> > On Wed, Feb 26, 2020 at 06:54:21AM +0000, Ardelean, Alexandru wrote:  
> > > On Tue, 2020-02-25 at 22:41 +0530, Rohit Sarkar wrote:  
> > > > Hi,
> > > > Could someone explain why using indio_dev->mlock directly is a bad idea?
> > > > Further examples of cases where it cannot be replaced will be helpful
> > > >   
> > > 
> > > Jonathan may add more here.
> > > 
> > > But in general, each driver should define it's own explicit lock if it needs
> > > to.
> > > Some drivers need explicit locking, some don't.
> > > 
> > > A lot of other frameworks already define locks already.
> > > Like, for example, when an IIO driver uses some SPI transfers, the SPI
> > > framework
> > > already uses some locks. So, you don't typically need extra locking; which
> > > for
> > > some IIO drivers translates to: no extra explicit locking.
> > > 
> > > I guess Jonathan also wants to move the mlock to be used only in the IIO
> > > framework.
> > > In some cases, if drivers use this mlock, and the framework uses it, you can
> > > end
> > > up trying to acquire the same mlock twice, which can end-up in a deadlock.
> > > These things can sometimes slip through the code-review.  
> > 
> > This makes sense
> >   
> > > I guess the docs need a bit of update.
> > > Because:
> > > 
> > > * @mlock:              [DRIVER] lock used to prevent simultaneous device
> > > state
> > > *                      changes
> > > 
> > > I think it should be converted to [INTERN]
> > >   
> > > > Thanks,
> > > > Rohit
> > > >   
> > 
> > As a follow up would I be right to assume that as long as the mlock is
> > not being in the IIO framework, explicit locking should be the way to
> > go?  
> 
> The question sounds a bit hard to follow.
> Each driver should define it's own locking if it needs it.
> mlock will continued to be used only in the IIO framework; it won't be removed.
> [INTERN] is just a marker in the doc-string to make sure people don't use
> these fields in drivers.

Yes.  That's basically it.  mlock is a framework internal lock and we may change
how it is implemented at any time.

Various drivers using it make any such changes impossible and are much harder to
reason about because the mlock uses in the core aren't visible within the
driver.

So basically its a software architecture problem rather than there being any
known bugs!

Thanks,

Jonathan

> 
> 
> > Thanks,
> > Rohit  


