Return-Path: <linux-iio+bounces-9690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38197DE34
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 20:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A991F2191F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1A7DA79;
	Sat, 21 Sep 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8TB43cI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194B405F7;
	Sat, 21 Sep 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726942789; cv=none; b=bQkn8BcWrH+Ty5IHKqUgYW/LEWseQlgDEhYvWjieaj+15zcXIBT1Q5c7OOSNmRM+IxYrhK6Vi/91cqYSFTeHXb5kyz5aa4kdKSvxFRII2DC07sQXBSDO+aeUypB/K+CUQDLBksmMaJKDFSiZ1GSj/eTYzaWcjJZLpwVYCfnhUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726942789; c=relaxed/simple;
	bh=3cWr+2kYsobguCkTLuApzeYH5DnVlYSiaiVDSNRMj+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1unD1BngPpoBiQoKUxY71KkH6YZnjNVQrc02Y0azpAvl1Ohmw4tHIZ3pRSEsnDRr1c3ipI8b2HKEXXn8qp+SWw9f4sPLT86Bu3hiRQJOkAHPM/0DnfGsjM3S2wMmfw77HpHh3NfCXMuf2gBlvz4LHyp8r7nd5luayLOqXN7G9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8TB43cI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so38711055e9.0;
        Sat, 21 Sep 2024 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726942786; x=1727547586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ov3nWuuNutZ9EhUmix81AjTrNsTlAMjsXRRshCjtjY=;
        b=i8TB43cIKi0ceOPOTC7fcFUCnwcI3Do/MTRpmrcXBHzohFXQR3l/QZRUerN/B11PSU
         qnWj3tF18AeSf1OdqNi5Z6J0PKqS54DGVU04TyDXdnKx+AQ2SjhxYnyWWtRrlhESNeaX
         7KEMAOlueZCWdaTB1zdBs7SymfI+1aEJxXDheS9hyMg3Ki7JWSKH0gbbPNUu7c8hpImO
         ftVMEDuABA4yEE0wq4qj+7pNDzT/JiK0mHwsczH62Fwkw9sOJSQvF2tksgdAzx3R2SgD
         ToOZaLbRWgflkNrwNGLV7YKKno8QxyRwjkPpSjb1WE7onM9qOuo2fU8IWthDf9hjfP5n
         ryOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726942786; x=1727547586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ov3nWuuNutZ9EhUmix81AjTrNsTlAMjsXRRshCjtjY=;
        b=p23pFGI8k8zxkxfbSbSvZEjeo++nA7Xgh2/eTkgP4Q5OMU+A4nN5WwY/GvRTk3ynPO
         zO3vWy/IcJRHzRUNK1T8zle225HkRFcqgbhLWFtFzSebaQhj8OkXMoxMR64tUyCWlkmk
         Iid4v8s8q7+h/sxtOEMP/3rWoaXg9Jvye02rwRb6KDVI2yvrXWWuGspxkIYI03TAME87
         cpEjmvt3ZBL572Yqg3Vv/fAaPz9E511g77vW7hVMIz7trVBfxime+cdiQ6670YsqDi2V
         9pp0eDG81fPaKoNgira1FcRZgF9Q7VXETP42eQrJgfRExMGQHNt01LPLn37EwthJGcso
         Nsdw==
X-Forwarded-Encrypted: i=1; AJvYcCUw/ztsCleVii20xvm46gpr5g7IRXamClhyXMS3u3VvxtEqHLj4i8XGByyVQ8RvScuQnI0TPRdHHv9RbFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUK58y+6gRs8n/GoiS/YUXrkdhZq+s9i8u77ZuzX2odCElFMno
	K+7s7Cnkd8nvw3cAcpn9RTcUXiBHdTokdeoCaKh+4YlXqjJVHjUo
X-Google-Smtp-Source: AGHT+IEO9+sK7TUcojlw2XckDWLPqrdiN3UZ/umC+HH9qCv5Mps6KFYODSb3QjrsKiT4XWVIJKJlWg==
X-Received: by 2002:a05:600c:350a:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-42e7add6bb0mr68913825e9.29.1726942785564;
        Sat, 21 Sep 2024 11:19:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a498:414b:b435:bfeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afa9c93sm55494315e9.18.2024.09.21.11.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:19:44 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	mazziesaccount@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 2/2] iio: remove iio_validate_own_trigger() completely
Date: Sat, 21 Sep 2024 20:19:39 +0200
Message-Id: <20240921181939.392517-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240921181939.392517-1-vassilisamir@gmail.com>
References: <20240921181939.392517-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove completely the iio_validate_own_trigger() since it is not used
any more and since the iio_trigger_validate_own_device() can fully
replace the function.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 20 --------------------
 include/linux/iio/trigger.h        |  1 -
 2 files changed, 21 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 3da8b8c25185..b980843b5a3c 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -718,26 +718,6 @@ bool iio_trigger_using_own(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_trigger_using_own);
 
-/**
- * iio_validate_own_trigger - Check if a trigger and IIO device belong to
- *  the same device
- * @idev: the IIO device to check
- * @trig: the IIO trigger to check
- *
- * This function can be used as the validate_trigger callback for triggers that
- * can only be attached to their own device.
- *
- * Return: 0 if both the trigger and the IIO device belong to the same
- * device, -EINVAL otherwise.
- */
-int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *trig)
-{
-	if (idev->dev.parent != trig->dev.parent)
-		return -EINVAL;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iio_validate_own_trigger);
-
 /**
  * iio_trigger_validate_own_device - Check if a trigger and IIO device belong to
  *  the same device
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index bce3b1788199..51f52c5c6092 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -171,7 +171,6 @@ void iio_trigger_free(struct iio_trigger *trig);
  */
 bool iio_trigger_using_own(struct iio_dev *indio_dev);
 
-int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *trig);
 int iio_trigger_validate_own_device(struct iio_trigger *trig,
 				     struct iio_dev *indio_dev);
 
-- 
2.25.1


