Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12A3E02A3
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhHDODi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbhHDODh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 10:03:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D7C0613D5;
        Wed,  4 Aug 2021 07:03:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so8876560pjb.2;
        Wed, 04 Aug 2021 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=USBicg/0dV73mfpcCzd1ZEB7FRKa+oevryChnbcskw0=;
        b=osWu0Ak7PxOAxHfIDeok5gAVR7kJNLQELy9diVumDJujF6m/H0u3qwhuuTp0u9o8gv
         Wb/M+XOPf15ZN03FS0rYayZ5RdarCiFRP/Mq0NZ0h6SVGTcJ42bWOB3ew41ACUur+noe
         PWUk18uWbBHX54nZ3uQtz0yKteplPxXuYvUP9S1vrm/AQC6eLb0D87ZO8QCRj14d5nzF
         UwUh5q/oqDVGuBsd5M1khNq8vL+bprSqQazUbYbD0qvy/DratQ2Utq+O2ZS6IFfyvT48
         G2BJmVG+3Ku5KYB+kfua4keFpKipWbhvBGp0mw22pR71KP/eHH0jtveLlXp387bgM6Zi
         U3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=USBicg/0dV73mfpcCzd1ZEB7FRKa+oevryChnbcskw0=;
        b=TchkxNGMjodv7JcRTPrgSw4cOZuwOeq93uvlKW4Et8PGHgkzup545AWjFOM+/c9ykU
         6l9HVAXyiDbDjd67aGOZ4SnF4fij99f8f/gMV1iM8G/I9Hw1GxsF/BJB61xn1R3r2BKA
         jRQ8akF+6b9AvOQR0pzQyIUWKBtbcLQxgmAZa37enF4Z3Qt8SS6sqIRjF0AGZiKST60a
         w1xS/IZgsgySK88aMAb+hYZnJBnLfpTNH63YPZIxN0HaGET7Q3nDNCOJSbIqFcpR/LnP
         j8g+fW4dJjY+eWHPaT/avTzRlxb+pKLi1d8F47X46oNT8aJM79IsdjYl0tBeOvf7SJuP
         NFfA==
X-Gm-Message-State: AOAM533RfflddBoO5OE56Rd3dpEWWVxC04CkNbm9AnLOiefO2neFrwAO
        gq//DFEQr4t3boDceuc1k/M=
X-Google-Smtp-Source: ABdhPJxhoa44dALM0xlv5t0YodiQrJYOi9l4Yb6jVAaXf4TFsFfRwYQiDkTuZ4u7XmHk2KMowVunBA==
X-Received: by 2002:aa7:8e51:0:b029:332:920f:1430 with SMTP id d17-20020aa78e510000b0290332920f1430mr28172289pfr.1.1628085803736;
        Wed, 04 Aug 2021 07:03:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:20f:6a87:f508:aab5:2fa7:36da])
        by smtp.googlemail.com with ESMTPSA id z2sm4048408pgz.43.2021.08.04.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:03:22 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v8 0/3] iio: accel: add support for ADXL355
Date:   Wed,  4 Aug 2021 19:33:06 +0530
Message-Id: <20210804140309.31468-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

Changes since v7:
1. Update MAINTAINERS to show all driver files.
2. Set CONFIGS for buffered support in Kconfig.

Changes since v6:
1. Use interrupt-names property in device tree document.
2. Add triggered buffer support.
3. Use a static table for offset and data registers.
4. Fix coding style issues.
5. move defines from header to c file.

Changes since v5:
1. Used get_unaligned_be24() and  get_unaligned_be16() to parse
acceleration and temperature data. This solves sparse errors and also
make the code more understandable.

Changes since v4:
1. Fix errors reported by sparse.

Changes since v3:
1. Fix errors in yaml DT doc.
2. Change SPDX-License-Identifier to GPL-2.0-only OR BSD-2-Clause

Changes since v2:
1. Add separate DT binding doc in yaml.
2. Use ____cacheline_aligned buffer for regmap_bulk_read/write calls.
3. Make code consistent by using same style in switch case.
4. Use FIELD_PREP in place of custom macros.
5. Make Kconfig description more informative.

Changes since v1:
1. Remove the declarations for static regmap structures from adxl355.h.
This was missed in the v1 and caused errors.
2. Make switch case statements consistent by directly returning from
each case rather than saving the return in a variable.
3. Some coding style changes.

Changes since v0:
1. Move adxl355_hpf_3db_table to adxl355_data structure. This is done to make
sure that each device gets its own table.
2. Make local regmap definitions private to adxl355_core.c.
3. Other minor coding style changes.

Puranjay Mohan (3):
  dt-bindings: iio: accel: Add DT binding doc for ADXL355
  iio: accel: Add driver support for ADXL355
  iio: accel: adxl355: Add triggered buffer support

 .../bindings/iio/accel/adi,adxl355.yaml       |  88 +++
 MAINTAINERS                                   |  10 +
 drivers/iio/accel/Kconfig                     |  33 +
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl355.h                   |  19 +
 drivers/iio/accel/adxl355_core.c              | 682 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  65 ++
 drivers/iio/accel/adxl355_spi.c               |  67 ++
 8 files changed, 967 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

