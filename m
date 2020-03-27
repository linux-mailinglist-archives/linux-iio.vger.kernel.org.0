Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E20196134
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgC0Weu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:34:50 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37996 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgC0Wet (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:49 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so4340043pje.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tHI92AzVcQSQD/O5A5HHGFkdI/p6OxDwwDw+5JnKm0=;
        b=Kv/dvlffhpd0NFV8xh9VkJRxc89AeOdti3ykzWw1en516Vwl4ZgKcaZBljAUTLkF2I
         0k/Z54XHn3tTdZuMhDi44wEOHNsp0Cbw6GLlb7keKfX9w5JZ0ZBKsQURABGZvxqKCac+
         7rm7Kci6u29qw1nu6QGB6TLNCilWIPjWW6+zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tHI92AzVcQSQD/O5A5HHGFkdI/p6OxDwwDw+5JnKm0=;
        b=bcwrXP/G4WKW8zOcSJcDu1XXqJulvC4Y+Uma03S27Np9TgYFRPW0Pbmf4Cnwwnni/G
         9sU2Sj6v7VB1dUvXA/hAbh+XeimOkkiFwBiD0TFLFO3HQfQKI1o2m16Mm4gJ4emyRwxE
         mNzpCtXDpWVVI/uBCris2nloNtJ2ZvuR0TTIuKztER1MoAIHNgSBJhgF6QHQksktEq5+
         46J8pJEofdWDOLJfCrLiIrY+MtDKHcL7qVa+vD3QITqNcRsD+ozz56IgrYN53EX7IRwy
         TGN7OIR0TXtnqnBqKRu1hj89hisbHDm1yrnBfq8hGLtF1S0briweldmNoB+gGSm7qWNF
         9CCg==
X-Gm-Message-State: ANhLgQ1sVMgEpXgjZTszWzJDurwhdGMJ+xYaouzz+WW1oZ7pcesM2Wjt
        eVg8VcV4Hg1/dzDaW+8Id5qfXQ==
X-Google-Smtp-Source: ADFU+vu1jv4HuYjns/KO7aUE3KuN3yMwVaojO02Y8Wlg8prhpyBcGC2UxqjS9FtT5dfNdu74v+YxyQ==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr1252937plt.184.1585348486602;
        Fri, 27 Mar 2020 15:34:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id u129sm4891895pfb.101.2020.03.27.15.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:45 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 00/12] Cros EC sensor hub FIFO support
Date:   Fri, 27 Mar 2020 15:34:31 -0700
Message-Id: <20200327223443.6006-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
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
                 |       cros-ec-sensorhub      |
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

The patch set allows the host to receive MEMS sensor sample
asynchronously from ChromeOS Emebedded Controller (EC).

Given the EC and the host are not synchronized, the timestamp generated
by the EC drifts and the AP interrupt latency adds variable delay.

When events arrive, the driver stores the time of the interrupt and use
that information to convert the timestamp from the EC time domain to the
AP time domain. To prevent the errors from the interrupt time variation,
a median filter smooth the timestamp generation and prevents timestamps
to go in the past.

When a batch of sensor events arrives, the sensor hub ring code spreads
the timestamps.

The buffer interaface is presentid through the IIO ABI.
And extra parameter - flush - (presents on HID and ST sensor hub implementation)
force the EC to send accumulated events in its queue, without waiting
for buffer hwfifo_timeout to expire.

To access sensor data, we can use iio_readdev like:
 iio_readdev -T 10000 -s 4 -b 2 iio:device4

When FIFO is not supported by the EC, a trigger is present in the
directory. After registering a trigger, setting sampling_frequency,
the latest data collected by the sensor will be retrieved by the host
when the trigger expires.

When cros_ec_accel_legacy driver is used, no FIFO is supported and the
sampling frequency for the accelerometers is hard coded at 10Hz.

Gwendal Grignou (12):
  platform: chrome: sensorhub: Add the number of sensors in sensorhub
  platform: chrome: sensorhub: Add FIFO support
  platform: chrome: sensorhub: Add code to spread timestmap
  platform: chrome: sensorhub: Add median filter
  iio: cros_ec: Move function description to .c file
  iio: expose iio_device_set_clock
  iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO
  iio: cros_ec: Remove pm function
  iio: cros_ec: Expose hwfifo_timeout
  iio: cros_ec: Report hwfifo_watermark_max
  iio: cros_ec: Use Hertz as unit for sampling frequency
  iio: cros_ec: flush as hwfifo attribute

 drivers/iio/accel/cros_ec_accel_legacy.c      |    8 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |    3 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |   13 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  403 +++++--
 drivers/iio/industrialio-core.c               |    8 +-
 drivers/iio/light/cros_ec_light_prox.c        |   15 +-
 drivers/iio/pressure/cros_ec_baro.c           |   14 +-
 drivers/platform/chrome/Makefile              |    4 +-
 drivers/platform/chrome/cros_ec_sensorhub.c   |  111 +-
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 1046 +++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   |  104 +-
 include/linux/iio/iio.h                       |    2 +
 .../linux/platform_data/cros_ec_sensorhub.h   |  163 +++
 13 files changed, 1655 insertions(+), 239 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c

-- 
2.26.0.rc2.310.g2932bb562d-goog

