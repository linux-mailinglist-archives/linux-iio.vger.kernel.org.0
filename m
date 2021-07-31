Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56E23DC8BD
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 00:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGaWvD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 18:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGaWvD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Jul 2021 18:51:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A443C0613CF;
        Sat, 31 Jul 2021 15:50:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j1so20325479pjv.3;
        Sat, 31 Jul 2021 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ccOmKGqAMkhwq31OLMcVjOhchprcLxq6RDKgsBdQFs=;
        b=mZWaMTj3EpxN8tSLODH97h8uPSbvNy45r4BNkaTAqVdZo+5//hJB/BLP0CVeV/ppit
         FUEFAuG0avqzBQ3hj862RvEh+FvFOxG3tadrhFD+tkc9peaSAUKbbnsRKCZsBdZHSo7u
         /zuoRbBgF2sd22FsvNXwCSSrbvejB55Oc1vA0Wp3or+qc+otCTJ71WD2td/u1TnUg8gf
         Ihb4OOFtMTknD/i0fe+sDuTH3oGJ6tGtGcbiSqY7JIeMvHIeJYt3EtTdP2PrAHchlUsI
         itChO72DNemc2uUKbCgbf6iS9vGE8mwGsLJmK3dXW7mnyY4JBQvKTWWoTAN8/NgUHY8S
         klGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ccOmKGqAMkhwq31OLMcVjOhchprcLxq6RDKgsBdQFs=;
        b=X83xz7YcY2vGot1VgR0SzveEESMXbm1uqmSCJ8ExCb9KzUCPpmic+4/bVN+85Vnl1y
         a++ccVaUjxh1KCcDSpNIo9sjf9Son4L7CV97E+aZAgOTeE87PpoGwXZivSpF7rwAgHMH
         pYPd53QGjEk5vbTo5tI8Fjzn5N4a09nFYFEFXv11avmJpRgqQVxX14n3fzTULQYdcklU
         f4e5kyDRMCG4aQh9X/Mg+Yc09+QmgHtPmt2f5veImoyu8+EP3sZBdCS5zZP4qdnBq5Rr
         ESrndXvNnPTsY/6P9MRWqLAe7vcw9A3PwnH40Ie2MGqZeDdmXvcXkrnAM/k2ARSThua2
         fWag==
X-Gm-Message-State: AOAM531UDFH6OW8YBGK7MHRg2lH4jeoXjMu08qSidgu59jB0PDlP9i1O
        0edlASnDKo21JYrVCg8ccOY=
X-Google-Smtp-Source: ABdhPJzELZqnT2vtdNh6hTPdTJ8H1uP75TJks3eb6I+eDIx/P+FExZ0KF/DrCjmkrKMEbpTIJ3vtng==
X-Received: by 2002:a17:902:e804:b029:12c:af3b:b172 with SMTP id u4-20020a170902e804b029012caf3bb172mr587680plg.2.1627771855477;
        Sat, 31 Jul 2021 15:50:55 -0700 (PDT)
Received: from localhost.localdomain ([125.62.118.205])
        by smtp.googlemail.com with ESMTPSA id 20sm6980578pfi.170.2021.07.31.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 15:50:54 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v7 0/3] iio: accel: add support for ADXL355
Date:   Sun,  1 Aug 2021 04:20:42 +0530
Message-Id: <20210731225045.399445-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

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
 MAINTAINERS                                   |   7 +
 drivers/iio/accel/Kconfig                     |  29 +
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl355.h                   |  19 +
 drivers/iio/accel/adxl355_core.c              | 682 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  65 ++
 drivers/iio/accel/adxl355_spi.c               |  67 ++
 8 files changed, 960 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

