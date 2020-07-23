Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6714C22AF67
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgGWMdD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 08:33:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbgGWMdD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Jul 2020 08:33:03 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B9AF7EFA9BF880261C92;
        Thu, 23 Jul 2020 13:33:02 +0100 (IST)
Received: from localhost (10.52.125.229) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Jul
 2020 13:33:02 +0100
Date:   Thu, 23 Jul 2020 13:31:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 19/27] iio:pressure:mpl3115 Force alignment of buffer
Message-ID: <20200723133142.00001b88@Huawei.com>
In-Reply-To: <CAHp75Ve6UAs+iryEgbcxW6FtbnmUAsV_MPJ7SiiCpkT5_O0xng@mail.gmail.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-20-jic23@kernel.org>
        <CAHp75Ve6UAs+iryEgbcxW6FtbnmUAsV_MPJ7SiiCpkT5_O0xng@mail.gmail.com>
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

On Thu, 23 Jul 2020 15:17:16 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > This one is unusual.  We have to do an explicit memset each time
> > as we are reading 3 bytes into a potential 4 byte channel which
> > may sometimes be a 2 byte channel depending on what is enabled.
> > As such, moving the buffer to the heap in the iio_priv structure
> > doesn't save us much.  We can't use a nice explicit structure
> > on the stack either as the data channels have different storage
> > sizes and are all separately controlled.  
> 
> I guess all non-standard cases (where no struct is applicable) deserve
> for better comment in the code.
> 

Sure can do that. I guess that will mean people actually think about
it whilst copying examples form old into new drivers.

In many ways the no struct applicable is the 'standard' case. It's
mere coincidence that in some drivers there are sufficiently few
channels that the struct 'trick' works.  All the other channels
are moving around even in those cases, it's just the timestamp
that happens to only have one valid location.

I'll probably do a v4 at the weekend.

Jonathan



