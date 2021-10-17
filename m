Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A479443060E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 03:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhJQB6P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 21:58:15 -0400
Received: from vern.gendns.com ([98.142.107.122]:48320 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244822AbhJQB6N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 21:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/zJFA1/ApbUButziAVTyPfPd0dIklGtFb9nwExj0Sds=; b=tFYjUzQJAir5dUw9j3jTiHXWl9
        xRrxkuOAos2Ayw0nPlXvCiVAzFoEwZUpeJBXbO0a+7B8b7zbKxIfmGd5yf0GU4qVnmrWFw4Oup2x8
        xt1dg7sMdMpSAunJRpom3292ujLo78cPbDd4fxeqd+UZEvZprxVwpKjn1T24ZYLXd0GmgCUIBGlf/
        d//SelhKaoYSR8AnFBYV5GBw1PZqkazm8VtwFpL88FbD0lm86brob0Qp1H8bHRFQ9YGipRiz9WGpU
        rRwnfexudaCbI0m+Zl2Es7toTHdQGHitHOzzpsI8bqHVTKIpre1a0ZO+8/VYTdifH+P2NAyCMTjl1
        fNXvIGIw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41624 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mbv45-0004D2-5F; Sat, 16 Oct 2021 21:34:19 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] counter/ti-eqep: add support for direction
Date:   Sat, 16 Oct 2021 20:33:37 -0500
Message-Id: <20211017013343.3385923-3-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211017013343.3385923-1-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for direction to the TI eQEP counter driver. It adds
both a direction attribute to sysfs and a direction change event to
the chrdev. The direction change event type is new public API.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/counter/ti-eqep.c    | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/counter.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index b7c79435e127..9881e5115da6 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -106,6 +106,15 @@
 #define QCLR_PCE		BIT(1)
 #define QCLR_INT		BIT(0)
 
+#define QEPSTS_UPEVNT		BIT(7)
+#define QEPSTS_FDF		BIT(6)
+#define QEPSTS_QDF		BIT(5)
+#define QEPSTS_QDLF		BIT(4)
+#define QEPSTS_COEF		BIT(3)
+#define QEPSTS_CDEF		BIT(2)
+#define QEPSTS_FIMF		BIT(1)
+#define QEPSTS_PCEF		BIT(0)
+
 /* EQEP Inputs */
 enum {
 	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
@@ -286,6 +295,9 @@ static int ti_eqep_events_configure(struct counter_device *counter)
 		case COUNTER_EVENT_UNDERFLOW:
 			qeint |= QEINT_PCU;
 			break;
+		case COUNTER_EVENT_DIRECTION_CHANGE:
+			qeint |= QEINT_QDC;
+			break;
 		}
 	}
 
@@ -298,6 +310,7 @@ static int ti_eqep_watch_validate(struct counter_device *counter,
 	switch (watch->event) {
 	case COUNTER_EVENT_OVERFLOW:
 	case COUNTER_EVENT_UNDERFLOW:
+	case COUNTER_EVENT_DIRECTION_CHANGE:
 		return 0;
 	default:
 		return -EINVAL;
@@ -371,11 +384,27 @@ static int ti_eqep_position_enable_write(struct counter_device *counter,
 	return 0;
 }
 
+static int ti_eqep_direction_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  enum counter_count_direction *direction)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	u32 qepsts;
+
+	regmap_read(priv->regmap16, QEPSTS, &qepsts);
+
+	*direction = (qepsts & QEPSTS_QDF) ? COUNTER_COUNT_DIRECTION_FORWARD
+					   : COUNTER_COUNT_DIRECTION_BACKWARD;
+
+	return 0;
+}
+
 static struct counter_comp ti_eqep_position_ext[] = {
 	COUNTER_COMP_CEILING(ti_eqep_position_ceiling_read,
 			     ti_eqep_position_ceiling_write),
 	COUNTER_COMP_ENABLE(ti_eqep_position_enable_read,
 			    ti_eqep_position_enable_write),
+	COUNTER_COMP_DIRECTION(ti_eqep_direction_read),
 };
 
 static struct counter_signal ti_eqep_signals[] = {
@@ -442,6 +471,10 @@ static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
 	if (qflg & QFLG_PCU)
 		counter_push_event(counter, COUNTER_EVENT_UNDERFLOW, 0);
 
+	if (qflg & QFLG_QDC)
+		counter_push_event(counter, COUNTER_EVENT_DIRECTION_CHANGE, 0);
+
+
 	regmap_set_bits(priv->regmap16, QCLR, ~0);
 
 	return IRQ_HANDLED;
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index d0aa95aeff7b..36dd3b474d09 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -61,6 +61,8 @@ enum counter_event_type {
 	COUNTER_EVENT_THRESHOLD,
 	/* Index signal detected */
 	COUNTER_EVENT_INDEX,
+	/* Direction change detected */
+	COUNTER_EVENT_DIRECTION_CHANGE,
 };
 
 /**
-- 
2.25.1

