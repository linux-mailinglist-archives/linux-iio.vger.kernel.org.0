Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68F471F5A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 03:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhLMClB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Dec 2021 21:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMClB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Dec 2021 21:41:01 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA1C06173F
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 18:41:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k64so13655460pfd.11
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 18:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeE3TWiejtVu79GuL4n7y2KRRoO6BQXVZvJaO+tIahw=;
        b=KCcMtpsg/bqUppt8ksWMf6XI9BN9jm/wzBofOitznXsas3+wqLsoJGlFCjT0i1L63/
         tiFzSGd9wDDOt3D+79CfwIYnI70slVyZll+LCGPQtrOeyuvL0jalLbaaHWKT+h39qKZh
         wheWPFZiy97xti/LG7Wgm7KmjULZO7uCwJ4TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeE3TWiejtVu79GuL4n7y2KRRoO6BQXVZvJaO+tIahw=;
        b=qh7gI59Cx+rTWrjC2qZB5S2Fd7jYHkQfgHJP4G3G6SeMxH0kogx8kffyf4H4FEcu25
         aIH0wCoWCTf/GfxbwipNuSNTLbGZ9nwlzA7pscMjFrsTR37ljp7oyOi7myHqAH5EC9Iz
         B147/64zzn9+/A/IaaD/XhFXvaDPYRrdt+9t0SoFNV2j/g8IvQatQJvoll05fUoVtlMd
         jPPjoqfG8RLj2iErkxZ7mjKzUMowWtK2MlFLJTN4+i0TGX65vh/7xpEWadMRG7ANC2cW
         s09vuNPsrahvbLRsVQs63chLuajDOGXOOutkPJNqI5jnmITSI45E+KjpiZr66UQPgkio
         4u2A==
X-Gm-Message-State: AOAM530MTP0qS34WEWOXTdPOx3xVkRSKkJJOrIB4/d0Ve4T90ZIy3gzq
        48HV592HowRS6sLeOTM9gxPLmQ==
X-Google-Smtp-Source: ABdhPJwb6ChiZ2AWx+VVljo0KEh7msQ/EGiA5c+ZLuQQFtlBBx50nUFyNhhSxCcIS2EtbZiD25uJrQ==
X-Received: by 2002:a63:e24:: with SMTP id d36mr40696768pgl.175.1639363260736;
        Sun, 12 Dec 2021 18:41:00 -0800 (PST)
Received: from localhost ([2620:15c:202:201:9cf8:7f4:ed82:2d07])
        by smtp.gmail.com with UTF8SMTPSA id x14sm5206850pjl.27.2021.12.12.18.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 18:41:00 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/4] Add Semtech SX9360 SAR Sensor support
Date:   Sun, 12 Dec 2021 18:40:53 -0800
Message-Id: <20211213024057.3824985-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9360.
It is a simpler version of SX9324, with only one phase instead of 4.
Leverage sx_common.h interface defined when SX9324 was added.

Major changes since v2:
- Register "modifier" as a new modifier.
- Fix device tree binding syntax
- Fix issues reported during sx9324 driver review:
  - fix include with iwyu
  - 

Major changes since v1:
- Integrate errors found in sx9324 driver.
- Simplify whomai function.
- Fix cut and paste in bindings.
- Handle negative sysfs parameters.

Gwendal Grignou (3):
Gwendal Grignou (4):
  iio: add IIO_MOD_REFERENCE modifier
  iio: proximity: Add sx9360 support
  dt-bindings: iio: Add sx9360 binding
  iio: sx9360: Add dt-binding support

 .../iio/proximity/semtech,sx9360.yaml         |  89 ++
 drivers/iio/industrialio-core.c               |   1 +
 drivers/iio/proximity/Kconfig                 |  14 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/sx9360.c                | 891 ++++++++++++++++++
 include/uapi/linux/iio/types.h                |   1 +
 6 files changed, 997 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
 create mode 100644 drivers/iio/proximity/sx9360.c

-- 
2.34.1.173.g76aa8bc2d0-goog

