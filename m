Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21DF444F79
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 08:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhKDHPr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 03:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDHPq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 03:15:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55048C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 00:13:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r28so4695152pga.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5Nz1B5eLt7T/KXVZ9WyJWI1uBbrPbhN2+93MNCUUos=;
        b=VzawAiJLAeukQsNjq6ptp/IJ4GFfFn7R6eawDWFJwRKzHynTIfUfH5OcO+W0fxj0Tn
         lau/4k7jNHlBdDYmehXn5L8rHRvJ3C+9IWbZ/JDyCx7QixZVT0/9Mre8pZo1sdSEwCW2
         B9b+7K8GBuRo9/MafI367s172I5q6awCNwyQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5Nz1B5eLt7T/KXVZ9WyJWI1uBbrPbhN2+93MNCUUos=;
        b=Dfip7G0ujEnFbD8P9H4zojuTP2dVcst+fJhtoG5iIO1UCGDRpaqV4tMkqqjRFBQxpV
         HldkZF9205sW9tW+O83Ml2eTCP4+i8+/t0NcaJwhKiOvCzgcKSz8ea+fpzB6u181k09M
         0YhhWA6eWqdEjZejQW2i/hNzNHDU7DOOhHFRRsZA0A3A2yWwAyqqBz0WA3UvvCB/vDBr
         0vVE0UvK65N87jxV7yJqCqsZ0h/GTbanJnka1daPVJyjXxYZZ0hgJL61NnRDnD5enG+H
         eVpjDdZbjI5cEAe9Z1ebSSmf3f+UvTdTizUEGqdYM87vwnlOzykpOdDucZfqBrdxX41q
         TGZg==
X-Gm-Message-State: AOAM533PPB17VntGC+QpbU/NAXXRNjn9YgEmVA6gmzomHaqGj2yurWrS
        D3tv3Rc/yrg8NlCBOETxX8jvug==
X-Google-Smtp-Source: ABdhPJxnJyQGaJQ1m6XQ+1I5VsXm97JTBnSmTVzCufGHLO+sn0ntfDJ4/deGiXr4fQvhPfuKJZFshQ==
X-Received: by 2002:a63:3d4a:: with SMTP id k71mr37799520pga.276.1636009988706;
        Thu, 04 Nov 2021 00:13:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id fw21sm6720727pjb.25.2021.11.04.00.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 00:13:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/5] Expand Semtech SAR Sensors support
Date:   Thu,  4 Nov 2021 00:12:58 -0700
Message-Id: <20211104071303.3604314-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

Major changes in v2:
  Better interface between common code and drivers
  Document SX9324 phase configuration

Gwendal Grignou (5):
  iio: sx9310: Add frequency in read_avail
  iio: sx9310: Extract common Semtech sensor logic
  iio: proximity: Add SX9324 support
  dt-bindings: iio: Add sx9324 binding
  iio: sx9324: Add dt_bidding support

 .../ABI/testing/sysfs-bus-iio-sx9324          |   29 +
 .../iio/proximity/semtech,sx9324.yaml         |  140 +++
 drivers/iio/proximity/Kconfig                 |   18 +
 drivers/iio/proximity/Makefile                |    3 +-
 drivers/iio/proximity/sx9310.c                |  705 ++---------
 drivers/iio/proximity/sx9324.c                | 1088 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  575 +++++++++
 drivers/iio/proximity/sx_common.h             |  158 +++
 8 files changed, 2112 insertions(+), 604 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

-- 
2.33.1.1089.g2158813163f-goog

