Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A4430616
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbhJQB6c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 21:58:32 -0400
Received: from vern.gendns.com ([98.142.107.122]:48338 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244855AbhJQB6b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 21:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Srfvu66+WHwBlVtlu6SrXigSIgQSK8IPw30+2MaUfYE=; b=mt6eXQvjVxBdcTLelkFVygxLIR
        DvM/2ptnnkeDf75Htb2spheR/o+x6+0CQi3gRhYmnw5J+2byVLE9YJHd2MxB+cM3Yu8Ft4dIBHt5p
        B2KRZO0pp5BMa4gPoHwafmr64c4j+X/hO05QB0ZA5PxQEFfxsYGsO9Vzm0sa3HPTn40iOrsAuWl4l
        bxsKKTOmsvNv9UyWaS0k2PRfEyombPyv48QOtWO1OW0XrvjORFE2Gr2AbyB6y+btfCxTEAB7VKEYG
        MA3eId24kHL5+ha3JLKnPLw7NedjF1F9EnBhYQvfYIqVL9CvZnQc37pFSGoeW7FQBCX0i1eH8Ebxr
        cD1fFiyQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41624 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mbv47-0004D2-D9; Sat, 16 Oct 2021 21:34:21 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] counter/ti-eqep: add support for latched position
Date:   Sat, 16 Oct 2021 20:33:40 -0500
Message-Id: <20211017013343.3385923-6-david@lechnology.com>
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

This adds support to the TI eQEP counter driver for a latched position.
This is a new extension that gets the counter count that was recorded
when an event was triggered. A new device-level latch_mode attribute is
added to select the trigger. Edge capture unit support will be needed
to make full use of this, but "Unit timeout" mode can already be used
to calculate high speeds.

The unit timer could also have attributes for latched_time and
latched_period that use the same trigger. However this is not a use
case at this time, so they can be added later if needed.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/counter/ti-eqep.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 1ba7f3c7cb7e..ef899655ad1d 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -405,12 +405,28 @@ static int ti_eqep_direction_read(struct counter_device *counter,
 	return 0;
 }
 
+static int ti_eqep_position_latched_count_read(struct counter_device *counter,
+					       struct counter_count *count,
+					       u64 *value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	u32 qposlat;
+
+	regmap_read(priv->regmap32, QPOSLAT, &qposlat);
+
+	*value = qposlat;
+
+	return 0;
+}
+
 static struct counter_comp ti_eqep_position_ext[] = {
 	COUNTER_COMP_CEILING(ti_eqep_position_ceiling_read,
 			     ti_eqep_position_ceiling_write),
 	COUNTER_COMP_ENABLE(ti_eqep_position_enable_read,
 			    ti_eqep_position_enable_write),
 	COUNTER_COMP_DIRECTION(ti_eqep_direction_read),
+	COUNTER_COMP_COUNT_U64("latched_count",
+			       ti_eqep_position_latched_count_read, NULL),
 };
 
 static struct counter_signal ti_eqep_signals[] = {
@@ -463,6 +479,38 @@ static struct counter_count ti_eqep_counts[] = {
 	},
 };
 
+static int ti_eqep_latch_mode_read(struct counter_device *counter,
+					    u32 *value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	u32 qepctl;
+
+	regmap_read(priv->regmap16, QEPCTL, &qepctl);
+	*value = !!(qepctl & QEPCTL_QCLM);
+
+	return 0;
+}
+
+static int ti_eqep_latch_mode_write(struct counter_device *counter,
+					     u32 value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+
+	if (value)
+		regmap_set_bits(priv->regmap16, QEPCTL, QEPCTL_QCLM);
+	else
+		regmap_clear_bits(priv->regmap16, QEPCTL, QEPCTL_QCLM);
+
+	return 0;
+}
+
+static const char *const ti_eqep_latch_mode_names[] = {
+	"Read count",
+	"Unit timeout",
+};
+
+static DEFINE_COUNTER_ENUM(ti_eqep_latch_modes, ti_eqep_latch_mode_names);
+
 static int ti_eqep_unit_timer_time_read(struct counter_device *counter,
 				       u64 *value)
 {
@@ -553,6 +601,8 @@ static int ti_eqep_unit_timer_enable_write(struct counter_device *counter,
 }
 
 static struct counter_comp ti_eqep_device_ext[] = {
+	COUNTER_COMP_DEVICE_ENUM("latch_mode", ti_eqep_latch_mode_read,
+				ti_eqep_latch_mode_write, ti_eqep_latch_modes),
 	COUNTER_COMP_DEVICE_U64("unit_timer_time", ti_eqep_unit_timer_time_read,
 				ti_eqep_unit_timer_time_write),
 	COUNTER_COMP_DEVICE_U64("unit_timer_period",
-- 
2.25.1

