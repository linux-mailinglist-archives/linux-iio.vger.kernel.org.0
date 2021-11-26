Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8445EBBC
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 11:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbhKZKjV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 05:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbhKZKhU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2021 05:37:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74170C06175A;
        Fri, 26 Nov 2021 02:23:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o20so36527501eds.10;
        Fri, 26 Nov 2021 02:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAa4zi7oYvYD4vpZ1kEFbpaY38iSHjx1RsDN+9GL+Wc=;
        b=J5iRhocmw+yVqilYP3pyshDYx6uxpNdp89z5urtEgeQc08bnJVEJgwkDAw7aefxLZ8
         8cRnyO8churmYM6ZdKgwBNw1ARu/cSzjfmFsIOjOBX6uMrV5mx4tVX29QSsO69NnYG+H
         VnX/VuKt1Ph2UyRACdY8CRi/I2H9fYk8gMMh9FMyjElH84LNRjLYhjAkh2kdg6w2iM+u
         E+c4sZDSAiOtZNNGEtVEM2voc8dxy0fAJA4QQ05ZzVSLfJqRjuwgUjMpJZUcb9MNQKsB
         8VL95a68Lzd73Bslmgcx9wY1i5Lr9UZ65jvzEp7VNiQHxqy7kL2FzTN2ekM/FfJ8ic4C
         FPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAa4zi7oYvYD4vpZ1kEFbpaY38iSHjx1RsDN+9GL+Wc=;
        b=t9c6YTitT49u07tt1Teuo2s0lziZ2y8RxPg2sF54TPvfdqMivxVrJWMRc060t78LK+
         3XMjvEuCdQKM+lHqnu0+qX4EtmmgpoVOcUqobzJJqjykGK3xPi9Z1MO22rvcYZ1pYLJG
         8R0fLYtwNB5ynNRtt1phK6ECTjh4eSbh0Zf9nR+KuflssF18VLV8OQZKr0Ze3OUZyZds
         OrOSGmQnkTZH2pNn4BtWZ2WiBDYuCljMhoetCkmkXdWifIlPIvPo3vd5sKmg7ES3/WjV
         WzUc3ge0eXYpYvtBQszn3FOX5F4Lu8YWltRsiFeNYI/l5TDTE0aGrYhoH9PcT4cSRNzC
         7jQQ==
X-Gm-Message-State: AOAM530qzoHdypBBmtgMjrXtXN1Z/TcQlufXrlGK0yhHgliToqbVxgD/
        EpVfqMQ4jW7t0CFBlv7Fzmq+sSAx0Rw=
X-Google-Smtp-Source: ABdhPJxxzeXri/4w3Fc+Qh5eiou5OeqHHL7XnRyr3aozHSI4NL6FEb3jG+6quJodoqo+WPzW4uZW1w==
X-Received: by 2002:a17:907:1c1f:: with SMTP id nc31mr38345534ejc.210.1637922187009;
        Fri, 26 Nov 2021 02:23:07 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id w24sm2866019ejk.0.2021.11.26.02.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 02:23:06 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v5 1/3] iio: add adddac subdirectory
Date:   Fri, 26 Nov 2021 12:22:44 +0200
Message-Id: <20211126102246.289491-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211126102246.289491-1-demonsingur@gmail.com>
References: <20211126102246.289491-1-demonsingur@gmail.com>
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

