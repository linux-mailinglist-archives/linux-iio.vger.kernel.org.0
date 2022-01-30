Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49694A38A5
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355964AbiA3T1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36478 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355928AbiA3T04 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BFD5612F4
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83443C340EF;
        Sun, 30 Jan 2022 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570815;
        bh=CPANyxrGkGC6EXjrb+WSVBmK3jmdg7tVHJhxmA3Qgi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOEObPAug7MTLJZ+/+2nnfd2ni2v0eQB2i9/k30z5yMdg96pMSyPTSWRiKjecMfxX
         RqPuW27caflbBYUot5ElrEQFq3bkj+VINPK8T+rNHJnnI2nQs7p8m3MgGgTLrAZGMz
         dbRVNlh6FNSEXfeMSVQrIe1F/k/ebixmwJyWwBOBa0sQBd0k7tnhXLiNacGmtTQ+Q2
         HoorUPd9n9Di80v0iY92e9OvdIT17RDzbcnwfNZB/f0HCXrNJZJR/XworvBx2IA+qH
         IrsshedBVYHqws/gFVR6Mq2Bh++Ql0h1LrjfpQIA/kJh75GowbNwht1+85A6re909s
         Q2vNvZUyGTpwQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 37/50] iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:34 +0000
Message-Id: <20220130193147.279148-38-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/tmp007.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index b422371a4674..f3420d8a0e35 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -537,7 +537,6 @@ static int tmp007_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tmp007_suspend(struct device *dev)
 {
 	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
@@ -554,9 +553,8 @@ static int tmp007_resume(struct device *dev)
 	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
 			data->config | TMP007_CONFIG_CONV_EN);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
 
 static const struct of_device_id tmp007_of_match[] = {
 	{ .compatible = "ti,tmp007", },
@@ -574,7 +572,7 @@ static struct i2c_driver tmp007_driver = {
 	.driver = {
 		.name	= "tmp007",
 		.of_match_table = tmp007_of_match,
-		.pm	= &tmp007_pm_ops,
+		.pm	= pm_sleep_ptr(&tmp007_pm_ops),
 	},
 	.probe		= tmp007_probe,
 	.id_table	= tmp007_id,
-- 
2.35.1

