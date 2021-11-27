Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A3460126
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 20:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhK0Tav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 14:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243280AbhK0T2t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 14:28:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DFBC06173E;
        Sat, 27 Nov 2021 11:25:34 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y13so53217244edd.13;
        Sat, 27 Nov 2021 11:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAa4zi7oYvYD4vpZ1kEFbpaY38iSHjx1RsDN+9GL+Wc=;
        b=S8XtyXE5Ga6fJGy+VCHboyMYFcgf3mpdcANnyq/zHTyKsy37ztXycLK8aVQugYU0Ky
         J/GmVFuuLj5YCC/MdcymY+i6OLAB4m1zOOU/m2Hr7U++5NzK8IoQOG7jkzINZLwZOEeS
         A4uLQn+JsTvWP3IBPkYnSGl8c32gP2IftyUKY4Ya3XyPO8dPgJT1gKejQl3KLh1FZfVi
         xJrY47p8ozo9eBkmxTjJojBCbaxJt+RtsGvh1Pl82y+4m15kpLeejqJPtn/zBnDd/srd
         OVGrp3/AHmNY0XQr2WOuPLVEhh4snzVzcECi0FmflguZBTFVyEvbIe5AVezqVGHKyzYz
         Fl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAa4zi7oYvYD4vpZ1kEFbpaY38iSHjx1RsDN+9GL+Wc=;
        b=kJKN7xHF8lH+v2sjz2mMuaM6JjdaPj0URWIorrehlkK0FtPGJmDDkLJ16XwwuiAoSu
         p3IVTXg/S3QtvpOXUmyvZS1XkXtPYaSEKCGDYuxEVgBlRZ/fuvPjmM0XNq8gWARHAzuz
         SAaccY8fkkf10J4L05y5rGuG/OQzojPv8T6XJ3KNOpSXEy0P0zFRuY1zp7eSNyxdE/sE
         5Iv3CmrEckqbU1eopBor0pccrYbVhqHIEzU0/FnK0ff3eeQV2MY3c40mwnKNrcO6G2eU
         yhbpT+P3c5RiDvM/vsmVKiWXpilcT+5fXYm3O++ICu7iVrJr9IRCYiIVqmv/kCWRtDV1
         mTMQ==
X-Gm-Message-State: AOAM531Gpcymlhg5jXrX+NBrTw2JsNyb6rzMoEAnXbvWHPUq6Qj+G+2v
        gdbMs+CGHP7Sw2/IJ1rBV9YuHaQZcDU=
X-Google-Smtp-Source: ABdhPJyc5pbhOvCbQ8tbiozsWBF2PsFhnJ3gWChimrai+vaFvxi9m4Jxi0FELn3LPvZr/OCuswUZQg==
X-Received: by 2002:a17:907:7b98:: with SMTP id ne24mr50813700ejc.14.1638041133468;
        Sat, 27 Nov 2021 11:25:33 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id d18sm6163126edj.23.2021.11.27.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 11:25:33 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v7 1/3] iio: add adddac subdirectory
Date:   Sat, 27 Nov 2021 21:25:08 +0200
Message-Id: <20211127192510.35723-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211127192510.35723-1-demonsingur@gmail.com>
References: <20211127192510.35723-1-demonsingur@gmail.com>
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

