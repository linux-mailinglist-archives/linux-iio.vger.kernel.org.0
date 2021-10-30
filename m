Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA20044087C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 13:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhJ3LVD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 07:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhJ3LVC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 07:21:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24B5C061570
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso1921633pjo.3
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mEFpy9CXH66d+AqaVfV3f9LKv0dUZ1dyTDseUnUOnj8=;
        b=JROyXK9mUC2B1XSFXtOywgBPNpKpjRpbzD9Tw9jGtgLdETt/8Jg8SncCZrgIJPNVU7
         jzKizAkLVgKOXnDEidz8Saqlhe5VniKFaJPv4H/5iUBLEw8BJHsRJthJcb4O1IBk44ye
         NYp9C5F9/9hwz5OV/BGvXnyXyTKo7GN43rbHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mEFpy9CXH66d+AqaVfV3f9LKv0dUZ1dyTDseUnUOnj8=;
        b=eO0T8eB8DWcxGqTHvvcyvrBpraNhA6YE9UnxkSlVt5wyOFTknxAtUDJvmaxCxilIf1
         BMd+Ss4AbFEySrNqs0wTuyp5XtzS3e3m79WwfJTcisQBXIWx+SOOYthKW1jmVueSXqV/
         4bUQ7tXCGcQUYdruDtgLDi3VscRBiTWClRq+fgmWgUr57S5rVEHJ9OcXKeEIQueabbEW
         70MbCHkKP7nqFHAbPGoeMEBONIzRHD9GXTOLR8rsiEmGZLyZn8zW0xwhpbt6Ay6SmV9S
         KL7rgMUs4K66sg0RO4350zmMZrI+tWHcr+zWjacyvh7JfgHhuK/fSiy+GOGQygoZ/Ea/
         h4xw==
X-Gm-Message-State: AOAM530X0H/6PWNJ/ULgeArvqswn0fhf0xdcR6IEKQDSLmla1EiAfwHk
        fPN96NGrzzxaY7Teyc+j36kz9g==
X-Google-Smtp-Source: ABdhPJx9WskO83aTI76AfIDTZGBEaXS5fa/nuwu1csgXwQlwWTK8G2+K5SeoTbH7M3KGAwIbaM48ng==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr25852786pjb.80.1635592712261;
        Sat, 30 Oct 2021 04:18:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:71f1:234f:bb3d:6ccf])
        by smtp.gmail.com with UTF8SMTPSA id l14sm13212409pjq.13.2021.10.30.04.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 04:18:31 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/5] Expand Semtech SAR Sensors support
Date:   Sat, 30 Oct 2021 04:18:22 -0700
Message-Id: <20211030111827.1494139-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

While moving the functions to the common file, noticed that constants are
sometimes used instead of chan->scan_type.realbits.

Gwendal Grignou (5):
  iio: Use .realbits to extend a small signed integer
  iio: sx9310: Extract common Semtech sensor logic
  iio: proximity: Add SX9324 support
  dt-bindings: iio: Add sx9324 binding
  iio: sx9324: Add dt_bidding support

 .../iio/proximity/semtech,sx9324.yaml         |  141 +++
 drivers/iio/accel/bma220_spi.c                |    3 +-
 drivers/iio/accel/kxcjk-1013.c                |    3 +-
 drivers/iio/accel/mma7455_core.c              |    3 +-
 drivers/iio/accel/stk8312.c                   |    2 +-
 drivers/iio/accel/stk8ba50.c                  |    3 +-
 drivers/iio/adc/ad7266.c                      |    3 +-
 drivers/iio/adc/at91-sama5d2_adc.c            |    3 +-
 drivers/iio/adc/ti-adc12138.c                 |    3 +-
 drivers/iio/adc/ti-ads1015.c                  |    8 +-
 drivers/iio/adc/xilinx-xadc-core.c            |    2 +-
 drivers/iio/magnetometer/mag3110.c            |    6 +-
 drivers/iio/pressure/mpl3115.c                |    7 +-
 drivers/iio/proximity/Kconfig                 |   18 +
 drivers/iio/proximity/Makefile                |    3 +-
 drivers/iio/proximity/sx9310.c                |  630 +---------
 drivers/iio/proximity/sx9324.c                | 1090 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  618 ++++++++++
 include/linux/iio/proximity/sx_common.h       |  129 ++
 19 files changed, 2081 insertions(+), 594 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 include/linux/iio/proximity/sx_common.h

-- 
2.33.1.1089.g2158813163f-goog

