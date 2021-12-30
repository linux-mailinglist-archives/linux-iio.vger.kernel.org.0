Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B60E481EB3
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbhL3RoG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhL3RoG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9773C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 09:44:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F9B6173B
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F978C36AE7;
        Thu, 30 Dec 2021 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886245;
        bh=2whoAEVxggZmzEb9eG30jHAk0sR4RAHC9ct/HRxERmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEPjE3wkXEPBjJkv8Q7u9mIZNBmR1pS5xD1A+BVlB/UhdGHd1NYvFIZ3Zh6ganvfS
         HDiLQzB7mG57+4hsI45l64mpuQcfMjoF+E0RqqhdTvkIwnceK01Ri2e355MKkjux00
         1zFetygnYiuiJDCkXRCWmyLT2M9uwAg7rIDtc81ABrgc9yTChZoVwZ8kXjV5FCGebZ
         yiueHfpI/q41b3A1I1sceb1ZTjHtR4dyHbumjxmEvnlgP9WKIDfI50amR1Bw2VEfnt
         /ZPlRSPDI9FUeBFiHoSsPXCfUbIDXu1PGV/mGI6fivB1ES1F0jLXeDwXpeZ848KECq
         sVqQk7A3X3+xg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/16] iio:proximity:rfd77402: White space cleanup of spacing around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:02 +0000
Message-Id: <20211230174911.78291-8-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The spacing in this driver was inconsistent with a space after the {
but not before the }.  Tidy this up to avoid providing a bad example
to copy into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/rfd77402.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 8c06d02139b6..0ae91963b570 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -310,7 +310,7 @@ static int rfd77402_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend, rfd77402_resume);
 
 static const struct i2c_device_id rfd77402_id[] = {
-	{ "rfd77402", 0},
+	{ "rfd77402", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rfd77402_id);
-- 
2.34.1

