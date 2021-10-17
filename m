Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FC4309B3
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 16:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbhJQOYJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 10:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhJQOYJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 10:24:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4152260E74;
        Sun, 17 Oct 2021 14:21:56 +0000 (UTC)
Date:   Sun, 17 Oct 2021 15:26:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH v2 0/2] iio: buffer: allocation and freeing buffers fix
 and optimization
Message-ID: <20211017152611.13fb0357@jic23-huawei>
In-Reply-To: <20211013094923.2473-1-andriy.shevchenko@linux.intel.com>
References: <20211013094923.2473-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Oct 2021 12:49:21 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Yang submitted a fix, but I think the code can be refactored a bit to be more
> robust against similar mistakes in the future, if any.
> 
> In v2:
> - put SoB Yang's patch (it's good for backporting)
> - added refactoring patch on top of Yang's fix
> 
> Andy Shevchenko (1):
>   iio: buffer: Use dedicated variable in
>     iio_buffers_alloc_sysfs_and_mask()
> 
> Yang Yingliang (1):
>   iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
> 
>  drivers/iio/industrialio-buffer.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
1st patch applied to the fixes-togreg branch of iio.git. I may well end up
sending these in the merge window anyway in which case I'll probably stick patch 2
on top of it before sending.  If not I'll pick that up next cycle now.

Thanks,

Jonathan


