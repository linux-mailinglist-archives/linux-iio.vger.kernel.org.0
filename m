Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D645DAE6
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 14:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351520AbhKYNXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352409AbhKYNVx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 08:21:53 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F66C06174A;
        Thu, 25 Nov 2021 05:15:29 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so25472223edv.1;
        Thu, 25 Nov 2021 05:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAa4zi7oYvYD4vpZ1kEFbpaY38iSHjx1RsDN+9GL+Wc=;
        b=nos8GOsSbhxSMIAj0q7gUKLRa4S6k3VP1dPN/NtvDlu5Wa2Bsvt220OUrMszDzMbxd
         SYwNB9p/dx3AmHtTTqynTYxvT/jQPos4EvHxPBpvbCgY8UKuHYBtHnsFeRXbc4TiZQ/b
         6UJpR8Nl4J71f0Dg5fZo7AwlvVlAdSQ4ARpoFLhsMkDt4+VKLrExRq877UQ33+IfsN6w
         1DkAqNqDnIxIWyDOgyX8xy0PjZvOaUSO/cgYd6tmyvL0vNTKgVimCiJ4eNya257MSgMo
         PvBSdDkWVMQ0qR/wiHhnzuyfqxP7su67UaRhdNdkZ3nuzGV8FhMqkKew1okavRdq66c1
         09NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAa4zi7oYvYD4vpZ1kEFbpaY38iSHjx1RsDN+9GL+Wc=;
        b=bPi8RDdVFPgs4J38SVVItCMfWxTJW8eXiPNqsGaYR9b1VqJ6auWDn008Pwv0fcXJ/8
         ZH8CUv5VrTdmZGLTnQcNrChO7XvUqK8c6KUHUyX+ReTwL+s6gCEac6WPpr4H6DpA3PPP
         Gbtmy/2T4rLbd7PduW/g6tqX4ne4qE9iowTL8yB29u8c1EoVtMGovbQwYUG4Ls00T1VW
         PpsCmbxSN0zHD28cT2c9Tkq6tZPQu6QLIOrrsHDP9zZJfj7k303IkZ1/R0DUhQVrhReX
         41niPyKbmMX0AJIiGQb1mlelX+m4ZoAafBVeyiVljoGF0yp+0nf1W/kea73KVbWlkerS
         b2QQ==
X-Gm-Message-State: AOAM532qykIGvlFEXyVOtpi+0LdIhL+m1+PMKrVapEmiQRDD4YcDG2jF
        m2TJzcCKB+HmRiSYfb+nuhA=
X-Google-Smtp-Source: ABdhPJzvkVCxeTwVXN1WFMqkdztL5hF1eKHNhnXln7mvbuT956aJcM5bSiiD5zvAsTyc2RBTdy6qzQ==
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr31892578ejc.173.1637846128519;
        Thu, 25 Nov 2021 05:15:28 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id g9sm2187770edb.52.2021.11.25.05.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 05:15:28 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v4 1/3] iio: add adddac subdirectory
Date:   Thu, 25 Nov 2021 15:14:20 +0200
Message-Id: <20211125131422.50657-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211125131422.50657-1-demonsingur@gmail.com>
References: <20211125131422.50657-1-demonsingur@gmail.com>
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

