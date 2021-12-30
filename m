Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE7481EB1
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbhL3RoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60280 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbhL3RoD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3A90CE1C9C
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7579FC36AE7;
        Thu, 30 Dec 2021 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886240;
        bh=7XzjijPYp/QZnwesr62fOMsWt/llJGp3aP6b+bwcq7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dz6ZGIcOy6mzz9JECyWwtgKQgI5A0ihv+LKnvmJicD6NrFInkr6vwUvPkjB2JekX9
         kpQn+x1LpCqcAbCPuNPlbxaK6cX0v30pD0jhtyJuVRol6mpzAjdsBhT79VTXdptjBI
         y12KekjHKoVh92tAkeWg44EEZNyb3UNV0lM3D80cuwV1pxnXfk22oDfQEg7InsNo+h
         EzmkfLkFrxXBRU6jJMHM5og+U852CsZmoG297/eVEvdjloLGk1F4JJIqb1zbAk15z7
         sTTOffA23J/Xq0OcI1QBfTbqnaA4p9iESW81wI0M/F3QNgv8PzzTLmT7u2QmFK9r2b
         ILeYnMLNDwihg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nikita Travkin <nikita@trvn.ru>,
        Maslov Dmitry <maslovdmitry@seeed.cc>
Subject: [PATCH 05/16] iio:light:ltr501: White space cleanup of spacing around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:00 +0000
Message-Id: <20211230174911.78291-6-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The spacing in this driver was inconsistent so make sure we have a space
after { and before } for the two id tables.
Part of aim is to avoid providing examples of this inconsistency that
get copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nikita Travkin <nikita@trvn.ru>
Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
---
 drivers/iio/light/ltr501.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 47d61ec2bb50..d1532ef5f08b 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1632,18 +1632,18 @@ static int ltr501_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
-	{"LTER0501", ltr501},
-	{"LTER0559", ltr559},
-	{"LTER0301", ltr301},
+	{ "LTER0501", ltr501 },
+	{ "LTER0559", ltr559 },
+	{ "LTER0301", ltr301 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
 
 static const struct i2c_device_id ltr501_id[] = {
-	{ "ltr501", ltr501},
-	{ "ltr559", ltr559},
-	{ "ltr301", ltr301},
-	{ "ltr303", ltr303},
+	{ "ltr501", ltr501 },
+	{ "ltr559", ltr559 },
+	{ "ltr301", ltr301 },
+	{ "ltr303", ltr303 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
-- 
2.34.1

