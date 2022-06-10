Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302A545C16
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiFJGGj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 02:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiFJGGi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 02:06:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BAE1BF83A
        for <linux-iio@vger.kernel.org>; Thu,  9 Jun 2022 23:06:36 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25A66IVB095920;
        Fri, 10 Jun 2022 15:06:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 10 Jun 2022 15:06:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25A66In9095917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Jun 2022 15:06:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4c2df9f0-89db-cfe8-b2ac-54c991f9fa4e@I-love.SAKURA.ne.jp>
Date:   Fri, 10 Jun 2022 15:06:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] iio:light:tsl2563: avoid flush_scheduled_work() usage
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

Use local wq in order to avoid flush_scheduled_work() usage.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
using a macro") for background.

This is a blind conversion, and is only compile tested.

 drivers/iio/light/tsl2563.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 0a278eea36ca..0739fced0d34 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -75,6 +75,8 @@
 #define TSL2563_INT_LEVEL	0x10
 #define TSL2563_INT_PERSIST(n)	((n) & 0x0F)
 
+static struct workqueue_struct *tsl2563_wq;
+
 struct tsl2563_gainlevel_coeff {
 	u8 gaintime;
 	u16 min;
@@ -343,7 +345,7 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
 	chip->data1 = tsl2563_normalize_adc(adc1, chip->gainlevel->gaintime);
 
 	if (!chip->int_enabled)
-		schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
+		queue_delayed_work(tsl2563_wq, &chip->poweroff_work, 5 * HZ);
 
 	ret = 0;
 out:
@@ -660,7 +662,7 @@ static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
 						chip->intr);
 		chip->int_enabled = false;
 		/* now the interrupt is not enabled, we can go to sleep */
-		schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
+		queue_delayed_work(tsl2563_wq, &chip->poweroff_work, 5 * HZ);
 	}
 out:
 	mutex_unlock(&chip->lock);
@@ -781,7 +783,7 @@ static int tsl2563_probe(struct i2c_client *client,
 	INIT_DELAYED_WORK(&chip->poweroff_work, tsl2563_poweroff_work);
 
 	/* The interrupt cannot yet be enabled so this is fine without lock */
-	schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
+	queue_delayed_work(tsl2563_wq, &chip->poweroff_work, 5 * HZ);
 
 	err = iio_device_register(indio_dev);
 	if (err) {
@@ -808,7 +810,7 @@ static int tsl2563_remove(struct i2c_client *client)
 	chip->intr &= ~0x30;
 	i2c_smbus_write_byte_data(chip->client, TSL2563_CMD | TSL2563_REG_INT,
 				  chip->intr);
-	flush_scheduled_work();
+	flush_workqueue(tsl2563_wq);
 	tsl2563_set_power(chip, 0);
 
 	return 0;
@@ -887,7 +889,27 @@ static struct i2c_driver tsl2563_i2c_driver = {
 	.remove		= tsl2563_remove,
 	.id_table	= tsl2563_id,
 };
-module_i2c_driver(tsl2563_i2c_driver);
+
+static int __init tsl2563_init(void)
+{
+	int ret;
+
+	tsl2563_wq = alloc_workqueue("tsl2563_wq", 0, 0);
+	if (!tsl2563_wq)
+		return -ENOMEM;
+	ret = i2c_add_driver(&tsl2563_i2c_driver);
+	if (ret)
+		destroy_workqueue(tsl2563_wq);
+	return ret;
+}
+module_init(tsl2563_init);
+
+static void __exit tsl2563_exit(void)
+{
+	i2c_del_driver(&tsl2563_i2c_driver);
+	destroy_workqueue(tsl2563_wq);
+}
+module_exit(tsl2563_exit);
 
 MODULE_AUTHOR("Nokia Corporation");
 MODULE_DESCRIPTION("tsl2563 light sensor driver");
-- 
2.18.4
