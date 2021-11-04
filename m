Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFA0445025
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhKDI06 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDI06 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:26:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2ABC061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 75so4807756pga.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uchlRa0uaxk27ENkQrO+9CN7Oxk/AoeUfpJ3avZ8Qxw=;
        b=OUczJOfqmakQQ/EDlxai+J59KFlArqLTO+ZHpXCdPQnpSXfcDyyEkOp4beGJPkPrkn
         C+PyMOV0WWaq6cp8Ba0bBrvKZOpqCb7DJwID3iI5vpWagckKtQQeBwuELPWjkz24iFlI
         9aeNEEDkW9jw2dAxRi9QBRbcnJqeID68gOCwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uchlRa0uaxk27ENkQrO+9CN7Oxk/AoeUfpJ3avZ8Qxw=;
        b=wfud4SYDWkrFQK5knAm4C/4B9EsgjI0F7cvEi69o5Ls14IuPkJ8pgM0L1TtuJMylQx
         4BckyIJAmZBCOJb6u56uU2X9G414q0BtJjO5bK9Nevzf1bHfqPpx9oqoypXNjgBLzKbN
         e68h6hzUBNdICu3PWLv5kkwY9Nvl4lY7Y+pLu2DK1Vm5IrQgwFrWZdvGeuF7fiyAqjCP
         7QA+JZ0vlARzNA6lvfVTTgCk5L8JEWYekzSver9xZTyHCSS3pZ33fjvcWLOfhvqWDjaN
         zxPccPe6HEEGZjdcIyrm0A1ReXSKqPMLkPPvmHcqMMy1pjdko/DGNU1Fin4+EXnrg7jA
         cC+Q==
X-Gm-Message-State: AOAM531X6kDxdB6FNF8nOqC2ZU1ZxOlZPsqqe1lw4TW9uOCjdGGZOxbA
        KpBQ0nwzq/WJmMCAjTCPNHdz5g==
X-Google-Smtp-Source: ABdhPJyXZG27eXEYhULbZEuOfnPiYnVhbOMfByjKEg4+taszvQgpRSIZsq/HaazaAl5e0utCDrLg5w==
X-Received: by 2002:a63:e00b:: with SMTP id e11mr37918609pgh.190.1636014260527;
        Thu, 04 Nov 2021 01:24:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id x13sm3558941pgt.80.2021.11.04.01.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:19 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 00/13] iio: Use scan_type shift and realbits when processing raw data
Date:   Thu,  4 Nov 2021 01:24:00 -0700
Message-Id: <20211104082413.3681212-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Using scan_type has source of truth, use shift and realbits instead of
constants when processing reading sensor registers to produce raw sysfs
entries.
The same shit and realbits are already used by the libiio user-space
library to present channel information from device buffer.

Fix only a handful of drivers, where channel scan_type was accessible
in the function handling the raw data request.

In mpl3115, use a 16 bit big endian buffer when reading temperature
channel to improve readability.

Changes in v2:
- Split first CL, one CL for each driver
- Add realbit for sca3000 temperature channel
- Remove constant in bma220 driver.

Gwendal Grignou (13):
  iio: bma220: Use scan_type when processing raw data
  iio: kxcjk-1013: Use scan_type when processing raw data
  iio: mma7455: Use scan_type when processing raw data
  iio: sca3000: Use scan_type when processing raw data
  iio: stk8312: Use scan_type when processing raw data
  iio: stk8ba50: Use scan_type when processing raw data
  iio: ad7266: Use scan_type when processing raw data
  iio: at91-sama5d2: Use scan_type when processing raw data
  iio: ti-adc12138: Use scan_type when processing raw data
  iio: mag3110: Use scan_type when processing raw data
  iio: ti-ads1015: Remove shift variable ads1015_read_raw
  iio: xilinx-xadc-core: Use local variable in xadc_read_raw
  iio: mpl3115: Use scan_type.shift and realbit in mpl3115_read_raw

 drivers/iio/accel/bma220_spi.c     |  6 +++---
 drivers/iio/accel/kxcjk-1013.c     |  3 ++-
 drivers/iio/accel/mma7455_core.c   |  3 ++-
 drivers/iio/accel/sca3000.c        | 17 +++++++++++++----
 drivers/iio/accel/stk8312.c        |  2 +-
 drivers/iio/accel/stk8ba50.c       |  3 ++-
 drivers/iio/adc/ad7266.c           |  3 ++-
 drivers/iio/adc/at91-sama5d2_adc.c |  3 ++-
 drivers/iio/adc/ti-adc12138.c      |  3 ++-
 drivers/iio/adc/ti-ads1015.c       |  8 +++-----
 drivers/iio/adc/xilinx-xadc-core.c |  2 +-
 drivers/iio/magnetometer/mag3110.c |  6 ++++--
 drivers/iio/pressure/mpl3115.c     | 16 +++++++++++-----
 13 files changed, 48 insertions(+), 27 deletions(-)

-- 
2.33.1.1089.g2158813163f-goog

