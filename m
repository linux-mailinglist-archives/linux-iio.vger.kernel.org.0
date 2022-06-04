Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522C053D7EC
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiFDQoS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiFDQoR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC35BE14
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C13760EDE
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A5C385B8;
        Sat,  4 Jun 2022 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654361054;
        bh=SKhUTh5zdzCFOBOIuQ+afsvo2Wl7hIx1kZRvLIc0c+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WdwcieQBBX+CbqrR3wAgnWy7mthFHaekj3+0uXjKznX67bgzZb1F29EAuwG+WOTj5
         ssZPSe5ggQ+AbCpW3OHLtFONT5U22a6ETF4vOCcO1ykZJ0ziD6+zIcTixbPvpBgVXA
         fSYcFhMmOjp+w9/9/c2nnsm/vpnQD7Ew8DbJimb6cz0sRncbBqNcTwqTmSIJRublV8
         oivT1DcfK8fojT4Xwwuw2KZIM3sdjrvYAeooSR4NCZ3MsiCds1YIkKrTEgDbwK/k8E
         9/qpaQyo07/zhGm1TRBqqBu9ZNjGgmnIaDgRdwn9BXduVthD7OdhgdLDzOGJE8l3Yr
         U7OPG0FgQ1TXw==
Date:   Sat, 4 Jun 2022 17:53:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     Alexandru Lazar <alazar@startmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 00/92] IIO: Fix alignment of buffers for DMA
Message-ID: <20220604175308.2f8d1abe@jic23-huawei>
In-Reply-To: <20220508175712.647246-1-jic23@kernel.org>
References: <20220508175712.647246-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  8 May 2022 18:55:40 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

+CC Greg as a heads up.

So I had a little debate with myself on 'how' to apply these and in the
end decided to take the slow path on the basis:

1) We haven't actually had a bug report and the problem is only known to
   be relevant directly to a very small set of platforms (those QC Kryo parts).
   (I've also so far not applied a Stable cc).

2) I'm nervous about such wide spread changes touching many drivers going
   in as fixes.

3) Churn and resulting delay to normal patch flow given this will create
   noise in a lot of drivers.

Anyhow, for now applied to the togreg branch of iio.git which I've pushed
out as testing for 0-day to play with it.  I'll almost certainly rebase that
branch of rc1 once available rather than it's current base of where Linus'
tree was when I started today (which happened to have char-misc merged).

All comments welcome as for a few days at least it's easy to modify how
these go upstream.

Thanks (particularly to Nuno for going through all these!),

Jonathan

p.s. I'll get around to the same fixes for the few drivers still in staging
 sometime in next few weeks.


> 
> Changes since v1:
> - Rename IIO_ALIGN to more specific IIO_DMA_MINALIGN
> - Fix a few patch descriptions (wrong drive names and such like)
> - Fixed a bunch of typos in the intro text in this email (I clearly
>   forgot to spell check that!)
> - Stopped removing 'to' in some comment updates. The English is fine either
>   way and this reduces the patch set size.
> - Pick up tags (thanks all!)
> 
> A few bits of feedback I haven't acted on:
> - Use of a general kernel define with a generic name. ARCH_DMA_MINALIGN
>   isn't yet available on all architectures, so the use of IIO_DMA_MINALIGN
>   provides a good path to fix this now in a fashion that can be easily
>   back ported.
> - Adding a define for __aligned(IIO_DMA_MINALIGN). I think that
>   such a define would obscure what was going a little. I couldn't think
>   of a reason we'd want to add anything else across all these locations
>   (which is the other reason we might want such a define).
> - Dropping some unnecessary marking of second buffers. I left these alone
>   because explaining why they aren't needed would require additional
>   commentary and is a separate cleanup that can wait for another time.#
> 
> Many years ago, IIO started using ____cacheline_aligned to ensure
> that buffers that might be used for DMA were not sharing a cacheline
> with other data that might lead to DMA safety issues.
> 
> As it turns out, that was fine at the time, but not based on the
> correct alignment requirement (though I believe it was a conservative
> choice at the time).  Note that on many architectures this was introducing
> unnecessary padding.  We should have been using ARCH_KMALLOC_MINALIGN
> as other subsystems such as crypto have done for a long time.
> 
> Patch 1 description contains more information but in short, there are
> ARM64 SoCs out their that have a larger cacheline size for caches beyond
> L1. In many cases they maintain coherency for all DMA devices attached
> and so this isn't a problem, but there are exceptions that do not.
> 
> So, this is a rather large patch set and just covers those drivers
> that are in the last kernel release and in drivers/iio.
> 
> Many of these drivers are somewhat old so I haven't specifically
> cc'd anyone so will be relying on those kind enough to sanity check
> patches on drivers that are beyond their own.
> 
> Given there is ongoing discussion around reducing the alignment
> requirements where possible, I've adopted the existing IIO_ALIGN
> define throughout.  That way we have a single point to update if
> that becomes relevant in future.
> 
> Cc: catalin.marinas@arm.com
> 
> Jonathan Cameron (92):
>   iio: core: Fix IIO_ALIGN and rename as it was not sufficiently large
>   iio: accel: adxl313: Fix alignment for DMA safety
>   iio: accel: adxl355: Fix alignment for DMA safety
>   iio: accel: adxl367: Fix alignment for DMA safety
>   iio: accel: bma220: Fix alignment for DMA safety
>   iio: accel: bmi088: Fix alignment for DMA safety
>   iio: accel: sca3000: Fix alignment for DMA safety
>   iio: accel: sca3300: Fix alignment for DMA safety
>   iio: adc: ad7266: Fix alignment for DMA safety
>   iio: adc: ad7280a: Fix alignment for DMA safety
>   iio: adc: ad7292: Fix alignment for DMA safety
>   iio: adc: ad7298: Fix alignment for DMA safety
>   iio: adc: ad7476: Fix alignment for DMA safety
>   iio: adc: ad7606: Fix alignment for DMA safety
>   iio: adc: ad7766: Fix alignment for DMA safety
>   iio: adc: ad7768-1: Fix alignment for DMA safety
>   iio: adc: ad7887: Fix alignment for DMA safety
>   iio: adc: ad7923: Fix alignment for DMA safety
>   iio: adc: ad7949: Fix alignment for DMA safety
>   iio: adc: hi8435: Fix alignment for DMA safety
>   iio: adc: ltc2496: Fix alignment for DMA safety
>   iio: adc: ltc2497: Fix alignment for DMA safety
>   iio: adc: max1027: Fix alignment for DMA safety
>   iio: adc: max11100: Fix alignment for DMA safety
>   iio: adc: max1118: Fix alignment for DMA safety
>   iio: adc: max1241: Fix alignment for DMA safety
>   iio: adc: mcp320x: Fix alignment for DMA safety
>   iio: adc: ti-adc0832: Fix alignment for DMA safety
>   iio: adc: ti-adc084s021: Fix alignment for DMA safety
>   iio: adc: ti-adc108s102: Fix alignment for DMA safety
>   iio: adc: ti-adc12138: Fix alignment for DMA safety
>   iio: adc: ti-adc128s052: Fix alignment for DMA safety
>   iio: adc: ti-adc161s626: Fix alignment for DMA safety
>   iio: adc: ti-ads124s08: Fix alignment for DMA safety
>   iio: adc: ti-ads131e08: Fix alignment for DMA safety
>   iio: adc: ti-ads7950: Fix alignment for DMA safety
>   iio: adc: ti-ads8344: Fix alignment for DMA safety
>   iio: adc: ti-ads8688: Fix alignment for DMA safety
>   iio: adc: ti-tlc4541: Fix alignment for DMA safety
>   iio: addac: ad74413r: Fix alignment for DMA safety
>   iio: amplifiers: ad8366: Fix alignment for DMA safety
>   iio: common: ssp: Fix alignment for DMA safety
>   iio: dac: ad5064: Fix alignment for DMA safety
>   iio: dac: ad5360: Fix alignment for DMA safety
>   iio: dac: ad5421: Fix alignment for DMA safety
>   iio: dac: ad5449: Fix alignment for DMA safety
>   iio: dac: ad5504: Fix alignment for DMA safety
>   iio: dac: ad5592r: Fix alignment for DMA safety
>   iio: dac: ad5686: Fix alignment for DMA safety
>   iio: dac: ad5755: Fix alignment for DMA safety
>   iio: dac: ad5761: Fix alignment for DMA safety
>   iio: dac: ad5764: Fix alignment for DMA safety
>   iio: dac: ad5766: Fix alignment for DMA safety
>   iio: dac: ad5770r: Fix alignment for DMA safety
>   iio: dac: ad5791: Fix alignment for DMA saftey
>   iio: dac: ad7293: Fix alignment for DMA safety
>   iio: dac: ad7303: Fix alignment for DMA safety
>   iio: dac: ad8801: Fix alignment for DMA safety
>   iio: dac: ltc2688: Fix alignment for DMA safety
>   iio: dac: mcp4922: Fix alignment for DMA safety
>   iio: dac: ti-dac082s085: Fix alignment for DMA safety
>   iio: dac: ti-dac5571: Fix alignment for DMA safety
>   iio: dac: ti-dac7311: Fix alignment for DMA safety
>   iio: dac: ti-dac7612: Fix alignment for DMA safety
>   iio: frequency: ad9523: Fix alignment for DMA safety
>   iio: frequency: adf4350: Fix alignment for DMA safety
>   iio: frequency: adf4371: Fix alignment for DMA safety
>   iio: frequency: admv1013: Fix alignment for DMA safety
>   iio: frequency: admv1014: Fix alignment for DMA safety
>   iio: frequency: admv4420: Fix alignment for DMA safety
>   iio: frequency: adrf6780: Fix alignment for DMA safety
>   iio: gyro: adis16080: Fix alignment for DMA safety
>   iio: gyro: adis16130: Fix alignment for DMA safety
>   iio: gyro: adxrs450: Fix alignment for DMA safety
>   iio: gyro: fxas210002c: Fix alignment for DMA safety
>   iio: imu: fxos8700: Fix alignment for DMA safety
>   iio: imu: inv_icm42600: Fix alignment for DMA safety
>   iio: imu: inv_icm42600: Fix alignment for DMA safety in buffer code.
>   iio: imu: mpu6050: Fix alignment for DMA safety
>   iio: potentiometer: ad5110: Fix alignment for DMA safety
>   iio: potentiometer: ad5272: Fix alignment for DMA safety
>   iio: potentiometer: max5481: Fix alignment for DMA safety
>   iio: potentiometer: mcp41010: Fix alignment for DMA safety
>   iio: potentiometer: mcp4131: Fix alignment for DMA safety
>   iio: pressure: dlhl60d: Drop unnecessary alignment forcing.
>   iio: proximity: as3935: Fix alignment for DMA safety
>   iio: proximity: vcnl3020: Drop unnecessary alignment requirement for
>     i2c device
>   iio: resolver: ad2s1200: Fix alignment for DMA safety
>   iio: resolver: ad2s90: Fix alignment for DMA safety
>   iio: temp: ltc2983: Fix alignment for DMA safety
>   iio: temp: max31865: Fix alignment for DMA safety
>   iio: temp: maxim_thermocouple: Fix alignment for DMA safety
> 
>  drivers/iio/accel/adxl313_core.c                   |  2 +-
>  drivers/iio/accel/adxl355_core.c                   |  2 +-
>  drivers/iio/accel/adxl367.c                        |  2 +-
>  drivers/iio/accel/adxl367_spi.c                    |  8 +++++---
>  drivers/iio/accel/bma220_spi.c                     |  2 +-
>  drivers/iio/accel/bmi088-accel-core.c              |  2 +-
>  drivers/iio/accel/sca3000.c                        |  4 ++--
>  drivers/iio/accel/sca3300.c                        |  2 +-
>  drivers/iio/adc/ad7266.c                           |  4 ++--
>  drivers/iio/adc/ad7280a.c                          |  2 +-
>  drivers/iio/adc/ad7292.c                           |  2 +-
>  drivers/iio/adc/ad7298.c                           |  2 +-
>  drivers/iio/adc/ad7476.c                           |  5 ++---
>  drivers/iio/adc/ad7606.h                           |  4 ++--
>  drivers/iio/adc/ad7766.c                           |  5 ++---
>  drivers/iio/adc/ad7768-1.c                         |  4 ++--
>  drivers/iio/adc/ad7887.c                           |  5 ++---
>  drivers/iio/adc/ad7923.c                           |  4 ++--
>  drivers/iio/adc/ad7949.c                           |  2 +-
>  drivers/iio/adc/adi-axi-adc.c                      |  7 ++++---
>  drivers/iio/adc/hi8435.c                           |  2 +-
>  drivers/iio/adc/ltc2496.c                          |  4 ++--
>  drivers/iio/adc/ltc2497.c                          |  4 ++--
>  drivers/iio/adc/max1027.c                          |  2 +-
>  drivers/iio/adc/max11100.c                         |  4 ++--
>  drivers/iio/adc/max1118.c                          |  2 +-
>  drivers/iio/adc/max1241.c                          |  2 +-
>  drivers/iio/adc/mcp320x.c                          |  2 +-
>  drivers/iio/adc/ti-adc0832.c                       |  2 +-
>  drivers/iio/adc/ti-adc084s021.c                    |  4 ++--
>  drivers/iio/adc/ti-adc108s102.c                    |  4 ++--
>  drivers/iio/adc/ti-adc12138.c                      |  2 +-
>  drivers/iio/adc/ti-adc128s052.c                    |  2 +-
>  drivers/iio/adc/ti-adc161s626.c                    |  2 +-
>  drivers/iio/adc/ti-ads124s08.c                     |  2 +-
>  drivers/iio/adc/ti-ads131e08.c                     |  2 +-
>  drivers/iio/adc/ti-ads7950.c                       |  4 ++--
>  drivers/iio/adc/ti-ads8344.c                       |  2 +-
>  drivers/iio/adc/ti-ads8688.c                       |  2 +-
>  drivers/iio/adc/ti-tlc4541.c                       |  4 ++--
>  drivers/iio/addac/ad74413r.c                       |  4 ++--
>  drivers/iio/amplifiers/ad8366.c                    |  4 ++--
>  drivers/iio/common/ssp_sensors/ssp.h               |  3 +--
>  drivers/iio/dac/ad5064.c                           |  4 ++--
>  drivers/iio/dac/ad5360.c                           |  4 ++--
>  drivers/iio/dac/ad5421.c                           |  4 ++--
>  drivers/iio/dac/ad5449.c                           |  4 ++--
>  drivers/iio/dac/ad5504.c                           |  2 +-
>  drivers/iio/dac/ad5592r-base.h                     |  4 +++-
>  drivers/iio/dac/ad5686.h                           |  6 ++++--
>  drivers/iio/dac/ad5755.c                           |  4 ++--
>  drivers/iio/dac/ad5761.c                           |  4 ++--
>  drivers/iio/dac/ad5764.c                           |  4 ++--
>  drivers/iio/dac/ad5766.c                           |  2 +-
>  drivers/iio/dac/ad5770r.c                          |  2 +-
>  drivers/iio/dac/ad5791.c                           |  2 +-
>  drivers/iio/dac/ad7293.c                           |  2 +-
>  drivers/iio/dac/ad7303.c                           |  4 ++--
>  drivers/iio/dac/ad8801.c                           |  2 +-
>  drivers/iio/dac/ltc2688.c                          |  4 ++--
>  drivers/iio/dac/mcp4922.c                          |  2 +-
>  drivers/iio/dac/ti-dac082s085.c                    |  2 +-
>  drivers/iio/dac/ti-dac5571.c                       |  2 +-
>  drivers/iio/dac/ti-dac7311.c                       |  2 +-
>  drivers/iio/dac/ti-dac7612.c                       |  4 ++--
>  drivers/iio/frequency/ad9523.c                     |  6 +++---
>  drivers/iio/frequency/adf4350.c                    |  6 +++---
>  drivers/iio/frequency/adf4371.c                    |  2 +-
>  drivers/iio/frequency/admv1013.c                   |  2 +-
>  drivers/iio/frequency/admv1014.c                   |  2 +-
>  drivers/iio/frequency/admv4420.c                   |  2 +-
>  drivers/iio/frequency/adrf6780.c                   |  2 +-
>  drivers/iio/gyro/adis16080.c                       |  2 +-
>  drivers/iio/gyro/adis16130.c                       |  2 +-
>  drivers/iio/gyro/adxrs450.c                        |  2 +-
>  drivers/iio/gyro/fxas21002c_core.c                 |  6 +++---
>  drivers/iio/imu/fxos8700_core.c                    |  2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  2 +-
>  drivers/iio/industrialio-core.c                    |  4 ++--
>  drivers/iio/potentiometer/ad5110.c                 |  4 ++--
>  drivers/iio/potentiometer/ad5272.c                 |  2 +-
>  drivers/iio/potentiometer/max5481.c                |  2 +-
>  drivers/iio/potentiometer/mcp41010.c               |  2 +-
>  drivers/iio/potentiometer/mcp4131.c                |  2 +-
>  drivers/iio/pressure/dlhl60d.c                     |  2 +-
>  drivers/iio/proximity/as3935.c                     |  2 +-
>  drivers/iio/proximity/vcnl3020.c                   |  4 ++--
>  drivers/iio/resolver/ad2s1200.c                    |  2 +-
>  drivers/iio/resolver/ad2s90.c                      |  2 +-
>  drivers/iio/temperature/ltc2983.c                  |  4 ++--
>  drivers/iio/temperature/max31865.c                 |  2 +-
>  drivers/iio/temperature/maxim_thermocouple.c       |  2 +-
>  include/linux/iio/iio.h                            | 10 ++++++++--
>  95 files changed, 151 insertions(+), 142 deletions(-)
> 

