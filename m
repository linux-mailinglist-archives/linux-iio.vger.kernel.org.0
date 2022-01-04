Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA537484A0C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jan 2022 22:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiADVm3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jan 2022 16:42:29 -0500
Received: from aposti.net ([89.234.176.197]:52048 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233569AbiADVm3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jan 2022 16:42:29 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/8] PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
Date:   Tue,  4 Jan 2022 21:42:07 +0000
Message-Id: <20220104214214.198843-2-paul@crapouillou.net>
In-Reply-To: <20220104214214.198843-1-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
for both runtime PM and system sleep, which is very likely to be a
mistake, as a system sleep can be triggered while a given device is
already PM-suspended, which would cause the suspend callback to be
called twice.

The amount of users of UNIVERSAL_DEV_PM_OPS() is also tiny (16
occurences) compared to the number of places where
SET_SYSTEM_SLEEP_PM_OPS() is used with pm_runtime_force_suspend() and
pm_runtime_force_resume(), which makes me think that none of these cases
are actually valid.

As this macro is currently unused, remove it before someone starts to
use it in yet another invalid case.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/linux/pm.h | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e1e9402180b9..31bbaafb06d2 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -366,6 +366,12 @@ static const struct dev_pm_ops name = { \
 	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
+/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+const struct dev_pm_ops __maybe_unused name = { \
+	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+}
+
 /*
  * Use this for defining a set of PM operations to be used in all situations
  * (system suspend, hibernation or runtime PM).
@@ -379,19 +385,6 @@ static const struct dev_pm_ops name = { \
  * .resume_early(), to the same routines as .runtime_suspend() and
  * .runtime_resume(), respectively (and analogously for hibernation).
  */
-#define DEFINE_UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-static const struct dev_pm_ops name = { \
-	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-}
-
-/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops __maybe_unused name = { \
-	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-}
-
-/* Deprecated. Use DEFINE_UNIVERSAL_DEV_PM_OPS() instead. */
 #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 const struct dev_pm_ops __maybe_unused name = { \
 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-- 
2.34.1

