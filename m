Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA548198D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 06:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhL3FPL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 00:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhL3FPL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 00:15:11 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B59C061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 21:15:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u20so20432436pfi.12
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 21:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Bu87Ug0Ml9SGoX5Ytzv/gUk/ATufiPAaQrppqAHRUQ=;
        b=hsIdrQpfnCTVma2s3Kqt8ObcclJsXy4c4pXMDD5VjHpL91n+ZI2o1lbueiCjYAp2Ok
         mKsAOnEtd1/7HXykYfPKoSw3k2k1x9Cj/l7MymokqBmTm5sW9OKgnJ2o7ahAAg/Cg8az
         ubbKYRfG48DgQ4qi0N64uTXGW8k+dWQL176F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Bu87Ug0Ml9SGoX5Ytzv/gUk/ATufiPAaQrppqAHRUQ=;
        b=O6ukuffH0eK6AdLA9nxoL5jtURUWNP+umQYJ94ziLfRy5SgO0wMnNz26FIyACU3Kfl
         LMyHxcdra4y59z7eH0xFhyH29vAZsDOnhH3dn5YYQsjLM359wRkir6EFP6VyNaSAsGm8
         De0VJyjKY+XraL8fm1rPVZC6nqGEfZ8auFnXryMIgmEllDzjkmWBv9EEdGVEWKdQOTg/
         l7beefNnHmmA/r8Sie4IZYFzgN246fwcXKZ6RxnEdre3BcCHb1IRBlLlLVkfZkFBQ/9X
         0h/jNahErgbuD341/4jyQrPxU5diiEnu9DH2MNqHo5C4OtNfh5jUL4l55uHDWSSVOctj
         jWJQ==
X-Gm-Message-State: AOAM533XINqYPjZnihmSvnTTrX9FR2ciFtwXxxP3nrSl12Sodi4szM8b
        sM4qbClD234CL/eyiMESObtgfg==
X-Google-Smtp-Source: ABdhPJz7XCvWphDT53lUbJ3rf86Xy13sQhF4oqQKvdyStGUWMT5dSALcdagMClmA8xPhJbNLs0OXJA==
X-Received: by 2002:aa7:950d:0:b0:4ba:787f:c5dc with SMTP id b13-20020aa7950d000000b004ba787fc5dcmr29688734pfp.46.1640841310258;
        Wed, 29 Dec 2021 21:15:10 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f2cb:bddc:361b:5398])
        by smtp.gmail.com with UTF8SMTPSA id b21sm24068110pfv.74.2021.12.29.21.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 21:15:09 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 0/3] Add Semtech SX9360 SAR Sensor support
Date:   Wed, 29 Dec 2021 21:15:04 -0800
Message-Id: <20211230051507.1053806-1-gwendal@chromium.org>
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
 drivers/iio/proximity/sx9360.c                | 892 ++++++++++++++++++
 4 files changed, 996 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
 create mode 100644 drivers/iio/proximity/sx9360.c

-- 
2.34.1.448.ga2b2bfdf31-goog

