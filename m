Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A9722ADA0
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 13:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGWLY4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 07:24:56 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbgGWLYz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Jul 2020 07:24:55 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BE56941A084075BE5EA5;
        Thu, 23 Jul 2020 12:24:53 +0100 (IST)
Received: from localhost (10.52.125.229) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Jul
 2020 12:24:53 +0100
Date:   Thu, 23 Jul 2020 12:23:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v3 23/27] iio:adc:ti-ads124s08 Fix alignment and data
 leak issues.
Message-ID: <20200723122333.00000222@Huawei.com>
In-Reply-To: <CAHp75Vc5UiY1pBvyS=rQ1RjhVcDGNYgkVhvB6UB4kvuNg0a5CA@mail.gmail.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-24-jic23@kernel.org>
        <CAHp75Vc5UiY1pBvyS=rQ1RjhVcDGNYgkVhvB6UB4kvuNg0a5CA@mail.gmail.com>
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

On Wed, 22 Jul 2020 23:54:29 +0300
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
> > moving to a suitable structure in the iio_priv() data with alignment
> > explicitly requested.  This data is allocated with kzalloc so no
> > data can leak apart from previous readings.
> >
> > In this driver the timestamp can end up in various different locations
> > depending on what other channels are enabled.  As a result, we don't
> > use a structure to specify it's position as that would be missleading.  
> 
> ...
> 
> > +       /*
> > +        * Used to correctly align data.
> > +        * Ensure timestamp is naturally aligned.
> > +        */
> > +       u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);  
> 
> u32 vs. u16?
> 
Curious indeed.  My eyes jumped straight over that when cutting and
pasting that line.  I guess too big is never a problem, but should definitely
tidy that up.

Thanks,

Jonathan



