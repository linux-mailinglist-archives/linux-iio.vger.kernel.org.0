Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADD16AE44
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2020 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXSAJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 13:00:09 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbgBXSAJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Feb 2020 13:00:09 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 48F3698E909D9259F339;
        Mon, 24 Feb 2020 18:00:07 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 24 Feb 2020 18:00:06 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 18:00:06 +0000
Date:   Mon, 24 Feb 2020 18:00:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
CC:     <linux-iio@vger.kernel.org>,
        <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: IIO staging TODO
Message-ID: <20200224180003.00007d63@Huawei.com>
In-Reply-To: <20200223090609.GA5222@SARKAR>
References: <20200223090609.GA5222@SARKAR>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 23 Feb 2020 14:36:09 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Hey,
> I was going through the TODO in staging/iio.
> 
> "
> Convert all uses of the old GPIO API from <linux/gpio.h> to the
> GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
> lines from device tree, ACPI or board files, board files should
> use <linux/gpio/machine.h>.
> "
> 
> I couldn't find any usages of the old gpio API in iio staging. We can
> probably update the TODO to remove this item.

Cool. Patches to the TODO welcome :) I guess the last of these got killed off.

> 
> Was wondering if there is any other TODO/ low hanging fruit in IIO?

If you want to take a look at device tree bindings there is definitely work
to be done there.

* Missing binding docs for devices that are obviously used via device tree.
* Yaml conversions of abandoned drivers. 

I'd mostly like to leave actually doing yaml conversions of actively
maintained drivers to their maintainers but I suspect we have quite a few
where no one has touched them in years.

Another area is missing ABI documentation.

Reviewing if there is anything worth keeping in drivers/staging/iio/Documentation
and putting it in the right place if so is also useful.

For code related stuff, I suspect the remaining staging drivers are still
there for a reason (often a hard problem to be resolved).

One task we often ask people to look at is uses of iio_dev->mlock.
That lock should never be used directly but we were less than careful
about it in the early days of IIO so there are still a few instances
in drivers.  My max1363 driver for example :)

Moving to either a local lock, or to using the iio_claim_direct etc
functions to manage this in a race free way tidies this bit of implementation
mess up.  It requires careful analysis of 'what' the lock is there for and
patches need to state your conclusions on that clearly so others can
verify you are correct!

One thing to note is never send too many patches of the same type out
until you have reviews back.  It's too easy to have the same issue repeated
many times over, so better to send things out slower.

Thanks and good luck,

Jonathan

> 
> Thanks,
> Rohit


