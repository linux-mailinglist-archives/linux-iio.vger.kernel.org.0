Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7270E290C7F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Oct 2020 21:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390764AbgJPT6u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 15:58:50 -0400
Received: from vern.gendns.com ([98.142.107.122]:46460 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390511AbgJPT6u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Oct 2020 15:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=di+n0UWMmhYQ1EkhV3MafIP4eU1fX02bVtJVBFfW51c=; b=gYIVmHiA7/9W5L+MCg8VBUwgVC
        2myvnQUWk9Bm0Wa4ivSHIGne+sSSw8ei7gFO5eWn5dnH+ejh/aBm5KEgty7QQau8QMbrIosHQdmt9
        9JV3IgbYJa46nBcqLyLa5HWl2Vqqt8Au1DN6p6HBZ0JWY7bJAfVJvRaTwpEHbZX71aW/qMjWIQ5AQ
        GlNi40khjZQjzOCnAaejwgftHIOOauaVEhodLvMC8T5Vjwurl9a8edKagPfV3HmRIjjJjp0NMdGeb
        x6I9cLE7KgASNY/hP0VnWtIyKo446Qxuh2P8ikxkzy7qM/HN3c0SL/aM0kZDgdVGtuCBdicswKCvC
        ndoOfHkg==;
Received: from [2600:1700:4830:165f::19e] (port=38858 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kTVsF-0003iX-Oi; Fri, 16 Oct 2020 15:58:48 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] counter/ti-eqep: Fix regmap max_register
Date:   Fri, 16 Oct 2020 14:58:37 -0500
Message-Id: <20201016195838.536791-1-david@lechnology.com>
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

The values given were the offset of the register after the last
register instead of the actual last register in each range. Fix
by using the correct last register of each range.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/counter/ti-eqep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index fe2c6bb22133..e60aec225541 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -798,7 +798,7 @@ static const struct regmap_config ti_eqep_regmap32_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.max_register = 0x24,
+	.max_register = QUPRD,
 };
 
 static const struct regmap_config ti_eqep_regmap16_config = {
@@ -806,7 +806,7 @@ static const struct regmap_config ti_eqep_regmap16_config = {
 	.reg_bits = 16,
 	.val_bits = 16,
 	.reg_stride = 2,
-	.max_register = 0x1e,
+	.max_register = QCPRDLAT,
 };
 
 static int ti_eqep_probe(struct platform_device *pdev)
-- 
2.25.1

