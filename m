Return-Path: <linux-iio+bounces-16736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC99A5CA17
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F637AD54C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8F260396;
	Tue, 11 Mar 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvVhYvUJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142425E825;
	Tue, 11 Mar 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708775; cv=none; b=kGjI+MEvRYuggtm9jPrfLtRa+7klih8jeT+iskffwJe9XNql6M0DC4mbg6X/hvkUWG9ZfhtPTLzVnpYmJA/X5LO1609Y5cS+0/oj84/tebp/UjzL96tKDQMqSrJpFvliG2dKD8hxQiUOZc4ojBGwA4TKLMMJWG35geRl7F40yqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708775; c=relaxed/simple;
	bh=yZVDAMXDKyayS4W4DCnf2up7ngjkuWd+hjdokyxRVcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzjJt6rkDrb+MY2YRvVdmGtpiTRHd5hobkPa7SxoKfLKLk0EFgUQMjgezQ79wzMEvZprU/VjKsoPz+Be8mXWJuj9RxA42/4h3rB3HzHs40on3umRjeuJjftTyYuJNbgSATCg2Qwzpv89O0p7ETgKRrk5+nM6spOSFVkO+fShWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvVhYvUJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223a7065ff8so13007365ad.0;
        Tue, 11 Mar 2025 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741708773; x=1742313573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCNydoAFyd6DNeo40itFioPOZBKtU3YX9TRd8RaDHCg=;
        b=HvVhYvUJPe/hXJJp8AtilxBAOXpXdHxU/m5K11TLrlYJqqV/1iXc3CpXxtJp2mNm6N
         CQrJEXglPKzGtMaPptiUYFu8rXxpAVYv7vjt2t7TZD0bSixO62iF30sMx2kToMFwbg8+
         IOHKkzI8inDxPzlBvTodaFqB3jjF8bFWPEXidlF1lnxT/+E2W1LxauTVEEUCIc4/XyLs
         zSgclzTu/I7dnlf995tUFGGUq1Pw7FIuHh72I+IynbObFTo1r0Pv4JNGTYJ8m33O0Q9w
         LQ3xRc29NQCwHAOQhLmqyc7avoAE+vt/lMysSwgIdrVlHgl0dyEH+fADqGFq8aij74cP
         ocsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708773; x=1742313573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCNydoAFyd6DNeo40itFioPOZBKtU3YX9TRd8RaDHCg=;
        b=A1mv8kKGgORHAXwUUUv9VAh0/Y6AniyXlwIdiDt07Mpt17Wz+jvaRwt/BgmNitbntn
         rW66/5HsfP8Af597xFZYeBQ63ndPDVJtj9IaBZgoXtSiMcm4QIau4RIqd55T7cCEGLCj
         Rc5cWZReNnIlkm9f4Ck4TjsUoQmw17CGXR8lwi4UiCb4UgwJCR5rZNOi2e8FhsLu34DP
         /rM+efZuSuG9zTZGXT28BKwisRW0M7rxEkmsVadu3ERJn/NevHguBtL5JoP4+m4lboxl
         QT30KFU3PMTxpXLmMSnOUawhrVJEsWeFiY/sHgemScscrT1pj8uatmnVUR3FhEdFRUx2
         Jt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWx7gM552+fM9hy/uGXSsC77MkkWcRD62O2A9XxBiKn57UPJuDdx8g7YIDgDDc3zl6DgkjVJc3F/0Q=@vger.kernel.org, AJvYcCXMV2Yao5jdKyyZ0wBqnbd3S4pjKX6T2z7zjuZngHDBmtD96qk4rn+DUG2fxFVfC8SDxDUuyjzwJ4oNKwqo@vger.kernel.org
X-Gm-Message-State: AOJu0YysZ/LFNKvkN1/HiXnhdqXthjKhTpQ9PJujcDpMXwOdsxqDMpmC
	uiUFu5LIAaCBJzXxzM5GxBbCps1t2vAWtU1CDBxG2UnOUcCyTM5l
X-Gm-Gg: ASbGncvvB0ss+mv1FqMFmBsVD+wAdA8HYdODGF1PNr8K8EjOP0nCSAdZiDI+/2WadPU
	JpHqe/p2/fqIH5MV71Iw8nx9tkDDIbl5AbQ35sSteIyRB5xw4NVp1Z8lvmA0lIcj7/Gl6/fdq+y
	/XONRR6f+/nf0vH3LkKxXnr3+cUD3ej2Sh/bFnGa4SANwtk7rXxsyDIl0jw4+I8Yo6C1tFrQjjw
	l3dY5yEKkcewNPSjLr1PcL/Q+MuKFlQYLIA1UfdZb4UKdH4JrjYYku8MsXJa7E0BCEiXlGRCexa
	WuT+6nB/Jg2ji8vCV9h04ykT4mTdZxNR1G1wvzk0VSRyapGzhsAxTtXVNF8zyHSB9bLRnWaGvZy
	9tsI38lpVZcrR4UA+kHteN6U2tZRn6yhVy6Oofg==
X-Google-Smtp-Source: AGHT+IGgeHlhqDLZGfH1ls3PTzCaL+VE5RDfOBxEXEDldkVg+Mz0o2RA+RV/kjYMYC0xERB7xuys4A==
X-Received: by 2002:a05:6a21:9786:b0:1f5:8506:5039 with SMTP id adf61e73a8af0-1f585065599mr10314781637.28.1741708773532;
        Tue, 11 Mar 2025 08:59:33 -0700 (PDT)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281075eaesm9750549a12.3.2025.03.11.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:59:33 -0700 (PDT)
From: Suraj Patil <surajpatil522@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Patil <surajpatil522@gmail.com>,
	Suraj Patil <your-email@example.com>
Subject: [PATCH] iio: industrialio-trigger: Fix typos in comments
Date: Tue, 11 Mar 2025 15:59:27 +0000
Message-ID: <20250311155927.467523-1-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed multiple occurrences of 'reenable' to 're-enable' in comments.

Signed-off-by: Suraj Patil <your-email@example.com>
Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..21688cd348c6 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -162,11 +162,11 @@ static void iio_reenable_work_fn(struct work_struct *work)
 	 * This 'might' occur after the trigger state is set to disabled -
 	 * in that case the driver should skip reenabling.
 	 */
-	trig->ops->reenable(trig);
+	trig->ops->re-enable(trig);
 }
 
 /*
- * In general, reenable callbacks may need to sleep and this path is
+ * In general, re-enable callbacks may need to sleep and this path is
  * not performance sensitive, so just queue up a work item
  * to reneable the trigger for us.
  *
@@ -175,14 +175,14 @@ static void iio_reenable_work_fn(struct work_struct *work)
  *    the final decrement is still in this interrupt.
  * 2) The trigger has been removed, but one last interrupt gets through.
  *
- * For (1) we must call reenable, but not in atomic context.
+ * For (1) we must call re-enable, but not in atomic context.
  * For (2) it should be safe to call reenanble, if drivers never blindly
- * reenable after state is off.
+ * re-enable after state is off.
  */
 static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
 {
 	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
-	    trig->ops->reenable)
+	    trig->ops->re-enable)
 		schedule_work(&trig->reenable_work);
 }
 
@@ -243,8 +243,8 @@ EXPORT_SYMBOL(iio_trigger_poll_nested);
 void iio_trigger_notify_done(struct iio_trigger *trig)
 {
 	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
-	    trig->ops->reenable)
-		trig->ops->reenable(trig);
+	    trig->ops->re-enable)
+		trig->ops->re-enable(trig);
 }
 EXPORT_SYMBOL(iio_trigger_notify_done);
 
-- 
2.43.0


