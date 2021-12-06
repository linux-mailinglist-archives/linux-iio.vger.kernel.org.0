Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8182F46A3D8
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 19:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhLFSVv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 13:21:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57050 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244449AbhLFSVt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 13:21:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A5B5CCE1769
        for <linux-iio@vger.kernel.org>; Mon,  6 Dec 2021 18:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873DAC341C2;
        Mon,  6 Dec 2021 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638814697;
        bh=gPLiuC4sDQvqY7xh6J2FFZnBMVLBctYvzHUPULI8P7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcPrDmmNo8QASKPUrBmuxbbK9mMSiaD/IPRHmwTFX1yaiYJ2fzqrg1DmVgDJwgB9L
         aYWRcnVZVTyVn6wJcQL2vQC5k/MQAAAXsIFa5p7ovARJiSCh8uj16I3+vzf0H7hSFp
         jJcSVHfkPX84LCs5ZRqzK4TgHDa8VDVjIh3s80gsNF/gQxUo4vA6pUlPx92EhN1DCU
         hMPvCKLmjBoKaN1k8ubXq6mB9o4Q6sNF89AZOFD7tCjrQHNCyt/zsCfrEfdotvqz/i
         dL8qIFMHurJSY13u30NH/4yoCdUiWdFuEwMQRqHMbR9YfB4k6CK68ogaLqrOpeuDa7
         +LBRNwWv4NXfg==
Date:   Mon, 6 Dec 2021 11:18:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Baptiste Mansuy <bmansuy@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 00/12] IIO: clang W=1 warning cleanup.
Message-ID: <Ya5T5CMHn5hzzJy5@archlinux-ax161>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 28, 2021 at 05:24:33PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Hi All,
> 
> In the interests of noise reduction in warnings during build tests of
> new code, this series suppresses a bunch of warnings seen with
> LLVM=1 W=1.
> 
> Note I am seeing two others I haven't fixed here.  One is tied up in
> the existing CONFIG_PM* cleanup patch set and will be dealt with as
> part of that.  The other in tsl2772 looks like it might be a bug that
> needs further analysis. If anyone is curious:
> 
> drivers/iio/light/tsl2772.c:576:24: warning: variable 'prox_diode_mask' set but not used [-Wunused-but-set-variable]
>         int i, ret, num_leds, prox_diode_mask;     
> 
> As is common with series like this, some of the drivers are old
> and as such I haven't cc'd original authors etc and would appreciate
> a sanity check from anyone who has the time.
> 
> Mauro and Arnd are cc'd on a bunch of them because a media patch that
> I happened to see had similar fixes + discussion of type to use in the
> casting. For some others I've just picked on people who touched
> the driver in last year or so.
> 
> Nothing in this series should have any functional affect.
> 
> Jonathan

I build tested drivers/iio/ for arm, arm64, s390, and x86_64
allmodconfig and did not see any warnings other than the ones mentioned
in the commit message.

All the fixes look reasonable for the warnings.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Cc: Baptiste Mansuy <bmansuy@invensense.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> Jonathan Cameron (12):
>   iio:accel:bma180: Suppress clang W=1 warning about pointer to enum
>     conversion.
>   iio:dc:ina2xx-adc: Suppress clang W=1 warning about pointer to enum
>     conversion.
>   iio:adc:rcar: Suppress clang W=1 warning about pointer to enum
>     conversion.
>   iio:adc:ti-ads1015: Suppress clang W=1 warning about pointer to enum
>     conversion.
>   iio:amplifiers:hmc425a: Suppress clang W=1 warning about pointer to
>     enum conversion.
>   iio:dac:mcp4725: Suppress clang W=1 warning about pointer to enum
>     conversion.
>   iio:imu:inv_icm42600: Suppress clang W=1 warning about pointer to enum
>     conversion.
>   iio:imu:inv_mpu6050: Suppress clang W=1 warning about pointer to enum
>     conversion.
>   iio:magn:ak8975: Suppress clang W=1 warning about pointer to enum
>     conversion.
>   iio:dummy: Drop set but unused variable len.
>   iio:accel:bmc150: Mark structure __maybe_unused as only needed with
>     for pm ops.
>   iio:accel:kxcjk-1013: Mark struct __maybe_unused to avoid warning.
> 
>  drivers/iio/accel/bma180.c                      | 2 +-
>  drivers/iio/accel/bmc150-accel-core.c           | 2 +-
>  drivers/iio/accel/kxcjk-1013.c                  | 2 +-
>  drivers/iio/adc/ina2xx-adc.c                    | 2 +-
>  drivers/iio/adc/rcar-gyroadc.c                  | 3 +--
>  drivers/iio/adc/ti-ads1015.c                    | 2 +-
>  drivers/iio/amplifiers/hmc425a.c                | 2 +-
>  drivers/iio/dac/mcp4725.c                       | 2 +-
>  drivers/iio/dummy/iio_simple_dummy_buffer.c     | 2 --
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c       | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c       | 2 +-
>  drivers/iio/magnetometer/ak8975.c               | 2 +-
>  14 files changed, 13 insertions(+), 16 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
