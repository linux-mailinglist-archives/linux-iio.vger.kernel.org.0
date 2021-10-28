Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7805B43DE99
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhJ1KVY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhJ1KVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0446C061570;
        Thu, 28 Oct 2021 03:18:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r12so22762897edt.6;
        Thu, 28 Oct 2021 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=owayHkJYZGFM3gFNN13JgRAipnyepGfFNldubgz8jak=;
        b=MNNXOVzMwXHYW4xvjcGr8iX1Z+00L9oJxblgaWWSRln5ZaYS2qS4R90OSw3m77I9T8
         8+m8p4AiRS4+7e0FrwCrKoXxAm4sJPzMETCfgwDMhJmq9XP8djyj2UC1BglJMLgPePUc
         D2w8ffhJwcRWLgt2i8aDzeL1KIbpWQrgU5tdCBJrr62j/EPWhWvaPzQRBIKbm85TTTxa
         bPPJUsogMPoCXrNgBYKpvaihfpvvBagb6/BwQr7dRULsuX3X0uHKotV1gLPZiQbbKTmE
         vqjVvA54fRDXzhwbshKgcNgKl9wwQmvwxLgV4ow3POWv468IFXjKZlKh5V7EmWHkEI88
         5rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=owayHkJYZGFM3gFNN13JgRAipnyepGfFNldubgz8jak=;
        b=NKIr4ohbuWHVwOmuQEwb0ZCg4Wm5rMcVQDxTp6lnPOLfntJNbCRZ8YDd6RA0UdYYCN
         qHc9I2J2kO4K8ml7MqT1gYiMGiDOaFOhdGFjeRROj84zkMtPIXULx/NQyDhnEwd1Nse9
         JV0CweXq/VxSU1p5VbWg8p6rLc90Yqdy+6eYv26aom8wTcI6iw0o2jZKzru6ZOTEyLxi
         rlHtLZ0ceMC5qGf/oUdzzFnU8QBUIEKLVImH0I75C/g0yqbj8bt0ct6XPxb7xJJJXLVw
         4EhaSFVodtWTmYm/gjUuHyAZjJymNqu05pnptXpkilvD20tUCykF3N87ACo75gdXHH/s
         Et0g==
X-Gm-Message-State: AOAM532tq4eRBR7oms/JkCa/M2zXe4Tma+ayKAoM4Y5xc/w7lRkjJxB3
        brAvWZAkRkq47ArO/yxEYKo=
X-Google-Smtp-Source: ABdhPJyqm0LiubM7NwYUr+F0/540Izgp2EpuhPpzzMKW97NU0TiMVaCiEcGAOLO/Tb/vCVKYZoLM+A==
X-Received: by 2002:a05:6402:35c5:: with SMTP id z5mr4936422edc.388.1635416329911;
        Thu, 28 Oct 2021 03:18:49 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:49 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v2 01/10] utils_macro: introduce find_closest_unsorted()
Date:   Thu, 28 Oct 2021 12:18:31 +0200
Message-Id: <20211028101840.24632-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is similar to find_closest() and find_closest_descending(), but, it
doesn't make any assumption about the array being ordered.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 include/linux/util_macros.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 72299f261b25..b48f80ceb380 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_HELPER_MACROS_H_
 #define _LINUX_HELPER_MACROS_H_
 
+#include <linux/math.h>
+
 #define __find_closest(x, a, as, op)					\
 ({									\
 	typeof(as) __fc_i, __fc_as = (as) - 1;				\
@@ -38,4 +40,28 @@
  */
 #define find_closest_descending(x, a, as) __find_closest(x, a, as, >=)
 
+/**
+ * find_closest_unsorted - locate the closest element in a unsorted array
+ * @x: The reference value.
+ * @a: The array in which to look for the closest element.
+ * @as: Size of 'a'.
+ *
+ * Similar to find_closest() but 'a' has no requirement to being sorted
+ */
+#define find_closest_unsorted(x, a, as)					\
+({									\
+	typeof(x) __fc_best_delta, __fc_delta;				\
+	typeof(as) __fc_i, __fc_best_idx;				\
+	bool __fc_first = true;						\
+	for (__fc_i = 0; __fc_i < (as); __fc_i++) {			\
+		__fc_delta = abs(a[__fc_i] - (x));			\
+		if (__fc_first || __fc_delta < __fc_best_delta) {	\
+			__fc_best_delta = __fc_delta;			\
+			__fc_best_idx = __fc_i;				\
+		}							\
+		__fc_first = false;					\
+	}								\
+	(__fc_best_idx);						\
+})
+
 #endif
-- 
2.17.1

