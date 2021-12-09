Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A529D46DFE0
	for <lists+linux-iio@lfdr.de>; Thu,  9 Dec 2021 01:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhLIBBp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 20:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241683AbhLIBBn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 20:01:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F5C061746
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 16:58:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so5640942pjb.5
        for <linux-iio@vger.kernel.org>; Wed, 08 Dec 2021 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NxoQXSULZwxl2gxUiZfPfGIr3nuzFPbF8g//zTGa4Q=;
        b=np/8mN0gL/fahRKFqS2LntCEHVoYzpIosEw6uTv39v5hOxxbI4khVaBNijAzrUhpsu
         sHgaCw3j3YRhX0o8wCob3dJjBiQKNqMX6ARnnF6BM373n8uhdEZ+8EZ9gv9FGoofoKFm
         UUOAG9wBginls3m88KZkB+ihk2hxzn6+kgz3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NxoQXSULZwxl2gxUiZfPfGIr3nuzFPbF8g//zTGa4Q=;
        b=krg74NgI1SgLq0q4WneIrSFwuk1LfH1u6TNKiY8/Cyl+yH7I5UGTN01WZZgrnL1gI8
         04NItTPoxrXxIRjAtcTJgu72KdjrA8zuir7/h23dbUMMsE+WTyWjA3w2/GSXxcePGAZz
         cVFcpDKK7yI7Mshjoh2rQfp/An7l0vmKFQ4yz8kRjZCDzIj6F6o2KHTypGhbm9BnyaMW
         g/f7tzwsXqPpLn5H7h8mA3T0gsky8cpS8DSnAVlN1u1+Hsra3ztNtDCkMiZPSQOaqD5H
         8JyDvEiimH60vwdCISeGf9EdHDqOgpKzeE5UKAZLd1dFluy3Ggjc4bZ5Oj//x3GhEsyX
         nzsA==
X-Gm-Message-State: AOAM531NY+BmDslfOnaavmI9y7fp5KICUxVR49lvik4Fso+uNAV/aC8V
        hQgPYDpSwLGQ4HXvgzrIVnNTOg==
X-Google-Smtp-Source: ABdhPJyMbCJxXcn/mdR8vVdEQTRGW0tiCVyHl/YSaZq1B7I99mjmUjUc+Qcga1ewcVJfjMdvd8JLow==
X-Received: by 2002:a17:90a:eb03:: with SMTP id j3mr11397026pjz.149.1639011490265;
        Wed, 08 Dec 2021 16:58:10 -0800 (PST)
Received: from localhost ([2620:15c:202:201:16e0:43f4:4e33:993b])
        by smtp.gmail.com with UTF8SMTPSA id oj11sm2174697pjb.46.2021.12.08.16.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 16:58:09 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 0/5] Expand Semtech SAR Sensors support
Date:   Wed,  8 Dec 2021 16:58:01 -0800
Message-Id: <20211209005806.3575399-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

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
2.34.1.400.ga245620fadb-goog

