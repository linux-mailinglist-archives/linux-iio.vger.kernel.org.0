Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF20224BF3
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgGROmJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgGROmJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:42:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2D22064B;
        Sat, 18 Jul 2020 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595083328;
        bh=XBulFzLGPXfZn/iFjNwycrLQNdoeQbsMF6p0DhRyzB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e2S1JMVG2nQgwAIsMY2pN5uSL2c1YL0L29xSaNiqlsXGxFguOGEvAEUZqLIewKfXN
         sdECk/OMdmTCggnhXnJShrT5XusLlq8inAhWEIOpiwYrE1C2CtLYOOYw2QPZy2fUY8
         3S541EB0k/dqD2MGFEs8SFe9OT3SZ+5haRHViFvw=
Date:   Sat, 18 Jul 2020 15:42:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/30] First batch of W=1 fixes for IIO
Message-ID: <20200718154204.280fcb83@archlinux>
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:58:58 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
Thanks for these.

One general comment is I'd have appreciated a spot of grouping to bring
a particular group of identical problems together in the series.
Example being the @lock(:) ones in this set.

It doesn't matter that much though. I'm just being fussy :)

Jonathan

> 
> Lee Jones (30):
>   iio: adc: ad_sigma_delta: Remove unused variable 'ret'
>   iio: accel: bma220_spi: Do not define 'struct acpi_device_id' when
>     !CONFIG_ACPI
>   iio: common: ms_sensors: ms_sensors_i2c: Fix misspelling of parameter
>     'client'
>   iio: adc: ad7298: Demote obvious misuse of kerneldoc to standard
>     comment blocks
>   iio: chemical: sgp30: Add description for sgp_read_cmd()'s
>     'duration_us'
>   iio: adc: ad7923: Demote obvious misuse of kerneldoc to standard
>     comment blocks
>   iio: dac: ad5360: Fix kerneldoc attribute formatting for 'lock'
>   iio: dac: ad5380: Fix kerneldoc attribute formatting for 'lock'
>   iio: dummy: iio_simple_dummy: Demote unworthy kerneldocs and correct
>     misspelling
>   iio: dummy: iio_simple_dummy: Add newline after function-end
>   iio: dac: ad5421: Fix kerneldoc attribute formatting for 'lock'
>   iio: gyro: adis16080: Fix formatting issue and compiler attribute
>     ordering
>   iio: dummy: iio_simple_dummy_events: Demote file header and supply
>     descriptions for val2 params
>   iio: dac: ad5064: Value returned by ad5064_vref_name may not be 'const
>     * const'
>   iio: dummy: iio_dummy_evgen: Demote file header and supply description
>     for 'irq_sim_domain'
>   iio: adc: ad7887: Demote seemingly unintentional kerneldoc header
>   iio: adc: ad7949: Fix misspelling issue and compiler attribute
>     ordering
>   iio: dummy: iio_simple_dummy_buffer: Demote file header and correct
>     misspelling
>   iio: dac: ad5064: Fix a few kerneldoc misdemeanours
>   iio: dac: ad5446: Complete 'struct ad5446_state' doc and demote
>     unworthy kerneldocs
>   iio: dac: ad5449: Fix kerneldoc attribute formatting for 'lock'
>   iio: dac: ad5755: Fix kerneldoc attribute formatting for 'lock'
>   iio: dac: ad5758: Move and fix-up kerneldoc header and demote unworthy
>     kerneldoc
>   iio: dac: ad5761: Fix kerneldoc attribute formatting for 'lock'
>   iio: dac: ad5764: Fix misdocumenting and formatting error
>   iio: dac: ad5791: Complete 'struct ad5791_chip_info' documentation
>   iio: light: cm32181: Fix formatting and docrot issues in
>     cm32181_acpi_get_cpm()
>   iio: magnetometer: mmc35240: Fix function header formatting
>   iio: imu: kmx61: Fix formatting in kerneldoc function headers
>   iio: dac: ad7303: Complete 'struct ad7303_state' doc and reorder
>     compiler attribute
> 
>  drivers/iio/accel/bma220_spi.c                 |  2 ++
>  drivers/iio/adc/ad7298.c                       |  8 ++++----
>  drivers/iio/adc/ad7887.c                       |  2 +-
>  drivers/iio/adc/ad7923.c                       |  8 ++++----
>  drivers/iio/adc/ad7949.c                       |  4 ++--
>  drivers/iio/adc/ad_sigma_delta.c               |  7 ++-----
>  drivers/iio/chemical/sgp30.c                   |  1 +
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c |  2 +-
>  drivers/iio/dac/ad5064.c                       | 10 +++++-----
>  drivers/iio/dac/ad5360.c                       |  2 +-
>  drivers/iio/dac/ad5380.c                       |  2 +-
>  drivers/iio/dac/ad5421.c                       |  2 +-
>  drivers/iio/dac/ad5446.c                       | 11 +++++++----
>  drivers/iio/dac/ad5449.c                       |  2 +-
>  drivers/iio/dac/ad5755.c                       |  2 +-
>  drivers/iio/dac/ad5758.c                       | 18 +++++++++---------
>  drivers/iio/dac/ad5761.c                       |  2 +-
>  drivers/iio/dac/ad5764.c                       |  5 ++---
>  drivers/iio/dac/ad5791.c                       | 10 ++++------
>  drivers/iio/dac/ad7303.c                       |  5 ++++-
>  drivers/iio/dummy/iio_dummy_evgen.c            |  4 +++-
>  drivers/iio/dummy/iio_simple_dummy.c           |  7 ++++---
>  drivers/iio/dummy/iio_simple_dummy_buffer.c    |  4 ++--
>  drivers/iio/dummy/iio_simple_dummy_events.c    |  4 +++-
>  drivers/iio/gyro/adis16080.c                   |  4 ++--
>  drivers/iio/imu/kmx61.c                        | 14 +++++++-------
>  drivers/iio/light/cm32181.c                    |  8 ++++----
>  drivers/iio/magnetometer/mmc35240.c            |  4 ++--
>  28 files changed, 81 insertions(+), 73 deletions(-)
> 

