Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1275E941E
	for <lists+linux-iio@lfdr.de>; Sun, 25 Sep 2022 17:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIYP50 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Sep 2022 11:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiIYP5Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2022 11:57:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3290C2715A
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 08:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECEF9B8092E
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 15:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64296C433B5;
        Sun, 25 Sep 2022 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664121441;
        bh=bBANOriHRBtfg54Gn2KgoM6NZYh17UtA5LvMOjx/ueg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PbyTqU/FyAUHddUD+Tp+fCmm+hokyIS8PVQYIXqi7tjLNo22fmvfJpRM9Kb6Uge14
         f3YSnE9zTtUhPhvT2kVlcgfgf8w2uN6tkc3jx9uPv0KD5Dfe+PKQZQi2g4F+y1N3co
         rk3X94sgRmQCX8embf5YnfoPNXt1qUryENOVLLi4yzk0pqO6akdzspajIuMPm1WEAT
         VZl4aG9Mj+ORKL5dQJkpCoFhiwqkRG9Yag/NBE02S+/UlwhE+AQ61EUuMJx6ei7+RI
         V7GtOUPli1Rya92nr3pxVky5SXuAK3E3cOPYaHgr+ARcxWywk1vLBui4CgmqBwVBnk
         u5fKW6PnvFKWQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/5] pm: Improve EXPORT_*_DEV_PM_OPS macros
Date:   Sun, 25 Sep 2022 16:57:15 +0100
Message-Id: <20220925155719.3316280-2-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220925155719.3316280-1-jic23@kernel.org>
References: <20220925155719.3316280-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

Update the _EXPORT_DEV_PM_OPS() internal macro. It was not used anywhere
outside pm.h and pm_runtime.h, so it is safe to update it.

Before, this macro would take a few parameters to be used as sleep and
runtime callbacks. This made it unsuitable to use with different
callbacks, for instance the "noirq" ones.

It is now semantically different: instead of creating a conditionally
exported dev_pm_ops structure, it only contains part of the definition.

This macro should however never be used directly (hence the trailing
underscore). Instead, the following four macros are provided:
- EXPORT_DEV_PM_OPS(name)
- EXPORT_GPL_DEV_PM_OPS(name)
- EXPORT_NS_DEV_PM_OPS(name, ns)
- EXPORT_NS_GPL_DEV_PM_OPS(name, ns)

For instance, it is now possible to conditionally export noirq
suspend/resume PM functions like this:

EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) = {
    NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
};

The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS() and
EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use these new macros.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pm.h         | 37 +++++++++++++++++++++++--------------
 include/linux/pm_runtime.h | 20 ++++++++++++--------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 871c9c49ec9d..93cd34f00822 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -375,19 +375,20 @@ const struct dev_pm_ops name = { \
 }
 
 #ifdef CONFIG_PM
-#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
-			   runtime_resume_fn, idle_fn, sec, ns)		\
-	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
-			   runtime_resume_fn, idle_fn); \
-	__EXPORT_SYMBOL(name, sec, ns)
+#define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
+	const struct dev_pm_ops name;					\
+	__EXPORT_SYMBOL(name, sec, ns);					\
+	const struct dev_pm_ops name
 #else
-#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
-			   runtime_resume_fn, idle_fn, sec, ns) \
-static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
-					 resume_fn, runtime_suspend_fn, \
-					 runtime_resume_fn, idle_fn)
+#define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
+	static __maybe_unused const struct dev_pm_ops __static_##name
 #endif
 
+#define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
+#define EXPORT_GPL_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "_gpl", "")
+#define EXPORT_NS_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "", #ns)
+#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "_gpl", #ns)
+
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
@@ -399,13 +400,21 @@ static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
 	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
 
 #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", "")
+	EXPORT_DEV_PM_OPS(name) = { \
+		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	}
 #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", "")
+	EXPORT_GPL_DEV_PM_OPS(name) = { \
+		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	}
 #define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", #ns)
+	EXPORT_NS_DEV_PM_OPS(name, ns) = { \
+		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	}
 #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", #ns)
+	EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
+		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	}
 
 /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 0a41b2dcccad..9a8151a2bdea 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -40,17 +40,21 @@
 			   resume_fn, idle_fn)
 
 #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "", "")
+	EXPORT_DEV_PM_OPS(name) = { \
+		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	}
 #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "_gpl", "")
+	EXPORT_GPL_DEV_PM_OPS(name) = { \
+		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	}
 #define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
-	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "", #ns)
+	EXPORT_NS_DEV_PM_OPS(name, ns) = { \
+		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	}
 #define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
-	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "_gpl", #ns)
+	EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
+		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	}
 
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
-- 
2.37.2

