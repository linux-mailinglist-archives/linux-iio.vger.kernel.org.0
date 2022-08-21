Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23FE59B58B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Aug 2022 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiHURBD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Aug 2022 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHURBC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2022 13:01:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFCB1F631
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 10:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF877B80B94
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 17:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7990C433C1;
        Sun, 21 Aug 2022 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661101258;
        bh=xoedtaxomH/Ic5LC2QdEU/ShM1tHsIsFsgynT8/vtBM=;
        h=From:To:Cc:Subject:Date:From;
        b=g/yokzO324ATILDGXdCGkH36NUQh6YVOt/yl86K0bNK8BKtnzd8uVcYYrt2kUBHCD
         P1LDQtRAtbhs5iAVu7NAj4BMtwavgaoYIH03qeRVVPhHbQtXOTRVZzeWh4Ulhn9GTv
         5d4Q1AqVHiBRkJzgrRLkxowOxBE/9bQaj4CD3w+6jPefsSQHM+3ztWS9pBjbGaZg2o
         1i4u8HbkjlZnONRR4tyTeuCVHoRpC69jhEgPXzI6eWEXKttGwQSKTxq77AhU7xwTNA
         EEPFlGETuyL/qr8YN241DrChQddkgTRzRjGIJU0FIxBoHSqiaD5Ovjj8IwP/2d4se2
         sX4oKx9i3RY9g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] iio: consumer: Mark struct iio_channel parameter to iio_get_channel_type() const
Date:   Sun, 21 Aug 2022 17:26:24 +0100
Message-Id: <20220821162624.2208210-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This accessor is only reading data via this pointer, so make the fact
it is const explicit.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2: the content to match the description. ooops.

Used in a clean up to sound/soc/samsung/aries_wm8994 where
the struct iio_channel pointer is marked const.
---
 drivers/iio/inkern.c         | 2 +-
 include/linux/iio/consumer.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 872fd5c24147..ac47cd453d1b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -912,7 +912,7 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
 }
 EXPORT_SYMBOL_GPL(iio_read_max_channel_raw);
 
-int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
+int iio_get_channel_type(const struct iio_channel *chan, enum iio_chan_type *type)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
 	int ret = 0;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 6802596b017c..a73c67baae2a 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -335,7 +335,7 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
  *
  * returns the enum iio_chan_type of the channel
  */
-int iio_get_channel_type(struct iio_channel *channel,
+int iio_get_channel_type(const struct iio_channel *channel,
 			 enum iio_chan_type *type);
 
 /**
-- 
2.37.2

