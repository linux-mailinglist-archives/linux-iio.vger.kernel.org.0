Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068023D87FC
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 08:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhG1Gem (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhG1Gem (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jul 2021 02:34:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7CC061757;
        Tue, 27 Jul 2021 23:34:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mt6so3697786pjb.1;
        Tue, 27 Jul 2021 23:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9DmELG1+gVWEcdyY7//y7sI4pfR9zgU+WdxarmT6tSs=;
        b=hBLsVbJHABv39fCJdwJEiFnBwz0SSVjEq5d8EfPYrxMbuO76MDzevoYSPDzoCIamOG
         3b2SYrO3qIqajTHx8PMkqIep9+T0fuJD5M7AGznU5sh0lPg50i8plbdZfRwZpZT1f2Vb
         mLW93MQc1zNOYNRC/CDSIcvnNTJqnB1sXQPCOG+WYBeHaT5hglHEij2EetI2LUr2HdIZ
         lEgaH5Ou4CVaQgNSCWAtFlM47jR0s7AoaR+4BmFanBnVh16wopxkN7E4KLHqxUZmscIb
         jpjhGF8RO3mX8UGqGPC7duOSdxzPV+WBY0M1adEpUAk/NYuAnfgfFvUX71WkgrvjMFs6
         cflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9DmELG1+gVWEcdyY7//y7sI4pfR9zgU+WdxarmT6tSs=;
        b=RCJpjGNdcUe0HtsApimyBsN22RZYlnEFAWdiK33vwLzcRKRy42o8tM14UrfUvhMAAy
         KgzgLgfPQ2vSfKDsqgRW/tsA9upw8GCut8gaUCLc5ATLslRYTt3wGNmn7V4nHqQF/CVy
         wzjacbB5wRdfQw1OChqQLCerbaVTV0JTN7UVyunWy6wYA7b21wrxDQjW6/zeLphuQP4t
         LKE9fO5BBaThiCxpIyxIaIYJ94wIgv6skAvyuq76QoLPMa4z3P8C1bcbPekuXBdJaVFF
         mWmfbVoukxjKwOH64iDwUwJyBDueJJf/ZC9KoW7C/k4EPPzL1XMX5IDwligIOTtV3X7b
         wGCw==
X-Gm-Message-State: AOAM531jts/ZRw+dMVQ4XFNkY1LOsAG2/GTwT0lrvVhMw1VdMKOcJnOA
        6NDKsgB+IUBf1gY+Uc0COvA=
X-Google-Smtp-Source: ABdhPJykhAsaGkST3v8hKLOWZ/IR7hFeOoOoIE3eI+f3o7caP8nReZ9C3MrrsC0vwHF5ZUd9l23PeA==
X-Received: by 2002:a62:3896:0:b029:33a:f41a:11a4 with SMTP id f144-20020a6238960000b029033af41a11a4mr27194404pfa.9.1627454079848;
        Tue, 27 Jul 2021 23:34:39 -0700 (PDT)
Received: from localhost.localdomain ([27.255.220.51])
        by smtp.googlemail.com with ESMTPSA id e30sm6698882pga.63.2021.07.27.23.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 23:34:39 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v6 0/2] iio: accel: add support for ADXL355
Date:   Wed, 28 Jul 2021 12:04:28 +0530
Message-Id: <20210728063430.258199-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

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

 .../bindings/iio/accel/adi,adxl355.yaml       |  76 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/accel/Kconfig                     |  29 +
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl355.h                   |  77 +++
 drivers/iio/accel/adxl355_core.c              | 542 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  63 ++
 drivers/iio/accel/adxl355_spi.c               |  66 +++
 8 files changed, 863 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

