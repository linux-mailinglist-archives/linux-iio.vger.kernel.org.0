Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725164797CD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 01:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhLRA1K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 19:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhLRA1J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 19:27:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1763BC061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:27:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k64so3508745pfd.11
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TA2bo/8U4Adag1lfRkw3dBGfF9/4mM+zwVApz7qSSOo=;
        b=bn/qeHkS3YigVlgXza+RhRkR1402EdPYCBvqVbHajZYASP0vxgxrnnFFsxsI5oK1oC
         wcS06aBiW1+DNaIHfD7dFpVDMWu43ysr056VcgbsYWK0LWPXEJsaS61ms+QKSm8ZtL9a
         dgIDgJUSdoc20hXVu29kT+Mm5G8v6ws5NZ/cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TA2bo/8U4Adag1lfRkw3dBGfF9/4mM+zwVApz7qSSOo=;
        b=1mpFXjsLoZ063ZZVKFJgWKWlFOxNyX590MpuE6Bwb7ctHhMnQcrXytqX0rKoWke2s8
         LM8oPaO5vz7Xns3iUYwzTJpFA98jBc2KAsezRy2pIHar4/yi70G785pSWYYYwNQZaYD1
         c624w+qFHNPatd2ze3zM1xvVn12qTfao32rMKjqpQypjY5ZcT+E1N8otnFv9bIarcPsN
         JGwNKH1OoPdkXQPuE2ROqiRPVVT5T0WR6EKK1tHc+1v/A4Q+AceWrJYnVLlYQMnXsCaK
         BPU+N/hr2nMeffY7Kw7Bg/SNjvDccZsYWlOPu9ZHVGsTDzfrOABjnFGGnVTgJkpx+u0c
         ji8w==
X-Gm-Message-State: AOAM533DA5tcrIRgejYOQli/PQhFO3IsMbdb16SlipR5roAmvcCLbm2A
        YodtABymSFrrq6VeH0gqZXz/Dw==
X-Google-Smtp-Source: ABdhPJy+oE9iLcjG4Anjar5XTP/YZNF6asAfWV7XmUu7FheWDLxgnO3Yn+cZnH4PLgELfxcUGDZU9Q==
X-Received: by 2002:a63:e657:: with SMTP id p23mr4953334pgj.337.1639787228535;
        Fri, 17 Dec 2021 16:27:08 -0800 (PST)
Received: from localhost ([2620:15c:202:201:2bc8:cefc:f407:829])
        by smtp.gmail.com with UTF8SMTPSA id c19sm11260916pjr.2.2021.12.17.16.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 16:27:08 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 0/3] Add Semtech SX9360 SAR Sensor support
Date:   Fri, 17 Dec 2021 16:27:02 -0800
Message-Id: <20211218002705.3099096-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9360.
It is a simpler version of SX9324, with only one phase instead of 4.
Leverage sx_common.h interface defined when SX9324 was added.

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
 drivers/iio/proximity/sx9360.c                | 900 ++++++++++++++++++
 4 files changed, 1004 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
 create mode 100644 drivers/iio/proximity/sx9360.c

-- 
2.34.1.173.g76aa8bc2d0-goog

