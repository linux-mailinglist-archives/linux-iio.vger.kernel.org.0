Return-Path: <linux-iio+bounces-8316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F109394B01C
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 20:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C041C216EE
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB227143740;
	Wed,  7 Aug 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga6O7jan"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34331422DD;
	Wed,  7 Aug 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056997; cv=none; b=V5J0R3WjVBoJBUzXuB/FFbyQryHKdc5rLkXCM/oT00Ze4m7V5erGIHUAlbG1hsY9hjkKfq2oWSLN+ikjgN+4jF6Ezdghhy1/rXz2QAaxIFP2GIw5rmjVG94PolpYhYR61a5ktwF/9VANJXyLgXXcZfFlAYH7G32X3q2tjxLHNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056997; c=relaxed/simple;
	bh=Xl0XNH6P8xVYikz4LRhMTvCzbnm4U8FecR5gPlsQ2vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QECFqlJk0YvFbOEqd6od2Xs4aXpsDJ+u9ld3XHxR1eZBTrGU9oajjd3oQ2688w7KshfNmBb2QpACu5NNi+qhOFjrSFwIfE1r+BN2eQBPp9NVIwhPJT2/cdLeX8n3hpFFN39N/KSK1X4FR25mDmzeks74pCEr8aCyfiuglG1g4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga6O7jan; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-530e22878cfso120079e87.2;
        Wed, 07 Aug 2024 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723056994; x=1723661794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8FeMbjLUWFRJmxjbVI7sz0MVMw/j8BJ1tQjl57/nuQ=;
        b=ga6O7janw4yPEEL9hOvoOdOhdHUojSpMOXHVz7IZ1A5H7pRs2HcVDDhaiE7bZr2mqk
         OIiEfXJXDV/dB/TD+MyfaJufv/+c0RrDgWnHHaBkKd5KNjnleuASG/Iwom5myQEcJqh+
         e1gW6oGCePEgffp0NDXS/xBGJY+3QQ/f4kyTsyjd3j/6xHPNWMf77ZYDea2O+3R9++Xf
         UvH/55MiGg9hhmGAHr58btLiJXX/gnrdWTxiYu/p6nSdWpqrjmHAv14lLiWVpwQxfJNx
         ye/Vdm0rN5wCbu/kccLO2Y6rB9dRN3ASZkGFjsxw0O3JyRNmL4rI7oD1Bm6S1lvLPVLv
         UGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723056994; x=1723661794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8FeMbjLUWFRJmxjbVI7sz0MVMw/j8BJ1tQjl57/nuQ=;
        b=IjUWBxiIHaLfA6naX3bJY5WHL6BUtkh9m6I4RJ0tsQtoALKJGAlccu7OMHCNEO+iBs
         Qm+gmZmNzGQhOdoztzXqA2ZCRzuRtQuDHogrfTZcLVuPJPsbDZR0VpmEVCMr61zVzI7C
         3xqhp62MVJoXbl6aWO4+2xAB+LmSnQ0MAge6AtbaWOweBbYnjBqZtxfH8rURAwMQ1X2v
         J/lSRlheyZREzbrnMLHpH3t2VtfZHOn9KNRL6FY0qnU0/q+mt9j72rIXW4RuZmZDdmZN
         I5kNMtbnovQwej6MoX4HHjGTzzzWCDQxVcg/W5tPXWhyX7b+ykY0DqyMdvPSUesGV1bj
         NE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtuWSsM1S5htB+/+4RpjqAxZ1Ju/9/kzp0m2v+YjsD0vkvpe4+U6wpfZkRcaAi+6RjBKVF/rWDWlL4l43skKal13e+IlWiXhbfL2arxn/slhxRBXykYP3tmCToRYpSD6wFlqNdVlN5
X-Gm-Message-State: AOJu0YzPHNEdrEUrRxeYkeNiEmkArzHkShF2ZDReJXs/rN3WVomt6gND
	TTwiUoWH/W9wBcnIAJJFeofgQUgClPpDaj/c373sUmvxF443lAMQ
X-Google-Smtp-Source: AGHT+IHXMiDEkYJmCtdL3jvSpvOWsC5iylXuVF5Mc7yRRcr1uljgelESNO/weCNyWt8Tti3Hkw799w==
X-Received: by 2002:a05:6512:118a:b0:52c:dc57:868b with SMTP id 2adb3069b0e04-530bb3b150cmr13185067e87.13.1723056993491;
        Wed, 07 Aug 2024 11:56:33 -0700 (PDT)
Received: from localhost.localdomain ([151.49.208.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba51da9c41sm5482270a12.36.2024.08.07.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:56:33 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v3 1/2] iio: trigger: allow devices to suspend/resume theirs associated trigger
Date: Wed,  7 Aug 2024 20:56:18 +0200
Message-ID: <20240807185619.7261-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807185619.7261-1-benato.denis96@gmail.com>
References: <20240807185619.7261-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a machine enters a sleep state while a trigger is associated to
an iio device that trigger is not resumed after exiting the sleep state:
provide iio device drivers a way to suspend and resume
the associated trigger to solve the aforementioned bug.

Each iio driver supporting external triggers is expected to call
iio_device_suspend_triggering before suspending,
and iio_device_resume_triggering upon resuming.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 27 +++++++++++++++++++++++++++
 include/linux/iio/iio.h            | 17 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 2e84776f4fbd..54416a384232 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -347,6 +347,7 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 	iio_trigger_put_irq(trig, pf->irq);
 	free_irq(pf->irq, pf);
 	module_put(iio_dev_opaque->driver_module);
+	pf->irq = 0;
 
 	return ret;
 }
@@ -770,3 +771,29 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 	if (indio_dev->trig)
 		iio_trigger_put(indio_dev->trig);
 }
+
+int iio_device_suspend_triggering(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	guard(mutex)(&iio_dev_opaque->mlock);
+
+	if ((indio_dev->pollfunc) && (indio_dev->pollfunc->irq > 0))
+		disable_irq(indio_dev->pollfunc->irq);
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_device_suspend_triggering);
+
+int iio_device_resume_triggering(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	guard(mutex)(&iio_dev_opaque->mlock);
+
+	if ((indio_dev->pollfunc) && (indio_dev->pollfunc->irq > 0))
+		enable_irq(indio_dev->pollfunc->irq);
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_device_resume_triggering);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f6c0499853bb..c66c784d31e4 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -810,6 +810,23 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 }
 #endif
 
+/**
+ * iio_device_suspend_triggering() - suspend trigger attached to an iio_dev
+ * @indio_dev: iio_dev associated with the device that will have triggers suspended
+ *
+ * Return 0 if successful, negative otherwise
+ **/
+int iio_device_suspend_triggering(struct iio_dev *indio_dev);
+
+/**
+ * iio_device_resume_triggering() - resume trigger attached to an iio_dev
+ *	that was previously suspended with iio_device_suspend_triggering()
+ * @indio_dev: iio_dev associated with the device that will have triggers resumed
+ *
+ * Return 0 if successful, negative otherwise
+ **/
+int iio_device_resume_triggering(struct iio_dev *indio_dev);
+
 #ifdef CONFIG_ACPI
 bool iio_read_acpi_mount_matrix(struct device *dev,
 				struct iio_mount_matrix *orientation,
-- 
2.46.0


