Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE822320A28
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 13:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBUMBy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 07:01:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhBUMBv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 07:01:51 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2D664F03;
        Sun, 21 Feb 2021 12:01:09 +0000 (UTC)
Date:   Sun, 21 Feb 2021 12:01:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v3 0/6] iio: Add output buffer support
Message-ID: <20210221120106.00ae1078@archlinux>
In-Reply-To: <20210219124012.92897-1-alexandru.ardelean@analog.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Feb 2021 14:40:06 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Changelog v2 -> v3:
> * https://lore.kernel.org/linux-iio/20210217083438.37865-4-alexandru.ardelean@analog.com/T/#m396545e0c6cc9d58e17f4d79b6fc707fd0373d89
> * adding only infrastructure pieces for output DAC buffers, unfortunately I
>   couldn't finish a complete DAC change to showcase these changes

For that I wonder if the driver you did previously would work with the hrtimer
trigger (so just drop the pwm stuff).  Obviously we'd want someone to sanity
check that with the hardware.  An alternative (for now) would be to add
a simple example to the dummy driver.

I'm not keen to take this series without the user, but I'll review it on basis
we'll get that sorted fairly soon in some fashion.

Jonathan


> * patch 'iio: Add output buffer support'
>    - moved new 'bufferY/direction' attribute at the end and added
>      comment about what it should be added at the end
> * removed Lars' comment '/* need a way of knowing if there may be enough data... */'
> * updated some various formatting;
> 
> Alexandru Ardelean (1):
>   iio: triggered-buffer: extend support to configure output buffers
> 
> Lars-Peter Clausen (5):
>   iio: Add output buffer support
>   iio: kfifo-buffer: Add output buffer support
>   iio: buffer-dma: Allow to provide custom buffer ops
>   iio: buffer-dma: Add output buffer support
>   iio: buffer-dma: add support for cyclic DMA transfers
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   7 +
>  drivers/iio/accel/adxl372.c                   |   1 +
>  drivers/iio/accel/bmc150-accel-core.c         |   1 +
>  drivers/iio/adc/adi-axi-adc.c                 |   4 +-
>  drivers/iio/adc/at91-sama5d2_adc.c            |   4 +-
>  drivers/iio/buffer/industrialio-buffer-dma.c  | 120 ++++++++++++++--
>  .../buffer/industrialio-buffer-dmaengine.c    |  72 +++++++---
>  .../buffer/industrialio-triggered-buffer.c    |   8 +-
>  drivers/iio/buffer/kfifo_buf.c                |  50 +++++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
>  .../common/hid-sensors/hid-sensor-trigger.c   |   5 +-
>  drivers/iio/industrialio-buffer.c             | 133 +++++++++++++++++-
>  include/linux/iio/buffer-dma.h                |  11 +-
>  include/linux/iio/buffer-dmaengine.h          |   8 +-
>  include/linux/iio/buffer.h                    |   7 +
>  include/linux/iio/buffer_impl.h               |  11 ++
>  include/linux/iio/triggered_buffer.h          |  11 +-
>  include/uapi/linux/iio/buffer.h               |   1 +
>  18 files changed, 412 insertions(+), 43 deletions(-)
> 

