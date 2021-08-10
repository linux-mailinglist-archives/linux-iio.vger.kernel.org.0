Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D140C3E8328
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhHJSqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhHJSqI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 14:46:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B315C0613C1;
        Tue, 10 Aug 2021 11:45:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t3so22468850plg.9;
        Tue, 10 Aug 2021 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ApjcOuh7duZILh8T6JLUB1Jdv+YHLxNkLoCXW/z5nfY=;
        b=dcnP4jw5UI8nCSfi/syI5q9gL/kCyB8rWwt7nwllSuIcM0XtYoAbVa6eWY3Ow5Z4/r
         8ZPSH3RCrUCMKYoxAl48j+IIlKdeHY2dLm37jkGI/SEtwLmNfeD7WHbpskZbX8SoG2KJ
         kSlUx4kF7SzRochmnIh7U2qZ04m047T+bzTcwdYkY0o+Jc5RPeblTq2sIXmJtfqCbruH
         Nblgl1TGQORhuv1uHljXAVSn0w4/FR136fvb9n+cdtw7Th0UziS7ohV/NtBgr7Z+o1zG
         y7Aq2Iph4Dv2eeKVCM0Z5Tt3TvLHGBd5mGaVlJfO3ovj9pH+5oSADoB6OSO6Dvus9GEH
         u8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ApjcOuh7duZILh8T6JLUB1Jdv+YHLxNkLoCXW/z5nfY=;
        b=jIG8Xp+WRxSXZ7fR5/N1QIbJSUr3nBAdHrAh0K+lSqF64Mcl4dzvUpJdPVwbTWp+cK
         x5vydjeWbBGYD4kffZ4KIXIwlZDwm/a0HkFjqcdmalErcPLmq2IQ/dY84LcewJRNO/ph
         2cQ65WrtQ3zpoEFCAZwrJqxhL2nZMY/4ADtSoRg7SvbZzL159ogBJHJq/SCVueUZg7eY
         f+j/JXoLNix9c35iwDu3/xMXJE8Hbyjx3sR/yL2dNJbQWC2NhRrXneQVLltsWb2moCY+
         nZFzTUDyvkr49cZePQPnvn+N2Ni0evlH6bCBVWXq8uLAPmL449P64IKMC7zeZeaPqk4Y
         5SDA==
X-Gm-Message-State: AOAM532eFFP89hc9xGNWMwm2RY93+zyFIcgKwVdbY+0gnaGNlHmUVpqC
        sqW6IxY8v+FQ4oyx/eWYlR3Amw+ABtPC+ut5
X-Google-Smtp-Source: ABdhPJyGB11DnKQqwRlqB0bhsQVRQ50tgIHv0X1zL13EgqCJpYK+prTKs4GNxBMWXyqjVkGeF3pIDA==
X-Received: by 2002:a17:90a:4681:: with SMTP id z1mr18196522pjf.131.1628621145705;
        Tue, 10 Aug 2021 11:45:45 -0700 (PDT)
Received: from localhost.localdomain ([125.62.119.16])
        by smtp.googlemail.com with ESMTPSA id f4sm29933733pgi.68.2021.08.10.11.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:45:45 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v10 0/2] iio: accel: add support for ADXL355
Date:   Wed, 11 Aug 2021 00:15:34 +0530
Message-Id: <20210810184536.34443-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

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
 drivers/iio/accel/adxl355.h                   |  20 +
 drivers/iio/accel/adxl355_core.c              | 582 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  62 ++
 drivers/iio/accel/adxl355_spi.c               |  65 ++
 8 files changed, 859 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

