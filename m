Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A921AFCA8
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 19:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDSR0G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 13:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDSR0G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 13:26:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4429A206D6;
        Sun, 19 Apr 2020 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587317165;
        bh=vKwicnR8zbQQcEPiIMWAAiMAvxvQ2n367njWGDA7hsE=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=Us8ELKKL0/BalFNGvNoSBDW4gR4xg8ReWzGHjo70cTcw2R4ytj3xLfqQ942BUT1e/
         R2aoekYqJdqbB1zTx/WJE20YAfNX7nsi26QWHSfgOsQNvdpdF9QvYoXauOhzGFyV+L
         y4ZAeYXZb+C0f/nKA5gZC54Wo1sDSkU0vnRhwJ1Y=
Date:   Sun, 19 Apr 2020 18:26:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for 5.7
Message-ID: <20200419182601.5bf20f77@archlinux>
In-Reply-To: <20200419182157.5ba79356@archlinux>
References: <20200419182157.5ba79356@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Greg,

Just a quick note to say there is a trivial merge conflict in MAINTAINERS
due to Linus sorting the file using the parse-maintainers script.

The resolution is fairly obvious but involves manually dropping
the line that ends up duplicated if you just grab the hunk from the
patch in here.

Note that patch is here as the large number of bounces people are getting
has lead to requests for me to hurry that one through.

Thanks as ever for your help,

Jonathan


On Sun, 19 Apr 2020 18:21:57 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit e681bb287f40e7a9dbcb04cef80fd87a2511ab86:
> 
>   staging: vt6656: Use DIV_ROUND_UP macro instead of specific code (2020-03-27 10:05:52 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.7a
> 
> for you to fetch changes up to 0f0459b8103835f75464db530a397da4d418b516:
> 
>   MAINTAINERS: remove Stefan Popa's email (2020-04-19 17:50:03 +0100)
> 
> ----------------------------------------------------------------
> First set of IIO fixes for the 5.7 cycle.
> 
> Includes one MAINTAINERS update to avoid people getting a lot of bounce
> messages and complaining about it.
> 
> * MAINTAINERS
>   - Drop Stefan Popa's Analog Devices email address in favour of
>     Michael Hennerich.
> * core
>   - Fix handling of dB sysfs inputs.
>   - Drop a stray semi colon in macro definition.
> * ad5770r
>   - Fix an off by one in chec on maximum number of channels.
> * ad7192
>   - Fix a null pointer de-reference due to the name previously being
>     retrieved from the spi_get_device_id call which no longer works as
>     the relevant table was removed.
> * ad7797
>   - Use correct attribute group.
> * counter/104-quad-8
>   - Add locks to prevent some race conditions.
> * inv-mpu6050
>   - Fix issues around suspend / resume clashing with runtime PM.
> * stm32-adc
>   - Fix sleep in invalid context
>   - Fix id relative path error in device tree binding doc.
> * st_lsm6dsx
>   - Fix a read alignment issue on an untagged FIFO.
>   - Handle odr for slave to properly compute the FIFO data layout / pattern.
>   - Flush the HW FIFO before resettting the device to avoid a race on
>     interrupt line 1.
> * st_sensors
>   - Rely on ODR mask not ODR address to identify if the ODR can be set.
>     Some devices have an ODR address of 0.
> * ti-ads8344
>   - Byte ordering was wrong - fix it.
> * xilinx-xadc
>   - Fix inverted logic in powering down the second ADC.
>   - Fix clearing interrupt when enabling the trigger.
>   - Fix configuration of sequencer when in simultaneous sampling mode.
>   - Limit initial sampling rate as done for runtime configured ones.
> 
> ----------------------------------------------------------------
> Alexandre Belloni (1):
>       iio: adc: ti-ads8344: properly byte swap value
> 
> Alexandru Ardelean (2):
>       iio: adc: ad7192: fix null pointer de-reference crash during probe
>       MAINTAINERS: remove Stefan Popa's email
> 
> Colin Ian King (1):
>       iio: dac: ad5770r: fix off-by-one check on maximum number of channels
> 
> Fabrice Gasnier (1):
>       dt-bindings: iio: adc: stm32-adc: fix id relative path
> 
> Jean-Baptiste Maneyrol (1):
>       iio: imu: inv_mpu6050: fix suspend/resume with runtime power
> 
> Lars Engebretsen (1):
>       iio: core: remove extra semi-colon from devm_iio_device_register() macro
> 
> Lars-Peter Clausen (4):
>       iio: xilinx-xadc: Fix ADC-B powerdown
>       iio: xilinx-xadc: Fix clearing interrupt when enabling trigger
>       iio: xilinx-xadc: Fix sequencer configuration for aux channels in simultaneous mode
>       iio: xilinx-xadc: Make sure not exceed maximum samplerate
> 
> Lary Gibaud (1):
>       iio: st_sensors: rely on odr mask to know if odr can be set
> 
> Lorenzo Bianconi (3):
>       iio: imu: st_lsm6dsx: fix read misalignment on untagged FIFO
>       iio: imu: st_lsm6dsx: specify slave odr in slv_odr
>       iio: imu: st_lsm6dsx: flush hw FIFO before resetting the device
> 
> Mircea Caprioru (1):
>       iio: core: Fix handling of 'dB'
> 
> Olivier Moysan (1):
>       iio: adc: stm32-adc: fix sleep in atomic context
> 
> Syed Nayyar Waris (1):
>       counter: 104-quad-8: Add lock guards - generic interface
> 
> YueHaibing (1):
>       iio:ad7797: Use correct attribute_group
> 
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   2 +-
>  MAINTAINERS                                        |  15 +-
>  drivers/counter/104-quad-8.c                       | 194 +++++++++++++++++----
>  drivers/iio/adc/ad7192.c                           |  63 +++++--
>  drivers/iio/adc/ad7793.c                           |   2 +-
>  drivers/iio/adc/stm32-adc.c                        |  31 +++-
>  drivers/iio/adc/ti-ads8344.c                       |   6 +-
>  drivers/iio/adc/xilinx-xadc-core.c                 |  95 +++++++---
>  drivers/iio/common/st_sensors/st_sensors_core.c    |   2 +-
>  drivers/iio/dac/ad5770r.c                          |   2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  11 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   3 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  23 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  24 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  29 ++-
>  drivers/iio/industrialio-core.c                    |   7 +-
>  include/linux/iio/iio.h                            |   2 +-
>  17 files changed, 400 insertions(+), 111 deletions(-)

