Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461B344F42D
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhKMQln (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 11:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhKMQln (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 11:41:43 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D001760F38;
        Sat, 13 Nov 2021 16:38:49 +0000 (UTC)
Date:   Sat, 13 Nov 2021 16:43:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 00/13] iio: Use scan_type shift and realbits when
 processing raw data
Message-ID: <20211113164336.57f27801@jic23-huawei>
In-Reply-To: <20211104082413.3681212-1-gwendal@chromium.org>
References: <20211104082413.3681212-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  4 Nov 2021 01:24:00 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Using scan_type has source of truth, use shift and realbits instead of
> constants when processing reading sensor registers to produce raw sysfs
> entries.
> The same shit and realbits are already used by the libiio user-space
> library to present channel information from device buffer.
> 
> Fix only a handful of drivers, where channel scan_type was accessible
> in the function handling the raw data request.
> 
> In mpl3115, use a 16 bit big endian buffer when reading temperature
> channel to improve readability.

All but patch 8 applied.  There are outstanding questions about how to
handle that one as it happens to also be fixing a bug.

Applied to the togreg branch of iio.git and pushed out as testing until
the merge window is over and I can rebase on rc1.

Thanks,

Jonathan

> 
> Changes in v2:
> - Split first CL, one CL for each driver
> - Add realbit for sca3000 temperature channel
> - Remove constant in bma220 driver.
> 
> Gwendal Grignou (13):
>   iio: bma220: Use scan_type when processing raw data
>   iio: kxcjk-1013: Use scan_type when processing raw data
>   iio: mma7455: Use scan_type when processing raw data
>   iio: sca3000: Use scan_type when processing raw data
>   iio: stk8312: Use scan_type when processing raw data
>   iio: stk8ba50: Use scan_type when processing raw data
>   iio: ad7266: Use scan_type when processing raw data
>   iio: at91-sama5d2: Use scan_type when processing raw data
>   iio: ti-adc12138: Use scan_type when processing raw data
>   iio: mag3110: Use scan_type when processing raw data
>   iio: ti-ads1015: Remove shift variable ads1015_read_raw
>   iio: xilinx-xadc-core: Use local variable in xadc_read_raw
>   iio: mpl3115: Use scan_type.shift and realbit in mpl3115_read_raw
> 
>  drivers/iio/accel/bma220_spi.c     |  6 +++---
>  drivers/iio/accel/kxcjk-1013.c     |  3 ++-
>  drivers/iio/accel/mma7455_core.c   |  3 ++-
>  drivers/iio/accel/sca3000.c        | 17 +++++++++++++----
>  drivers/iio/accel/stk8312.c        |  2 +-
>  drivers/iio/accel/stk8ba50.c       |  3 ++-
>  drivers/iio/adc/ad7266.c           |  3 ++-
>  drivers/iio/adc/at91-sama5d2_adc.c |  3 ++-
>  drivers/iio/adc/ti-adc12138.c      |  3 ++-
>  drivers/iio/adc/ti-ads1015.c       |  8 +++-----
>  drivers/iio/adc/xilinx-xadc-core.c |  2 +-
>  drivers/iio/magnetometer/mag3110.c |  6 ++++--
>  drivers/iio/pressure/mpl3115.c     | 16 +++++++++++-----
>  13 files changed, 48 insertions(+), 27 deletions(-)
> 

