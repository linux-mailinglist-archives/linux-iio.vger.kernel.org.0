Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8A66A27
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfGLJlW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 05:41:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35934 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfGLJlW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 05:41:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so4193031wme.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2019 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=crBMT3xDpFdt/DcdLHZD4Am4FS/boMU7JkN4C0dR2LU=;
        b=A3mrdWovnpW3j5o1VzHKvoG0yI1duoPhVVW6JaOjBHnesZdvPRyNyKLD1ww/Wnny5x
         HAbMekUmPyFbC1ABm2hJGDkWSN/lu+G3+2gzs3U6PFbWeo2NeWDQaUH+aijPpJKsWtlI
         ZWIAoqnfyxyYZ6psddSURxj1IDfJtAkePG0mzc4TFELzIFuCRJKp6PVnYcHtkJM+xLIN
         ZeFDk/Hv84tpi7oxhPfI779cWYi49REL/RDbDdAgrx3C8TH1UnBaFrY5AyxMwoJY8WAD
         qMCx0eg6qKjWe+ZJaldSUfbVHDSpYwXXbhdtTeVKXZYxTXE/oT7b6Am9fFSFH55hH2Ao
         LZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=crBMT3xDpFdt/DcdLHZD4Am4FS/boMU7JkN4C0dR2LU=;
        b=EXcmwh0S6aFDlyl5OMermY4K0bNcUTykYuVEZy3IsAIkpJ6h3sg7ojbtSc1vEh4Qv6
         c6LK0Ybi9LzEmJK7XLHvG+lOp2EClQUsySsxJ8l+rBUpy2T5VMzCfH+A07+6DpYi7f3i
         V18js9Mrenaxl3D/vvi9BW0OylJ1qU/IhKf1GTk9BTdMmWMQ4Rn+CI3gQS1ZFXVdzgKg
         13CjqRKEOwty98Q9ArRFKwYVnBSOgdfcsMUc4/t4dY2fNmPa534PuzoJHKyaQIlGV/+n
         CMLbAyHoQUWXR9nsF0f2rBOGlT9mp82MyCHp6FL1Aul6ER/moTpyBzH/6ZHEpTbsoCfK
         eyDA==
X-Gm-Message-State: APjAAAUNeO/S/OuxqmI6TIB2ebuHDhkSroFFzRL0WJbLBh2bcR9CRdoc
        PY4rr8rH1FraCmRifz46fK5Zdw==
X-Google-Smtp-Source: APXvYqwCpixGmJMBiTRtGB84DQj+1xZVpJZkCed5cgcKDFeu8bX7SzPEiD9xCthjAezxXIQbz0CAVw==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr9045751wmj.89.1562924480413;
        Fri, 12 Jul 2019 02:41:20 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id p18sm7310891wrm.16.2019.07.12.02.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 02:41:13 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 0/3] Add PAT9125 optical tracker driver
Date:   Fri, 12 Jul 2019 11:40:47 +0200
Message-Id: <20190712094050.17432-1-amergnat@baylibre.com>
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

