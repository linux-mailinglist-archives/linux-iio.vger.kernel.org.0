Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F972D9158
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 01:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgLNAK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 19:10:29 -0500
Received: from vern.gendns.com ([98.142.107.122]:57140 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgLNAK3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 19:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5X4s94Fdl2oC6xR+328R3HW3pc42D0Tcrv4mtJNgo08=; b=OffSPz4X4fzdjmBlcKgtyMMwsA
        QZAoiGSK/drwS32qpcmbOAb91BIAlKuto4z8nwvpIDB5HOKbciFg65Wfu+sfvxqAjtwQ00Ape7wi9
        XVzUS4ePov5LxfFAmTxYwbetTZN+P11fkar9B8IbRe61Hf3oYZVgyBYlx7OEOeD/2tuv434yspepB
        l1l1lh2oDncTI0LRDBW/g/DjCDzrC2E9RHW4PodT0h3tctql92VEswVaZYZfpSCvFItfUyYHwGILq
        XwfkDSDqRtkYyCGgdvvbSkbuwu1OzeiWJC3xCXK86iOux3dVWuVcN7eI8Ig5f+kTl3+0aSMD4sg5k
        xDbj4lCw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:39336 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kobQw-0005rC-1J; Sun, 13 Dec 2020 19:09:46 -0500
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] counter:ti-eqep: remove floor
Date:   Sun, 13 Dec 2020 18:09:27 -0600
Message-Id: <20201214000927.1793062-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
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

The hardware doesn't support this. QPOSINIT is an initialization value
that is triggered by other things. When the counter overflows, it
always wraps around to zero.

Fixes: f213729f6796 "counter: new TI eQEP driver"
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/counter/ti-eqep.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index a60aee1a1a29..65df9ef5b5bc 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -235,36 +235,6 @@ static ssize_t ti_eqep_position_ceiling_write(struct counter_device *counter,
 	return len;
 }
 
-static ssize_t ti_eqep_position_floor_read(struct counter_device *counter,
-					   struct counter_count *count,
-					   void *ext_priv, char *buf)
-{
-	struct ti_eqep_cnt *priv = counter->priv;
-	u32 qposinit;
-
-	regmap_read(priv->regmap32, QPOSINIT, &qposinit);
-
-	return sprintf(buf, "%u\n", qposinit);
-}
-
-static ssize_t ti_eqep_position_floor_write(struct counter_device *counter,
-					    struct counter_count *count,
-					    void *ext_priv, const char *buf,
-					    size_t len)
-{
-	struct ti_eqep_cnt *priv = counter->priv;
-	int err;
-	u32 res;
-
-	err = kstrtouint(buf, 0, &res);
-	if (err < 0)
-		return err;
-
-	regmap_write(priv->regmap32, QPOSINIT, res);
-
-	return len;
-}
-
 static ssize_t ti_eqep_position_enable_read(struct counter_device *counter,
 					    struct counter_count *count,
 					    void *ext_priv, char *buf)
@@ -301,11 +271,6 @@ static struct counter_count_ext ti_eqep_position_ext[] = {
 		.read	= ti_eqep_position_ceiling_read,
 		.write	= ti_eqep_position_ceiling_write,
 	},
-	{
-		.name	= "floor",
-		.read	= ti_eqep_position_floor_read,
-		.write	= ti_eqep_position_floor_write,
-	},
 	{
 		.name	= "enable",
 		.read	= ti_eqep_position_enable_read,
-- 
2.25.1

