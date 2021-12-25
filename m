Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584F347F3BD
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhLYQLR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbhLYQLO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36BDC06175F
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008DS-LJ; Sat, 25 Dec 2021 17:11:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dS-006agz-Df; Sat, 25 Dec 2021 17:11:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dR-0007fS-71; Sat, 25 Dec 2021 17:11:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 08/23] counter: intel-qep: Convert to counter_priv() wrapper
Date:   Sat, 25 Dec 2021 17:10:41 +0100
Message-Id: <20211225161056.682797-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=g9BfXIkcjNw5YS2h7I7k7foNDE7mpF/qCH/1d9F0FUc=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=Ax69rXrNAqJUpt+mx9VJqrku88dhLzmNBLAaw6ZG0OY=; g=990ae56b2628066bb62ad34907d77560123f896f
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQkcACgkQwfwUeK3K7AkqYQf+Lqy sQQvuFlLUND5NPtxLJILv4B+2UXHDJxEfZf2yVjqoY1T+lLi0+NC6D8R0fGXTV3V4eKrF3EIgTuEL 0FTfzyjdwvdqX9M1U2l4hwH8hoEi9QW6/uKtXVH+QeC4wreJGe2pN2UjjSf5pNgLdxEfVsNiV6db9 vNDowv7LCobPchNbHD+i1fj63CfBj2EAMMq4eVJFDVLpgLiMPCpbQX5vTmtAT4uPteQp+pdLA0PtV etfCqd01kARSAfoZlc3EPaVPvUb5aaUQpyhDVpoVf5WA5vaC7hsAgHPyYLlD39bSuXgQvPcF/qXaw MDOApa3ZVJa8qTDg1y4NIljns1G+Y1Q==
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
 drivers/counter/intel-qep.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 0924d16de6e2..8f84a48508ac 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -109,7 +109,7 @@ static void intel_qep_init(struct intel_qep *qep)
 static int intel_qep_count_read(struct counter_device *counter,
 				struct counter_count *count, u64 *val)
 {
-	struct intel_qep *const qep = counter->priv;
+	struct intel_qep *const qep = counter_priv(counter);
 
 	pm_runtime_get_sync(qep->dev);
 	*val = intel_qep_readl(qep, INTEL_QEPCOUNT);
@@ -176,7 +176,7 @@ static struct counter_synapse intel_qep_count_synapses[] = {
 static int intel_qep_ceiling_read(struct counter_device *counter,
 				  struct counter_count *count, u64 *ceiling)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 
 	pm_runtime_get_sync(qep->dev);
 	*ceiling = intel_qep_readl(qep, INTEL_QEPMAX);
@@ -188,7 +188,7 @@ static int intel_qep_ceiling_read(struct counter_device *counter,
 static int intel_qep_ceiling_write(struct counter_device *counter,
 				   struct counter_count *count, u64 max)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	int ret = 0;
 
 	/* Intel QEP ceiling configuration only supports 32-bit values */
@@ -213,7 +213,7 @@ static int intel_qep_ceiling_write(struct counter_device *counter,
 static int intel_qep_enable_read(struct counter_device *counter,
 				 struct counter_count *count, u8 *enable)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 
 	*enable = qep->enabled;
 
@@ -223,7 +223,7 @@ static int intel_qep_enable_read(struct counter_device *counter,
 static int intel_qep_enable_write(struct counter_device *counter,
 				  struct counter_count *count, u8 val)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	bool changed;
 
@@ -256,7 +256,7 @@ static int intel_qep_spike_filter_ns_read(struct counter_device *counter,
 					  struct counter_count *count,
 					  u64 *length)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 
 	pm_runtime_get_sync(qep->dev);
@@ -277,7 +277,7 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 					   struct counter_count *count,
 					   u64 length)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	bool enable;
 	int ret = 0;
@@ -326,7 +326,7 @@ static int intel_qep_preset_enable_read(struct counter_device *counter,
 					struct counter_count *count,
 					u8 *preset_enable)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 
 	pm_runtime_get_sync(qep->dev);
@@ -341,7 +341,7 @@ static int intel_qep_preset_enable_read(struct counter_device *counter,
 static int intel_qep_preset_enable_write(struct counter_device *counter,
 					 struct counter_count *count, u8 val)
 {
-	struct intel_qep *qep = counter->priv;
+	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	int ret = 0;
 
-- 
2.33.0

