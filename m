Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12615F805E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 20:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKKTnD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 14:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfKKTnD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Nov 2019 14:43:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F35F20659;
        Mon, 11 Nov 2019 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573501381;
        bh=haxGbi3IawP+5qw/s9Z9lsdBxuD5C0b9O0fdMvA8aJE=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=FLnYy4oP6BcMQ1cflXFof9xIOn+ayOwfv2+3ANobI3wpDv15sViNtEE+s3+6ZD5dF
         Tz3mfqJotU/w2HTBtJDOTxu2l+WsKfz+LUK0x5Km0e8YTE+GXcwO+6GXvzo9fAegAy
         W7L4CUbdkc58L298EjptTLzJCcHCZgH2YsfJyQEA=
Date:   Mon, 11 Nov 2019 19:42:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] 3rd set of new device support, cleanups etc for IIO in
 the 5.5 cycle.
Message-ID: <20191111194249.5eb84282@archlinux>
In-Reply-To: <20191111193735.6c0e9472@archlinux>
References: <20191111193735.6c0e9472@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Greg,

Clearly this one is a bit late, but it seemed a shame to hold it given
Linus has been hinting at this cycle going a week longer than normal.

There are a few fixes in here, so if you decide its too late or something
else is wrong I'll pull them back out again for after the merge window.
None of them are urgent enough to be worth rushing in before the
merge window opens.

Thanks,

Jonathan

On Mon, 11 Nov 2019 19:37:35 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit f8be8d1ede50a5918faeda82e1f1fb45e9431b=
54:
>=20
>   staging: rts5208: Eliminate the use of Camel Case in file sd.h (2019-11=
-01 10:55:10 +0100)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-=
for-5.5c
>=20
> for you to fetch changes up to 4c35b7a51e2f291471f7221d112c6a45c63e83bc:
>=20
>   iio: adis16480: Add debugfs_reg_access entry (2019-11-11 18:38:13 +0000)
>=20
> ----------------------------------------------------------------
> Third set of IIO new device support cleanups and fixes for the 5.5 cycle.
>=20
> New device support
> * ad5446
>   - Support the ad5600 DAC (id only needed).
> * ad7292 ADC DAC etc
>   - New driver plus dt-bindings.
> * veml6030 ambient light sensor
>   - New driver plus dt-bindings and sysfs docs.
>=20
> Features
> * mpu6050
>   - Explicit VDD control.
> * stm32-adc
>   - Allow limiting of max clock frequency from devicetree to ensure it's
>     suitable for external circuitry.
>=20
> yaml binding conversions
> * ltc1660
> * mcp3911
>=20
> Fixes
> * adis16480
>   - Fix wrong scale factors.
>   - Fix debugfs reg access by providing the callback.
> * cros_ec_baro
>   - Fixing missing mask entry to make available sample frequencies visible
>     in sysfs.
> * st_lsm6dsx
>   - Explicitly handle different ODR table sizes.
>   - Handle restrictions between slave ODR and accel ODR when
>     both are enabled.
>   - Allow ODR to be expressed more accurately by using miliHz.
> * tools
>   - Fix an issue with parallel builds.
>=20
> Cleanups and warning fixes
> * adis16136, adis16400, adis16460, adis-lib
>   - Change some checks on return values to be for 0 rather than strictly
>     negative. Avoids some fiddly issues with the compiler concluding some
>     variables are initialized due to a mixture of error checks.
>   - Assign values only on success of 'read' operations - avoiding any
>     chance the compiler will falsly suggest they might be used uninitiali=
zed.
>   - Whitespace and simlar cleanups.
> * aspeed adc
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * bcm-iproc-adc
>   - Stray semicolon removal.
> * cc10001
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * dln2-adc
>   - Reorganise the buffered mode setup and tear down. Part of moving towa=
rds
>     being able to refactor this area of the IIO core.
> * hdc100x
>   - Reorganise the buffered mode setup and tear down.
> * ingenic-adc
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * lpc18xx-adc
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * lpc18xx-dac
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * mt6577
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * npcm
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * rcar-gyroadc
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * spear-adc
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * vf610-adc
>   - devm_platfom_ioremap_resource to reduce boilerplate.
> * vf610-dac
>   - devm_platfom_ioremap_resource to reduce boilerplate.
>=20
> ----------------------------------------------------------------
> Alexandru Ardelean (12):
>       iio: dln2-adc: fix iio_triggered_buffer_postenable() position
>       iio: hdc100x: fix iio_triggered_buffer_{predisable,postenable} posi=
tions
>       iio: gyro: adis16136: check ret val for non-zero vs less-than-zero
>       iio: imu: adis16400: check ret val for non-zero vs less-than-zero
>       iio: imu: adis16460: check ret val for non-zero vs less-than-zero
>       iio: imu: adis16480: check ret val for non-zero vs less-than-zero
>       iio: imu: adis: check ret val for non-zero vs less-than-zero
>       iio: imu: adis16480: fix indentation of return statement
>       iio: imu: adis16480: prefer `unsigned int` over `unsigned`
>       iio: imu: adis16480: assign bias value only if operation succeeded
>       iio: imu: adis: assign read val in debugfs hook only if op successf=
ul
>       iio: imu: adis: assign value only if return code zero in read funcs
>=20
> Fabrice Gasnier (2):
>       dt-bindings: iio: stm32-adc: add max clock rate property
>       iio: adc: stm32: allow to tune analog clock
>=20
> Gwendal Grignou (1):
>       iio: cros_ec_baro: set info_mask_shared_by_all_available field
>=20
> Jonathan Cameron (12):
>       iio: adc: aspeed: use devm_platform_ioremap_resource
>       iio: adc: mt6577_auxdac: use devm_platform_ioremap_resource
>       iio: adc: bcm_iproc_adc: drop a stray semicolon
>       iio: adc: cc10001: use devm_platform_ioremap_resource
>       iio: adc: ingenic: Use devm_platform_ioremap_resource
>       iio: adc: lpc18xx: use devm_platform_ioremap_resource
>       iio: adc: npcm: use devm_platform_ioremap_resource
>       iio: adc: rcar-gyroadc: use devm_platform_ioremap_resource
>       iio: adc: spear_adc: Use devm_platform_ioremap_resource
>       iio: adc: vf610: use devm_platform_ioremap_resource
>       iio: dac: lpc18xx: Use devm_platform_ioremap_resource
>       iio: dac: vf610: Use devm_platform_ioremap_resource
>=20
> Laura Abbott (1):
>       tools: iio: Correctly add make dependency for iio_utils
>=20
> Lorenzo Bianconi (3):
>       iio: imu: st_lsm6dsx: explicitly define odr table size
>       iio: imu: st_lsm6dsx: fix ODR check in st_lsm6dsx_write_raw
>       iio: imu: st_lsm6dsx: express odr in mHZ
>=20
> Marcelo Schmitt (2):
>       dt-bindings: iio: adc: Add dt-schema for AD7292
>       iio: adc: Add driver support for AD7292
>=20
> Marcus Folkesson (2):
>       dt-bindings: iio: dac: Migrate LTC1660 documentation to yaml
>       dt-bindings: iio: adc: Migrate MCP3911 documentation to yaml
>=20
> Nuno S=C3=A1 (2):
>       iio: adis16480: Fix scales factors
>       iio: adis16480: Add debugfs_reg_access entry
>=20
> Rishi Gupta (3):
>       iio: light: add driver for veml6030 ambient light sensor
>       dt-bindings: iio: light: add veml6030 ALS bindings
>       iio: documentation: light: Add veml6030 sysfs documentation
>=20
> Stefan Popa (1):
>       iio: dac: ad5446: Add support for new AD5600 DAC
>=20
> Stephan Gerhold (2):
>       dt-bindings: iio: imu: mpu6050: add vdd-supply
>       iio: imu: mpu6050: Add support for vdd-supply regulator
>=20
>  Documentation/ABI/testing/sysfs-bus-iio            |  11 +
>  .../devicetree/bindings/iio/adc/adi,ad7292.yaml    | 104 +++
>  .../devicetree/bindings/iio/adc/mcp3911.txt        |  30 -
>  .../bindings/iio/adc/microchip,mcp3911.yaml        |  71 ++
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   2 +
>  .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml  |  49 ++
>  .../devicetree/bindings/iio/dac/ltc1660.txt        |  21 -
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   1 +
>  .../devicetree/bindings/iio/light/veml6030.yaml    |  62 ++
>  MAINTAINERS                                        |  12 +-
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ad7292.c                           | 350 ++++++++
>  drivers/iio/adc/aspeed_adc.c                       |   4 +-
>  drivers/iio/adc/bcm_iproc_adc.c                    |   2 +-
>  drivers/iio/adc/cc10001_adc.c                      |   4 +-
>  drivers/iio/adc/dln2-adc.c                         |  20 +-
>  drivers/iio/adc/ingenic-adc.c                      |   4 +-
>  drivers/iio/adc/lpc18xx_adc.c                      |   4 +-
>  drivers/iio/adc/mt6577_auxadc.c                    |   4 +-
>  drivers/iio/adc/npcm_adc.c                         |   4 +-
>  drivers/iio/adc/rcar-gyroadc.c                     |   4 +-
>  drivers/iio/adc/spear_adc.c                        |   4 +-
>  drivers/iio/adc/stm32-adc-core.c                   |  16 +-
>  drivers/iio/adc/vf610_adc.c                        |   4 +-
>  drivers/iio/dac/Kconfig                            |   4 +-
>  drivers/iio/dac/ad5446.c                           |   6 +
>  drivers/iio/dac/lpc18xx_dac.c                      |   4 +-
>  drivers/iio/dac/vf610_dac.c                        |   4 +-
>  drivers/iio/gyro/adis16136.c                       |  24 +-
>  drivers/iio/humidity/hdc100x.c                     |  19 +-
>  drivers/iio/imu/adis.c                             |   5 +-
>  drivers/iio/imu/adis16400.c                        |  22 +-
>  drivers/iio/imu/adis16460.c                        |   8 +-
>  drivers/iio/imu/adis16480.c                        | 116 +--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  43 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   4 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   8 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   9 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 235 +++---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  45 +-
>  drivers/iio/light/Kconfig                          |  11 +
>  drivers/iio/light/Makefile                         |   1 +
>  drivers/iio/light/veml6030.c                       | 908 +++++++++++++++=
++++++
>  drivers/iio/pressure/cros_ec_baro.c                |   3 +
>  include/linux/iio/imu/adis.h                       |   6 +-
>  tools/iio/Build                                    |   1 +
>  tools/iio/Makefile                                 |  10 +-
>  48 files changed, 1955 insertions(+), 339 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.=
yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,m=
cp3911.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc166=
0.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.=
yaml
>  create mode 100644 drivers/iio/adc/ad7292.c
>  create mode 100644 drivers/iio/light/veml6030.c

