Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8113EC6CA
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 05:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhHODCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 23:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHODCw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Aug 2021 23:02:52 -0400
X-Greylist: delayed 1841 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Aug 2021 20:02:22 PDT
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEA1C061764;
        Sat, 14 Aug 2021 20:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o6zS1SnTsY8NxtD8X4Qurgu+HNtIJy+wL0A4Qwnfq6M=; b=jCjeo0/KS6VBY8f/cIpGZFXSB1
        Lp+S9sLL6LtLQUDT3ZdTtRCgQg4t+JFmpNv+kjNibBdYIfClN4WldO/256iyqkAeLQjccqnm1LD98
        F54rj5IdFYA2UsVGXLCPBgnRyzSzGJjsJly8l6jJ+57ouRCQ0kcsnqFKV6ER/NCIuqIw=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1mF5vs-0003RC-Oo; Sat, 14 Aug 2021 19:31:28 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     daniel watson <ozzloy@challenge-bot.com>
Subject: [PATCH] staging:iio:ade7854 surround complex defines in parentheses
Date:   Sat, 14 Aug 2021 19:31:15 -0700
Message-Id: <20210815023115.13016-1-ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Error found by checkpatch.pl

Signed-off-by: daniel watson <ozzloy@challenge-bot.com>
---
 drivers/staging/iio/meter/ade7854.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index a51e6e3183d38..afb13e21002e1 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -139,9 +139,9 @@
 #define ADE7854_MAX_RX    7
 #define ADE7854_STARTUP_DELAY 1000
 
-#define ADE7854_SPI_SLOW	(u32)(300 * 1000)
-#define ADE7854_SPI_BURST	(u32)(1000 * 1000)
-#define ADE7854_SPI_FAST	(u32)(2000 * 1000)
+#define ADE7854_SPI_SLOW	((u32)(300 * 1000))
+#define ADE7854_SPI_BURST	((u32)(1000 * 1000))
+#define ADE7854_SPI_FAST	((u32)(2000 * 1000))
 
 /**
  * struct ade7854_state - device instance specific data
-- 
2.30.2

