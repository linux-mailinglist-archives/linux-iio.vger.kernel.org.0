Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4B460952
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352615AbhK1T1J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:27:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58368 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357631AbhK1TZJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:25:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE4ECB80D2B
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E991C53FC1;
        Sun, 28 Nov 2021 19:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127310;
        bh=d8pMIP0ALW68m60IvtWGic1c6QVE2F82TtJyPirEqeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMuBEOxfAHgG9mvl4mneoNh5/o3YF//1vW7xxlnCp9sanvIK32QGzF9oi7yLsSS+R
         E5jjOwKqfNKzYJI53Raf9yoN6l65eQnITtrjggzaeJ29A0PTMYV5OYayczhN1vqf4Q
         4QGr5hpFmlHDI1veB9uoqsPDnlsiUjP4DPbqynfHPaHeusL4dF4B5D9u9lUNryDp8R
         ieQ/ddyxH61xC4aBw2fgH2OB83X/5cCGGMLiwO0Ym5Cag9tBjXrEzKAMWKvvpMMjbk
         K/biYpzJwenj5SAcRMnFDUgI1gDYLZ6IGQeWMhQk993MqJSe+HhIpP2r0XI+LZ+kLy
         YVXokxZXv8TUw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/12] iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
Date:   Sun, 28 Nov 2021 19:26:27 +0000
Message-Id: <20211128192635.2724359-5-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver never used anything from the of specific headers.
mod_devicetable.h provides the struct of_device_id definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/lpc18xx_dac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index 5502e4f62f0d..60467c6f2c6e 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -16,9 +16,8 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-- 
2.34.1

