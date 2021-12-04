Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D890468669
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhLDRLE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355578AbhLDRLD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F89CC0613F8
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 09:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4C9560ECE
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2415C341C0;
        Sat,  4 Dec 2021 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637657;
        bh=IqNCfg93SZoTLLvKdKhxPUT4Z7BsH3ioNYKX7qCsqM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sl7387T6eQN5QEWkfgdmz5nGGD+ns4N9acq7fzS21hKujgMyimBpI9l/aG/HS86Fd
         DNOZlISABCLGT1Q4EC9rhrhLi1gNEhMz66K3IA3CC48z7RNloPJNZXiBUstrxXDGS8
         OrkcwTxzfg9Z+l208HBZbkoYvEit1SS6yBXlyEUScHGk6nVjl4KRgGRlhoicBMr89L
         gpZUVbOe7jqHYxDZD5rkThH3YEMZQKDRLeALqWP55aa8uyY69RSieBFag4WnKb/ydD
         e0d/v102huRFdkHBQHGBSwUP/IDhUnQIOEbNwP/3fDdbUxL/UV/LxT/CBhBWGw2Tqf
         9h3FtzuNSDt1g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Gomez <dagmcr@gmail.com>
Subject: [PATCH v2 02/12] iio:dac:ad5758: Drop unused of specific headers.
Date:   Sat,  4 Dec 2021 17:12:27 +0000
Message-Id: <20211204171237.2769210-3-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These have never been used in this driver.  What is used is in
mod_devicetable.h so add that include (struct of_device_id)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/dac/ad5758.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 0572ef518101..98771e37a7b5 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -10,9 +10,8 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/property.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
 
-- 
2.34.1

