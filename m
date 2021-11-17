Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF06D45436E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 10:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhKQJTz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 04:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhKQJTy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 04:19:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAEC061570
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 01:16:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k4so1579941plx.8
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 01:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlOjod4DjAps34kxUhxx5I3zAwME7JC2gUbauEVsiOI=;
        b=UcBha6EZ+ltvCs035ihraHV7Em1ImiiNBcXJeL/vy4MuYk+AtTgsa0fFFV5HeNcMfM
         MPUGMq2V1uIroYi7AYGqpDV5N+du8yICEMDbDaxkiuLZlTggB/hNpQte7MLFEt/hHKNq
         S7uRCvvyh3Y7oB2YGGyjFQMecUFkyA/mMm30Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlOjod4DjAps34kxUhxx5I3zAwME7JC2gUbauEVsiOI=;
        b=T2fhJL+G8Z7y5rmaxCAjnqk/Zhjid7UIwtfM+EOBm8NhsQulLZnRIs3f6h+UuEZLKv
         /epyFUv8wSweYGKCoDByWMRu5l6O/fUNC1tkeaCK68frdfUsVOohgJlD0vLp+OTQKmQT
         rUuJVmuUxdGq5pEaqc7uSGEFTEIS9euU5S8fbJ+S+TPzZ4ZwuArOorASaCURGw3LT5eI
         N408MyxsIsb8VbGuMfzpRaqsLhjpPfEV8JuhldQWyfsXT3jbCjj/ZzEQG2VNlZzFn13x
         gpoI7yntIXi81BlH03dTeC9p7fA8pv0jDccyruXVpJbJxWjQAyFE2jl4Zkrh0QolRgpb
         ygmw==
X-Gm-Message-State: AOAM531NBeEstrAhHU2dpHN07zbVYZAWzyXsWMMNJuEpv8/f5nMUn9XW
        Xjhbxd3kP7lGCxZ16/ITKLmNQQ==
X-Google-Smtp-Source: ABdhPJzqwGr+cLhA6UirT0f0ruzljutydP7GHsYAO90jcROYCdoyFUxmRSltWs4LRCtpegMhNaEDFQ==
X-Received: by 2002:a17:90b:380a:: with SMTP id mq10mr7457016pjb.61.1637140616340;
        Wed, 17 Nov 2021 01:16:56 -0800 (PST)
Received: from localhost ([2620:15c:202:201:327f:7baa:380e:33a3])
        by smtp.gmail.com with UTF8SMTPSA id qe12sm5202410pjb.29.2021.11.17.01.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 01:16:55 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/3] Add Semtech SX9360 SAR Sensor support
Date:   Wed, 17 Nov 2021 01:16:50 -0800
Message-Id: <20211117091653.2829677-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9360.
It is a simpler version of SX9324, with only one phase instead of 4.
Leverage sx_common.h interface defined when SX9324 was added.

Gwendal Grignou (3):
  iio: proximity: Add sx9360 support
  dt-bindings: iio: Add sx9360 binding
  iio: sx9360: Add dt-binding support

 .../iio/proximity/semtech,sx9360.yaml         |  91 ++
 drivers/iio/proximity/Kconfig                 |  14 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/sx9360.c                | 909 ++++++++++++++++++
 4 files changed, 1015 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
 create mode 100644 drivers/iio/proximity/sx9360.c

-- 
2.34.0.rc1.387.gb447b232ab-goog

