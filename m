Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4436CA50
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhD0R0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236019AbhD0R0a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 13:26:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A936C61154;
        Tue, 27 Apr 2021 17:25:45 +0000 (UTC)
Date:   Tue, 27 Apr 2021 18:26:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 0/6] Adis IRQ fixes and minor improvements
Message-ID: <20210427182630.43d15ff0@jic23-huawei>
In-Reply-To: <20210427085454.30616-1-nuno.sa@analog.com>
References: <20210427085454.30616-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Apr 2021 10:54:48 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> The primary goal of this series was to fix the return value on some
> trigger handlers as spotted in [1]. While doing it, I found some minor
> improvements that I think are simple enough to include in this series.
> 
> As for the first 2 patches, I opted to not do any functional change so
> I'm keeping the 'if (!adis->buffer)' check. However, 'adis-buffer' is
> allocated in 'update_scan_mode' hook which means we should be sure that
> the buffer is allocated and the check is really not needed. I did not
> went into the details but is there any way for the trigger handler to be
> called before the 'update_scan_mode' hook? If not, I'm happy in sending
> a v2 where we just remove the 'if'...
> 
> 
> Changes in v2:
>  * Remove the 'if' check for the allocated buffer;
>  * Make sure the adis 'state_lock' is unlocked on error paths;
>  * Fixed the commit message on the first 3 patches.
>  * Dropped ("iio: adis16475: re-set max spi transfer") and added 3 new
> patches (last 3 in the series ) to fix a potential race with the spi core
> as discussed in [2].
> 
> Changes in v3:
>  * Improved commit description on ("iio: adis16475: do not return ints in
> irq handlers");
>  * Reordered patch 2 and 3 so that patch 3 is easier to apply;
>  * Re-arranged the error handling on 'spi_sync()' error path.
> 
> [1]: https://marc.info/?l=linux-iio&m=161815197426882&w=2
> [2]: https://marc.info/?l=linux-iio&m=161884696722142&w=2

Not rushing these in as not comfortable with marking them for stable.
If we want to do a specific stable request at a later date that can
easily explain we need all of them.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at them and see if they can find anything we
missed.

Thanks,

Jonathan

> 
> Nuno Sa (6):
>   iio: adis16475: do not return ints in irq handlers
>   iio: adis_buffer: update device page after changing it
>   iio: adis_buffer: don't push data to buffers on failure
>   iio: adis: add burst_max_speed_hz variable
>   iio: adis16475: do not directly change spi 'max_speed_hz'
>   iio: adis16400: do not directly change spi 'max_speed_hz'
> 
>  drivers/iio/imu/adis16400.c   | 15 ++-------------
>  drivers/iio/imu/adis16475.c   |  9 +++------
>  drivers/iio/imu/adis_buffer.c | 16 ++++++++++------
>  include/linux/iio/imu/adis.h  |  2 ++
>  4 files changed, 17 insertions(+), 25 deletions(-)
> 

