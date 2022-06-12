Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA6A547A92
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jun 2022 16:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiFLOxV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 10:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiFLOxV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 10:53:21 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB69A31506
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 07:53:19 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25CEr0LX070253;
        Sun, 12 Jun 2022 23:53:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sun, 12 Jun 2022 23:53:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25CEqxaX070247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 12 Jun 2022 23:53:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3381176e-2f86-24ba-a8ba-c4ce8f416086@I-love.SAKURA.ne.jp>
Date:   Sun, 12 Jun 2022 23:52:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH v2] iio:light:tsl2563: Replace flush_scheduled_work() with
 cancel_delayed_work_sync().
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
References: <4c2df9f0-89db-cfe8-b2ac-54c991f9fa4e@I-love.SAKURA.ne.jp>
In-Reply-To: <4c2df9f0-89db-cfe8-b2ac-54c991f9fa4e@I-love.SAKURA.ne.jp>
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

Commit 9e61d901155bcd4e ("iio: light: tsl2563: Remove
flush_scheduled_work") replaced cancel_delayed_work() +
flush_scheduled_work() with cancel_delayed_work_sync() for only
tsl2563_probe() side.

Do the same thing for tsl2563_remove() side, which was added by
commit 388be4883952872b ("staging:iio: tsl2563 abi fixes and interrupt
handling").

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Use cancel_delayed_work_sync() instead of introducing a dedicated WQ.

Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
using a macro") for background.

 drivers/iio/light/tsl2563.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 0a278eea36ca..4d89ac3a5bbc 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -803,12 +803,11 @@ static int tsl2563_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	if (!chip->int_enabled)
-		cancel_delayed_work(&chip->poweroff_work);
+		cancel_delayed_work_sync(&chip->poweroff_work);
 	/* Ensure that interrupts are disabled - then flush any bottom halves */
 	chip->intr &= ~0x30;
 	i2c_smbus_write_byte_data(chip->client, TSL2563_CMD | TSL2563_REG_INT,
 				  chip->intr);
-	flush_scheduled_work();
 	tsl2563_set_power(chip, 0);
 
 	return 0;
-- 
2.18.4


