Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5B457CCC
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhKTKSL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 05:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhKTKSK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 05:18:10 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD10C061574
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:15:07 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 206so5769587pgb.4
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2obGVTsw8XfhHzcZQLrMHyAIjYbTeOxdfLb5/fMxeI=;
        b=EzJIJIbF0+mgzEpc8uGEfPWuEcpl0dLrgg1MGE+WkspdXZ61fBBwkwL7nwIZjt7ypY
         v6I3aojRZRAGTlgCpKks6ymrfBlQKKgWhBFqsUKK0bvkb2Leejli29niP2C4ZrcLqyTL
         D8D0fvMRa30PKAThsOJG3Ixv5OOlAk/4OihVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2obGVTsw8XfhHzcZQLrMHyAIjYbTeOxdfLb5/fMxeI=;
        b=rEv86y355qkRvTpnw3Q6aoLR3HMScnWYfRN98h/QoVhG9JzkUwQJm3Kbd/DC6V3Xka
         r6SA8HhiKk+J9McIJtJmtaODjGY6ArnT59EuXh78DI/bM8FTYeZzRC9wQC3pd+RB9jaU
         swRt9YKVU/f8F9DQQTheg6+fGkx94UHoC/7A9Xq+Gz3ZB7T0Krjir8q5wu6uc4971I+a
         uiKf4VLzD4Y7QfB8KTavM7g13ltGMHmdZggdHF5I1zdVBgUmO888gU3jcKfTZzg0W0uD
         XeDx1O/PbtOVYee/y7edDp2mi8aeo4cEqfOPOts/l+ej6c32InVmlcaKbpacoCTpiSP5
         FB8w==
X-Gm-Message-State: AOAM530u2gyZSIjdvA1llGRDnYzG9LH6BAjhXbGiv4osZVB+Bo4HvUmq
        36nYvxOYrEIcwjvjf4SIyqUfPQ==
X-Google-Smtp-Source: ABdhPJwm4CcH795cAwq6gg0UFJrHesbHnHmyn8OqEBnUu985Iw13nSDwXN3+frrm7DYL3cIaXmv64Q==
X-Received: by 2002:aa7:9dcd:0:b0:494:658c:3943 with SMTP id g13-20020aa79dcd000000b00494658c3943mr69743215pfq.19.1637403307281;
        Sat, 20 Nov 2021 02:15:07 -0800 (PST)
Received: from localhost ([2620:15c:202:201:913f:8f64:e1fa:a751])
        by smtp.gmail.com with UTF8SMTPSA id m19sm1722074pgh.75.2021.11.20.02.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 02:15:06 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 0/5] Expand Semtech SAR Sensors support
Date:   Sat, 20 Nov 2021 02:14:56 -0800
Message-Id: <20211120101501.1659549-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

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
 drivers/iio/proximity/sx9310.c                |  704 ++---------
 drivers/iio/proximity/sx9324.c                | 1074 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  568 +++++++++
 drivers/iio/proximity/sx_common.h             |  155 +++
 8 files changed, 2109 insertions(+), 601 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

-- 
2.34.0.rc2.393.gf8c9666880-goog

