Return-Path: <linux-iio+bounces-7869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6942C93B9CA
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 02:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB231C213CB
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780317F8;
	Thu, 25 Jul 2024 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad3H2iLG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632563D0;
	Thu, 25 Jul 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867250; cv=none; b=i2T2aKx2JyLyGg38PUvvOuniZkFA6WE67aQ3CDsQqf5x37BnbGcZgiiB+IJM9j9nXO19ewD8uu1N+FbqZBzHkJRtqd3jcbGb0CMgIurGqE4tNUXUBzlSuEJ5erNkK+u3VqWA0UhTXJnW9BpieRTTogsJgRvPvpnDBwV/D31/TdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867250; c=relaxed/simple;
	bh=xAwBVFQH8e7up7GuYAZk9EruzSQd6n3+Gr1ceCR/51E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CseDmj+vWkw9PT6tCGfeFoviHPiTunjinE6Qbgbu9s8wrn4ETwnf/CEfDlZjy23GFfnJ7MUjG6KqFWIxT+fflyxLqLDOEgcU4yXKu99o/iVcO0RZWKIHZqe8J6o+jkv0Q+zfYlyVUABu5NCU62CetQjQKI8umAyAIN7DogviNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad3H2iLG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266f344091so2352045e9.0;
        Wed, 24 Jul 2024 17:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721867247; x=1722472047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yxi8euCEWjpLf30egLarY0olD/MdHwC3K0RnPeARFg=;
        b=ad3H2iLGZCMBjtsESA5iIohYRklMsGHwSS+qYvyRDoMxJAjWKDwacRiQGjEZ4MvouP
         hIEJ9D7X/AnPEWJmDOjrQ8IX/ORe+h6tZ6WHlowbnxamINhTxVYeKge7S6zlfbSKAEuw
         B/+SdNVZ/jV0giNTIvwDKgsT67l2KFQMXoCUcwSMEL1pqCSw6smud0MFJp+fk5cPl1ci
         MRotRKEQ+HERHZYuTqyM+m9BLcRluzf4dUiJR+Y0KGVzfKOQDp7DWcaRT9Eej8EPhlV1
         WnnTv8AQx4O2uvZplw+3cOUMeILADK6SmjnUIKlVcuOsQ9Vx8DiXXRyAPSdMRWb13il9
         lMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721867247; x=1722472047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yxi8euCEWjpLf30egLarY0olD/MdHwC3K0RnPeARFg=;
        b=CLNoIJx6IcJisuW9vg3k84bDvVivFZN+kp6EGiF/DVJkbaB9ZV5uROMXINSuGrTfl8
         +re88gx29/A4s4U4HM0hL3e5hi2hKaxTz/XnxKxhk4kGk9CfyWF5rGleuA9twIW5qNIy
         1pGZaulfZ9lDZ+p49wHmFAIlX0QHhPn8x8+TICF3YwncdNvE8/VGgK/+t3HLN4BPT1DY
         HaDBGgiBR4GH2GYUjRxmDuL6XYhd84nEezKKuynsY5dTqMND8+Bd81Zp+mz0eFLk2EWJ
         OeCJpghWxS1eXieo9nrPTeyKV0MesjHoxmOupRRxfjbYXCvHDzADLeHv+ctPECz1qTGq
         sNWw==
X-Forwarded-Encrypted: i=1; AJvYcCWoOaBcE1aUL8oWh+tAUYCzVJwZgDIb2fY0z70t8hFYbu4cGTceeyBGgtgSBad0GMSxV3AsJ88JqiLifBEw6UszXFojvIirlghp+GUk6TLRtJOlJMNa/DwVzmUoE1KjVJ2i9w9FuZcn
X-Gm-Message-State: AOJu0YwVg1fdssQwFxfJwYdGb96hkYx4KNEoOgsMxsrtMRKqPBeKmJk0
	S0WbG6txcddCWZzRZUAznJ1xw0SquLficc9++9L0kPJqtdvo3OGc
X-Google-Smtp-Source: AGHT+IF+G00j39Vy33dYOGjD04m+c1z+Ee1YT6dehvKjdvNSWao0oCNuMGItaf4LqjFKcZVmzL1MZw==
X-Received: by 2002:a05:600c:3b21:b0:424:ad14:6b79 with SMTP id 5b1f17b1804b1-42806b5c0b8mr1980455e9.8.1721867247126;
        Wed, 24 Jul 2024 17:27:27 -0700 (PDT)
Received: from localhost.localdomain ([151.49.92.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b0e8sm8233605e9.26.2024.07.24.17.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 17:27:26 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH 1/2] iio: trigger: allow devices to suspend/resume theirs associated trigger
Date: Thu, 25 Jul 2024 02:26:40 +0200
Message-ID: <20240725002641.191509-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725002641.191509-1-benato.denis96@gmail.com>
References: <20240725002641.191509-1-benato.denis96@gmail.com>
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


