Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3F3E89A6
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 07:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhHKFUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 01:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhHKFUJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 01:20:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF4C061765;
        Tue, 10 Aug 2021 22:19:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a5so1173901plh.5;
        Tue, 10 Aug 2021 22:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALXZGGx8hqHrc29Uo+vr/bND157mwrNg33GFHzJzrxk=;
        b=Orr1RIZrR+VJ+N4FGLvQyD2E4uwTXGcsocyz3iLyzP/UYNG8bDpNLR4XHowYuxvg6u
         2a/x9nXQwGws1tIsdl0v+tBb50wUVgbjrn/tp1kh/jweq08rdxBa3KVtAw+JDZLUWhGc
         jT0YKnILyqFjThpnbpAI3JpewgSKdwwz1qx1ckdL2im80Iq01meuOhGu1NH97lSRXRGw
         q8fy8PY82978+iVSM5niPoafZb6jt9Fd0vEVLoXFFJxFUaSUI6LUc3yS6L2mnBPVya3Q
         /Zvk9fzNj0AVcY6EYaNyK2c7e/znACneWQ988VvkvKGspfQRwDbDwEVu5VMka0fBGZg0
         pHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALXZGGx8hqHrc29Uo+vr/bND157mwrNg33GFHzJzrxk=;
        b=Vc4GYbKQPv8nVI7t9gvTfK3mO3mnROTacDDGXsAov4YoIb2se9xzoTksvGKpm4EZfK
         MDPACrPmlLCbzMp/Rbrdi0YTFwnE8MgCklpAeHnySaMiggWwDRXEG9xFE8y59md8toxj
         yHJPBC9vLmTfVduAsuDTgGb2u06MW+8utkR2dd/w+qx+tXWC/yYHOGpUn3rHEUArnlDV
         Kf0E7+rXoTA7iINs/Hjn/UivrOIoIAvKSLhPeUk00+6f0zATFQ++ZcYyiIJgdXKV4Ufz
         PFAlNzAQHD8HpIIv5BZxiBF6gtmhLnv7NNJj+SV0EJgZ2kBTXYeSSci6ihMb5t5AE0T/
         BKTQ==
X-Gm-Message-State: AOAM532knpaEX5kjEgLVvoMVrxHrQlkBCbkQdMoNin6SPU+qiyrs5+xp
        z+mGl4i1/m0AYC0HCkNbqNs=
X-Google-Smtp-Source: ABdhPJw5chguG/izlwPxLAyrbnKOQ2f7WqHqg6GwDBb8sn7FQwjNSZy143xIGpkhYTzhbU4mhRdSvA==
X-Received: by 2002:a17:902:b487:b029:12c:4051:a8de with SMTP id y7-20020a170902b487b029012c4051a8demr2774145plr.76.1628659186242;
        Tue, 10 Aug 2021 22:19:46 -0700 (PDT)
Received: from localhost.localdomain ([49.156.64.163])
        by smtp.googlemail.com with ESMTPSA id y20sm13055924pfb.54.2021.08.10.22.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 22:19:45 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v11 0/2] iio: accel: add support for ADXL355
Date:   Wed, 11 Aug 2021 10:49:36 +0530
Message-Id: <20210811051938.111191-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

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
 drivers/iio/accel/adxl355.h                   |  19 +
 drivers/iio/accel/adxl355_core.c              | 584 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  62 ++
 drivers/iio/accel/adxl355_spi.c               |  65 ++
 8 files changed, 860 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

