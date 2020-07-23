Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639AD22ADCC
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 13:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGWLbB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 07:31:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbgGWLbB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Jul 2020 07:31:01 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5E60A55E73338109DDD3;
        Thu, 23 Jul 2020 12:31:00 +0100 (IST)
Received: from localhost (10.52.125.229) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Jul
 2020 12:30:59 +0100
Date:   Thu, 23 Jul 2020 12:29:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: Re: [PATCH v3 10/27] iio:light:rpr0521 Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200723122939.000003f0@Huawei.com>
In-Reply-To: <CAHp75VcGDccaUwuyCBGhATTnFUEbXMw+=gq8Oe7jbYRcoArDyQ@mail.gmail.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-11-jic23@kernel.org>
        <CAHp75VcGDccaUwuyCBGhATTnFUEbXMw+=gq8Oe7jbYRcoArDyQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.229]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 22:47:46 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable structure in the iio_priv().  
> 
> > This data is allocated with kzalloc so no data can leak appart  
> 
> apart
> 
> > from previous readings and in this case the status byte from the device.
> >
> > The forced alignment of ts is not necessary in this case but it
> > potentially makes the code less fragile.  
> 
> ...
> 
> > +        * Note that the read will put garbage data into
> > +        * the padding but this should not be a problem  
> 
> > +               u8 garbage;  
> 
> >         err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
> > -               &buffer,
> > +               data->scan.channels,
> >                 (3 * 2) + 1);   /* 3 * 16-bit + (discarded) int clear reg. */  
> 
> But can't we read the interrupt clear register separately?
> 

Potentially though I have no idea if there is an odd quirk there. I'm not
immediately seeing anything on the datasheet about it.
Would need a tested-by from someone with hardware to confirm it is fine to
do it as two reads though.

Would be nice to get rid of the non standard handling so well worth
pursuing in v4 of this set.

Jonathan


