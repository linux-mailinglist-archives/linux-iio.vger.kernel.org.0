Return-Path: <linux-iio+bounces-7966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905493DF50
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30932836A4
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2C80BEE;
	Sat, 27 Jul 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXfzCEy0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB880034;
	Sat, 27 Jul 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083462; cv=none; b=eQjVPFz+1MDlFCth1FKdajeWAVz1gVw7PXhkVN60aL7/oQHkEq0jTSi5fZxbXCWmJex1q41eAgvH5tJx0eSlmrL5DIcjSNcCcRoYKQA5DWl5CDuSIFipvjJKsy37PnpIzqz3zHGmH6qRfQeYZLxt8+1OHrzN+CmQG4hUDG6THpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083462; c=relaxed/simple;
	bh=xAwBVFQH8e7up7GuYAZk9EruzSQd6n3+Gr1ceCR/51E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTONjNO2k0Q7V0YjVHXowJTdnp+6Q3JXmAw+1eXokcT1iWX/ON7UrgPDW9nh5hbBW85nPj9w3mwZkcSGGITryo4Nine6nidXg7f1twjPA2NL2L+CmQnU/f9MSt1XQkUo2GjhDj9vS17rc48/QqSbjWXAlDDgi4hi5gYDIBR4rK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXfzCEy0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280bca3960so4018125e9.3;
        Sat, 27 Jul 2024 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722083459; x=1722688259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yxi8euCEWjpLf30egLarY0olD/MdHwC3K0RnPeARFg=;
        b=lXfzCEy0q2geTDy2YwawVYsvW5YTkwFPHkA/8HMBlMvaCYwST5e2iINsB5E6tfEEDC
         cD6EMDd8At+//U9bx+K3mW6lWmJrObJSimVDCbQ1KvOAp6A0lPteLDiXSWGxXU6Ove+X
         +h3Cdam4+1mR0BujI8NBkoOBrGTscdn7bsoKLd49mH1xSQbUfmBbWH+N0Ly6cjujIrSi
         lNcqJK0TIaBw9vZfYR4Xj465Ft4rD0PhJm5c5faBta5ZHvE+Jgt7vKaCyDetZ6lb+ssl
         z3Z5I47FjHlNtgmWtdV9qC15sO1rcXdOwOw5/zj/g0E1Doz1MUoPGiKxFwqnTDp9sHzz
         KU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722083459; x=1722688259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yxi8euCEWjpLf30egLarY0olD/MdHwC3K0RnPeARFg=;
        b=NvIkTefwPViT1r6eiWxJK/+BxWlOEetc0O0+lqoM161bUlZYi2kHbpF4gPqFLmwDNH
         SrIRUBgM3RQc3N/gAmCTF6Dhmtjg7Ng4SL3SVzPFSNOS1UpPiqa2GqtuWV6CCp4+e07C
         /rPR7t/uwX2NNzxQo7dKYPySKm270uwCyaPoSgLFs3YoNadgTWqZt/RI9HtBVaDB+p/3
         3Fa57JWrssOr8imPINa88xtgAP8xXr3yR3Xax4Od7f38LkXtJyxiwEjpKXYp0j8aAqnv
         c715IH0/8Pbo5zBybtM7v7XCO8WqVfdQvrwozIuDYfozQMUDv8jU9LbKkHAcqFKQ8F8O
         C+kg==
X-Forwarded-Encrypted: i=1; AJvYcCWApXbYGpT/YAXRBIcODGwH9qT3C8ZQJQhTLEcsHJgf7P3WExRcYZHDg4x7p9wJBeLo8crK2G/V0/lQ7p07h4lls85s2/aZL/ceotddjLxA6rdNyqNeEOqRoMU3OXUWTq8OXctYPPWA
X-Gm-Message-State: AOJu0YztL1nboP1PjAXGigxEImtlvaTt1zqGeQ9vTOV7GREDFL7PuZY/
	boWFY+MbssIvHXw7O9afUONqIceaUXlrBU3tC8MFVeD32RGwcfzN
X-Google-Smtp-Source: AGHT+IEGnr1xJZ+KYcBxak1Z1KruyWJkuGviM2Au54R7HVVS4+fJerANjY8EBFWVIEW6/Q6ueOr0nA==
X-Received: by 2002:a05:600c:5492:b0:426:5b3a:96c with SMTP id 5b1f17b1804b1-42811dcd245mr13661565e9.28.1722083458814;
        Sat, 27 Jul 2024 05:30:58 -0700 (PDT)
Received: from localhost.localdomain ([176.206.92.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6368sm114913215e9.38.2024.07.27.05.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 05:30:58 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v2 1/2] iio: trigger: allow devices to suspend/resume theirs associated trigger
Date: Sat, 27 Jul 2024 14:30:33 +0200
Message-ID: <20240727123034.5541-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727123034.5541-1-benato.denis96@gmail.com>
References: <20240727123034.5541-1-benato.denis96@gmail.com>
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
 drivers/iio/industrialio-trigger.c | 26 ++++++++++++++++++++++++++
 include/linux/iio/iio.h            | 17 +++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 2e84776f4fbd..2e92283fad0f 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -770,3 +770,29 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
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
index 894309294182..c87dfda54681 100644
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
2.45.2


