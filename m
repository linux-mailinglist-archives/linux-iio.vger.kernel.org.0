Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EC848195D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 05:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhL3Emr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 23:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhL3Emq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 23:42:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966AFC061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:42:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a088d00b001b0e3a74cf7so15724871pjc.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WnrBaj6nkgrIJ5ZGcyPIAKUp/fACZVTK9JdPIpSv1Q=;
        b=LCMId2IjXNlsSL+brQDckXm+dCwGafGVQcoQBSmhgps6AhY0JWurHnTbxCNaxgSmpY
         pLcbHlJK8zIzbkBc4otGEdHMBc6IXPWYfD1zlGvv8EHPFTsel+EOMHLWvKAZ8oAL+9G4
         wxkwpyiho+0MS5zJwgIf4SD9LY+vYgLrDIOdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WnrBaj6nkgrIJ5ZGcyPIAKUp/fACZVTK9JdPIpSv1Q=;
        b=CN/L5/fGfOYZ9+yy3/kBsO88t/QoTJdfXkpZ7H+d7PT2TRUqVZYkOdJ/Op80lUm7TU
         TvLVr5PsMk3vg/+uAv6O5N0/rWPbuoWpqxSehPamTdv5BKIDJghJeon8pNdiHApkd0Fq
         WCT+lch+8ljZYgGwrQc9XJ7jzfLWNi5l4F/ctGZX6U/ERwmJYuryDdDKNSWT0a8x5kvR
         h5YJYuykuRcV67TkrerrqCjPOjCaSpfHpeF3veL8L8M1ykOGl0/mJ3MVW+CcWuUJ96Ad
         w6HuF/+ePAYD+h1crIVDH0haIeD7rmv2YEr1p7FEfXkN+23pX3ja837SBuDIORAM7PIR
         NU/g==
X-Gm-Message-State: AOAM530OofOtFMV9PdpRQAIEmCol9GM8qvALsZKtKpkC0+/Jf687cRSG
        MClHYjmUqAX9S2HBe04JWt1GqQ==
X-Google-Smtp-Source: ABdhPJy6juXZ6MIvPp9fezazaGovc34g3quXFekGe9uvbDIyQc+0C+Jxmli6y+mvnR8S1u6+E3UBMw==
X-Received: by 2002:a17:902:7246:b0:149:636f:2fde with SMTP id c6-20020a170902724600b00149636f2fdemr24912300pll.9.1640839366147;
        Wed, 29 Dec 2021 20:42:46 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f2cb:bddc:361b:5398])
        by smtp.gmail.com with UTF8SMTPSA id 93sm25382237pjo.26.2021.12.29.20.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 20:42:45 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v9 0/5] Expand Semtech SAR Sensors support
Date:   Wed, 29 Dec 2021 20:42:37 -0800
Message-Id: <20211230044242.1024940-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

Major changes in v9:
  Use simple pm macro
  Unify use of returning on default
  Add space before '}'
  Use sysfs_emit instead of printf.

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
 drivers/iio/proximity/sx9310.c                |  740 ++----------
 drivers/iio/proximity/sx9324.c                | 1067 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  576 +++++++++
 drivers/iio/proximity/sx_common.h             |  161 +++
 8 files changed, 2126 insertions(+), 629 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

-- 
2.34.1.448.ga2b2bfdf31-goog

