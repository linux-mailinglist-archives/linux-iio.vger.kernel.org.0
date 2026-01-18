Return-Path: <linux-iio+bounces-27911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35032D3979C
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 181F0300C5D8
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD62EBDEB;
	Sun, 18 Jan 2026 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEaIzD2b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D133B945
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768751098; cv=none; b=JQGbHH3PB/xbpavZftNTlHUfhprDo+68bFAeMLJOQ+Y50ebrWnovYgcLw4UtViskcpTcyC+ahTWK0UCFUMwCVxGC5sny9vG5rWDHsng0J1m/SuBnkh1CaSO67LaFwFwaapqZVnskSArD0d82I4J5OIaS8q7QEfWzxbJ0U6VqxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768751098; c=relaxed/simple;
	bh=V5GRFxOK+CqYOqKjTag3VDmILaHUud2L5Y/Wvb3b2ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X97GEkvHTehGEpjWVpsemyFNcxlriT9W1VZRYvEqmgo6PHNDv1xuube4qzp9lgx72eoidy02tuuXRDHRYF/LcJJW5XX6YiGHF1Xf2dcsqahnGC8SzJ1qREZAFmFrjBdns+7eIRIalUV16aoSwzaL9jLeu1H0OyhPipjlkNR/RFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEaIzD2b; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94388cfa259so1008988241.3
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768751094; x=1769355894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6CY6gggGU9QCCuY3V8jLvoji+Ol4m8zqn3+Qzz+4w0=;
        b=DEaIzD2bhdioW2brvbkMlA0FY30Wbnpc37xCzmeNtheqhIkixGeLubWOL3CHY0gLpy
         YOftSldJgxUsoQGqaQNcMOtHT31FUraL5cx6K4OQY9EtK4utxSpoDJKizomjHAhtezmV
         WD8Nt2y7H0/G/1LKL+zPdJ4WJCGshjNiwqh24MjBAhbnTkfMwTkPDwPYdz6zZYa9lqo1
         GdwyFMw8f20GwRw/6e4SVzzHoUZwiBlE5yP7qopuC5JvI8YJr43LfCzbUsbJknhErmC0
         Nz1nTBHOWz2bTqX6kY6Y6hBSt/OuPQdcKa6xO2aF5ZjwhHiOtXcvQKHnV4Vswkb00pNS
         S+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768751094; x=1769355894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6CY6gggGU9QCCuY3V8jLvoji+Ol4m8zqn3+Qzz+4w0=;
        b=R0EvQRQ6gWTpGoVP2ay7LHW8MTJClcbPsdGPjn1zB2GxSbSsetjeJhEnyXZJ+NUG2g
         Een3VQtDM9v5lFnlHi51AQqtJ/wpvnRFJ2j8Ytwc5y21kwGxQNTnt+DhTODBsGTUjyai
         zPjCYbgXLo2lBLV+n+f/4iU84IWl0HEmKIJeaoIHkHycfx0Qcb3cZyGv8wKM71P4zLw7
         EzbEIUjKUP1aPum66UQr2eRtVLr1ttILcr3f/e9HKIiTRwvKRE4Afd23jk6zS3I2sHWF
         T4UN2Y1+E4GoI+jnWp2UM/AR+EaXWORSGQ2HzKjaRbcIYIl9g2vVSrxq7m1/aSvpoojW
         5VJw==
X-Forwarded-Encrypted: i=1; AJvYcCUA/fsG2zJ51GmPHZq32Pb+6t7px0YickFOfCM9GfugzcDXVDxf38mxWaEF5oE8/zdP17VcUCNcFL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImjkHipNkfGiZ8WQln3K1xHBd8vefVklEH55iyLBaXcs26Gsy
	elqxmQah42a0F/FPT+fIMvJWM1gDQjUiN/YKZ/RrwWU1vWTgEDFsXPw0Np9gUFYb
X-Gm-Gg: AY/fxX7any8k8YB7487TDTt1ONr53uXtqA3umvD7RFVDGV+6q5if0b3rYJ3eBTTVuYB
	Cb6eZ6MO1Er4WziUswz39SKmVD8seRujky9+eG/iM4O7oJMYwGgJpycDS8piGvgfsROmXnEZV8P
	ML2adgaAs/RcVMawaCQAvLIVMSAewwSHog6B07wqmG4YD2cnJevN5THgLiLtk5j6nyR5xmBkZa7
	mrSEMSAqxTBMaTnRm6J2SeqzgZJHgb29ylKhZxoFaejcWpT/WRgHv6QpIDTgbE7YfpNOIHt2i7T
	a2mZrajPfKUNwy6X8Xx8vA4H4IhptB+FXb3WAX4+YdNUZqgxJ/HsD6+QM/c9Zg6j8b9VISgxVGp
	9DR0kMkN3WuYWqymfjr58nGTaxlx4ynTEv4Sijvz1OQgsa7YhBZi/TExYVZYXzAW+CbOWLEmU1Q
	2rG6B9CBNBhVtk
X-Received: by 2002:a05:6102:5109:b0:5d5:f544:a88e with SMTP id ada2fe7eead31-5f1a71b9607mr2391425137.35.1768751094087;
        Sun, 18 Jan 2026 07:44:54 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6d3ca2esm2832731137.10.2026.01.18.07.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:44:53 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 18 Jan 2026 10:44:28 -0500
Subject: [PATCH v4 1/7] iio: core: Add and export __iio_dev_mode_lock()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260118-lock-impr-v4-1-6c8d0aee8ed2@gmail.com>
References: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
In-Reply-To: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=V5GRFxOK+CqYOqKjTag3VDmILaHUud2L5Y/Wvb3b2ns=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJk5/z8sc/oo426zjDHXauYmqYyS97EeL/jsHxnmBZ97X
 znPpHBxRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAExEO5GR4Unwj3N67c++vLfs
 nMpTKrZhudQD4c9pEl/YIiInteix+TD8Mzy+0LlwaTZz3fKHAl2zj+8Jum72PuukhPjN5mm/7Z9
 lcwIA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add unconditional wrappers around the internal IIO mode lock.

As mentioned in the documentation, this is not meant to be used by
drivers, instead this will aid in the eventual addition of cleanup
classes around conditional locks.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f69deefcfb6f..9693a6bb3917 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2171,6 +2171,36 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
+/**
+ * __iio_dev_mode_lock - Locks the current IIO device mode
+ * @indio_dev: the iio_dev associated with the device
+ *
+ * If the device is either in direct or buffer mode, it's guaranteed to stay
+ * that way until __iio_dev_mode_unlock() is called.
+ *
+ * This function is not meant to be used directly by drivers to protect internal
+ * state; a driver should have it's own mechanisms for that matter.
+ *
+ * There are very few cases where a driver actually needs to lock the current
+ * mode unconditionally. It's recommended to use iio_device_claim_direct() or
+ * iio_device_claim_buffer_mode() pairs or related helpers instead.
+ */
+void __iio_dev_mode_lock(struct iio_dev *indio_dev)
+{
+	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);
+
+/**
+ * __iio_dev_mode_unlock - Unlocks the current IIO device mode
+ * @indio_dev: the iio_dev associated with the device
+ */
+void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
+{
+	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
+
 /**
  * __iio_device_claim_direct - Keep device in direct mode
  * @indio_dev:	the iio_dev associated with the device
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 872ebdf0dd77..aecda887d833 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -661,6 +661,9 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
+
+void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
+void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
 bool __iio_device_claim_direct(struct iio_dev *indio_dev);
 void __iio_device_release_direct(struct iio_dev *indio_dev);
 

-- 
2.52.0


