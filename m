Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA683CC9B8
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhGRPPV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 11:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhGRPPU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 11:15:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371E1611AB;
        Sun, 18 Jul 2021 15:12:19 +0000 (UTC)
Date:   Sun, 18 Jul 2021 16:14:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 0/5] iio: accel: mma9551/mma9553 Cleanup and update
Message-ID: <20210718161443.72733cda@jic23-huawei>
In-Reply-To: <20210603185207.3646368-1-jic23@kernel.org>
References: <20210603185207.3646368-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Jun 2021 19:52:02 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi All,

This is a series I'd appreciate some more eyes on if anyone has the time
to spare!

Thanks,

Jonathan

> 
> v2: mma9551: Drop the gpio based irq support as not known to be used
>     and adds complexity which is nice to get rid of.
> 
> This series came about because I was looking to write a dt-binding for these
> two (currently missing entirely) and I discovered the mma9551 driver in
> particular was doing some unusual things.
> 
> Note however, I've only tested the fwnode_irq_get() patch using a hacked
> up version of QEMU and stubbing out some error paths because I'm too
> lazy to emulate it properly ;)
> 
> The ACPI entries seem unlikely, but please shout if anyone knows of
> them being used in the wild.
> 
> It would be particularly helpful if anyone who has either of these
> parts could both give this a spin and let me know so I can ask
> for testing in future.
> 
> Thanks,
> 
> Jonathan
> 
> Jonathan Cameron (5):
>   iio: accel: mma9551/mma9553: Drop explicit ACPI match support
>   iio: accel: mma9551/mma9553: Simplify pm logic
>   iio: accel: mma9551: Add support to get irqs directly from fwnode
>   iio: accel: mma9551: Use devm managed functions to tidy up probe()
>   iio: accel: mma9553: Use devm managed functions to tidy up probe()
> 
>  drivers/iio/accel/mma9551.c | 151 ++++++++++++------------------------
>  drivers/iio/accel/mma9553.c | 121 +++++++++--------------------
>  2 files changed, 85 insertions(+), 187 deletions(-)
> 

