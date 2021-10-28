Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DDD43E2C8
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhJ1N7V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhJ1N7T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 09:59:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B574C061745;
        Thu, 28 Oct 2021 06:56:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j21so2238716edt.11;
        Thu, 28 Oct 2021 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sTjTaF8WzIIc1JA5L9+qt2x1Ed+2Sbp5MJYlMdnNpw=;
        b=orj/4hHD1H/QMibvy0wVcX/ojlT24OdkGoJsrG6DLVeB79aEQ/MimEZ4rIa3CAkGT0
         2QhNY9U8jJJVq8b/yn2cersZb+r38knLTsAVhl0mHdjde10iGflGBzNe/kVrzfAYlaCE
         oRR1zzIpk5ryfFUE7qseM0j2jfrH5wLX/6WAZou99x9HzvGbHqQudg20ElNr62bSyYOx
         BqukaLhizz0GKPJ6bJhCxW7JPd7Dnq0igKvrDyaGcYZ0Vy2kUSRXOfJipwy/g2pFh/Z+
         JhLLTlt8HS0ITcnMuY42B3NtigoEIWJX1YRpHfY8Vu70/iQ4m2+YhcL1Bo1d0V/JWh5z
         mb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sTjTaF8WzIIc1JA5L9+qt2x1Ed+2Sbp5MJYlMdnNpw=;
        b=A59OUG5E60Sm1eCkFZ/3vZYTP/GPjcatyKW3ggypK+UClyHFJFo9IhS7NjhwjwzS1w
         SP6yREjJc0+dp5SBr3K8dvbw8UUz46xa5jh3krjDnaK4uFdZfje/5R2NHPadeEwXRcQH
         znlj9QbHfhaBA2+AG3FtiWWfDTGxPuFBS8p++GKQVNPrbIsbyV1DYDTtDD84bTp0LYAg
         T2uUfHTT8Xybtrtwt0kiddU7EoWygKq5P8E2+OCCx1TnkwigTxZlIiDkd9YWS/cqIT+G
         aKSAOKx1568toExEU4zWPPnhjQb6n6MsSuv68dH4WMI+iTyRljEBSUV3aTFgDjYs9C9E
         V8rA==
X-Gm-Message-State: AOAM530WzXYhqoKsgwQ7kJ98fs6vkCGad+I0RzPtecsuG7fcQsAu7fWd
        We3G6WjGEGZatImCMmmEmZs=
X-Google-Smtp-Source: ABdhPJyHrp87CN6z10YuAmEu/uSaupRW9hzvLm0EiS+ghOttqpU+OHx7xoNYBcGlwxE0ZrjZ1CWDdg==
X-Received: by 2002:a50:9b4b:: with SMTP id a11mr6408589edj.316.1635429410793;
        Thu, 28 Oct 2021 06:56:50 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id gn24sm651039ejc.78.2021.10.28.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:56:50 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: add adddac subdirectory
Date:   Thu, 28 Oct 2021 16:56:03 +0300
Message-Id: <20211028135608.3666940-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211028134849.3664969-1-demonsingur@gmail.com>
References: <20211028134849.3664969-1-demonsingur@gmail.com>
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
2.33.0

