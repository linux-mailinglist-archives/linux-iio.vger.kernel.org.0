Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F18445F172
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 17:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378546AbhKZQRl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 11:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378297AbhKZQPk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2021 11:15:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890AC0613B4;
        Fri, 26 Nov 2021 08:03:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x15so40752906edv.1;
        Fri, 26 Nov 2021 08:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAa4zi7oYvYD4vpZ1kEFbpaY38iSHjx1RsDN+9GL+Wc=;
        b=f10ri+NcAk5BS0ufz31hiIPOMWQNymCL9O1BDQvkmCNdWyimfWhAQXKJ/C0KsvLF2v
         lnFZ/T4LqmiLwibGD/EdKj9UAvrZsmoC/kmiJETdr3rJgGX1BVpgMfm4UUQyZn/F0KTk
         9Go3LkKSYQJHR2fghD2uOkjX4/7388tq0z+3FeRO8atfPePI9RNjnv/S/QG4Jyt1IGVd
         4a37zmwfjTu6EaEX99cpFrQkFi+A9bCzGdq1h6BUeHIfz27MOO3/0MZVbet617X40T1/
         kUp6VRgSlbBKO0p3Dv/ZnSkAtmhpVv3Q0GUInXdJ8yK0VuUo/M00OZhpgKb2SbPaX4u7
         Ui/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAa4zi7oYvYD4vpZ1kEFbpaY38iSHjx1RsDN+9GL+Wc=;
        b=fDwcyrQETeTZhOhjT8xatZh7BVXxvCVBta3g0aALiSqlVPN4rha7wAq2FQHw9XFHHW
         KPO6NvYC+aY28F96deY7LzNv/xWfMaJxNv6pGduCUxeYhpE+uH+OSzLZqrozaRtR5fDv
         am6PoS9eeYYf2RQIYEhpTfZMsy6HbHTKJJ4LgN0Z9hiop4CpctCDFipcHLlckkGCmi8f
         rmKrEcOzYyio46n4IP8wcxB3EFhp+5MkOJqCJ818AH3cZFo7RZ+YuBOw4CVQEurIkXSB
         lT0QDLIT746wJMqvTK6x2uOMRDratvHOdgf5ima1h6oMRdd8tjxFV8wExzfwCtxlJgb7
         Z/1A==
X-Gm-Message-State: AOAM531pU/NAKtje2q2thM3Zag3Wl2gxJC1+FhK+wgZY+OyZBt/kKVoG
        iW72L2Nx7MWyjcfLSyVeOMk=
X-Google-Smtp-Source: ABdhPJwsl2vs6L54ilrtrb6W9nr7X/8+jFhL0zMF8ghZLbXiJqPmQC4a4B1561UNeIQ/S1iAWaGV+A==
X-Received: by 2002:a17:907:7b99:: with SMTP id ne25mr39336835ejc.15.1637942579756;
        Fri, 26 Nov 2021 08:02:59 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id y15sm4188324edr.35.2021.11.26.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 08:02:59 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v6 1/3] iio: add adddac subdirectory
Date:   Fri, 26 Nov 2021 18:02:17 +0200
Message-Id: <20211126160219.674665-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211126160219.674665-1-demonsingur@gmail.com>
References: <20211126160219.674665-1-demonsingur@gmail.com>
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
2.34.1

