Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6173D6DE4
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhG0FQr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 01:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhG0FQq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 01:16:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523ACC061757;
        Mon, 26 Jul 2021 22:16:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a8001b029017700de3903so1976246pjn.1;
        Mon, 26 Jul 2021 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKYFgBjjZwYmO/YYDavSQwhPmskL/iEGpl6anuA2AZE=;
        b=iSGB8Yk6SY7cMvHQklOeef//X9ijee3KjIt1/NK1eh6KyY4d+PSJSapguDHoEL/sey
         voVWNwcH4AMphup/tyAzSxT4ezuH3Pzrtl4W5Zlcc9bH2sh/i+/e6esiR4qH/7k8gg3G
         T/2iiTepe38Ve6vqyVfHxXp1lftOjfo7vKTTHMFQIuJ/WVObEYAF81zMwMqYnfyINxR1
         jMHIm61X2V1qQ0NQ6Nz86BJt3pIOa4LSvbnb81erUJ91FaxZbAfLFSJhBy1Q40BP9iFZ
         9VQSPqZyt7wPogQnVte2gR0vOFUM6HvhG1jPDFhXdvPq0CO8CJYtrbB6AOgMb/Hj/JAA
         zcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKYFgBjjZwYmO/YYDavSQwhPmskL/iEGpl6anuA2AZE=;
        b=XBsSK7DqLwmrN9OxiiSlcocznuSOkmKidi6j/7MiNA+xF6THxtL/5HxUAPtbL0YAE3
         5p/dnwDIbcFTXyGdxHR+5YVbsWl8lVDwgdhLzvjDNHyA/QKSmTf6/Q4M87O266eXSveO
         EQkOie/dBHqDXkM8rmP/IPOMWBAO1+i7wAMvTarIh4ruYJZoT+fioaS6U63bYeD1iF8U
         NgZIN1dTLvhSTpuqBsx36hxC7ipvHQJYBYDjGWZwnUNcULDH6Do4ouw3hoCl0+aRsChw
         XIehSqLGnrPwHOaCuVkKxOublnP0cFe1b/30ugKbfeNiy6clWnRGSh4ZSfv835o5nM1U
         PtAg==
X-Gm-Message-State: AOAM532WVVGrIhGSHjKKEOH3SR5Jw9rSmfBKdpez7uue8cf0y+9AuFf6
        ubvqeiL8kM94qoOJ340FJMY=
X-Google-Smtp-Source: ABdhPJyfzmDdbaen3mSXOnNDEdwKQGBuud2r53KZOFCsFenEvdjXOfAdreyB0ILQlwiQxtXqtwmNqw==
X-Received: by 2002:a65:680c:: with SMTP id l12mr2805634pgt.122.1627363004734;
        Mon, 26 Jul 2021 22:16:44 -0700 (PDT)
Received: from localhost.localdomain ([49.156.121.207])
        by smtp.googlemail.com with ESMTPSA id k198sm1870787pfd.148.2021.07.26.22.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:16:44 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v4 0/2] iio: accel: add support for ADXL355
Date:   Tue, 27 Jul 2021 10:46:25 +0530
Message-Id: <20210727051627.12234-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

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
 drivers/iio/accel/adxl355_core.c              | 545 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  63 ++
 drivers/iio/accel/adxl355_spi.c               |  66 +++
 8 files changed, 866 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

