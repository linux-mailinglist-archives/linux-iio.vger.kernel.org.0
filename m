Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9943D66EB
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhGZSJA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZSI7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 14:08:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA9CC061757;
        Mon, 26 Jul 2021 11:49:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n10so12902020plf.4;
        Mon, 26 Jul 2021 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2A51SNaALgCfp6Tg57dvY8olluure0IQxuR4WPpMDzw=;
        b=An7NeMY4ZwowD4Q7hLctD3DTF9TSvUk7uDUXALjL3y58jfNKITNZE/FCCXle8OXCTX
         lc5yOiaCRtcgrYbNqU/bHbiijNfAV6PlUVqwp9joqpWZys/SjEVw5oxL2pNiBXOLDXdK
         Uk06L3JYkshh/qaZnhiMpzrZ7KpJT6J2o93wvVo4eFgthMc8UrDmUEN+IfgxTkP+XyLw
         FGwkY58gooojzfcdGDNfST8fLOQ10Dv/C6W+6sNcua0s+ohE6ucvWeNJgFf/VhCvgzyH
         tUrJYJQfb8RLbXNkgCeIJKtk3H0H5rosdsr4e+WJvVvhJRcrpF/3HCnPO/ZXGXi51gKp
         douw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2A51SNaALgCfp6Tg57dvY8olluure0IQxuR4WPpMDzw=;
        b=eYbJfXM8UEg/8Qd2dvyE/JEsjUFu80nROAJ6egIa4Tb8Ya6n9jb/+Hr+DP9eXOmbPB
         GqHKA8yirvHphYXFkS5OaKBiRLWPDcWmjlWhy4fLLqDaTHiQnmZknsnD+s0JbqCWSnf9
         U1k6rhvh1Y7uH6RWojef/Jeb29npBttnPlLZsxuGvoKOYSSllc7b23Q/9YacGBveWJcE
         QJj47q6hoyTFkBZ9Fa1Ub7h8wk0C2btnMHQGNC3VTbDRyFUnS5lBehv2qwh4+C/hdzq7
         RF8RRIxD1XU9sKbb4jKvpZTVEpUN9w9scd4l69Fn+zORQ9Qf2HQP5eWc0Ybp3tDf8HJt
         yIkQ==
X-Gm-Message-State: AOAM531gNPNYea3kfESUds4QA5K02GWOgMCLnOfFnMW7kluEz5qkse1A
        Td1knVPTjkR+yop3hJ4aiwk=
X-Google-Smtp-Source: ABdhPJzDvMpvxA7LHdldZpHIrX9EMBK8JfhzM0+dLISIM13Tii4dt+SJ7mU8fgJr/VVj0AGPaXb+RA==
X-Received: by 2002:a05:6a00:7d1:b029:356:3484:b7ef with SMTP id n17-20020a056a0007d1b02903563484b7efmr19738976pfu.72.1627325366783;
        Mon, 26 Jul 2021 11:49:26 -0700 (PDT)
Received: from localhost.localdomain ([125.62.116.66])
        by smtp.googlemail.com with ESMTPSA id o192sm774902pfd.78.2021.07.26.11.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:49:26 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v3 0/2] iio: accel: add support for ADXL355
Date:   Tue, 27 Jul 2021 00:19:15 +0530
Message-Id: <20210726184917.301070-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

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

 .../bindings/iio/accel/adi,adxl355.yaml       |  75 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/accel/Kconfig                     |  29 +
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl355.h                   |  77 +++
 drivers/iio/accel/adxl355_core.c              | 545 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  63 ++
 drivers/iio/accel/adxl355_spi.c               |  66 +++
 8 files changed, 865 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

