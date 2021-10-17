Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B983A430B9F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhJQTDe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 15:03:34 -0400
Received: from vern.gendns.com ([98.142.107.122]:56308 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhJQTDc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 15:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zTj/6fsXAw9g7jPeYVZ6H9bWVfQESY/dfzjAL3t61WY=; b=wZXglTRa4FDQGJOCB+LZi86DOm
        G0ag3kGKb0Tlm6T850EztAH9z969s6R50wvVagw3LjY1qcd3P8fnAds6qctv6cY4goS6gVrbX70xZ
        G1sVD/zl4ni503dCTu/hEyr+7Rnjn9xRKllZ1PSn8f/pAs0JbBx9HXgvJaLFDykKFPo0lIwH8Iz5q
        2jOOTiBcHYciOqluJY6qxhNZW/d41vPTanUcrmrira0iR+NiXTy+m8UpPz3dhyxFCtUaq+l2ycS6a
        f9mtFUKhjgQJ49mJOrDnKN3Lzte/km/pL0Zq0zL7uZN/EQzgY2uxoOPMym8B1ObUPlG7TiMoHuVyD
        tTUp2tFg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:32904 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mcBPM-0006KK-Mw; Sun, 17 Oct 2021 15:01:21 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] counter/counter-sysfs: use sysfs_emit everywhere
Date:   Sun, 17 Oct 2021 14:01:06 -0500
Message-Id: <20211017190106.3472645-1-david@lechnology.com>
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

In the counter subsystem, we are already using sysfs_emit(), but there
were a few places where we were still using sprintf() in *_show()
functions. For consistency and added protections, use sysfs_emit()
everywhere.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/counter/counter-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 7bf8882ff54d..8c2d7c29ea59 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -113,7 +113,7 @@ static ssize_t counter_comp_u8_show(struct device *dev,
 		/* data should already be boolean but ensure just to be safe */
 		data = !!data;
 
-	return sprintf(buf, "%u\n", (unsigned int)data);
+	return sysfs_emit(buf, "%u\n", (unsigned int)data);
 }
 
 static ssize_t counter_comp_u8_store(struct device *dev,
@@ -196,7 +196,7 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 	case COUNTER_COMP_COUNT_MODE:
 		return sysfs_emit(buf, "%s\n", counter_count_mode_str[data]);
 	default:
-		return sprintf(buf, "%u\n", (unsigned int)data);
+		return sysfs_emit(buf, "%u\n", (unsigned int)data);
 	}
 }
 
@@ -300,7 +300,7 @@ static ssize_t counter_comp_u64_show(struct device *dev,
 	if (err < 0)
 		return err;
 
-	return sprintf(buf, "%llu\n", (unsigned long long)data);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)data);
 }
 
 static ssize_t counter_comp_u64_store(struct device *dev,
@@ -539,7 +539,7 @@ static ssize_t counter_comp_id_show(struct device *dev,
 {
 	const size_t id = (size_t)to_counter_attribute(attr)->comp.priv;
 
-	return sprintf(buf, "%zu\n", id);
+	return sysfs_emit(buf, "%zu\n", id);
 }
 
 static int counter_comp_id_attr_create(struct device *const dev,
-- 
2.25.1

