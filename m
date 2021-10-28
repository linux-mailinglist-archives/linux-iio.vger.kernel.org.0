Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC443E28A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhJ1Nv6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhJ1Nvj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 09:51:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A06C061220;
        Thu, 28 Oct 2021 06:49:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h7so25610207ede.8;
        Thu, 28 Oct 2021 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BovXqE0Q/mhEQVcledJTFqExJrjsVNS5gIUqVyJDoY=;
        b=hv+9b20zOu4SMISP96uhUZGkB2paa1ApPsBGLC1kGOxjNUBR7J/1pT3H88Lwh510nC
         aRQxp3ZlClR3ZGLQkF4tJURYyS26RWElkVw0G3KJMSLacP/TIfqQE42EdpSSr6AbZXxA
         Yl9zPBar9YZPqfL1INj1Ny7s+o6WqkqFmDmFSbKxwJseUAb3pvlSdRGdbuFJX141eL9k
         B2tvIRwt/FtzZM3KfjCQ4U/rpGGjnib7478r7Lsz7YdbZFInIZ6J1XRu5eEAWINTpPfD
         EySyHbgZ0J/w0rdkbPj4RMP8c9mI3gHLFZpxjdMepCjP5t0I9fmPXDuL4NzqEFaSDjHU
         GGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BovXqE0Q/mhEQVcledJTFqExJrjsVNS5gIUqVyJDoY=;
        b=NNgfJcdfd1fiV3oC2sLMTnut+SsGA6PuABqieSkAcipndj6cWYC9w1rhzEt4dpbm6I
         N+LEFrD7hcuNHTiI2O4lbrnBZR0lsHID59xi4X3Qs5pYnWJV6YHRvtWxCaOSRHuEPOv2
         L17iRXM2f+9l+waKyVoUNIgb9VcA8c1Tlv0/StBQaE0/3TFGRiCHSykZgOSWaONESSIj
         yBFgcuTp6+lYgshBkraAAxv2L5r91+wVZJ33H+RFUH1wJgkeF/ujIfHx6SzCv78KExW1
         nWGCORZovoBRcLRQtl9hxhRbD+nhW7MZOFvTVhDoUrSX4C+/3/VWNISXxisZyonJdnhA
         Pn4g==
X-Gm-Message-State: AOAM530/fQ16+lPtx0wIeRyI6L6QA+VWNIKdT0jIkqF+KTlAgqnRNzZo
        wWcLjlRXqfX9RBntuJ/H1x4=
X-Google-Smtp-Source: ABdhPJwB5nJKhRiOxwpp/Pgj4qcD/x4TVfHGhWJIqnq49U0MEpM3I+U11DNwqOiy3JMqCVQ2l2ZbmQ==
X-Received: by 2002:a05:6402:42d4:: with SMTP id i20mr6165295edc.337.1635428947629;
        Thu, 28 Oct 2021 06:49:07 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id x3sm1941934edd.67.2021.10.28.06.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:49:07 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: add adddac subdirectory
Date:   Thu, 28 Oct 2021 16:48:43 +0300
Message-Id: <20211028134849.3664969-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
2.33.0

