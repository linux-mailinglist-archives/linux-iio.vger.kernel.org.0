Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826093D77BB
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhG0OCK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhG0OCI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 10:02:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86EC061757;
        Tue, 27 Jul 2021 07:02:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i1so15859824plr.9;
        Tue, 27 Jul 2021 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MG0nAz3FF+ReTpCdyTI7WciKOtD3Jot25y+ByURqCXI=;
        b=mHadje27Rek2f5KIEbEhqBrS0JeLoxsK0l50YWVVuKnf7MPIBlbXzaUVLO68NyhY8F
         a3pIdfsMJXpkEjv0MoWicAsAD3Kmf4jMW2lM6paq7Ab07h+8QdqESzfmBySIMJJqCUii
         MZ8qrDc86x/Xi67KbxhKkhzlv5J2KH+kiHpNPjq6vmZAt+lJwZldoZzW5FwVPKsikPIb
         i3HG6zOX4SPC4UNAvNB656osTzdohO9KqmcVFv4KzPZnbery/Rzo/b57sGP0RBbxftqP
         K04syYN+xtnerP0Yvq7MKQXzlApBvKlXMVNgHhgP15nbv6fsoDJUbuoAgV08hBqVWK/n
         +hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MG0nAz3FF+ReTpCdyTI7WciKOtD3Jot25y+ByURqCXI=;
        b=anMEjKsfPv1RWpBLAscIniT5nukN6SXZIEJSL32EAZHDAZebkXRKMfda0gUQCxJgz0
         SN5eAZm6J5x71CQ8dx3ml9DTHen3h6GK8jiPY/XayXljSDCIh9BRrk2jj9Fy2cAL0iNM
         mcrMER1gq687dBqRJrRAvT2PzCPDlG95/n5mURNkC+c1lOB6/ZQVFeckR6/+RKcnDtSY
         yY+oJRmS1PYPePe98jaDhXK7pO0qEgGtGxvaDyeT2cw7mJYTSzKRE0Gsh2ikoyGPpk8K
         w5d9AGGR2R4l/aYDc+5MFi6PbPZ5y4kSpx8+z3prFtnJyUosF9Un4+ciNv6OkbjfHnMA
         ojEQ==
X-Gm-Message-State: AOAM530uMaxJUxPBP8ch/gYEZK7iB4fmt9iJAf+XwM5zY5lPfCIJjPvX
        t0we8mdKyL2xeI9I3ca1fBlIdcBRe1kkDA==
X-Google-Smtp-Source: ABdhPJz4dnVEKSYd2KOAmoSpc0cDdgJhNJiyTVgP1qMvAiJd7ZHw0pq/Li6bdmmADTSgYm0af99d0A==
X-Received: by 2002:a17:90a:ab07:: with SMTP id m7mr22139597pjq.27.1627394527979;
        Tue, 27 Jul 2021 07:02:07 -0700 (PDT)
Received: from localhost.localdomain ([49.156.66.102])
        by smtp.googlemail.com with ESMTPSA id o8sm3071563pjm.21.2021.07.27.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 07:02:07 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v5 0/2] iio: accel: add support for ADXL355
Date:   Tue, 27 Jul 2021 19:31:56 +0530
Message-Id: <20210727140158.201188-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

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

