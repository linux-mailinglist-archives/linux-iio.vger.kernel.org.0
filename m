Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17A8E6A07
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfJ0XJu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:09:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34260 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfJ0XJu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:09:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so4525317pll.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZMQdP49SKSGCxikzk4IXXGYDDhTMLiJX9xeTkJggFM=;
        b=Agg48ZrqlsNLwomBNvDAFStDC4273KPi77NSUU3O6CRLoYpEbURn/nlCdk6NNqT443
         3AtvUVMxe7RYgYAoZTMwZdJfJgsDuqV6iIdvzXNBvOilFg5BcGSCC9A5FuOH1/kqAexe
         0xOf0b8+p/XIz7Wm0w4aG5lTNvFsyKb9sahHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZMQdP49SKSGCxikzk4IXXGYDDhTMLiJX9xeTkJggFM=;
        b=GWZyB4l8LNmFgC6rZRia/I3cYUPxvIbVTL1km+JLZOvklCDrHqs6vL1VSC/PlxZ4qM
         2y24KQbH2K6Wi09fQOw8b7LktWY5mn/Qx0us8453mkSHrZCjmyKIdinUEabRtSJ7FeJ/
         5GeEoOMAK0gY2Jj1HTi91hbi6/VrucXyuEuScqhT4nBCH/PS6p8AZZvO0dTy8o+gd350
         1BnWQgxqjAmQrq3zmVvfqAQRueAciqA+08gu4zYNAbjymikn817IZ3F955jqBqE2/JQ5
         RMRbcNc5Bfd+jEGaIvRjpzr7GJvg1IYDduksR3cTwVEiuRXa6jSUgrP8drjaFEuYyKga
         0PXw==
X-Gm-Message-State: APjAAAVPZsVOSpLVt0zfhFwAGZ11GVkY1ad/zViaLDXpfsUDmiMitBlh
        eTOW3ByzU87vXyDlFzxYv4wJMg==
X-Google-Smtp-Source: APXvYqy2IgOxLN+SoLyYZNs3CI53NfTDWcc/ByPFbQnu9ECHCeKRG4mkz4WCGBlfBKDtOtpXcI65KA==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr3851785plp.189.1572217789229;
        Sun, 27 Oct 2019 16:09:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j22sm3097568pff.42.2019.10.27.16.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:09:48 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 00/18] cros_ec: Add sensorhub driver and FIFO processing
Date:   Sun, 27 Oct 2019 16:09:03 -0700
Message-Id: <20191027230921.205251-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds a sensorhub driver for spreading sensor
events coming from the Embedded controller sensor FIFO:

       +---------------+ +--------------+ +----
       | cros_ec_accel | | cros_ec_gyro | | ...
       +---------------+ +--------------+ +----
           id:0       \        id:1 |       / id:..
                 +------------------------------+
                 |       cros_ec_sensorhub      |
                 +------------------------------+
                 |           cros_ec_dev        |
                 +------------------------------+
                 | cros_ec_i2c, cros_ec_lpc, .. |
                 +------------------------------+
                                 |
                                 EC

When new sensors events are present, the EC raises and interrupt,
sensorhub reads the FIFO and uses the 'id' field to spread the event to
the proper IIO sensors. This stack is similar to the HID sensor input
stack.

The first patch move cros_ec_proto functions documentations into the
code to prevent rot.

The inext 3 patches add a primitive cros_ec_sensorhub. MFD just have to
register this driver if at least one sensor is presented by the EC.
cros_ec_sensorhub retrieves more information from the EC to find out
which sensors are actually present:
  mfd: cros_ec: Add sensor_count and make check_features public
  platform: cros_ec: Add cros_ec_sensor_hub driver
  platform/mfd:iio: cros_ec: Register sensor through sensorhub

The next 3 patches prepare for FIFO support:
  platform: chrome: cros-ec: record event timestamp in the hard irq
  platform: chrome: cros_ec: Do not attempt to register a non-positive
  platform: chrome: cros_ec: handle MKBP more events flag

That last patch fixes a regression that changes event processing.
Revert the patches that fixed that regression.

The next 3 patches add FIFO support. An interface is added to connect
the IIO sensors with cros_ec_sensorhub, and filters are needed to spread
the timestamp when the EC send batches of events and deal with variation
in interrupt delay.
  platform: chrome: sensorhub: Add FIFO support
  platform: chrome: sensorhub: Add code to spread timestmap
  platform: chrome: sensorhub: Add median filter

The remaining patches update IIO cros_ec drivers:
The first patch moves cros_ec_sensor_core functions documentation into
the .c file.
Then we can use the FIFO function exposed by cros_ec_sensorhub:
  iio: cros_ec: Use triggered buffer only when EC does not support FIFO

The power management functions are not necessary anymore, since we
shutoff the FIFO from cros_ec_sensorhub:
  iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO

Finally, the last 3 patches present sensor information following the IIO
ABI:
-  Configurable EC timeout to allow batch mode in buffer/hwfifo_timeout,
  in seconds.
-  Hard coded EC FIFO size in buffer/hwfifo_watermark_max
-  Sensor sampling frequency in hertz at sampling_frequency:
  iio: cros_ec: Expose hwfifo_timeout
  iio: cros_ec: Report hwfifo_watermark_max
  iio: cros_ec: Use Hertz as unit for sampling frequency

For testing, libiio test tools can be used:
A iio device link looks like:
iio:device1 ->
...09:00/GOOG0004:00/cros-ec-dev.6.auto/cros-ec-sensorhub.7.auto/
                     cros-ec-accel.15.auto/iio:device1

When FIFO is available, no trigger are presented. Once
sampling_freqeuncy and hwfifo_timeout are set, sensor events flow
when listening to /dev/iio:device1:
echo 12 > sampling_frequency   # Set ODR to at least 12Hz
echo .100 > buffer/hwfifo_timeout  # do not wait more than 100ms to
                                   # to send samples
iio_readdev -b 2 -T 1000 -s 2 iio:device1 2>/dev/null| od -x
0000000 ffd0 2e20 d990 0000 8630 b56c 07ea 0000
0000020 ffc0 2e10 d970 0000 877e b56c 07ea 0000
0000040`

When FIFO is not supported by the EC, a trigger is present in the
directory. After registering a trigger, setting sampling_frequency,
the latest data collected by the sensor will be retrieved by the host
when the trigger expires.

When cros_ec_accel_legacy driver is used, no FIFO is supported and the
sampling frequency for the accelerometers is hard coded at 10Hz.

This set is built upon the master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Enrico Granata (2):
  platform: chrome: cros_ec: Do not attempt to register a non-positive
    IRQ number
  platform: chrome: cros_ec: handle MKBP more events flag

Gwendal Grignou (16):
  platform: chrome: Put docs with the code
  mfd: cros_ec: Add sensor_count and make check_features public
  platform: cros_ec: Add cros_ec_sensor_hub driver
  platform/mfd:iio: cros_ec: Register sensor through sensorhub
  platform: chrome: cros-ec: record event timestamp in the hard irq
  Revert "Input: cros_ec_keyb - add back missing mask for event_type"
  Revert "Input: cros_ec_keyb: mask out extra flags in event_type"
  platform: chrome: sensorhub: Add FIFO support
  platform: chrome: sensorhub: Add code to spread timestmap
  platform: chrome: sensorhub: Add median filter
  iio: cros_ec: Move function description to .c file
  iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO
  iio: cros_ec: Remove pm function
  iio: cros_ec: Expose hwfifo_timeout
  iio: cros_ec: Report hwfifo_watermark_max
  iio: cros_ec: Use Hertz as unit for sampling frequency

 drivers/iio/accel/cros_ec_accel_legacy.c      |  14 +-
 drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |   3 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  19 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 365 +++++--
 drivers/iio/light/cros_ec_light_prox.c        |  21 +-
 drivers/iio/pressure/cros_ec_baro.c           |  14 +-
 drivers/input/keyboard/cros_ec_keyb.c         |   6 +-
 drivers/mfd/cros_ec_dev.c                     | 235 +----
 drivers/platform/chrome/Kconfig               |  12 +
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec.c             |  79 +-
 drivers/platform/chrome/cros_ec_ishtp.c       |  25 +-
 drivers/platform/chrome/cros_ec_lpc.c         |  17 +-
 drivers/platform/chrome/cros_ec_proto.c       | 268 ++++-
 drivers/platform/chrome/cros_ec_rpmsg.c       |  19 +-
 drivers/platform/chrome/cros_ec_sensorhub.c   | 272 +++++
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 986 ++++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   | 105 +-
 include/linux/platform_data/cros_ec_proto.h   | 138 +--
 .../linux/platform_data/cros_ec_sensorhub.h   | 175 ++++
 21 files changed, 2147 insertions(+), 630 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
 create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h

-- 
2.23.0.866.gb869b98d4c-goog

