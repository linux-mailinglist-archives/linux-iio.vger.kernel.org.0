Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B564BD086
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbiBTSJP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 13:09:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244482AbiBTSJO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 13:09:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175C527E3
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:08:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14B43B80DAD
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 18:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896FBC340F0;
        Sun, 20 Feb 2022 18:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645380530;
        bh=Vy/rE6jW/gLwIq9M04Ry+5g5a6fATgcJy2+KHhwSYPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/DRQJnxACslKGYxERXr+b4k1NfOPUSWjY2mmj6orDbsHftinnvgisv94kDi0PoY2
         e2El4/dUzx2anGxJIL9dpxxPIrIckXQRX444sMVIE1fapgw4L6VNb0PNoE5hUdmmn8
         0mGzDoFztVgoPwHmjVLWzN76gD4ZMRJ/drH7jFFQA/0aPCmx8TeiJGBYQFlvZPOTLh
         aChCHdjY8LG8r7gTSNIxl2OCoHrqJqdEr9aY3ZR7x5sH6kQxPhQUZDwONQOipzKCoq
         J7HtZVgijg9U2GQ33IZNEH1k1tHrWn93BVBxUzrQhkRDVuJVYZgpnvIe4/TcpT3grg
         xu0WBmlkpekBg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/8] PM: core: Add NS varients of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and runtime pm equiv
Date:   Sun, 20 Feb 2022 18:15:16 +0000
Message-Id: <20220220181522.541718-3-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220181522.541718-1-jic23@kernel.org>
References: <20220220181522.541718-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As more drivers start to use namespaces, we need to have varients of these
useful macros that allow the export to be in a particular namespace.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm.h         | 14 +++++++++-----
 include/linux/pm_runtime.h | 10 ++++++++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index f7d2be686359..112b8125d4be 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -368,13 +368,13 @@ const struct dev_pm_ops name = { \
 
 #ifdef CONFIG_PM
 #define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
-			   runtime_resume_fn, idle_fn, sec) \
+			   runtime_resume_fn, idle_fn, sec, ns)		\
 	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
 			   runtime_resume_fn, idle_fn); \
-	_EXPORT_SYMBOL(name, sec)
+	__EXPORT_SYMBOL(name, sec, ns)
 #else
 #define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
-			   runtime_resume_fn, idle_fn, sec) \
+			   runtime_resume_fn, idle_fn, sec, ns) \
 static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
 					 resume_fn, runtime_suspend_fn, \
 					 runtime_resume_fn, idle_fn)
@@ -391,9 +391,13 @@ static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
 	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
 
 #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "")
+	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", "")
 #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl")
+	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", "")
+#define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
+	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", #ns)
+#define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
+	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", #ns)
 
 /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 9f09601c465a..6a8b9551ecad 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -41,10 +41,16 @@
 
 #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "")
+			   suspend_fn, resume_fn, idle_fn, "", "")
 #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "_gpl")
+			   suspend_fn, resume_fn, idle_fn, "_gpl", "")
+#define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
+	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
+			   suspend_fn, resume_fn, idle_fn, "", #ns)
+#define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
+	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
+			   suspend_fn, resume_fn, idle_fn, "_gpl", #ns)
 
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
-- 
2.35.1

