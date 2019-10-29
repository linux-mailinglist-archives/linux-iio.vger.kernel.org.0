Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F286EE8F36
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2019 19:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfJ2SZi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 29 Oct 2019 14:25:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfJ2SZi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Oct 2019 14:25:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4BFE16EC83704DE73A66;
        Wed, 30 Oct 2019 02:25:36 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 02:25:35 +0800
Date:   Tue, 29 Oct 2019 18:25:29 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 2/2] iio: adis16480: Add debugfs_reg_access entry
Message-ID: <20191029182529.00004f03@huawei.com>
In-Reply-To: <5a01de12c49f198d6d09b5e733225c6cc357f822.camel@analog.com>
References: <20191025124508.166648-1-nuno.sa@analog.com>
        <20191025124508.166648-2-nuno.sa@analog.com>
        <20191027163700.16d7d3f8@archlinux>
        <5a01de12c49f198d6d09b5e733225c6cc357f822.camel@analog.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Oct 2019 08:25:24 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> On Sun, 2019-10-27 at 16:37 +0000, Jonathan Cameron wrote:
> > On Fri, 25 Oct 2019 14:45:08 +0200
> > Nuno Sá <nuno.sa@analog.com> wrote:
> >   
> > > The driver is defining debugfs entries by calling
> > > `adis16480_debugfs_init()`. However, those entries are attached to
> > > the
> > > iio_dev debugfs entry which won't exist if no debugfs_reg_access
> > > callback is provided.
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>  
> > As you are respinning the first one and this is probably stable
> > material as well, please add a fixes tag for v2.
> > Thanks,
> >   
> 
> Will do that. Should I also cc Stable?
Nope, I'll add that once we are happy with it.  Otherwise they'll
get spammed with every version along the way.  They only need
to care once it hit's Linus' tree.

Thanks,

Jonathan
> 
> Thanks!
> Nuno Sá


