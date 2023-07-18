Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672317581F3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jul 2023 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjGRQUc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jul 2023 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGRQUb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jul 2023 12:20:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F42D3
        for <linux-iio@vger.kernel.org>; Tue, 18 Jul 2023 09:20:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLnR4-00055z-O7; Tue, 18 Jul 2023 18:20:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLnR3-000Pdg-N5; Tue, 18 Jul 2023 18:20:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLnR3-005tZ9-2y; Tue, 18 Jul 2023 18:20:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] counter: Declare counter_priv() to be const
Date:   Tue, 18 Jul 2023 18:20:15 +0200
Message-Id: <20230718162015.3940148-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xHP/FPStphElaZx48Fd1Qj5vxQKCN/bZjBvL+zx1sdY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBktru+8K/SLNU4ZBUvyZQ2EF439rBTpl2Ere68u 1tbUAmGlTiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLa7vgAKCRCPgPtYfRL+ ThobB/42iIHY98vGYo5QW/CUqZLJiQhyYdn0h4zssxUvRXl8a8UGjnT/u57n/uSJsTTOu/aF0uv QmALrtVZc7ysA2Cnenny0FBeUehdEWsiCf64HxPRTeY0hU3ToZ6yiqwPYVKnGmbd5xhseYDGF/C GjqhQ2sM2UUmip/e44KudiPUhadr0EKv8CCkQB2Gc8Gv9XgSmDkMKtJulWC9sFdhZAYkMteLd1k DCvr5iCrnO4zPqNOXEAEErpPqqj98x8W8nCbtJvp/fHW6ZZHhxTdjI9+8/f9Zw6SDosj/pOqGyx KDIdnfijKmroP3aDghuXgMqYQtdjCc3U3WGR8IJeI2gtqzEb
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to the gcc manual functions "whose return value is not
affected by changes to the observable state of the program and that have
no observable effects on such state other than to return a value may
lend themselves to optimizations such as common subexpression
elimination. Declaring such functions with the 'const' attribute allows
GCC to avoid emitting some calls in repeated invocations of the function
with the same argument values."

counter_priv() is such a function and so can be marked with the const
function attribute.

The effect for an arm allyesconfig build according to bloat-o-meter (on
top of v6.5-rc2) is:

	add/remove: 0/1 grow/shrink: 2/14 up/down: 524/-1064 (-540)
	Function                                     old     new   delta
	rz_mtu3_count_enable_write                   632    1152    +520
	stm32_count_enable_write                     372     376      +4
	ti_eqep_action_read                          456     452      -4
	stm32_lptim_cnt_action_write                 400     392      -8
	stm32_lptim_cnt_action_read                  300     288     -12
	rz_mtu3_count_write                          296     284     -12
	rz_mtu3_count_read                           304     292     -12
	rz_mtu3_count_function_read                  212     200     -12
	rz_mtu3_count_direction_read                 268     256     -12
	rz_mtu3_action_read                          628     616     -12
	rz_mtu3_count_function_write                 328     312     -16
	ecap_cnt_suspend                             364     340     -24
	ecap_cnt_resume                              300     276     -24
	rz_mtu3_count_ceiling_write                  596     560     -36
	rz_mtu3_count_enable_read                    332     288     -44
	rz_mtu3_count_ceiling_read                   384     340     -44
	rz_mtu3_initialize_counter                   792       -    -792
	Total: Before=60715, After=60175, chg -0.89%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/counter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index b63746637de2..702e9108bbb4 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -399,7 +399,7 @@ struct counter_device {
 	struct mutex ops_exist_lock;
 };
 
-void *counter_priv(const struct counter_device *const counter);
+void *counter_priv(const struct counter_device *const counter) __attribute_const__;
 
 struct counter_device *counter_alloc(size_t sizeof_priv);
 void counter_put(struct counter_device *const counter);

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.39.2

