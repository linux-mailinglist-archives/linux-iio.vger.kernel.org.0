Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29000482872
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 21:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiAAUiF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 15:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiAAUiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 15:38:04 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E1C061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 12:38:04 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id v13so26166206pfi.3
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGBAYq4NQf+CmBtjQkoqd9MhmisfF0EM4+c93MaSBYE=;
        b=B2N7W1Vm5GF37uucsNWBnwItO2hPa2M5s1O53aXRsqw+r+j3ePPfTrCL1Pe2H5Mmra
         QEcaTrakHQn52TKRB3soGKZWh8vDSAHG98j8/TYYY3CKQnc6Dzi7NIapvVjrcopyjDb6
         TQ+EkJVtPEmSuLqWBVIRTBKHp5iFgR7N9gKAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGBAYq4NQf+CmBtjQkoqd9MhmisfF0EM4+c93MaSBYE=;
        b=W5N8xy1bjAwfAqePAx90kHeZIY7EnApLSNIcGSQgxDRsiPUE4lGCX7CDByuhpUXqwW
         fu7bKErSklBOz7LkWNUOaQx6xDPq68SNbBbIWjEd8rsNPmMamR0OPIOmyeUiV8TaJOtM
         6XQtYEPjsDd0B/UFe8g7yYUzDiZ3wEknSG/9dveWMgmpi7n8ATWb8JtkVtTq3j5R9kQW
         wGVKJVbVTTU6f1ZsXAkLmdQe35rnLNLOdGv/+AfNLOZ/UTEnhW6hAstFmT9Modozceau
         rkHbEMiSt/2k05ycmgINUkKamfueepjmSeE8a5caA0rseRxQRXIOg1FuSkHrrCNShIkl
         YYdw==
X-Gm-Message-State: AOAM530WdPXtBa/KRhgkVos2Cnk795m4KXABrh+n2SXXIArkkH50LbBN
        H4OjSUckpANWpzq3CbR3bhAKrw==
X-Google-Smtp-Source: ABdhPJxiIrgtHsF41errgthmuas+7BVdmGRSAtIKCZI+IZmqzJwy30CA8fxssYdipinDd2Z4zb7pWA==
X-Received: by 2002:a63:5541:: with SMTP id f1mr35353900pgm.320.1641069483804;
        Sat, 01 Jan 2022 12:38:03 -0800 (PST)
Received: from localhost ([2620:15c:202:201:df49:1d3f:ae08:999])
        by smtp.gmail.com with UTF8SMTPSA id q69sm34701517pjq.41.2022.01.01.12.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 12:38:03 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 0/3] Add Semtech SX9360 SAR Sensor support
Date:   Sat,  1 Jan 2022 12:37:57 -0800
Message-Id: <20220101203800.290387-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9360.
It is a simpler version of SX9324, with only one phase instead of 4.
Leverage sx_common.h interface defined when SX9324 was added.

Major changes since v4:
- Use sysfs_emit instead of printf for real.
- Use SEMTECH_PROX export namespace.

Major changes since v4:
- Use simple pm macro
- Unify use of returning on default
- Add space before '}'
- Use sysfs_emit instead of printf.

Major changes since v3:
- Remove "reference" as a new modifier: it is not needed, indexed
  channels and labels are used instead.
- Use dev_get_drvdata to access iio device structure.

Major changes since v2:
- Register "modifier" as a new modifier.
- Fix device tree binding syntax
- Fix issues reported during sx9324 driver review:
  - fix include with iwyu

Major changes since v1:
- Integrate errors found in sx9324 driver.
- Simplify whomai function.
- Fix cut and paste in bindings.
- Handle negative sysfs parameters.

Gwendal Grignou (3):
  iio: proximity: Add sx9360 support
  dt-bindings: iio: Add sx9360 binding
  iio: sx9360: Add dt-binding support

 .../iio/proximity/semtech,sx9360.yaml         |  89 ++
 drivers/iio/proximity/Kconfig                 |  14 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/sx9360.c                | 893 ++++++++++++++++++
 4 files changed, 997 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
 create mode 100644 drivers/iio/proximity/sx9360.c

-- 
2.34.1.448.ga2b2bfdf31-goog

