Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396665EF7F5
	for <lists+linux-iio@lfdr.de>; Thu, 29 Sep 2022 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiI2Oqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Sep 2022 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiI2Oqd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2022 10:46:33 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A531139434;
        Thu, 29 Sep 2022 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664462790;
  x=1695998790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4UggI7jdRf8BRVTsc0yMPHPWWjItDpaXHMT2RBrz0M=;
  b=M6WxSftEfnEozPIB4t+RWf7u81cDXWLsPGEzAVyX1JzQ3KtFedjMOnkJ
   LVc8Kedkx6ojxBlViM466uA3UNqGgSxRpK4OCdjeVfs40uY9qcHfCPd5R
   hz+LycfNnyBMa+dIC9YSuFCazfJnxG+B5bmErH7XMe+6awbi8qFBNBFSM
   aJkMw71GgJWUIl50ajSS1hOp6NaZPpmMK5gfEEarCzOqHxv7Y9hl09HIN
   txqft6fgjDvCg+XZKdwWgaQubFxhJfK0FKbx7UY/Hs0kK1ndbiXko+0Fq
   LFkTz8tGyYfRTaP2kfg1XT5hknMeqjinLvBxsA4d39yfkbsvjumAhNz5p
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 2/2] iio: light: vcnl4000: Incorporate iio_device with PM runtime
Date:   Thu, 29 Sep 2022 16:46:18 +0200
Message-ID: <20220929144618.1086985-3-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220929144618.1086985-1-marten.lindahl@axis.com>
References: <20220929144618.1086985-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the vcnl4000 device registers the iio_device, the iio_device
creates basic sysfs power/attribute nodes, but PM runtime is only
enabled for the vcnl4000 device and not for the child iio_device.

A result of this is that the iio_device sysfs power attributes is marked
as 'unsupported' and can not be used for control or monitoring of the
vcnl4000 device.

To fix this the iio_device should be incorporated with the vcnl4000
device by enabling runtime PM for it.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 3db4e26731bb..a904c7c99456 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1077,6 +1077,7 @@ static int vcnl4000_probe(struct i2c_client *client,
 		goto fail_poweroff;
 
 	pm_runtime_enable(&client->dev);
+	pm_runtime_sync_parent_enable(&indio_dev->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4000_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-- 
2.30.2

