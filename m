Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C2CDE23
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 11:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfJGJVZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 05:21:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbfJGJVZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 05:21:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE3E5EBCD1E71597C0C;
        Mon,  7 Oct 2019 17:21:21 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 7 Oct 2019
 17:21:19 +0800
Date:   Mon, 7 Oct 2019 10:21:07 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: imu: adis16480: clean up a condition
Message-ID: <20191007102107.000067b6@huawei.com>
In-Reply-To: <20191006181439.GU22609@kadam>
References: <20190926081016.GA2332@mwanda>
        <9e40c550310d6f30e6481329e01061beb474bc33.camel@analog.com>
        <20190926113630.GF27389@kadam>
        <20191006095133.24fb89be@archlinux>
        <20191006181439.GU22609@kadam>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Oct 2019 21:14:40 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Sun, Oct 06, 2019 at 09:51:33AM +0100, Jonathan Cameron wrote:
> > On Thu, 26 Sep 2019 14:36:30 +0300
> > Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >   
> > > On Thu, Sep 26, 2019 at 11:06:39AM +0000, Ardelean, Alexandru wrote:  
> > > > On Thu, 2019-09-26 at 11:10 +0300, Dan Carpenter wrote:    
> > > > > [External]
> > > > > 
> > > > > The "t" variable is unsigned so it can't be less than zero.  We really
> > > > > are just trying to prevent divide by zero bugs so just checking against
> > > > > zero is sufficient.  
> > 
> > I'm not sure that true.  It if were signed we'd be detecting that the
> > input from userspace was negative.  
> 
> It does a really bad job of that though so it raises more questions than
> answers.  Maybe just one of the parameters is negative or maybe the
> multiply or the addition overflowed?  Should scenarios those be checked?
> 
> It turns out none of those situations matter, only divide by zero needs
> to be checked.

It isn't being nearly paranoid enough. Either val or val2 being
negative is a reason to fault out.  Divide by zero needs handling after
that.  Obviously divide by zero is the only one that causes a crash but
negatives are going to cause rather 'unexpected' results.

What fun.

Jonathan

