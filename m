Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B53F9329
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 05:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbhH0DtL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 23:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbhH0DtG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 23:49:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BC5C0613C1;
        Thu, 26 Aug 2021 20:48:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m17so3109761plc.6;
        Thu, 26 Aug 2021 20:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ailO7mWThdrVL8blMHbd6DHGx3BHyfc6JT8C/AVCxTw=;
        b=hGJNel52AB4HPlmab7Q3dYqidGZHRqIPtSwUqem6ds0ejfoHDhxaaR6BoLtvxjoh93
         9DKRxXcivLvrT8A676B8xOo7YSnxaI/+H9euY8Zd/SCci9enXb9uPvo/ivUeb6rsraiu
         awqubFC1VqYB9lHNkjjidBkt3HOnilq4N2lYJo5U58KbGvohFMaqqm2MmbgOo6G4/gAe
         RhEzBuiXHAr7i6sVmYtzkc0KJTZa3TDgWhxKUJPudU3PCmdl1Oq9VCtQp0rJbfuzQexY
         HzokXmhQ6qCAPU+CjT2pAOUWshUlxxdCdi5tmIkZW6pAQMeew+3NJ/25Uhm+4hrASQUK
         JpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ailO7mWThdrVL8blMHbd6DHGx3BHyfc6JT8C/AVCxTw=;
        b=jCvsI4WK1PI2iBOYodlwbI4GAMzlBsHgj3PvXgpJzGWZCKOjGMPy7AgD6f3n0tR78V
         YGAaV9GvUvx639kD48i2eyWme3FigMGVf0h3jw8nFkHtk8qlCM4nZQhL/e4pTwwmduOF
         pmJj+C4eYv/z//2Pq6+SDlMO9NICU+elz5SKdRDO/DjnNp5qVBTUUmK6ljHKhRokf4Uq
         iCR/dYCQ5aDu+NT2OdV3Vk7kELeABLqRyzDru2uLEHJqYrzriWFWo22ck0zEjpAeETJf
         Wy2mtQKiQxC52rxD9SosY8gapWAJN1DSdLtURt5HMm7apt4Kx8h6lZIRqiw2O7HL967+
         olNA==
X-Gm-Message-State: AOAM530SGhvyX78tzwZ/6+mMoMBQZNGGFWXzzRspX8GUxcqNM3mI0f/4
        qVCZOPrXWq7JMRMYtC6ww9M=
X-Google-Smtp-Source: ABdhPJz6HSG/IOmN4K3PSxmGRWXA6Onvhl/sDmrN61R87mNnnixTGMgF40yfuAJdfhNNRbLMD8iNXQ==
X-Received: by 2002:a17:90a:49cb:: with SMTP id l11mr1353505pjm.142.1630036097608;
        Thu, 26 Aug 2021 20:48:17 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o6sm4364693pjk.4.2021.08.26.20.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:48:17 -0700 (PDT)
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
Subject: [PATCH v16 01/14] counter: stm32-lptimer-cnt: Provide defines for clock polarities
Date:   Fri, 27 Aug 2021 12:47:45 +0900
Message-Id: <a111c8905c467805ca530728f88189b59430f27e.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630031207.git.vilhelm.gray@gmail.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The STM32 low-power timer permits configuration of the clock polarity
via the LPTIMX_CFGR register CKPOL bits. This patch provides
preprocessor defines for the supported clock polarities.

Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 6 +++---
 include/linux/mfd/stm32-lptimer.h   | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 13656957c45f..7367f46c6f91 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -140,9 +140,9 @@ static const enum counter_function stm32_lptim_cnt_functions[] = {
 };
 
 enum stm32_lptim_synapse_action {
-	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
-	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
-	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
+	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE = STM32_LPTIM_CKPOL_RISING_EDGE,
+	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE = STM32_LPTIM_CKPOL_FALLING_EDGE,
+	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES = STM32_LPTIM_CKPOL_BOTH_EDGES,
 	STM32_LPTIM_SYNAPSE_ACTION_NONE,
 };
 
diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
index 90b20550c1c8..06d3f11dc3c9 100644
--- a/include/linux/mfd/stm32-lptimer.h
+++ b/include/linux/mfd/stm32-lptimer.h
@@ -45,6 +45,11 @@
 #define STM32_LPTIM_PRESC	GENMASK(11, 9)
 #define STM32_LPTIM_CKPOL	GENMASK(2, 1)
 
+/* STM32_LPTIM_CKPOL */
+#define STM32_LPTIM_CKPOL_RISING_EDGE	0
+#define STM32_LPTIM_CKPOL_FALLING_EDGE	1
+#define STM32_LPTIM_CKPOL_BOTH_EDGES	2
+
 /* STM32_LPTIM_ARR */
 #define STM32_LPTIM_MAX_ARR	0xFFFF
 
-- 
2.32.0

