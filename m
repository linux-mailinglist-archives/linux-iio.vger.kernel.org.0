Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88281B45E2
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 15:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDVNJI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 09:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVNJH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 09:09:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83374C03C1A9;
        Wed, 22 Apr 2020 06:09:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so4915108wme.1;
        Wed, 22 Apr 2020 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKZeIF5oa3PJGYfL412u0zBLwHBoYTt9cbGj5XIHl7w=;
        b=NZ8PkCeHEJb93tczaENRAIVlVsv5YvvQfIvNgzZqUu90AJ2bRIxEhOHszY209N/LLN
         uFndkxXGY1EJGgQlzVnWX+F6wk8mfNgrdTtMmC6SJ+9hV/6wIntc7oU4j7ku1ASfNjGT
         AkiyNOQO2FD7kfl8UmcKrH0Qkfo3SooN5iYYvkGUn5MWryhIxaYYTmQ/+uVByK5+5Lan
         pcKv3RjWbLoplpSPoK0MI7f4LXUuqqMhmz3CgIWyv/iM42JqvG0/daXbMxt5mHkVlbce
         D60rNLSNGzc4YX5P896pH05DNWDOFxOLZs8DfEa7Rfjszbb9arilSw4GmHpVK9FO1tr5
         LUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKZeIF5oa3PJGYfL412u0zBLwHBoYTt9cbGj5XIHl7w=;
        b=oTDNaJsLO/bkIvR/wt5z0P0Hc1MxT7/IKf9RK1EO19Fxz9VZ4ln2rAojlMysYhDkCu
         MXDffzpxMAmp4gSV3ZQmpGMPEergB2Rk0QbOLOkH8Qhoe+2Ck+x/AgoE8MiN/NIDpM40
         t+yXSkBCjoZfDWgWgLlTzGTFLVMBgcacSkBPdnaYzan1+yxr4LN7EhdI1spNSqNvA0jU
         khYfkcfh5OpzNpqVt+PXp31HkRQYIKeVfZYF8whCVUw1kjwD+5aZM3V7rsc3r2oToUKI
         FHxAQrs4FwbOjyfFf7w6/BaFVR+Fzzx3NWGBSjTxAaqk5H6ZvJBE9InK2D4vNEJqVXoD
         UsQQ==
X-Gm-Message-State: AGi0PubiDOpP1bEUj23FQhS/sYBNMxktFWipPQ3361jtC/5yBnaa1Pkk
        o/kXFtjFC4kfpzbRlpa34QQ=
X-Google-Smtp-Source: APiQypKLVEuv665pnccyANSRDruxEFNubppeFp7M7T06aH564HbzZu1v5VJUk8fs3z4dS4rSuo7spw==
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr10372240wml.82.1587560946273;
        Wed, 22 Apr 2020 06:09:06 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:8872:7e71:5cf6:8a5b])
        by smtp.gmail.com with ESMTPSA id o3sm2064820wru.68.2020.04.22.06.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 06:09:05 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v5 0/4] iio: vcnl: Add interrupts support for VCNL4010/20.
Date:   Wed, 22 Apr 2020 15:08:52 +0200
Message-Id: <20200422130856.1722-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Here's a v5 taking Andy remarks into account.

Thanks,

Mathieu

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

Mathieu Othacehe (4):
  iio: vcnl4000: Factorize data reading and writing.
  iio: vcnl4000: Add event support for VCNL4010/20.
  iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
  iio: vcnl4000: Add buffer support for VCNL4010/20.

 drivers/iio/light/Kconfig    |   2 +
 drivers/iio/light/vcnl4000.c | 750 ++++++++++++++++++++++++++++++++---
 2 files changed, 686 insertions(+), 66 deletions(-)

-- 
2.26.0

