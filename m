Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0157C3B227
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbfFJJaO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 05:30:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35476 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388777AbfFJJaK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jun 2019 05:30:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so7453869wml.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Jun 2019 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ReCc469/hMNgKKDRaI/8/xE7tbMybb43zKTGTTYrE/I=;
        b=K7jf9S3DT5/YZPXxDbox6LiHnAsH5cSs2RGmlrGV7k9YC3+cBMpqpSbHzebBRcAqse
         BdXlxZVNB4xLsD0u1Qsm5gD1vqRWXbAHDRmo6ogvwG6RZyTT6Pd1+5RReD3NMsmnQZcK
         5+Vr+mYR2SpgBnFw7esR0Feox1aITxXcpsqFswNVy/Pp0OvHx6GnIPORpCOnUzLhty/2
         EAMFOUUS/4UE0R/xeCs8enfXInYGd8Cka5OrsukgQB/aY6OxykPRuJjBW1YkPs/uW5wT
         +afPXZyOlCOg9wAzmk80b5dQj0o9kbL4mfq/ZDfZwsll2mHE124xabykrW6j/uOuGfaI
         fBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ReCc469/hMNgKKDRaI/8/xE7tbMybb43zKTGTTYrE/I=;
        b=MkmIROQsfP68ucXOMRN9vrvxS6fpe9Yzxnf14NU6MCu6rSBXI+R2UiUjXU1wUuOERs
         RF6y6eWbV85rVBwpkNF75K39IaszYH/8h+oxbseSs8DYmstLGOlwciYRBzPYzNdjmG0c
         b+OvLZG+tPNceeujUH1hLdVaZuc4jhY96JLsC4RjVtUpi7gAeQAG0sPOJZxwoIIK6uFn
         T/RXrbMlmc49adWHqPyF5MGmnPrweq0p0qJPFjNI9XYh6wFTp/8nOCDRA5mubNoTPIzm
         bd062kwbY8oB2ggx8Ws7TGdd73VoMwJb7e17nJRpXGiLewBsc+0j1zhsIfV1gNiJvBjz
         mRoA==
X-Gm-Message-State: APjAAAV5iqVXnJNLNQzlVEIqwa4yJ9CjZy6aNiEzqOyYPRtB7/xD5IuU
        kR12/RRRk0XuHqZH1pVHJkKaQA==
X-Google-Smtp-Source: APXvYqz/c0tI9OV2RYHdb+EY+X14qnPe9z8tweSoQF6lpYD7pTkq39JwbtdeSUdT09qt9cWEhCZvxg==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr7854269wmk.55.1560159007741;
        Mon, 10 Jun 2019 02:30:07 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j123sm11881943wmb.32.2019.06.10.02.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 02:30:07 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 0/3] Add PAT9125 optical tracker driver
Date:   Mon, 10 Jun 2019 11:29:42 +0200
Message-Id: <20190610092945.6330-1-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PixArt Imaging PAT9125 is a miniature low power optical navigation chip
using LASER light source enabling digital surface tracking.

This device driver use IIO API to provide punctual and/or buffered data.
The data could be relative position or delta value, both on X and Y axis,
depend on CPI (Counts Per Inch) resolution setting chosen.

The device support configuration through module parameter interface.

This patchset :
- Update vendor prefix
- Add the bindings for this device
- Add the device driver
- Add directory for optical tracker devices

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
- Implement a trigger handler function which can work with any IIO trigger,
  independently of it own GPIO IRQ, to match with IIO requirement/behaviour
- Replace iio push event function by iio trigger poll in GPIO IRQ handler
- Use triggered_buffer helpers to replace kfifo use, setup buffer,
  implement enable/disable setup buffer operations, IIO trigger allocation
  and re-enable operations
- Remove useless "goto"
- Change GPIO IRQ handler from planified thread to IRQ thread
- Change GPIO IRQ trigger from low level and one shot to falling edge
- Add device unregister and buffer cleanup to driver remove function

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
 drivers/iio/position/pat9125.c                | 499 ++++++++++++++++++
 7 files changed, 545 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/pat9125.txt
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/pat9125.c

-- 
2.17.1

