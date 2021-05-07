Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9913E3762C8
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhEGJ0b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 05:26:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3036 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbhEGJ0b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 May 2021 05:26:31 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fc4Wp3Ps6z70gHy;
        Fri,  7 May 2021 17:14:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 11:25:17 +0200
Received: from localhost (10.52.124.175) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 May 2021
 10:25:16 +0100
Date:   Fri, 7 May 2021 10:23:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 16/19] iio: magn: bmc150: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210507102333.00004e07@Huawei.com>
In-Reply-To: <CACRpkdbYemUZCPwET4=dCGcJUfph3En+STtNphK8fbN0er1Z3Q@mail.gmail.com>
References: <20210501170121.512209-1-jic23@kernel.org>
        <20210501170121.512209-17-jic23@kernel.org>
        <CACRpkdbYemUZCPwET4=dCGcJUfph3En+STtNphK8fbN0er1Z3Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.175]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 May 2021 14:57:12 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, May 1, 2021 at 7:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > To make code more readable, use a structure to express the channel
> > layout and ensure the timestamp is 8 byte aligned.
> >
> > Found during an audit of all calls of uses of
> > iio_push_to_buffers_with_timestamp()
> >
> > Fixes: c91746a2361d ("iio: magn: Add support for BMC150 magnetometer")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Stephan Gerhold <stephan@gerhold.net>
> > Cc: Linus Walleij <linus.walleij@linaro.org>  
> 
> Excellent work Jonathan.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I wonder if there is some way for us to abstract this into the core so
> we can't get it wrong.

Abstracting is a bit of a pain, because we end up creating unnecessary
limitations on what can be done.  Often having buffer a lot larger than
it needs to be is sensible for example...

However, I'm definitely thinking we should look at what checks we can
add once all these cases are fixed and there might be a nice
pattern to use for those cases where we currently have a bounce buffer
anyway due to hardware restrictions.  In most others, moving to the pattern
where the timestamp is explicit in the structure makes it obvious (subject
to the fun question of x86_32 alignment and whether that matters - we don't
know of any bugs as a result but it's possible some buffer consumer will assume
8 byte alignment - hence the hardening in these cases).

The size being too small case for example should be easy - we just augment
iio_push_to_buffers_with_timestamp() to take the size and check it against
scan_bytes.  Alignment is trickier... 

Jonathan


> Yours,
> Linus Walleij

