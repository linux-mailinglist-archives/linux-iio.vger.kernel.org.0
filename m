Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19099540DEF
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jun 2022 20:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiFGSvf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jun 2022 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354507AbiFGSrG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2022 14:47:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD1B7A804;
        Tue,  7 Jun 2022 11:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D810B82182;
        Tue,  7 Jun 2022 18:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71116C3411C;
        Tue,  7 Jun 2022 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654624896;
        bh=EZK/LpgtcWkuxU1xfFoepZT73wWITzW3Yx7sqm7t7Ow=;
        h=From:To:Cc:Subject:Date:From;
        b=MxHA9wSA87QpFeamJxBG9+7vMfmbmhauYJXIkPQSUwDQUnKcELtwaYPLJ54wukbSj
         0j/MUFXthfLXCZKqCkjuN5WfDk4awywJ/uv02hTL7+kW5uquSke8t9CAwJrRhZu96E
         OjFLlifczyGX8DsTuxrAwvxM+d6UEJ1/8XfNE7mvgQs0Yt9MFKYXUjRbtID7/MY5ag
         LRVZtiY5khT8AdX1SD8oNcQr6TiKnjRCi5i6FDB4EuyzvpUpx4NimgFKpSfLAGaN9U
         MG469asbP5ZZrNS35RXxjdS7EDlqHM9AibFJAh7E89wBrT9dQr+uuvoT4lBcS8LJjo
         dVxxyc5UhgsOQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiaoke Wang <xkernel.wang@foxmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/27] iio: dummy: iio_simple_dummy: check the return value of kstrdup()
Date:   Tue,  7 Jun 2022 14:01:05 -0400
Message-Id: <20220607180133.481701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

[ Upstream commit ba93642188a6fed754bf7447f638bc410e05a929 ]

kstrdup() is also a memory allocation-related function, it returns NULL
when some memory errors happen. So it is better to check the return
value of it so to catch the memory error in time. Besides, there should
have a kfree() to clear up the allocation if we get a failure later in
this function to prevent memory leak.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Link: https://lore.kernel.org/r/tencent_C920CFCC33B9CC1C63141FE1334A39FF8508@qq.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dummy/iio_simple_dummy.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 62052479c349..f970b4388dda 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -571,10 +571,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	struct iio_sw_device *swd;
 
 	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
-	if (!swd) {
-		ret = -ENOMEM;
-		goto error_kzalloc;
-	}
+	if (!swd)
+		return ERR_PTR(-ENOMEM);
+
 	/*
 	 * Allocate an IIO device.
 	 *
@@ -586,7 +585,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	indio_dev = iio_device_alloc(sizeof(*st));
 	if (!indio_dev) {
 		ret = -ENOMEM;
-		goto error_ret;
+		goto error_free_swd;
 	}
 
 	st = iio_priv(indio_dev);
@@ -617,6 +616,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 *    indio_dev->name = spi_get_device_id(spi)->name;
 	 */
 	indio_dev->name = kstrdup(name, GFP_KERNEL);
+	if (!indio_dev->name) {
+		ret = -ENOMEM;
+		goto error_free_device;
+	}
 
 	/* Provide description of available channels */
 	indio_dev->channels = iio_dummy_channels;
@@ -633,7 +636,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 
 	ret = iio_simple_dummy_events_register(indio_dev);
 	if (ret < 0)
-		goto error_free_device;
+		goto error_free_name;
 
 	ret = iio_simple_dummy_configure_buffer(indio_dev);
 	if (ret < 0)
@@ -650,11 +653,12 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	iio_simple_dummy_unconfigure_buffer(indio_dev);
 error_unregister_events:
 	iio_simple_dummy_events_unregister(indio_dev);
+error_free_name:
+	kfree(indio_dev->name);
 error_free_device:
 	iio_device_free(indio_dev);
-error_ret:
+error_free_swd:
 	kfree(swd);
-error_kzalloc:
 	return ERR_PTR(ret);
 }
 
-- 
2.35.1

