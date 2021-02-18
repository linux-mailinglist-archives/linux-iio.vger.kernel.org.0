Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392CE31EB92
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhBRP2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbhBRNkA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 08:40:00 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 837EB64E6F;
        Thu, 18 Feb 2021 13:38:08 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:38:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v2 0/5] iio: Add output buffer support
Message-ID: <20210218133804.60d7eca7@archlinux>
In-Reply-To: <20210217083438.37865-1-alexandru.ardelean@analog.com>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Feb 2021 10:34:33 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This patchset is based on the new multibuffer set.
> It doesn't require the high-speed/mmap interface.
> That will come later on a v2.
> 
> Changelog v1 -> v2:
> * https://lore.kernel.org/linux-iio/20210212102021.47276-4-alexandru.ardelean@analog.com/T/#u
> * removed DMA patches for now
> * in patch 'iio: Add output buffer support'
>   - added /sys/bus/iio/devices/iio:deviceX/bufferY/direction attribute
>   - thinking about this, an update to the new buffer infrastructure is
>     required when adding ADDAC/MxFE/transceivers; right now there is no
>     problem, because we have only ADCs and DACs; but when we get
>     transceivers, a bufferY/ directory needs to filter in/out
>     scan_elements/ ; this only occured to me recently (it's one of those
>     things that pops up later in mind)

For that we can rely on review in the short term, but agreed a sanity
check that everything matches would make sense.

> * added 'iio: Documentation: update definitions for bufferY and scan_elements'
>   - seems I forgot this on the original multibuffer patchset

Likewise. :)  Who needs docs?

> * added 'iio: triggered-buffer: extend support to configure output buffers'
>   - basically output triggered buffer support
> * added 'iio: dac: ad5686: Add PWM as a trigger source'
>   - this is a first user of this infrastructure
> 
> Alexandru Ardelean (2):
>   iio: Documentation: update definitions for bufferY and scan_elements
>   iio: triggered-buffer: extend support to configure output buffers
> 
> Lars-Peter Clausen (2):
>   iio: Add output buffer support
>   iio: kfifo-buffer: Add output buffer support
> 
> Mircea Caprioru (1):
>   iio: dac: ad5686: Add PWM as a trigger source
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  92 +++++++++++
>  drivers/iio/accel/adxl372.c                   |   1 +
>  drivers/iio/accel/bmc150-accel-core.c         |   1 +
>  drivers/iio/adc/at91-sama5d2_adc.c            |   4 +-
>  .../buffer/industrialio-triggered-buffer.c    |   8 +-
>  drivers/iio/buffer/kfifo_buf.c                |  50 ++++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
>  .../common/hid-sensors/hid-sensor-trigger.c   |   5 +-
>  drivers/iio/dac/ad5686-spi.c                  |   2 +-
>  drivers/iio/dac/ad5686.c                      | 146 +++++++++++++++++-
>  drivers/iio/dac/ad5686.h                      |   7 +-
>  drivers/iio/dac/ad5696-i2c.c                  |   2 +-
>  drivers/iio/industrialio-buffer.c             | 128 ++++++++++++++-
>  include/linux/iio/buffer.h                    |   7 +
>  include/linux/iio/buffer_impl.h               |  11 ++
>  include/linux/iio/triggered_buffer.h          |  11 +-
>  16 files changed, 459 insertions(+), 17 deletions(-)
> 

