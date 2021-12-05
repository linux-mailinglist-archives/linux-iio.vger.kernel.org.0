Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F58468C34
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhLERAN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhLERAN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975DC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EA11B80EC2
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2A8C341C5;
        Sun,  5 Dec 2021 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723403;
        bh=JPpbZ4ypsu3va1X6hjD2xNvGaVOonlRdQQfUqIl+IRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qK5YHtg4f7Azq5i7tA0gf79B6TfpXaVwt5IdsubMmap+Oz2tGLzOVPEsqvSMsUsgZ
         rnOX3ZwiQrSN9Oft/ilRQQiV2Vxp9GwD01ZvG5h/TP8ATUG+vVPkXLo2FyUGET6qwI
         tHW0k2Jc4t7ag4n6/hrHIOk2igYOgFk4TXKHNNgkbk72HItUis0gIuC7PXcqI0vC8E
         z58SCb1+mBeu9ZCvJ2aACqnsqQUM9x9FP9oBMGfvUAaR/0LPgiW9gLP8auOQdpwtxC
         U1PYMLoWqVtVZsXJtHrTZK1wUlmUoyiTC82k2+JyrQ4uuUul+JTyCn380Nxk1m4doQ
         vo4L1reRZOZuQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 03/12] iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
Date:   Sun,  5 Dec 2021 17:01:31 +0000
Message-Id: <20211205170140.2783914-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver never used anything in the of specific header.
It just wants the struct of_device_id from mod_devicetable.h.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/dac/dpot-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 5d1819448102..83ce9489259c 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -30,7 +30,7 @@
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-- 
2.34.1

