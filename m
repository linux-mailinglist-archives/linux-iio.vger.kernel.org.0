Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB0447F3C7
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhLYQLV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhLYQLU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA4EC06175C
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008DW-LI; Sat, 25 Dec 2021 17:11:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dS-006ahC-PF; Sat, 25 Dec 2021 17:11:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dR-0007gA-Qc; Sat, 25 Dec 2021 17:11:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 11/23] counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
Date:   Sat, 25 Dec 2021 17:10:44 +0100
Message-Id: <20211225161056.682797-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=0yX2wuHepSgzmHBcBjV+l+JzQO1R5LNoMTHdUc1ehqw=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=MPuYNGn6o/9dZFmQfs3kSBFCwdmcbQB8/ZjqZVWw3zU=; g=a38dfe0269317a90960ceb5e30dd5407f739ecfc
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQlQACgkQwfwUeK3K7Anfagf+Om4 6XIfXpaalut52jCQf4HqUWFCGKV9nqoTPNrITr798f0nM+XkgIFK+nB6UJOdLzDIQuWDKiV5vRGE6 1iGs+9590ruZ4H0AeZC31ABLx8q65o4vCP392FBszyUk0nSzDxtNRsak4OlGJ/AEukmZ9kiBHxgY4 Bt4WxKq8nTUIP0HahHvcLv2CLE7uynOY6Cgko3khhKE3Pj0qCSvlq1EcMEff68BCvgI0ETDDzuGUh Um5lFDq61f1PrJ56loSLBoc6SqZKtGV/b58fOuHuT54VimyxhhWlJtbbt5HIYzD2ibRAEsEyaKJBS FWVDyjE5s+SBFprfZBI/RT+ymu63dzg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/stm32-lptimer-cnt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 5168833b1fdf..9cf00e929cc0 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -141,7 +141,7 @@ static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
 static int stm32_lptim_cnt_read(struct counter_device *counter,
 				struct counter_count *count, u64 *val)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	u32 cnt;
 	int ret;
 
@@ -158,7 +158,7 @@ static int stm32_lptim_cnt_function_read(struct counter_device *counter,
 					 struct counter_count *count,
 					 enum counter_function *function)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
 	if (!priv->quadrature_mode) {
 		*function = COUNTER_FUNCTION_INCREASE;
@@ -177,7 +177,7 @@ static int stm32_lptim_cnt_function_write(struct counter_device *counter,
 					  struct counter_count *count,
 					  enum counter_function function)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
 	if (stm32_lptim_is_enabled(priv))
 		return -EBUSY;
@@ -200,7 +200,7 @@ static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
 				       struct counter_count *count,
 				       u8 *enable)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	int ret;
 
 	ret = stm32_lptim_is_enabled(priv);
@@ -216,7 +216,7 @@ static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
 					struct counter_count *count,
 					u8 enable)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	int ret;
 
 	/* Check nobody uses the timer, or already disabled/enabled */
@@ -241,7 +241,7 @@ static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
 					struct counter_count *count,
 					u64 *ceiling)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
 	*ceiling = priv->ceiling;
 
@@ -252,7 +252,7 @@ static int stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
 					 struct counter_count *count,
 					 u64 ceiling)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
 	if (stm32_lptim_is_enabled(priv))
 		return -EBUSY;
@@ -277,7 +277,7 @@ static int stm32_lptim_cnt_action_read(struct counter_device *counter,
 				       struct counter_synapse *synapse,
 				       enum counter_synapse_action *action)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	enum counter_function function;
 	int err;
 
@@ -321,7 +321,7 @@ static int stm32_lptim_cnt_action_write(struct counter_device *counter,
 					struct counter_synapse *synapse,
 					enum counter_synapse_action action)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	enum counter_function function;
 	int err;
 
-- 
2.33.0

