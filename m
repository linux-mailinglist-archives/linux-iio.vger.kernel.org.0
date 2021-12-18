Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4844797BD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhLRASA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 19:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhLRASA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 19:18:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A1FC061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:18:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso7115224pjf.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVe7XCr4nT9em+BXzD672MiHlPyY/4VHpVz9xpH21MI=;
        b=aHCWe0L2y3XBaHAFl/kt3PBebuGtyhlAmn4/3Wcmoj5mXdAPjoOod4mPG+LBCQw0Xz
         UOeKVzVWTGK3ICD8EtZaUhNAcZH2Jkrhg/zXEolWjXvmXNy41NAB+3CxhbzSC+gUekhY
         rNkpkq5wr+00I4VdtRDlDJ7bQw2AOAllcK/rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVe7XCr4nT9em+BXzD672MiHlPyY/4VHpVz9xpH21MI=;
        b=ZMwd1jWf5X1H9H61WulYk0moPhkkq7jvPY35S5GNPIK+t3xpkVV/I43cGSsFWOratO
         sexHmda2AtKPAdlRSGfGFlVjaeq/qFpOG6sQKTdCAkuzQlKAYlispfeRl3Igx5vHaUU4
         pf6+C9VHYay8cuMPGlpDuhHcycQnOx8wauh42xbsC6o9cMwtVcBNUfr2DX/OR5wat9NJ
         Gvl+4t/y3zdpvR1NyGWbF1gS2rFRC8YEsX7e31A/cvU3OhFCD16oTgdNnhsn/5GRZaER
         EroxRKebKGiS3ok8n4rBjGmYlDbPkRH5nK+ToqXpLvyukjLASep1kycygPDnChQqXXPo
         qJmQ==
X-Gm-Message-State: AOAM533PFQd0CuBoYWH7FUbCaNwbNrjDrQMfZ5qSWxPjRs9U0qj4FsIh
        ZF65i2m43hnVDjLVw7fXgE25LA==
X-Google-Smtp-Source: ABdhPJw0i1zqNmaBrDMYu2VMXPDzB4O0jFNwpGB327TJ382oF/kv+rNDgyMm9vHhvTiQu7OP5i7OXg==
X-Received: by 2002:a17:90b:3b4d:: with SMTP id ot13mr14794954pjb.127.1639786679586;
        Fri, 17 Dec 2021 16:17:59 -0800 (PST)
Received: from localhost ([2620:15c:202:201:2bc8:cefc:f407:829])
        by smtp.gmail.com with UTF8SMTPSA id g19sm7593633pfc.145.2021.12.17.16.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 16:17:59 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v8 0/5] Expand Semtech SAR Sensors support
Date:   Fri, 17 Dec 2021 16:17:50 -0800
Message-Id: <20211218001755.3096807-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

Major changes in v8:
  Fix mismatch between documentation and code (setting vs setup)
  Use dev_get_drvdata to access iio device structure.

Major changes in v7:
  Fix one remaining syntax error in device tree binding documentation.

Major changes in v6:
  Fix syntax errors in device tree binding documentation.
  Drop of_match_ptr and ACPI_PTR protections.
  Fix unused variable warning.

Major changes in v5:
  Use iwyu to cleanup include files.
  Use dev_err_probe() in probe routine
  Add attribute to shift irq status register, not common among all
    sensors.
  Fix long line.

Major changes in v4:
  Use chip_info instead of info in common data.
  Returns an error when setting negative sysfs entries
  Fix cut and paste errors, credit.

Major changes in v3:
  Fix some error in binding descriptions and setting
  Fix invalid register constant name.

Major changes in v2:
  Better interface between common code and drivers
  Document SX9324 phase configuration

Gwendal Grignou (5):
  iio: sx9310: Add frequency in read_avail
  iio: sx9310: Extract common Semtech sensor logic
  iio: proximity: Add SX9324 support
  dt-bindings: iio: Add sx9324 binding
  iio: sx9324: Add dt_binding support

 .../ABI/testing/sysfs-bus-iio-sx9324          |   28 +
 .../iio/proximity/semtech,sx9324.yaml         |  161 +++
 drivers/iio/proximity/Kconfig                 |   20 +
 drivers/iio/proximity/Makefile                |    2 +
 drivers/iio/proximity/sx9310.c                |  717 ++---------
 drivers/iio/proximity/sx9324.c                | 1074 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  576 +++++++++
 drivers/iio/proximity/sx_common.h             |  163 +++
 8 files changed, 2127 insertions(+), 614 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

-- 
2.34.1.173.g76aa8bc2d0-goog

