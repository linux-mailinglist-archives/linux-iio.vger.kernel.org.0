Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF144650C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 15:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhKEOjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 10:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhKEOjO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 10:39:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644BC061714;
        Fri,  5 Nov 2021 07:36:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b12so14077196wrh.4;
        Fri, 05 Nov 2021 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAXBce7LGi7iWmzwvSrxT0zVpIZPzsFHymvkfe+ZySU=;
        b=bLXXh0BiBxQSxJYEN9NcT5HkPs4oo7h8tyLLlf5gCNVD4M2BONP/8kpyRZECYYdBBb
         RzSJmkjrhW1AG7baYCFR+cBRK0Q1yBqMFfUgxW7apapPyjtLLa78ogInuh31HSF05DPF
         OEz51dqunelrGD6E4mqSmCKPiBlr43yvWjwKg49AIVj/+OS6FZUWyN68tdNNZWDfqBNo
         XVqe11NvESgUM7XjFgbGvvWAQt1ydpLnv84s8IuvpSGvi7h88OaCu0d1DdXICKkWcUGq
         WZ9tQyjamimnAPiBFs+xW2Bh82IOGHP/B0tloEffwhgEom/fEMJbEOrZ+X1VdXbsJi0R
         EXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAXBce7LGi7iWmzwvSrxT0zVpIZPzsFHymvkfe+ZySU=;
        b=0fE3zUnagcdC/866QinONgvH6pAR3MI+5cBxPvOG9KHHrSQ5JG7Q+zJFoohDBoSUn8
         rRDVODEe2owfKpKfn9At4pfIZhuvuEgkubNaFid2kEpIgkjNYgSGD/RsU5evbSyd7na1
         s8oEmhlmDaXT5E66NeQHkHwSlvrMl+eJUln0mf9PPWdfO3y4dvB7OLbK3kUBD4kvjjbd
         X7FmRhmsGaCYAYQGybnUzFfjD+Rxif2irXchecovjq1N1RGZnNBllhQoo6wHo5caQg27
         aFy89dzKctaH6j2GmwHWefeZp1G8eR5924tk6jO7jZlLjNVLog3NMer0rcqcNMQCqOKY
         Wr0w==
X-Gm-Message-State: AOAM530704QECbmN3Fcf/CKDQVlKVkX6Y7oLBQlP9wd7Gj+DBa+mJ8+r
        Bc4N5Qsm8GySqTajuGEx8I1k8C/idmV29Q==
X-Google-Smtp-Source: ABdhPJxIaFa0SqQVq8hDJFIPK5nG9hjAeuEFhIAPM3CDR1BtkGVz5/l4Y/Nmqe6IDKrlNuT33A9JyQ==
X-Received: by 2002:a5d:522e:: with SMTP id i14mr59704492wra.43.1636122992969;
        Fri, 05 Nov 2021 07:36:32 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id z5sm15140839wmp.26.2021.11.05.07.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:36:32 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v3 1/3] iio: add adddac subdirectory
Date:   Fri,  5 Nov 2021 16:35:48 +0200
Message-Id: <20211105143550.1783528-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105143550.1783528-1-demonsingur@gmail.com>
References: <20211105143550.1783528-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

For IIO devices that expose both ADC and DAC functionality.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/Kconfig        | 1 +
 drivers/iio/Makefile       | 1 +
 drivers/iio/addac/Kconfig  | 8 ++++++++
 drivers/iio/addac/Makefile | 6 ++++++
 4 files changed, 16 insertions(+)
 create mode 100644 drivers/iio/addac/Kconfig
 create mode 100644 drivers/iio/addac/Makefile

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 2334ad249b46..4fb4321a72cb 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -70,6 +70,7 @@ config IIO_TRIGGERED_EVENT
 
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
+source "drivers/iio/addac/Kconfig"
 source "drivers/iio/afe/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/cdc/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 65e39bd4f934..8d48c70fee4d 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
 
 obj-y += accel/
 obj-y += adc/
+obj-y += addac/
 obj-y += afe/
 obj-y += amplifiers/
 obj-y += buffer/
diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
new file mode 100644
index 000000000000..2e64d7755d5e
--- /dev/null
+++ b/drivers/iio/addac/Kconfig
@@ -0,0 +1,8 @@
+#
+# ADC DAC drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Analog to digital and digital to analog converters"
+
+endmenu
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
new file mode 100644
index 000000000000..b888b9ee12da
--- /dev/null
+++ b/drivers/iio/addac/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O ADDAC drivers
+#
+
+# When adding new entries keep the list in alphabetical order
-- 
2.33.1

