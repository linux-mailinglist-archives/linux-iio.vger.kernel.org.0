Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082C1547A9D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jun 2022 17:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiFLPEV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiFLPEU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 11:04:20 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E40E54192
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 08:04:18 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25CF41rI072214;
        Mon, 13 Jun 2022 00:04:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Mon, 13 Jun 2022 00:04:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25CF41v2072211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 Jun 2022 00:04:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <041b6745-f784-ff3f-9836-3f4397d35d94@I-love.SAKURA.ne.jp>
Date:   Mon, 13 Jun 2022 00:04:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] iio:light:tsl2563: Replace cancel_delayed_work() with
 cancel_delayed_work_sync().
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since cancel_delayed_work(&chip->poweroff_work) does not guarantee that
tsl2563_poweroff_work() is not running, tsl2563_set_power(chip, 0) can be
called from tsl2563_poweroff_work() after tsl2563_get_power(chip) and
tsl2563_set_power(chip, 1) are called. Use _sync version in order to make
sure that tsl2563_poweroff_work() is no longer running.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/iio/light/tsl2563.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 4d89ac3a5bbc..bbb577459fb9 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -310,7 +310,7 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
 		goto out;
 
 	if (!chip->int_enabled) {
-		cancel_delayed_work(&chip->poweroff_work);
+		cancel_delayed_work_sync(&chip->poweroff_work);
 
 		if (!tsl2563_get_power(chip)) {
 			ret = tsl2563_set_power(chip, 1);
@@ -638,7 +638,7 @@ static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
 		chip->intr &= ~0x30;
 		chip->intr |= 0x10;
 		/* ensure the chip is actually on */
-		cancel_delayed_work(&chip->poweroff_work);
+		cancel_delayed_work_sync(&chip->poweroff_work);
 		if (!tsl2563_get_power(chip)) {
 			ret = tsl2563_set_power(chip, 1);
 			if (ret)
-- 
2.18.4
