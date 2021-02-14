Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E631B0E3
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhBNPGF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 10:06:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhBNPGD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 10:06:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B3660200;
        Sun, 14 Feb 2021 15:05:20 +0000 (UTC)
Date:   Sun, 14 Feb 2021 15:05:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH 0/5] iio: kfifo: define a devm_iio_kfifo_buffer_setup
 helper
Message-ID: <20210214150516.785503e9@archlinux>
In-Reply-To: <20210214143313.67202-1-alexandru.ardelean@analog.com>
References: <20210214143313.67202-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Feb 2021 16:33:08 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This is a re-spin of an older set [1]:
>  https://patchwork.kernel.org/project/linux-iio/patch/20200401125936.6398-1-alexandru.ardelean@analog.com/
> 
> Patch 'iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()' is
> already be present in a fixes-togreg path. It did not make it yet
> downstream in the iio-togreg path.
> 
> Following [1], where there was a suggestion to name this
> 'devm_iio_device_attach_new_kfifo_buffer()', I took another look and
> devm_iio_kfifo_buffer_setup() made more sense, since there is already a
> '{devm_}iio_triggered_buffer_setup()' helper.
> 
> This reduces the usage of the iio_device_attach_buffer() helper to a
> more manage-able state.
> This is related to comment:
>   https://lore.kernel.org/linux-iio/CA+U=Dsp5hxd9=rNbigUMFALBpPVBqDZDRq_Pe69ggKak7p46=w@mail.gmail.com/T/#u
This definitely reduces where we need to handle errors from iio_device_attach_buffer() which
is good.  I guess we need a rebase of one or the other series though to make
this all fit together.

> 
> This should have gone before the multibuffer patch-set, but I was still
> waiting on patch 'iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()'
> to make it downstream in iio-togreg.

Oops. I've been a touch slow sending things onwards recently.

> 
> Regarding patch 'iio: kfifo: un-export devm_iio_kfifo_allocate() function'
> I would have also wanted to un-export iio_kfifo_allocate() &
> iio_kfifo_free(), but that still needs a bit of work to cleanup the IIO
> dummy buffer.

Yup. The lack of having a parent is a bit of pain.  We just need to fake one
I guess however silly that seems.

Mind you, I'd also like to see this go over to the triggered_buffer stuff
if possible.


> Related to patchset:
>   https://lore.kernel.org/linux-iio/20201203095005.72252-1-alexandru.ardelean@analog.com/
> 
> The IIO dummy driver seems to be one of those blockers in cleaning up
> some IIO API.
> 

Jonathan

> Alexandru Ardelean (5):
>   iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()
>   iio: kfifo: add devm_iio_kfifo_buffer_setup() helper
>   iio: make use of devm_iio_kfifo_buffer_setup() helper
>   iio: accel: sca3000: use devm_iio_kfifo_buffer_setup() helper
>   iio: kfifo: un-export devm_iio_kfifo_allocate() function
> 
>  .../driver-api/driver-model/devres.rst        |  2 +-
>  drivers/iio/accel/sca3000.c                   | 19 ++-------
>  drivers/iio/accel/ssp_accel_sensor.c          | 14 +++----
>  drivers/iio/adc/ina2xx-adc.c                  | 14 +++----
>  drivers/iio/adc/ti_am335x_adc.c               | 24 +++--------
>  drivers/iio/buffer/kfifo_buf.c                | 42 ++++++++++++++++++-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 13 +++---
>  drivers/iio/gyro/ssp_gyro_sensor.c            | 14 +++----
>  drivers/iio/health/max30100.c                 | 16 ++++---
>  drivers/iio/health/max30102.c                 | 16 ++++---
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 14 +++----
>  .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 13 +++---
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 15 +++----
>  drivers/iio/light/acpi-als.c                  | 12 +++---
>  drivers/iio/light/apds9960.c                  | 16 ++++---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 23 ++--------
>  include/linux/iio/kfifo_buf.h                 |  7 +++-
>  17 files changed, 125 insertions(+), 149 deletions(-)
> 

