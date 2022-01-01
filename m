Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E816482876
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 21:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiAAUiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 15:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiAAUiU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 15:38:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC41C061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 12:38:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso28484161pjb.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ht6YiRR2imdQgC4tI4akrcUQCfdHV6BkfOinYvnngpc=;
        b=VD2iiQ2G9TDrHvzSZMIFKhljoKhdaC2I0XanPru7G5/OppVW4w6R7s7TLdrL1Fxwrd
         ALdTV7Dr9cLlPxbbBPE2W+XegGCRdI3kZ4nZZFjY4Mlvr2xW6qeivj2XiLqaSX2oPtw/
         hIy3NSbXlUNeHuyxDLyjFrCRA/xPFoHOeTFwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ht6YiRR2imdQgC4tI4akrcUQCfdHV6BkfOinYvnngpc=;
        b=WyBSwOe5CJcaDAijEA8D6psEF0jf5hlTSSygie3DwRRXki1M/ldF0FVgEpTiYxSI2E
         UFmx7L1n8uBMgxD1kFrxkDBJJA/NsZrtXB/c7GKXGBrEyR9aoVHJbQLEHbxMbgjZUhEe
         dz8XaUXVXuwkgD15lQ/wb/yAT7fIHtdmAAxLCzi5ja1MsBdayW9VhcnFek+uMvnQ1HFS
         r9UgLfxygmxQmCRiWvnbap7J/Dugl1hwBd2iFRxcVfbkmFRLmwvuoZza0VwxbG+Wc1XV
         OBPyF4fSFVhpYOusyVLNdiXZRAqpcbEsXryR4ZGSGkmr7ogDBLAJRANhHS1B1H31xQX2
         LSZg==
X-Gm-Message-State: AOAM5315lRby3cqU3Yj8wtpDLfCU7KIr8YZCDFGF9+WvNm5DEAcnWeVo
        Nm5Rrac11NGUOJ7YF/67dmX6gQ==
X-Google-Smtp-Source: ABdhPJyQI3usSVPmD03EW6wpXsLETaVagLbP4BxZKJ9F4Vg4H+AxuHX0IyL9fdWhttYJcOgnzuLnyg==
X-Received: by 2002:a17:902:e549:b0:149:ad2b:f0fa with SMTP id n9-20020a170902e54900b00149ad2bf0famr8494136plf.123.1641069500299;
        Sat, 01 Jan 2022 12:38:20 -0800 (PST)
Received: from localhost ([2620:15c:202:201:df49:1d3f:ae08:999])
        by smtp.gmail.com with UTF8SMTPSA id i4sm17180720pjj.30.2022.01.01.12.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 12:38:20 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v10 0/5] Expand Semtech SAR Sensors support
Date:   Sat,  1 Jan 2022 12:38:12 -0800
Message-Id: <20220101203817.290512-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

Major changes in v10:
  Fix spelling in comment, unnecessary empty lines.
  Add symbol namespace.
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
 drivers/iio/proximity/sx9310.c                |  741 ++----------
 drivers/iio/proximity/sx9324.c                | 1068 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  572 +++++++++
 drivers/iio/proximity/sx_common.h             |  157 +++
 8 files changed, 2120 insertions(+), 629 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

-- 
2.34.1.448.ga2b2bfdf31-goog

