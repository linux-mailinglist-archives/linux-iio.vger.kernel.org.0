Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEEB482B44
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiABMwh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMwh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDFC061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:52:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C982B80D62
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AF7C36AEF;
        Sun,  2 Jan 2022 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127954;
        bh=iNnu+j6fhP+XT63LueJNlA6oGTuAnsesnFdh75UX5Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffparIASoEdv88jRU2EsxzPgGcE2NW5Yinao99T7cqsg407ZT5gjcFyukF7L2qrPb
         gJTxJdWflBCb1/8BJN2KvZryceOMlZ2ykZIYhnQlj0XbkSmxaSSjpSV3g4U+nTnH97
         Gd58SxdujCELwTUVWrIH50TLrQV+Vx5suAkVY95vQztKsOyJ97v9/HqiDlZ/X1ZIzN
         JIkbOLzbWWhCaTUVh+64Y2hv73FaOKs0DQJsaGcpbranhlQgtjbCcsZM45xEj7Y4YB
         b1KMJO0dGbyb/DO6j4BbeGCTTwOCBbk05FiFCMJOEtHaOGo76C1/NAB6onDDCpTVe+
         P6NZUAntAjAEQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 37/51] iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:03 +0000
Message-Id: <20220102125617.1259804-38-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102125617.1259804-1-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards. Also use SIMPLE_DEV_PM_OPS instead
of open-coding the equivalent.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/mmc35240.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 65f3d1ed0d59..97af02dc6245 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -521,7 +521,6 @@ static int mmc35240_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mmc35240_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -548,11 +547,8 @@ static int mmc35240_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops mmc35240_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
-};
+DEFINE_SIMPLE_DEV_PM_OPS(mmc35240_pm_ops, mmc35240_suspend, mmc35240_resume);
 
 static const struct of_device_id mmc35240_of_match[] = {
 	{ .compatible = "memsic,mmc35240", },
@@ -576,7 +572,7 @@ static struct i2c_driver mmc35240_driver = {
 	.driver = {
 		.name = MMC35240_DRV_NAME,
 		.of_match_table = mmc35240_of_match,
-		.pm = &mmc35240_pm_ops,
+		.pm = pm_sleep_ptr(&mmc35240_pm_ops),
 		.acpi_match_table = ACPI_PTR(mmc35240_acpi_match),
 	},
 	.probe		= mmc35240_probe,
-- 
2.34.1

