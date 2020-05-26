Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7D1E27B0
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEZQvP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 12:51:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbgEZQvP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 12:51:15 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C058E8417E6992E134A7;
        Tue, 26 May 2020 17:51:13 +0100 (IST)
Received: from localhost (10.47.89.183) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 26 May
 2020 17:51:13 +0100
Date:   Tue, 26 May 2020 17:50:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 07/25] iio:magnetometer:ak8975 Fix alignment and data
 leak issues.
Message-ID: <20200526175042.00001432@Huawei.com>
In-Reply-To: <20200526092415.GO1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-8-jic23@kernel.org>
        <20200526092415.GO1634618@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.89.183]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 12:24:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, May 25, 2020 at 06:06:10PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable structure in the iio_priv() data.  
> 
> I'm not sure I understood the issue in full.
> 
> s16 members are aligned on 2 bytes at least. Unaligned access easily to fix by
> moving from (int64_t *)... = ...; to put_unaligned(); in
> iio_push_to_buffers_with_timestamp() once for all.

The problem is that consumers of the buffer also need to know
that it's potentially unaligned.  So ultimately all consumers need
to then do a get_unaligned for the timestamp.

Note in some of these cases they would need to do a get_unaligned
for the channels as well.  So I think we are better off fixing all
these up and ensuring predictability. 

Moving to the heap here was just to avoid having to memset the thing
each time rather than the alignment issue.

> 
> On stack the driver allocates proper amount of data with padding.
> 
> > This data is allocated with kzalloc so no data can leak apart from
> > previous readings.
> > 
> > Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")  
> 
> Unfortunately breaks as per other patch review :-)
> 

Actually I think this one is coincidentally fine as we have 6 bytes of channels,
but see that other thread for why. + we'd still want to change the
code here to make that explicit.

Jonathan

