Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99A5DE432
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 07:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfJUFyP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 01:54:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38781 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfJUFyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 01:54:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so6071736plq.5
        for <linux-iio@vger.kernel.org>; Sun, 20 Oct 2019 22:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmuwxAhHny5Bxddl2wSh3/iRStUxUdgRz5ebQs0ffAs=;
        b=bgj6Wo5YqV9LZUQ+dZT40Ds92N7Je9E19ECQFwZfcHqLQ8JG2U8OWYloBldX+l11Ex
         1ArQUOoCkx2ccjp+b1RspxwTQ6V7RaaWhs1+09gXus3NRF4kYuMnTJK8qjCSSJMSnUGD
         tfTvrQ72gC7j8ZGHE1QQH1+hzhaOHh+Curxfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmuwxAhHny5Bxddl2wSh3/iRStUxUdgRz5ebQs0ffAs=;
        b=nTVEbIQe0VWUmDVYfnaHQmF77jlyPyCenC3s0USX67s6nazMPhUwaLMoKjI/kMrp+R
         mwVSTgGy4djbflxHkRIILElSZK/KW4lPu8FZ53tnkuVR/j6UDxRdGeMUIRuHkc5Vm/m4
         EN8ia9S3F8/Yy3dkXiMa0+U3/5MEeX31CM6vfkgrzuanzkU7swUWTbsmFsaC9Ax2vlUe
         Gm9BKLZsDUYIF7SCTcnWExH+kE8RR7OmoYxvn4FAzBcCZrjUqwwA/zRF4YW78irbGz3+
         3uBiSTKomu49+3VQfO6IhX/T4xosovY7ZUOqpGE+5PbPcanoHJniGb3C1b2yQGnBSgmM
         V14A==
X-Gm-Message-State: APjAAAV8+i8/PcruaqKRUYuDk2KDE9Y0Mryv4tjHLHew6Y7SjnRaxJ1S
        5vDLwflTdD06NldghG0PAcB4Uw==
X-Google-Smtp-Source: APXvYqww+wuJMWctkjZd9ig8aBIyKel5rJnB1sOEFVxbXEVSynRio4At5dT6RRCpIm0K+SZ4TgLHwQ==
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr22541831plp.179.1571637252943;
        Sun, 20 Oct 2019 22:54:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id w2sm12870614pgr.78.2019.10.20.22.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:12 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 00/18] cros_ec: Add sensorhub driver and FIFO processing*** SUBJECT HERE
Date:   Sun, 20 Oct 2019 22:53:45 -0700
Message-Id: <20191021055403.67849-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
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
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 359 +++++--
 drivers/iio/light/cros_ec_light_prox.c        |  21 +-
 drivers/iio/pressure/cros_ec_baro.c           |  14 +-
 drivers/input/keyboard/cros_ec_keyb.c         |   6 +-
 drivers/mfd/cros_ec_dev.c                     | 235 +----
 drivers/platform/chrome/Kconfig               |  12 +
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec.c             |  80 +-
 drivers/platform/chrome/cros_ec_ishtp.c       |  25 +-
 drivers/platform/chrome/cros_ec_lpc.c         |  17 +-
 drivers/platform/chrome/cros_ec_proto.c       | 267 ++++-
 drivers/platform/chrome/cros_ec_rpmsg.c       |  23 +-
 drivers/platform/chrome/cros_ec_sensorhub.c   | 263 +++++
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 973 ++++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   | 106 +-
 include/linux/platform_data/cros_ec_proto.h   | 138 +--
 .../linux/platform_data/cros_ec_sensorhub.h   | 171 +++
 21 files changed, 2118 insertions(+), 632 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
 create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h

-- 
2.23.0.866.gb869b98d4c-goog

