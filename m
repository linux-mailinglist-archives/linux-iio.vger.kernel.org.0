Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47046457CDF
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 11:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhKTK3l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 05:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKTK3k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 05:29:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E7AC061574
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:26:37 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b11so10036326pld.12
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+63H/pZV7OrW7pJKtRHJtgiDxP+xke6g5HxzldLmCl0=;
        b=g9ZwdgwwM8K5Sp3g2QXkztbdK1qD2CQ6tYDv5TlZ1foZrVn5hoOA4KD9aWDmDUIrGn
         X0Uxho5lOx+JITj9EqkaLnQOZLwR0F2IRETc1sB64eipHlvqdqv3H3FlLFhxi4jITC8X
         Jw86kbCYtj25Ac7+gFE42pvnyV6mWfnLFU53c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+63H/pZV7OrW7pJKtRHJtgiDxP+xke6g5HxzldLmCl0=;
        b=CbRbImBLJoeMgfmPZeicFX7IhkniVRgMEb3jRnXi4NlrwWjUavt8+C6+OIc+6+CvN2
         aIyD8DXHneO6CCwVJ9ecKE37dlpPw2iQWjy8gYl5/57B57deEOe3HUesDCTMbHNpSvU0
         PtuGm3zjvPReOH17R493rXBxK8NkHOM3gblNbV9EBcQfdcjMML92cMEeg3xe970ijwgH
         gL5G8+iTtXejRKMNPDOSzxdiQZjJhgHXsJOfEV6uccJB/JyTWlM5t6umSNdcJOEplYEB
         UdCgbVslIWKafpuz3Pe+44JCLRzEqBq+zzg5SxIpuUjbxLHcsYIZRmj3fhA2I4/wk67f
         ckgQ==
X-Gm-Message-State: AOAM533VWg1Kg1VfEto4EUKcyGIY1oKUTP7LDUGXof57gVmbEFfNfUa4
        +gVN13RFLFlf0dWYgiMcIppHtA==
X-Google-Smtp-Source: ABdhPJwfRQsvqBdpVbWZtCc5LwdE8371w8ZenBfhCZ6I4Sd0PlQNO+WKSez+YCI+phlI2igKndxeZA==
X-Received: by 2002:a17:902:e8d4:b0:143:88c2:e2c9 with SMTP id v20-20020a170902e8d400b0014388c2e2c9mr86499231plg.12.1637403996895;
        Sat, 20 Nov 2021 02:26:36 -0800 (PST)
Received: from localhost ([2620:15c:202:201:913f:8f64:e1fa:a751])
        by smtp.gmail.com with UTF8SMTPSA id j13sm950524pfc.151.2021.11.20.02.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 02:26:36 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/3] Add Semtech SX9360 SAR Sensor support
Date:   Sat, 20 Nov 2021 02:26:31 -0800
Message-Id: <20211120102634.1688190-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9360.
It is a simpler version of SX9324, with only one phase instead of 4.
Leverage sx_common.h interface defined when SX9324 was added.

Major changes since v1:
- Integrate errors found in sx9324 driver.
- Simplify whomai function.
- Fix cut and paste in bindings.
- Handle negative sysfs parameters.

Gwendal Grignou (3):
  iio: proximity: Add sx9360 support
  dt-bindings: iio: Add sx9360 binding
  iio: sx9360: Add dt-binding support

 .../iio/proximity/semtech,sx9360.yaml         |  90 ++
 drivers/iio/proximity/Kconfig                 |  14 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/sx9360.c                | 889 ++++++++++++++++++
 4 files changed, 994 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
 create mode 100644 drivers/iio/proximity/sx9360.c

-- 
2.34.0.rc2.393.gf8c9666880-goog

