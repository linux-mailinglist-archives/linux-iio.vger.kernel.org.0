Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1335C3BB8BD
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhGEIWR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhGEIWR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:22:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E61C061760;
        Mon,  5 Jul 2021 01:19:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso11317504pjp.5;
        Mon, 05 Jul 2021 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stljVzismgi0bhtAbjcWPPl7QduNl8XesIvoC90of/Y=;
        b=lBPm735wq5Hqmn4+hV8uefqyLgB0/8ouc4pmGNEZp5sEeqfeqAGTrbQA1vEs7aKfad
         /YBPzTALvNXtsRU1RrQLhzoBAKtt7m1fM21AhMkuP0i9vqO2Re+sJgJ/l8CfRxfiJyF+
         aC2WY2B6Zq0p36dN2xlZiD5Wa2nG7v93qq6U+zvmCUWMTXDOtxc1guY1Z93q2Hg6/V8q
         qM39Qto420qcAqQIttNRd0VZJ8P8GgATtWn5mDBtsW/thp7fek4cV0rOC3tJPsbr2jH+
         1RTWIzEoNZYaA3wpz/IOP+hlHpC+zYsUZo4PSdd8Yk+JHgGkw+1ETOV8SSCKxRIx5J0w
         VsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stljVzismgi0bhtAbjcWPPl7QduNl8XesIvoC90of/Y=;
        b=OTq3uuN+aZCrw7AamE812+xfIwKlVU5MnWE8BJS80HKAv9Ls3xUSElnlvLtKTWYaIo
         eAG4MBAkiqWbkSX6Qjvuk+e9AmvqxsMojXHrMFZ7C3YfAu1PNlpTYJ5p7ErdwQDsWqup
         fNFX0Tc3EtfxkYZfEeqsVykU1NYaWXfZ4K6rq+9pGPTov5ZScBp8f4KntXWUN9yCFAD9
         iRgZWUjywBWb270C/PENRjnz7CC36SoFvJ01ROuc1XZgRVeRCtDJtoFEb8lxJYRTN4l5
         YlyVh/HiFEDlaQ2iz6H0GLfZFBIRkFBOZcyOD/Q0GK785nfiBJF9XV3rrPSTGyGZ9MrN
         UDiA==
X-Gm-Message-State: AOAM532j1je7oglggjPD6s5Tesj4fUDOYQ0kJiymwx+zqOEsrKrrVS32
        8wBJ8hO22DyCnCHFxBJDyHo=
X-Google-Smtp-Source: ABdhPJyXYShWjeZFwxJcv49xdwSleXlIQku3KIv3x6cjovjto725dXxQSUSismAGJ6fdMKwFyNY/Ig==
X-Received: by 2002:a17:90a:4295:: with SMTP id p21mr13654533pjg.149.1625473179621;
        Mon, 05 Jul 2021 01:19:39 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y11sm12209986pfo.160.2021.07.05.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:19:39 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v12 03/17] counter: Standardize to ERANGE for limit exceeded errors
Date:   Mon,  5 Jul 2021 17:18:51 +0900
Message-Id: <26c3e75fad4010d74ab563884e2cd0215efb05ed.1625471640.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1625471640.git.vilhelm.gray@gmail.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ERANGE is a semantically better error code to return when an argument
value falls outside the supported limit range of a device.

Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: David Lechner <david@lechnology.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c        | 6 +++---
 drivers/counter/intel-qep.c         | 2 +-
 drivers/counter/interrupt-cnt.c     | 3 +++
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index b358b2b2b883..d54efdb8d393 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -154,7 +154,7 @@ static int quad8_count_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (val > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
@@ -669,7 +669,7 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (preset > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
@@ -714,7 +714,7 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (ceiling > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 8d7ae28fbd67..85dd328ae1f6 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -320,7 +320,7 @@ static ssize_t spike_filter_ns_write(struct counter_device *counter,
 	}
 
 	if (length > INTEL_QEPFLT_MAX_COUNT(length))
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&qep->lock);
 	if (qep->enabled) {
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 5df7cd13d4c7..66cac4900327 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -107,6 +107,9 @@ static int interrupt_cnt_write(struct counter_device *counter,
 {
 	struct interrupt_cnt_priv *priv = counter->priv;
 
+	if (val != (typeof(priv->count.counter))val)
+		return -ERANGE;
+
 	atomic_set(&priv->count, val);
 
 	return 0;
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 78f383b77bd2..49aeb9e393f3 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -283,7 +283,7 @@ static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
 		return ret;
 
 	if (ceiling > STM32_LPTIM_MAX_ARR)
-		return -EINVAL;
+		return -ERANGE;
 
 	priv->ceiling = ceiling;
 
-- 
2.32.0

