Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2A4AB185
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbiBFS6G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347261AbiBFS6F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:58:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B90BC043187
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:58:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B7A61225
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4750EC340F0;
        Sun,  6 Feb 2022 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173883;
        bh=YynubkBNH+nHurp+ttrnMx1Pzd86C5KNUeE0VeS0u5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K96iPzcDu9/3ezrDrZBQPTGDt3sFit52xbgw4Cmy0N3tvo+N+hYIZ2BJYbqJWuvSR
         cjaFrRsrPZMcEV/lzsF/Eh0n8nRJEogWcGruzkfqmfFZP8Z1bvAij2paRwbobiikQU
         LCDlHhW4Jzqxt3TWrdek5ndUwzGbhHk9e2oIs5m/whkEC64TafOzudmuk0djzTl6TS
         x9yg7wCTgN5vGB4wnOiBExN40AJbtL9bnsp5lQqrFgctkVqXLh3drroxFATKsI6tZ6
         i1V8dXCf2crViruEfGF8ltk0M0EhB2Oid71sR2zIWahPVoyYlnuKNFfvG04LzQ7aJu
         Tyl1T8QYp1gXA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 18/20] staging:iio:adc:ad7280a: Remove shift from cb_mask state cache.
Date:   Sun,  6 Feb 2022 19:03:26 +0000
Message-Id: <20220206190328.333093-19-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Making the local storage of the Cell Balance mask a simple
bitmap and then shifting it only at time of register write simplifies
several code paths.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index a32c32a1226a..a7e16144b013 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -88,6 +88,7 @@
 #define   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
 
 #define AD7280A_CELL_BALANCE_REG		0x14 /* D7 to D0, Read/write */
+#define  AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK		GENMASK(7, 2)
 #define AD7280A_CB1_TIMER_REG			0x15 /* D7 to D0, Read/write */
 #define  AD7280A_CB_TIMER_VAL_MSK			GENMASK(7, 3)
 #define AD7280A_CB2_TIMER_REG			0x16 /* D7 to D0, Read/write */
@@ -474,7 +475,7 @@ static ssize_t ad7280_show_balance_sw(struct iio_dev *indio_dev,
 
 	return sysfs_emit(buf, "%d\n",
 			  !!(st->cb_mask[chan->address >> 8] &
-			  (1 << ((chan->address & 0xFF) + 2))));
+			     BIT(chan->address & 0xFF)));
 }
 
 static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
@@ -496,12 +497,13 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->lock);
 	if (readin)
-		st->cb_mask[devaddr] |= 1 << (ch + 2);
+		st->cb_mask[devaddr] |= BIT(ch);
 	else
-		st->cb_mask[devaddr] &= ~(1 << (ch + 2));
+		st->cb_mask[devaddr] &= ~BIT(ch);
 
-	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG,
-			   0, st->cb_mask[devaddr]);
+	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG, 0,
+			   FIELD_PREP(AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK,
+				      st->cb_mask[devaddr]));
 	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
-- 
2.35.1

