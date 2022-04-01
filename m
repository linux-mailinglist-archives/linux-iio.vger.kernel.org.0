Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931364EEED5
	for <lists+linux-iio@lfdr.de>; Fri,  1 Apr 2022 16:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346678AbiDAOIn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Apr 2022 10:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346548AbiDAOIl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2022 10:08:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E92215472;
        Fri,  1 Apr 2022 07:06:51 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KVMPm6c5pz67VyR;
        Fri,  1 Apr 2022 22:05:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 16:06:49 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 15:06:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v2 2/3] PM: core: Add NS varients of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and runtime pm equiv
Date:   Fri, 1 Apr 2022 15:06:04 +0100
Message-ID: <20220401140605.31871-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401140605.31871-1-Jonathan.Cameron@huawei.com>
References: <20220401140605.31871-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
2.32.0

