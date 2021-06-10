Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F150D3A2C66
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFJNGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:06:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3195 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFJNGO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:06:14 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G13kk2wXFz6M4h3;
        Thu, 10 Jun 2021 20:51:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:04:16 +0200
Received: from localhost (10.52.126.112) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 14:04:15 +0100
Date:   Thu, 10 Jun 2021 14:04:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: core: Support removing extended name in
 attribute filename
Message-ID: <20210610140412.000054ac@Huawei.com>
In-Reply-To: <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
References: <20210610124556.34507-1-paul@crapouillou.net>
        <20210610124556.34507-2-paul@crapouillou.net>
        <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.112]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Jun 2021 15:58:51 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 10, 2021 at 3:47 PM Paul Cercueil <paul@crapouillou.net> wrote:
> >
> > By default, when a channel has an extended name, it will appear in the
> > filename of channel attributes. E.g. if the extended name is "aux", the
> > filename of a "sample_rate" attribute will be something like:
> > in_voltage0_aux_sample_rate
> >
> > Add a mechanism to disable this feature. This will be used to add a
> > "extended_name" channel attribute.  
> 
> I'm afraid, NAK. Otherwise, please put an explanation that clearly
> shows that it will be no ABI breakage.
> I.o.w. users for the existing drivers and devices will always get
> those attributes at the same platform configuration(s).
> 

What Andy said.  This was a bad design decision a long time back, but
we are stuck with it.

We have the _label attribute today that is the preferred route forwards
for new drivers but we can't touch the old ones however annoying it might
be.

Jonathan
