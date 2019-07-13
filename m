Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8905367921
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2019 10:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfGMIFG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Jul 2019 04:05:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40771 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfGMIFG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jul 2019 04:05:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so10793127wmj.5
        for <linux-iio@vger.kernel.org>; Sat, 13 Jul 2019 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=crBMT3xDpFdt/DcdLHZD4Am4FS/boMU7JkN4C0dR2LU=;
        b=s3rW1GYRQVlJ8DjwhU4sZ5eQZORVIhCYzjtFCnuvllOfgOrGEW3IDL0OYFJHa9rJ6y
         C33H9tgpaCopN/NNlamYa1TA3kxaX4EUqEBVNNKvK+lEcqNMcCbuOuN0DVUcWqxwcCSn
         DVUjDDaQAi90hm8fWJv4NQoJN9mftS/2FdY5y1kuYTnQWqH0TKyTlK7vtSbdwrEsU+7P
         duv//N4FPYXg7z7nfiEri1FPPBrw8MGuPt2AMBvXhD5N2Ep99lTWHdFibiACmXHMFL3S
         GB7xtI+SmD9jt+fauKIxTBwTos/L7idUAoCn2gCv+9tA0nRmCVL+rxTBBUuWPvSVCE3d
         a2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=crBMT3xDpFdt/DcdLHZD4Am4FS/boMU7JkN4C0dR2LU=;
        b=ZP+3Bx04mmEJMT8aUoV9/McPR4QpkTucDJ2cr5s640GQBkbByIeDRHJkuz7bGaoGVB
         29THQKAGcZSDHmMVbUhoTI1p5z11YiBX4KSPqAQgMWqkH2mLGd2Rl/tCttBBottQR3Gw
         hMPZsXtLqWIR07zm5yOI/mt1VGYZ4j5qsnwBeY/UuS/Yy2CkOEUpFWEh5lBqZBpLAzaR
         RQiMFdrnT6YPg7TbpjG7jfodotY1SNA/W2pYk8514H+6sytynblfPcVhfvXWYtJhKhsL
         N6ffWVBFlS3Vj+loEWOJcwGLx4j3V5mJdB/80AAFltIRGOGOCZySIaz+8f8pLmpGqBgx
         EUZA==
X-Gm-Message-State: APjAAAVsOVLsqc0Km+lfgAOg6IC2u6+gW/Uxs9v/O+oeDhGjOJfjKtkW
        Cn57xUmlVDTlr6C5UDyTz9nXJw==
X-Google-Smtp-Source: APXvYqyh0bSoYxaglNe3o+ajqe4aEtUDwJlLfU0lqLonTie6aJIi7TQcFHgbG1pZCVAq6kcPbiJ2HA==
X-Received: by 2002:a05:600c:291:: with SMTP id 17mr13409688wmk.32.1563005103881;
        Sat, 13 Jul 2019 01:05:03 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id o26sm9621634wro.53.2019.07.13.01.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 01:05:03 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 0/3] Add PAT9125 optical tracker driver
Date:   Sat, 13 Jul 2019 10:04:52 +0200
Message-Id: <20190713080455.17513-1-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PixArt Imaging PAT9125 is a miniature low power optical navigation chip
using LASER light source enabling digital surface tracking.

This device driver use IIO API to provide punctual and/or buffered data.
The data is a relative position from where start the device on X and Y
axis, depend on CPI (Counts Per Inch) resolution setting chosen.

The device support CPI configuration through IIO interface.

This patchset :
- Update vendor prefix
- Add the bindings for this device
- Add the device driver
- Add directory for optical tracker devices

Change since v3:
- Replace delta value by relative position
- Improve write protected reg function by removing print log and obvious
  returns
- Handle error in postenable buffer function

Change since v2:
- Fix typo
- Add constructor webpage and datasheet in commit message
- Use BIT() macro for define bit mask
- Remove shift from IIO channel spec structure
- Replace IIO_LE by IIO_CPU from IIO channel spec structure
- Replace memcpy() by cast (s32)
- Rename "pat9125_trig_try_reen" to "pat9125_trig_try_reenable"
- Add carriage return (\n) at the end of each "dev_err" function
- Remove "iio_trigger_unregister" in case of "iio_trigger_register" fail,
  register function already manage it
- Remove log which print device name in case of successful initialization
- Fix enabled IRQ flag warning during nested IRQ thread
- Improve retry algo now based on status register
- Remove "ts", "motion_detected" and "buffer_mode" from pat9125_data
  structure
- Rename all "ot" directories to "position"
- Polling sample through IIO_CHAN_INFO_RAW now return position value
  (relative to the position at initialization time) instead of delta
  position
- Clean iio_buffer_setup_ops structure by removing NULL pointer.
- Use devm_iio_ function for all init functions and then delete
  "pat9125_remove"
- Move device_register at the end of probe function
- Replace MODULE_PARM_DESC by IIO_SCALE to set axis resolution (CPI)

Change since v1:
- Fix typo
- Rename some defines / variables
- Remove I2C client from driver structure
- Change type of delta_x and delta_y from s16 to s32 to simplify signed
  operations
- Add module parameter for axis resolution
- Replace "IIO_MOD_X_AND_Y" by "IIO_MOD_X" and "IIO_MOD_Y"
- Add sign extension macro
- Improve read value algorithm to avoid data loss
- Implement a trigger handler function which can work with any IIO
  trigger, independently of it own GPIO IRQ, to match with IIO
  requirement/behaviour
- Replace iio push event function by iio trigger poll in GPIO IRQ handler
- Use triggered_buffer helpers to replace kfifo use, setup buffer,
  implement enable/disable setup buffer operations, IIO trigger
  allocation and re-enable operations
- Remove useless "goto"
- Change GPIO IRQ handler from planified thread to IRQ thread
- Change GPIO IRQ trigger from low level and one shot to falling edge
- Add device unregister and buffer cleanup to driver remove function

Alexandre Mergnat (3):
  dt-bindings: Add pixart vendor
  dt-bindings: iio: position: Add docs pat9125
  iio: Add PAT9125 optical tracker sensor

 .../bindings/iio/position/pat9125.txt         |  18 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/position/Kconfig                  |  18 +
 drivers/iio/position/Makefile                 |   6 +
 drivers/iio/position/pat9125.c                | 506 ++++++++++++++++++
 7 files changed, 552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/pat9125.txt
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/pat9125.c

-- 
2.17.1

