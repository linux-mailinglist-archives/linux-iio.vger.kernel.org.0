Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEE97D1DE7
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 17:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJUPb5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Oct 2023 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjJUPb4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2023 11:31:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F8211B
        for <linux-iio@vger.kernel.org>; Sat, 21 Oct 2023 08:31:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE424C433C8;
        Sat, 21 Oct 2023 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697902310;
        bh=02n/ZAnwwQdPRmdqxEyuMBdjzxsZo633LJmeXmUO7Ig=;
        h=Date:From:To:Subject:From;
        b=WV6PBKvqQsq42MhcAlKbD1HpF9kCwZgUSc3SEtSYjR338vr4brN9FIggTLSFW/7DP
         pEmn6QucMfaAt9I4RV3qiJQqgVCamAz+qqGPzGN28mQZfDWQrpiRdXaxwDYBO/+vp6
         +yHT8hAZBrm6go3X9jhrYlYEAgn5IA3/zDIQngwkVYj/QoLX/A09/bWNvkRf0C+4C0
         Dd1AbX6tNZn4trgnhIPLiSDTfrStOgjj9EZIubh+pBuiQu1QeErWMJYXK21fUObo/F
         Z8x52k5ihoE/AuKnXUGniHKhCWCS5mh9FKpA/8YJ5+9Q+N2r0KWBx4MCyokbx9nOir
         5ROg7ANM06lbg==
Date:   Sat, 21 Oct 2023 16:31:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of new drivers, features and cleanup for 6.7
Message-ID: <20231021163146.60deecaa@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 2399cde86e0f6bdbf26cadb83897f6d270921740:

  Merge tag 'counter-updates-for-6.7a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next (2023-10-20 08:34:47 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.7b

for you to fetch changes up to 89e2233386a5670d15908628b63e611cb03b0d03:

  iio: proximity: sx9324: Switch to device_property_match_property_string() (2023-10-20 08:26:41 +0100)

----------------------------------------------------------------
IIO: 2nd set of new device support, features and cleanup for 6.7

A few things that weren't quite ready for the previous pull but would
be nice to sneak into the 6.7 merge window if possible.

Includes a few generic firmware property helpers.

New device support
------------------
* bosch,bmi323
  - New driver supporting this 6 axis IMU
* maxim, max34408
  - New driver supporting the MAX34408 and MAX34409 current monitors.

Features
--------
* adi,ad2s1210 (additional stuff post move out of staging)
  - Add support for configurations where the mode pins on the chip are
    hardwired.
  - Add support for reset gpio usage at probe if the pin is wired.

Cleanup
-------
Firmware property related.
- Add fwnode_property_match_property_string() helper for when we
  a match against an element in an array of predefined strings is
  wanted.  Use this in adf4377, admv1014, tmag5273 and sx9324 IIO drivers.
- Use fwnode_property_string_array_count() within property.c instead
  of open coded variant.

----------------------------------------------------------------
Andy Shevchenko (6):
      device property: Use fwnode_property_string_array_count()
      device property: Add fwnode_property_match_property_string()
      iio: frequency: adf4377: Switch to device_property_match_property_string()
      iio: frequency: admv1014: Switch to device_property_match_property_string()
      iio: magnetometer: tmag5273: Switch to device_property_match_property_string()
      iio: proximity: sx9324: Switch to device_property_match_property_string()

David Lechner (2):
      iio: resolver: ad2s1210: add support for adi,fixed-mode
      iio: resolver: ad2s1210: add reset gpio support

Ivan Mikhaylov (2):
      dt-bindings: adc: provide max34408/9 device tree binding document
      iio: adc: Add driver support for MAX34408/9

Jagath Jog J (2):
      dt-bindings: iio: imu: Add Bosch BMI323
      iio: imu: Add driver for BMI323 IMU

 Documentation/ABI/testing/sysfs-bus-iio            |   18 +
 .../bindings/iio/adc/maxim,max34408.yaml           |  139 ++
 .../devicetree/bindings/iio/imu/bosch,bmi323.yaml  |   77 +
 MAINTAINERS                                        |    7 +
 drivers/base/property.c                            |   37 +-
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/max34408.c                         |  276 +++
 drivers/iio/frequency/adf4377.c                    |   16 +-
 drivers/iio/frequency/admv1014.c                   |   31 +-
 drivers/iio/imu/Kconfig                            |    1 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/bmi323/Kconfig                     |   33 +
 drivers/iio/imu/bmi323/Makefile                    |    7 +
 drivers/iio/imu/bmi323/bmi323.h                    |  209 ++
 drivers/iio/imu/bmi323/bmi323_core.c               | 2139 ++++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c                |  121 ++
 drivers/iio/imu/bmi323/bmi323_spi.c                |   92 +
 drivers/iio/magnetometer/tmag5273.c                |   10 +-
 drivers/iio/proximity/sx9324.c                     |   24 +-
 drivers/iio/resolver/ad2s1210.c                    |  162 +-
 include/linux/property.h                           |   12 +
 22 files changed, 3342 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
 create mode 100644 drivers/iio/adc/max34408.c
 create mode 100644 drivers/iio/imu/bmi323/Kconfig
 create mode 100644 drivers/iio/imu/bmi323/Makefile
 create mode 100644 drivers/iio/imu/bmi323/bmi323.h
 create mode 100644 drivers/iio/imu/bmi323/bmi323_core.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_i2c.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_spi.c
