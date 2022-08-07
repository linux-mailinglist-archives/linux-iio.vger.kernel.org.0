Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9758BC97
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiHGSx7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiHGSx6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5663DB
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5278960FF8
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B07C433C1;
        Sun,  7 Aug 2022 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659898436;
        bh=dT3lR4gKdcfXboqILHTfqbspq7DQF37WU1geGrNSG2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2QaFhKyJVg7XB9e83yQBwc7rK7souDG8ieWDIpSLR+uUgZ2vrL9tDVPljAgaRI7/
         PMZgVUpaAeGvKm90olPUXHfRkNjj37P8eeWkqIi8u7yfFTeydJSbQ4FkWbanWbzjiG
         XI6s7T6Wm8hK/i+fMVg9FJdEly9b65dmwAW8Sle82bEQoSk6WvsCs8GH8Tngp2MPUM
         XojIMO5xxcCFqgCmWnOhph/ZQgL8Grk+0uVS28fZa/304yPEZACVm1KKlmmdYhuHFG
         kCzOpOBzGqHS6bHQOliWukCZMAJ4Xc9CP1W8zZS0nKgZmLO13f8etSok0rs6e844F6
         sVlHAYdFWH89g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio: pressure: icp10100: Switch from UNIVERSAL to DEFINE_RUNTIME_DEV_PM_OPS().
Date:   Sun,  7 Aug 2022 20:04:13 +0100
Message-Id: <20220807190414.1039028-2-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807190414.1039028-1-jic23@kernel.org>
References: <20220807190414.1039028-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The suspend and resume callbacks in this driver appear to be safe
to call repeatedly, but why do so when we can use the
DEFINE_RUNTIME_DEV_PM_OPS() macro to supply callbacks that check if
we are already runtime suspended before doing unnecessary work.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/pressure/icp10100.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index af4621eaa6b5..b62f28585db5 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -595,7 +595,7 @@ static int icp10100_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-static int __maybe_unused icp10100_suspend(struct device *dev)
+static int icp10100_suspend(struct device *dev)
 {
 	struct icp10100_state *st = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -607,7 +607,7 @@ static int __maybe_unused icp10100_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused icp10100_resume(struct device *dev)
+static int icp10100_resume(struct device *dev)
 {
 	struct icp10100_state *st = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -626,8 +626,8 @@ static int __maybe_unused icp10100_resume(struct device *dev)
 	return ret;
 }
 
-static UNIVERSAL_DEV_PM_OPS(icp10100_pm, icp10100_suspend, icp10100_resume,
-			    NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(icp10100_pm, icp10100_suspend, icp10100_resume,
+				 NULL);
 
 static const struct of_device_id icp10100_of_match[] = {
 	{
@@ -646,7 +646,7 @@ MODULE_DEVICE_TABLE(i2c, icp10100_id);
 static struct i2c_driver icp10100_driver = {
 	.driver = {
 		.name = "icp10100",
-		.pm = &icp10100_pm,
+		.pm = pm_ptr(&icp10100_pm),
 		.of_match_table = icp10100_of_match,
 	},
 	.probe = icp10100_probe,
-- 
2.37.1

