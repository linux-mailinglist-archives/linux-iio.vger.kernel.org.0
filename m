Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869DFF094B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 23:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfKEW1A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 17:27:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37292 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbfKEW1A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 17:27:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so11023609pgu.4
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2019 14:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nV2PkaEhH0UdUJVKakWMfCCcbRmMl2heftuwVL9yV+0=;
        b=M9AkwTRelUiPLNUDpEPc6c6+EOiLOINKxvoV0NY4t3ReTUSUuewgqYC4Avg5v8140v
         IZIISgfGOMVDRT0iHbvvoH9F7i16ygqs7xRjSSZly6WY7vTdAblayuuDNmz0yx6ZLFZb
         dhV7zn3LAGHjzx+JUN6BXsk7I0apxWEU5w3hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nV2PkaEhH0UdUJVKakWMfCCcbRmMl2heftuwVL9yV+0=;
        b=QiLQo4p+h8cqgdKrzEiufJvmskciZ2zcKI1d+f2+YY7zXLktLtYwBp3E4hZtiOxQWZ
         al9IP9rz71e6Cm7lR0tqY8JMU90ArwFI4wFp7FosX/47p15Q2pzR4XOJ5WMPtW0HtfgY
         5pqpdQEtjGaW9zKMP5v3fj9GrnA1W8XbCpeh/fqTAo4lI92OYal1/N3ujJfgpwDMPZ4u
         ksDN4MYSAKFUEXqCY1qkQzimaoPAXrYeEUs7sTifRAj8pISOvg+QsipCcagdr52OtuoA
         FEt9hTpn91q6ZMEtatObhArB862mzxwDuweDNAkoWM1HzqPUOcR+ZPg67V2CKXMZm/2u
         L6TA==
X-Gm-Message-State: APjAAAXaP5iHVVYL/l2PmPNcTYWnKxFhjAqtx8PrRr06zwfPEqwaLFLd
        XxX1xCKQ+IMyvq+ehdx9FZb2IA==
X-Google-Smtp-Source: APXvYqzMp6Le4VpDyDLOdTXoRlDTkjARL4CNpAcezU3vCofbDMb+EEhYVpxKHwSNjmEbFlACFSO/Qg==
X-Received: by 2002:a63:e148:: with SMTP id h8mr1147388pgk.297.1572992819226;
        Tue, 05 Nov 2019 14:26:59 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y3sm9114754pgl.78.2019.11.05.14.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:26:58 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 00/17] cros_ec: Add sensorhub driver and FIFO processing
Date:   Tue,  5 Nov 2019 14:26:35 -0800
Message-Id: <20191105222652.70226-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
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

Gwendal Grignou (15):
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
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 363 +++++--
 drivers/iio/light/cros_ec_light_prox.c        |  21 +-
 drivers/iio/pressure/cros_ec_baro.c           |  14 +-
 drivers/input/keyboard/cros_ec_keyb.c         |   6 +-
 drivers/mfd/cros_ec_dev.c                     | 235 +----
 drivers/platform/chrome/Kconfig               |  12 +
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec.c             |  51 +-
 drivers/platform/chrome/cros_ec_ishtp.c       |  25 +-
 drivers/platform/chrome/cros_ec_lpc.c         |  17 +-
 drivers/platform/chrome/cros_ec_proto.c       | 198 +++-
 drivers/platform/chrome/cros_ec_rpmsg.c       |  19 +-
 drivers/platform/chrome/cros_ec_sensorhub.c   | 276 +++++
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 984 ++++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   | 104 +-
 include/linux/platform_data/cros_ec_proto.h   |  41 +-
 .../linux/platform_data/cros_ec_sensorhub.h   | 198 ++++
 21 files changed, 2073 insertions(+), 531 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
 create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

