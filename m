Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8184409A3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhJ3OrP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 10:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhJ3OrO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 10:47:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5E0660F4B;
        Sat, 30 Oct 2021 14:44:42 +0000 (UTC)
Date:   Sat, 30 Oct 2021 15:49:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v7 0/2] iio/scmi: Add reading "raw" attribute.
Message-ID: <20211030154911.78f5e6c3@jic23-huawei>
In-Reply-To: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Oct 2021 12:16:25 +0300
Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:

> Introduce IIO_VAL_INT_64 to read 64-bit value for
> channel attribute. Val is used as lower 32 bits.
> Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
> reading "raw" attribute in scmi_iio_read_raw.
> 
> Patches are based on v5.14.
> 
> Any comments are very welcome.
> 
> Thanks,
> Andriy.
> 
> Andriy Tryshnivskyy (2):
>   iio: core: Introduce IIO_VAL_INT_64.
>   iio/scmi: Add reading "raw" attribute.
> 
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
>  drivers/iio/industrialio-core.c            |  3 ++
>  include/linux/iio/types.h                  |  1 +
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f

Applied to the togreg branch of iio.git which is pushed out as testing for
0-day to poke at it and see what we missed.

Note this is next cycle material now given merge window is about to open.
As such I'll be rebasing my tree after rc1.

Thanks,

Jonathan
