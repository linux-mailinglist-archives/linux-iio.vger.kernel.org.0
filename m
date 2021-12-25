Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA247F3BF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhLYQLR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhLYQLQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121EC061757
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dY-0008DO-Bp; Sat, 25 Dec 2021 17:11:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dS-006agx-6g; Sat, 25 Dec 2021 17:11:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dQ-0007fI-W4; Sat, 25 Dec 2021 17:11:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 07/23] counter: microchip-tcb-capture: Convert to counter_priv() wrapper
Date:   Sat, 25 Dec 2021 17:10:40 +0100
Message-Id: <20211225161056.682797-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Hp2T2iFLn7CFN8KF5qhl8Yel9BpU8tmTjZCiPEA8/Ww=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=BYcvZ0zO3MM6N3oWt5xWrZtJqTSlsGv5VeTpFmQXUpI=; g=1eb51e809fab672de15f82de80b728ef59b6bca7
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQkMACgkQwfwUeK3K7AlAawf9Flr LP8LzkmKT+q1E3UtUSBPeOPcD5+v//ye8zhkr4NEIp/21T1ZL+cJgVpLcKHOOHxVYBAVcVhf3neQF LAHEFje12/fTCedHrte0mXiyT28BF3641/J9qQKEei+BYrplpu37oxBQYMcC94KjyIQi/bfv96+U0 DTp5iy233GMLvMJkqvXreAMpvdIVyHYuZMTKPlccEaHrdchF2WP3DJEEYVIPFm+BNsNopuuSygpQ1 GuBeNcBmCY+uFAaFj0ED2KpMcJCGkm9hswUSHoS/dEbygqtWhtF4x2nuPgWjk8GmSJRZ8XiDjUs/2 6W1142pmEahMSsONvgboGSqBdQhUClQ==
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
 drivers/counter/microchip-tcb-capture.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index bb69f2e0ba93..1b56b7444668 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -72,7 +72,7 @@ static int mchp_tc_count_function_read(struct counter_device *counter,
 				       struct counter_count *count,
 				       enum counter_function *function)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 
 	if (priv->qdec_mode)
 		*function = COUNTER_FUNCTION_QUADRATURE_X4;
@@ -86,7 +86,7 @@ static int mchp_tc_count_function_write(struct counter_device *counter,
 					struct counter_count *count,
 					enum counter_function function)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 bmr, cmr;
 
 	regmap_read(priv->regmap, ATMEL_TC_BMR, &bmr);
@@ -148,7 +148,7 @@ static int mchp_tc_count_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
 				     enum counter_signal_level *lvl)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	bool sigstatus;
 	u32 sr;
 
@@ -169,7 +169,7 @@ static int mchp_tc_count_action_read(struct counter_device *counter,
 				     struct counter_synapse *synapse,
 				     enum counter_synapse_action *action)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 cmr;
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
@@ -197,7 +197,7 @@ static int mchp_tc_count_action_write(struct counter_device *counter,
 				      struct counter_synapse *synapse,
 				      enum counter_synapse_action action)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 edge = ATMEL_TC_ETRGEDG_NONE;
 
 	/* QDEC mode is rising edge only */
@@ -230,7 +230,7 @@ static int mchp_tc_count_action_write(struct counter_device *counter,
 static int mchp_tc_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CV), &cnt);
-- 
2.33.0

