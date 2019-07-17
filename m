Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FBC6BF72
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2019 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGQQHo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jul 2019 12:07:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbfGQQHn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Jul 2019 12:07:43 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60DD8B8A802AA8B28FB9;
        Thu, 18 Jul 2019 00:07:40 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 18 Jul 2019
 00:07:37 +0800
Date:   Wed, 17 Jul 2019 17:07:27 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 00/14] iio: SPDX headers for core + non device driver
 parts.
Message-ID: <20190717170727.00001363@huawei.com>
In-Reply-To: <20190622145516.3231-1-jic23@kernel.org>
References: <20190622145516.3231-1-jic23@kernel.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If anyone has time to sanity check these, it would be much appreciated.

At somepoint I'll take a view on them being too dull to garner review, but
I really don't like applying stuff that hasn't had a second set of eyes on it.

Thanks,

Jonathan

On Sat, 22 Jun 2019 15:55:02 +0100
<jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There is a general movement towards ensuring all of the kernel source
> files have SPDX headers.  I have previously expressed the view, that,
> like many cleanups it would be better to do these when otherwise touching
> the relevant part of the code, rather than creating noise throughout.
> 
> Time to change my mind on that, and push through adding these to IIO.
> 
> Even in the core code, I was less than entirely consistent with the
> existing license markings, so there are places where the file headers
> don't match with the MODULE_LICENSE macro.
> There were also headers that gained default SPDX license markings
> that actually aren't quite correct given the related c files sometimes
> did have well stated licenses.
> 
> If someone has time to check my logic on the these that would be great.
> 
> For the drivers, my intent is to use random periods of boredom
> (I'm on some long haul flights in the near future) to see if I can
> plough through them.  If anyone wants to get ahead of the game and
> do their own drivers that would be great.  This is particularly true
> in the big octopus drivers that spread throughout the IIO directories
> and beyond.  I'd love it if other people took those on.
> 
> If in doubt, don't do a given file or put out a clearly worded email
> to the list asking for help!
> 
> Jonathan Cameron (14):
>   iio: core: SPDX headers for core files. Note fix to MODULE_LICENSE
>   iio:configfs: SPDX headers.
>   iio: sw-device: SPDX headers
>   iio: sw-trigger: SPDX headers.
>   iio: triggered-event: Add SPDX and fix header license to match the
>     code.
>   iio:buffer-dma: SPDX headers.
>   iio: buffer-cb: SPDX headers
>   iio: kfifo-buf: Add SPDX header
>   iio: buffer-dmaengine: SPDX GPL-2.0+
>   iio: triggered-buffer: SPDX + fix MODULE_LICENSE to GPLv2
>   iio: trig-hrtimer: SPDX header GPLv2
>   iio: trig-interrupt: SPDX headers. GPLv2
>   iio: trig-loop: SPDX headers GPL-v2
>   iio: trig-sysfs: SPDX headers GPLv2.
> 
>  drivers/iio/buffer/industrialio-buffer-cb.c        |  8 +++-----
>  drivers/iio/buffer/industrialio-buffer-dma.c       |  3 +--
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  3 +--
>  drivers/iio/buffer/industrialio-triggered-buffer.c |  9 +++------
>  drivers/iio/buffer/kfifo_buf.c                     |  1 +
>  drivers/iio/iio_core.h                             |  8 +++-----
>  drivers/iio/iio_core_trigger.h                     |  2 +-
>  drivers/iio/industrialio-buffer.c                  |  8 +++-----
>  drivers/iio/industrialio-configfs.c                |  5 +----
>  drivers/iio/industrialio-core.c                    | 10 ++++------
>  drivers/iio/industrialio-event.c                   |  4 +++-
>  drivers/iio/industrialio-sw-device.c               |  5 +----
>  drivers/iio/industrialio-sw-trigger.c              |  5 +----
>  drivers/iio/industrialio-trigger.c                 |  8 +++-----
>  drivers/iio/industrialio-triggered-event.c         |  6 +-----
>  drivers/iio/inkern.c                               |  8 +++-----
>  drivers/iio/trigger/iio-trig-hrtimer.c             |  6 +-----
>  drivers/iio/trigger/iio-trig-interrupt.c           |  5 +----
>  drivers/iio/trigger/iio-trig-loop.c                |  3 +--
>  drivers/iio/trigger/iio-trig-sysfs.c               |  4 +---
>  include/linux/iio/buffer-dma.h                     |  3 +--
>  include/linux/iio/buffer-dmaengine.h               |  3 +--
>  include/linux/iio/buffer.h                         |  8 +++-----
>  include/linux/iio/configfs.h                       |  5 +----
>  include/linux/iio/consumer.h                       |  5 +----
>  include/linux/iio/driver.h                         |  5 +----
>  include/linux/iio/events.h                         |  8 +++-----
>  include/linux/iio/iio.h                            |  9 +++------
>  include/linux/iio/kfifo_buf.h                      |  2 +-
>  include/linux/iio/machine.h                        |  5 +----
>  include/linux/iio/sw_device.h                      |  5 +----
>  include/linux/iio/sw_trigger.h                     |  5 +----
>  include/linux/iio/sysfs.h                          | 10 ++++------
>  include/linux/iio/trigger.h                        |  5 +----
>  include/linux/iio/trigger_consumer.h               |  8 +++-----
>  include/linux/iio/triggered_event.h                |  2 +-
>  include/linux/iio/types.h                          |  8 +++-----
>  37 files changed, 67 insertions(+), 140 deletions(-)
> 


