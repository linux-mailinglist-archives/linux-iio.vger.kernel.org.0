Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EB2DBA08
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 05:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgLPE0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 23:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPE03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2020 23:26:29 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E8C0613D6
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 20:25:49 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id lb18so788356pjb.5
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 20:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pIXKuIPGH4KJ6NNoBDyWkBvHbbSeun6J8xXhej0zss=;
        b=J6GgYatmJiTrzYPOOaDZ5kcvgoAmZ4x84n3ZZ6BPineTq5HUF0GG+Ia+535ScgilZG
         0S69qG864P9JjT+t4D81pAqQuj3CdqMC+e6UkuYFbkWFF/lmh1R1/Avn0wQGvh/TgWxA
         oGFcO90nhrskjihA/6Lan8DPoIkrm8mO4fIBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pIXKuIPGH4KJ6NNoBDyWkBvHbbSeun6J8xXhej0zss=;
        b=c2doPKfzUv5fWT3vPcDPtmoQanVkQg5rUg90BwD8OWXrhaOR/H4BF9AB+JfvahILaX
         5JPszr8/IFX0VsuI/m4WMvHCXLkhCLPDMGfRUNSGm07eEXp0FkxojXzYj2nQefu3rSzV
         RQMwKw8Ub74OXKEpEIs/ws2fVZv6JrJBOE5HCBxQBmKx7STLNjpb6hOb7oTl5ktGi2H+
         Xk/o72wDgWVojxkPDbvCLNnHsMtb6OGsiVcJTdL+LQrnbJreq+mw1XQIWmNAs58HKaci
         qS14wDlef49ePcyku9cIcR6RgVeWlVsPxfxmWnbcft5M1ItFqXvp37o03lk3t4nfzRxh
         Zphw==
X-Gm-Message-State: AOAM533eL9XmRJXMqbLpfPfRYuSMOhEH2qQhaD2JomszPPx/uOUp7jJ+
        wED6JI2TXSRRgLrB6OnN6JwW1Q==
X-Google-Smtp-Source: ABdhPJwGQor2KBDBnfgIQ53SUewt4fG70Ujvi+oy5j7bJZKcN74TME0mDzYDRLlQ1p0duWPMhSD9HQ==
X-Received: by 2002:a17:902:42:b029:da:e72b:fe9e with SMTP id 60-20020a1709020042b02900dae72bfe9emr30320549pla.31.1608092749252;
        Tue, 15 Dec 2020 20:25:49 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id a18sm574161pfg.107.2020.12.15.20.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 20:25:48 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 8/8] iio: Rename iio_trigger_alloc dev argument to parent
Date:   Tue, 15 Dec 2020 20:25:45 -0800
Message-Id: <20201216042545.88176-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To be consistent with iio_device_alloc, name the parameter
device the trigger connected to as parent explicitely.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/industrialio-trigger.c | 16 ++++++++--------
 include/linux/iio/iio.h            |  2 +-
 include/linux/iio/trigger.h        |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 83006d1f7eea..0ce57dba464c 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -517,7 +517,7 @@ static void iio_trig_subirqunmask(struct irq_data *d)
 }
 
 static __printf(2, 0)
-struct iio_trigger *viio_trigger_alloc(struct device *dev,
+struct iio_trigger *viio_trigger_alloc(struct device *parent,
 				       const char *fmt,
 				       va_list vargs)
 {
@@ -528,7 +528,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *dev,
 	if (!trig)
 		return NULL;
 
-	trig->dev.parent = dev;
+	trig->dev.parent = parent;
 	trig->dev.type = &iio_trig_type;
 	trig->dev.bus = &iio_bus_type;
 	device_initialize(&trig->dev);
@@ -566,7 +566,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *dev,
 
 /**
  * iio_trigger_alloc - Allocate a trigger
- * @dev:		Device to allocate iio_trigger for
+ * @parent:		Device to allocate iio_trigger for
  * @fmt:		trigger name format. If it includes format
  *			specifiers, the additional arguments following
  *			format are formatted and inserted in the resulting
@@ -574,13 +574,13 @@ struct iio_trigger *viio_trigger_alloc(struct device *dev,
  * RETURNS:
  * Pointer to allocated iio_trigger on success, NULL on failure.
  */
-struct iio_trigger *iio_trigger_alloc(struct device *dev, const char *fmt, ...)
+struct iio_trigger *iio_trigger_alloc(struct device *parent, const char *fmt, ...)
 {
 	struct iio_trigger *trig;
 	va_list vargs;
 
 	va_start(vargs, fmt);
-	trig = viio_trigger_alloc(dev, fmt, vargs);
+	trig = viio_trigger_alloc(parent, fmt, vargs);
 	va_end(vargs);
 
 	return trig;
@@ -607,7 +607,7 @@ static void devm_iio_trigger_release(struct device *dev, void *res)
  * RETURNS:
  * Pointer to allocated iio_trigger on success, NULL on failure.
  */
-struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
+struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...)
 {
 	struct iio_trigger **ptr, *trig;
@@ -620,11 +620,11 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 
 	/* use raw alloc_dr for kmalloc caller tracing */
 	va_start(vargs, fmt);
-	trig = viio_trigger_alloc(dev, fmt, vargs);
+	trig = viio_trigger_alloc(parent, fmt, vargs);
 	va_end(vargs);
 	if (trig) {
 		*ptr = trig;
-		devres_add(dev, ptr);
+		devres_add(parent, ptr);
 	} else {
 		devres_free(ptr);
 	}
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f015fa185253..ee8dd1f7eb38 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -692,7 +692,7 @@ static inline void *iio_priv(const struct iio_dev *indio_dev)
 void iio_device_free(struct iio_dev *indio_dev);
 struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
 __printf(2, 3)
-struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
+struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...);
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 089e1961810c..f99b275c3810 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -161,7 +161,7 @@ void iio_trigger_poll_chained(struct iio_trigger *trig);
 
 irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
 
-__printf(2, 3) struct iio_trigger *iio_trigger_alloc(struct device *dev,
+__printf(2, 3) struct iio_trigger *iio_trigger_alloc(struct device *parent,
 						     const char *fmt, ...);
 void iio_trigger_free(struct iio_trigger *trig);
 
-- 
2.29.2.684.gfbc64c5ab5-goog

