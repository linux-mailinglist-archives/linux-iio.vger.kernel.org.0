Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1121C7DAF
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 01:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgEFXDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEFXDe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 19:03:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED32C061A0F
        for <linux-iio@vger.kernel.org>; Wed,  6 May 2020 16:03:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a32so1750882pje.5
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2020 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmaPtEHyPvGoB0RVI/vcu9s3SLlgGAwwRY3BU1xGh4w=;
        b=jJj8oVccZvz0VnXx/RxslRSl6lS7KnhNSbt4svw5Um1pu8LUgfMmb9WcLEL1iqiPLK
         G+4wMfzeASCOFSnrKIGoRn/y6nbJIYl1NV6RfpsHJnnxes8xXH6iXuSrmE3Njx5tX213
         T2IC0Deegw5PZ+VMuBtGBSRU6fSXOqAAwinVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmaPtEHyPvGoB0RVI/vcu9s3SLlgGAwwRY3BU1xGh4w=;
        b=r4kamdV307KE1OTI85rNlQXR6Tv0s0pW012lrUHwmaBGB82QqwZldU8/ZRZomLcnip
         yOC1TKndQTEAagc/G39ypeRC6WTRtk/MGH0aNcuBsPLOViOhAo70M5HsaQCyVoQNRV2w
         nJVWowoWYVWmqZIYxjn6+UUNvSdCECnZfR1ih4YIhIoL0ujNPJ8MU320HmKW1/7BXCzq
         aYFitzaN6aUnldOAUmBF2554XMNhm/GV2BLSzJFJaJLvrpg7DHEOlAskY9Bb5v3DrTbJ
         WwSzrpuGOi/nc2Ss/6QtMFveqH/6USLZxymvPBoTKvlnPOeWSCJoU3XjBvw03201NaE4
         JpVA==
X-Gm-Message-State: AGi0PuaHVm1/44HUG8gkat2FCljIEVYsf4gTShnQVPMHW+jM3obbavM8
        zoDm7/1ZPpYY2B8wJR1iTTnXxA==
X-Google-Smtp-Source: APiQypKUO7bfvDMai2oDuvIVuwr3nwkhaoD7oZ559rsBY2hRfYMuzzVDjlXNMNfwdicLgaOeZJ2Bjg==
X-Received: by 2002:a17:902:c3d3:: with SMTP id j19mr10226448plj.340.1588806212706;
        Wed, 06 May 2020 16:03:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id 189sm2887851pfd.55.2020.05.06.16.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 16:03:31 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/3] iio: cros_ec: Add support for RGB light sensor
Date:   Wed,  6 May 2020 16:03:21 -0700
Message-Id: <20200506230324.139241-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for color light sensor presented by the Chromebook Embedded
Controller (EC).
Instead of just presenting lux measurement (clear channel), a color light
sensor is able to report color temperature measurement.

The EC, using factory settings, can transform the raw measurement into
the CIE 1931 XYZ color space (XYZ) and take adavantage of color sensor
autocalibration to provide the most accurate measurements.

Gwendal Grignou (3):
  iio: Add in_illumincance vectors in different color spaces
  iio: cros_ec: Allow enabling/disabling calibration mode
  iio: cros_ec_light: Add support for RGB sensor

 Documentation/ABI/testing/sysfs-bus-iio       |  27 +
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
 drivers/iio/light/cros_ec_light_prox.c        | 469 +++++++++++++++---
 drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 -
 .../linux/platform_data/cros_ec_commands.h    |  14 +-
 6 files changed, 441 insertions(+), 76 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

