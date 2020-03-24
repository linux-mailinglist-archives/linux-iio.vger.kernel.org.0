Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831DF191AE7
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 21:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCXU1r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 16:27:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33253 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgCXU1r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 16:27:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id g18so7906539plq.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW77brf4/DB30Av5/e9eE1qVytMveWFMmosb2tkTGWQ=;
        b=MilKqsOYHxMM3hcJiRdIJYCR5wQNd2azNK6VJjgdydP7wFNNzjefP9LTdY8KwJxOQ8
         E59j8XE/zByx2tDz4vQF9htOPX7Ak1d7unlY+m7L0c1W+X9fyYlxs1iuJFThW8MhHOfH
         pMM4PifelTHaL9Fn1UNwzrofPZKaQx2NnH64U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW77brf4/DB30Av5/e9eE1qVytMveWFMmosb2tkTGWQ=;
        b=uj99nS2JDggADmIWWl51C/5ACZ6YVlukHHO4qIYb19iAWWU3TJX+KSnw5Se2+5jdB9
         2NcvQJoE1xXmUEBybzUCNONAhqCcsNt9FT9KE3WQ+OB9gGoXAE36w/Pl9ARvlIwysppW
         6KtWSae+dQ1XfpBiwjAjUO/Bi/aP4QCi23X8QV15d0G9BKrRyB1sKelRII0BhgchFAyq
         wxEmuS+WHDAiCeK16obfWL5ZIFspuGJumAlHazj5KJUrdtmIHCTqhsBprhPiRn49zE0m
         uFtsEqLBZP++LVOVTUiFnLvvHBz6B+f6SAR0cQ4R8BNQj2y5sWMddhfQAiXz9JpHK6qU
         +2GA==
X-Gm-Message-State: ANhLgQ3C7xn6WmT4R9xeN1EQBn09LozGIDzM4F9XK05wRe+nkKy8BvUM
        UEtskAFeryCYCWv5N6I9NkvU/Q==
X-Google-Smtp-Source: ADFU+vuaRhlr2ACZb+PkHDJQkmA31Q5nXWsygxXXlJNW4AfPt9CFfRx0dc76oFs1wS0cK2VzS55pCQ==
X-Received: by 2002:a17:902:463:: with SMTP id 90mr29726944ple.213.1585081664593;
        Tue, 24 Mar 2020 13:27:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id g81sm16558739pfb.188.2020.03.24.13.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:27:43 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 00/11] Cros EC sensor hub FIFO support
Date:   Tue, 24 Mar 2020 13:27:25 -0700
Message-Id: <20200324202736.243314-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
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
And extra parameter - flush - (presents on HID and ST sensor hub
implementation) force the EC to send accumulated events in its queue,
without waiting for buffer hwfifo_timeout to expire.

To access sensor data, we can use iio_readdev like:
 iio_readdev -T 10000 -s 4 -b 2 iio:device4

When FIFO is not supported by the EC, a trigger is present in the
directory. After registering a trigger, setting sampling_frequency,
the latest data collected by the sensor will be retrieved by the host
when the trigger expires.

When cros_ec_accel_legacy driver is used, no FIFO is supported and the
sampling frequency for the accelerometers is hard coded at 10Hz.

Gwendal Grignou (11):
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
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  404 +++++--
 drivers/iio/industrialio-core.c               |    8 +-
 drivers/iio/light/cros_ec_light_prox.c        |   15 +-
 drivers/iio/pressure/cros_ec_baro.c           |   14 +-
 drivers/platform/chrome/Makefile              |    4 +-
 drivers/platform/chrome/cros_ec_sensorhub.c   |  107 +-
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 1002 +++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   |  104 +-
 include/linux/iio/iio.h                       |    2 +
 .../linux/platform_data/cros_ec_sensorhub.h   |  166 +++
 13 files changed, 1612 insertions(+), 238 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c

-- 
2.25.1.696.g5e7596f4ac-goog

