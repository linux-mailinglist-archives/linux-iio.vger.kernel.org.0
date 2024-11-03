Return-Path: <linux-iio+bounces-11876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 142AF9BA859
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 22:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A761F20F9F
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E077B18BC29;
	Sun,  3 Nov 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJNM+rpr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674E189BA3;
	Sun,  3 Nov 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669955; cv=none; b=MhNqyTMSkvAG14DmgRHP5LpI5sv73x3UNY6jo23jJR9Ay4qdDUwqcBuRS2WdQ6ZzPSQEoWjTfVXugQ6cM7vTDjCQeRmpsjHnFqGYcKvgOszLAOvZLILSqcASHklgMUXnQ5RaeFxGK5eXu5jGNboT3qMKeuV0DRXATReL4LQ8xb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669955; c=relaxed/simple;
	bh=Jok0MB3/q3anWfOSQpzxb1BnAFdIcPOVvInpT0WAEfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C26t+bswlYuU2jQ3oxQ6KplBuUJ5+YaoLOLTP/S3nZxosW4+i0NN551D4TgPQE+Se0vGLm9B5EvMPDGDBScOXDfxYeXbkK1k2ixRmSaRh/wdLcP+ZHP6JUT2W7DSPJuQt0JzAAKnrbZ2BRLyBc7a54hfiR03Ym3yCSKO1719rwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJNM+rpr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b1467af9dbso276832885a.0;
        Sun, 03 Nov 2024 13:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669953; x=1731274753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFVi2mNc7smaUSpqUV8IgqBMIyn5vhuRCKFcW8iODME=;
        b=TJNM+rprxcWZUU+WXu/rN5cWXRsBkpueCWdmT1fmOZLiFhlcWelAnEFZIpls/+uz5J
         EvCE99E85pHi7KcspCvcXJfEY0P007xLInFwue/dwcCIFk0l2YhI58ZdrInQKHmqxcsx
         m4RDM8h4Ejng9f5EseerwyOxY7YGb2WD0AEUXSF9Nwb7J47FqUkpJRbU+ML0uzEgIoDw
         N+Oxb1CJZBd7x9LHDgtvE43GFqmSGuQnse29koZm6hwr9KyZCJ89/RQd2mw4zH1o9ect
         ZsUe+LLSbTa9cqzma9kNC7JqdqQmOi7j1OaoygONA7u7t8XfIlK6mt1qLiPMcMObOyxO
         Hq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669953; x=1731274753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFVi2mNc7smaUSpqUV8IgqBMIyn5vhuRCKFcW8iODME=;
        b=S7IwU5KsKINC2wWg2asKMIONZP/rQE3JqJNy/irElZPO/2bbe7Hesw7AdEkVZTVw7B
         EKlvZYQBtzjJnO6A68H+MMr7E4y8k3yREdqzAQuo7jTICldDPQsKE/XDzsuJab1hC3af
         GpMioYVBnIPKHADObsxIu5teDSpUD1s0DtnvcZmGmvg0e83t4ibv7ceEdvHvoaVuywgS
         ++SPO8bAjuu9utyGVGiZgP+vlwXWJomyTKGMziAlLOB22IUVU3D6v0iWGPicAb3Ie4gc
         lu7pBvrHV42u5p4mLIBmb4PCfQZ8ikjg71nxW8mC8m7rFmf9CU9Z51e4pShnkbCFMw1/
         f5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU9G58BvNNWTJJNuU3gfqeWbs0JkZnEOa4vvYeb3icVjlvN7lUg9zGxhAuko/5udIpaUxBmWgvEJMGJMg==@vger.kernel.org, AJvYcCXmS9JPz6DJsxy/pUDrk8HY6wjF0eDLao1lhx732LgdPnCK7vCWSeSgsU5QlVKVsguSpXxo0aG5m+6Sak4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqN2c4Tz4zwnyiYVuZRIqJtB91CDUKIO81juzXIuRPW7ixwqN
	sGo0eZGTbgbJM/TKQU6phpB5Opyvc8NMeTPh/IAip4sdhiDSnSwL
X-Google-Smtp-Source: AGHT+IEJJ81Rfz5B53h8fh2vx4nDSYEt9Cb2ocAO1cYoLk4b3StAYMYarD9H0rz2o7m2aF4Tcd72HQ==
X-Received: by 2002:a05:620a:450e:b0:7b1:4762:45c4 with SMTP id af79cd13be357-7b1aee51f10mr2426040785a.54.1730669953050;
        Sun, 03 Nov 2024 13:39:13 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a117c4sm365448685a.68.2024.11.03.13.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:39:12 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: vigneshr@ti.com,
	jpanis@baylibre.com,
	wbg@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] counter: ti-ecap-capture: Add check for clk_enable()
Date: Sun,  3 Nov 2024 21:39:10 +0000
Message-Id: <20241103213910.31976-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() in order to catch the
potential exception.

Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support for ECAP")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/counter/ti-ecap-capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index 675447315caf..30a269fa5da0 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -574,8 +574,11 @@ static int ecap_cnt_resume(struct device *dev)
 {
 	struct counter_device *counter_dev = dev_get_drvdata(dev);
 	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+	int ret;
 
-	clk_enable(ecap_dev->clk);
+	ret = clk_enable(ecap_dev->clk);
+	if (ret)
+		return ret;
 
 	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
 
-- 
2.25.1


