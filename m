Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4272F614A8B
	for <lists+linux-iio@lfdr.de>; Tue,  1 Nov 2022 13:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKAMWD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Nov 2022 08:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKAMWC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2022 08:22:02 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FFD15A2E
        for <linux-iio@vger.kernel.org>; Tue,  1 Nov 2022 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1667305321;
  x=1698841321;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eG6LBddHVswXEUBxrT7VWePzZ/GtYCU0hqABGFssKlU=;
  b=jELyWrSe1k8wNbAcw8GzxfnxKsbdDbUKLSxpScW6+dhsSNO3ZPp71+KR
   20JhzAOPLC48UmGE9z7PmTiGzvYJiU8WsrF7QFbzOfuuGwW0NWD0qc1SK
   mQ7dVsT6H3LT5Yhl8e7N6CCm8uNznO64XOpQ+Gybe6H9jSw515OOsHarM
   2Ipz1Ke6OuEubtJhm1Fmck3W0epbOjVZF43YCHsxhwqBOo+11HTbKscLW
   A3cFOMupvLQ/stQfyFaGRO99BesrFQ+SWcK86YCIY8yXL9XDsgKXjcxI8
   rHP5DV7/zOisa2Iih84F+Ce1SPMcREeW2Ru2FwrcLfL3piFQ+gsjFNwyd
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] iio: light: vcnl4000: Don't create sysfs PM nodes for child
Date:   Tue, 1 Nov 2022 13:21:51 +0100
Message-ID: <20221101122151.221029-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
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

PM runtime is enabled for the parent i2c device, but it is disabled for
the iio child device and remains so in this driver. But as the child
sysfs PM directory is created by default by iio_device_register =>
cdev_device_add => dpm_sysfs_add it doesn't bring any value exposing it
since it won't give any usable data for the user.

Tell dpm_sysfs to not create the PM directory for the iio device.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index f6c83ecaad8b..400dc1155559 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1072,6 +1072,7 @@ static int vcnl4000_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto fail_poweroff;
 
+	device_set_pm_not_required(&indio_dev->dev);
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto fail_poweroff;
-- 
2.30.2

