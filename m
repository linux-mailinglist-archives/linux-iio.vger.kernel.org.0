Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ECB3E8B0D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 09:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhHKHbB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 03:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhHKHbA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 03:31:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB038C061765;
        Wed, 11 Aug 2021 00:30:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so8321008pjs.0;
        Wed, 11 Aug 2021 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWn49/rYG5mX/2i6xhvlb6WPBoJKr0zV+SSn8uRssf8=;
        b=oxdRDqDoEbysbjthkPcretiA5WSwUh2NyaGwByP4PLhyb07l/GMf8W8Ft+58yMk3/i
         iNBX9cJao9XnfsYGAtUOqJtQQecW//juIP1lQtaNBdN6X8BqnbDbjh0JZcb1XPGOFuxm
         T8SCYLyEzgYcIj3bktS0umljgHDn9YxDAnMFI+RrKayDMlllhVfkURUZNeq93JV0Vs94
         DsjGU8tMxBxVcJFuCXFJpM7AiEtX8wpgeY4VcjZSUzvkX6g0gZEZKpXtk5XDj7LzyOyw
         F6XfOjfUwIPEfKyuWr9FFsAP56rJ5GlpOUbgdK54wFXY3RtVRlJgN2fj2ZuAMs8XKslH
         IRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWn49/rYG5mX/2i6xhvlb6WPBoJKr0zV+SSn8uRssf8=;
        b=GyzHfgABZqaPZ79rC8cTXGsRIR2wbL5xGA3KnQGhjgf5wxDXIh3CMcskcxOGEFEbqS
         eS4QfDIGZhUC5JPdz7IbyXGVz73nRCmgZdQjLyXeVQzSk8PVVMhe40qrcYs+wW8Bn2mx
         2n9nNU1JOtkYnIPdMxMtZWIPYs8PW0VmfRg/bpjSgx1/WKcKiLxof0u0zo74URnKWqkG
         pOmGwBEmuzJUU/aTD3SR7dLT048pHj7Fq2aeVy7JnXu/kFyHGHGD5G1GgzY+4SWl6zBc
         KThzl5ekjNclIZajR3djSYY39RrNIvEhc40YkphIiOZLYewmXh2uq43K8kOs6uNYGcD3
         PAlQ==
X-Gm-Message-State: AOAM531X1yH13wdYHXfPzDEjYHGonH4TKsAgCy/B+10it1SfY4oFh5G4
        1oDozGpuTKM979t9XMgfFso=
X-Google-Smtp-Source: ABdhPJyV42ff377l6Op0DeLmp5tNSNrLuHqZLbtHaNkDE381UmHzjfjOdMNmtQ1NnqJBKPey67YxDw==
X-Received: by 2002:a63:4a55:: with SMTP id j21mr332593pgl.187.1628667036139;
        Wed, 11 Aug 2021 00:30:36 -0700 (PDT)
Received: from localhost.localdomain ([124.253.244.73])
        by smtp.googlemail.com with ESMTPSA id c21sm26042284pfo.193.2021.08.11.00.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 00:30:35 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v12 0/2] iio: accel: add support for ADXL355
Date:   Wed, 11 Aug 2021 13:00:25 +0530
Message-Id: <20210811073027.124619-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

Changes since v11:
1. Add forward declaration of struct device in header.
2. Use defines for power-of-10s.

Changes since v10:
1. Use macros for powers-of-10 in fill_3db_frequency_tbl().
2. Change names of gotos.
3. add commas to non-terminal lines.

Changes since v9:
1. Fix white space issues, remove extra lines.
2. Include bits.h and device.h
3. Add commas to non-terminal lines in structs etc.

Changes since v8:
1. Make scale and offset defines inline and remove them.
2. Change dt-binding doc to state interrupt polarity only for DRDY pin.
3. Remove triggered buffer support from this patch series.

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

Puranjay Mohan (2):
  dt-bindings: iio: accel: Add DT binding doc for ADXL355
  iio: accel: Add driver support for ADXL355

 .../bindings/iio/accel/adi,adxl355.yaml       |  88 +++
 MAINTAINERS                                   |  10 +
 drivers/iio/accel/Kconfig                     |  29 +
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl355.h                   |  21 +
 drivers/iio/accel/adxl355_core.c              | 584 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  62 ++
 drivers/iio/accel/adxl355_spi.c               |  65 ++
 8 files changed, 862 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

