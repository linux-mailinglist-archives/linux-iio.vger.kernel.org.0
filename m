Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFD71C2AE9
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgECJcV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgECJcV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 05:32:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F3C061A0C;
        Sun,  3 May 2020 02:32:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so5296622wmg.1;
        Sun, 03 May 2020 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v48F27nCpiSeuCStzuPRcHVl03E6b+T/M/LToBjyeBY=;
        b=o2JeUOT/SAXzjoRGgMb73kDM41GlcTO/bK49XobiuZLY6ZKbkGmf6x3HrXxn3qeRkX
         mDaQTzWMPkSTNEznRFg4V3lOo7hdPNjIKsSXRny/MsGt+VSHjyLmk8BpiN9vNt0a6s33
         LrwRXg7NEJ8OSkZk9oWFy1sWPBE/HVk8z9ykn+ZFjERu8+q//wBLQNok5Xdojep2B0iU
         X/18FylZ9Q8LVR2YM38AHAbfbCuOCsTHdxVsZbRVmX02GXllGnCi46UNY6f7qcN2Ynbo
         r3MvFJYH3OfVuD5fR/HKfRy1b4irEH58iuPUHAXGs3+7KpenCGMbvNKo5OspY2Hzcq7I
         x/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v48F27nCpiSeuCStzuPRcHVl03E6b+T/M/LToBjyeBY=;
        b=TA9TLcNKBIFGeQv/PqtVHXrRXHYp9CL1k7OfYV1W8AKl/cnkDMPrItZTgkLOsYgdBT
         n90mt6WBQUzye7e2alX+6s7D3AdqIwPfgMj23VJZ8eXt3fK/ZeUu0KsIeNYWLBlwCAJH
         HGmMAciKqWhvzFm61ac3iugj8ZVE2ubpN8beanr7JQc5TbwZR5WwE/MnhPLDQUJRF3lC
         Fw4TPgKQrtUBQtBKwvh+56uaHydlaClraF1QUh0i5VX6WRbAHoXo/aoifqT7nDDsWQLZ
         mcnKjN9mRH20ga59K1Sa3R5i1B9vLLMgmVZL7lwqpbX1BKJhzztVyV8JuKetrnzK5FOo
         YX2A==
X-Gm-Message-State: AGi0PuYxVYv5QXDgSyK5qOJqTSggZgNL6CcsDJ8jsUWpXuTogDE3NVzR
        dd0+NOINde9YzlEHG0TrdCLOktcuR68=
X-Google-Smtp-Source: APiQypJkISHrzMTy4bQ64FUEa7px7gnv9suiYvgrZG+diRIAjRf09HqMqMCcC7eTugA1qtJbhKZSbw==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr9279138wmn.154.1588498339898;
        Sun, 03 May 2020 02:32:19 -0700 (PDT)
Received: from meru.home ([2a01:cb18:832e:5f00:1cf0:acc0:9003:83d6])
        by smtp.gmail.com with ESMTPSA id e17sm10086963wrr.32.2020.05.03.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:32:19 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v7 0/5] iio: vcnl: Add interrupts support for VCNL4010/20.
Date:   Sun,  3 May 2020 11:29:54 +0200
Message-Id: <20200503092959.8806-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Here's a v7 fixing Jonathan remarks.

Thanks,

Mathieu

Changes from v6:
* Add a missing Signed-off" tag in the first commit.
* Clean exit pattern in vcnl4010_buffer_postenable.

Changes from v5:
* Fix i2c measure reads that are broken on the current driver for be16
platforms.
* Use read_avail callback for sampling frequency.
* Move scan_index setting to the correct patch.

Changes from v4:
* Rename vcnl4010_in_periodic_mode into vcnl4010_is_in_periodic_mode
and vcnl4010_thr_enabled into vcnl4010_is_thr_enabled.
Also fix bitmask checking in those functions.
* Refactor vcnl4010_write_proxy_samp_freq to loop in the
other direction.

Changes from v3:
* Use i2c_smbus_read_byte_data and i2c_smbus_write_word_data
for read and write functions.
* Rename vcnl4010_prox_threshold to vcnl4010_config_threshold.
* Do not lock i2c accesses as they are already protected.
* Fix a typo in irq name.
* Do not provide ALS sampling frequency operation, as ALS data
are not buffered anymore.
* Return bool in vcnl4010_in_periodic_mode and vcnl4010_thr_enabled
functions.

Changes from v2:
* Rebase on iio testing branch.
* Remove useless test in vcnl4010_probe_trigger.

Changes from v1:
* Split into four different patches.
* Use iio_device_claim_direct_mode to protect
raw access from buffer capture.
* Requesting a sampling frequency above the limit is no longer possible.
* Inline read_isr and write_isr functions.
* Remove IIO_LIGHT data from buffer capture.
* Make sure postenable and predisable functions respect the common form.
* Do not set the trigger by default.
* Remove the devm_iio_triggered_buffer_setup top half.
Mathieu Othacehe (5):
  iio: vcnl4000: Fix i2c swapped word reading.
  iio: vcnl4000: Factorize data reading and writing.
  iio: vcnl4000: Add event support for VCNL4010/20.
  iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
  iio: vcnl4000: Add buffer support for VCNL4010/20.

 drivers/iio/light/Kconfig    |   2 +
 drivers/iio/light/vcnl4000.c | 753 ++++++++++++++++++++++++++++++++---
 2 files changed, 689 insertions(+), 66 deletions(-)

-- 
2.26.0

