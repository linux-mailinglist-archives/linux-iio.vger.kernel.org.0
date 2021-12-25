Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C890E47F3BE
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhLYQLR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhLYQLP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6ECC061401
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dY-0008DL-Bq; Sat, 25 Dec 2021 17:11:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dS-006agv-1H; Sat, 25 Dec 2021 17:11:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dQ-0007fC-Qe; Sat, 25 Dec 2021 17:11:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 06/23] counter: interrupt-cnt: Convert to counter_priv() wrapper
Date:   Sat, 25 Dec 2021 17:10:39 +0100
Message-Id: <20211225161056.682797-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=UvwkBYGga9JlM2GrCZHQufITek7q8mZMRp/+AZAdT4Q=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=56An2X6rtAsiBaEov/PPWPUqFKFmMen+S5ZlWV2LPYw=; g=01fd9e214cb17a28c3343b0247151e3c2d035f98
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQj4ACgkQwfwUeK3K7AlfqAf+OmS W+WahbQgBePOyI65iUr45Ykall7nIp4dbIbGFFn8J7TaaSLuC1wmEsu4PWQ2vwtiSbG5qyBLNm+Zl SF6AxFSvfEp3Bt015+rU4Q8JKoD27Och5I1dYimPT9ICZ5X4ZIoxy/dZGleWHdL+RHqOOH112yTIO +EGzRgzrSE8oHmxtd2kLoJ3Ru5bk4Kky3Pa54CD8+dJxeg6luZReDqniItqDMkwpV0zcAOGyW89mV GOOcupZPRnkUKxxpwf9G4HdyMwt7ZYLWECk+1apU4AnWwVaj0Am2KQHR7ZlgtlTxp1DCSPMBTgrbT RRSJj+Y9J1JoqaSF+gKB+CkoGEQlfgQ==
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
 drivers/counter/interrupt-cnt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 8514a87fcbee..4bf706ef46e2 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -37,7 +37,7 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
 static int interrupt_cnt_enable_read(struct counter_device *counter,
 				     struct counter_count *count, u8 *enable)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	*enable = priv->enabled;
 
@@ -47,7 +47,7 @@ static int interrupt_cnt_enable_read(struct counter_device *counter,
 static int interrupt_cnt_enable_write(struct counter_device *counter,
 				      struct counter_count *count, u8 enable)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	if (priv->enabled == enable)
 		return 0;
@@ -85,7 +85,7 @@ static int interrupt_cnt_action_read(struct counter_device *counter,
 static int interrupt_cnt_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	*val = atomic_read(&priv->count);
 
@@ -95,7 +95,7 @@ static int interrupt_cnt_read(struct counter_device *counter,
 static int interrupt_cnt_write(struct counter_device *counter,
 			       struct counter_count *count, const u64 val)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	if (val != (typeof(priv->count.counter))val)
 		return -ERANGE;
@@ -122,7 +122,7 @@ static int interrupt_cnt_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
 				     enum counter_signal_level *level)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 	int ret;
 
 	if (!priv->gpio)
-- 
2.33.0

