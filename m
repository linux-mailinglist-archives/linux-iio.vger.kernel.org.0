Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956A23FE2CA
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhIATPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhIATPJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 15:15:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CF5C061575;
        Wed,  1 Sep 2021 12:14:12 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w17so654782qta.9;
        Wed, 01 Sep 2021 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1M8/dHpvc9LZe0hsBOQZmLDRjDHSjTPsafOkwvoWbDc=;
        b=ldCv+6Dei62x4jpLThEA0fA+OMT2A4MWNkW30pGnv59JNe2YA6BDjPpMt1KbVQzyyn
         aDJbI4Ud1Rxsfcz3rn/MMBMy56ElVm8dhSqiob4h4tt/GfthUeP6KNiDi16sXyrwiBta
         KNQY7K+NY+/pFpzKOX3szubXE3CVgyWKIBaYmAjbLav0nrbBhGfg+RkNIn6bCQSMFM0y
         1DPSDU6Cb9xw9yroINdnk2/5SZCgAdkxVa8JysrINueQRhOCeF3PQFf2b4OBG5vDy8n7
         TNl9JdKmG+efWWZNSoJAjMhltLzHB+g+MFGqyTm2F3rlKl+udJYOxsxNamQ7CqLylW2W
         ru8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1M8/dHpvc9LZe0hsBOQZmLDRjDHSjTPsafOkwvoWbDc=;
        b=oJnvUPRvHWSUvkuChPS8v79rTC3+hL7C6MuDMhDECC7guF0i7yisR5Xued10LD+ovs
         I0/dK1TqdyeEh8RChCvPNrslKMTVy+3tJpeLWtMW9THkzgFm3VmBsvk98IMWl6YmvEvY
         eWK89G0S37NWDK1IWQwY383ZiXlDiZtyLC1UBSV1NXNQX/TJhA7ALYHuQL9Dtzg/qgfv
         TZ43VJFk+A+G1TkR+iXJYyv56WMPd7ablCa4kEYeb1/AL4zbnuRsEfQGb7X6KrXXJzDq
         krYNy5BpWfXaSaTHZDs0sdUGNgGsqyGtY39ieb7opxXRrapE56Y1PXMsLWmxY3q2ScR0
         lRQA==
X-Gm-Message-State: AOAM533Qy4X4u44S/8byhzg+1Ut3Ihj2flBsRHLxWreLYHMzdOwhalce
        BFV7/es+7K6F6gaFa4rSp7M=
X-Google-Smtp-Source: ABdhPJwMtf4FkLSEqtaWf/D5BqwGDo6RTzDVHEaVR6al0mg/yLuEFJJF0QV4VEDAzyu6m5kcPjaMAw==
X-Received: by 2002:aed:314f:: with SMTP id 73mr977422qtg.274.1630523651541;
        Wed, 01 Sep 2021 12:14:11 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1002])
        by smtp.gmail.com with ESMTPSA id h20sm432337qtr.81.2021.09.01.12.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 12:14:11 -0700 (PDT)
Date:   Wed, 1 Sep 2021 16:14:07 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] iio: accel: Add support for ADXL313 accelerometer
Message-ID: <cover.1630523106.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver support and dt-bindings documentation for ADXL313 digital
accelerometer.

Changelog v3 -> v4:
- Add comma to last field of structs
- Add kernel doc to core_probe()
- Rename interface_specific_setup to setup
- Use address instead of scan_index for channel index
- Remove unused fields from scan_type
- Add explicit includes for mod_devicetable.h

Lucas Stankus (2):
  dt-bindings: iio: accel: Add binding documentation for ADXL313
  iio: accel: Add driver support for ADXL313

 .../bindings/iio/accel/adi,adxl313.yaml       |  86 +++++
 MAINTAINERS                                   |   6 +
 drivers/iio/accel/Kconfig                     |  29 ++
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl313.h                   |  54 +++
 drivers/iio/accel/adxl313_core.c              | 332 ++++++++++++++++++
 drivers/iio/accel/adxl313_i2c.c               |  66 ++++
 drivers/iio/accel/adxl313_spi.c               |  92 +++++
 8 files changed, 668 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
 create mode 100644 drivers/iio/accel/adxl313.h
 create mode 100644 drivers/iio/accel/adxl313_core.c
 create mode 100644 drivers/iio/accel/adxl313_i2c.c
 create mode 100644 drivers/iio/accel/adxl313_spi.c

-- 
2.33.0

