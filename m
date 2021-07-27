Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B559C3D7786
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhG0NwI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 09:52:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3503 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhG0NwI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 09:52:08 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYyfS0xVXz6J6LZ;
        Tue, 27 Jul 2021 21:42:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:52:06 +0200
Received: from localhost (10.47.8.150) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Jul
 2021 14:52:06 +0100
Date:   Tue, 27 Jul 2021 14:51:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [PATCH 2/2] iio:adc:ad7124: Convert to fwnode handling of child
 node parsing.
Message-ID: <20210727145141.0000230d@Huawei.com>
In-Reply-To: <CAHp75VcgMkPw8BudKkF9MN2ijjDuT=VRo3FivVcjEYsEY4L-0w@mail.gmail.com>
References: <20210725172458.487343-1-jic23@kernel.org>
        <20210725172458.487343-3-jic23@kernel.org>
        <CAHp75VcgMkPw8BudKkF9MN2ijjDuT=VRo3FivVcjEYsEY4L-0w@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.150]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 25 Jul 2021 23:33:12 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jul 25, 2021 at 8:22 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Also use device_get_match_data() rather than of specific variant.
> > These changes enable use of this binding on ACPI platforms via PRP0001.
> > Whilst it's possible no one will ever do so, this is part of a general
> > effort to clear out examples from IIO that might be copied into new
> > drivers.
> >
> > It may appear that this change drops the check for status = disabled,
> > but in reality it does not because the of property code uses
> > of_get_next_available_child().  This driver may well fail to probe
> > if disabled is ever actually set though due to the need for
> > complete concurrent child nodes.  A future series might resolve
> > that restriction.  
> 
> Perhaps we need to have
> 
> ...
> 
> > +       device_for_each_child_node(dev, child)
> > +               st->num_channels++;
> > +  
> 
> device_get_child_node_count() ?
> 

Gah. Not sure how I missed that one when looking for it...

> ...
> 
> > -       for_each_available_child_of_node(np, child) {
> > +       device_for_each_child_node(dev, child) {  
> 
> Isn't this
>   fwnode_for_each_available_child_node()
> better to use?

Given we would be extracting the fwnode just to call this
loop, I'd say no, device version makes more sense..

> 
> ...
> 
> So the gaps I see are
>   device_get_available_child_node_count()
> and
>   device_for_each_available_child_node()

Do we then fix the fact that
device_for_each_child_node() will call the _available() form
for device tree?  That seems inconsistent currently and
I was assuming that was deliberate...

Jonathan


> 
> Both of them I think are easy to add and avoid possible breakage.
> 

