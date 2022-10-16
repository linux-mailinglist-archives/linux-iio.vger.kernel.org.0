Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2688260020F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJPRK1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJPRKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 13:10:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBF3121F
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 10:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94451B80D44
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 17:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919E4C433D7;
        Sun, 16 Oct 2022 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665940175;
        bh=OLtfYai7gFMwNSnBiWGLmqeLgGk5N+D5CRtvVtWILBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6IPmDO8e0Clr+DCQ0WwLJZgvoegv3AWibf9KiLSc5JT5Rf7PeWzKHY6/NKFNUWZC
         QCbLz8Ip5X1sI9uT2JJtm1rIyItWndpN/anepyKfCtzbVdnCev2War4jIUIaFUPZnw
         7k0vPkXFuesrMQJcxconqPuGRQxR6ruB6Q/67hHhsByNQsPcRVlS8O1oj01fdI2dOm
         Zpv1HdEwTFxR7Ckaw6D32EdINnI1liZYhDg9WP9C4bMGNV+MPQJrDPc5UF21kS4sEu
         fAdw95zBy3BmN7rX48+sHMX80mR9aRcQOmz3O/uwhGuGCf8ZE9KSkkHe+GyJyNnGpB
         CHaWo6V3UbbKA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/5] iio: adc: cc10001: Switch remaining IIO calls in probe to devm_ forms.
Date:   Sun, 16 Oct 2022 18:09:50 +0100
Message-Id: <20221016170950.387751-6-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221016170950.387751-1-jic23@kernel.org>
References: <20221016170950.387751-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As everything else is now handled by devm managed releases the
triggered buffer setup and IIO device registration can also be
moved over to their devm forms allowing dropping of remove().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/cc10001_adc.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index b0daaec7ff16..ab71004ea8f1 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -390,33 +390,12 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 
 	mutex_init(&adc_dev->lock);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &cc10001_adc_trigger_h, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      &cc10001_adc_trigger_h, NULL);
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto err_cleanup_buffer;
-
-	platform_set_drvdata(pdev, indio_dev);
-
-	return 0;
-
-err_cleanup_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
-}
-
-static int cc10001_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id cc10001_adc_dt_ids[] = {
@@ -431,7 +410,6 @@ static struct platform_driver cc10001_adc_driver = {
 		.of_match_table = cc10001_adc_dt_ids,
 	},
 	.probe	= cc10001_adc_probe,
-	.remove	= cc10001_adc_remove,
 };
 module_platform_driver(cc10001_adc_driver);
 
-- 
2.37.2

