Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9532B4696D4
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 14:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbhLFNZk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 08:25:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4209 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244369AbhLFNZk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 08:25:40 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J73vd4QbJz67Lkw;
        Mon,  6 Dec 2021 21:20:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 14:22:10 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 13:22:04 +0000
Date:   Mon, 6 Dec 2021 13:22:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 01/12] iio:dac:ad5755: Switch to generic firmware
 properties and drop pdata
Message-ID: <20211206132203.00006686@Huawei.com>
In-Reply-To: <CAHp75VenfEMhYjjst4VwZDorwr0Be6CBOH6zhciQSD1AmUbSTA@mail.gmail.com>
References: <20211205170140.2783914-1-jic23@kernel.org>
        <20211205170140.2783914-2-jic23@kernel.org>
        <CAHp75VenfEMhYjjst4VwZDorwr0Be6CBOH6zhciQSD1AmUbSTA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Dec 2021 22:09:36 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Dec 5, 2021 at 6:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Lars pointed out that platform data can also be supported via the
> > generic properties interface, so there is no point in continuing to
> > support it separately.  Hence squish the linux/platform_data/ad5755.h
> > header into the c file and drop accessing the platform data directly.
> >
> > Done by inspection only.  Mostly completely mechanical with the
> > exception of a few places where default value handling is
> > cleaner done by first setting the value, then calling the
> > firmware reading function but and not checking the return value,
> > as opposed to reading firmware then setting the default if an error
> > occurs.
> >
> > Part of general attempt to move all of IIO over to generic
> > device properties, both to enable other firmware types and
> > to remove drivers that can be the source of of_ specific
> > behaviour in new drivers.  
> 
> I was looking again into these enums thinking that it might be a good
> place for them in include/dr-bindings/ but after reading the schema I
> realized that they are rather encoded, while the schema is using
> decoded values. So, scratch this. But I have noticed one more thing
> (see below).
> 
> ...
> 
> >         devm_kfree(dev, pdata);
> >         return NULL;  
> 
> Sorry, haven't noticed this one, do we really need this devm_kfree() call?
> Shouldn't there be better error reporting then? (Note, it's just
> thoughts for further improvements).
>
I wondered about this.  The driver will currently successfully
probe with broken firmware and fall back to the defaults.

If we change that (and hence have this return an ERR_PTR() and fail
the probe) then we risk a regression if someone actually has a platform
with a firmware broken in this fashion.

The path that triggers this is when there are too many child nodes.

I'm tempted to say that supporting something that broken is beyond what
we should bother with and just drop this muddling on (as a follow up patch).
If anyone reports a regression as a result we can put it back again...

Jonathan
