Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68C470A48
	for <lists+linux-iio@lfdr.de>; Fri, 10 Dec 2021 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343618AbhLJT1O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 14:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343607AbhLJT1K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 14:27:10 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E12C061746
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 11:23:33 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id m15so8837409pgu.11
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 11:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJGJ/nnp5iIra1swFaXkGR0pyDcptneAO5UoeBudmSQ=;
        b=MoMY1ZuxzPWoAIaH0S8kIJlTfF1qaPGHhx0+zrZa/bD00XGRlAHP8D7Cqx+qUOLGNq
         r31+5gd5jxoUnkz2QVqNS7eP1uyazOf7deiMW6dxrzoDE8NNo/ioLshvguyThqYgZ+fP
         omDy5R5/xyG2BW5Dz0FYhX6ZpuezrH2NH8KUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJGJ/nnp5iIra1swFaXkGR0pyDcptneAO5UoeBudmSQ=;
        b=0jiignAGSYBPaP3CVC+9iX/LWUJbM7CjaN2VOEORQh62emLoOmAxO8Uwob+I6le+hA
         fIbgCr4AafSOEGhzJM6Pj7ZQP6rWFE2IZdI5PgRlhZWk0DH8nnctYZcnIfNirHeKwJjZ
         jniKNgoQdBLMPMBIqHPXkUrzgxr9nJOXDJgt2QtrVZwe3bxI9gL4bfAfa3kk5B5bMivd
         V9zgSEGkpDrZdrgrlzHp+fwobVnh7lBRzY7uQ2zhHJ+rfUYWcDa4rRjPbizWCcoYhlAz
         Sel4UZHdRAWAXPNw0/5doN8v6g8pwpI64p3u7/+aGs3tC9Zejhv8mgLHWZnjusxcriZV
         Y07A==
X-Gm-Message-State: AOAM530gqRvfiZVGWJCb7S+ZP1OrCMs4q1kVUnD3LVaxbx6kbtnIMAft
        oVzZex8EkSfv5kCzxEqf88UKPg==
X-Google-Smtp-Source: ABdhPJy4ObIhV19dv/iT8s3Ocag+bwTIXVoEQL9n6e3G0hGxA7VBncJm3N/MlA1T3tXQznJrv/FSpw==
X-Received: by 2002:a62:e907:0:b0:4a0:3a71:9712 with SMTP id j7-20020a62e907000000b004a03a719712mr20124351pfh.73.1639164212869;
        Fri, 10 Dec 2021 11:23:32 -0800 (PST)
Received: from localhost ([2620:15c:202:201:16de:af23:a52f:63b])
        by smtp.gmail.com with UTF8SMTPSA id j1sm4090569pfu.47.2021.12.10.11.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:23:31 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 0/5] Expand Semtech SAR Sensors support
Date:   Fri, 10 Dec 2021 11:23:23 -0800
Message-Id: <20211210192328.2844060-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

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
 drivers/iio/proximity/Kconfig                 |   18 +
 drivers/iio/proximity/Makefile                |    2 +
 drivers/iio/proximity/sx9310.c                |  714 ++---------
 drivers/iio/proximity/sx9324.c                | 1076 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  576 +++++++++
 drivers/iio/proximity/sx_common.h             |  163 +++
 8 files changed, 2127 insertions(+), 611 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

-- 
2.34.1.173.g76aa8bc2d0-goog

